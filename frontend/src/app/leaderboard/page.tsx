'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Crown, Medal, Award } from 'lucide-react';

interface LeaderboardEntry {
  username: string;
  level: number;
  xp: number;
  streak: number;
  solved: number;
}

export default function LeaderboardPage() {
  const [entries, setEntries] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Placeholder — will fetch from /api/progress/leaderboard when backend adds it
    setLoading(false);
  }, []);

  const rankIcon = (rank: number) => {
    if (rank === 1) return <Crown className="h-5 w-5 text-warning" />;
    if (rank === 2) return <Medal className="h-5 w-5 text-muted" />;
    if (rank === 3) return <Award className="h-5 w-5 text-orange-600" />;
    return <span className="text-muted font-mono text-sm">{rank}</span>;
  };

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8 text-center">
        <div className="text-4xl mb-4 animate-pulse">🏆</div>
        <p className="text-muted">Loading leaderboard...</p>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8 max-w-3xl">
      <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }}>
        <h1 className="font-heading text-3xl mb-2">Leaderboard</h1>
        <p className="text-muted mb-8">The mightiest Java warriors in the realm.</p>

        <Card className="p-0 overflow-hidden">
          <div className="grid grid-cols-12 gap-4 px-6 py-3 border-b border-border/50 text-xs font-heading text-muted uppercase tracking-wider">
            <div className="col-span-1">Rank</div>
            <div className="col-span-4">Warrior</div>
            <div className="col-span-2 text-center">Level</div>
            <div className="col-span-3 text-right">XP</div>
            <div className="col-span-2 text-right">Streak</div>
          </div>
          {entries.length === 0 ? (
            <div className="px-6 py-12 text-center text-muted text-sm">
              <p>No warriors have registered yet.</p>
              <p className="mt-2">Be the first to claim the throne!</p>
            </div>
          ) : (
            entries.map((entry, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, x: -10 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: i * 0.05 }}
                className="grid grid-cols-12 gap-4 px-6 py-3 items-center hover:bg-secondary/30 transition-colors border-b border-border/30"
              >
                <div className="col-span-1 flex justify-center">{rankIcon(i + 1)}</div>
                <div className="col-span-4 font-body">{entry.username}</div>
                <div className="col-span-2 text-center">
                  <Badge variant="secondary" className="font-mono">Lv.{entry.level}</Badge>
                </div>
                <div className="col-span-3 text-right font-mono text-warning">{entry.xp.toLocaleString()}</div>
                <div className="col-span-2 text-right font-mono text-sm">
                  {entry.streak > 0 && `🔥 ${entry.streak}`}
                </div>
              </motion.div>
            ))
          )}
        </Card>
      </motion.div>
    </div>
  );
}