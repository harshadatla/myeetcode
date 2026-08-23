# myCodeQuest — Java LeetCode Clone with RPG Progression

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Build a beautiful, gamified Java coding practice platform where users solve progressively harder problems and "level up" like an RPG character — earning XP, unlocking skill-tree nodes, and conquering "boss" problems.

**Architecture:** Next.js 14 (App Router) frontend with TypeScript, TailwindCSS, shadcn/ui, Monaco Editor, and Framer Motion animations. Spring Boot 3 (Java 21) backend with PostgreSQL, JWT auth, and Judge0 CE (self-hosted Docker) for sandboxed Java code execution. The RPG progression engine tracks XP, levels, skill-tree unlocks, streaks, and achievements.

**Tech Stack:**
- **Frontend:** Next.js 14, TypeScript, TailwindCSS v4, shadcn/ui, @monaco-editor/react, Framer Motion, Zustand (state), TanStack Query (server state)
- **Backend:** Spring Boot 3.3, Java 21, Gradle, Spring Security + JWT, Spring Data JPA, Flyway (migrations), PostgreSQL 16
- **Code Execution:** Judge0 CE via Docker (language_id=62 for Java OpenJDK 13.0.1)
- **Infra:** Docker Compose for local dev (postgres + judge0 + backend + frontend)

---

## RPG Progression System Design

The core differentiator — learning Java DSA feels like playing an RPG.

### Character Stats
```
Level:        1 → 100 (XP-based, increasing curve)
XP:           Earned per problem solve (easy=50, medium=120, hard=300, boss=500)
HP:           100 max. Wrong submission = -10 HP. 0 HP = "must review a hint" penalty.
Streak:       Daily solve streak (multiplier: 1x base, 1.5x at 7-day streak, 2x at 30-day)
Rank:         Novice → Apprentice → Squire → Knight → Paladin → Sage → Archmage → Legend
```

### Skill Tree (7 Worlds / Realms)

Each realm is a "world" on the skill tree, containing nodes (problems) that unlock progressively. Completing all nodes in a world unlocks the **Boss Problem** — a multi-part challenge combining all skills from that realm.

```
Realm 1: The Forest of Fundamentals      (Easy — Java Basics, Loops, Conditionals)
Realm 2: The Caves of Arrays             (Easy-Medium — Arrays, Two Pointers, Sliding Window)
Realm 3: The String Mountains           (Medium — String manipulation, Regex, StringBuilder)
Realm 4: The Sorting Citadel             (Medium — Sorting algorithms, Binary Search)
Realm 5: The Hash Marshlands             (Medium — HashMap, HashSet, Collections)
Realm 6: The Linked List Labyrinth       (Medium-Hard — Linked Lists, Stacks, Queues)
Realm 7: The Tree Sanctuary               (Hard — Trees, BSTs, Recursion, Graphs)
```

### Visual Skill Tree Map
Each realm renders as an interactive node-graph (like Path of Exile / Diablo). Nodes light up when unlocked. Completed nodes glow. Boss nodes are skull-shaped and locked until all prerequisite nodes are cleared.

```
[Start] → [Var] → [Loop] → [Cond] → [Method] → [BOSS: FizzBuzz Ultimate]
            ↓                              ↑
         [Array1] → [Array2] → [TwoPtr] → [SlidingWindow] → [BOSS: Max Subarray]
```

### Achievement Badges
- "First Blood" — Solve your first problem
- "Combo Master" — 5 correct submissions in a row
- "Speed Demon" — Solve a medium in under 5 minutes
- "Untouchable" — Solve a hard with 0 wrong submissions
- "Realm Conqueror" — Clear all nodes in a realm
- "30-Day Warrior" — 30-day solve streak
- "Java Sage" — Reach level 50
- "No Hint, No Problem" — Solve any medium/hard without unlocking any hints

---

## Intelligent Hinting System Design

The hinting system is a core feature — not an afterthought. It provides multi-layered, progressive assistance that guides the user toward the solution without ever just giving it away. The system is aware of the user's current code, their submission history, and how many hints they've already used.

### Hint Layers (5 Levels of Help)

Hints unlock progressively — you can't see Layer 3 until you've consumed Layer 1 and 2. Each layer costs more HP but gives more specific guidance. The user chooses when to ask for help; hints are never forced.

```
Layer 1: "The Compass"      (5 HP)   — High-level approach nudge
Layer 2: "The Map"           (10 HP)  — Algorithm/pattern name + conceptual steps
Layer 3: "The Blueprint"    (15 HP)  — Pseudocode outline (no actual Java)
Layer 4: "The Scaffold"     (20 HP)  — Java code skeleton with TODOs
Layer 5: "The Sage's Whisper" (30 HP) — Near-complete solution with key lines blanked out
```

### Hint Types

1. **Static Hints** (pre-authored per problem) — Layers 1-3 are written by the problem author and stored in the database. These cover approach, algorithm name, and pseudocode.

2. **Dynamic Code-Aware Hints** (generated at runtime) — When a user has submitted code that failed, the system analyzes their submission and generates a targeted hint:
   - **Compilation Error** → Parse Judge0 `compile_output`, translate the Java compiler error into beginner-friendly English, point to the likely line.
   - **Wrong Answer** → Compare expected vs actual output, identify edge cases the user missed, suggest "Have you considered what happens when the input is empty/negative/single-element?"
   - **Time Limit Exceeded** → Tell the user their approach is too slow, name the likely time complexity they hit, suggest the target complexity.
   - **Runtime Exception** → Identify the exception type (NPE, ArrayIndexOutOfBounds, etc.) and explain what likely caused it in plain language.

3. **Pattern Hints** (cross-problem) — When a user is stuck on problem N, and they've previously solved problem M that uses the same algorithmic pattern, the hint says: "This problem uses the same pattern as [Problem M] you already solved. Recall how you approached that."

### Dynamic Hint Generation Engine

The backend includes a `HintEngine` service that:
1. Takes the user's current (failed) submission + the problem's test cases.
2. Classifies the failure type from Judge0 response.
3. Generates a targeted, code-aware hint using a rule-based engine (no AI needed — rule-based is deterministic, fast, and free).

```java
@Service
public class HintEngine {
    // Analyzes a failed submission and generates a dynamic hint
    public DynamicHint generateHint(Submission failedSubmission, Problem problem, List<TestCase> failedCases) {
        return switch (failedSubmission.getStatus()) {
            case COMPILE_ERROR     -> compileErrorHint(failedSubmission.getCompileOutput());
            case WRONG_ANSWER      -> wrongAnswerHint(failedSubmission, failedCases, problem);
            case TIME_LIMIT_EXCEEDED -> tleHint(problem);
            case RUNTIME_ERROR      -> runtimeErrorHint(failedSubmission.getStderr());
            default -> new DynamicHint("Unexpected status. Try resetting your code and starting fresh.");
        };
    }

    // Java compiler error → human-friendly explanation
    private DynamicHint compileErrorHint(String compileOutput) {
        // Parse common Java compiler errors:
        // "cannot find symbol"    → "You're using a variable or method name that doesn't exist. Check spelling and scope."
        // "incompatible types"     → "Type mismatch. You're assigning a value of one type to a variable of another. Check your declarations."
        // "';' expected"           → "Missing semicolon. Java needs ; at the end of each statement."
        // "class expected"         → "Check your class structure. You may be missing a closing brace }."
        // "illegal start of expression" → "Syntax error. Check for misplaced operators, parentheses, or braces."
        // "unclosed string literal" → "You have a string that isn't properly closed with a matching quote."
        // Return DynamicHint with the translated error + line number if parseable
    }

    // Wrong answer → edge case analysis
    private DynamicHint wrongAnswerHint(Submission sub, List<TestCase> failedCases, Problem problem) {
        // Look at the first failing test case:
        // - If input is empty/null → "Your code fails on empty input. Add a check at the beginning."
        // - If input has negative numbers → "Your code doesn't handle negative values. Review your loop conditions."
        // - If input is a single element → "Single-element edge case. What does your code return when the array has length 1?"
        // - If the actual output is empty but expected is not → "Your code produces no output for this case. Check if your loop body ever executes."
        // - If actual output has extra characters → "Your output has extra characters. Check for extra spaces, newlines, or print statements."
        // Return DynamicHint with the specific edge case analysis
    }

    // TLE → complexity nudge
    private DynamicHint tleHint(Problem problem) {
        // Based on problem constraints in description:
        // - n <= 10 → O(n!) is fine, but O(2^n) might TLE
        // - n <= 1000 → O(n^2) is fine, O(n^3) might TLE
        // - n <= 10^5 → O(n log n) is fine, O(n^2) will TLE
        // - n <= 10^9 → Must be O(log n) or O(1)
        // Tell the user: "Your solution is too slow. For input size up to N, you need an O(?) algorithm. Your current approach appears to be O(?). Think about how to reduce the number of operations."
    }

    // Runtime error → exception translation
    private DynamicHint runtimeErrorHint(String stderr) {
        // Match common Java exceptions:
        // ArrayIndexOutOfBoundsException → "You're accessing an array index that doesn't exist. Check your loop bounds — are you going past array.length?"
        // NullPointerException → "You're using a reference that is null. Check if your variable is initialized before using it."
        // NumberFormatException → "You're trying to parse a string that isn't a valid number. Add input validation."
        // ArithmeticException → "Math error — likely division by zero. Check your divisor."
        // StackOverflowError → "Infinite recursion! Your recursive call has no proper base case. Make sure there's a condition that stops the recursion."
        // Return DynamicHint with translated exception + likely cause
    }
}
```

### Hint State Tracking

```sql
-- Track which hints a user has unlocked per problem
CREATE TABLE hint_usage (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT REFERENCES users(id),
    problem_id      BIGINT REFERENCES problems(id),
    hint_layer      INT NOT NULL,              -- 1-5
    hint_type       VARCHAR(30) NOT NULL,      -- STATIC, DYNAMIC_COMPILE, DYNAMIC_WRONG, DYNAMIC_TLE, DYNAMIC_RUNTIME, PATTERN
    hp_cost         INT NOT NULL,
    content         TEXT NOT NULL,             -- The hint content that was shown
    unlocked_at     TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, problem_id, hint_layer, hint_type)
);

-- Track dynamic hint context (what the user's code looked like when they asked)
CREATE TABLE hint_context (
    id              BIGSERIAL PRIMARY KEY,
    hint_usage_id   BIGINT REFERENCES hint_usage(id),
    source_code     TEXT NOT NULL,             -- User's code at the time they asked
    submission_id   BIGINT REFERENCES submissions(id), -- The failed submission that triggered the dynamic hint
    failed_test_case_id BIGINT REFERENCES test_cases(id)
);
```

### Hint API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/problems/{slug}/hints` | Get all hints for a problem (only unlocked ones show content; locked ones show layer + HP cost) |
| POST | `/api/problems/{slug}/hints/unlock` | Unlock the next hint layer. Body: `{ layer: int, type: "STATIC" | "DYNAMIC" }`. For dynamic, analyzes last failed submission. Deducts HP. Returns hint content. |
| GET | `/api/problems/{slug}/hints/state` | Get hint state: which layers unlocked, HP spent so far, whether dynamic hint is available (requires ≥1 failed submission) |
| POST | `/api/problems/{slug}/hints/dynamic` | Request a dynamic code-aware hint. Analyzes the user's last failed submission. Returns a DynamicHint. Costs 10 HP. Only available if user has ≥1 failed submission for this problem. |

### Hint UI — "The Oracle's Guidance"

The hint UI is themed as consulting a mystical oracle. It's not a boring "help" dropdown — it's an immersive RPG interaction.

#### Oracle Panel (in Problem Workspace left panel, below problem description)

```
┌────────────────────────────────────────────┐
│  🔮 The Oracle's Guidance                  │
│                                            │
│  Layer 1: The Compass         [UNLOCKED]    │
│  "Think about using a hash map to track     │
│   frequencies of each element..."          │
│                                            │
│  Layer 2: The Map             [UNLOCKED]   │
│  "Algorithm: Two-Pointer Technique.         │
│   Place one pointer at the start and one    │
│   at the end. Move them toward each         │
│   other based on the sum comparison..."     │
│                                            │
│  Layer 3: The Blueprint       [LOCKED - 15 HP]
│  Layer 4: The Scaffold        [LOCKED - 20 HP]
│  Layer 5: The Sage's Whisper  [LOCKED - 30 HP]
│                                            │
│  ── Dynamic Hints ──────────────────────    │
│                                            │
│  ⚠️ Your last submission had a compile      │
│     error. Click below for a targeted hint. │
│                                            │
│  [🔍 Analyze My Failed Submission]  (10 HP) │
│                                            │
│  ── Pattern Hint ───────────────────────    │
│                                            │
│  💡 You solved "Two Sum" using a similar    │
│     hash map pattern. This problem can      │
│     be approached the same way.             │
│                                            │
└────────────────────────────────────────────┘
```

