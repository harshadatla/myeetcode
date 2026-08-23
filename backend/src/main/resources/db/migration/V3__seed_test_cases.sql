-- V3__seed_test_cases.sql — Test cases for all problems

INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(1, '', '['''', ''Hello, World!\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(1, '', '['''', ''Hello, World!\n'', True]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(1, '', '['''', ''Hello, World!\n'', True]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''3 5\n'', ''8\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''-10 20\n'', ''10\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''0 0\n'', ''0\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''100 200\n'', ''300\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''-1000000 500000\n'', ''-500000\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(2, '', '[''999999999 1\n'', ''1000000000\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''4\n'', ''Even\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''7\n'', ''Odd\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''0\n'', ''Even\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''-2\n'', ''Even\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''-3\n'', ''Odd\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''100\n'', ''Even\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(3, '', '[''999999999\n'', ''Odd\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''5\n'', ''5 x 1 = 5\n5 x 2 = 10\n5 x 3 = 15\n5 x 4 = 20\n5 x 5 = 25\n5 x 6 = 30\n5 x 7 = 35\n5 x 8 = 40\n5 x 9 = 45\n5 x 10 = 50\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''1\n'', ''1 x 1 = 1\n1 x 2 = 2\n1 x 3 = 3\n1 x 4 = 4\n1 x 5 = 5\n1 x 6 = 6\n1 x 7 = 7\n1 x 8 = 8\n1 x 9 = 9\n1 x 10 = 10\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''2\n'', ''2 x 1 = 2\n2 x 2 = 4\n2 x 3 = 6\n2 x 4 = 8\n2 x 5 = 10\n2 x 6 = 12\n2 x 7 = 14\n2 x 8 = 16\n2 x 9 = 18\n2 x 10 = 20\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''10\n'', ''10 x 1 = 10\n10 x 2 = 20\n10 x 3 = 30\n10 x 4 = 40\n10 x 5 = 50\n10 x 6 = 60\n10 x 7 = 70\n10 x 8 = 80\n10 x 9 = 90\n10 x 10 = 100\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''100\n'', ''100 x 1 = 100\n100 x 2 = 200\n100 x 3 = 300\n100 x 4 = 400\n100 x 5 = 500\n100 x 6 = 600\n100 x 7 = 700\n100 x 8 = 800\n100 x 9 = 900\n100 x 10 = 1000\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(4, '', '[''7\n'', ''7 x 1 = 7\n7 x 2 = 14\n7 x 3 = 21\n7 x 4 = 28\n7 x 5 = 35\n7 x 6 = 42\n7 x 7 = 49\n7 x 8 = 56\n7 x 9 = 63\n7 x 10 = 70\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''5\n'', ''120\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''0\n'', ''1\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''1\n'', ''1\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''10\n'', ''3628800\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''3\n'', ''6\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''20\n'', ''2432902008176640000\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(5, '', '[''7\n'', ''5040\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''121\n'', ''true\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''123\n'', ''false\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''0\n'', ''true\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''-121\n'', ''false\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''11\n'', ''true\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''1001\n'', ''true\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''12321\n'', ''true\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(6, '', '[''10\n'', ''false\n'', True]', FALSE, 7);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''15\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''5\n'', ''1\n2\nFizz\n4\nBuzz\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''3\n'', ''1\n2\nFizz\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''1\n'', ''1\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''30\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n16\n17\nFizz\n19\nBuzz\nFizz\n22\n23\nFizz\nBuzz\n26\nFizz\n28\n29\nFizzBuzz\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(7, '', '[''10\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''hello\n'', ''olleh\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''Java\n'', ''avaJ\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''a\n'', ''a\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''abcd\n'', ''dcba\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''12345\n'', ''54321\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(8, '', '[''racecar\n'', ''racecar\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''12345\n'', ''5\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''7\n'', ''1\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''0\n'', ''1\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''100\n'', ''3\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''999999999\n'', ''9\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(9, '', '[''1000000000000000000\n'', ''19\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''15 3 5\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''10 2 7\n'', ''1\nFizz\n3\nFizz\n5\nFizz\nBuzz\nFizz\n9\nFizz\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''6 3 5\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''20 4 6\n'', ''1\n2\n3\nFizz\n5\nBuzz\n7\nFizz\n9\n10\n11\nFizzBuzz\n13\n14\n15\nFizz\n17\nBuzz\n19\nFizz\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''3 2 3\n'', ''1\nFizz\nBuzz\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''30 3 5\n'', ''1\n2\nFizz\n4\nBuzz\nFizz\n7\n8\nFizz\nBuzz\n11\nFizz\n13\n14\nFizzBuzz\n16\n17\nFizz\n19\nBuzz\nFizz\n22\n23\nFizz\nBuzz\n26\nFizz\n28\n29\nFizzBuzz\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(10, '', '[''100 7 11\n'', ''1\n2\n3\n4\n5\n6\nFizz\n8\n9\n10\nBuzz\n12\n13\nFizz\n15\n16\n17\n18\n19\n20\nFizz\n22\n23\n24\n25\n26\n27\nFizzBuzz\n29\n30\n31\n32\n33\nFizz\n35\n36\n37\n38\n39\n40\n41\nBuzz\n43\nFizz\n45\n46\n47\n48\nFizz\n50\n51\n52\n53\nBuzz\n55\nFizz\n57\n58\n59\n60\n61\n62\nFizz\n64\n65\n66\n67\n68\n69\nBuzz\n71\n72\nFizz\n74\n75\n76\n77\n78\n79\nFizzBuzz\n81\n82\n83\n84\n85\n86\nFizz\n88\n89\n90\n91\n92\n93\nFizz\n95\n96\n97\n98\n99\n100\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''5\n3 7 2 9 1\n'', ''9\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''3\n-1 -5 -3\n'', ''-1\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''1\n42\n'', ''42\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''4\n100 200 150 50\n'', ''200\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''6\n0 -1 0 -2 0 0\n'', ''0\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(11, '', '[''8\n1 2 3 4 5 6 7 8\n'', ''8\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''5\n3 7 2 9 1\n'', ''7\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''3\n5 5 5\n'', ''-1\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''4\n1 2 3 4\n'', ''3\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''2\n10 10\n'', ''-1\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''6\n10 10 5 8 20 20\n'', ''10\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''5\n-1 -5 -3 -7 -2\n'', ''-2\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(12, '', '[''4\n1 1 1 2\n'', ''1\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''7\n1 1 2 2 3 4 4\n'', ''1 2 3 4\n4\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''5\n1 2 3 4 5\n'', ''1 2 3 4 5\n5\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''3\n1 1 1\n'', ''1\n1\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''1\n42\n'', ''42\n1\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''6\n-3 -3 -1 0 0 2\n'', ''-3 -1 0 2\n4\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(13, '', '[''8\n1 1 1 1 1 1 1 1\n'', ''1\n1\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''4 9\n2 7 11 15\n'', ''1 2\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''3 6\n3 2 3\n'', ''1 3\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''2 10\n5 5\n'', ''1 2\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''4 6\n3 2 4 3\n'', ''1 3\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''5 0\n-1 1 0 2 -2\n'', ''1 2\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''3 100\n50 50 50\n'', ''1 2\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(14, '', '[''4 -5\n-3 -2 -8 1\n'', ''1 4\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''5\n0 1 0 3 12\n'', ''1 3 12 0 0\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''1\n0\n'', ''0\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''4\n0 0 0 0\n'', ''0 0 0 0\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''5\n1 2 3 4 5\n'', ''1 2 3 4 5\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''6\n0 0 1 0 0 2\n'', ''1 2 0 0 0 0\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(15, '', '[''3\n1 0 1\n'', ''1 1 0\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''6\n7 1 5 3 6 4\n'', ''5\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''5\n7 6 4 3 1\n'', ''0\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''1\n5\n'', ''0\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''5\n1 2 3 4 5\n'', ''4\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''4\n5 4 3 2\n'', ''0\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(16, '', '[''6\n3 3 3 3 3 3\n'', ''0\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''3 3\n1 3 5\n2 4 6\n'', ''1 2 3 4 5 6\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''2 2\n1 5\n2 4\n'', ''1 2 4 5\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''1 1\n1\n2\n'', ''1 2\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''3 0\n1 2 3\n\n'', ''1 2 3\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''0 3\n\n1 2 3\n'', ''1 2 3\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(17, '', '[''2 3\n1 1 1\n2 2 3\n'', ''1 1 1 2 2 3\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''7 3\n1 2 3 4 5 6 7\n'', ''5 6 7 1 2 3 4\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''5 2\n1 2 3 4 5\n'', ''4 5 1 2 3\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''1 0\n5\n'', ''5\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''4 4\n1 2 3 4\n'', ''1 2 3 4\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''5 10\n1 2 3 4 5\n'', ''1 2 3 4 5\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(18, '', '[''6 1\n1 2 3 4 5 6\n'', ''6 1 2 3 4 5\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''5\n'', ''1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''1\n'', ''1\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''3\n'', ''1\n1 1\n1 2 1\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''2\n'', ''1\n1 1\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''4\n'', ''1\n1 1\n1 2 1\n1 3 3 1\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(19, '', '[''6\n'', ''1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1\n1 5 10 10 5 1\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''9\n-2 1 -3 4 -1 2 1 -5 4\n'', ''6\n'', False]', FALSE, 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''1\n5\n'', ''5\n'', False]', FALSE, 1);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''5\n5 4 -1 7 8\n'', ''23\n'', False]', FALSE, 2);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''3\n-1 -2 -3\n'', ''-1\n'', True]', FALSE, 3);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''4\n-2 -1 -3 -4\n'', ''-1\n'', True]', FALSE, 4);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''8\n1 2 3 4 5 6 7 8\n'', ''36\n'', True]', FALSE, 5);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(20, '', '[''6\n-1 2 3 -4 5 -1\n'', ''5\n'', True]', FALSE, 6);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(21, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(22, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(23, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(24, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(25, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(26, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(27, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(28, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(29, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(30, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(31, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(32, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(33, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(34, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(35, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(36, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(37, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(38, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(39, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(40, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(41, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(42, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(43, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(44, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(45, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(46, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(47, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(48, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(49, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(50, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(51, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(52, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(53, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(54, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(55, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(56, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(57, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(58, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(59, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(60, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(61, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(62, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(63, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(64, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(65, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(66, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(67, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(68, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(69, '', '', 'FALSE', 0);
INSERT INTO test_cases (problem_id, input, expected_output, is_hidden, order_num) VALUES
(70, '', '', 'FALSE', 0);