'use client';

import { useState, useEffect } from 'react';
import { useParams, useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Card } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { CodeEditor } from '@/components/editor/code-editor';
import { api } from '@/lib/api';
import { toast } from 'sonner';
import { Play, Send, RotateCcw, Lightbulb, Lock, AlertCircle } from 'lucide-react';

const difficultyColors: Record<string, string> = {
  EASY: 'text-success border-success/30 bg-success/5',
  MEDIUM: 'text-warning border-warning/30 bg-warning/5',
  HARD: 'text-destructive border-destructive/30 bg-destructive/5',
  BOSS: 'text-destructive border-destructive/30 bg-destructive/5',
};

export default function ProblemPage() {
  const params = useParams();
  const router = useRouter();
  const slug = params.slug as string;

  const [problem, setProblem] = useState<any>(null);
  const [code, setCode] = useState('');
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [result, setResult] = useState<any>(null);

  useEffect(() => {
    api.problems.get(slug).then((data) => {
      setProblem(data);
      setCode(data.starterCode || '');
      setLoading(false);
    }).catch(() => {
      toast.error('Failed to load problem');
      setLoading(false);
    });
  }, [slug]);

  const handleSubmit = async (runSampleOnly: boolean) => {
    setSubmitting(true);
    setResult(null);
    try {
      const res = await api.submissions.submit({
        slug,
        sourceCode: code,
        runSampleOnly,
      });
      setResult(res);
      if (res.status === 'ACCEPTED' && !runSampleOnly) {
        toast.success(`Accepted! +${res.xpGained} XP`);
        if (res.leveledUp) {
          toast.success(`Level Up! You are now Level ${res.newLevel}`);
        }
        if (res.bossDefeated) {
          toast.success('Boss Defeated! Realm conquered!');
        }
        if (res.newAchievements?.length > 0) {
          res.newAchievements.forEach((a: string) => toast.success(`Achievement: ${a}`));
        }
      } else if (res.status !== 'ACCEPTED' && !runSampleOnly) {
        toast.error(`${res.status} — HP -10`);
      }
    } catch (err: any) {
      toast.error(err.body?.error || 'Submission failed');
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex h-[calc(100vh-64px)] items-center justify-center">
        <div className="text-center">
          <div className="text-4xl mb-4 animate-pulse">⏳</div>
          <p className="text-muted">Loading problem...</p>
        </div>
      </div>
    );
  }

  if (!problem) {
    return (
      <div className="flex h-[calc(100vh-64px)] items-center justify-center">
        <div className="text-center">
          <p className="text-muted">Problem not found</p>
          <Button className="mt-4" onClick={() => router.push('/quest')}>Back to Quest</Button>
        </div>
      </div>
    );
  }

  return (
    <div className="flex h-[calc(100vh-64px)] overflow-hidden">
      {/* Left: Problem description + hints */}
      <div className="w-1/4 min-w-[300px] border-r border-border/50 overflow-y-auto p-4">
        <div className="flex items-center gap-2 mb-3">
          <Badge variant="outline" className={difficultyColors[problem.difficulty]}>
            {problem.difficulty}
          </Badge>
          <Badge variant="secondary">{problem.xpReward} XP</Badge>
          {problem.isBoss && <span className="text-lg">💀</span>}
        </div>
        <h1 className="font-heading text-xl mb-4">{problem.title}</h1>
        <div className="prose prose-invert prose-sm max-w-none">
          <div className="text-sm whitespace-pre-wrap text-foreground/90">
            {problem.description}
          </div>
        </div>

        {/* Oracle Panel placeholder */}
        <div className="mt-6 rounded-xl border border-primary/20 bg-secondary/30 p-4">
          <div className="flex items-center gap-2 mb-3">
            <span className="text-xl">🔮</span>
            <h3 className="font-heading text-sm text-primary/80">The Oracle's Guidance</h3>
          </div>
          <p className="text-xs text-muted">
            Hints will appear here after backend integration. Unlock 5 layers of help, from a gentle nudge to near-complete solution.
          </p>
        </div>
      </div>

      {/* Center: Code editor + actions */}
      <div className="flex-1 flex flex-col">
        <div className="flex-1 overflow-hidden">
          <CodeEditor value={code} onChange={setCode} />
        </div>
        <div className="border-t border-border/50 p-3 flex items-center justify-between gap-2 bg-secondary/30">
          <div className="flex gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => handleSubmit(true)}
              disabled={submitting}
            >
              <Play className="h-4 w-4 mr-1" />
              Run Sample
            </Button>
            <Button
              size="sm"
              onClick={() => handleSubmit(false)}
              disabled={submitting}
              className="animate-glow-pulse"
            >
              <Send className="h-4 w-4 mr-1" />
              {submitting ? 'Submitting...' : 'Submit'}
            </Button>
          </div>
          <Button
            variant="ghost"
            size="sm"
            onClick={() => {
              setCode(problem.starterCode || '');
              setResult(null);
            }}
          >
            <RotateCcw className="h-4 w-4 mr-1" />
            Reset
          </Button>
        </div>
      </div>

      {/* Right: Test results */}
      <div className="w-1/4 min-w-[280px] border-l border-border/50 overflow-y-auto p-4">
        <Tabs defaultValue="results">
          <TabsList className="w-full">
            <TabsTrigger value="results" className="flex-1">Results</TabsTrigger>
            <TabsTrigger value="history" className="flex-1">History</TabsTrigger>
          </TabsList>
          <TabsContent value="results" className="mt-4">
            {submitting && (
              <div className="text-center py-8">
                <div className="text-3xl mb-2 animate-spin">⚡</div>
                <p className="text-xs text-muted">Running tests...</p>
              </div>
            )}
            {!submitting && result && (
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
              >
                <div className={`p-3 rounded-lg mb-4 ${
                  result.status === 'ACCEPTED'
                    ? 'bg-success/10 border border-success/30'
                    : 'bg-destructive/10 border border-destructive/30'
                }`}>
                  <p className={`font-heading text-sm ${
                    result.status === 'ACCEPTED' ? 'text-success' : 'text-destructive'
                  }`}>
                    {result.status === 'ACCEPTED' ? '✓ Accepted' : `✗ ${result.status}`}
                  </p>
                  {result.passedCount !== undefined && (
                    <p className="text-xs text-muted mt-1">
                      {result.passedCount}/{result.totalCount} test cases passed
                    </p>
                  )}
                </div>

                {result.results?.map((tc: any, i: number) => (
                  <Card key={i} className="p-3 mb-2 text-xs">
                    <div className="flex items-center justify-between mb-1">
                      <span className="font-mono">Case {tc.caseNum}</span>
                      <span className={tc.status === 'PASS' ? 'text-success' : 'text-destructive'}>
                        {tc.status === 'PASS' ? '✓' : '✗'}
                      </span>
                    </div>
                    {tc.status !== 'PASS' && (
                      <>
                        <p className="text-muted">Expected: {tc.expectedOutput}</p>
                        <p className="text-muted">Got: {tc.actualOutput}</p>
                      </>
                    )}
                    {tc.timeMs && (
                      <p className="text-muted mt-1">{tc.timeMs}ms · {tc.memoryKb}KB</p>
                    )}
                  </Card>
                ))}

                {result.xpGained > 0 && (
                  <p className="text-center text-warning font-heading text-lg mt-4">
                    +{result.xpGained} XP
                  </p>
                )}
              </motion.div>
            )}
            {!submitting && !result && (
              <div className="text-center py-8 text-muted text-xs">
                <p>Run or submit your code to see results here.</p>
              </div>
            )}
          </TabsContent>
          <TabsContent value="history" className="mt-4">
            <div className="text-center py-8 text-muted text-xs">
              <p>Submission history will appear here.</p>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}