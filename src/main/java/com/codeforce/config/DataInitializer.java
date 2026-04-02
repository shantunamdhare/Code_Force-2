package com.codeforce.config;

import com.codeforce.model.*;
import com.codeforce.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final ProblemRepository problemRepository;
    private final ContestRepository contestRepository;
    private final BlogPostRepository blogPostRepository;
    private final TagRepository tagRepository;
    private final TestCaseRepository testCaseRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DataInitializer(UserRepository userRepository, ProblemRepository problemRepository,
                           ContestRepository contestRepository, BlogPostRepository blogPostRepository,
                           TagRepository tagRepository, TestCaseRepository testCaseRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.problemRepository = problemRepository;
        this.contestRepository = contestRepository;
        this.blogPostRepository = blogPostRepository;
        this.tagRepository = tagRepository;
        this.testCaseRepository = testCaseRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        System.out.println("--- Bootstrapping CodeForce Application Data ---");

        // Ensure Admin exists
        userRepository.findByHandle("admin").ifPresentOrElse(
            admin -> {
                admin.setRole("ADMIN");
                admin.setPassword("admin123");
                userRepository.save(admin);
            },
            () -> {
                userRepository.save(User.builder()
                        .handle("admin").email("admin@cf.com").password("admin123")
                        .firstName("System").lastName("Admin")
                        .role("ADMIN").rank("Admin").maxRank("Admin")
                        .build());
            }
        );

        // Ensure Organizer exists
        userRepository.findByHandle("organizer").ifPresentOrElse(
            organizer -> {
                organizer.setRole("ORGANIZER");
                organizer.setPassword("pass123");
                userRepository.save(organizer);
            },
            () -> {
                createOrganizer("organizer", "organizer@cf.com", "pass123");
            }
        );

        // Ensure Tester exists
        userRepository.findByHandle("tester").ifPresentOrElse(
            tester -> {
                tester.setRole("TESTER");
                tester.setPassword("pass123");
                userRepository.save(tester);
            },
            () -> {
                createUser("tester", "tester@cf.com", "pass123", "Default", "Tester",
                        "Global", null, null, 1200, 1200,
                        "Pupil", "Pupil", 0, 0, null, "TESTER");
            }
        );

        // Reset syed and khan_test for the user
        userRepository.findByHandle("syed").ifPresent(u -> {u.setPassword("12345"); u.setRole("TESTER"); userRepository.save(u);});
        userRepository.findByHandle("khan_test").ifPresent(u -> {u.setPassword("password123"); userRepository.save(u);});

        /*
        if (userRepository.count() > 10) {
            System.out.println("Data already initialized. Skipping sample users/problems.");
            return;
        }
        */

        System.out.println("Initializing sample data...");
        String defaultPass = "pass123";

        // Create Tags
        Tag dp = createTag("DP", 5);
        Tag greedy = createTag("greedy", 4);
        Tag math = createTag("Math", 12);
        Tag graphs = createTag("Graphs", 10);
        Tag strings = createTag("Strings", 8);
        Tag binarySearch = createTag("binary search", 3);
        Tag sortings = createTag("sortings", 5);
        Tag impl = createTag("implementation", 7);
        Tag bruteForce = createTag("brute force", 5);
        Tag dataStructures = createTag("data structures", 4);
        Tag constructive = createTag("constructive algorithms", 3);
        Tag numberTheory = createTag("number theory", 2);
        Tag dfs = createTag("dfs and similar", 2);
        Tag trees = createTag("Trees", 9);
        Tag arrays = createTag("Arrays", 10);

        // Create Users
        User tourist = createUser("tourist", "tourist@cf.com", "pass123", "Gennady", "Korotkevich",
                "Belarus", "Gomel", "ITMO University", 3822, 3979,
                "Legendary Grandmaster", "Legendary Grandmaster", 200, 15000,
                LocalDateTime.of(2010, 1, 1, 0, 0));

        User jiangly = createUser("jiangly", "jiangly@cf.com", "pass123", "Jiang", "Ly",
                "China", "Beijing", null, 3650, 3756,
                "Legendary Grandmaster", "Legendary Grandmaster", 85, 8000,
                LocalDateTime.of(2018, 3, 15, 0, 0));

        // ... truncated for brevity in this replace_file_content call ...
        // Actually I should provide the full content for the range I specified.

        User benq = createUser("Benq", "benq@cf.com", "pass123", "Benjamin", "Qi",
                "United States", "New York", "MIT", 3450, 3555,
                "Legendary Grandmaster", "Legendary Grandmaster", 120, 9500,
                LocalDateTime.of(2017, 5, 20, 0, 0));

        User ecnerwala = createUser("ecnerwala", "ecnerwala@cf.com", "pass123", "Andrew", "He",
                "United States", "San Francisco", null, 3200, 3300,
                "International Grandmaster", "International Grandmaster", 75, 6000,
                LocalDateTime.of(2015, 8, 10, 0, 0));

        User petr = createUser("Petr", "petr@cf.com", "pass123", "Petr", "Mitrichev",
                "Russia", "Moscow", "Google", 3100, 3380,
                "International Grandmaster", "Legendary Grandmaster", 180, 12000,
                LocalDateTime.of(2009, 2, 1, 0, 0));

        User errichto = createUser("Errichto", "errichto@cf.com", "pass123", "Kamil", "Debowski",
                "Poland", "Warsaw", null, 2850, 3050,
                "Grandmaster", "International Grandmaster", 250, 10000,
                LocalDateTime.of(2013, 6, 1, 0, 0));

        User um_nik = createUser("Um_nik", "umnik@cf.com", "pass123", "Alex", "Danilyuk",
                "Ukraine", "Kyiv", null, 2750, 2900,
                "Grandmaster", "Grandmaster", 65, 5500,
                LocalDateTime.of(2014, 9, 15, 0, 0));

        createUser("coder42", "coder42@cf.com", "pass123", "Alex", "Smith",
                "India", "Mumbai", null, 1550, 1600,
                "Expert", "Expert", 10, 50,
                LocalDateTime.of(2023, 1, 1, 0, 0));

        createUser("algoLearner", "learner@cf.com", "pass123", "Sam", "Johnson",
                "UK", "London", null, 1100, 1250,
                "Pupil", "Specialist", 5, 20,
                LocalDateTime.of(2024, 6, 1, 0, 0));

        createUser("newbieCoder", "newbie@cf.com", "pass123", "Min", "Park",
                "South Korea", "Seoul", null, 800, 900,
                "Newbie", "Newbie", 0, 5,
                LocalDateTime.of(2025, 1, 1, 0, 0));

        createUser("syed", "syed@cf.com", "12345", "Syed", "User",
                "Global", null, null, 0, 0,
                "Newbie", "Newbie", 0, 0, null, "TESTER");

        createUser("khan_test", "khan@cf.com", "12345", "Khan", "Test",
                "Global", null, null, 1500, 1600,
                "Expert", "Expert", 10, 50,
                LocalDateTime.of(2023, 1, 1, 0, 0));

        createUser("aman", "aman@cf.com", "12345", "Aman", "Organizer",
                "India", "Delhi", "IIT", 2500, 2600,
                "Grandmaster", "Grandmaster", 50, 4000,
                LocalDateTime.now(), "ORGANIZER");

        // Create Contests
        createContest("Codeforces Round #940 (Div. 2)", "CF", "BEFORE", 7200,
                LocalDateTime.now().plusDays(3),
                "Rated contest for Div. 2 participants. Problems cover math, DP, and graph algorithms.", 0, "tourist");

        createContest("Codeforces Round #939 (Div. 1 + Div. 2)", "CF", "BEFORE", 9000,
                LocalDateTime.now().plusDays(7),
                "Combined division contest with challenging problems from easy to extremely hard.", 0, "jiangly");

        createContest("Educational Codeforces Round 170", "ICPC", "BEFORE", 7200,
                LocalDateTime.now().plusDays(10),
                "Educational round focusing on important algorithms and data structures.", 0, "Errichto");

        createContest("Codeforces Round #938 (Div. 2)", "CF", "FINISHED", 7200,
                LocalDateTime.now().minusDays(2),
                "Standard Div. 2 round with 6 problems of increasing difficulty.", 18542, "Benq");

        createContest("Codeforces Round #937 (Div. 3)", "CF", "FINISHED", 7200,
                LocalDateTime.now().minusDays(5),
                "Div. 3 round designed for newcomers to competitive programming.", 25630, "Um_nik");

        createContest("Codeforces Round #936 (Div. 1)", "CF", "FINISHED", 7200,
                LocalDateTime.now().minusDays(8),
                "High-level Div. 1 contest with advanced algorithmic challenges.", 5200, "Petr");

        createContest("Global Round 28", "CF", "FINISHED", 10800,
                LocalDateTime.now().minusDays(15),
                "Open global round rated for all participants with 9 problems.", 32000, "tourist");

        // Create Problems
        Set<Tag> p1Tags = new HashSet<>(); p1Tags.add(math); p1Tags.add(impl);
        createProblem("1923", "A", "Satisfying Constraints",
                "You are given n constraints on variable x.",
                "Standard CF input.", "Standard CF output.", "6\n4\n1 3\n2 10...", "7\n0...",
                1000, 256, 800, 42150, p1Tags, "APPROVED");

        Set<Tag> p2Tags = new HashSet<>(); p2Tags.add(greedy); p2Tags.add(sortings);
        createProblem("1923", "B", "Summation Game",
                "Alice and Bob play a game with an array.",
                "Standard Input.", "Standard Output.", "5\n4 1 1...", "2\n0...",
                1000, 256, 1100, 28300, p2Tags, "APPROVED");

        Set<Tag> p3Tags = new HashSet<>(); p3Tags.add(dp); p3Tags.add(math);
        createProblem("1923", "C", "Partitioning the Array",
                "You have an array of n elements.",
                "Standard Input.", "Standard Output.", "3\n4\n4 2 4 2...", "2\n3...",
                2000, 256, 1500, 15600, p3Tags, "APPROVED");

        // ARRAYS STAGE 1
        Set<Tag> arr1 = new HashSet<>(); arr1.add(arrays); arr1.add(impl);
        createProblem("ARR1", "A", "Array Sum Mastery", "Find the sum of all elements in an array.", "n, followed by n integers.", "sum", "5\n1 2 3 4 5", "15", 1000, 256, 800, 500, arr1, "APPROVED");
        createProblem("ARR1", "B", "Target Value Search", "Check if a target k exists in the array.", "n, k, followed by n integers.", "YES/NO", "3 2\n1 2 3", "YES", 1000, 256, 900, 300, arr1, "APPROVED");

        // ARRAYS STAGE 2
        Set<Tag> arr2 = new HashSet<>(); arr2.add(arrays); arr2.add(binarySearch);
        createProblem("ARR2", "A", "Rotate and Find", "Rotate an array by k positions and find an element.", "n, k, followed by array.", "result", "4 1\n1 2 3 4", "4 1 2 3", 1000, 256, 1400, 200, arr2, "APPROVED");
        createProblem("ARR2", "B", "Two Sum Strategy", "Find two numbers that sum up to target.", "n, target, array.", "indices", "3 5\n2 3 1", "0 1", 1000, 256, 1300, 450, arr2, "APPROVED");

        // ARRAYS STAGE 3
        Set<Tag> arr3 = new HashSet<>(); arr3.add(arrays); arr3.add(dp);
        createProblem("ARR3", "A", "Maximum Subarray Sum", "Find the contiguous subarray with largest sum (Kadane's).", "n, array.", "max sum", "5\n-1 2 3 -2 4", "7", 1000, 256, 1900, 100, arr3, "APPROVED");
        createProblem("ARR3", "B", "Trapping Rain Water", "Calculate trapped water between heights.", "n, heights.", "water amount", "6\n0 1 0 2 1 0", "1", 2000, 512, 2200, 50, arr3, "APPROVED");

        // TREES STAGE 1
        Set<Tag> tree1 = new HashSet<>(); tree1.add(trees); tree1.add(impl);
        createProblem("TREE1", "A", "Preorder Traversal", "Perform preorder traversal on a binary tree.", "n, followed by edge list.", "order", "3\n1 2\n1 3", "1 2 3", 1000, 256, 800, 400, tree1, "APPROVED");
        createProblem("TREE1", "B", "Tree Height", "Calculate the maximum depth of a binary tree.", "n, edges.", "depth", "3\n1 2\n2 3", "3", 1000, 256, 900, 350, tree1, "APPROVED");

        // TREES STAGE 2
        Set<Tag> tree2 = new HashSet<>(); tree2.add(trees); tree2.add(dfs);
        createProblem("TREE2", "A", "LCA Discovery", "Find the Lowest Common Ancestor of two nodes.", "n, edges, u, v.", "LCA node", "4\n1 2\n1 3\n2 4\n4 3", "1", 1000, 256, 1500, 180, tree2, "APPROVED");
        createProblem("TREE2", "B", "Diameter of Tree", "Calculate the longest path between any two nodes.", "n, edges.", "diameter", "5\n1 2\n2 3\n2 4\n4 5", "4", 1000, 256, 1600, 120, tree2, "APPROVED");

        // TREES STAGE 3
        Set<Tag> tree3 = new HashSet<>(); tree3.add(trees); tree3.add(dataStructures);
        createProblem("TREE3", "A", "Heavy-Light Decomposition", "Update path and query path on a tree.", "n, ops, edges.", "results", "5\n3\n1 2\n...", "...", 3000, 512, 2100, 40, tree3, "APPROVED");

        // STRINGS STAGE 1
        Set<Tag> str1 = new HashSet<>(); str1.add(strings); str1.add(impl);
        createProblem("STR1", "A", "Palindrome Logic", "Check if a string is the same forward and backward.", "string s", "YES/NO", "racecar", "YES", 1000, 256, 800, 700, str1, "APPROVED");

        // STRINGS STAGE 2
        Set<Tag> str2 = new HashSet<>(); str2.add(strings); str2.add(greedy);
        createProblem("STR2", "A", "KMP String Matching", "Find all occurrences of pattern p in text t.", "t, p", "indices", "ababa aba", "0 2", 1000, 256, 1400, 150, str2, "APPROVED");

        // STRINGS STAGE 3
        Set<Tag> str3 = new HashSet<>(); str3.add(strings); str3.add(dataStructures);
        createProblem("STR3", "A", "Suffix Automaton", "Build a suffix automaton for a string.", "string", "state count", "abacaba", "12", 2000, 512, 2300, 25, str3, "APPROVED");

        // GRAPHS STAGE 1
        Set<Tag> graph1 = new HashSet<>(); graph1.add(graphs); graph1.add(dfs);
        createProblem("GRAPH1", "A", "BFS Traversal", "Visit all reachable nodes using BFS.", "nodes, edges, start", "order", "3 2\n1 2\n2 3\n1", "1 2 3", 1000, 256, 900, 550, graph1, "APPROVED");

        // GRAPHS STAGE 2
        Set<Tag> graph2 = new HashSet<>(); graph2.add(graphs); graph2.add(math);
        createProblem("GRAPH2", "A", "Dijkstra's Path", "Find shortest path from source to all nodes.", "nodes, edges with weights.", "distances", "3 3\n1 2 5\n2 3 2\n1 3 10", "0 5 7", 1500, 256, 1500, 200, graph2, "APPROVED");

        // GRAPHS STAGE 3
        Set<Tag> graph3 = new HashSet<>(); graph3.add(graphs); graph3.add(constructive);
        createProblem("GRAPH3", "A", "Max Flow Dinics", "Calculate the maximum flow from source to sink.", "nodes, edges with capacities.", "max flow", "4 5\n1 2 10...", "15", 2000, 512, 2400, 30, graph3, "APPROVED");

        // MATH STAGE 1
        Set<Tag> m1 = new HashSet<>(); m1.add(math); m1.add(impl);
        createProblem("MATH1", "A", "GCD Explorer", "Find Greatest Common Divisor of two numbers.", "a, b", "gcd", "12 18", "6", 1000, 256, 800, 600, m1, "APPROVED");

        // MATH STAGE 2
        Set<Tag> m2 = new HashSet<>(); m2.add(math); m2.add(numberTheory);
        createProblem("MATH2", "A", "Sieve of Eratosthenes", "Produce all primes up to N.", "N", "primes", "10", "2 3 5 7", 2000, 256, 1400, 150, m2, "APPROVED");

        // MATH STAGE 3
        Set<Tag> m3 = new HashSet<>(); m3.add(math); m3.add(constructive);
        createProblem("MATH3", "A", "Modular Exponentiation", "Compute (a^b) % c for large numbers.", "a, b, c", "result", "2 10 1000", "1024", 2000, 256, 2000, 80, m3, "APPROVED");

        // DP STAGE 1
        Set<Tag> dp1 = new HashSet<>(); dp1.add(dp); dp1.add(impl);
        createProblem("DP1", "A", "Climbing Stairs", "Ways to reach n-th step.", "N", "ways", "3", "3", 1000, 256, 800, 800, dp1, "APPROVED");
        createProblem("DP1", "B", "Fibonacci Efficient", "Calculate n-th Fibonacci using DP.", "N", "fib(N)", "10", "55", 1000, 256, 900, 750, dp1, "APPROVED");

        // DP STAGE 2
        Set<Tag> dp2 = new HashSet<>(); dp2.add(dp); dp2.add(math);
        createProblem("DP2", "A", "Longest Increasing Subsequence", "Length of the LIS in array.", "n, array.", "length", "6\n1 2 1 3 2 4", "4", 1000, 256, 1500, 200, dp2, "APPROVED");
        createProblem("DP2", "B", "Knapsack 0/1", "Maximize value in limited capacity.", "n, W, weights, values.", "max value", "3 50\n10 20 30\n60 100 120", "220", 1000, 256, 1600, 180, dp2, "APPROVED");

        // DP STAGE 3
        Set<Tag> dp3 = new HashSet<>(); dp3.add(dp); dp3.add(constructive);
        createProblem("DP3", "A", "Digit DP Mastery", "Sum of digits in range [L, R].", "L, R", "sum", "1 10", "46", 2000, 512, 2100, 45, dp3, "APPROVED");
        createProblem("DP3", "B", "Bitmask TSP", "Shortest tour visiting all cities.", "n, distances.", "shortest path", "4\n...", "...", 3000, 512, 2300, 30, dp3, "APPROVED");

        // Create PENDING problems for the tester
        Set<Tag> pTestTags = new HashSet<>(); pTestTags.add(math);
        Problem p13 = createProblem("2000", "A", "Primary Task",
                "Smallest round number strictly greater than n.",
                "First line t. Each: integer n.",
                "Smallest round number > n.",
                "3\n9\n100\n150",
                "10\n110\n160",
                1000, 256, 800, 0, pTestTags, "PENDING");
        createTestCase(p13, "5", "10", true);
        createTestCase(p13, "9", "10", true);

        // Create Blog Posts
        createBlogPost("Codeforces Round #940 Editorial",
                "Here we present the editorial for all problems from Round #940. Problem A (Satisfying Constraints): The key observation is to track the maximum lower bound and minimum upper bound from type 1 and 2 constraints, then subtract excluded values. Problem B uses a greedy sorting approach...",
                tourist, 156, 3, 42, LocalDateTime.now().minusHours(6), "editorial,div2,round940");
    }

    private Tag createTag(String name, int problemCount) {
        return tagRepository.findByNameIgnoreCase(name).orElseGet(() -> {
            Tag tag = new Tag();
            tag.setName(name);
            tag.setProblemCount(problemCount);
            return tagRepository.save(tag);
        });
    }

    private User createUser(String handle, String email, String password, String firstName, String lastName,
                            String country, String city, String organization, int rating, int maxRating,
                            String rank, String maxRank, int contribution, int friendCount, LocalDateTime regTime) {
        return createUser(handle, email, password, firstName, lastName, country, city, organization, rating, maxRating, rank, maxRank, contribution, friendCount, regTime, "USER");
    }

    private User createUser(String handle, String email, String password, String firstName, String lastName,
                            String country, String city, String organization, int rating, int maxRating,
                            String rank, String maxRank, int contribution, int friendCount, LocalDateTime regTime, String role) {
        return userRepository.findByHandle(handle).orElseGet(() -> {
            User user = new User();
            user.setHandle(handle);
            user.setEmail(email);
            user.setPassword(password); // Removed encoding
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setCountry(country);
            user.setCity(city);
            user.setOrganization(organization);
            user.setRating(rating);
            user.setMaxRating(maxRating);
            user.setRank(rank);
            user.setMaxRank(maxRank);
            user.setContribution(contribution);
            user.setFriendCount(friendCount);
            user.setRole(role);
            if (regTime != null) user.setRegistrationTime(regTime);
            return userRepository.save(user);
        });
    }

    private Contest createContest(String name, String type, String phase, int durationSeconds,
                                  LocalDateTime startTime, String description, int participantCount, String preparedBy) {
        List<Contest> existing = contestRepository.findByNameContainingIgnoreCase(name);
        for (Contest c : existing) {
            if (c.getName().equalsIgnoreCase(name)) return c;
        }
        Contest contest = new Contest();
        contest.setName(name);
        contest.setType(type);
        contest.setPhase(phase);
        contest.setDurationSeconds(durationSeconds);
        contest.setStartTime(startTime);
        contest.setDescription(description);
        contest.setParticipantCount(participantCount);
        contest.setPreparedBy(preparedBy);
        return contestRepository.save(contest);
    }

    private Problem createProblem(String contestId, String indexLetter, String name, String statement,
                                   String inputSpec, String outputSpec, String sampleInput, String sampleOutput,
                                   int timeLimitMs, int memoryLimitMb, int difficultyRating, int solvedCount,
                                   Set<Tag> tags, String status) {
        // Simple check for existing problem in same contest with same index
        List<Problem> existing = problemRepository.findByContestId(contestId);
        for(Problem p : existing) {
            if(p.getIndexLetter().equalsIgnoreCase(indexLetter)) return p;
        }

        Problem problem = new Problem();
        problem.setContestId(contestId);
        problem.setIndexLetter(indexLetter);
        problem.setName(name);
        problem.setStatement(statement);
        problem.setInputSpec(inputSpec);
        problem.setOutputSpec(outputSpec);
        problem.setSampleInput(sampleInput);
        problem.setSampleOutput(sampleOutput);
        problem.setTimeLimitMs(timeLimitMs);
        problem.setMemoryLimitMb(memoryLimitMb);
        problem.setDifficultyRating(difficultyRating);
        problem.setSolvedCount(solvedCount);
        problem.setTags(tags);
        if (status != null) problem.setStatus(status);
        return problemRepository.save(problem);
    }

    private void createTestCase(Problem problem, String input, String output, boolean isPublic) {
        TestCase testCase = new TestCase();
        testCase.setProblem(problem);
        testCase.setInput(input);
        testCase.setExpectedOutput(output);
        testCase.setPubliclyVisible(isPublic);
        testCaseRepository.save(testCase);
    }

    private void createBlogPost(String title, String content, User author, int upvotes, int downvotes,
                                     int commentCount, LocalDateTime createdAt, String tags) {
        BlogPost post = new BlogPost();
        post.setTitle(title);
        post.setContent(content);
        post.setAuthor(author);
        post.setUpvotes(upvotes);
        post.setDownvotes(downvotes);
        post.setCommentCount(commentCount);
        post.setCreatedAt(createdAt);
        post.setTags(tags);
        blogPostRepository.save(post);
    }

    private User createOrganizer(String handle, String email, String password) {
        User user = new User();
        user.setHandle(handle);
        user.setEmail(email);
        user.setPassword(password); // Removed encoding
        user.setRole("ORGANIZER");
        user.setRank("Contest Manager");
        user.setMaxRank("Contest Manager");
        return userRepository.save(user);
    }
}
