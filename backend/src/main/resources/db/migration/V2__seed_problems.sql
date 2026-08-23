-- V2__seed_problems.sql — All 70 problems for myCodeQuest

INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'hello-java', 'Hello, Java!', '# Hello, Java!

Welcome to your first coding quest! Your task is simple: print `Hello, World!` to the standard output.

## Examples

**Input:** No input required.
**Output:**
```
Hello, World!
```

## Constraints

- No input is given.
- Output must match exactly (case-sensitive, including punctuation).', 'EASY', 50, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', 'public class Solution {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'sum-of-two-numbers', 'Sum of Two Numbers', '# Sum of Two Numbers

Read two integers from standard input and print their sum.

## Examples

**Input:**
```
3 5
```
**Output:**
```
8
```

**Input:**
```
-10 20
```
**Output:**
```
10
```

## Constraints

- Both integers are in the range -10^9 to 10^9.', 'EASY', 50, 2, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        System.out.println(a + b);
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'even-or-odd', 'Even or Odd', '# Even or Odd

Read an integer from standard input and print "Even" if the number is even, or "Odd" if the number is odd.

## Examples

**Input:**
```
4
```
**Output:**
```
Even
```

**Input:**
```
7
```
**Output:**
```
Odd
```

## Constraints

- The integer is in the range -10^9 to 10^9.', 'EASY', 50, 3, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if (n % 2 == 0) {
            System.out.println("Even");
        } else {
            System.out.println("Odd");
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'multiplication-table', 'Multiplication Table', '# Multiplication Table

Read an integer N from standard input and print its multiplication table from 1 to 10. Each line should show: `N x i = result`

## Examples

**Input:**
```
5
```
**Output:**
```
5 x 1 = 5
5 x 2 = 10
5 x 3 = 15
5 x 4 = 20
5 x 5 = 25
5 x 6 = 30
5 x 7 = 35
5 x 8 = 40
5 x 9 = 45
5 x 10 = 50
```

## Constraints

- 1 <= N <= 100', 'EASY', 75, 4, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        for (int i = 1; i <= 10; i++) {
            System.out.println(n + " x " + i + " = " + (n * i));
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'factorial', 'Factorial', '# Factorial

Read a non-negative integer N and compute its factorial (N!). The factorial of N is the product of all positive integers from 1 to N. By definition, 0! = 1.

## Examples

**Input:**
```
5
```
**Output:**
```
120
```

**Input:**
```
0
```
**Output:**
```
1
```

## Constraints

- 0 <= N <= 20 (use long to avoid overflow)', 'EASY', 75, 5, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result *= i;
        }
        System.out.println(result);
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'palindrome-number', 'Palindrome Number', '# Palindrome Number

Read an integer N and determine if it is a palindrome. A palindrome number reads the same forwards and backwards. Print "true" or "false".

## Examples

**Input:**
```
121
```
**Output:**
```
true
```

**Input:**
```
123
```
**Output:**
```
false
```

## Constraints

- 0 <= N <= 2^31 - 1
- Negative numbers are not palindromes.', 'EASY', 100, 6, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if (n < 0) {
            System.out.println("false");
            return;
        }
        int original = n;
        int reversed = 0;
        while (n > 0) {
            reversed = reversed * 10 + n % 10;
            n /= 10;
        }
        System.out.println(original == reversed ? "true" : "false");
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'fizzbuzz', 'FizzBuzz', '# FizzBuzz

Read an integer N and print numbers from 1 to N. But for multiples of 3, print "Fizz" instead of the number. For multiples of 5, print "Buzz". For numbers that are multiples of both 3 and 5, print "FizzBuzz".

## Examples

**Input:**
```
15
```
**Output:**
```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
```

## Constraints

- 1 <= N <= 10000', 'EASY', 100, 7, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            if (i % 15 == 0) System.out.println("FizzBuzz");
            else if (i % 3 == 0) System.out.println("Fizz");
            else if (i % 5 == 0) System.out.println("Buzz");
            else System.out.println(i);
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'reverse-a-string', 'Reverse a String', '# Reverse a String

