'use client';

import { useAuthStore } from '@/stores/auth-store';
import { Progress } from '@/components/ui/progress';
import { xpForLevel, getRankTitle, getStreakMultiplier } from '@/lib/constants';
import { Flame, Heart, Zap } from 'lucide-react';

export function UserStatsBar() {
  const { user } = useAuthStore();
  if (!user) return null;

  const xpNeeded = xpForLevel(user.level + 1);
  const xpProgress = (user.xp / xpNeeded) * 100;
  const hpPercent = user.hp;
  const multiplier = getStreakMultiplier(user.streak);

  return (
    <div className="fixed bottom-0 left-0 right-0 z-40 border-t border-border/50 bg-background/95 backdrop-blur-sm">
      <div className="container mx-auto flex items-center justify-between px-4 py-2 gap-4 text-xs">
        {/* Level + Rank */}
        <div className="flex items-center gap-2">
          <span className="font-heading text-sm text-primary">Lv.{user.level}</span>
          <span className="text-muted hidden sm:inline">{getRankTitle(user.level)}</span>
        </div>

        {/* XP Bar */}
        <div className="flex-1 max-w-xs">
          <div className="flex items-center gap-2">
            <Zap className="h-3 w-3 text-warning" />
            <Progress value={xpProgress} className="h-2 flex-1" />
            <span className="text-muted font-mono text-xs whitespace-nowrap">
              {user.xp}/{xpNeeded}
            </span>
          </div>
        </div>

        {/* HP Bar */}
        <div className="flex items-center gap-2 w-32">
          <Heart className="h-3 w-3 text-destructive" />
          <Progress value={hpPercent} className="h-2 flex-1" />
          <span className="text-muted font-mono whitespace-nowrap">{user.hp} HP</span>
        </div>

        {/* Streak */}
        <div className="flex items-center gap-1">
          <Flame className="h-3 w-3 text-warning" />
          <span className="font-mono">{user.streak}</span>
          {multiplier > 1 && (
            <span className="text-success font-mono text-xs">({multiplier}x)</span>
          )}
        </div>
      </div>
    </div>
  );
}