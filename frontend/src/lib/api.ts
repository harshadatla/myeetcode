const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api';

export class ApiError extends Error {
  constructor(public status: number, public body: any) {
    super(body?.message || `API Error ${status}`);
  }
}

interface AuthResponse {
  token: string;
  userId: number;
  username: string;
  email: string;
  level: number;
  xp: number;
  hp: number;
  streak: number;
}

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

async function apiFetch<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = typeof window !== 'undefined' ? localStorage.getItem('token') : null;
  const res = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...options.headers,
    },
  });
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new ApiError(res.status, body);
  }
  return res.json() as Promise<T>;
}

export const api = {
  auth: {
    register: (data: { email: string; username: string; password: string }) =>
      apiFetch<AuthResponse>('/auth/register', { method: 'POST', body: JSON.stringify(data) }),
    login: (data: { email: string; password: string }) =>
      apiFetch<AuthResponse>('/auth/login', { method: 'POST', body: JSON.stringify(data) }),
    me: () => apiFetch<AuthResponse>('/auth/me'),
  },
  problems: {
    list: () => apiFetch<ProblemNode[]>('/problems'),
    get: (slug: string) => apiFetch<any>(`/problems/${slug}`),
  },
  hints: {
    get: (slug: string) => apiFetch<any>(`/problems/${slug}/hints`),
    state: (slug: string) => apiFetch<any>(`/problems/${slug}/hints/state`),
    unlock: (slug: string, layer: number) =>
      apiFetch<any>(`/problems/${slug}/hints/unlock`, { method: 'POST', body: JSON.stringify({ layer }) }),
    dynamic: (slug: string) =>
      apiFetch<any>(`/problems/${slug}/hints/dynamic`, { method: 'POST' }),
  },
  submissions: {
    submit: (data: { slug: string; sourceCode: string; runSampleOnly: boolean }) =>
      apiFetch<any>('/submissions', { method: 'POST', body: JSON.stringify(data) }),
  },
  progress: {
    skillTree: () => apiFetch<any>('/progress/skill-tree'),
    stats: () => apiFetch<any>('/progress/stats'),
    achievements: () => apiFetch<any>('/progress/achievements'),
  },
};