Read a string from standard input and print its reverse.

## Examples

**Input:**
```
hello
```
**Output:**
```
olleh
```

**Input:**
```
Java
```
**Output:**
```
avaJ
```

## Constraints

- String length is between 1 and 1000 characters.
- The string contains only printable ASCII characters (no spaces).', 'EASY', 100, 8, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();
        StringBuilder sb = new StringBuilder(s);
        System.out.println(sb.reverse().toString());
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'count-digits', 'Count Digits', '# Count Digits

Read a non-negative integer N and count how many digits it has.

## Examples

**Input:**
```
12345
```
**Output:**
```
5
```

**Input:**
```
7
```
**Output:**
```
1
```

## Constraints

- 0 <= N <= 10^18 (use long)', 'EASY', 100, 9, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        long n = sc.nextLong();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        long n = sc.nextLong();
        if (n == 0) {
            System.out.println(1);
            return;
        }
        int count = 0;
        while (n > 0) {
            count++;
            n /= 10;
        }
        System.out.println(count);
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(1, 'fizzbuzz-ultimate', 'FizzBuzz Ultimate', '# BOSS: FizzBuzz Ultimate

The classic FizzBuzz, but with a twist! Read three integers: N (the range), F (the Fizz divisor), and B (the Buzz divisor). Print numbers from 1 to N. For multiples of F, print "Fizz". For multiples of B, print "Buzz". For multiples of both F and B, print "FizzBuzz".

## Examples

**Input:**
```
15 3 5
```
**Output:**
```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
```

**Input:**
```
10 2 7
```
**Output:**
```
1
Fizz
3
Fizz
5
Fizz
Buzz
Fizz
9
Fizz
```

## Constraints

- 1 <= N <= 100000
- 2 <= F, B <= 100
- F != B', 'EASY', 200, 10, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int f = sc.nextInt();
        int b = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int f = sc.nextInt();
        int b = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            if (i % f == 0 && i % b == 0) System.out.println("FizzBuzz");
            else if (i % f == 0) System.out.println("Fizz");
            else if (i % b == 0) System.out.println("Buzz");
            else System.out.println(i);
        }
    }
}', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'max-element-in-array', 'Max Element in Array', '# Max Element in Array

Read N integers from standard input (first number is N, followed by N integers). Find and print the maximum element.

## Examples

**Input:**
```
5
3 7 2 9 1
```
**Output:**
```
9
```

## Constraints

- 1 <= N <= 1000
- -10^9 <= elements <= 10^9', 'EASY', 100, 1, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int max = arr[0];
        for (int i = 1; i < n; i++) {
            if (arr[i] > max) max = arr[i];
        }
        System.out.println(max);
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'second-largest', 'Second Largest', '# Second Largest

Read N integers and find the second largest distinct element in the array. If there is no second largest (all elements are the same or N < 2), print "-1".

## Examples

**Input:**
```
5
3 7 2 9 1
```
**Output:**
```
7
```

**Input:**
```
3
5 5 5
```
**Output:**
```
-1
```

## Constraints