#### Visual Design
- **Oracle icon:** A crystal ball (🔮) or wise sage icon at the top of the panel, with a subtle purple glow.
- **Unlocked hints:** Full content visible, with a faint amber left-border accent.
- **Locked hints:** Show only the layer name + HP cost, dimmed with a lock icon. Hovering shows a tooltip: "Unlocking this hint will cost X HP. You'll still get full XP if you solve the problem."
- **Dynamic hint button:** Only appears if the user has ≥1 failed submission. Glows when available. On click, shows a loading spinner ("The Oracle examines your code...") then reveals the targeted hint with a typewriter animation effect.
- **Pattern hint:** Auto-discovered and shown as a passive info card (no HP cost — it's a reward for having solved related problems).
- **HP cost animation:** When a hint is unlocked, show a brief `-X HP` floating text animation from the HP bar.

#### Hint Card Component (Individual Hint Display)

```tsx
function HintCard({ hint, isUnlocked, onUnlock }) {
  if (!isUnlocked) {
    return (
      <div className="rounded-lg border border-muted/20 bg-surface/30 p-4 opacity-60">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <LockIcon className="h-4 w-4 text-muted" />
            <span className="font-body text-sm">Layer {hint.layer}: {hint.name}</span>
          </div>
          <Badge variant="warning">{hint.hpCost} HP</Badge>
        </div>
        <Button variant="ghost" size="sm" className="mt-2 text-xs"
          onClick={() => onUnlock(hint.layer)}>
          Consult the Oracle ({hint.hpCost} HP)
        </Button>
      </div>
    );
  }

  return (
    <motion.div
      initial={{ opacity: 0, height: 0 }}
      animate={{ opacity: 1, height: 'auto' }}
      className="rounded-lg border-l-2 border-amber-500/40 bg-amber-500/5 p-4"
    >
      <div className="flex items-center gap-2 mb-2">
        <span className="text-lg">{hint.icon}</span>
        <span className="font-heading text-sm text-amber-500/80">
          Layer {hint.layer}: {hint.name}
        </span>
      </div>
      <TypewriterText text={hint.content} speed={20} />
    </motion.div>
  );
}
```

#### Dynamic Hint Component

```tsx
function DynamicHintButton({ problemSlug, lastFailedSubmission }) {
  const [analysis, setAnalysis] = useState(null);
  const [isAnalyzing, setIsAnalyzing] = useState(false);

  if (!lastFailedSubmission) return null;

  const failureType = lastFailedSubmission.status; // COMPILE_ERROR, WRONG_ANSWER, etc.

  return (
    <div className="rounded-lg border border-danger/20 bg-danger/5 p-4">
      <div className="flex items-center gap-2 mb-2">
        <AlertIcon className="h-4 w-4 text-danger" />
        <span className="text-sm text-danger">Your last submission: {humanizeStatus(failureType)}</span>
      </div>

      <Button
        variant="outline"
        size="sm"
        className="w-full border-primary/30 hover:border-primary/60"
        onClick={() => {
          setIsAnalyzing(true);
          api.hints.dynamic(problemSlug).then(hint => {
            setAnalysis(hint);
            setIsAnalyzing(false);
          });
        }}
      >
        {isAnalyzing ? (
          <><Spinner className="h-4 w-4 mr-2 animate-spin" /> The Oracle examines your code...</>
        ) : (
          <>🔍 Analyze My Failed Submission (10 HP)</>
        )}
      </Button>

      {analysis && (
        <motion.div initial={{ opacity: 0, y: -10 }} animate={{ opacity: 1, y: 0 }}
          className="mt-3 rounded-md bg-surface p-3 border border-primary/20">
          <TypewriterText text={analysis.content} speed={15} />
          {analysis.lineNumber && (
            <p className="mt-2 text-xs text-muted">Likely issue at line {analysis.lineNumber}</p>
          )}
        </motion.div>
      )}
    </div>
  );
}
```

### Hint XP Penalty Logic

Using hints does NOT reduce the XP you earn for solving the problem — it only costs HP. This is intentional: we want users to feel that asking for help is okay and encouraged, not punitive. The HP cost is the tradeoff, not reduced rewards.

However, there IS an achievement for solving without hints:
- **"No Hint, No Problem"** — Solve a medium or hard problem without unlocking ANY hints (including dynamic). This is a badge of honor.

The XP table stays the same regardless of hints used:
```
Easy:   50 XP
Medium: 120 XP
Hard:   300 XP
Boss:   500 XP
```
Streak multipliers still apply on top.

### Java Compiler Error Translation Table

The `HintEngine.compileErrorHint()` method uses this lookup table to translate raw Java compiler errors into beginner-friendly explanations:

| Java Compiler Message | Beginner-Friendly Hint |
|---|---|
| `cannot find symbol` | "You're using a variable, method, or class name that Java doesn't recognize. Check: (1) is it spelled correctly? (2) is it declared before you use it? (3) is it in scope?" |
| `incompatible types: X cannot be converted to Y` | "Type mismatch — you're trying to use a {X} where a {Y} is expected. Check your variable types and any casts." |
| `';' expected` | "Missing semicolon. Java requires a ; at the end of each statement. Look at the line just before the error." |
| `class, interface, or enum expected` | "Java found something unexpected at the class level. You might have code outside a class, or mismatched braces." |
| `illegal start of expression` | "Syntax error — Java doesn't understand this expression. Check for misplaced operators, missing parentheses, or stray characters." |
| `unclosed string literal` | "You opened a string with a quote (\") but didn't close it. Check that every \" has a matching closing \"." |
| `variable might not have been initialized` | "You're using a variable before assigning it a value. Initialize it first, e.g., `int x = 0;` instead of just `int x;`." |
| `method ... cannot be applied to given types` | "The arguments you're passing to this method don't match its parameters. Check the method signature — are the types and count correct?" |
| `possible loss of precision` | "You're assigning a larger type (like double) to a smaller type (like int). Add an explicit cast: `(int)value`." |
| `incompatible types: null` | "You're using null in a context where Java needs a specific type. Make sure the variable is properly typed." |
| `unreachable statement` | "Code after a return or break statement will never execute. Remove the unreachable code or fix your control flow." |
| `'}' expected` | "Missing closing brace. You opened a block with { but didn't close it with }. Count your braces." |
| `array required, but X found` | "You're using array index notation [ ] on something that isn't an array. Check the variable type." |
| `bad operand types for operator X` | "The operator {X} doesn't work with the types you're using. Check the types on both sides." |

### Edge Case Analysis Table

The `HintEngine.wrongAnswerHint()` method analyzes the first failing test case:

| Test Case Pattern | Hint Generated |
|---|---|
| Input is empty string / `""` | "Your code fails on empty input. What does your code do when there's nothing to process? Add a guard clause at the start." |
| Input is a single element | "Single-element edge case. When the array/list has just one element, your loop might not execute. Check your loop bounds." |
| Input contains negative numbers | "Your code doesn't handle negative values correctly. Review your comparison operators and initial values — are you initializing with 0 when you should use Integer.MIN_VALUE?" |
| Input contains zeros | "Your code fails when the input includes zero. Zero is neither positive nor negative — does your logic handle this?" |
| Input is already sorted | "Your code fails on already-sorted input. Some algorithms behave differently on sorted vs unsorted data. Check if your approach assumes unsorted input." |
| Input has duplicate values | "Your code fails on input with duplicates. Are you accidentally skipping or double-counting repeated values?" |
| Expected output is empty | "The expected output is empty for this case. Should your code produce no output for this input?" |
| Actual output has extra whitespace | "Your output has extra spaces or newlines. Check your print statements — are you adding extra spaces or using println where you should use print?" |
| Actual output is truncated | "Your output is cut short. Are you breaking out of a loop too early? Check your break/return conditions." |
| Actual output is empty but expected is not | "Your code produced no output. Is your main method reaching the print statements? Check if your code is throwing a silent exception." |
| Output differs only in case | "Your output differs only in letter case. Check if you need toUpperCase() or toLowerCase() on your result." |

---

## Problem Set (70 Problems Across 7 Realms)

Each problem includes: title, description, difficulty, XP reward, Java starter code, test cases, solution, 5 hint layers (The Compass → The Sage's Whisper), and dynamic code-aware hints.

### Realm 1: Forest of Fundamentals (Easy)
1. Hello, Java! — Print "Hello, World!" (50 XP)
2. Sum of Two Numbers — Read stdin, print sum (50 XP)
3. Even or Odd — Modulo operator (50 XP)
4. Multiplication Table — Nested loops (75 XP)
5. Factorial — For loop / recursion intro (75 XP)
6. Palindrome Number — While loop, digit extraction (100 XP)
7. FizzBuzz — Classic conditional logic (100 XP)
8. Reverse a String — StringBuilder basics (100 XP)
9. Count Digits — While loop with division (100 XP)
10. **BOSS: FizzBuzz Ultimate** — FizzBuzz with custom divisors + range input (200 XP)

### Realm 2: Caves of Arrays (Easy → Medium)
11. Max Element in Array — Linear scan (100 XP)
12. Second Largest — Two-variable tracking (120 XP)
13. Remove Duplicates — In-place modification (120 XP)
14. Two Sum — HashMap intro (but teach brute-force first) (150 XP)
15. Move Zeroes — Two-pointer technique (150 XP)
16. Best Time to Buy/Sell Stock — Sliding window concept (150 XP)
17. Merge Sorted Arrays — Two-pointer merge (180 XP)
18. Rotate Array — Reversal trick (180 XP)
19. Pascal's Triangle — 2D List construction (180 XP)
20. **BOSS: Maximum Subarray (Kadane's)** — Combine sliding window + DP thinking (300 XP)

### Realm 3: String Mountains (Medium)
21. Valid Anagram — char[] frequency counting (150 XP)
22. Valid Palindrome — Two-pointer on strings (150 XP)
23. Longest Common Prefix — Vertical scanning (180 XP)
24. Length of Last Word — String parsing (150 XP)
25. Count and Say — StringBuilder + iteration (200 XP)
26. Roman to Integer — HashMap + conditional logic (200 XP)
27. Implement strStr() — Naive string matching (200 XP)
28. Group Anagrams — HashMap with sorted key (250 XP)
29. Longest Substring Without Repeating — Sliding window + HashSet (250 XP)
30. **BOSS: Minimum Window Substring** — Advanced sliding window (350 XP)

### Realm 4: Sorting Citadel (Medium)
31. Bubble Sort Implementation — From-scratch sort (150 XP)
32. Selection Sort — From-scratch sort (150 XP)
33. Insertion Sort — From-scratch sort (180 XP)
34. Merge Sort Implementation — Divide and conquer (250 XP)
35. Quick Sort Implementation — Partition + recursion (250 XP)
36. Binary Search — Classic search (150 XP)
37. First Bad Version — Binary search variant (180 XP)
38. Search Insert Position — Binary search variant (180 XP)
39. Sort Colors (Dutch National Flag) — Three-way partitioning (250 XP)
40. **BOSS: Kth Largest Element** — Quickselect algorithm (350 XP)

### Realm 5: Hash Marshlands (Medium)
41. Contains Duplicate — HashSet basics (120 XP)
42. Single Number — XOR / HashMap (150 XP)
43. Intersection of Two Arrays — HashSet (150 XP)
44. Happy Number — HashSet cycle detection (180 XP)
45. Isomorphic Strings — HashMap char mapping (180 XP)
46. Word Pattern — HashMap bijection check (200 XP)
47. First Unique Character — LinkedHashMap / frequency array (200 XP)
48. Frequency Sort — PriorityQueue / HashMap sort (250 XP)
49. Top K Frequent Elements — Heap + HashMap (250 XP)
50. **BOSS: Longest Consecutive Sequence** — HashSet + union-find thinking (350 XP)

### Realm 6: Linked List Labyrinth (Medium → Hard)
51. Reverse Linked List — Pointer manipulation (200 XP)
52. Merge Two Sorted Lists — Dummy node technique (200 XP)
53. Linked List Cycle — Floyd's tortoise and hare (250 XP)
54. Remove Nth Node From End — Two-pointer with offset (250 XP)
55. Palindrome Linked List — Stack + slow/fast pointer (250 XP)
56. Middle of Linked List — Slow/fast pointer (200 XP)
57. Delete Node in Linked List — Copy value trick (150 XP)
58. Intersection of Two Linked Lists — Length-difference technique (250 XP)
59. Copy List with Random Pointer — HashMap deep copy (300 XP)
60. **BOSS: Merge K Sorted Lists** — Divide and conquer + merge (400 XP)

### Realm 7: Tree Sanctuary (Hard)
61. Maximum Depth of Binary Tree — Recursion basics (200 XP)
62. Invert Binary Tree — Recursive swap (200 XP)
63. Symmetric Tree — Mirror recursion (250 XP)
64. Path Sum — DFS with target (250 XP)
65. Binary Tree Level Order Traversal — BFS / Queue (250 XP)
66. Validate Binary Search Tree — In-order traversal (300 XP)
67. Lowest Common Ancestor — Recursive DFS (300 XP)
68. Construct Binary Tree from Inorder + Postorder — Divide and conquer (350 XP)
69. Serialize and Deserialize Binary Tree — BFS/DFS encoding (350 XP)
70. **BOSS: Word Ladder (Graph BFS)** — Combined graph + BFS + HashSet (500 XP)

---

## Database Schema

```sql
-- Users
CREATE TABLE users (
    id              BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255) UNIQUE NOT NULL,
    username        VARCHAR(50) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    level           INT DEFAULT 1,
    xp              INT DEFAULT 0,
    hp              INT DEFAULT 100,
    streak          INT DEFAULT 0,
    last_solve_date DATE,
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Problems
CREATE TABLE problems (
    id              BIGSERIAL PRIMARY KEY,
    realm_id        INT NOT NULL,              -- 1-7
    slug            VARCHAR(100) UNIQUE NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,             -- Markdown
    difficulty      VARCHAR(20) NOT NULL,      -- EASY, MEDIUM, HARD, BOSS
    xp_reward       INT NOT NULL,
    order_in_realm  INT NOT NULL,
    starter_code    TEXT NOT NULL,             -- Java template
    solution_code   TEXT,                      -- Reference solution
    time_limit_ms   INT DEFAULT 2000,
    memory_limit_kb INT DEFAULT 256000,
    is_boss         BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Test cases
CREATE TABLE test_cases (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT REFERENCES problems(id),
    input           TEXT NOT NULL,
    expected_output  TEXT NOT NULL,
    is_hidden       BOOLEAN DEFAULT FALSE,
    order_num       INT DEFAULT 0
);

-- Hints (static, pre-authored per problem)
CREATE TABLE hints (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT REFERENCES problems(id),
    layer           INT NOT NULL,              -- 1-5 (1=Compass, 2=Map, 3=Blueprint, 4=Scaffold, 5=Sage)
    name            VARCHAR(50) NOT NULL,      -- "The Compass", "The Map", etc.
    icon            VARCHAR(10),              -- emoji
    content         TEXT NOT NULL,             -- Markdown hint content
    hp_cost         INT NOT NULL,
    order_num       INT NOT NULL,              -- same as layer for static hints
    UNIQUE(problem_id, layer)
);

-- Track which hints a user has unlocked per problem (static + dynamic)
CREATE TABLE hint_usage (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT REFERENCES users(id),
    problem_id      BIGINT REFERENCES problems(id),
    hint_layer      INT NOT NULL,              -- 1-5 for static, 0 for dynamic
    hint_type       VARCHAR(30) NOT NULL,      -- STATIC, DYNAMIC_COMPILE, DYNAMIC_WRONG, DYNAMIC_TLE, DYNAMIC_RUNTIME, PATTERN
    hp_cost         INT NOT NULL,
    content         TEXT NOT NULL,             -- The hint content that was shown
    unlocked_at     TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, problem_id, hint_layer, hint_type)
);

-- Track dynamic hint context (what the user's code looked like when they asked)
CREATE TABLE hint_context (
    id              BIGSERIAL PRIMARY KEY,
    hint_usage_id   BIGINT REFERENCES hint_usage(id),
    source_code     TEXT NOT NULL,             -- User's code at the time they asked
    submission_id   BIGINT REFERENCES submissions(id), -- The failed submission that triggered the dynamic hint
    failed_test_case_id BIGINT REFERENCES test_cases(id)
);

-- Problem patterns (for cross-problem pattern hints)
CREATE TABLE problem_patterns (
    id              BIGSERIAL PRIMARY KEY,
    problem_id      BIGINT REFERENCES problems(id),
    pattern_name    VARCHAR(100) NOT NULL      -- e.g. "Two-Pointer", "Hash Map", "Sliding Window"
);

-- Submissions
CREATE TABLE submissions (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT REFERENCES users(id),
    problem_id      BIGINT REFERENCES problems(id),
    source_code     TEXT NOT NULL,
    status          VARCHAR(50) NOT NULL,      -- ACCEPTED, WRONG_ANSWER, TIME_LIMIT, etc.
    execution_time_ms INT,
    memory_used_kb   INT,
    judge0_token    VARCHAR(100),
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Skill tree node unlock state
CREATE TABLE skill_tree_progress (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT REFERENCES users(id),
    problem_id      BIGINT REFERENCES problems(id),
    is_unlocked     BOOLEAN DEFAULT FALSE,
    is_completed    BOOLEAN DEFAULT FALSE,
    completed_at    TIMESTAMP,
    UNIQUE(user_id, problem_id)
);

-- Achievements
CREATE TABLE user_achievements (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT REFERENCES users(id),
    achievement_key VARCHAR(50) NOT NULL,
    unlocked_at     TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, achievement_key)
);
```

---

## API Design

### Auth
| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/auth/register` | Register new user (email, username, password) |
| POST | `/api/auth/login` | Login, returns JWT token |
| GET | `/api/auth/me` | Get current user profile + RPG stats |

### Problems
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/problems` | List all problems (with completion status for user) |
| GET | `/api/problems/{slug}` | Get problem details, starter code, hint state |
| GET | `/api/problems/{slug}/test-cases` | Get sample test cases (hidden ones excluded) |
| GET | `/api/problems/{slug}/hints` | Get all hints for problem (unlocked show content, locked show layer+cost) |
| GET | `/api/problems/{slug}/hints/state` | Hint state: layers unlocked, HP spent, dynamic availability |
| POST | `/api/problems/{slug}/hints/unlock` | Unlock next static hint layer. Body: `{ layer: int }`. Deducts HP. |
| POST | `/api/problems/{slug}/hints/dynamic` | Request dynamic code-aware hint. Analyzes last failed submission. 10 HP. |

### Submission
| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/submissions` | Submit code → runs on Judge0 → returns result |
| GET | `/api/submissions/{id}` | Get submission result |
| GET | `/api/submissions?problemId={id}` | User's submission history for a problem |

### RPG / Gamification
| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/progress/skill-tree` | Get skill tree state (all nodes, locked/unlocked/completed) |
| GET | `/api/progress/stats` | Get XP, level, HP, streak, rank, achievements |
| GET | `/api/progress/achievements` | List all achievements + unlocked status |

---

## UI/UX Design — "Extremely Pleasing"

### Design System
- **Theme:** Dark-first with a "fantasy RPG" aesthetic
- **Colors:**
  - Background: deep charcoal `#0a0a0f` with subtle purple tint
  - Surface: `#13131f` with `1px` border `rgba(139, 92, 246, 0.1)`
  - Primary: amethyst purple `#8b5cf6`
  - Accent: emerald `#10b981` (success), crimson `#ef4444` (wrong), amber `#f59e0b` (boss)
  - Text: `#e4e4e7` primary, `#71717a` muted
- **Typography:** Inter for UI, JetBrains Mono for code, Cinzel for headings (RPG feel)
- **Shadows:** Glowing purple shadows on hover for interactive elements
- **Borders:** Rounded-xl everywhere, subtle gradient borders on cards

### Key Pages

#### 1. Landing Page (`/`)
- Full-screen hero with animated particle background (constellation effect)
- "Begin Your Quest" CTA button with glowing pulse animation
- Feature cards with hover tilt + glow (shadcn Card + Framer Motion)
- RPG class selection mockup as the signup flow visual

#### 2. Skill Tree Map (`/quest`)
- **The centerpiece.** An interactive node-graph world map.
- Each realm is a "region" with a distinct color palette and icon.
- Nodes are circular icons — locked (dim, gray lock icon), unlocked (full color, pulsing border), completed (golden glow + checkmark).
- Boss nodes are larger, skull-shaped, red-auraed, with "LOCKED" overlay until all prereqs done.
- Connecting paths between nodes light up as you progress.
- Scrollable/zoomable canvas (like Path of Exile skill tree).
- Clicking a node opens a side panel with problem preview.

#### 3. Problem Workspace (`/quest/{slug}`)
- **Three-panel layout** (LeetCode-style but beautiful):
  - **Left panel:** Problem description with markdown rendering, difficulty badge, XP reward, and the Oracle's Guidance panel (5 progressive hint layers + dynamic code-aware hints + cross-problem pattern hints).
  - **Center panel:** Monaco Editor with Java syntax highlighting, custom theme matching the app's dark aesthetic.
  - **Right panel:** Test results, console output, submission history.
- **Bottom bar:** Run (sample tests) | Submit (full judge) | Reset | Reset HP (if stuck).
- On "Accepted": full-screen confetti + XP gain animation + level-up overlay if applicable.
- On "Wrong Answer": HP deduction animation (screen shake + red flash) + encouraging message.

#### 4. Character Profile (`/profile`)
- RPG character card with avatar, level, rank title, HP bar, XP bar.
- Stats grid: Total solved, Easy/Medium/Hard breakdown, Streak, Accuracy.
- Achievement badge grid (locked badges are silhouetted).
- Recent activity timeline.

#### 5. Leaderboard (`/leaderboard`)
- Ranked table with top 50 players.
- User's rank highlighted.
- Rank icons (crown for #1, etc.).

---

## Project Structure

```
myeetcode/
├── docker-compose.yml                  # postgres + judge0 + backend + frontend
├── frontend/                           # Next.js 14 app
│   ├── package.json
│   ├── next.config.ts
│   ├── tailwind.config.ts
│   ├── tsconfig.json
│   ├── src/
│   │   ├── app/
│   │   │   ├── layout.tsx              # Root layout with theme provider
│   │   │   ├── page.tsx                # Landing page
│   │   │   ├── quest/
│   │   │   │   ├── page.tsx            # Skill tree map
│   │   │   │   └── [slug]/
│   │   │   │       └── page.tsx        # Problem workspace
│   │   │   ├── profile/
│   │   │   │   └── page.tsx            # Character profile
│   │   │   ├── leaderboard/
│   │   │   │   └── page.tsx            # Leaderboard
│   │   │   └── auth/
│   │   │       ├── login/page.tsx
│   │   │       └── register/page.tsx
│   │   ├── components/
│   │   │   ├── ui/                     # shadcn/ui components
│   │   │   ├── skill-tree/
│   │   │   │   ├── skill-tree-map.tsx   # Interactive node graph
│   │   │   │   ├── skill-node.tsx       # Individual node
│   │   │   │   └── realm-connector.tsx  # SVG path connectors
│   │   │   ├── editor/
│   │   │   │   ├── code-editor.tsx      # Monaco wrapper
│   │   │   │   └── editor-theme.ts      # Custom Monaco theme
│   │   │   ├── problem/
│   │   │   │   ├── problem-panel.tsx
│   │   │   │   ├── test-results.tsx
│   │   │   │   ├── hint-card.tsx          # Individual static hint card (locked/unlocked)
│   │   │   │   ├── oracle-panel.tsx       # Full hint UI: static layers + dynamic + pattern hints
│   │   │   │   ├── dynamic-hint.tsx       # "Analyze My Failed Submission" button + result display
│   │   │   │   └── pattern-hint.tsx       # Cross-problem pattern hint card (free)
│   │   │   ├── rpg/
│   │   │   │   ├── xp-bar.tsx
│   │   │   │   ├── hp-bar.tsx
│   │   │   │   ├── level-up-overlay.tsx
│   │   │   │   └── achievement-toast.tsx
│   │   │   ├── layout/
│   │   │   │   ├── navbar.tsx
│   │   │   │   └── sidebar.tsx
│   │   │   └── shared/
│   │   │       ├── confetti-burst.tsx
│   │   │       ├── screen-shake.tsx
│   │   │       └── typewriter-text.tsx    # Typewriter animation for hint reveals
│   │   ├── lib/
│   │   │   ├── api.ts                  # API client (fetch wrapper)
│   │   │   ├── auth.ts                 # JWT storage / interceptors
│   │   │   ├── utils.ts                 # cn() and helpers
│   │   │   └── constants.ts            # XP tables, rank names, realm metadata
│   │   ├── hooks/
│   │   │   ├── use-submission.ts        # Submit code hook
│   │   │   ├── use-progress.ts          # RPG stats hook
│   │   │   ├── use-skill-tree.ts        # Skill tree state hook
│   │   │   └── use-hints.ts             # Hint state, unlock, and dynamic hint hook
│   │   ├── stores/
│   │   │   └── auth-store.ts           # Zustand auth state
│   │   └── styles/
│   │       └── globals.css             # Tailwind + custom CSS vars
│   └── public/
│       └── icons/                      # Realm icons, badge icons
│
├── backend/                            # Spring Boot 3
│   ├── build.gradle.kts
│   ├── settings.gradle.kts
│   ├── src/main/java/com/mycodequest/
│   │   ├── MyCodeQuestApplication.java
│   │   ├── config/
│   │   │   ├── SecurityConfig.java      # JWT security filter chain
│   │   │   ├── JwtConfig.java
│   │   │   └── CorsConfig.java
│   │   ├── controller/
│   │   │   ├── AuthController.java
│   │   │   ├── ProblemController.java
│   │   │   ├── SubmissionController.java
│   │   │   └── ProgressController.java
│   │   ├── service/
│   │   │   ├── AuthService.java
│   │   │   ├── ProblemService.java
│   │   │   ├── SubmissionService.java   # Calls Judge0
│   │   │   ├── Judge0Client.java        # HTTP client to Judge0 API
│   │   │   ├── ProgressService.java     # XP, level, HP, streak logic
│   │   │   ├── SkillTreeService.java    # Unlock/completion logic
│   │   │   ├── AchievementService.java  # Badge unlock logic
│   │   │   ├── HintEngine.java          # Dynamic code-aware hint generation (compile errors, wrong answers, TLE, runtime)
│   │   │   ├── HintService.java         # Static hint unlock + state tracking + pattern hints
│   │   │   └── PatternMatcher.java       # Cross-problem pattern matching for pattern hints
│   │   ├── dto/
│   │   │   ├── auth/                    # LoginRequest, RegisterRequest, AuthResponse
│   │   │   ├── problem/                 # ProblemDto, TestCaseDto, HintDto, HintStateDto, DynamicHintDto, PatternHintDto
│   │   │   ├── submission/              # SubmitRequest, SubmissionResultDto
│   │   │   └── progress/                # SkillTreeDto, StatsDto, AchievementDto
│   │   ├── entity/
│   │   │   ├── User.java
│   │   │   ├── Problem.java
│   │   │   ├── TestCase.java
│   │   │   ├── Hint.java
│   │   │   ├── HintUsage.java
│   │   │   ├── HintContext.java
│   │   │   ├── ProblemPattern.java
│   │   │   ├── Submission.java
│   │   │   ├── SkillTreeProgress.java
│   │   │   └── UserAchievement.java
│   │   ├── repository/
│   │   │   ├── UserRepository.java
│   │   │   ├── ProblemRepository.java
│   │   │   ├── TestCaseRepository.java
│   │   │   ├── HintRepository.java
│   │   │   ├── HintUsageRepository.java
│   │   │   ├── ProblemPatternRepository.java
│   │   │   ├── SubmissionRepository.java
│   │   │   ├── SkillTreeProgressRepository.java
│   │   │   └── UserAchievementRepository.java
│   │   ├── security/
│   │   │   ├── JwtTokenProvider.java
│   │   │   ├── JwtAuthFilter.java
│   │   │   └── UserDetailsServiceImpl.java
│   │   └── exception/
│   │       ├── GlobalExceptionHandler.java
│   │       ├── AuthException.java
│   │       └── SubmissionException.java
│   ├── src/main/resources/
│   │   ├── application.yml
│   │   ├── application-dev.yml
│   │   └── db/migration/
│   │       ├── V1__init_schema.sql      # Flyway migration
│   │       └── V2__seed_problems.sql     # All 70 problems + test cases
│   └── src/test/java/com/mycodequest/
│       ├── service/
│       │   ├── ProgressServiceTest.java
│       │   ├── SubmissionServiceTest.java
│       │   └── AchievementServiceTest.java
│       └── controller/
│           ├── AuthControllerTest.java
│           └── ProblemControllerTest.java
│
└── judge0/                             # Judge0 CE config
    └── docker-compose.judge0.yml       # Judge0 server + workers
```

---

## Step-by-Step Implementation Plan

### Phase 1: Infrastructure & Setup (Tasks 1-5)

### Task 1: Initialize Docker Compose + Project Scaffolding

**Objective:** Set up the monorepo with Docker Compose for all services.

**Files:**
- Create: `docker-compose.yml`
- Create: `frontend/` (Next.js init)
- Create: `backend/` (Spring Boot init via Spring Initializr)
- Create: `judge0/docker-compose.judge0.yml`
- Create: `.gitignore`
- Create: `README.md`

**Steps:**

1. Create `docker-compose.yml`:
```yaml
version: '3.8'
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: mycodequest
      POSTGRES_USER: quest
      POSTGRES_PASSWORD: questpass
    ports: ['5432:5432']
    volumes: ['pgdata:/var/lib/postgresql/data']

  backend:
    build: ./backend
    environment:
      SPRING_PROFILES_ACTIVE: dev
      DB_URL: jdbc:postgresql://postgres:5432/mycodequest
      DB_USER: quest
      DB_PASS: questpass
      JUDGE0_URL: http://judge0-server:2358
      JWT_SECRET: dev-secret-change-in-prod
    ports: ['8080:8080']
    depends_on: [postgres, judge0-server]

  frontend:
    build: ./frontend
    ports: ['3000:3000']
    environment:
      NEXT_PUBLIC_API_URL: http://localhost:8080/api
    depends_on: [backend]

  judge0-server:
    image: judge0/judge0-server:1.13.1
    environment:
      REDIS_URL: redis://judge0-redis:6379
      POSTGRES_HOST: judge0-postgres
      POSTGRES_USER: judge0
      POSTGRES_PASSWORD: judge0pass
      POSTGRES_DB: judge0
    ports: ['2358:2358']
    depends_on: [judge0-redis, judge0-postgres]

  judge0-redis:
    image: redis:7-alpine

  judge0-postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: judge0
      POSTGRES_USER: judge0
      POSTGRES_PASSWORD: judge0pass

volumes:
  pgdata:
```

2. Initialize Next.js frontend:
```bash
npx create-next-app@latest frontend --typescript --tailwind --app --src-dir --eslint --use-npm
cd frontend
npm install @monaco-editor/react framer-motion zustand @tanstack/react-query
npx shadcn@latest init
```

3. Initialize Spring Boot backend (via Spring Initializr or Gradle init):
```bash
# Use start.spring.io or manual setup
# Dependencies: spring-boot-starter-web, spring-boot-starter-data-jpa,
# spring-boot-starter-security, spring-boot-starter-validation,
# postgresql, flyway-core, jjwt (manual)
```

4. Create `.gitignore`:
```gitignore
node_modules/
.next/
build/
.gradle/
*.env
.idea/
.vscode/
```

5. Verify: `docker-compose config` validates without errors.

---

### Task 2: Spring Boot — Database Schema & Flyway Migrations

**Objective:** Create the database schema with Flyway migrations including all 70 problems seeded.

**Files:**
- Create: `backend/src/main/resources/db/migration/V1__init_schema.sql`
- Create: `backend/src/main/resources/db/migration/V2__seed_problems.sql`
- Create: `backend/src/main/resources/application.yml`

**Steps:**

1. Write `V1__init_schema.sql` — the full schema from the Database Schema section above (users, problems, test_cases, hints, submissions, skill_tree_progress, user_achievements).

2. Write `V2__seed_problems.sql` — INSERT all 70 problems with titles, descriptions (markdown), difficulties, XP rewards, realm_id, order_in_realm, starter_code (Java templates), and is_boss flags. Include test cases for each problem.

Example problem seed:
```sql
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss)
VALUES (1, 'hello-java', 'Hello, Java!', '# Hello, Java!\n\nWrite a program that prints "Hello, World!" to stdout.', 'EASY', 50, 1,
'public class Solution {\n    public static void main(String[] args) {\n        // Your code here\n    }\n}',
'public class Solution {\n    public static void main(String[] args) {\n        System.out.println("Hello, World!");\n    }\n}',
false);
```

3. Write `application.yml`:
```yaml
spring:
  datasource:
    url: ${DB_URL:jdbc:postgresql://localhost:5432/mycodequest}
    username: ${DB_USER:quest}
    password: ${DB_PASS:questpass}
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
  flyway:
    enabled: true
    locations: classpath:db/migration
judge0:
  url: ${JUDGE0_URL:http://localhost:2358}
jwt:
  secret: ${JWT_SECRET:dev-secret-change-in-prod}
  expiration-ms: 86400000
```

4. Verify: Start postgres + backend, confirm Flyway runs migrations and tables exist.

---

### Task 3: Spring Boot — JPA Entities & Repositories

**Objective:** Create all JPA entities and Spring Data repositories.

**Files:**
- Create: `backend/.../entity/User.java`
- Create: `backend/.../entity/Problem.java`
- Create: `backend/.../entity/TestCase.java`
- Create: `backend/.../entity/Hint.java`
- Create: `backend/.../entity/Submission.java`
- Create: `backend/.../entity/SkillTreeProgress.java`
- Create: `backend/.../entity/UserAchievement.java`
- Create: All repository interfaces

**Steps:**

1. Create `User.java` entity:
```java
@Entity @Table(name = "users")
public class User {
    @Id @GeneratedValue(strategy = IDENTITY)
    private Long id;
    @Column(unique = true, nullable = false)
    private String email;
    @Column(unique = true, nullable = false)
    private String username;
    @Column(name = "password_hash", nullable = false)
    private String passwordHash;
    private Integer level = 1;
    private Integer xp = 0;
    private Integer hp = 100;
    private Integer streak = 0;
    @Column(name = "last_solve_date")
    private LocalDate lastSolveDate;
    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();
    // getters/setters
}
```

2. Create `Problem.java`, `TestCase.java`, `Hint.java`, `Submission.java`, `SkillTreeProgress.java`, `UserAchievement.java` — mirror the DB schema with proper JPA annotations, `@ManyToOne` / `@OneToMany` relationships.

3. Create repository interfaces:
```java
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);
    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
}

public interface ProblemRepository extends JpaRepository<Problem, Long> {
    Optional<Problem> findBySlug(String slug);
    List<Problem> findByRealmIdOrderByOrderInRealm(int realmId);
}

public interface TestCaseRepository extends JpaRepository<TestCase, Long> {
    List<TestCase> findByProblemIdOrderByOrderNum(Long problemId);
    List<TestCase> findByProblemIdAndIsHiddenFalseOrderByOrderNum(Long problemId);
}

public interface SubmissionRepository extends JpaRepository<Submission, Long> {
    Page<Submission> findByUserIdAndProblemIdOrderByCreatedAtDesc(Long userId, Long problemId, Pageable pageable);
    long countByUserIdAndStatus(Long userId, String status);
}

public interface SkillTreeProgressRepository extends JpaRepository<SkillTreeProgress, Long> {
    List<SkillTreeProgress> findByUserId(Long userId);
    Optional<SkillTreeProgress> findByUserIdAndProblemId(Long userId, Long problemId);
}

public interface UserAchievementRepository extends JpaRepository<UserAchievement, Long> {
    List<UserAchievement> findByUserId(Long userId);
    boolean existsByUserIdAndAchievementKey(Long userId, String key);
}
```

4. Verify: `./gradlew build` compiles without errors.

---

### Task 4: Spring Boot — JWT Security & Auth Endpoints

**Objective:** Implement JWT authentication with register/login endpoints.

**Files:**
- Create: `backend/.../security/JwtTokenProvider.java`
- Create: `backend/.../security/JwtAuthFilter.java`
- Create: `backend/.../security/UserDetailsServiceImpl.java`
- Create: `backend/.../config/SecurityConfig.java`
- Create: `backend/.../config/CorsConfig.java`
- Create: `backend/.../controller/AuthController.java`
- Create: `backend/.../service/AuthService.java`
- Create: `backend/.../dto/auth/LoginRequest.java`
- Create: `backend/.../dto/auth/RegisterRequest.java`
- Create: `backend/.../dto/auth/AuthResponse.java`
- Create: `backend/.../exception/GlobalExceptionHandler.java`

**Steps:**

1. Create `JwtTokenProvider.java` — generate and validate JWT tokens using `io.jsonwebtoken` (jjwt):
```java
@Component
public class JwtTokenProvider {
    @Value("${jwt.secret}")
    private String secret;
    @Value("${jwt.expiration-ms}")
    private long expirationMs;

    public String generate(Long userId, String username) {
        return Jwts.builder()
            .subject(String.valueOf(userId))
            .claim("username", username)
            .issuedAt(new Date())
            .expiration(new Date(System.currentTimeMillis() + expirationMs))
            .signWith(Keys.hmacShaKeyFor(secret.getBytes()))
            .compact();
    }

    public Claims parse(String token) {
        return Jwts.parser()
            .verifyWith(Keys.hmacShaKeyFor(secret.getBytes()))
            .build()
            .parseSignedClaims(token)
            .getPayload();
    }
}
```

2. Create `JwtAuthFilter.java` — extract JWT from `Authorization: Bearer <token>`, validate, set `SecurityContext`.

3. Create `SecurityConfig.java`:
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http, JwtAuthFilter jwtFilter) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .sessionManagement(s -> s.sessionCreationPolicy(STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/register", "/api/auth/login").permitAll()
                .requestMatchers("/api/**").authenticated()
                .anyRequest().permitAll())
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
    @Bean
    PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
}
```

4. Create `AuthController.java`:
```java
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    // POST /register → AuthService.register() → AuthResponse (JWT + user stats)
    // POST /login → AuthService.login() → AuthResponse
    // GET /me → returns current user's RPG stats
}
```

5. Create `AuthService.java` — register (hash password, create user, init skill tree progress for realm 1, generate JWT), login (verify password, generate JWT).

6. Create `GlobalExceptionHandler.java` — `@RestControllerAdvice` handling all exceptions with consistent JSON error format.

7. Verify: `./gradlew test` passes. Manual test: POST to `/api/auth/register` creates a user and returns JWT.

---

### Task 5: Spring Boot — Problem & Test Case Endpoints

**Objective:** Create endpoints to list problems, get problem details, and retrieve test cases.

**Files:**
- Create: `backend/.../controller/ProblemController.java`
- Create: `backend/.../service/ProblemService.java`
- Create: `backend/.../dto/problem/ProblemDto.java`
- Create: `backend/.../dto/problem/ProblemDetailDto.java`
- Create: `backend/.../dto/problem/TestCaseDto.java`
- Create: `backend/.../dto/problem/HintDto.java`

**Steps:**

1. Create DTOs:
```java
public record ProblemDto(Long id, int realmId, String slug, String title,
    String difficulty, int xpReward, int orderInRealm, boolean isBoss,
    boolean completed, boolean unlocked) {}

public record ProblemDetailDto(Long id, int realmId, String slug, String title,
    String description, String difficulty, int xpReward, String starterCode,
    List<TestCaseDto> sampleTests, List<HintDto> hints, boolean isBoss,
    int timeLimitMs, int memoryLimitKb) {}

public record TestCaseDto(String input, String expectedOutput, boolean isHidden) {}

public record HintDto(int layer, String name, String icon, String content, int hpCost, boolean unlocked, String hintType) {}

public record HintStateDto(
    List<HintDto> staticHints,       // 5 layers (content null if locked)
    boolean dynamicAvailable,        // true if user has ≥1 failed submission for this problem
    String lastFailureType,          // COMPILE_ERROR, WRONG_ANSWER, etc. (null if no failed submission)
    int totalHpSpentOnHints,
    int hintsUnlockedCount,
    List<PatternHintDto> patternHints // Cross-problem pattern hints (free, no HP cost)
) {}

public record DynamicHintDto(
    String hintType,       // DYNAMIC_COMPILE, DYNAMIC_WRONG, DYNAMIC_TLE, DYNAMIC_RUNTIME
    String content,        // The generated hint text
    Integer lineNumber,    // Likely line number of issue (null if N/A)
    String exceptionType,  // Java exception name (null if not a runtime error)
    int hpCost
) {}

public record PatternHintDto(
    String patternName,         // "Two-Pointer", "Hash Map", etc.
    String relatedProblemSlug,  // Problem the user already solved with this pattern
    String relatedProblemTitle
) {}
```

2. Create `ProblemService.java`:
- `getAllProblems(userId)` — returns all problems with user's completion/unlock status
- `getProblem(slug, userId)` — returns full problem detail with sample test cases
- `getTestCases(problemId, userId)` — sample (non-hidden) test cases only

3. Create `ProblemController.java`:
```java
@RestController
@RequestMapping("/api/problems")
public class ProblemController {
    @GetMapping
    ResponseEntity<List<ProblemDto>> getAllProblems(@AuthenticationPrincipal User user);

    @GetMapping("/{slug}")
    ResponseEntity<ProblemDetailDto> getProblem(@PathVariable String slug, @AuthenticationPrincipal User user);

    @GetMapping("/{slug}/test-cases")
    ResponseEntity<List<TestCaseDto>> getTestCases(@PathVariable String slug, @AuthenticationPrincipal User user);
}
```

4. Verify: GET `/api/problems` with JWT returns list of 70 problems. GET `/api/problems/hello-java` returns problem detail with starter code.

---

### Phase 2: Code Execution & Submission (Tasks 6-8)

### Task 6: Spring Boot — Judge0 Client Integration

**Objective:** Create the HTTP client that submits code to Judge0 CE and polls for results.

**Files:**
- Create: `backend/.../service/Judge0Client.java`
- Create: `backend/.../dto/submission/Judge0Request.java`
- Create: `backend/.../dto/submission/Judge0Response.java`

**Steps:**

1. Create `Judge0Client.java`:
```java
@Service
public class Judge0Client {
    private final RestClient client; // Spring 6.1 HTTP client
    @Value("${judge0.url}")
    private String judge0Url;

    // Submit code to Judge0
    // POST {judge0Url}/submissions?base64_encoded=false
    // Body: { "source_code": "...", "language_id": 62, "stdin": "...", "expected_output": "...",
    //         "cpu_time_limit": 2, "memory_limit": 256000 }
    // Returns token

    // Poll for result
    // GET {judge0Url}/submissions/{token}?base64_encoded=false
    // Returns: { stdout, stderr, status: { id, description }, time, memory, compile_output }

    public String submit(String sourceCode, String stdin, String expectedOutput, double timeLimit, int memoryLimit) {
        Map<String, Object> body = Map.of(
            "source_code", sourceCode,
            "language_id", 62,  // Java (OpenJDK 13.0.1)
            "stdin", stdin,
            "expected_output", expectedOutput,
            "cpu_time_limit", timeLimit,
            "memory_limit", memoryLimit
        );
        // POST and extract token
    }

    public Judge0Response poll(String token) {
        // GET submission by token, return parsed response
    }
}
```

2. Create `Judge0Request.java` and `Judge0Response.java` DTOs matching the Judge0 API format. Key fields in response: `status.id` (3 = Accepted, 4 = Wrong Answer, 5 = Time Limit Exceeded, 6 = Compilation Error), `stdout`, `stderr`, `compile_output`, `time`, `memory`.

3. Verify: Submit a simple "Hello, World!" Java program via the client. Confirm Judge0 returns status 3 (Accepted) with stdout "Hello, World!".

---

### Task 7: Spring Boot — Submission Service (Multi-Test-Case Runner)

**Objective:** Run user code against all test cases for a problem and determine pass/fail. Award XP, update skill tree, check achievements.

**Files:**
- Create: `backend/.../service/SubmissionService.java`
- Create: `backend/.../controller/SubmissionController.java`
- Create: `backend/.../dto/submission/SubmitRequest.java`
- Create: `backend/.../dto/submission/SubmissionResultDto.java`

**Steps:**

1. Create `SubmitRequest.java`:
```java
public record SubmitRequest(String slug, String sourceCode, boolean runSampleOnly) {}
```

2. Create `SubmissionResultDto.java`:
```java
public record SubmissionResultDto(
    String status,               // ACCEPTED, WRONG_ANSWER, TIME_LIMIT, COMPILE_ERROR, etc.
    int passedCount,
    int totalCount,
    List<TestCaseResultDto> results,
    int xpGained,                // 0 if failed, XP reward if all passed
    int newTotalXp,
    int newLevel,
    boolean leveledUp,
    int hpRemaining,
    List<String> newAchievements,
    boolean bossDefeated
) {}
public record TestCaseResultDto(int caseNum, String status, String input, String expectedOutput, String actualOutput, int timeMs, int memoryKb) {}
```

3. Create `SubmissionService.java`:
```java
@Service
public class SubmissionService {
    // submit(userId, SubmitRequest):
    // 1. Fetch problem by slug
    // 2. Fetch test cases (sample only if runSampleOnly, all if submit)
    // 3. For each test case: call Judge0Client.submit(sourceCode, input, expectedOutput, timeLimit, memoryLimit)
    // 4. Poll all tokens until all complete (parallel with timeout)
    // 5. Collect results: compare stdout to expected_output (trimmed)
    // 6. If ALL passed AND !runSampleOnly:
    //    a. Award XP (with streak multiplier)
    //    b. Update skill_tree_progress → completed=true
    //    c. Check + unlock next nodes in skill tree
    //    d. Update user streak + lastSolveDate
    //    e. Check achievements (firstBlood, comboMaster, etc.)
    //    f. Check level-up
    // 7. If any failed AND !runSampleOnly:
    //    a. Deduct HP (-10 per wrong submission)
    // 8. Save submission record
    // 9. Return SubmissionResultDto
}
```

4. Create `SubmissionController.java`:
```java
@RestController
@RequestMapping("/api/submissions")
public class SubmissionController {
    @PostMapping
    ResponseEntity<SubmissionResultDto> submit(@RequestBody SubmitRequest req, @AuthenticationPrincipal User user);

    @GetMapping("/{id}")
    ResponseEntity<SubmissionResultDto> getSubmission(@PathVariable Long id, @AuthenticationPrincipal User user);

    @GetMapping
    ResponseEntity<Page<SubmissionDto>> getHistory(@RequestParam Long problemId, @AuthenticationPrincipal User user, Pageable pageable);
}
```

5. Verify: Submit correct Java code for "hello-java" problem → status ACCEPTED, XP gained, skill tree updated. Submit wrong code → status WRONG_ANSWER, HP deducted.

---

### Task 8: Spring Boot — RPG Progress Engine (Skill Tree, XP, Achievements)

**Objective:** Implement the full RPG progression logic — leveling, skill tree unlocking, achievements, streaks.

**Files:**
- Create: `backend/.../service/ProgressService.java`
- Create: `backend/.../service/SkillTreeService.java`
- Create: `backend/.../service/AchievementService.java`
- Create: `backend/.../controller/ProgressController.java`
- Create: `backend/.../dto/progress/StatsDto.java`
- Create: `backend/.../dto/progress/SkillTreeDto.java`
- Create: `backend/.../dto/progress/SkillNodeDto.java`
- Create: `backend/.../dto/progress/AchievementDto.java`

**Steps:**

1. Create `ProgressService.java` — XP curve, level calculation, streak multiplier:
```java
@Service
public class ProgressService {
    // XP needed for level N: 100 * N * (N-1) / 2 + 100*N
    // Level 1→2: 200 XP, Level 2→3: 500 XP, etc. (quadratic curve)
    public int xpForLevel(int level) { return 100 * level * level; }
    public int levelFromXp(int totalXp) { /* solve quadratic */ }

    public int applyXp(User user, int baseXp) {
        int multiplier = getStreakMultiplier(user.getStreak());
        int gained = baseXp * multiplier;
        int oldLevel = user.getLevel();
        user.setXp(user.getXp() + gained);
        user.setLevel(levelFromXp(user.getXp()));
        return gained;
    }

    private int getStreakMultiplier(int streak) {
        if (streak >= 30) return 2;
        if (streak >= 7) return 1.5;
        return 1;
    }

    public void updateStreak(User user) {
        LocalDate today = LocalDate.now();
        if (user.getLastSolveDate() == null || user.getLastSolveDate().isBefore(today.minusDays(1))) {
            user.setStreak(1);
        } else if (user.getLastSolveDate().equals(today.minusDays(1))) {
            user.setStreak(user.getStreak() + 1);
        }
        user.setLastSolveDate(today);
    }
}
```

2. Create `SkillTreeService.java` — unlock logic:
```java
@Service
public class SkillTreeService {
    // Realm 1: all nodes unlocked from start (except boss)
    // Node N unlocks when node N-1 is completed
    // Boss node unlocks when ALL non-boss nodes in the realm are completed
    // Completing a boss in realm R unlocks realm R+1's first node

    public void onProblemCompleted(Long userId, Long problemId) {
        // Mark completed, unlock next node in same realm
        // If boss completed → unlock first node of next realm
        // If first completion of realm 1 node 1 → unlock all realm 1 nodes (handled at registration)
    }

    public List<SkillNodeDto> getSkillTree(Long userId) {
        // Return all 70 nodes with lock/unlock/complete status
    }
}
```

3. Create `AchievementService.java`:
```java
@Service
public class AchievementService {
    // Check and award achievements after each submission:
    // FIRST_BLOOD: first ever accepted submission
    // COMBO_MASTER: 5 consecutive accepted submissions (no failures in between)
    // SPEED_DEMON: medium problem accepted within 5 minutes of first submission for that problem
    // UNTOUCHABLE: hard problem accepted with 0 prior wrong submissions
    // NO_HINT_NO_PROBLEM: medium/hard accepted with 0 hints unlocked for that problem (check hint_usage table)
    // REALM_CONQUEROR: all non-boss + boss in a realm completed
    // STREAK_30: 30-day streak reached
    // SAGE: level 50 reached
}
```

4. Create `ProgressController.java`:
```java
@RestController
@RequestMapping("/api/progress")
public class ProgressController {
    @GetMapping("/skill-tree")
    ResponseEntity<SkillTreeDto> getSkillTree(@AuthenticationPrincipal User user);

    @GetMapping("/stats")
    ResponseEntity<StatsDto> getStats(@AuthenticationPrincipal User user);

    @GetMapping("/achievements")
    ResponseEntity<List<AchievementDto>> getAchievements(@AuthenticationPrincipal User user);

    @PostMapping("/hints/{problemId}")
    ResponseEntity<HintResultDto> unlockHint(@PathVariable Long problemId, @AuthenticationPrincipal User user);
    // Deducts HP, returns hint content
}
```

5. Verify: After completing a problem, skill tree updates next node to unlocked. XP gains are correct. Achievements trigger properly.

---

### Phase 2b: Intelligent Hinting System (Task 8b)

### Task 8b: Spring Boot — HintEngine, HintService & Hint Endpoints

**Objective:** Build the full intelligent hinting system — dynamic code-aware hint generation engine, static hint layer management, pattern hints, and all hint API endpoints.

**Files:**
- Create: `backend/.../service/HintEngine.java`
- Create: `backend/.../service/HintService.java`
- Create: `backend/.../service/PatternMatcher.java`
- Create: `backend/.../controller/HintController.java`
- Create: `backend/.../entity/HintUsage.java`
- Create: `backend/.../entity/HintContext.java`
- Create: `backend/.../entity/ProblemPattern.java`
- Create: `backend/.../repository/HintRepository.java`
- Create: `backend/.../repository/HintUsageRepository.java`
- Create: `backend/.../repository/ProblemPatternRepository.java`
- Create: `backend/.../dto/problem/HintStateDto.java`
- Create: `backend/.../dto/problem/DynamicHintDto.java`
- Create: `backend/.../dto/problem/PatternHintDto.java`
- Create: `backend/src/main/resources/db/migration/V5__seed_hints.sql`
- Create: `backend/src/main/resources/db/migration/V6__seed_problem_patterns.sql`
- Test: `backend/src/test/java/com/mycodequest/service/HintEngineTest.java`
- Test: `backend/src/test/java/com/mycodequest/service/HintServiceTest.java`

**Step 1: Create entities**

Create `HintUsage.java`:
```java
@Entity @Table(name = "hint_usage")
public class HintUsage {
    @Id @GeneratedValue(strategy = IDENTITY)
    private Long id;
    @Column(name = "user_id") private Long userId;
    @Column(name = "problem_id") private Long problemId;
    @Column(name = "hint_layer") private Integer hintLayer;     // 1-5 for static, 0 for dynamic
    @Column(name = "hint_type") private String hintType;        // STATIC, DYNAMIC_COMPILE, etc.
    @Column(name = "hp_cost") private Integer hpCost;
    @Column(name = "content") private String content;
    @Column(name = "unlocked_at") private LocalDateTime unlockedAt = LocalDateTime.now();
}
```

Create `HintContext.java`, `ProblemPattern.java` — mirror the DB schema with JPA annotations.

**Step 2: Create repositories**

```java
public interface HintRepository extends JpaRepository<Hint, Long> {
    List<Hint> findByProblemIdOrderByLayer(Long problemId);
    Optional<Hint> findByProblemIdAndLayer(Long problemId, int layer);
}

public interface HintUsageRepository extends JpaRepository<HintUsage, Long> {
    List<HintUsage> findByUserIdAndProblemId(Long userId, Long problemId);
    boolean existsByUserIdAndProblemIdAndHintType(Long userId, Long problemId, String hintType);
    int countByUserIdAndProblemId(Long userId, Long problemId);
    @Query("SELECT SUM(h.hpCost) FROM HintUsage h WHERE h.userId = :userId AND h.problemId = :problemId")
    Integer sumHpCostByUserIdAndProblemId(@Param("userId") Long userId, @Param("problemId") Long problemId);
}

public interface ProblemPatternRepository extends JpaRepository<ProblemPattern, Long> {
    List<ProblemPattern> findByProblemId(Long problemId);
    @Query("SELECT pp FROM ProblemPattern pp WHERE pp.patternName IN " +
           "(SELECT pp2.patternName FROM ProblemPattern pp2 " +
           "WHERE pp2.problemId IN " +
           "(SELECT s.problemId FROM Submission s WHERE s.userId = :userId AND s.status = 'ACCEPTED')) " +
           "AND pp.problemId = :currentProblemId")
    List<ProblemPattern> findMatchingPatternsForUser(@Param("userId") Long userId, @Param("currentProblemId") Long currentProblemId);
}
```

**Step 3: Create HintEngine.java — the dynamic hint generation engine**

```java
@Service
public class HintEngine {

    /**
     * Analyzes a failed submission and generates a targeted, code-aware hint.
     * Rule-based — no AI needed, deterministic and fast.
     */
    public DynamicHintDto generateHint(Submission failed, Problem problem, List<TestCase> failedCases) {
        return switch (SubmissionStatus.from(failed.getStatus())) {
            case COMPILE_ERROR      -> compileErrorHint(failed.getCompileOutput());
            case WRONG_ANSWER       -> wrongAnswerHint(failed, failedCases, problem);
            case TIME_LIMIT_EXCEEDED -> tleHint(problem);
            case RUNTIME_ERROR       -> runtimeErrorHint(failed.getStderr());
            default                  -> new DynamicHintDto("DYNAMIC_UNKNOWN",
                "Unexpected status. Try resetting your code and starting fresh.", null, null, 10);
        };
    }

    // --- Compile Error Translation ---
    // Uses the Java Compiler Error Translation Table (in the design section above)
    // Parses the compile_output string for known error patterns:
    private DynamicHintDto compileErrorHint(String compileOutput) {
        if (compileOutput == null || compileOutput.isBlank())
            return new DynamicHintDto("DYNAMIC_COMPILE",
                "Your code failed to compile, but no specific error was captured. Check your syntax — especially braces, semicolons, and method signatures.",
                null, null, 10);

        // Pattern-match against the translation table
        Map<String, String> errorTranslations = Map.ofEntries(
            Map.entry("cannot find symbol",
                "You're using a variable, method, or class name that Java doesn't recognize. Check: (1) is it spelled correctly? (2) is it declared before you use it? (3) is it in scope?"),
            Map.entry("incompatible types",
                "Type mismatch — you're trying to use a value of one type where another is expected. Check your variable types and any casts."),
            Map.entry("';' expected",
                "Missing semicolon. Java requires a ; at the end of each statement. Look at the line just before the error."),
            Map.entry("class, interface, or enum expected",
                "Java found something unexpected at the class level. You might have code outside a class, or mismatched braces."),
            Map.entry("illegal start of expression",
                "Syntax error — Java doesn't understand this expression. Check for misplaced operators, missing parentheses, or stray characters."),
            Map.entry("unclosed string literal",
                "You opened a string with a quote (\") but didn't close it. Check that every \" has a matching closing \"."),
            Map.entry("variable might not have been initialized",
                "You're using a variable before assigning it a value. Initialize it first, e.g., `int x = 0;` instead of just `int x;`."),
            Map.entry("method .* cannot be applied to given types",
                "The arguments you're passing to this method don't match its parameters. Check the method signature — are the types and count correct?"),
            Map.entry("possible loss of precision",
                "You're assigning a larger type (like double) to a smaller type (like int). Add an explicit cast: `(int)value`."),
            Map.entry("unreachable statement",
                "Code after a return or break statement will never execute. Remove the unreachable code or fix your control flow."),
            Map.entry("'}' expected",
                "Missing closing brace. You opened a block with { but didn't close it with }. Count your braces."),
            Map.entry("array required, but",
                "You're using array index notation [ ] on something that isn't an array. Check the variable type."),
            Map.entry("bad operand types for operator",
                "The operator doesn't work with the types you're using. Check the types on both sides.")
        );

        // Extract line number from compiler output (format: "Solution.java:LINE: error: ...")
        Integer lineNumber = extractLineNumber(compileOutput);

        for (Map.Entry<String, String> entry : errorTranslations.entrySet()) {
            if (compileOutput.toLowerCase().contains(entry.getKey().toLowerCase())) {
                String hint = entry.getValue();
                if (lineNumber != null)
                    hint += " (This error appears to be around line " + lineNumber + ".)";
                return new DynamicHintDto("DYNAMIC_COMPILE", hint, lineNumber, null, 10);
            }
        }

        // Unknown compile error — return the raw output with a generic nudge
        String truncated = compileOutput.length() > 300 ? compileOutput.substring(0, 300) + "..." : compileOutput;
        return new DynamicHintDto("DYNAMIC_COMPILE",
            "Your code failed to compile. Here's the compiler message:\n\n" + truncated + "\n\nRead the error carefully — it usually tells you the line number and what's wrong.",
            lineNumber, null, 10);
    }

    private Integer extractLineNumber(String output) {
        // Match patterns like "Solution.java:5:" or ":5: error"
        Pattern p = Pattern.compile("Solution\\.java:(\\d+):");
        Matcher m = p.matcher(output);
        return m.find() ? Integer.parseInt(m.group(1)) : null;
    }

    // --- Wrong Answer Edge Case Analysis ---
    // Uses the Edge Case Analysis Table (in the design section above)
    private DynamicHintDto wrongAnswerHint(Submission sub, List<TestCase> failedCases, Problem problem) {
        if (failedCases.isEmpty())
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code produced the wrong output for at least one test case. Review the expected vs actual output carefully.", null, null, 10);

        TestCase firstFailure = failedCases.get(0);
        String input = firstFailure.getInput();
        String expected = firstFailure.getExpectedOutput();
        String actual = sub.getStdout();

        // Edge case detection
        if (input == null || input.trim().isEmpty())
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code fails on EMPTY input. What does your code do when there's nothing to process? Add a guard clause at the start.", null, null, 10);

        if (input.lines().count() == 1 && input.trim().split("\\s+").length == 1)
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Single-element edge case. When the input has just one element, your loop might not execute at all. Check your loop bounds.", null, null, 10);

        if (input.contains("-"))
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code doesn't handle NEGATIVE values correctly. Review your comparison operators and initial values — are you initializing with 0 when you should use Integer.MIN_VALUE?", null, null, 10);

        if (actual != null && actual.trim().isEmpty() && expected != null && !expected.trim().isEmpty())
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code produced NO OUTPUT for this test case. Is your main method reaching the print statements? Check if your code is exiting early or throwing a silent exception.", null, null, 10);

        if (actual != null && expected != null && actual.trim().equalsIgnoreCase(expected.trim()) && !actual.equals(expected))
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your output differs only in LETTER CASE. Check if you need toUpperCase() or toLowerCase() on your result.", null, null, 10);

        if (actual != null && expected != null && actual.trim().equals(expected.trim()) && !actual.equals(expected))
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your output has EXTRA WHITESPACE. Check your print statements — are you adding extra spaces or using println where you should use print?", null, null, 10);

        // Generic wrong answer hint
        String inputPreview = input.length() > 100 ? input.substring(0, 100) + "..." : input;
        return new DynamicHintDto("DYNAMIC_WRONG",
            "Your code produces the wrong output for this test case.\nInput: \"" + inputPreview + "\"\nExpected: \"" + expected + "\"\nYour output: \"" + (actual == null ? "(empty)" : actual) + "\"\n\nLook at the difference between expected and actual. What edge case are you missing?",
            null, null, 10);
    }

    // --- TLE Complexity Nudge ---
    private DynamicHintDto tleHint(Problem problem) {
        // Infer input size constraints from problem description
        String desc = problem.getDescription().toLowerCase();
        String complexityTarget;

        if (desc.contains("10^9") || desc.contains("1000000000"))
            complexityTarget = "O(log n) or O(1)";
        else if (desc.contains("10^5") || desc.contains("100000"))
            complexityTarget = "O(n log n)";
        else if (desc.contains("10^3") || desc.contains("1000"))
            complexityTarget = "O(n^2)";
        else if (desc.contains("n <= 20") || desc.contains("n ≤ 20"))
            complexityTarget = "O(2^n)";
        else
            complexityTarget = "better than your current approach";

        return new DynamicHintDto("DYNAMIC_TLE",
            "Your solution is TOO SLOW — it exceeded the time limit. Based on the problem's constraints, you need an algorithm with complexity around " + complexityTarget + ".\n\nThink about: Can you reduce nested loops? Can you use a hash map for O(1) lookups? Can you sort first and then use binary search?",
            null, null, 10);
    }

    // --- Runtime Exception Translation ---
    private DynamicHintDto runtimeErrorHint(String stderr) {
        if (stderr == null || stderr.isBlank())
            return new DynamicHintDto("DYNAMIC_RUNTIME",
                "Your code crashed with a runtime error. Check for null pointers, array index issues, or division by zero.", null, null, 10);

        Map<String, String> exceptionTranslations = Map.ofEntries(
            Map.entry("ArrayIndexOutOfBoundsException",
                "You're accessing an array index that doesn't exist. Check your loop bounds — are you going past array.length? Remember: valid indices are 0 to length-1."),
            Map.entry("NullPointerException",
                "You're using a reference that is null. Check if your variable is initialized before using it. Add null checks where needed."),
            Map.entry("NumberFormatException",
                "You're trying to parse a string that isn't a valid number. Add input validation before calling Integer.parseInt() or similar."),
            Map.entry("ArithmeticException",
                "Math error — likely DIVISION BY ZERO. Check your divisor before dividing."),
            Map.entry("StackOverflowError",
                "Infinite recursion! Your recursive call has no proper base case. Make sure there's a condition that stops the recursion."),
            Map.entry("StringIndexOutOfBoundsException",
                "You're accessing a character position in a string that doesn't exist. Check your index — valid positions are 0 to length()-1."),
            Map.entry("InputMismatchException",
                "You're reading the wrong type of input. If you call nextInt() but the input is a string, this happens. Make sure your Scanner calls match the expected input types."),
            Map.entry("NoSuchElementException",
                "You're trying to read more input than available. Check if you're calling Scanner.next() more times than there are input tokens.")
        );

        for (Map.Entry<String, String> entry : exceptionTranslations.entrySet()) {
            if (stderr.contains(entry.getKey())) {
                return new DynamicHintDto("DYNAMIC_RUNTIME", entry.getValue(), null, entry.getKey(), 10);
            }
        }

        String truncated = stderr.length() > 300 ? stderr.substring(0, 300) + "..." : stderr;
        return new DynamicHintDto("DYNAMIC_RUNTIME",
            "Your code crashed with a runtime error:\n\n" + truncated + "\n\nRead the exception name and message — it usually tells you exactly what went wrong.",
            null, null, 10);
    }
}
```

**Step 4: Create HintService.java — static hint management + state**

```java
@Service
public class HintService {
    private final HintRepository hintRepo;
    private final HintUsageRepository hintUsageRepo;
    private final SubmissionRepository submissionRepo;
    private final ProblemPatternRepository patternRepo;
    private final HintEngine hintEngine;
    private final UserRepository userRepo;

    /**
     * Get full hint state for a user + problem:
     * - 5 static hint layers (content null if locked)
     * - Dynamic hint availability (requires ≥1 failed submission)
     * - Last failure type
     * - Total HP spent on hints
     * - Pattern hints (free)
     */
    public HintStateDto getHintState(Long userId, Long problemId) {
        List<Hint> allHints = hintRepo.findByProblemIdOrderByLayer(problemId);
        List<HintUsage> usedHints = hintUsageRepo.findByUserIdAndProblemId(userId, problemId);
        Set<Integer> unlockedLayers = usedHints.stream()
            .filter(h -> h.getHintType().equals("STATIC"))
            .map(HintUsage::getHintLayer)
            .collect(toSet());

        List<HintDto> hintDtos = allHints.stream().map(h -> new HintDto(
            h.getLayer(), h.getName(), h.getIcon(),
            unlockedLayers.contains(h.getLayer()) ? h.getContent() : null,
            h.getHpCost(), unlockedLayers.contains(h.getLayer()), "STATIC"
        )).toList();

        // Dynamic hint availability
        Optional<Submission> lastFailed = submissionRepo.findFirstByUserIdAndProblemIdAndStatusNotOrderByCreatedAtDesc(userId, problemId, "ACCEPTED");
        boolean dynamicAvailable = lastFailed.isPresent();
        String lastFailureType = lastFailed.map(Submission::getStatus).orElse(null);

        int totalHpSpent = usedHints.stream().mapToInt(HintUsage::getHpCost).sum();

        // Pattern hints (free, no HP cost)
        List<PatternHintDto> patternHints = findPatternHints(userId, problemId);

        return new HintStateDto(hintDtos, dynamicAvailable, lastFailureType, totalHpSpent, usedHints.size(), patternHints);
    }

    /**
     * Unlock a static hint layer (costs HP).
     * Enforces sequential unlock: can't unlock layer N+1 without unlocking layer N.
     */
    @Transactional
    public HintDto unlockStaticHint(Long userId, Long problemId, int layer) {
        // Validate sequential unlock
        if (layer > 1) {
            boolean previousUnlocked = hintUsageRepo.existsByUserIdAndProblemIdAndHintType(userId, problemId, "STATIC")
                && hintUsageRepo.findByUserIdAndProblemId(userId, problemId).stream()
                    .anyMatch(h -> h.getHintType().equals("STATIC") && h.getHintLayer() == layer - 1);
            if (!previousUnlocked)
                throw new BadRequestException("You must unlock Layer " + (layer - 1) + " first. Hints unlock progressively.");
        }

        // Check if already unlocked
        if (hintUsageRepo.existsByUserIdAndProblemIdAndHintType(userId, problemId, "STATIC"))
            // ... find and return existing

        Hint hint = hintRepo.findByProblemIdAndLayer(problemId, layer)
            .orElseThrow(() -> new NotFoundException("Hint layer " + layer + " not found for this problem"));

        // Deduct HP
        User user = userRepo.findById(userId).orElseThrow();
        if (user.getHp() < hint.getHpCost())
            throw new BadRequestException("Not enough HP! You have " + user.getHp() + " HP, but this hint costs " + hint.getHpCost() + " HP.");
        user.setHp(user.getHp() - hint.getHpCost());
        userRepo.save(user);

        // Record usage
        HintUsage usage = new HintUsage(userId, problemId, layer, "STATIC", hint.getHpCost(), hint.getContent());
        hintUsageRepo.save(usage);

        return new HintDto(hint.getLayer(), hint.getName(), hint.getIcon(), hint.getContent(), hint.getHpCost(), true, "STATIC");
    }

    /**
     * Generate a dynamic code-aware hint (costs 10 HP).
     * Requires at least 1 failed submission for this problem.
     */
    @Transactional
    public DynamicHintDto getDynamicHint(Long userId, Long problemId) {
        // Check user has a failed submission
        Optional<Submission> lastFailed = submissionRepo.findFirstByUserIdAndProblemIdAndStatusNotOrderByCreatedAtDesc(userId, problemId, "ACCEPTED");
        if (lastFailed.isEmpty())
            throw new BadRequestException("Dynamic hints require at least one failed submission. Submit your code first!");

        // Deduct HP
        User user = userRepo.findById(userId).orElseThrow();
        if (user.getHp() < 10)
            throw new BadRequestException("Not enough HP! Dynamic hints cost 10 HP. You have " + user.getHp() + " HP.");
        user.setHp(user.getHp() - 10);
        userRepo.save(user);

        // Generate hint
        Problem problem = problemRepo.findById(problemId).orElseThrow();
        List<TestCase> failedCases = testCaseRepo.findByProblemIdOrderByOrderNum(problemId);
        // Filter to only the cases that actually failed
        // (compare actual output vs expected for each)
        DynamicHintDto hint = hintEngine.generateHint(lastFailed.get(), problem, failedCases);

        // Record usage
        HintUsage usage = new HintUsage(userId, problemId, 0, hint.hintType(), 10, hint.content());
        hintUsageRepo.save(usage);

        // Save context
        HintContext ctx = new HintContext(usage.getId(), lastFailed.get().getSourceCode(), lastFailed.get().getId(), null);
        hintContextRepo.save(ctx);

        return hint;
    }

    /**
     * Find pattern hints — cross-problem hints based on shared algorithmic patterns.
     * Free (no HP cost) — it's a reward for having solved related problems.
     */
    private List<PatternHintDto> findPatternHints(Long userId, Long problemId) {
        List<ProblemPattern> matches = patternRepo.findMatchingPatternsForUser(userId, problemId);
        return matches.stream().map(pp -> new PatternHintDto(
            pp.getPatternName(),
            // Find the slug/title of the related problem the user already solved
            findSolvedProblemSlug(userId, pp.getPatternName()),
            findSolvedProblemTitle(userId, pp.getPatternName())
        )).filter(p -> p.relatedProblemSlug() != null).toList();
    }
}
```

**Step 5: Create HintController.java**

```java
@RestController
@RequestMapping("/api/problems/{slug}/hints")
public class HintController {

    @GetMapping
    ResponseEntity<HintStateDto> getHints(@PathVariable String slug, @AuthenticationPrincipal User user) {
        Problem problem = problemService.getBySlug(slug);
        return ResponseEntity.ok(hintService.getHintState(user.getId(), problem.getId()));
    }

    @GetMapping("/state")
    ResponseEntity<HintStateDto> getHintState(@PathVariable String slug, @AuthenticationPrincipal User user) {
        Problem problem = problemService.getBySlug(slug);
        return ResponseEntity.ok(hintService.getHintState(user.getId(), problem.getId()));
    }

    @PostMapping("/unlock")
    ResponseEntity<HintDto> unlockHint(@PathVariable String slug, @RequestBody UnlockHintRequest req, @AuthenticationPrincipal User user) {
        Problem problem = problemService.getBySlug(slug);
        return ResponseEntity.ok(hintService.unlockStaticHint(user.getId(), problem.getId(), req.layer()));
    }

    @PostMapping("/dynamic")
    ResponseEntity<DynamicHintDto> getDynamicHint(@PathVariable String slug, @AuthenticationPrincipal User user) {
        Problem problem = problemService.getBySlug(slug);
        return ResponseEntity.ok(hintService.getDynamicHint(user.getId(), problem.getId()));
    }
}

public record UnlockHintRequest(int layer) {}
```

**Step 6: Write test — HintEngineTest.java**

```java
@Test
void compileErrorHint_cannotFindSymbol() {
    String compileOutput = "Solution.java:5: error: cannot find symbol\n    symbol: variable x";
    DynamicHintDto hint = hintEngine.compileErrorHint(compileOutput);
    assertThat(hint.hintType()).isEqualTo("DYNAMIC_COMPILE");
    assertThat(hint.content()).contains("variable");
    assertThat(hint.lineNumber()).isEqualTo(5);
}

@Test
void wrongAnswerHint_emptyInput() {
    Submission sub = new Submission();
    sub.setStatus("WRONG_ANSWER");
    sub.setStdout("");
    TestCase emptyCase = new TestCase();
    emptyCase.setInput("");
    emptyCase.setExpectedOutput("42");
    DynamicHintDto hint = hintEngine.wrongAnswerHint(sub, List.of(emptyCase), problem);
    assertThat(hint.content()).contains("EMPTY");
}

@Test
void runtimeErrorHint_nullPointer() {
    String stderr = "Exception in thread \"main\" java.lang.NullPointerException at Solution.main(Solution.java:8)";
    DynamicHintDto hint = hintEngine.runtimeErrorHint(stderr);
    assertThat(hint.content()).contains("null");
    assertThat(hint.exceptionType()).isEqualTo("NullPointerException");
}

@Test
void tleHint_infersComplexity() {
    Problem p = new Problem();
    p.setDescription("Given an array of size up to 10^5...");
    DynamicHintDto hint = hintEngine.tleHint(p);
    assertThat(hint.content()).contains("O(n log n)");
}
```

**Step 7: Write V5__seed_hints.sql — 5 hint layers for all 70 problems**

Each problem gets 5 hint layers:
```sql
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', 'Think about what Java statement prints text to the screen.', 5, 1),
(1, 2, 'The Map', '🗺️', 'Algorithm: Use System.out.println(). It prints a string followed by a newline to stdout.', 10, 2),
(1, 3, 'The Blueprint', '📐', 'Pseudocode:\n  1. Call println with the string "Hello, World!"\n  2. That''s it — just one line!', 15, 3),
(1, 4, 'The Scaffold', '🔨', 'public class Solution {\n    public static void main(String[] args) {\n        // TODO: Print "Hello, World!" here\n    }\n}', 20, 4),
(1, 5, 'The Sage''s Whisper', '🔮', 'System.out.println("Hello, World!");', 30, 5);
```

**Step 8: Write V6__seed_problem_patterns.sql — pattern tags for cross-problem hints**

```sql
INSERT INTO problem_patterns (problem_id, pattern_name) VALUES
(14, 'Hash Map'),
(45, 'Hash Map'),
(49, 'Hash Map'),
(15, 'Two-Pointer'),
(16, 'Two-Pointer'),
(17, 'Two-Pointer'),
(16, 'Sliding Window'),
(29, 'Sliding Window'),
(30, 'Sliding Window'),
(36, 'Binary Search'),
(37, 'Binary Search'),
(38, 'Binary Search'),
(51, 'Linked List Reversal'),
(52, 'Two-Pointer'),
(53, 'Floyd Cycle Detection'),
(61, 'Tree DFS'),
(62, 'Tree DFS'),
(63, 'Tree DFS'),
(65, 'Tree BFS'),
(70, 'Graph BFS');
```

**Step 9: Verify**

Run: `./gradlew test --tests HintEngineTest`
Expected: All tests pass.

Run: `./gradlew test --tests HintServiceTest`
Expected: All tests pass.

Manual test flow:
1. Submit wrong Java code → get compile error
2. Call `POST /api/problems/{slug}/hints/dynamic` → get targeted compile error hint
3. Unlock Layer 1 hint → HP decreases by 5
4. Try to unlock Layer 3 without Layer 2 → error "must unlock Layer 2 first"
5. Check `GET /api/problems/{slug}/hints/state` → shows 2 layers unlocked, dynamic available, pattern hints if any

---

### Phase 3: Frontend — Design System & Auth (Tasks 9-12)

### Task 9: Frontend — TailwindCSS Theme, shadcn/ui Setup, Global Styles

**Objective:** Create the "extremely pleasing" dark RPG fantasy theme.

**Files:**
- Modify: `frontend/src/styles/globals.css`
- Modify: `frontend/tailwind.config.ts`
- Create: `frontend/src/lib/utils.ts`
- Create: `frontend/src/lib/constants.ts`

**Steps:**

1. Configure `globals.css` with CSS custom properties for the RPG theme:
```css
@import "tailwindcss";

:root {
  --background: 240 6% 4%;          /* #0a0a0f */
  --surface: 240 5% 9%;             /* #13131f */
  --surface-hover: 240 5% 12%;
  --border: 262 60% 40%;            /* purple-tinted border */
  --primary: 262 83% 58%;           /* amethyst #8b5cf6 */
  --primary-glow: 262 83% 58% / 0.3;
  --success: 160 84% 39%;           /* emerald #10b981 */
  --danger: 0 84% 60%;             /* crimson #ef4444 */
  --warning: 38 92% 50%;            /* amber #f59e0b */
  --foreground: 240 5% 90%;         /* #e4e4e7 */
  --muted: 240 4% 46%;              /* #71717a */
  --radius: 0.75rem;
  --font-heading: 'Cinzel', serif;
  --font-body: 'Inter', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
}

body {
  background: var(--background);
  color: var(--foreground);
  font-family: var(--font-body);
}
```

2. Configure `tailwind.config.ts`:
```typescript
import type { Config } from 'tailwindcss';
export default {
  content: ['./src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        background: 'hsl(var(--background))',
        surface: 'hsl(var(--surface))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          glow: 'hsl(var(--primary-glow))',
        },
        success: 'hsl(var(--success))',
        danger: 'hsl(var(--danger))',
        warning: 'hsl(var(--warning))',
      },
      fontFamily: {
        heading: ['Cinzel', 'serif'],
        body: ['Inter', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
      borderRadius: { xl: 'var(--radius)' },
      animation: {
        'glow-pulse': 'glowPulse 2s ease-in-out infinite',
        'level-up': 'levelUp 0.8s ease-out',
        'shake': 'shake 0.4s',
      },
      keyframes: {
        glowPulse: {
          '0%, 100%': { boxShadow: '0 0 20px hsl(var(--primary) / 0.3)' },
          '50%': { boxShadow: '0 0 40px hsl(var(--primary) / 0.6)' },
        },
        levelUp: {
          '0%': { transform: 'scale(0.5)', opacity: '0' },
          '50%': { transform: 'scale(1.1)', opacity: '1' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
        shake: {
          '0%, 100%': { transform: 'translateX(0)' },
          '25%': { transform: 'translateX(-8px)' },
          '75%': { transform: 'translateX(8px)' },
        },
      },
    },
  },
} satisfies Config;
```

3. Create `constants.ts` with realm metadata:
```typescript
export const REALMS = [
  { id: 1, name: 'Forest of Fundamentals', icon: '🌲', color: '#10b981', desc: 'Java basics: loops, conditionals, methods' },
  { id: 2, name: 'Caves of Arrays', icon: '🕳️', color: '#3b82f6', desc: 'Arrays, two pointers, sliding window' },
  { id: 3, name: 'String Mountains', icon: '⛰️', color: '#f59e0b', desc: 'String manipulation, StringBuilder, regex' },
  { id: 4, name: 'Sorting Citadel', icon: '🏰', color: '#ef4444', desc: 'Sorting algorithms, binary search' },
  { id: 5, name: 'Hash Marshlands', icon: '🌊', color: '#8b5cf6', desc: 'HashMap, HashSet, Collections' },
  { id: 6, name: 'Linked List Labyrinth', icon: '🔗', color: '#ec4899', desc: 'Linked lists, stacks, queues' },
  { id: 7, name: 'Tree Sanctuary', icon: '🌳', color: '#14b8a6', desc: 'Trees, BSTs, recursion, graphs' },
];

export const RANKS = [
  { level: 1, title: 'Novice' },
  { level: 5, title: 'Apprentice' },
  { level: 10, title: 'Squire' },
  { level: 20, title: 'Knight' },
  { level: 35, title: 'Paladin' },
  { level: 50, title: 'Sage' },
  { level: 75, title: 'Archmage' },
  { level: 100, title: 'Legend' },
];

export const XP_PER_LEVEL = (level: number) => 100 * level * level;
```

4. Install shadcn/ui components:
```bash
cd frontend
npx shadcn@latest add button card dialog badge progress tabs tooltip \
  dropdown-menu sonner separator scroll-area avatar input label
```

5. Verify: Run `npm run dev`, see the dark-themed landing page with correct fonts/colors.

---

### Task 10: Frontend — API Client, Auth Store, Auth Pages

**Objective:** Create the API client, Zustand auth store, and login/register pages.

**Files:**
- Create: `frontend/src/lib/api.ts`
- Create: `frontend/src/stores/auth-store.ts`
- Create: `frontend/src/app/auth/login/page.tsx`
- Create: `frontend/src/app/auth/register/page.tsx`
- Create: `frontend/src/components/layout/navbar.tsx`

**Steps:**

1. Create `api.ts`:
```typescript
const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8080/api';

async function apiFetch<T>(path: string, options: RequestInit = {}): Promise<T> {
  const token = localStorage.getItem('token');
  const res = await fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...options.headers,
    },
  });
  if (!res.ok) throw new ApiError(res.status, await res.json());
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
```

2. Create `auth-store.ts` (Zustand):
```typescript
interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  login: (token: string, user: User) => void;
  logout: () => void;
  updateUser: (updates: Partial<User>) => void;
}
```

3. Create login and register pages — beautiful forms with:
- Full-screen split layout (left: RPG artwork/illustration, right: form)
- Glowing primary buttons
- Form validation with error toasts (shadcn `sonner`)
- On success: redirect to `/quest`

4. Create `navbar.tsx` — top nav with logo, user avatar + level badge, XP bar mini-display, logout.

5. Verify: Register → redirected to `/quest`. Login → redirected to `/quest`. Token stored in localStorage. Navbar shows user info.

---

### Task 11: Frontend — Landing Page

**Objective:** Create a stunning landing page that sells the RPG coding adventure.

**Files:**
- Create: `frontend/src/app/page.tsx`
- Create: `frontend/src/components/landing/hero.tsx`
- Create: `frontend/src/components/landing/feature-cards.tsx`
- Create: `frontend/src/components/landing/realm-preview.tsx`

**Steps:**

1. Create `hero.tsx`:
- Full-screen section with animated particle/constellation background (CSS animation or lightweight canvas).
- Large heading in Cinzel font: "Forge Your Java Mastery. One Quest at a Time."
- Subtext: "An RPG-themed Java coding journey. Solve problems, level up, conquer bosses."
- Two CTA buttons: "Begin Your Quest" (primary, glowing) → `/auth/register`, "I Already Quest" (ghost) → `/auth/login`.
- Framer Motion entrance animation: stagger fade-in from bottom.

2. Create `feature-cards.tsx` — 3 cards highlighting:
- "70 Hand-Crafted Problems" — Progressive difficulty across 7 realms
- "RPG Progression" — XP, levels, skill trees, achievements
- "Real Java Execution" — Write and run Java code in a beautiful editor

3. Create `realm-preview.tsx` — horizontal scroll/row of 7 realm cards with icons, colors, and brief descriptions. Hover reveals problem count.

4. Verify: Landing page loads with animations, responsive, dark theme is cohesive.

---

### Task 12: Frontend — Layout Shell & Route Protection

**Objective:** Create the app layout with navbar, sidebar, and auth-guarded routes.

**Files:**
- Create: `frontend/src/components/layout/app-shell.tsx`
- Create: `frontend/src/components/layout/sidebar.tsx`
- Create: `frontend/src/components/layout/user-stats-bar.tsx`
- Create: `frontend/src/app/quest/layout.tsx`

**Steps:**

1. Create `app-shell.tsx` — wraps all authenticated pages with:
- Top navbar (logo, user info)
- Left sidebar (Quest Map, Profile, Leaderboard, About)
- Main content area
- User stats mini-bar at bottom (Level, XP bar, HP bar, Streak)

2. Create `user-stats-bar.tsx` — always-visible bottom bar showing:
```tsx
<div className="fixed bottom-0 left-0 right-0 ...">
  <LevelBadge level={user.level} rank={user.rank} />
  <XpBar current={user.xp} needed={xpForNextLevel} />
  <HpBar current={user.hp} max={100} />
  <StreakBadge days={user.streak} />
