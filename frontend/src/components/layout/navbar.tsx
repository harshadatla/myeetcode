'use client';

import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useAuthStore } from '@/stores/auth-store';
import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback } from '@/components/ui/avatar';
import { Badge } from '@/components/ui/badge';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { getRankTitle } from '@/lib/constants';
import { LogOut, Menu } from 'lucide-react';

export function Navbar() {
  const router = useRouter();
  const { user, logout } = useAuthStore();

  const handleLogout = () => {
    logout();
    router.push('/');
  };

  if (!user) {
    return (
      <header className="border-b border-border/50 bg-background/80 backdrop-blur-sm sticky top-0 z-50">
        <div className="container mx-auto flex h-16 items-center justify-between px-4">
          <Link href="/" className="font-heading text-xl font-bold">
            <span className="text-primary">my</span>CodeQuest
          </Link>
          <div className="flex gap-2">
            <Link href="/auth/login">
              <Button variant="ghost" size="sm">Login</Button>
            </Link>
            <Link href="/auth/register">
              <Button size="sm">Sign Up</Button>
            </Link>
          </div>
        </div>
      </header>
    );
  }

  return (
    <header className="border-b border-border/50 bg-background/80 backdrop-blur-sm sticky top-0 z-50">
      <div className="container mx-auto flex h-16 items-center justify-between px-4">
        <div className="flex items-center gap-8">
          <Link href="/quest" className="font-heading text-xl font-bold">
            <span className="text-primary">my</span>CodeQuest
          </Link>
          <nav className="hidden md:flex gap-4">
            <Link href="/quest" className="text-sm text-muted hover:text-foreground transition-colors">
              Quest Map
            </Link>
            <Link href="/profile" className="text-sm text-muted hover:text-foreground transition-colors">
              Profile
            </Link>
            <Link href="/leaderboard" className="text-sm text-muted hover:text-foreground transition-colors">
              Leaderboard
            </Link>
          </nav>
        </div>

        <div className="flex items-center gap-4">
          <div className="hidden sm:flex items-center gap-2">
            <Badge variant="secondary" className="font-mono">
              Lv.{user.level}
            </Badge>
            <span className="text-xs text-muted">{getRankTitle(user.level)}</span>
          </div>
          <DropdownMenu>
            <DropdownMenuTrigger className="flex items-center gap-2 cursor-pointer outline-none">
              <Avatar className="h-8 w-8 border border-primary/30">
                <AvatarFallback className="bg-primary/10 text-primary text-xs">
                  {user.username.slice(0, 2).toUpperCase()}
                </AvatarFallback>
              </Avatar>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end">
              <div className="px-2 py-1.5">
                <p className="text-sm font-semibold">{user.username}</p>
                <p className="text-xs text-muted">{user.email}</p>
              </div>
              <DropdownMenuItem onClick={() => router.push('/profile')}>
                Profile
              </DropdownMenuItem>
              <DropdownMenuItem onClick={handleLogout} className="text-destructive">
                <LogOut className="h-4 w-4 mr-2" />
                Logout
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </div>
    </header>
  );
}