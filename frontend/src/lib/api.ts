const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api';

export class ApiError extends Error {
  constructor(public status: number, public body: any) {
    super(body?.message || `API Error ${status}`);
  }
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
  return res.json();
}

export const api = {
  auth: {
    register: (data: { email: string; username: string; password: string }) =>
      apiFetch('/auth/register', { method: 'POST', body: JSON.stringify(data) }),
    login: (data: { email: string; password: string }) =>
      apiFetch('/auth/login', { method: 'POST', body: JSON.stringify(data) }),
    me: () => apiFetch('/auth/me'),
  },
  problems: {
    list: () => apiFetch('/problems'),
    get: (slug: string) => apiFetch(`/problems/${slug}`),
  },
  hints: {
    get: (slug: string) => apiFetch(`/problems/${slug}/hints`),
    state: (slug: string) => apiFetch(`/problems/${slug}/hints/state`),
    unlock: (slug: string, layer: number) =>
      apiFetch(`/problems/${slug}/hints/unlock`, { method: 'POST', body: JSON.stringify({ layer }) }),
    dynamic: (slug: string) =>
      apiFetch(`/problems/${slug}/hints/dynamic`, { method: 'POST' }),
  },
  submissions: {
    submit: (data: { slug: string; sourceCode: string; runSampleOnly: boolean }) =>
      apiFetch('/submissions', { method: 'POST', body: JSON.stringify(data) }),
  },
  progress: {
    skillTree: () => apiFetch('/progress/skill-tree'),
    stats: () => apiFetch('/progress/stats'),
    achievements: () => apiFetch('/progress/achievements'),
  },
};