'use client';

import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Card } from '@/components/ui/card';
import { api } from '@/lib/api';
import { HINT_LAYERS } from '@/lib/constants';
import { toast } from 'sonner';
import { Lock, AlertCircle, Sparkles, Lightbulb } from 'lucide-react';

interface HintInfo {
  layer: number;
  name: string;
  icon: string;
  content: string | null;
  hpCost: number;
  unlocked: boolean;
  hintType: string;
}

interface HintState {
  staticHints: HintInfo[];
  dynamicAvailable: boolean;
  lastFailureType: string | null;
  totalHpSpentOnHints: number;
  hintsUnlockedCount: number;
  patternHints: any[];
}

export function OraclePanel({ problemSlug }: { problemSlug: string }) {
  const [hintState, setHintState] = useState<HintState | null>(null);
  const [loading, setLoading] = useState(true);
  const [dynamicHint, setDynamicHint] = useState<any>(null);
  const [analyzing, setAnalyzing] = useState(false);

  const loadHints = async () => {
    try {
      const state = await api.hints.get(problemSlug);
      setHintState(state);
      setLoading(false);
    } catch {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadHints();
  }, [problemSlug]);

  const handleUnlock = async (layer: number) => {
    try {
      await api.hints.unlock(problemSlug, layer);
      toast.success(`Hint Layer ${layer} unlocked!`);
      loadHints();
    } catch (err: any) {
      toast.error(err.body?.error || 'Failed to unlock hint');
    }
  };

  const handleDynamic = async () => {
    setAnalyzing(true);
    setDynamicHint(null);
    try {
      const hint = await api.hints.dynamic(problemSlug);
      setDynamicHint(hint);
      loadHints();
    } catch (err: any) {
      toast.error(err.body?.error || 'Failed to analyze submission');
    } finally {
      setAnalyzing(false);
    }
  };

  if (loading) {
    return (
      <div className="mt-6 rounded-xl border border-primary/20 bg-secondary/30 p-4">
        <div className="flex items-center gap-2">
          <span className="text-xl animate-pulse">🔮</span>
          <span className="text-sm text-muted">Loading hints...</span>
        </div>
      </div>
    );
  }

  return (
    <div className="mt-6 rounded-xl border border-primary/20 bg-secondary/30 p-4">
      {/* Header */}
      <div className="mb-4 flex items-center gap-2">
        <span className="text-xl">🔮</span>
        <h3 className="font-heading text-sm text-primary/80">The Oracle's Guidance</h3>
      </div>

      {/* Static hint layers */}
      <div className="space-y-2">
        {hintState?.staticHints.map((hint) => (
          <HintCard key={hint.layer} hint={hint} onUnlock={() => handleUnlock(hint.layer)} />
        ))}
      </div>

      {/* Dynamic hint section */}
      {hintState?.dynamicAvailable && (
        <div className="mt-4">
          <div className="rounded-lg border border-destructive/20 bg-destructive/5 p-3">
            <div className="flex items-center gap-2 mb-2">
              <AlertCircle className="h-4 w-4 text-destructive" />
              <span className="text-xs text-destructive">
                Last submission: {hintState.lastFailureType?.replace(/_/g, ' ')}
              </span>
            </div>
            <Button
              variant="outline"
              size="sm"
              className="w-full border-primary/30 hover:border-primary/60"
              onClick={handleDynamic}
              disabled={analyzing}
            >
              {analyzing ? (
                <><span className="h-4 w-4 mr-2 animate-spin">⚡</span> The Oracle examines your code...</>
              ) : (
                <>🔍 Analyze My Failed Submission (10 HP)</>
              )}
            </Button>

            <AnimatePresence>
              {dynamicHint && (
                <motion.div
                  initial={{ opacity: 0, y: -10 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="mt-3 rounded-md bg-background p-3 border border-primary/20"
                >
                  <p className="text-sm whitespace-pre-wrap">{dynamicHint.content}</p>
                  {dynamicHint.lineNumber && (
                    <p className="mt-2 text-xs text-muted">Likely issue at line {dynamicHint.lineNumber}</p>
                  )}
                  {dynamicHint.exceptionType && (
                    <p className="mt-2 text-xs text-muted">Exception: {dynamicHint.exceptionType}</p>
                  )}
                </motion.div>
              )}
            </AnimatePresence>
          </div>
        </div>
      )}

      {/* Pattern hints (free) */}
      {hintState?.patternHints && hintState.patternHints.length > 0 && (
        <div className="mt-4 space-y-2">
          <p className="text-xs text-muted">── Pattern Hints ──</p>
          {hintState.patternHints.map((ph: any, i: number) => (
            <div key={i} className="rounded-lg border border-success/20 bg-success/5 p-3 flex items-start gap-2">
              <Lightbulb className="h-4 w-4 text-success mt-0.5" />
              <div>
                <p className="text-xs">
                  You solved <span className="text-success">{ph.relatedProblemTitle}</span> using a similar{' '}
                  <span className="text-success">{ph.patternName}</span> pattern.
                </p>
                <p className="text-xs text-muted mt-1">This problem can be approached the same way.</p>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* HP spent summary */}
      {hintState && hintState.totalHpSpentOnHints > 0 && (
        <p className="mt-3 text-xs text-muted">
          Total HP spent on hints: {hintState.totalHpSpentOnHints}
        </p>
      )}
    </div>
  );
}

function HintCard({ hint, onUnlock }: { hint: HintInfo; onUnlock: () => void }) {
  if (!hint.unlocked) {
    return (
      <div className="rounded-lg border border-border/20 bg-background/30 p-3 opacity-60">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Lock className="h-3 w-3 text-muted" />
            <span className="text-xs font-body">Layer {hint.layer}: {hint.name}</span>
          </div>
          <Badge variant="outline" className="text-xs">{hint.hpCost} HP</Badge>
        </div>
        <Button variant="ghost" size="sm" className="mt-2 text-xs h-7" onClick={onUnlock}>
          Consult the Oracle ({hint.hpCost} HP)
        </Button>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0, height: 0 }}
      animate={{ opacity: 1, height: 'auto' }}
      className="rounded-lg border-l-2 border-amber-500/40 bg-amber-500/5 p-3"
    >
      <div className="flex items-center gap-2 mb-1">
        <span className="text-sm">{hint.icon}</span>
        <span className="text-xs font-heading text-amber-500/80">
          Layer {hint.layer}: {hint.name}
        </span>
      </div>
      <p className="text-xs text-foreground/80 whitespace-pre-wrap">{hint.content}</p>
    </motion.div>
  );
}