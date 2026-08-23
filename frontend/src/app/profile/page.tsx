'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Progress } from '@/components/ui/progress';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { useAuthStore } from '@/stores/auth-store';
import { xpForLevel, getRankTitle, ACHIEVEMENTS } from '@/lib/constants';
import { Trophy, Flame, Target, Zap, Heart } from 'lucide-react';

export default function ProfilePage() {
  const { user } = useAuthStore();
  const [achievements, setAchievements] = useState<string[]>([]);

  useEffect(() => {
    apiCall();
  }, []);

  const apiCall = async () => {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api'}/progress/achievements`, {
        headers: { Authorization: `Bearer ${localStorage.getItem('token')}` },
      });
      if (res.ok) {
        const data = await res.json();
        setAchievements(data.map((a: any) => a.achievementKey || a));
      }
    } catch {}
  };

  if (!user) return null;

  const xpNeeded = xpForLevel(user.level + 1);
  const xpProgress = (user.xp / xpNeeded) * 100;

  return (
    <div className="container mx-auto px-4 py-8 max-w-4xl">
      <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }}>
        {/* Character Card */}
        <Card className="p-6 mb-6 border-primary/20">
          <div className="flex items-center gap-6">
            <Avatar className="h-24 w-24 rounded-full border-4 border-primary/30">
              <AvatarFallback className="bg-primary/10 text-primary text-2xl font-heading">
                {user.username.slice(0, 2).toUpperCase()}
              </AvatarFallback>
            </Avatar>
            <div className="flex-1">
              <h1 className="font-heading text-2xl">{user.username}</h1>
              <p className="text-muted text-sm">{user.email}</p>
              <div className="flex items-center gap-2 mt-2">
                <Badge className="bg-primary/20 text-primary">Level {user.level}</Badge>
                <span className="text-sm text-muted">{getRankTitle(user.level)}</span>
              </div>
            </div>
          </div>

          <div className="mt-6 space-y-4">
            {/* XP Bar */}
            <div>
              <div className="flex items-center justify-between mb-1">
                <span className="text-xs text-muted flex items-center gap-1">
                  <Zap className="h-3 w-3 text-warning" /> Experience
                </span>
                <span className="text-xs font-mono text-muted">{user.xp} / {xpNeeded} XP</span>
              </div>
              <Progress value={xpProgress} className="h-3" />
            </div>
            {/* HP Bar */}
            <div>
              <div className="flex items-center justify-between mb-1">
                <span className="text-xs text-muted flex items-center gap-1">
                  <Heart className="h-3 w-3 text-destructive" /> Health
                </span>
                <span className="text-xs font-mono text-muted">{user.hp} / 100 HP</span>
              </div>
              <Progress value={user.hp} className="h-3" />
            </div>
          </div>
        </Card>

        {/* Stats Grid */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
          {[
            { icon: Trophy, label: 'Streak', value: `${user.streak} days`, color: 'text-warning' },
            { icon: Zap, label: 'Total XP', value: user.xp.toLocaleString(), color: 'text-primary' },
            { icon: Heart, label: 'HP', value: `${user.hp}/100`, color: 'text-destructive' },
            { icon: Target, label: 'Level', value: `${user.level}`, color: 'text-success' },
          ].map((stat, i) => (
            <motion.div key={i} initial={{ opacity: 0, scale: 0.9 }} animate={{ opacity: 1, scale: 1 }} transition={{ delay: i * 0.1 }}>
              <Card className="p-4 text-center">
                <stat.icon className={`h-6 w-6 mx-auto mb-2 ${stat.color}`} />
                <p className="text-lg font-heading">{stat.value}</p>
                <p className="text-xs text-muted">{stat.label}</p>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Achievements */}
        <Card className="p-6">
          <h2 className="font-heading text-lg mb-4 flex items-center gap-2">
            <Trophy className="h-5 w-5 text-warning" /> Achievements
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {ACHIEVEMENTS.map((ach) => {
              const unlocked = achievements.includes(ach.key);
              return (
                <div
                  key={ach.key}
                  className={`rounded-lg border p-4 text-center transition-all ${
                    unlocked
                      ? 'border-warning/30 bg-warning/5'
                      : 'border-border/20 opacity-30 grayscale'
                  }`}
                >
                  <div className="text-3xl mb-2">{ach.icon}</div>
                  <p className="text-xs font-heading">{ach.title}</p>
                  <p className="text-xs text-muted mt-1">{ach.desc}</p>
                </div>
              );
            })}
          </div>
        </Card>
      </motion.div>
    </div>
  );
}