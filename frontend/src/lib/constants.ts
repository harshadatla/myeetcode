export const REALMS = [
  { id: 1, name: 'Forest of Fundamentals', icon: '🌲', color: '#a6e3a1', desc: 'Java basics: loops, conditionals, methods' },
  { id: 2, name: 'Caves of Arrays', icon: '🕳️', color: '#89b4fa', desc: 'Arrays, two pointers, sliding window' },
  { id: 3, name: 'String Mountains', icon: '⛰️', color: '#fab387', desc: 'String manipulation, StringBuilder, regex' },
  { id: 4, name: 'Sorting Citadel', icon: '🏰', color: '#f38ba8', desc: 'Sorting algorithms, binary search' },
  { id: 5, name: 'Hash Marshlands', icon: '🌊', color: '#cba6f7', desc: 'HashMap, HashSet, Collections' },
  { id: 6, name: 'Linked List Labyrinth', icon: '🔗', color: '#f5c2e7', desc: 'Linked lists, stacks, queues' },
  { id: 7, name: 'Tree Sanctuary', icon: '🌳', color: '#74c7ec', desc: 'Trees, BSTs, recursion, graphs' },
] as const;

export const RANKS = [
  { level: 1, title: 'Novice' },
  { level: 5, title: 'Apprentice' },
  { level: 10, title: 'Squire' },
  { level: 20, title: 'Knight' },
  { level: 35, title: 'Paladin' },
  { level: 50, title: 'Sage' },
  { level: 75, title: 'Archmage' },
  { level: 100, title: 'Legend' },
] as const;

export const HINT_LAYERS = [
  { layer: 1, name: 'The Compass', icon: '🧭', hpCost: 5 },
  { layer: 2, name: 'The Map', icon: '🗺️', hpCost: 10 },
  { layer: 3, name: 'The Blueprint', icon: '📐', hpCost: 15 },
  { layer: 4, name: 'The Scaffold', icon: '🔨', hpCost: 20 },
  { layer: 5, name: "The Sage's Whisper", icon: '🔮', hpCost: 30 },
] as const;

export const XP_REWARDS = {
  EASY: 50,
  MEDIUM: 120,
  HARD: 300,
  BOSS: 500,
} as const;

export const xpForLevel = (level: number): number => 100 * level * level;

export const levelFromXp = (totalXp: number): number => {
  return Math.floor(Math.sqrt(totalXp / 100));
};

export const getRankTitle = (level: number): string => {
  let title = 'Novice';
  for (const rank of RANKS) {
    if (level >= rank.level) title = rank.title;
  }
  return title;
};

export const getStreakMultiplier = (streak: number): number => {
  if (streak >= 30) return 2;
  if (streak >= 7) return 1.5;
  return 1;
};

export const ACHIEVEMENTS = [
  { key: 'FIRST_BLOOD', title: 'First Blood', desc: 'Solve your first problem', icon: '⚔️' },
  { key: 'COMBO_MASTER', title: 'Combo Master', desc: '5 correct submissions in a row', icon: '🔥' },
  { key: 'SPEED_DEMON', title: 'Speed Demon', desc: 'Solve a medium in under 5 minutes', icon: '⚡' },
  { key: 'UNTOUCHABLE', title: 'Untouchable', desc: 'Solve a hard with 0 wrong submissions', icon: '🛡️' },
  { key: 'NO_HINT_NO_PROBLEM', title: 'No Hint, No Problem', desc: 'Solve a medium/hard without any hints', icon: '🧠' },
  { key: 'REALM_CONQUEROR', title: 'Realm Conqueror', desc: 'Clear all nodes in a realm', icon: '👑' },
  { key: 'STREAK_30', title: '30-Day Warrior', desc: '30-day solve streak', icon: '📅' },
  { key: 'SAGE', title: 'Java Sage', desc: 'Reach level 50', icon: '🎓' },
] as const;