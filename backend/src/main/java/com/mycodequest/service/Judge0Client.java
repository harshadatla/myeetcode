package com.mycodequest.service;

import java.time.Duration;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import com.mycodequest.dto.submission.Judge0Response;

@Service
public class Judge0Client {

    private final RestClient client;

    @Value("${judge0.url}")
    private String judge0Url;

    private static final int JAVA_LANGUAGE_ID = 62;

    public Judge0Client() {
        this.client = RestClient.builder()
                .build();
    }

    /**
     * Submit code to Judge0 for execution and return the submission token.
     */
    public String submit(String sourceCode, String stdin, String expectedOutput,
                         double timeLimit, int memoryLimit) {
        Map<String, Object> body = Map.of(
                "source_code", sourceCode,
                "language_id", JAVA_LANGUAGE_ID,
                "stdin", stdin != null ? stdin : "",
                "expected_output", expectedOutput != null ? expectedOutput : "",
                "cpu_time_limit", timeLimit,
                "memory_limit", memoryLimit
        );

        Map<String, String> response = client.post()
                .uri(judge0Url + "/submissions?base64_encoded=false")
                .contentType(MediaType.APPLICATION_JSON)
                .body(body)
                .retrieve()
                .body(Map.class);

        if (response == null || !response.containsKey("token")) {
            throw new RuntimeException("Judge0 submission failed: no token returned");
        }
        return response.get("token");
    }

    /**
     * Poll Judge0 for submission result by token.
     * Waits until the submission is processed (status id > 1) with a timeout.
     */
    public Judge0Response poll(String token) {
        int maxAttempts = 30;
        for (int i = 0; i < maxAttempts; i++) {
            @SuppressWarnings("unchecked")
            Map<String, Object> body = client.get()
                    .uri(judge0Url + "/submissions/{token}?base64_encoded=false", token)
                    .retrieve()
                    .body(Map.class);

            if (body == null) {
                throw new RuntimeException("Judge0 poll returned null for token: " + token);
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> status = (Map<String, Object>) body.get("status");
            int statusId = 0;
            String statusDesc = null;
            if (status != null) {
                statusId = ((Number) status.get("id")).intValue();
                statusDesc = (String) status.get("description");
            }

            // Status id 1 = In Queue, 2 = Processing. Anything else is a final state.
            if (statusId > 2) {
                String stdout = (String) body.get("stdout");
                String stderr = (String) body.get("stderr");
                String compileOutput = (String) body.get("compile_output");
                String time = (String) body.get("time");
                Integer memory = body.get("memory") != null
                        ? ((Number) body.get("memory")).intValue()
                        : null;

                return new Judge0Response(
                        token,
                        new Judge0Response.Judge0Status(statusId, statusDesc),
                        stdout,
                        stderr,
                        compileOutput,
                        time,
                        memory
                );
            }

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("Polling interrupted for token: " + token);
            }
        }
        throw new RuntimeException("Judge0 polling timed out for token: " + token);
    }

    /**
     * Submit code and poll immediately for the result (convenience method).
     */
    public Judge0Response submitAndPoll(String sourceCode, String stdin, String expectedOutput,
                                         double timeLimit, int memoryLimit) {
        String token = submit(sourceCode, stdin, expectedOutput, timeLimit, memoryLimit);
        return poll(token);
    }
}