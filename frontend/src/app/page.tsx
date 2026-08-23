'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { REALMS } from '@/lib/constants';

export default function LandingPage() {
  return (
    <div className="min-h-screen bg-background">
      {/* Hero Section */}
      <section className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden px-4">
        {/* Animated background glow */}
        <div className="pointer-events-none absolute inset-0">
          <div className="absolute left-1/2 top-1/2 h-[600px] w-[600px] -translate-x-1/2 -translate-y-1/2 rounded-full bg-primary/10 blur-[120px]" />
          <div className="absolute left-1/4 top-1/3 h-[300px] w-[300px] rounded-full bg-primary/5 blur-[80px]" />
          <div className="absolute right-1/4 bottom-1/3 h-[300px] w-[300px] rounded-full bg-success/5 blur-[80px]" />
        </div>

        <motion.div
          initial={{ opacity: 0, y: 40 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: 'easeOut' }}
          className="relative z-10 text-center"
        >
          <motion.p
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.3 }}
            className="mb-4 text-sm font-body uppercase tracking-widest text-muted"
          >
            An RPG Java Coding Adventure
          </motion.p>
          <h1 className="font-heading text-5xl md:text-7xl font-bold leading-tight">
            <span className="bg-gradient-to-r from-primary via-primary to-success bg-clip-text text-transparent">
              Forge Your Java Mastery
            </span>
          </h1>
          <p className="mt-4 max-w-xl mx-auto font-body text-lg text-muted-foreground">
            Solve problems, earn XP, level up, and conquer bosses across 7 RPG realms.
            Your coding journey starts here.
          </p>
          <div className="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
            <Link href="/auth/register">
              <Button
                size="lg"
                className="w-full sm:w-auto animate-glow-pulse text-base font-semibold"
              >
                Begin Your Quest
              </Button>
            </Link>
            <Link href="/auth/login">
              <Button
                size="lg"
                variant="outline"
                className="w-full sm:w-auto text-base font-semibold"
              >
                I Already Quest
              </Button>
            </Link>
          </div>
        </motion.div>
      </section>

      {/* Realms Preview */}
      <section className="px-4 py-20 border-t border-border/50">
        <div className="max-w-6xl mx-auto">
          <h2 className="font-heading text-3xl text-center mb-12">
            Seven Realms Await
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            {REALMS.map((realm, i) => (
              <motion.div
                key={realm.id}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.1 }}
              >
                <Card className="p-4 hover:border-primary/30 transition-all hover:scale-[1.02] cursor-default">
                  <div className="text-4xl mb-2">{realm.icon}</div>
                  <h3 className="font-heading text-sm font-semibold">{realm.name}</h3>
                  <p className="text-xs text-muted mt-1">{realm.desc}</p>
                </Card>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Features */}
      <section className="px-4 py-20 border-t border-border/50">
        <div className="max-w-5xl mx-auto">
          <h2 className="font-heading text-3xl text-center mb-12">
            Why myCodeQuest?
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {[
              { icon: '⚔️', title: '70 Hand-Crafted Problems', desc: 'Progressive difficulty across 7 realms — from Java basics to advanced tree algorithms.' },
              { icon: '🎮', title: 'RPG Progression', desc: 'XP, levels, skill trees, achievements, streaks. Learn Java by playing a game.' },
              { icon: '🔮', title: 'Intelligent Hinting', desc: '5 progressive hint layers + dynamic code-aware hints that analyze your failed submissions.' },
            ].map((feature, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.15 }}
              >
                <Card className="p-6 text-center hover:border-primary/30 transition-all">
                  <div className="text-5xl mb-4">{feature.icon}</div>
                  <h3 className="font-heading text-lg mb-2">{feature.title}</h3>
                  <p className="text-sm text-muted">{feature.desc}</p>
                </Card>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer CTA */}
      <section className="px-4 py-20 border-t border-border/50">
        <div className="max-w-2xl mx-auto text-center">
          <h2 className="font-heading text-3xl mb-4">Ready to Begin?</h2>
          <p className="text-muted mb-8">
            Join the quest. Master Java. Become a Legend.
          </p>
          <Link href="/auth/register">
            <Button size="lg" className="animate-glow-pulse text-base font-semibold">
              Start Your Journey
            </Button>
          </Link>
        </div>
      </section>
    </div>
  );
}