- 2 <= N <= 1000
- -10^9 <= elements <= 10^9', 'MEDIUM', 120, 2, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int largest = Integer.MIN_VALUE;
        int second = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            if (arr[i] > largest) {
                second = largest;
                largest = arr[i];
            } else if (arr[i] > second && arr[i] != largest) {
                second = arr[i];
            }
        }
        if (second == Integer.MIN_VALUE) {
            System.out.println("-1");
        } else {
            System.out.println(second);
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'remove-duplicates', 'Remove Duplicates from Sorted Array', '# Remove Duplicates from Sorted Array

Read a sorted array of N integers. Remove duplicates in-place and print the unique elements separated by spaces, followed by the count of unique elements on a new line.

## Examples

**Input:**
```
7
1 1 2 2 3 4 4
```
**Output:**
```
1 2 3 4
4
```

## Constraints

- 1 <= N <= 10000
- The array is sorted in non-decreasing order.', 'MEDIUM', 120, 3, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int writeIndex = 1;
        for (int i = 1; i < n; i++) {
            if (arr[i] != arr[i - 1]) {
                arr[writeIndex++] = arr[i];
            }
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < writeIndex; i++) {
            if (i > 0) sb.append(" ");
            sb.append(arr[i]);
        }
        System.out.println(sb.toString());
        System.out.println(writeIndex);
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'two-sum', 'Two Sum', '# Two Sum

Read an array of N integers and a target value T. Find two distinct indices i and j such that arr[i] + arr[j] = T. Print the two indices (1-based, space-separated, smaller index first). It is guaranteed that exactly one solution exists.

## Examples

**Input:**
```
4 9
2 7 11 15
```
**Output:**
```
1 2
```

**Input:**
```
3 6
3 2 3
```
**Output:**
```
1 3
```

## Constraints

- 2 <= N <= 10000
- -10^9 <= arr[i] <= 10^9
- Exactly one solution exists.', 'MEDIUM', 150, 4, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int target = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    }
}', 'import java.util.Scanner;
import java.util.HashMap;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int target = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int complement = target - arr[i];
            if (map.containsKey(complement)) {
                int j = map.get(complement);
                System.out.println((j + 1) + " " + (i + 1));
                return;
            }
            if (!map.containsKey(arr[i])) map.put(arr[i], i);
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'move-zeroes', 'Move Zeroes', '# Move Zeroes

Read an array of N integers. Move all zeroes to the end while maintaining the relative order of non-zero elements. Print the resulting array space-separated.

## Examples

**Input:**
```
5
0 1 0 3 12
```
**Output:**
```
1 3 12 0 0
```

**Input:**
```
1
0
```
**Output:**
```
0
```

## Constraints

- 1 <= N <= 10000', 'MEDIUM', 150, 5, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int insertPos = 0;
        for (int i = 0; i < n; i++) {
            if (arr[i] != 0) {
                arr[insertPos++] = arr[i];
            }
        }
        while (insertPos < n) {
            arr[insertPos++] = 0;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            if (i > 0) sb.append(" ");
            sb.append(arr[i]);
        }
        System.out.println(sb.toString());
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'best-time-buy-sell-stock', 'Best Time to Buy and Sell Stock', '# Best Time to Buy and Sell Stock

Read N stock prices. You may buy on one day and sell on a later day. Find the maximum profit possible. If no profit is possible, print 0.

## Examples

**Input:**
```
6
7 1 5 3 6 4
```
**Output:**
```
5
```

**Input:**
```
5
7 6 4 3 1
```
**Output:**
```
0
```

## Constraints

- 1 <= N <= 100000
- 0 <= prices[i] <= 10000', 'MEDIUM', 150, 6, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] prices = new int[n];
        for (int i = 0; i < n; i++) {
            prices[i] = sc.nextInt();
        }
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] prices = new int[n];
        for (int i = 0; i < n; i++) prices[i] = sc.nextInt();
        int minPrice = Integer.MAX_VALUE;
        int maxProfit = 0;
        for (int i = 0; i < n; i++) {
            if (prices[i] < minPrice) {
                minPrice = prices[i];
            } else if (prices[i] - minPrice > maxProfit) {
                maxProfit = prices[i] - minPrice;
            }
        }
        System.out.println(maxProfit);
    
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'merge-sorted-arrays', 'Merge Sorted Arrays', '# Merge Sorted Arrays

Read two sorted arrays A (size M) and B (size N). Merge them into a single sorted array and print the result space-separated.

## Examples

**Input:**
```
3 3
1 3 5
2 4 6
```
**Output:**
```
1 2 3 4 5 6
```

## Constraints

