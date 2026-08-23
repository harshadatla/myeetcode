-- V5__seed_hints.sql — 5 hint layers per problem (350 total)

INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', 'This is the simplest quest — you just need to print something to the screen. Java uses System.out.println() to print a line of text.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', 'Algorithm: Direct Output. Use System.out.println() and pass the exact string "Hello, World!" as the argument. Don''''t forget the semicolon!', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', '```
BEGIN
  PRINT "Hello, World!"
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', '```java
public class Solution {
    public static void main(String[] args) {
        // TODO: Use System.out.println to print "Hello, World!"
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(1, 1, 'The Compass', '🧭', '```java
public class Solution {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(2, 1, 'The Compass', '🧭', 'You need to read two numbers and add them together. Java''''s Scanner class can read integers from stdin. The + operator adds numbers.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(2, 1, 'The Compass', '🧭', 'Algorithm: Arithmetic Addition. Steps: (1) Read two integers using Scanner. (2) Add them with the + operator. (3) Print the result with System.out.println().', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(2, 1, 'The Compass', '🧭', '```
BEGIN
  READ a, b
  result = a + b
  PRINT result
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(2, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        // TODO: Print a + b
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(2, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int a = sc.nextInt();
        int b = sc.nextInt();
        System.out.println(a + b);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(3, 1, 'The Compass', '🧭', 'A number is even if it''''s divisible by 2 with no remainder. The modulo operator % gives you the remainder of division. Think about what n % 2 tells you.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(3, 1, 'The Compass', '🧭', 'Algorithm: Modulo Check. Steps: (1) Read integer n. (2) Check if n % 2 equals 0. (3) If true, print "Even". (4) Otherwise print "Odd".', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(3, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  IF n MOD 2 == 0 THEN
    PRINT "Even"
  ELSE
    PRINT "Odd"
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(3, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // TODO: if (n % 2 == 0) print "Even" else print "Odd"
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(3, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if (n % 2 == 0) System.out.println("Even");
        else System.out.println("Odd");
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(4, 1, 'The Compass', '🧭', 'You need to print 10 lines, each showing n multiplied by a number from 1 to 10. A for loop running from 1 to 10 is perfect here. String concatenation with + can build the output format.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(4, 1, 'The Compass', '🧭', 'Algorithm: For Loop + String Concatenation. Steps: (1) Read n. (2) Loop i from 1 to 10. (3) Print n + " x " + i + " = " + (n*i) each iteration.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(4, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  FOR i = 1 TO 10
    PRINT n, " x ", i, " = ", n*i
  END FOR
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(4, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        // TODO: for loop from 1 to 10, print "n x i = n*i"
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(4, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        for (int i = 1; i <= 10; i++) {
            System.out.println(n + " x " + i + " = " + (n * i));
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(5, 1, 'The Compass', '🧭', 'Factorial means multiplying all numbers from 1 to N together. You can use a for loop to multiply, or think about it recursively: N! = N * (N-1)!. Don''''t forget the base case 0! = 1.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(5, 1, 'The Compass', '🧭', 'Algorithm: Iterative Multiplication. Steps: (1) Initialize result = 1 (use long). (2) Loop from 2 to N. (3) Multiply result by each number. (4) Print result. Note: use long, not int, to handle large results.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(5, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  result = 1
  FOR i = 2 TO n
    result = result * i
  END FOR
  PRINT result
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(5, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        long result = 1;
        // TODO: loop from 2 to n, multiply result by i
        System.out.println(result);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(5, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        long result = 1;
        for (int i = 2; i <= n; i++) result *= i;
        System.out.println(result);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(6, 1, 'The Compass', '🧭', 'A palindrome reads the same forwards and backwards. To check this, you can reverse the number digit by digit and compare the reversed version to the original. The modulo operator % 10 extracts the last digit, and division / 10 removes it.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(6, 1, 'The Compass', '🧭', 'Algorithm: Digit Reversal. Steps: (1) Handle negative numbers (not palindromes). (2) Reverse the number using a while loop: extract last digit with %10, build reversed with *10+digit, remove last digit with /10. (3) Compare reversed to original.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(6, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  IF n < 0 THEN PRINT "false"
  original = n
  reversed = 0
  WHILE n > 0
    digit = n MOD 10
    reversed = reversed * 10 + digit
    n = n / 10
  END WHILE
  IF original == reversed THEN PRINT "true" ELSE PRINT "false"
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(6, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if (n < 0) { System.out.println("false"); return; }
        int original = n;
        int reversed = 0;
        // TODO: while n > 0, build reversed from n%10
        System.out.println(original == reversed ? "true" : "false");
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(6, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        if (n < 0) { System.out.println("false"); return; }
        int original = n, reversed = 0;
        while (n > 0) { reversed = reversed * 10 + n % 10; n /= 10; }
        System.out.println(original == reversed ? "true" : "false");
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(7, 1, 'The Compass', '🧭', 'The classic FizzBuzz! Loop from 1 to N. Check divisibility using the % (modulo) operator. The key is to check the most specific condition first (both 3 AND 5) before checking individual ones.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(7, 1, 'The Compass', '🧭', 'Algorithm: Conditional Branching. Steps: (1) Loop i from 1 to N. (2) If i % 15 == 0 (divisible by both 3 and 5), print "FizzBuzz". (3) Else if i % 3 == 0, print "Fizz". (4) Else if i % 5 == 0, print "Buzz". (5) Else print i.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(7, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  FOR i = 1 TO n
    IF i MOD 15 == 0 THEN PRINT "FizzBuzz"
    ELSE IF i MOD 3 == 0 THEN PRINT "Fizz"
    ELSE IF i MOD 5 == 0 THEN PRINT "Buzz"
    ELSE PRINT i
  END FOR
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(7, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            // TODO: check i%15, then i%3, then i%5, else print i
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(7, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
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
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(8, 1, 'The Compass', '🧭', 'You need to reverse a string. Java''''s StringBuilder class has a built-in reverse() method that makes this trivial. Alternatively, you could loop from the end of the string to the beginning.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(8, 1, 'The Compass', '🧭', 'Algorithm: StringBuilder Reverse. Steps: (1) Read the string. (2) Create a StringBuilder from the string. (3) Call reverse() on the StringBuilder. (4) Convert back to String and print.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(8, 1, 'The Compass', '🧭', '```
BEGIN
  READ s
  sb = new StringBuilder(s)
  sb.reverse()
  PRINT sb.toString()
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(8, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();
        // TODO: use StringBuilder to reverse and print
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(8, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String s = sc.next();
        System.out.println(new StringBuilder(s).reverse().toString());
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(9, 1, 'The Compass', '🧭', 'To count digits, you can repeatedly divide the number by 10 until it becomes 0. Each division removes one digit. Count how many times you divide. Don''''t forget the special case of 0 (which has 1 digit).', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(9, 1, 'The Compass', '🧭', 'Algorithm: Division Counting. Steps: (1) Handle n=0 as special case (1 digit). (2) Initialize count=0. (3) While n>0, divide n by 10 and increment count. (4) Print count.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(9, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  IF n == 0 THEN PRINT 1; STOP
  count = 0
  WHILE n > 0
    count = count + 1
    n = n / 10
  END WHILE
  PRINT count
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(9, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        long n = sc.nextLong();
        if (n == 0) { System.out.println(1); return; }
        int count = 0;
        // TODO: while n > 0, divide n by 10 and count++
        System.out.println(count);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(9, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        long n = sc.nextLong();
        if (n == 0) { System.out.println(1); return; }
        int count = 0;
        while (n > 0) { count++; n /= 10; }
        System.out.println(count);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(10, 1, 'The Compass', '🧭', 'This is FizzBuzz but with custom divisors. Instead of hard-coding 3 and 5, you read F and B from input. The check for both divisors uses F*B or you can check i % f == 0 && i % b == 0.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(10, 1, 'The Compass', '🧭', 'Algorithm: Parameterized FizzBuzz. Steps: (1) Read n, f, b. (2) Loop i from 1 to n. (3) Check i % f == 0 && i % b == 0 first (print "FizzBuzz"). (4) Then check i % f == 0 (print "Fizz"). (5) Then check i % b == 0 (print "Buzz"). (6) Else print i.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(10, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, f, b
  FOR i = 1 TO n
    IF i MOD f == 0 AND i MOD b == 0 THEN PRINT "FizzBuzz"
    ELSE IF i MOD f == 0 THEN PRINT "Fizz"
    ELSE IF i MOD b == 0 THEN PRINT "Buzz"
    ELSE PRINT i
  END FOR
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(10, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), f = sc.nextInt(), b = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            // TODO: check i%f==0 && i%b==0, then i%f==0, then i%b==0, else print i
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(10, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), f = sc.nextInt(), b = sc.nextInt();
        for (int i = 1; i <= n; i++) {
            if (i % f == 0 && i % b == 0) System.out.println("FizzBuzz");
            else if (i % f == 0) System.out.println("Fizz");
            else if (i % b == 0) System.out.println("Buzz");
            else System.out.println(i);
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(11, 1, 'The Compass', '🧭', 'Finding the maximum is a linear scan. Start by assuming the first element is the max, then check each subsequent element. If you find a larger one, update the max.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(11, 1, 'The Compass', '🧭', 'Algorithm: Linear Scan. Steps: (1) Set max = arr[0]. (2) Loop through remaining elements. (3) If any element > max, update max. (4) Print max.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(11, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, arr
  max = arr[0]
  FOR i = 1 TO n-1
    IF arr[i] > max THEN max = arr[i]
  END FOR
  PRINT max
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(11, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int max = arr[0];
        // TODO: loop and find max
        System.out.println(max);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(11, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int max = arr[0];
        for (int i = 1; i < n; i++) if (arr[i] > max) max = arr[i];
        System.out.println(max);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(12, 1, 'The Compass', '🧭', 'Track two variables: the largest and second-largest. As you scan each element, if it''''s bigger than the largest, the old largest becomes the second largest. If it''''s between the second and largest, update just the second.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(12, 1, 'The Compass', '🧭', 'Algorithm: Two-Variable Tracking. Steps: (1) Initialize largest and second to MIN_VALUE. (2) For each element: if > largest, shift largest to second and update largest. Else if > second and != largest, update second. (3) If second is still MIN_VALUE, print -1.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(12, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, arr
  largest = MIN, second = MIN
  FOR each element e:
    IF e > largest THEN second = largest; largest = e
    ELSE IF e > second AND e != largest THEN second = e
  PRINT second (or -1 if still MIN)
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(12, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int largest = Integer.MIN_VALUE, second = Integer.MIN_VALUE;
        // TODO: track largest and second largest, handle ties
        System.out.println(second == Integer.MIN_VALUE ? "-1" : second);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(12, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int l = Integer.MIN_VALUE, s = Integer.MIN_VALUE;
        for (int v : arr) {
            if (v > l) { s = l; l = v; }
            else if (v > s && v != l) { s = v; }
        }
        System.out.println(s == Integer.MIN_VALUE ? "-1" : s);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(13, 1, 'The Compass', '🧭', 'Since the array is sorted, duplicates are always adjacent. Use two pointers: one for reading (scanning through the array) and one for writing (where to place the next unique element). If the current element differs from the previous, it''''s unique.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(13, 1, 'The Compass', '🧭', 'Algorithm: Two-Pointer In-Place. Steps: (1) writeIndex = 1. (2) Loop from index 1 to end. (3) If arr[i] != arr[i-1], copy arr[i] to arr[writeIndex] and increment writeIndex. (4) Print first writeIndex elements and writeIndex.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(13, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, arr
  write = 1
  FOR i = 1 TO n-1
    IF arr[i] != arr[i-1] THEN
      arr[write] = arr[i]; write++
  END FOR
  PRINT arr[0..write-1]
  PRINT write
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(13, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int write = 1;
        // TODO: loop from 1, if arr[i]!=arr[i-1], copy to write position
        // Print unique elements and count
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(13, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int w = 1;
        for (int i = 1; i < n; i++) if (arr[i] != arr[i-1]) arr[w++] = arr[i];
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < w; i++) { if (i > 0) sb.append(" "); sb.append(arr[i]); }
        System.out.println(sb);
        System.out.println(w);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(14, 1, 'The Compass', '🧭', 'For each element, think about what other number you need to reach the target. If target is 9 and current is 2, you need 7. A HashMap lets you check if you''''ve seen 7 before in O(1) time.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(14, 1, 'The Compass', '🧭', 'Algorithm: Hash Map (One Pass). Steps: (1) Create a HashMap. (2) For each element, compute complement = target - arr[i]. (3) If complement exists in map, you found the pair. (4) Otherwise, store arr[i] -> index in map.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(14, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, target, arr
  map = empty HashMap
  FOR i = 0 TO n-1
    complement = target - arr[i]
    IF complement IN map THEN
      PRINT map[complement]+1, i+1
      STOP
    END IF
    map[arr[i]] = i
  END FOR
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(14, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
import java.util.HashMap;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), target = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        HashMap<Integer, Integer> map = new HashMap<>();
        // TODO: check complement in map, else store arr[i]->i
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(14, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
import java.util.HashMap;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), target = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int c = target - arr[i];
            if (map.containsKey(c)) { System.out.println((map.get(c)+1) + " " + (i+1)); return; }
            if (!map.containsKey(arr[i])) map.put(arr[i], i);
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(15, 1, 'The Compass', '🧭', 'Instead of swapping, use a write pointer. Non-zero elements get placed at the write pointer position, which advances. After processing all elements, fill the remaining positions with zeroes.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(15, 1, 'The Compass', '🧭', 'Algorithm: Two-Pointer (Overwrite). Steps: (1) insertPos = 0. (2) Loop through array. (3) If element != 0, copy to arr[insertPos] and increment. (4) After loop, fill rest with 0.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(15, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, arr
  pos = 0
  FOR i = 0 TO n-1
    IF arr[i] != 0 THEN arr[pos] = arr[i]; pos++
  END FOR
  WHILE pos < n: arr[pos] = 0; pos++
  PRINT arr
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(15, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int pos = 0;
        // TODO: move non-zeros to front, fill rest with 0
        // Print result
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(15, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int p = 0;
        for (int i = 0; i < n; i++) if (arr[i] != 0) arr[p++] = arr[i];
        while (p < n) arr[p++] = 0;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) { if (i > 0) sb.append(" "); sb.append(arr[i]); }
        System.out.println(sb);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(16, 1, 'The Compass', '🧭', 'Track the minimum price seen so far. For each day, calculate the profit if you sold at the current price (current - minPrice). Keep track of the maximum profit seen.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(16, 1, 'The Compass', '🧭', 'Algorithm: Single-Pass Tracking. Steps: (1) minPrice = MAX_VALUE, maxProfit = 0. (2) For each price: if < minPrice, update minPrice. Else if price - minPrice > maxProfit, update maxProfit. (3) Print maxProfit.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(16, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, prices
  minPrice = MAX
  maxProfit = 0
  FOR each price p:
    IF p < minPrice THEN minPrice = p
    ELSE IF p - minPrice > maxProfit THEN maxProfit = p - minPrice
  PRINT maxProfit
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(16, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] p = new int[n];
        for (int i = 0; i < n; i++) p[i] = sc.nextInt();
        int minP = Integer.MAX_VALUE, maxP = 0;
        // TODO: track min price, update max profit
        System.out.println(maxP);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(16, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] p = new int[n];
        for (int i = 0; i < n; i++) p[i] = sc.nextInt();
        int minP = Integer.MAX_VALUE, maxP = 0;
        for (int v : p) {
            if (v < minP) minP = v;
            else if (v - minP > maxP) maxP = v - minP;
        }
        System.out.println(maxP);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(17, 1, 'The Compass', '🧭', 'Use two pointers, one for each array. Compare the current elements from both arrays. Pick the smaller one and advance that pointer. When one array is exhausted, copy the rest of the other.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(17, 1, 'The Compass', '🧭', 'Algorithm: Two-Pointer Merge. Steps: (1) i=0, j=0, k=0. (2) While both have elements, compare a[i] and b[j], put smaller in result, advance that pointer. (3) Copy remaining elements. (4) Print result.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(17, 1, 'The Compass', '🧭', '```
BEGIN
  i=0, j=0, k=0
  WHILE i < M AND j < N
    IF a[i] <= b[j] THEN result[k++] = a[i++]
    ELSE result[k++] = b[j++]
  COPY remaining from a or b
  PRINT result
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(17, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int m = sc.nextInt(), n = sc.nextInt();
        int[] a = new int[m], b = new int[n];
        for (int i = 0; i < m; i++) a[i] = sc.nextInt();
        for (int i = 0; i < n; i++) b[i] = sc.nextInt();
        int[] res = new int[m+n];
        int i=0, j=0, k=0;
        // TODO: merge a and b using two pointers
        // Print res
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(17, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int m = sc.nextInt(), n = sc.nextInt();
        int[] a = new int[m], b = new int[n];
        for (int i = 0; i < m; i++) a[i] = sc.nextInt();
        for (int i = 0; i < n; i++) b[i] = sc.nextInt();
        int[] res = new int[m+n]; int i=0, j=0, k=0;
        while (i<m && j<n) res[k++] = a[i]<=b[j] ? a[i++] : b[j++];
        while (i<m) res[k++] = a[i++];
        while (j<n) res[k++] = b[j++];
        StringBuilder sb = new StringBuilder();
        for (int x=0; x<m+n; x++) { if (x>0) sb.append(" "); sb.append(res[x]); }
        System.out.println(sb);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(18, 1, 'The Compass', '🧭', 'The reversal trick is elegant: (1) Reverse the entire array. (2) Reverse the first K elements. (3) Reverse the remaining N-K elements. Don''''t forget to take K % N first since K can be larger than N.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(18, 1, 'The Compass', '🧭', 'Algorithm: Triple Reversal. Steps: (1) k = k % n. (2) Reverse entire array. (3) Reverse first k elements. (4) Reverse last n-k elements. (5) Print result.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(18, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, k, arr
  k = k MOD n
  reverse(arr, 0, n-1)
  reverse(arr, 0, k-1)
  reverse(arr, k, n-1)
  PRINT arr
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(18, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), k = sc.nextInt() % n;
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        // TODO: reverse all, reverse first k, reverse rest
        // Print arr
    }
    static void reverse(int[] a, int l, int r) { /* TODO */ }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(18, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt(), k = sc.nextInt() % n;
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        rev(arr, 0, n-1); rev(arr, 0, k-1); rev(arr, k, n-1);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) { if (i>0) sb.append(" "); sb.append(arr[i]); }
        System.out.println(sb);
    }
    static void rev(int[] a, int l, int r) { while (l<r) { int t=a[l]; a[l++]=a[r]; a[r--]=t; } }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(19, 1, 'The Compass', '🧭', 'Each row starts and ends with 1. Every inner element is the sum of the two elements directly above it from the previous row. Build rows one at a time.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(19, 1, 'The Compass', '🧭', 'Algorithm: 2D Array Construction. Steps: (1) Create a 2D array. (2) Each row i has i+1 elements. (3) First and last are 1. (4) Inner elements = triangle[i-1][j-1] + triangle[i-1][j]. (5) Print each row.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(19, 1, 'The Compass', '🧭', '```
BEGIN
  READ n
  FOR i = 0 TO n-1
    row[i][0] = 1, row[i][i] = 1
    FOR j = 1 TO i-1
      row[i][j] = row[i-1][j-1] + row[i-1][j]
    PRINT row[i]
  END FOR
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(19, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[][] tri = new int[n][];
        // TODO: build rows, first/last = 1, inner = sum of above two
        // Print each row
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(19, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[][] tri = new int[n][];
        for (int i = 0; i < n; i++) {
            tri[i] = new int[i+1];
            tri[i][0] = tri[i][i] = 1;
            for (int j = 1; j < i; j++) tri[i][j] = tri[i-1][j-1] + tri[i-1][j];
            StringBuilder sb = new StringBuilder();
            for (int j = 0; j <= i; j++) { if (j>0) sb.append(" "); sb.append(tri[i][j]); }
            System.out.println(sb);
        }
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(20, 1, 'The Compass', '🧭', 'Think about this: at each position, should you start a new subarray or extend the existing one? If the current sum is negative, starting fresh might be better. This is Kadane''''s algorithm.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(20, 1, 'The Compass', '🧭', 'Algorithm: Kadane''''s Algorithm. Steps: (1) maxSoFar = arr[0], currentMax = arr[0]. (2) For each element from index 1: currentMax = max(arr[i], currentMax + arr[i]). (3) maxSoFar = max(maxSoFar, currentMax). (4) Print maxSoFar.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(20, 1, 'The Compass', '🧭', '```
BEGIN
  READ n, arr
  maxSoFar = arr[0]
  currentMax = arr[0]
  FOR i = 1 TO n-1
    currentMax = MAX(arr[i], currentMax + arr[i])
    maxSoFar = MAX(maxSoFar, currentMax)
  END FOR
  PRINT maxSoFar
END
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(20, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int maxSoFar = arr[0], curMax = arr[0];
        // TODO: for each element, decide: extend or start new?
        System.out.println(maxSoFar);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(20, 1, 'The Compass', '🧭', '```java
import java.util.Scanner;
public class Solution {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) arr[i] = sc.nextInt();
        int maxSoFar = arr[0], cur = arr[0];
        for (int i = 1; i < n; i++) {
            cur = Math.max(arr[i], cur + arr[i]);
            maxSoFar = Math.max(maxSoFar, cur);
        }
        System.out.println(maxSoFar);
    }
}
```', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(21, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(21, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(21, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(21, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(21, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(22, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(22, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Two-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(22, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Two-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(22, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Two-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(22, 5, 'The Sage''s Whisper', '🔮', 'Apply the Two-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(23, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(23, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves String. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(23, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the String approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(23, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply String
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(23, 5, 'The Sage''s Whisper', '🔮', 'Apply the String pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(24, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(24, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves String. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(24, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the String approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(24, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply String
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(24, 5, 'The Sage''s Whisper', '🔮', 'Apply the String pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(25, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(25, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves String. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(25, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the String approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(25, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply String
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(25, 5, 'The Sage''s Whisper', '🔮', 'Apply the String pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(26, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(26, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(26, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(26, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(26, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(27, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(27, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves String. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(27, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the String approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(27, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply String
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(27, 5, 'The Sage''s Whisper', '🔮', 'Apply the String pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(28, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(28, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(28, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(28, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(28, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(29, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(29, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Sliding Window. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(29, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Sliding Window approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(29, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Sliding Window
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(29, 5, 'The Sage''s Whisper', '🔮', 'Apply the Sliding Window pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(30, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(30, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Sliding Window. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(30, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Sliding Window approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(30, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Sliding Window
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(30, 5, 'The Sage''s Whisper', '🔮', 'Apply the Sliding Window pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(31, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(31, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Sorting. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(31, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Sorting approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(31, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Sorting
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(31, 5, 'The Sage''s Whisper', '🔮', 'Apply the Sorting pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(32, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(32, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Sorting. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(32, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Sorting approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(32, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Sorting
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(32, 5, 'The Sage''s Whisper', '🔮', 'Apply the Sorting pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(33, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(33, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Sorting. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(33, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Sorting approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(33, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Sorting
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(33, 5, 'The Sage''s Whisper', '🔮', 'Apply the Sorting pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(34, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(34, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Divide and Conquer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(34, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Divide and Conquer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(34, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Divide and Conquer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(34, 5, 'The Sage''s Whisper', '🔮', 'Apply the Divide and Conquer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(35, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(35, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Divide and Conquer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(35, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Divide and Conquer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(35, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Divide and Conquer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(35, 5, 'The Sage''s Whisper', '🔮', 'Apply the Divide and Conquer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(36, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(36, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Binary Search. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(36, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Binary Search approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(36, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Binary Search
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(36, 5, 'The Sage''s Whisper', '🔮', 'Apply the Binary Search pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(37, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(37, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Binary Search. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(37, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Binary Search approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(37, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Binary Search
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(37, 5, 'The Sage''s Whisper', '🔮', 'Apply the Binary Search pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(38, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(38, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Binary Search. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(38, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Binary Search approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(38, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Binary Search
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(38, 5, 'The Sage''s Whisper', '🔮', 'Apply the Binary Search pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(39, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(39, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Three-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(39, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Three-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(39, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Three-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(39, 5, 'The Sage''s Whisper', '🔮', 'Apply the Three-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(40, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(40, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Quick Select. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(40, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Quick Select approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(40, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Quick Select
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(40, 5, 'The Sage''s Whisper', '🔮', 'Apply the Quick Select pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(41, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(41, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Set. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(41, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Set approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(41, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Set
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(41, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Set pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(42, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(42, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves XOR. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(42, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the XOR approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(42, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply XOR
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(42, 5, 'The Sage''s Whisper', '🔮', 'Apply the XOR pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(43, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(43, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Set. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(43, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Set approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(43, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Set
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(43, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Set pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(44, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(44, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Set. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(44, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Set approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(44, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Set
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(44, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Set pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(45, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(45, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(45, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(45, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(45, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(46, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(46, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(46, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(46, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(46, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(47, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(47, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(47, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(47, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(47, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(48, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(48, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(48, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(48, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(48, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(49, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(49, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Heap. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(49, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Heap approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(49, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Heap
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(49, 5, 'The Sage''s Whisper', '🔮', 'Apply the Heap pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(50, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(50, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Set. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(50, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Set approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(50, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Set
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(50, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Set pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(51, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(51, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Linked List. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(51, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Linked List approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(51, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Linked List
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(51, 5, 'The Sage''s Whisper', '🔮', 'Apply the Linked List pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(52, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(52, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Two-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(52, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Two-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(52, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Two-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(52, 5, 'The Sage''s Whisper', '🔮', 'Apply the Two-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(53, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(53, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Floyd Cycle Detection. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(53, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Floyd Cycle Detection approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(53, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Floyd Cycle Detection
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(53, 5, 'The Sage''s Whisper', '🔮', 'Apply the Floyd Cycle Detection pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(54, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(54, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Two-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(54, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Two-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(54, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Two-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(54, 5, 'The Sage''s Whisper', '🔮', 'Apply the Two-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(55, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(55, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Stack. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(55, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Stack approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(55, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Stack
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(55, 5, 'The Sage''s Whisper', '🔮', 'Apply the Stack pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(56, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(56, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Two-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(56, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Two-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(56, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Two-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(56, 5, 'The Sage''s Whisper', '🔮', 'Apply the Two-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(57, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(57, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Linked List. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(57, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Linked List approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(57, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Linked List
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(57, 5, 'The Sage''s Whisper', '🔮', 'Apply the Linked List pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(58, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(58, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Two-Pointer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(58, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Two-Pointer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(58, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Two-Pointer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(58, 5, 'The Sage''s Whisper', '🔮', 'Apply the Two-Pointer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(59, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(59, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Hash Map. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(59, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Hash Map approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(59, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Hash Map
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(59, 5, 'The Sage''s Whisper', '🔮', 'Apply the Hash Map pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(60, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(60, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Divide and Conquer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(60, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Divide and Conquer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(60, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Divide and Conquer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(60, 5, 'The Sage''s Whisper', '🔮', 'Apply the Divide and Conquer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(61, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(61, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(61, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(61, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(61, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(62, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(62, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(62, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(62, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(62, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(63, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(63, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(63, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(63, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(63, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(64, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(64, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(64, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(64, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(64, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(65, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(65, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree BFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(65, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree BFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(65, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree BFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(65, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree BFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(66, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(66, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(66, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(66, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(66, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(67, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(67, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree DFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(67, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree DFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(67, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree DFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(67, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree DFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(68, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(68, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Divide and Conquer. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(68, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Divide and Conquer approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(68, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Divide and Conquer
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(68, 5, 'The Sage''s Whisper', '🔮', 'Apply the Divide and Conquer pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(69, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(69, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Tree BFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(69, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Tree BFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(69, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Tree BFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(69, 5, 'The Sage''s Whisper', '🔮', 'Apply the Tree BFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(70, 1, 'The Compass', '🧭', 'Think about what approach would work for this problem. Consider the data structures involved.', 5, 1);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(70, 2, 'The Map', '🗺️', 'Algorithm hint: This problem involves Graph BFS. Think about how to apply it step by step.', 10, 2);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(70, 3, 'The Blueprint', '📐', 'Pseudocode:
1. Read and parse the input
2. Apply the Graph BFS approach
3. Handle edge cases
4. Output the result', 15, 3);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(70, 4, 'The Scaffold', '🔨', 'public class Solution {
    public static void main(String[] args) {
        // TODO: Parse input
        // TODO: Apply Graph BFS
        // TODO: Print result
    }
}', 20, 4);
INSERT INTO hints (problem_id, layer, name, icon, content, hp_cost, order_num) VALUES
(70, 5, 'The Sage''s Whisper', '🔮', 'Apply the Graph BFS pattern directly. The key insight is to identify the right data structure and iterate through the input.', 30, 5);