</div>
```

3. Create auth guard in `quest/layout.tsx`:
```tsx
export default function QuestLayout({ children }) {
  const { isAuthenticated, isLoading } = useAuth();
  if (isLoading) return <LoadingScreen />;
  if (!isAuthenticated) redirect('/auth/login');
  return <AppShell>{children}</AppShell>;
}
```

4. Verify: Unauthenticated user visiting `/quest` is redirected to login. Authenticated user sees the full shell with stats bar.

---

### Phase 4: Frontend — Skill Tree & Problem Workspace (Tasks 13-16)

### Task 13: Frontend — Skill Tree Map Page

**Objective:** Build the interactive RPG skill tree node graph — the centerpiece of the app.

**Files:**
- Create: `frontend/src/app/quest/page.tsx`
- Create: `frontend/src/components/skill-tree/skill-tree-map.tsx`
- Create: `frontend/src/components/skill-tree/skill-node.tsx`
- Create: `frontend/src/components/skill-tree/realm-connector.tsx`
- Create: `frontend/src/components/skill-tree/node-detail-panel.tsx`
- Create: `frontend/src/hooks/use-skill-tree.ts`

**Steps:**

1. Create `use-skill-tree.ts` — TanStack Query hook:
```typescript
export function useSkillTree() {
  return useQuery({
    queryKey: ['skill-tree'],
    queryFn: api.progress.skillTree,
  });
}
```

2. Create `skill-tree-map.tsx`:
- Renders 7 realms as vertical sections (or a winding path layout).
- Each realm has its icon, name, and color theme.
- Nodes within each realm are positioned in a tree/path layout.
- Uses SVG for connecting paths between nodes.
- Pan/zoom support (use `react-zoom-pan-pinch` or custom).
- Framer Motion animations: nodes animate in on load, completed nodes pulse.

3. Create `skill-node.tsx`:
```tsx
function SkillNode({ node, realm, onClick }) {
  const state = node.completed ? 'completed' : node.unlocked ? 'unlocked' : 'locked';
  // completed: golden glow + checkmark icon
  // unlocked: full color + pulsing border (animate-glow-pulse)
  // locked: gray, lock icon, reduced opacity
  // boss: skull icon, larger size, red aura when locked, gold when completed

  return (
    <motion.div
      whileHover={state === 'locked' ? {} : { scale: 1.1, y: -2 }}
      onClick={state !== 'locked' ? onClick : undefined}
      className={cn(
        'flex h-16 w-16 items-center justify-center rounded-full border-2 transition-all',
        state === 'completed' && 'border-amber-500 bg-amber-500/20 shadow-[0_0_30px_rgba(245,158,11,0.4)]',
        state === 'unlocked' && 'border-primary bg-primary/10 animate-glow-pulse cursor-pointer',
        state === 'locked' && 'border-muted/30 bg-surface/50 opacity-40 cursor-not-allowed',
        node.isBoss && 'h-20 w-20',
      )}
    >
      {state === 'completed' ? <CheckIcon /> : state === 'locked' ? <LockIcon /> : <span className="text-2xl">{realm.icon}</span>}
    </motion.div>
  );
}
```

4. Create `realm-connector.tsx` — SVG paths connecting nodes:
```tsx
// Draw curved/bezier paths between connected nodes
// Completed path: glowing gradient stroke
// Unlocked but not completed: solid primary color
// Locked: dashed gray
```

5. Create `node-detail-panel.tsx` — slide-in side panel when a node is clicked:
- Problem title, difficulty badge, XP reward
- Brief description preview
- "Start Quest" button → navigates to `/quest/{slug}`
- If completed: show "Completed" badge + time/memory stats from last submission

6. Create `quest/page.tsx`:
```tsx
export default function QuestPage() {
  const { data: skillTree, isLoading } = useSkillTree();
  return (
    <div className="min-h-screen p-8">
      <h1 className="font-heading text-3xl mb-8">Your Quest Map</h1>
      {isLoading ? <LoadingSkeleton /> : <SkillTreeMap data={skillTree} />}
      <NodeDetailPanel />
    </div>
  );
}
```

7. Verify: Skill tree renders all 7 realms with nodes. Clicking an unlocked node opens detail panel. Locked nodes are visually distinct. Completed nodes glow gold.

---

### Task 14: Frontend — Problem Workspace (Monaco Editor + Panels)

**Objective:** Build the three-panel problem solving workspace with Monaco editor.

**Files:**
- Create: `frontend/src/app/quest/[slug]/page.tsx`
- Create: `frontend/src/components/problem/problem-panel.tsx`
- Create: `frontend/src/components/problem/test-results.tsx`
- Create: `frontend/src/components/problem/hint-card.tsx`
- Create: `frontend/src/components/editor/code-editor.tsx`
- Create: `frontend/src/components/editor/editor-theme.ts`
- Create: `frontend/src/hooks/use-submission.ts`

**Steps:**

1. Create `editor-theme.ts` — custom Monaco theme matching the app:
```typescript
export const questTheme = {
  base: 'vs-dark',
  inherit: true,
  rules: [
    { token: 'keyword', foreground: 'c084fc' },     // purple keywords
    { token: 'string', foreground: '4ade80' },       // green strings
    { token: 'number', foreground: 'fbbf24' },       // amber numbers
    { token: 'comment', foreground: '71717a' },      // gray comments
    { token: 'type', foreground: '60a5fa' },          // blue types
  ],
  colors: {
    'editor.background': '#0a0a0f',
    'editor.foreground': '#e4e4e7',
    'editorLineNumber.foreground': '#3f3f46',
    'editor.selectionBackground': '#8b5cf633',
    'editor.lineHighlightBackground': '#13131f',
    'editorCursor.foreground': '#8b5cf6',
  },
};
```

2. Create `code-editor.tsx`:
```tsx
import Editor from '@monaco-editor/react';