- 1 <= M, N <= 10000
- Arrays are sorted in non-decreasing order.', 'MEDIUM', 180, 7, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int m = sc.nextInt();
        int n = sc.nextInt();
        int[] a = new int[m];
        int[] b = new int[n];
        for (int i = 0; i < m; i++) a[i] = sc.nextInt();
        for (int i = 0; i < n; i++) b[i] = sc.nextInt();
        // Your code here
    }
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int m = sc.nextInt(), n = sc.nextInt();
        int[] a = new int[m], b = new int[n];
        for (int i = 0; i < m; i++) a[i] = sc.nextInt();
        for (int i = 0; i < n; i++) b[i] = sc.nextInt();
        int[] merged = new int[m + n];
        int i = 0, j = 0, k = 0;
        while (i < m && j < n) {
            if (a[i] <= b[j]) merged[k++] = a[i++];
            else merged[k++] = b[j++];
        }
        while (i < m) merged[k++] = a[i++];
        while (j < n) merged[k++] = b[j++];
        StringBuilder sb = new StringBuilder();
        for (int x = 0; x < m + n; x++) {
            if (x > 0) sb.append(" ");
            sb.append(merged[x]);
        }
        System.out.println(sb.toString());
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'rotate-array', 'Rotate Array', '# Rotate Array

Read an array of N integers and a rotation count K. Rotate the array to the right by K positions. Print the resulting array space-separated.

## Examples

**Input:**
```
7 3
1 2 3 4 5 6 7
```
**Output:**
```
5 6 7 1 2 3 4
```

## Constraints

- 1 <= N <= 10000
- 0 <= K <= 10^9 (K can be larger than N, so use K % N)', 'MEDIUM', 180, 8, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int k = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int k = sc.nextInt() % n;
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        reverse(arr, 0, n - 1);
        reverse(arr, 0, k - 1);
        reverse(arr, k, n - 1);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            if (i > 0) sb.append(" ");
            sb.append(arr[i]);
        }
        System.out.println(sb.toString());
    }
    static void reverse(int[] arr, int left, int right) {
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'pascals-triangle', 'Pascal''s Triangle', '# Pascal''s Triangle

Read an integer N and print the first N rows of Pascal''''s triangle. Each row''''s elements are space-separated, and each row is on a new line.

## Examples

**Input:**
```
5
```
**Output:**
```
1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
```

## Constraints

- 1 <= N <= 30', 'MEDIUM', 180, 9, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[][] triangle = new int[n][];
        for (int i = 0; i < n; i++) {
            triangle[i] = new int[i + 1];
            triangle[i][0] = 1;
            triangle[i][i] = 1;
            for (int j = 1; j < i; j++) {
                triangle[i][j] = triangle[i-1][j-1] + triangle[i-1][j];
            }
        }
        for (int i = 0; i < n; i++) {
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j <= i; j++) {
                if (j > 0) sb.append(" ");
                sb.append(triangle[i][j]);
            }
            System.out.println(sb.toString());
        }
    
}', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(2, 'maximum-subarray', 'BOSS: Maximum Subarray (Kadane''s)', '# BOSS: Maximum Subarray

Read an array of N integers. Find the contiguous subarray with the largest sum and print that sum.

## Examples

**Input:**
```
9
-2 1 -3 4 -1 2 1 -5 4
```
**Output:**
```
6
```

**Input:**
```
1
5
```
**Output:**
```
5
```

## Constraints

- 1 <= N <= 100000
- -10^4 <= arr[i] <= 10^4', 'HARD', 300, 10, 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }
        // Your code here
    
}', 'import java.util.Scanner;

public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int maxSoFar = arr[0];
        int currentMax = arr[0];
        for (int i = 1; i < n; i++) {
            currentMax = Math.max(arr[i], currentMax + arr[i]);
            maxSoFar = Math.max(maxSoFar, currentMax);
        }
        System.out.println(maxSoFar);
    
}', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'valid-anagram', 'Valid Anagram', 'Given two strings s and t, return true if t is an anagram of s, and false otherwise.

Example:
Input: s = "anagram", t = "nagaram"
Output: true', 'EASY', 150, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Valid Anagram
// Implement the algorithm for: Given two strings s and t, return true if t is an anagram of...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'valid-palindrome', 'Valid Palindrome', 'Given a string s, return true if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Example:
Input: s = "A man, a plan, a canal: Panama"
Output: true', 'EASY', 150, 2, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Valid Palindrome
// Implement the algorithm for: Given a string s, return true if it is a palindrome, conside...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'longest-common-prefix', 'Longest Common Prefix', 'Write a function to find the longest common prefix string amongst an array of strings.

