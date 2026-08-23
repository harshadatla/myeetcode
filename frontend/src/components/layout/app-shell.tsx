'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { useAuthStore } from '@/stores/auth-store';
import { Navbar } from '@/components/layout/navbar';
import { UserStatsBar } from '@/components/layout/user-stats-bar';

export function AppShell({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const { isAuthenticated, isLoading, setLoading } = useAuthStore();

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (!token) {
      setLoading(false);
      router.push('/auth/login');
      return;
    }
    // Token exists — mark as authenticated
    if (!isAuthenticated) {
      // Try to restore session
      useAuthStore.setState({
        token,
        isAuthenticated: true,
        isLoading: false,
      });
    }
    setLoading(false);
  }, [isAuthenticated, isLoading, router, setLoading]);

  if (isLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="text-4xl mb-4 animate-pulse">⚔️</div>
          <p className="text-muted">Loading your quest...</p>
        </div>
      </div>
    );
  }

  if (!isAuthenticated) return null;

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      <main className="pb-16">{children}</main>
      <UserStatsBar />
    </div>
  );
}