export function CodeEditor({ value, onChange }) {
  return (
    <Editor
      height="100%"
      language="java"
      theme="quest"
      beforeMount={(monaco) => monaco.editor.defineTheme('quest', questTheme)}
      value={value}
      onChange={(v) => onChange(v || '')}
      options={{
        fontSize: 14,
        fontFamily: 'JetBrains Mono',
        minimap: { enabled: false },
        scrollBeyondLastLine: false,
        padding: { top: 16 },
        fontLigatures: true,
        smoothScrolling: true,
        cursorBlinking: 'smooth',
        tabSize: 4,
        automaticLayout: true,
      }}
    />
  );
}
```

3. Create `problem-panel.tsx` — left panel:
- Markdown-rendered problem description (use `react-markdown`)
- Difficulty badge (EASY=green, MEDIUM=amber, HARD=red, BOSS=skull)
- XP reward badge
- **Oracle Panel** (`oracle-panel.tsx`) embedded below problem description:
  - Crystal ball (🔮) header with purple glow
  - 5 static hint layers (The Compass → The Sage's Whisper) — locked/unlocked state
  - "Consult the Oracle" buttons on locked layers showing HP cost
  - Dynamic hint section (only appears if user has ≥1 failed submission):
    - Shows last failure type with warning icon
    - "🔍 Analyze My Failed Submission" button (10 HP)
    - Typewriter animation when hint is revealed
  - Pattern hints section (free, auto-discovered):
    - "💡 You solved [Problem X] using a similar [Pattern] pattern"
  - HP cost floating animation when a hint is unlocked

4. Create `oracle-panel.tsx` — the full hint UI component:
```tsx
function OraclePanel({ problemSlug }) {
  const { data: hintState } = useHints(problemSlug);
  const unlockMutation = useUnlockHint(problemSlug);
  const dynamicMutation = useDynamicHint(problemSlug);

  return (
    <div className="mt-6 rounded-xl border border-primary/20 bg-surface/50 p-4">
      <div className="mb-4 flex items-center gap-2">
        <span className="text-2xl">🔮</span>
        <h3 className="font-heading text-sm text-primary/80">The Oracle's Guidance</h3>
      </div>

      {/* Static hint layers */}
      <div className="space-y-2">
        {hintState?.staticHints.map(hint => (
          <HintCard key={hint.layer} hint={hint}
            onUnlock={() => unlockMutation.mutate(hint.layer)} />
        ))}
      </div>

      {/* Dynamic hint section */}
      {hintState?.dynamicAvailable && (
        <DynamicHintButton problemSlug={problemSlug}
          lastFailureType={hintState.lastFailureType}
          onAnalyze={() => dynamicMutation.mutate()}
          analysis={dynamicMutation.data}
          isAnalyzing={dynamicMutation.isPending} />
      )}

      {/* Pattern hints (free) */}
      {hintState?.patternHints?.length > 0 && (
        <div className="mt-4 space-y-2">
          <p className="text-xs font-body text-muted">── Pattern Hints ──</p>
          {hintState.patternHints.map(ph => (
            <PatternHintCard key={ph.patternName} pattern={ph} />
          ))}
        </div>
      )}

      {/* HP spent summary */}
      {hintState && hintState.totalHpSpentOnHints > 0 && (
        <p className="mt-3 text-xs text-muted">
          Total HP spent on hints: {hintState.totalHpSpentOnHints}
        </p>
      )}
    </div>
  );
}
```

5. Create `hint-card.tsx` — individual static hint layer card:
- Locked state: dimmed, lock icon, layer name + HP cost badge, "Consult the Oracle" button
- Unlocked state: amber left border, typewriter text reveal, layer name + icon
- Framer Motion expand animation on unlock

6. Create `dynamic-hint.tsx` — dynamic code-aware hint button + result:
- Only shows if user has ≥1 failed submission
- Shows failure type (compile error, wrong answer, TLE, runtime error) with appropriate icon
- "🔍 Analyze My Failed Submission (10 HP)" button with glow
- On click: loading spinner "The Oracle examines your code..." → typewriter reveal of generated hint
- Shows line number if available ("Likely issue at line X")

7. Create `pattern-hint.tsx` — free cross-problem pattern hint card:
- Shows pattern name + related problem title as a link
- Lightbulb icon, subtle green accent (not HP-cost colored)
- "This problem can be approached the same way"

8. Create `typewriter-text.tsx` — reusable typewriter animation:
```tsx
function TypewriterText({ text, speed = 20 }) {
  const [displayed, setDisplayed] = useState('');
  useEffect(() => {
    let i = 0;
    const interval = setInterval(() => {
      if (i < text.length) { setDisplayed(text.slice(0, i + 1)); i++; }
      else clearInterval(interval);
    }, speed);
    return () => clearInterval(interval);
  }, [text, speed]);
  return <span className="whitespace-pre-wrap">{displayed}<span className="animate-pulse">▋</span></span>;
}
```

9. Create `use-hints.ts` — TanStack Query hooks for hints:
```typescript
export function useHints(slug: string) {
  return useQuery({ queryKey: ['hints', slug], queryFn: () => api.hints.get(slug) });
}
export function useUnlockHint(slug: string) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (layer: number) => api.hints.unlock(slug, layer),
    onSuccess: () => { qc.invalidateQueries({ queryKey: ['hints', slug] }); qc.invalidateQueries({ queryKey: ['stats'] }); }
  });
}
export function useDynamicHint(slug: string) {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: () => api.hints.dynamic(slug),
    onSuccess: () => { qc.invalidateQueries({ queryKey: ['hints', slug] }); qc.invalidateQueries({ queryKey: ['stats'] }); }
  });
}
```

4. Create `test-results.tsx` — right panel:
- Tabs: "Test Results" | "Console" | "Submissions"
- Test results: per-case rows with pass/fail icon, input, expected vs actual, time/memory
- Overall status banner: green "Accepted" or red "Wrong Answer"
- Submission history list

5. Create `use-submission.ts`:
```typescript
export function useSubmission() {
  return useMutation({
    mutationFn: api.submissions.submit,
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ['skill-tree'] });
      queryClient.invalidateQueries({ queryKey: ['stats'] });
      if (data.status === 'ACCEPTED') {
        triggerConfetti();
        if (data.leveledUp) showLevelUpOverlay(data.newLevel);
        if (data.bossDefeated) showBossDefeatedAnimation();
      } else {
        triggerScreenShake();
      }
    },
  });
}
```

6. Create `quest/[slug]/page.tsx`:
```tsx
export default function ProblemPage({ params: { slug } }) {
  const { data: problem } = useProblem(slug);
  const [code, setCode] = useState(problem?.starterCode || '');
  const submission = useSubmission();

  return (
    <div className="flex h-[calc(100vh-64px)]">
      <ProblemPanel problem={problem} className="w-1/4" />
      <div className="flex-1 flex flex-col">
        <CodeEditor value={code} onChange={setCode} />
        <ActionBar onRun={() => submission.mutate({ slug, sourceCode: code, runSampleOnly: true })}
                    onSubmit={() => submission.mutate({ slug, sourceCode: code, runSampleOnly: false })} />
      </div>
      <TestResults results={submission.data} className="w-1/4" />
    </div>
  );
}
```

7. Verify: Load a problem → see three-panel layout. Type Java code in Monaco editor with custom theme. Click "Run" → sample test cases execute. Click "Submit" → full test run, XP gain, skill tree updates.

---

### Task 15: Frontend — RPG Feedback Animations

**Objective:** Create the celebratory feedback animations for submissions.

**Files:**
- Create: `frontend/src/components/rpg/level-up-overlay.tsx`
- Create: `frontend/src/components/rpg/confetti-burst.tsx`
- Create: `frontend/src/components/rpg/screen-shake.tsx`
- Create: `frontend/src/components/rpg/achievement-toast.tsx`
- Create: `frontend/src/components/rpg/xp-gain-popup.tsx`

**Steps:**

1. Create `confetti-burst.tsx` — full-screen confetti on accepted submission:
```tsx
import { motion, AnimatePresence } from 'framer-motion';