Example:
Input: ["flower","flow","flight"]
Output: "fl"', 'MEDIUM', 180, 3, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Longest Common Prefix
// Implement the algorithm for: Write a function to find the longest common prefix string am...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'length-of-last-word', 'Length of Last Word', 'Given a string s consisting of words and spaces, return the length of the last word.

Example:
Input: s = "Hello World"
Output: 5', 'EASY', 150, 4, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Length of Last Word
// Implement the algorithm for: Given a string s consisting of words and spaces, return the ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'count-and-say', 'Count and Say', 'The count-and-say sequence is a sequence of digit strings defined recursively.

Example:
Input: n = 4
Output: "1211"', 'MEDIUM', 200, 5, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Count and Say
// Implement the algorithm for: The count-and-say sequence is a sequence of digit strings de...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'roman-to-integer', 'Roman to Integer', 'Given a roman numeral, convert it to an integer.

Example:
Input: s = "III"
Output: 3', 'EASY', 200, 6, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Roman to Integer
// Implement the algorithm for: Given a roman numeral, convert it to an integer.

Example:
I...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'implement-strstr', 'Implement strStr()', 'Given two strings needle and haystack, return the index of the first occurrence of needle in haystack.

Example:
Input: haystack = "sadbutsad", needle = "sad"
Output: 0', 'EASY', 200, 7, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Implement strStr()
// Implement the algorithm for: Given two strings needle and haystack, return the index of t...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'group-anagrams', 'Group Anagrams', 'Given an array of strings strs, group the anagrams together.

Example:
Input: ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]', 'MEDIUM', 250, 8, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Group Anagrams
// Implement the algorithm for: Given an array of strings strs, group the anagrams together....', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'longest-substring-no-repeat', 'Longest Substring Without Repeating Characters', 'Given a string s, find the length of the longest substring without repeating characters.

Example:
Input: s = "abcabcbb"
Output: 3', 'MEDIUM', 250, 9, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Longest Substring Without Repeating Characters
// Implement the algorithm for: Given a string s, find the length of the longest substring w...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(3, 'min-window-substring', 'Minimum Window Substring', 'Given two strings s and t, return the minimum window substring of s that contains all characters of t.

Example:
Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"', 'HARD', 350, 10, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Minimum Window Substring
// Implement the algorithm for: Given two strings s and t, return the minimum window substri...', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'bubble-sort', 'Bubble Sort', 'Implement bubble sort on an array of integers.

Example:
Input: [5,2,8,1,9]
Output: [1,2,5,8,9]', 'EASY', 150, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Bubble Sort
// Implement the algorithm for: Implement bubble sort on an array of integers.

Example:
Inp...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'selection-sort', 'Selection Sort', 'Implement selection sort on an array of integers.

Example:
Input: [64,25,12,22,11]
Output: [11,12,22,25,64]', 'EASY', 150, 2, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Selection Sort
// Implement the algorithm for: Implement selection sort on an array of integers.

Example:
...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'insertion-sort', 'Insertion Sort', 'Implement insertion sort on an array of integers.

Example:
Input: [12,11,13,5,6]
Output: [5,6,11,12,13]', 'EASY', 180, 3, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Insertion Sort
// Implement the algorithm for: Implement insertion sort on an array of integers.

Example:
...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'merge-sort', 'Merge Sort', 'Implement merge sort on an array of integers.

Example:
Input: [38,27,43,3,9,82,10]
Output: [3,9,10,27,38,43,82]', 'MEDIUM', 250, 4, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Merge Sort
// Implement the algorithm for: Implement merge sort on an array of integers.

Example:
Inpu...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'quick-sort', 'Quick Sort', 'Implement quick sort on an array of integers.

