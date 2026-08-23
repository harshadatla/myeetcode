package com.mycodequest.service;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

import com.mycodequest.dto.problem.DynamicHintDto;
import com.mycodequest.entity.Problem;
import com.mycodequest.entity.Submission;
import com.mycodequest.entity.TestCase;

@Service
public class HintEngine {

    private static final Map<String, String> COMPILE_ERROR_TRANSLATIONS = Map.ofEntries(
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
            "You opened a string with a quote but didn't close it. Check that every \" has a matching closing \"."),
        Map.entry("variable might not have been initialized",
            "You're using a variable before assigning it a value. Initialize it first, e.g., `int x = 0;` instead of just `int x;`."),
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

    private static final Map<String, String> EXCEPTION_TRANSLATIONS = Map.ofEntries(
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

    public DynamicHintDto generateHint(Submission failed, Problem problem, List<TestCase> failedCases) {
        String status = failed.getStatus();
        if (status == null) {
            return new DynamicHintDto("DYNAMIC_UNKNOWN", "Unexpected status. Try resetting your code.", null, null, 10);
        }

        return switch (status) {
            case "COMPILE_ERROR" -> compileErrorHint(failed.getCompileOutput());
            case "WRONG_ANSWER" -> wrongAnswerHint(failed, failedCases, problem);
            case "TIME_LIMIT_EXCEEDED" -> tleHint(problem);
            case "RUNTIME_ERROR" -> runtimeErrorHint(failed.getStderr());
            default -> new DynamicHintDto("DYNAMIC_UNKNOWN",
                "Unexpected status. Try resetting your code and starting fresh.", null, null, 10);
        };
    }

    private DynamicHintDto compileErrorHint(String compileOutput) {
        if (compileOutput == null || compileOutput.isBlank()) {
            return new DynamicHintDto("DYNAMIC_COMPILE",
                "Your code failed to compile, but no specific error was captured. Check your syntax — especially braces, semicolons, and method signatures.",
                null, null, 10);
        }

        Integer lineNumber = extractLineNumber(compileOutput);

        for (Map.Entry<String, String> entry : COMPILE_ERROR_TRANSLATIONS.entrySet()) {
            if (compileOutput.toLowerCase().contains(entry.getKey().toLowerCase())) {
                String hint = entry.getValue();
                if (lineNumber != null) {
                    hint += " (This error appears to be around line " + lineNumber + ".)";
                }
                return new DynamicHintDto("DYNAMIC_COMPILE", hint, lineNumber, null, 10);
            }
        }

        String truncated = compileOutput.length() > 300 ? compileOutput.substring(0, 300) + "..." : compileOutput;
        return new DynamicHintDto("DYNAMIC_COMPILE",
            "Your code failed to compile. Here's the compiler message:\n\n" + truncated + "\n\nRead the error carefully — it usually tells you the line number and what's wrong.",
            lineNumber, null, 10);
    }

    private Integer extractLineNumber(String output) {
        Pattern p = Pattern.compile("Solution\\.java:(\\d+):");
        Matcher m = p.matcher(output);
        return m.find() ? Integer.parseInt(m.group(1)) : null;
    }

    private DynamicHintDto wrongAnswerHint(Submission sub, List<TestCase> failedCases, Problem problem) {
        if (failedCases == null || failedCases.isEmpty()) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code produced the wrong output for at least one test case. Review the expected vs actual output carefully.",
                null, null, 10);
        }

        TestCase firstFailure = failedCases.get(0);
        String input = firstFailure.getInput();
        String expected = firstFailure.getExpectedOutput();
        String actual = sub.getStdout();

        if (input == null || input.trim().isEmpty()) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code fails on EMPTY input. What does your code do when there's nothing to process? Add a guard clause at the start.",
                null, null, 10);
        }

        if (input.lines().count() == 1 && input.trim().split("\\s+").length == 1) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Single-element edge case. When the input has just one element, your loop might not execute at all. Check your loop bounds.",
                null, null, 10);
        }

        if (input.contains("-")) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code doesn't handle NEGATIVE values correctly. Review your comparison operators and initial values — are you initializing with 0 when you should use Integer.MIN_VALUE?",
                null, null, 10);
        }

        if (actual != null && actual.trim().isEmpty() && expected != null && !expected.trim().isEmpty()) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your code produced NO OUTPUT for this test case. Is your main method reaching the print statements? Check if your code is exiting early or throwing a silent exception.",
                null, null, 10);
        }

        if (actual != null && expected != null && actual.trim().equalsIgnoreCase(expected.trim()) && !actual.equals(expected)) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your output differs only in LETTER CASE. Check if you need toUpperCase() or toLowerCase() on your result.",
                null, null, 10);
        }

        if (actual != null && expected != null && actual.trim().equals(expected.trim()) && !actual.equals(expected)) {
            return new DynamicHintDto("DYNAMIC_WRONG",
                "Your output has EXTRA WHITESPACE. Check your print statements — are you adding extra spaces or using println where you should use print?",
                null, null, 10);
        }

        String inputPreview = input.length() > 100 ? input.substring(0, 100) + "..." : input;
        return new DynamicHintDto("DYNAMIC_WRONG",
            "Your code produces the wrong output for this test case.\nInput: \"" + inputPreview + "\"\nExpected: \"" + expected + "\"\nYour output: \"" + (actual == null ? "(empty)" : actual) + "\"\n\nLook at the difference between expected and actual. What edge case are you missing?",
            null, null, 10);
    }

    private DynamicHintDto tleHint(Problem problem) {
        String desc = problem.getDescription() != null ? problem.getDescription().toLowerCase() : "";
        String complexityTarget;

        if (desc.contains("10^9") || desc.contains("1000000000")) {
            complexityTarget = "O(log n) or O(1)";
        } else if (desc.contains("10^5") || desc.contains("100000")) {
            complexityTarget = "O(n log n)";
        } else if (desc.contains("10^3") || desc.contains("1000")) {
            complexityTarget = "O(n^2)";
        } else if (desc.contains("n <= 20") || desc.contains("n ≤ 20")) {
            complexityTarget = "O(2^n)";
        } else {
            complexityTarget = "better than your current approach";
        }

        return new DynamicHintDto("DYNAMIC_TLE",
            "Your solution is TOO SLOW — it exceeded the time limit. Based on the problem's constraints, you need an algorithm with complexity around " + complexityTarget + ".\n\nThink about: Can you reduce nested loops? Can you use a hash map for O(1) lookups? Can you sort first and then use binary search?",
            null, null, 10);
    }

    private DynamicHintDto runtimeErrorHint(String stderr) {
        if (stderr == null || stderr.isBlank()) {
            return new DynamicHintDto("DYNAMIC_RUNTIME",
                "Your code crashed with a runtime error. Check for null pointers, array index issues, or division by zero.",
                null, null, 10);
        }

        for (Map.Entry<String, String> entry : EXCEPTION_TRANSLATIONS.entrySet()) {
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