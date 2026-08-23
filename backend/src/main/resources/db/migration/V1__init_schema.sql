-- V1__init_schema.sql — Full database schema for myCodeQuest

-- Users
CREATE TABLE users (
    id              BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255) UNIQUE NOT NULL,
    username        VARCHAR(50) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    level           INT NOT NULL DEFAULT 1,
    xp              INT NOT NULL DEFAULT 0,
    hp              INT NOT NULL DEFAULT 100,
    streak          INT NOT NULL DEFAULT 0,
    last_solve_date DATE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Problems
CREATE TABLE problems (
    id              BIGSERIAL PRIMARY KEY,
    realm_id        INT NOT NULL,
    slug            VARCHAR(100) UNIQUE NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,
    difficulty      VARCHAR(20) NOT NULL,
    xp_reward       INT NOT NULL,
    order_in_realm  INT NOT NULL,
    starter_code    TEXT NOT NULL,
    solution_code   TEXT,
    time_limit_ms   INT DEFAULT 2000,
    memory_limit_kb INT DEFAULT 256000,
    is_boss         BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Test cases
CREATE TABLE test_cases (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    input           TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    is_hidden       BOOLEAN DEFAULT FALSE,
    order_num       INT DEFAULT 0
);

-- Hints (static, pre-authored per problem — 5 layers)
CREATE TABLE hints (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    layer           INT NOT NULL,
    name            VARCHAR(50) NOT NULL,
    icon            VARCHAR(10),
    content         TEXT NOT NULL,
    hp_cost         INT NOT NULL,
    order_num       INT NOT NULL,
    UNIQUE(problem_id, layer)
);

-- Track which hints a user has unlocked per problem (static + dynamic)
CREATE TABLE hint_usage (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    hint_layer      INT NOT NULL,
    hint_type       VARCHAR(30) NOT NULL,
    hp_cost         INT NOT NULL,
    content         TEXT NOT NULL,
    unlocked_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, problem_id, hint_layer, hint_type)
);

-- Submissions
CREATE TABLE submissions (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    source_code     TEXT NOT NULL,
    status          VARCHAR(50) NOT NULL,
    stdout          TEXT,
    stderr          TEXT,
    compile_output  TEXT,
    execution_time_ms INT,
    memory_used_kb   INT,
    judge0_token    VARCHAR(100),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Track dynamic hint context (what the user's code looked like when they asked)
CREATE TABLE hint_context (
    id              BIGSERIAL PRIMARY KEY,
    hint_usage_id   BIGINT NOT NULL REFERENCES hint_usage(id) ON DELETE CASCADE,
    source_code     TEXT NOT NULL,
    submission_id   BIGINT REFERENCES submissions(id),
    failed_test_case_id BIGINT REFERENCES test_cases(id)
);

-- Problem patterns (for cross-problem pattern hints)
CREATE TABLE problem_patterns (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    pattern_name    VARCHAR(100) NOT NULL
);

-- Skill tree node unlock state
CREATE TABLE skill_tree_progress (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    problem_id      BIGINT NOT NULL REFERENCES problems(id) ON DELETE CASCADE,
    is_unlocked     BOOLEAN DEFAULT FALSE,
    is_completed    BOOLEAN DEFAULT FALSE,
    completed_at    TIMESTAMP,
    UNIQUE(user_id, problem_id)
);

-- Achievements
CREATE TABLE user_achievements (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    achievement_key VARCHAR(50) NOT NULL,
    unlocked_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, achievement_key)
);

-- Indexes for performance
CREATE INDEX idx_problems_realm ON problems(realm_id, order_in_realm);
CREATE INDEX idx_test_cases_problem ON test_cases(problem_id, order_num);
CREATE INDEX idx_submissions_user_problem ON submissions(user_id, problem_id, created_at DESC);
CREATE INDEX idx_skill_tree_user ON skill_tree_progress(user_id);
CREATE INDEX idx_hint_usage_user_problem ON hint_usage(user_id, problem_id);