Example:
Input: [10,7,8,9,1,5]
Output: [1,5,7,8,9,10]', 'MEDIUM', 250, 5, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Quick Sort
// Implement the algorithm for: Implement quick sort on an array of integers.

Example:
Inpu...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'binary-search', 'Binary Search', 'Given a sorted array and a target, return the index of target, or -1 if not found.

Example:
Input: [-1,0,3,5,9,12], target = 9
Output: 4', 'EASY', 150, 6, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Binary Search
// Implement the algorithm for: Given a sorted array and a target, return the index of targe...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'first-bad-version', 'First Bad Version', 'You have n versions [1, 2, ..., n]. Find the first bad version.

Example:
Input: n = 5, bad = 4
Output: 4', 'EASY', 180, 7, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for First Bad Version
// Implement the algorithm for: You have n versions [1, 2, ..., n]. Find the first bad versi...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'search-insert-position', 'Search Insert Position', 'Given a sorted array and a target, return the index where it should be inserted.

Example:
Input: [1,3,5,6], target = 5
Output: 2', 'EASY', 180, 8, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Search Insert Position
// Implement the algorithm for: Given a sorted array and a target, return the index where it...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'sort-colors', 'Sort Colors', 'Sort an array of 0s, 1s, and 2s in-place (Dutch National Flag problem).

Example:
Input: [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]', 'MEDIUM', 250, 9, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Sort Colors
// Implement the algorithm for: Sort an array of 0s, 1s, and 2s in-place (Dutch National Fla...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(4, 'kth-largest-element', 'Kth Largest Element', 'Find the kth largest element in an unsorted array.

Example:
Input: [3,2,1,5,6,4], k = 2
Output: 5', 'HARD', 350, 10, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Kth Largest Element
// Implement the algorithm for: Find the kth largest element in an unsorted array.

Example:...', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'contains-duplicate', 'Contains Duplicate', 'Given an integer array, return true if any value appears at least twice.

Example:
Input: [1,2,3,1]
Output: true', 'EASY', 120, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Contains Duplicate
// Implement the algorithm for: Given an integer array, return true if any value appears at ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'single-number', 'Single Number', 'Given a non-empty array of integers, every element appears twice except one. Find that single one.

Example:
Input: [4,1,2,1,2]
Output: 4', 'EASY', 150, 2, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Single Number
// Implement the algorithm for: Given a non-empty array of integers, every element appears t...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'intersection-two-arrays', 'Intersection of Two Arrays', 'Given two integer arrays, return their intersection.

Example:
Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2]', 'EASY', 150, 3, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Intersection of Two Arrays
// Implement the algorithm for: Given two integer arrays, return their intersection.

Exampl...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'happy-number', 'Happy Number', 'A happy number is defined by a process of summing squared digits. Determine if n is happy.

Example:
Input: n = 19
Output: true', 'EASY', 180, 4, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Happy Number
// Implement the algorithm for: A happy number is defined by a process of summing squared di...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'isomorphic-strings', 'Isomorphic Strings', 'Given two strings s and t, determine if they are isomorphic.

Example:
Input: s = "egg", t = "add"
Output: true', 'EASY', 180, 5, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Isomorphic Strings
// Implement the algorithm for: Given two strings s and t, determine if they are isomorphic....', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'word-pattern', 'Word Pattern', 'Given a pattern and a string s, determine if s follows the pattern.

Example:
Input: pattern = "abba", s = "dog cat cat dog"
Output: true', 'EASY', 200, 6, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Word Pattern
// Implement the algorithm for: Given a pattern and a string s, determine if s follows the p...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'first-unique-char', 'First Unique Character', 'Given a string, find the first non-repeating character and return its index.

Example:
Input: s = "leetcode"
Output: 0', 'EASY', 200, 7, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for First Unique Character
// Implement the algorithm for: Given a string, find the first non-repeating character and r...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'frequency-sort', 'Sort Characters By Frequency', 'Given a string s, sort it in decreasing order based on frequency of characters.

