# myCodeQuest 🎮

A gamified Java LeetCode clone with RPG progression — solve problems, earn XP, level up, unlock skill-tree nodes, and conquer boss problems across 7 themed realms.

## Features

- **70 Hand-Crafted Java Problems** across 7 RPG realms (easy → hard progression)
- **RPG Progression System** — XP, levels, HP, streaks, ranks, achievements
- **Interactive Skill Tree Map** — Path of Exile-style node graph
- **Intelligent Hinting System** — 5 progressive hint layers + dynamic code-aware hints
- **Real Java Code Execution** — Monaco editor + Judge0 sandboxed compilation
- **Beautiful Dark RPG Theme** — TailwindCSS, shadcn/ui, Framer Motion animations

## Tech Stack

- **Frontend:** Next.js 14, TypeScript, TailwindCSS, shadcn/ui, Monaco Editor, Framer Motion
- **Backend:** Spring Boot 3 (Java 21), PostgreSQL, JWT auth, Flyway migrations
- **Code Execution:** Judge0 CE (self-hosted Docker)
- **Infra:** Docker Compose

## Quick Start

```bash
docker-compose up --build
```

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080/api
- Judge0: http://localhost:2358

## Development Setup

### Prerequisites
- Docker & Docker Compose
- Node.js 20+
- Java 21+
- PostgreSQL 16 (or use Docker)

### Local Development (without Docker for frontend/backend)

1. Start infrastructure services:
```bash
docker-compose up postgres judge0-server judge0-redis judge0-postgres
```

2. Start backend:
```bash
cd backend
./gradlew bootRun
```

3. Start frontend:
```bash
cd frontend
npm install
npm run dev
```

## Project Structure

```
myeetcode/
├── docker-compose.yml
├── frontend/          # Next.js 14 app
├── backend/            # Spring Boot 3 app
└── README.md
```

## License

MIT