export function ConfettiBurst({ trigger }: { trigger: boolean }) {
  // Generate 50 random confetti particles with Framer Motion
  // Each particle: random color (purple/green/gold), random x/y trajectory, rotation
  // AnimatePresence: appears for 2s then fades
}
```

2. Create `level-up-overlay.tsx`:
```tsx
export function LevelUpOverlay({ level, show }: { level: number; show: boolean }) {
  return (
    <AnimatePresence>
      {show && (
        <motion.div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80"
          initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}>
          <motion.div className="text-center" initial={{ scale: 0.5, y: 50 }} animate={{ scale: 1, y: 0 }}>
            <p className="font-heading text-6xl text-amber-500 animate-pulse">LEVEL UP!</p>
            <p className="font-heading text-4xl text-white mt-4">Level {level}</p>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
```

3. Create `screen-shake.tsx` — wrapper component that adds shake animation on wrong answer:
```tsx
export function ScreenShake({ active, children }) {
  return (
    <motion.div animate={active ? { x: [0, -8, 8, -8, 8, 0] } : { x: 0 }}
      transition={{ duration: 0.4 }}>
      {children}
    </motion.div>
  );
}
```

4. Create `achievement-toast.tsx` — toast notification when achievement unlocked:
```tsx
export function AchievementToast({ achievement }: { achievement: Achievement }) {
  return (
    <Toaster>
      <Toast>
        <div className="flex items-center gap-3">
          <TrophyIcon className="text-amber-500 h-8 w-8" />
          <div>
            <p className="font-heading text-amber-500">Achievement Unlocked!</p>
            <p className="text-sm">{achievement.title}</p>
          </div>
        </div>
      </Toast>
    </Toaster>
  );
}
```

5. Create `xp-gain-popup.tsx` — floating "+120 XP" text that rises and fades:
```tsx
export function XpGainPopup({ xp, show }) {
  return (
    <AnimatePresence>
      {show && (
        <motion.p className="fixed top-1/2 left-1/2 font-heading text-4xl text-amber-500 z-40"
          initial={{ opacity: 0, y: 0, scale: 0.5 }}
          animate={{ opacity: 1, y: -80, scale: 1.2 }}
          exit={{ opacity: 0 }}>
          +{xp} XP
        </motion.p>
      )}
    </AnimatePresence>
  );
}
```

6. Verify: Submit correct answer → confetti + XP popup + (if leveled up) level-up overlay. Submit wrong answer → screen shake + red flash. Unlock achievement → toast appears.

---

### Task 16: Frontend — Profile & Leaderboard Pages

**Objective:** Create the character profile page and leaderboard.

**Files:**
- Create: `frontend/src/app/profile/page.tsx`
- Create: `frontend/src/components/profile/character-card.tsx`
- Create: `frontend/src/components/profile/stats-grid.tsx`
- Create: `frontend/src/components/profile/achievement-grid.tsx`
- Create: `frontend/src/components/profile/activity-timeline.tsx`
- Create: `frontend/src/app/leaderboard/page.tsx`
- Create: `frontend/src/components/leaderboard/leaderboard-table.tsx`

**Steps:**

1. Create `character-card.tsx` — RPG-style character stat card:
```tsx
<div className="rounded-xl border-2 border-primary/20 bg-surface p-6">
  <div className="flex items-center gap-4">
    <Avatar className="h-24 w-24 rounded-full border-4 border-primary/30" />
    <div>
      <h2 className="font-heading text-2xl">{user.username}</h2>
      <p className="text-muted">Level {user.level} {user.rank}</p>
    </div>
  </div>
  <div className="mt-4 space-y-3">
    <XpBar current={user.xp} needed={xpForNextLevel} showText />
    <HpBar current={user.hp} max={100} showText />
  </div>
</div>
```

2. Create `stats-grid.tsx` — grid of stat cards:
- Total Solved (with Easy/Medium/Hard breakdown)
- Current Streak (with flame icon)
- Accuracy (accepted / total submissions)
- Average Time per Problem

3. Create `achievement-grid.tsx` — badge grid:
```tsx
<div className="grid grid-cols-4 gap-4">
  {achievements.map(a => (
    <div className={cn('rounded-xl border p-4 text-center',
      a.unlocked ? 'border-amber-500/30 bg-amber-500/5' : 'border-muted/20 opacity-30 grayscale')}>
      <TrophyIcon className="h-8 w-8 mx-auto" />
      <p className="text-xs mt-2">{a.title}</p>
    </div>
  ))}
</div>
```

4. Create `leaderboard-table.tsx` — ranked table with:
- Rank number (1st = crown icon)
- Username
- Level + Rank title
- Total XP
- Problems solved
- Current streak

5. Verify: Profile page shows user's RPG character card with all stats. Leaderboard shows ranked list. Achievements show locked/unlocked correctly.

---

### Phase 5: Polish & Integration (Tasks 17-20)

### Task 17: Seed All 70 Problems with Test Cases & Solutions

**Objective:** Write the complete problem seed file with all 70 problems, test cases, hints, and reference solutions.

**Files:**
- Create: `backend/src/main/resources/db/migration/V2__seed_problems.sql`
- Create: `backend/src/main/resources/db/migration/V3__seed_test_cases.sql`
- Create: `backend/src/main/resources/db/migration/V5__seed_hints.sql`
- Create: `backend/src/main/resources/db/migration/V6__seed_problem_patterns.sql`

**Steps:**

1. Write `V2__seed_problems.sql` — INSERT all 70 problems. Each has:
- `slug` (kebab-case)
- `title`
- `description` (Markdown with problem statement, examples, constraints)
- `difficulty` (EASY/MEDIUM/HARD/BOSS)
- `xp_reward`
- `realm_id` (1-7)
- `order_in_realm` (1-10)
- `starter_code` (Java class template with method signature)
- `solution_code` (reference Java solution)
- `is_boss` (true for problem #10 in each realm)

2. Write `V3__seed_test_cases.sql` — 3-5 visible + 5-10 hidden test cases per problem. Each has:
- `problem_id` (FK)
- `input` (stdin text)
- `expected_output` (stdout text)
- `is_hidden` (false for sample, true for judge tests)
- `order_num`

3. Write `V5__seed_hints.sql` — 5 progressive hint layers per problem (350 total hints):
- Layer 1 "The Compass" (5 HP): high-level approach nudge ("Think about using a hash map...")
- Layer 2 "The Map" (10 HP): algorithm/pattern name + conceptual steps ("Two-Pointer Technique: place one pointer at start...")
- Layer 3 "The Blueprint" (15 HP): pseudocode outline (no actual Java code)
- Layer 4 "The Scaffold" (20 HP): Java code skeleton with TODO markers
- Layer 5 "The Sage's Whisper" (30 HP): near-complete solution with key lines blanked out

4. Write `V6__seed_problem_patterns.sql` — pattern tags for cross-problem pattern hints:
- Tag each problem with its algorithmic pattern(s) (e.g., "Hash Map", "Two-Pointer", "Sliding Window", "Binary Search", "Tree DFS", "Tree BFS")
- This enables the PatternMatcher service to discover related solved problems

5. Verify: Run migrations on fresh DB. Confirm 70 problems, ~500 test cases, 350 hints (5 per problem), and ~25 pattern tags exist. Query sample: `SELECT slug, title, difficulty FROM problems ORDER BY realm_id, order_in_realm` returns all 70 in order. `SELECT COUNT(*) FROM hints` returns 350. `SELECT * FROM problem_patterns` returns pattern tags.

---

### Task 18: Backend — Submission Polling Optimization

**Objective:** Optimize the Judge0 submission flow for speed (parallel test case execution).

**Files:**
- Modify: `backend/.../service/Judge0Client.java`
- Modify: `backend/.../service/SubmissionService.java`

**Steps:**

1. In `Judge0Client`, batch-submit all test cases at once (Judge0 supports creating multiple submissions). Then poll all tokens concurrently using `CompletableFuture.allOf()` with a timeout.

2. Add WebSocket support (Spring WebSocket) for real-time submission status:
```java
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new SubmissionStatusHandler(), "/ws/submissions");
    }
}
```
Frontend connects to WebSocket, gets live updates as each test case completes.

3. Add submission rate limiting (1 submission per 5 seconds per user per problem) to prevent Judge0 flooding.

4. Verify: Submit a problem with 10 test cases — all execute in parallel, total time < 5 seconds. WebSocket updates arrive in real-time on frontend.

---

### Task 19: Frontend — Mobile Responsiveness & Accessibility

**Objective:** Ensure the app is usable on tablets and accessible.

**Files:**
- Modify: All page components
- Create: `frontend/src/components/shared/mobile-nav.tsx`

**Steps:**

1. Problem workspace: on screens < 1024px, collapse to tabbed layout (Description | Editor | Results) instead of three-panel.

2. Skill tree: add touch-friendly pinch-zoom and pan for tablets. Increase node tap target size on mobile.

3. All interactive elements: minimum 44px touch target, visible focus rings (`focus-visible:ring-2 ring-primary`).

4. Add ARIA labels to all icon-only buttons. Add `role="status"` and `aria-live="polite"` to submission result area.

5. Test with keyboard navigation only — Tab through the entire app, every action reachable.

6. Verify: Load app at 768px width — all pages are usable, no horizontal scroll, no overlapping elements. Lighthouse accessibility score > 90.

---

### Task 20: Docker Compose Production Config & Documentation

**Objective:** Finalize Docker Compose for one-command startup, write comprehensive README.

**Files:**
- Modify: `docker-compose.yml`
- Create: `frontend/Dockerfile`
- Create: `backend/Dockerfile`
- Modify: `README.md`
- Create: `backend/src/main/resources/application-prod.yml`

**Steps:**

1. Create `backend/Dockerfile`:
```dockerfile
FROM gradle:8-jdk21-alpine AS build
WORKDIR /app
COPY . .
RUN gradle bootJar --no-daemon