Example:
Input: s = "tree"
Output: "eert"', 'MEDIUM', 250, 8, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Sort Characters By Frequency
// Implement the algorithm for: Given a string s, sort it in decreasing order based on frequ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'top-k-frequent', 'Top K Frequent Elements', 'Given an integer array and integer k, return the k most frequent elements.

Example:
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]', 'MEDIUM', 250, 9, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Top K Frequent Elements
// Implement the algorithm for: Given an integer array and integer k, return the k most freq...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(5, 'longest-consecutive', 'Longest Consecutive Sequence', 'Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

Example:
Input: [100,4,200,1,3,2]
Output: 4 (sequence: 1,2,3,4)', 'HARD', 350, 10, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Longest Consecutive Sequence
// Implement the algorithm for: Given an unsorted array of integers, find the length of the ...', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'reverse-linked-list', 'Reverse Linked List', 'Given the head of a singly linked list, reverse it.

Example:
Input: 1->2->3->4->5
Output: 5->4->3->2->1', 'MEDIUM', 200, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Reverse Linked List
// Implement the algorithm for: Given the head of a singly linked list, reverse it.

Example...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'merge-two-sorted-lists', 'Merge Two Sorted Lists', 'Merge two sorted linked lists into one sorted list.

Example:
Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4', 'MEDIUM', 200, 2, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Merge Two Sorted Lists
// Implement the algorithm for: Merge two sorted linked lists into one sorted list.

Example...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'linked-list-cycle', 'Linked List Cycle', 'Given head of a linked list, determine if it has a cycle.

Example:
Input: head = [3,2,0,-4], pos = 1
Output: true', 'MEDIUM', 250, 3, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Linked List Cycle
// Implement the algorithm for: Given head of a linked list, determine if it has a cycle.

E...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'remove-nth-from-end', 'Remove Nth Node From End', 'Given the head of a linked list, remove the nth node from the end.

Example:
Input: 1->2->3->4->5, n = 2
Output: 1->2->3->5', 'MEDIUM', 250, 4, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Remove Nth Node From End
// Implement the algorithm for: Given the head of a linked list, remove the nth node from th...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'palindrome-linked-list', 'Palindrome Linked List', 'Given the head of a singly linked list, determine if it is a palindrome.

Example:
Input: 1->2->2->1
Output: true', 'MEDIUM', 250, 5, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Palindrome Linked List
// Implement the algorithm for: Given the head of a singly linked list, determine if it is a...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'middle-linked-list', 'Middle of Linked List', 'Given the head of a singly linked list, return the middle node.

Example:
Input: 1->2->3->4->5
Output: 3', 'EASY', 200, 6, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Middle of Linked List
// Implement the algorithm for: Given the head of a singly linked list, return the middle no...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'delete-node-linked-list', 'Delete Node in Linked List', 'Given a node in a singly linked list, delete it (you have access to the node only).

Example:
Input: node with value 5 in 4->5->1->9
Output: 4->1->9', 'EASY', 150, 7, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Delete Node in Linked List
// Implement the algorithm for: Given a node in a singly linked list, delete it (you have ac...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'intersection-linked-lists', 'Intersection of Two Linked Lists', 'Given the heads of two singly linked lists, find the node where they intersect.

Example:
Input: intersectVal = 8
Output: Reference to node with value 8', 'MEDIUM', 250, 8, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Intersection of Two Linked Lists
// Implement the algorithm for: Given the heads of two singly linked lists, find the node wh...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'copy-list-random-pointer', 'Copy List with Random Pointer', 'A linked list with a random pointer. Return a deep copy.

