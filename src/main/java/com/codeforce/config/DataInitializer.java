package com.codeforce.config;

import com.codeforce.model.*;
import com.codeforce.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashSet;
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
                if (!"ADMIN".equals(admin.getRole())) {
                    admin.setRole("ADMIN");
                    userRepository.save(admin);
                }
            },
            () -> {
                userRepository.save(User.builder()
                        .handle("admin").email("admin@cf.com").password(passwordEncoder.encode("admin123"))
                        .firstName("System").lastName("Admin")
                        .role("ADMIN").rank("Admin").maxRank("Admin")
                        .build());
            }
        );

        // Ensure Organizer exists
        if (userRepository.findByHandle("organizer").isEmpty()) {
            createOrganizer("organizer", "organizer@cf.com", passwordEncoder.encode("pass123"));
        }

        // Ensure Tester exists
        if (userRepository.findByHandle("tester").isEmpty()) {
            createUser("tester", "tester@cf.com", "pass123", "Default", "Tester",
                    "Global", null, null, 1200, 1200,
                    "Pupil", "Pupil", 0, 0, null);
        }

        if (userRepository.count() > 3) {
            System.out.println("Data already initialized. Skipping sample users/problems.");
            return;
        }

        System.out.println("Initializing sample data...");
        String defaultPass = passwordEncoder.encode("pass123");

        // Create Tags
        Tag dp = createTag("dp", 5);
        Tag greedy = createTag("greedy", 4);
        Tag math = createTag("math", 6);
        Tag graphs = createTag("graphs", 3);
        Tag strings = createTag("strings", 4);
        Tag binarySearch = createTag("binary search", 3);
        Tag sortings = createTag("sortings", 5);
        Tag impl = createTag("implementation", 7);
        Tag bruteForce = createTag("brute force", 5);
        Tag dataStructures = createTag("data structures", 4);
        Tag constructive = createTag("constructive algorithms", 3);
        Tag numberTheory = createTag("number theory", 2);
        Tag dfs = createTag("dfs and similar", 2);
        Tag trees = createTag("trees", 2);

        // Create Users
        User tourist = createUser("tourist", "tourist@cf.com", "pass123", "Gennady", "Korotkevich",
                "Belarus", "Gomel", "ITMO University", 3822, 3979,
                "Legendary Grandmaster", "Legendary Grandmaster", 200, 15000,
                LocalDateTime.of(2010, 1, 1, 0, 0));

        User jiangly = createUser("jiangly", "jiangly@cf.com", "pass123", "Jiang", "Ly",
                "China", "Beijing", null, 3650, 3756,
                "Legendary Grandmaster", "Legendary Grandmaster", 85, 8000,
                LocalDateTime.of(2018, 3, 15, 0, 0));

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
                "Newbie", "Newbie", 0, 0, null);

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
        createProblem("1920", "A", "Satisfying Constraints",
                "You are given n constraints on variable x. Each constraint says x must be >= some value, <= some value, or != some value. Find how many integer values of x satisfy all constraints.",
                "First line: t (1 <= t <= 500) test cases. Each test case: first line n, then n lines with constraint type and value.",
                "For each test case, print one integer - the number of valid values.",
                "6\n4\n1 3\n2 10\n3 1\n3 5\n2\n1 5\n2 4\n10\n3 6\n3 7\n1 2\n1 7\n3 100\n3 44\n2 100\n2 98\n1 3\n3 99\n6\n1 5\n2 10\n1 9\n2 2\n3 2\n3 9\n5\n1 1\n2 2\n3 1\n3 2\n3 3\n6\n1 10000\n2 900000000\n3 500000000\n1 100000000\n3 10000\n3 900000001",
                "7\n0\n90\n0\n0\n800000000",
                1000, 256, 800, 42150, p1Tags, "APPROVED");

        Set<Tag> p2Tags = new HashSet<>(); p2Tags.add(greedy); p2Tags.add(sortings);
        createProblem("1920", "B", "Summation Game",
                "Alice and Bob play a game with an array. Alice removes at most k elements, then Bob negates at most m elements. Alice wants to maximize sum, Bob wants to minimize. Both play optimally. Find the final sum.",
                "First line t test cases. Each: first line n, k, m. Second line: array a.",
                "For each test case, print Alice's optimal sum.",
                "5\n4 1 1\n3 1 2 4\n6 6 3\n1 4 3 2 5 6",
                "2\n0",
                1000, 256, 1100, 28300, p2Tags, "APPROVED");

        Set<Tag> p3Tags = new HashSet<>(); p3Tags.add(dp); p3Tags.add(math);
        createProblem("1920", "C", "Partitioning the Array",
                "You have an array of n elements (n is composite). For each divisor d of n, check if you can assign values to make all consecutive blocks of size d equal. Count valid divisors.",
                "First line t. Each test case: first line n, second line array.",
                "For each test case, print the count of valid divisors.",
                "3\n4\n4 2 4 2\n6\n1 2 3 1 2 3",
                "2\n3",
                2000, 256, 1500, 15600, p3Tags, "APPROVED");

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
        Tag tag = new Tag();
        tag.setName(name);
        tag.setProblemCount(problemCount);
        return tagRepository.save(tag);
    }

    private User createUser(String handle, String email, String password, String firstName, String lastName,
                            String country, String city, String organization, int rating, int maxRating,
                            String rank, String maxRank, int contribution, int friendCount, LocalDateTime regTime) {
        User user = new User();
        user.setHandle(handle);
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(password));
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
        if (regTime != null) user.setRegistrationTime(regTime);
        return userRepository.save(user);
    }

    private Contest createContest(String name, String type, String phase, int durationSeconds,
                                  LocalDateTime startTime, String description, int participantCount, String preparedBy) {
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
        testCase.setPublic(isPublic);
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
        user.setPassword(password);
        user.setRole("ORGANIZER");
        user.setRank("Contest Manager");
        user.setMaxRank("Contest Manager");
        return userRepository.save(user);
    }
}
