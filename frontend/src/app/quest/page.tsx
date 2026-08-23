'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import Link from 'next/link';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { REALMS } from '@/lib/constants';
import { api } from '@/lib/api';
import { useAuthStore } from '@/stores/auth-store';
import { Lock, CheckCircle, Circle, Skull } from 'lucide-react';

interface ProblemNode {
  id: number;
  realmId: number;
  slug: string;
  title: string;
  difficulty: string;
  xpReward: number;
  orderInRealm: number;
  isBoss: boolean;
  completed: boolean;
  unlocked: boolean;
}

export default function QuestPage() {
  const [problems, setProblems] = useState<ProblemNode[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api.problems.list().then((data) => {
      setProblems(data);
      setLoading(false);
    }).catch(() => setLoading(false));
  }, []);

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="text-center py-20">
          <div className="text-4xl mb-4 animate-pulse">🗺️</div>
          <p className="text-muted">Loading your quest map...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <h1 className="font-heading text-3xl mb-2">Your Quest Map</h1>
        <p className="text-muted mb-8">
          Conquer each realm to unlock the next. Boss problems await at the end.
        </p>
      </motion.div>

      <div className="space-y-8">
        {REALMS.map((realm, realmIndex) => {
          const realmProblems = problems.filter((p) => p.realmId === realm.id);
          if (realmProblems.length === 0) return null;

          return (
            <motion.div
              key={realm.id}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: realmIndex * 0.1 }}
            >
              <div className="flex items-center gap-3 mb-4">
                <span className="text-3xl">{realm.icon}</span>
                <div>
                  <h2 className="font-heading text-xl" style={{ color: realm.color }}>
                    {realm.name}
                  </h2>
                  <p className="text-xs text-muted">{realm.desc}</p>
                </div>
              </div>

              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 lg:grid-cols-10 gap-3">
                {realmProblems.map((problem, pIdx) => {
                  const status = problem.completed
                    ? 'completed'
                    : problem.unlocked
                    ? 'unlocked'
                    : 'locked';

                  return (
                    <Link
                      key={problem.id}
                      href={problem.unlocked ? `/quest/${problem.slug}` : '#'}
                      className="block"
                    >
                      <Card
                        className={`p-3 h-full flex flex-col items-center justify-center text-center transition-all hover:scale-105 ${
                          status === 'completed'
                            ? 'border-warning/30 bg-warning/5'
                            : status === 'unlocked'
                            ? 'border-primary/30 bg-primary/5 hover:border-primary/60 cursor-pointer animate-glow-pulse'
                            : 'border-border/30 opacity-40 cursor-not-allowed'
                        }`}
                      >
                        {problem.isBoss ? (
                          <Skull className="h-5 w-5 mb-1" style={{ color: status === 'completed' ? '#f59e0b' : realm.color }} />
                        ) : status === 'completed' ? (
                          <CheckCircle className="h-5 w-5 mb-1 text-warning" />
                        ) : status === 'unlocked' ? (
                          <Circle className="h-5 w-5 mb-1" style={{ color: realm.color }} />
                        ) : (
                          <Lock className="h-5 w-5 mb-1 text-muted" />
                        )}
                        <span className="text-xs font-body truncate w-full">
                          {problem.title}
                        </span>
                        <Badge
                          variant="secondary"
                          className="mt-1 text-xs"
                        >
                          {problem.xpReward} XP
                        </Badge>
                      </Card>
                    </Link>
                  );
                })}
              </div>
            </motion.div>
          );
        })}
      </div>
    </div>
  );
}