FROM eclipse-temurin:21-jre-alpine
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

2. Create `frontend/Dockerfile`:
```dockerfile
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/.next/standalone ./
EXPOSE 3000
CMD ["node", "server.js"]
```

3. Create `application-prod.yml` with production-grade settings (connection pooling, JWT expiration, CORS origins).

4. Write `README.md` with:
- Project overview + screenshots placeholder
- Prerequisites (Docker, Java 21, Node 20)
- Quick start: `docker-compose up --build`
- Architecture diagram (text-based)
- API documentation summary
- Problem list summary
- RPG progression explanation
- Development setup for local dev (without Docker)

5. Verify: `docker-compose up --build` starts all services. Visit `localhost:3000` → landing page loads. Register → play through first problem end-to-end.

---

## End-to-End Verification Checklist

After all tasks are complete, verify:

- [ ] `docker-compose up --build` starts postgres, judge0, backend, frontend without errors
- [ ] Register a new user → JWT received, redirected to quest map
- [ ] Skill tree shows 7 realms, Realm 1 nodes unlocked, others locked
- [ ] Click an unlocked node → problem workspace opens with Java starter code
- [ ] Type code in Monaco editor → syntax highlighting works, custom theme applied
- [ ] Click "Run" → sample test cases execute, results show pass/fail
- [ ] Click "Submit" → all test cases run, XP awarded on success, skill tree updates
- [ ] Wrong submission → HP decreases, screen shake animation plays
- [ ] Correct submission → confetti, XP popup, skill tree node turns gold
- [ ] Complete all nodes in a realm → boss node unlocks
- [ ] Level up → level-up overlay animation plays
- [ ] Profile page shows character card, stats, achievements
- [ ] Leaderboard shows ranked users
- [ ] Hints can be unlocked (HP cost deducted)
- [ ] Static hints unlock progressively (can't skip Layer 2 to get Layer 3)
- [ ] Dynamic hint analyzes failed submission — compile errors get translated to plain English
- [ ] Dynamic hint for wrong answer identifies specific edge case (empty input, negatives, etc.)
- [ ] Dynamic hint for TLE suggests target time complexity based on problem constraints
- [ ] Dynamic hint for runtime errors translates Java exceptions to beginner-friendly text
- [ ] Pattern hints appear automatically when user has solved a related problem
- [ ] Typewriter animation plays when hint content is revealed
- [ ] HP cost floating animation plays when hint is unlocked
- [ ] Streak multiplier applies XP bonus correctly
- [ ] Dark theme is cohesive across all pages — no contrast issues
- [ ] Mobile (768px) — all pages usable without horizontal scroll
- [ ] Lighthouse: Performance > 80, Accessibility > 90, Best Practices > 90

---

## Risks & Tradeoffs

1. **Judge0 self-hosted security:** Judge0 had CVEs in early 2024 (CVE-2024-28185, CVE-2024-29021 — sandbox escape). Mitigation: use latest version, run in isolated Docker network, never expose Judge0 port publicly. For production, add reverse proxy with auth.

2. **Judge0 resource limits:** Java compilation is CPU/memory heavy. With 10 concurrent test cases per submission, a single user submission could spike resources. Mitigation: queue submissions, limit concurrent submissions per user, set strict `cpu_time_limit` and `memory_limit` on Judge0.

3. **Monaco Editor bundle size:** Monaco is large (~5MB). Mitigation: dynamic import on the problem page only, not on landing/skill tree pages.

4. **Skill tree complexity:** The node-graph layout with SVG connectors is the most complex frontend component. If time-constrained, fall back to a simpler grid/list layout for v1 and add the interactive graph in v2.

5. **Spring Boot vs Node.js backend:** Spring Boot adds build complexity (Gradle, JVM startup) vs a Node.js backend. Tradeoff: Spring Boot is a better showcase for a Java-focused platform and demonstrates Java best practices to learners. The backend IS part of the learning experience.

6. **Real-time submission updates:** WebSocket adds complexity. If time-constrained, use polling (frontend polls `/api/submissions/{id}` every 500ms until status is terminal).

---

## Open Questions

1. **User avatars:** Should we use generated avatars (e.g., DiceBear API) or allow uploads? Recommendation: DiceBear "fantasy" style avatars for the RPG theme, assigned at registration.

2. **Social features:** Should v1 include friend lists, shared solutions, or discussion forums? Recommendation: Skip for v1, add in v2.

3. **Custom problems:** Should users be able to create and share their own problems? Recommendation: Skip for v1, admin-only problem creation.

4. **Multi-language support:** The platform is Java-only per the requirement. Should we add Python/JS later? Recommendation: Java-only for v1, architecture supports adding languages via Judge0 `language_id`.