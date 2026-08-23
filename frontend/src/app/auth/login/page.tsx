'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { motion } from 'framer-motion';
import { toast } from 'sonner';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { api, ApiError } from '@/lib/api';
import { useAuthStore } from '@/stores/auth-store';

export default function LoginPage() {
  const router = useRouter();
  const login = useAuthStore((s) => s.login);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await api.auth.login({ email, password });
      login(res.token, {
        id: res.userId,
        email: res.email,
        username: res.username,
        level: res.level,
        xp: res.xp,
        hp: res.hp,
        streak: res.streak,
        lastSolveDate: null,
      });
      toast.success(`Welcome back, ${res.username}!`);
      router.push('/quest');
    } catch (err) {
      if (err instanceof ApiError) {
        toast.error(err.body?.error || 'Login failed');
      } else {
        toast.error('Login failed');
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex">
      {/* Left: RPG illustration */}
      <div className="hidden lg:flex flex-1 items-center justify-center bg-gradient-to-br from-success/5 via-background to-primary/10 relative overflow-hidden">
        <div className="absolute inset-0">
          <div className="absolute left-1/2 top-1/2 h-[400px] w-[400px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-success/10 blur-[100px]" />
        </div>
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8 }}
          className="relative z-10 text-center px-12"
        >
          <div className="text-7xl mb-6">🏰</div>
          <h2 className="font-heading text-3xl mb-4">Welcome Back, Hero</h2>
          <p className="text-muted font-body">
            Your quest awaits. The realms need conquering.
          </p>
        </motion.div>
      </div>

      {/* Right: Form */}
      <div className="flex-1 flex items-center justify-center px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="w-full max-w-md"
        >
          <h1 className="font-heading text-3xl mb-2">Login</h1>
          <p className="text-muted mb-8">Continue your Java mastery journey.</p>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="email">Email</Label>
              <Input
                id="email"
                type="email"
                placeholder="adventurer@quest.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="bg-secondary/50"
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="password">Password</Label>
              <Input
                id="password"
                type="password"
                placeholder="••••••••"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="bg-secondary/50"
              />
            </div>
            <Button type="submit" disabled={loading} className="w-full" size="lg">
              {loading ? 'Logging in...' : 'Continue Quest'}
            </Button>
          </form>

          <p className="mt-6 text-sm text-muted text-center">
            New adventurer?{' '}
            <Link href="/auth/register" className="text-primary hover:underline">
              Begin your quest
            </Link>
          </p>
        </motion.div>
      </div>
    </div>
  );
}