Example:
Input: [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: Deep copy', 'HARD', 300, 9, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Copy List with Random Pointer
// Implement the algorithm for: A linked list with a random pointer. Return a deep copy.

Ex...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(6, 'merge-k-sorted-lists', 'Merge K Sorted Lists', 'Given an array of k sorted linked lists, merge them into one sorted list.

Example:
Input: [1->4->5, 1->3->4, 2->6]
Output: 1->1->2->3->4->4->5->6', 'HARD', 400, 10, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Merge K Sorted Lists
// Implement the algorithm for: Given an array of k sorted linked lists, merge them into one...', TRUE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'max-depth-binary-tree', 'Maximum Depth of Binary Tree', 'Given the root of a binary tree, return its maximum depth.

Example:
Input: [3,9,20,null,null,15,7]
Output: 3', 'EASY', 200, 1, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Maximum Depth of Binary Tree
// Implement the algorithm for: Given the root of a binary tree, return its maximum depth.

...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'invert-binary-tree', 'Invert Binary Tree', 'Given the root of a binary tree, invert it (mirror it).

Example:
Input: [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]', 'EASY', 200, 2, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Invert Binary Tree
// Implement the algorithm for: Given the root of a binary tree, invert it (mirror it).

Exa...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'symmetric-tree', 'Symmetric Tree', 'Given the root of a binary tree, check if it is a mirror of itself.

Example:
Input: [1,2,2,3,4,4,3]
Output: true', 'EASY', 250, 3, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Symmetric Tree
// Implement the algorithm for: Given the root of a binary tree, check if it is a mirror of ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'path-sum', 'Path Sum', 'Given a binary tree and a target sum, determine if there is a root-to-leaf path with that sum.

Example:
Input: [5,4,8,11,null,13,4,7,2,null,null,null,1], targetSum = 22
Output: true', 'EASY', 250, 4, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Path Sum
// Implement the algorithm for: Given a binary tree and a target sum, determine if there is ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'level-order-traversal', 'Binary Tree Level Order Traversal', 'Given the root of a binary tree, return the level order traversal.

Example:
Input: [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]', 'MEDIUM', 250, 5, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Binary Tree Level Order Traversal
// Implement the algorithm for: Given the root of a binary tree, return the level order trav...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'validate-bst', 'Validate Binary Search Tree', 'Given the root of a binary tree, determine if it is a valid BST.

Example:
Input: [2,1,3]
Output: true', 'MEDIUM', 300, 6, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Validate Binary Search Tree
// Implement the algorithm for: Given the root of a binary tree, determine if it is a valid ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'lowest-common-ancestor', 'Lowest Common Ancestor', 'Given a binary tree, find the lowest common ancestor of two nodes.

Example:
Input: root=[3,5,1,6,2,0,8], p=5, q=1
Output: 3', 'MEDIUM', 300, 7, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Lowest Common Ancestor
// Implement the algorithm for: Given a binary tree, find the lowest common ancestor of two ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'construct-tree-inorder-postorder', 'Construct Binary Tree from Inorder+Postorder', 'Given inorder and postorder traversal, construct the binary tree.

Example:
Input: inorder=[9,3,15,20,7], postorder=[9,15,7,20,3]
Output: [3,9,20,null,null,15,7]', 'HARD', 350, 8, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Construct Binary Tree from Inorder+Postorder
// Implement the algorithm for: Given inorder and postorder traversal, construct the binary ...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'serialize-deserialize-tree', 'Serialize and Deserialize Binary Tree', 'Design an algorithm to serialize and deserialize a binary tree.

Example:
Input: [1,2,3,null,null,4,5]
Output: Same tree after deserialize', 'HARD', 350, 9, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Serialize and Deserialize Binary Tree
// Implement the algorithm for: Design an algorithm to serialize and deserialize a binary tr...', FALSE, 2000, 256000);
INSERT INTO problems (realm_id, slug, title, description, difficulty, xp_reward, order_in_realm, starter_code, solution_code, is_boss, time_limit_ms, memory_limit_kb) VALUES
(7, 'word-ladder', 'Word Ladder', 'Given two words beginWord and endWord and a dictionary, find the shortest transformation sequence.

Example:
Input: beginWord="hit", endWord="cog", wordList=["hot","dot","dog","lot","log","cog"]
Output: 5 (hit->hot->dot->dog->cog)', 'HARD', 500, 10, 'public class Solution {
    public static void main(String[] args) {
        // Your code here
    }
}', '// Solution for Word Ladder
// Implement the algorithm for: Given two words beginWord and endWord and a dictionary, find...', TRUE, 2000, 256000);