package com.codeforce.config;

import com.codeforce.model.*;
import com.codeforce.repository.*;
import org.springframework.boot.CommandLineRunner;
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
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository, ProblemRepository problemRepository, 
                           ContestRepository contestRepository, BlogPostRepository blogPostRepository, 
                           TagRepository tagRepository, org.springframework.security.crypto.password.PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.problemRepository = problemRepository;
        this.contestRepository = contestRepository;
        this.blogPostRepository = blogPostRepository;
        this.tagRepository = tagRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {

        System.out.println("--- Bootstrapping CodeForce Application Data ---");
        
        // Ensure Admin exists, has correct role and correctly hashed password
        userRepository.findByHandle("admin").ifPresentOrElse(
            admin -> {
                System.out.println("Found existing 'admin' account. Ensuring role is ADMIN.");
                if (!"ADMIN".equals(admin.getRole())) {
                    admin.setRole("ADMIN");
                    userRepository.save(admin);
                }
            },
            () -> {
                System.out.println("Creating new admin account...");
                userRepository.save(User.builder()
                        .handle("admin").email("admin@cf.com").password(passwordEncoder.encode("admin123"))
                        .firstName("System").lastName("Admin")
                        .role("ADMIN").rank("Admin").maxRank("Admin")
                        .build());
            }
        );

        // Ensure Organizer exists
        if (userRepository.findByHandle("organizer").isEmpty()) {
            System.out.println("Creating default organizer account...");
            createOrganizer("organizer", "organizer@cf.com", passwordEncoder.encode("pass123"));
        }

        if (userRepository.count() > 2) { // 2 because we expect admin + organizer
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
        User tourist = createUser("tourist", "tourist@cf.com", "pass123", "Gennady", "Korotkevich", "Belarus", "Gomel", "ITMO University", 3822, 3979, "Legendary Grandmaster", "Legendary Grandmaster", 200, 15000, LocalDateTime.of(2010, 1, 1, 0, 0));
        User jiangly = createUser("jiangly", "jiangly@cf.com", "pass123", "Jiang", "Ly", "China", "Beijing", null, 3650, 3756, "Legendary Grandmaster", "Legendary Grandmaster", 85, 8000, LocalDateTime.of(2018, 3, 15, 0, 0));
        User benq = createUser("Benq", "benq@cf.com", "pass123", "Benjamin", "Qi", "United States", "New York", "MIT", 3450, 3555, "Legendary Grandmaster", "Legendary Grandmaster", 120, 9500, LocalDateTime.of(2017, 5, 20, 0, 0));
        User ecnerwala = createUser("ecnerwala", "ecnerwala@cf.com", "pass123", "Andrew", "He", "United States", "San Francisco", null, 3200, 3300, "International Grandmaster", "International Grandmaster", 75, 6000, LocalDateTime.of(2015, 8, 10, 0, 0));
        User petr = createUser("Petr", "petr@cf.com", "pass123", "Petr", "Mitrichev", "Russia", "Moscow", "Google", 3100, 3380, "International Grandmaster", "Legendary Grandmaster", 180, 12000, LocalDateTime.of(2009, 2, 1, 0, 0));
        User errichto = createUser("Errichto", "errichto@cf.com", "pass123", "Kamil", "Debowski", "Poland", "Warsaw", null, 2850, 3050, "Grandmaster", "International Grandmaster", 250, 10000, LocalDateTime.of(2013, 6, 1, 0, 0));
        User um_nik = createUser("Um_nik", "umnik@cf.com", "pass123", "Alex", "Danilyuk", "Ukraine", "Kyiv", null, 2750, 2900, "Grandmaster", "Grandmaster", 65, 5500, LocalDateTime.of(2014, 9, 15, 0, 0));
        User newUser = createUser("coder42", "coder42@cf.com", "pass123", "Alex", "Smith", "India", "Mumbai", null, 1550, 1600, "Expert", "Expert", 10, 50, LocalDateTime.of(2023, 1, 1, 0, 0));
        User pupilUser = createUser("algoLearner", "learner@cf.com", "pass123", "Sam", "Johnson", "UK", "London", null, 1100, 1250, "Pupil", "Specialist", 5, 20, LocalDateTime.of(2024, 6, 1, 0, 0));
        User newbie = createUser("newbieCoder", "newbie@cf.com", "pass123", "Min", "Park", "South Korea", "Seoul", null, 800, 900, "Newbie", "Newbie", 0, 5, LocalDateTime.of(2025, 1, 1, 0, 0));
        createUser("syed", "syed@cf.com", "12345", "Syed", "User", "Global", null, null, 0, 0, "Newbie", "Newbie", 0, 0, null);

        // Create Contests
        createContest("Codeforces Round #940 (Div. 2)", "CF", "BEFORE", 7200, LocalDateTime.now().plusDays(3), "Rated contest for Div. 2 participants. Problems cover math, DP, and graph algorithms.", 0, "tourist");
        createContest("Codeforces Round #939 (Div. 1 + Div. 2)", "CF", "BEFORE", 9000, LocalDateTime.now().plusDays(7), "Combined division contest with challenging problems from easy to extremely hard.", 0, "jiangly");
        createContest("Educational Codeforces Round 170", "ICPC", "BEFORE", 7200, LocalDateTime.now().plusDays(10), "Educational round focusing on important algorithms and data structures.", 0, "Errichto");
        createContest("Codeforces Round #938 (Div. 2)", "CF", "FINISHED", 7200, LocalDateTime.now().minusDays(2), "Standard Div. 2 round with 6 problems of increasing difficulty.", 18542, "Benq");
        createContest("Codeforces Round #937 (Div. 3)", "CF", "FINISHED", 7200, LocalDateTime.now().minusDays(5), "Div. 3 round designed for newcomers to competitive programming.", 25630, "Um_nik");
        createContest("Codeforces Round #936 (Div. 1)", "CF", "FINISHED", 7200, LocalDateTime.now().minusDays(8), "High-level Div. 1 contest with advanced algorithmic challenges.", 5200, "Petr");
        createContest("Global Round 28", "CF", "FINISHED", 10800, LocalDateTime.now().minusDays(15), "Open global round rated for all participants with 9 problems.", 32000, "tourist");


        // Create Problems
        Set<Tag> p1Tags = new HashSet<>(); p1Tags.add(math); p1Tags.add(impl);
        createProblem("1920", "A", "Satisfying Constraints", "You are given n constraints on variable x. Each constraint says x must be >= some value, <= some value, or != some value. Find how many integer values of x satisfy all constraints.", "First line: t (1 <= t <= 500) test cases. Each test case: first line n, then n lines with constraint type and value.", "For each test case, print one integer - the number of valid values.", "6\n4\n1 3\n2 10\n3 1\n3 5\n2\n1 5\n2 4\n10\n3 6\n3 7\n1 2\n1 7\n3 100\n3 44\n2 100\n2 98\n1 3\n3 99\n6\n1 5\n2 10\n1 9\n2 2\n3 2\n3 9\n5\n1 1\n2 2\n3 1\n3 2\n3 3\n6\n1 10000\n2 900000000\n3 500000000\n1 100000000\n3 10000\n3 900000001", "7\n0\n90\n0\n0\n800000000", 1000, 256, 800, 42150, p1Tags);

        Set<Tag> p2Tags = new HashSet<>(); p2Tags.add(greedy); p2Tags.add(sortings);
        createProblem("1920", "B", "Summation Game", "Alice and Bob play a game with an array. Alice removes at most k elements, then Bob negates at most m elements. Alice wants to maximize sum, Bob wants to minimize. Both play optimally. Find the final sum.", "First line t test cases. Each: first line n, k, m. Second line: array a.", "For each test case, print Alice's optimal sum.", "5\n4 1 1\n3 1 2 4\n6 6 3\n1 4 3 2 5 6", "2\n0", 1000, 256, 1100, 28300, p2Tags);

        Set<Tag> p3Tags = new HashSet<>(); p3Tags.add(dp); p3Tags.add(math);
        createProblem("1920", "C", "Partitioning the Array", "You have an array of n elements (n is composite). For each divisor d of n, check if you can assign values to make all consecutive blocks of size d equal. Count valid divisors.", "First line t. Each test case: first line n, second line array.", "For each test case, print the count of valid divisors.", "3\n4\n4 2 4 2\n6\n1 2 3 1 2 3", "2\n3", 2000, 256, 1500, 15600, p3Tags);

        Set<Tag> p4Tags = new HashSet<>(); p4Tags.add(binarySearch); p4Tags.add(dp); p4Tags.add(dataStructures);
        createProblem("1920", "D", "Array Repetition", "You start with an empty array s. You perform n operations: either append a value or repeat the entire current array d times. Answer q queries asking for the value at position pos.", "First line t test cases. Each: n and q, then n operations, then q queries.", "For each query, print the value at that position.", "3\n5 10\n1 1\n1 2\n2 3\n1 3\n2 2\n1 2 3 4 5 6 14 15 16 20", "1 2 1 2 3 1 2 3 1 3", 2000, 256, 1800, 8500, p4Tags);

        Set<Tag> p5Tags = new HashSet<>(); p5Tags.add(graphs); p5Tags.add(dp); p5Tags.add(trees);
        createProblem("1920", "E", "Reversible Permutation Pairs", "Count the number of ordered pairs (p, q) of permutations of length n such that for every integer i from 1 to n, p(q(i)) = q(p(i)). Since the answer can be large, output it modulo 998244353.", "Single integer n.", "Single integer - the answer modulo 998244353.", "3", "18", 3000, 512, 2400, 1200, p5Tags);

        Set<Tag> p6Tags = new HashSet<>(); p6Tags.add(impl); p6Tags.add(bruteForce);
        createProblem("1921", "A", "Square", "Given 4 corner points of a square (not necessarily axis-aligned), find its area.", "First line t test cases. Each test case has 4 lines with x, y coordinates.", "For each test case, print the area.", "3\n1 2 4 5 1 5 4 2\n-1 1 1 -1 -1 -1 1 1\n45 11 45 39 17 11 17 39", "9\n4\n784", 1000, 256, 800, 55000, p6Tags);

        Set<Tag> p7Tags = new HashSet<>(); p7Tags.add(constructive); p7Tags.add(greedy);
        createProblem("1921", "B", "Arranging Cats", "You have a binary string of length n representing cats on a shelf. In one operation you can place a cat, remove a cat, or swap two positions. Find the minimum operations to transform string s into string t.", "First line t. Each test case: n, strings s and t.", "Minimum number of operations per test case.", "4\n5\n10010\n00001\n1\n1\n1\n4\n0101\n1010\n3\n100\n101", "2\n0\n2\n1", 1000, 256, 900, 48000, p7Tags);

        Set<Tag> p8Tags = new HashSet<>(); p8Tags.add(strings); p8Tags.add(dp);
        createProblem("1921", "C", "Sending Messages", "Your phone has charge f. At each moment i you can send messages. Between moments phone loses charge. You can turn it off and on for free. Can you send all n messages?", "First line t. Each test case: n, f, a, b. Next line: n message times.", "YES or NO for each test case.", "6\n1 10 3 1\n6\n2 10 3 1\n6 10\n2 10 3 2\n6 10\n1 1000000000000000000 1000000000000000000 1000000000000000000\n1000000000000000000\n3 11 9 6\n6 8 12\n12 621526648202 708592 1000000000\n1 51 96 98 102 192 200 257 512 621526648201", "YES\nYES\nNO\nNO\nYES\nYES", 1000, 256, 1300, 20100, p8Tags);

        Set<Tag> p9Tags = new HashSet<>(); p9Tags.add(math); p9Tags.add(numberTheory);
        createProblem("1921", "D", "Very Different Array", "You have two arrays a and b of length n. You can rearrange both arrays. Maximize the sum of |a[i] - b[i]| over all i from 1 to n.", "First line t. Each test case: n, then arrays a and b.", "Maximum possible sum for each test case.", "5\n1\n5\n3\n2\n1 2\n4 3\n4\n1 2 3 4\n5 6 7 8\n5\n1 1 1 1 1\n1000000000 1000000000 1000000000 1000000000 1000000000", "2\n6\n20\n4999999995", 2000, 256, 1100, 30500, p9Tags);

        Set<Tag> p10Tags = new HashSet<>(); p10Tags.add(graphs); p10Tags.add(dfs);
        createProblem("1921", "E", "Counting Prefixes", "You are given a tree with n vertices rooted at vertex 1. Each vertex has a character. Count the number of distinct strings that appear as a prefix of the path from root to any leaf.", "First line n. Next line characters. Next n-1 lines: edges.", "Number of distinct prefix strings.", "5\nabcab\n1 2\n1 3\n2 4\n2 5", "4", 2000, 256, 2100, 3200, p10Tags);

        Set<Tag> p11Tags = new HashSet<>(); p11Tags.add(impl); p11Tags.add(math);
        createProblem("1922", "A", "Tricky Template", "You are given three binary strings a, b, c of the same length. Find a template string that matches a and b but not c, or report it's impossible.", "First line t. Each test case: n, then strings a, b, c.", "YES or NO for each test case.", "4\n1\na\nb\nc\n2\naa\nbb\naa\n10\nmathforces\nluckforces\nadhoccoder", "YES\nNO\nYES", 1000, 256, 800, 51000, p11Tags);

        Set<Tag> p12Tags = new HashSet<>(); p12Tags.add(sortings); p12Tags.add(greedy); p12Tags.add(dataStructures);
        createProblem("1922", "B", "Forming Triangles", "You have n sticks with lengths that are powers of 2. Count the number of ways to choose 3 sticks that can form a non-degenerate triangle.", "First line t. Each test case: n, then array of exponents.", "Number of valid triangles for each test case.", "4\n1\n1\n3\n1 1 1\n6\n0 1 2 3 4 5", "0\n1\n0", 2000, 256, 1200, 22000, p12Tags);

        // Create Blog Posts


        createBlogPost("Codeforces Round #940 Editorial", "Here we present the editorial for all problems from Round #940. Problem A (Satisfying Constraints): The key observation is to track the maximum lower bound and minimum upper bound from type 1 and 2 constraints, then subtract excluded values. Problem B uses a greedy sorting approach...", tourist, 156, 3, 42, LocalDateTime.now().minusHours(6), "editorial,div2,round940");
        createBlogPost("Tips for Competitive Programming Beginners", "Welcome to competitive programming! Here are my top tips for getting started: 1. Master the basics - arrays, strings, sorting. 2. Learn standard algorithms - BFS, DFS, binary search. 3. Practice daily on Codeforces. 4. Read editorials after contests. 5. Don't give up after wrong answers!", errichto, 320, 5, 89, LocalDateTime.now().minusDays(1), "tutorial,beginners,tips");
        createBlogPost("Segment Trees: A Complete Guide", "In this blog, I explain segment trees from scratch. A segment tree is a data structure that allows you to answer range queries and perform range updates efficiently. Topics covered: basic segment tree, lazy propagation, persistent segment tree, and 2D segment trees.", benq, 528, 8, 134, LocalDateTime.now().minusDays(3), "tutorial,segment-tree,data-structures");
        createBlogPost("My Journey to Grandmaster", "After 3 years of competitive programming, I finally reached Grandmaster rank! Here's what I learned along the way: consistency is key, always upsolve contest problems, focus on weak topics, and participate in every contest you can.", um_nik, 245, 12, 67, LocalDateTime.now().minusDays(5), "experience,journey,motivation");
        createBlogPost("Educational Round 170 Announcement", "We are pleased to announce Educational Codeforces Round 170! The round will take place in 10 days. It will be rated for users with rating below 2100. Please register in advance. Good luck to all participants!", petr, 89, 2, 23, LocalDateTime.now().minusDays(7), "announcement,educational,contest");
        createBlogPost("Dynamic Programming Optimization Techniques", "Advanced DP optimization techniques every competitive programmer should know: Convex Hull Trick, Divide and Conquer optimization, Knuth's optimization, and Aliens trick. Each technique with detailed examples and practice problems.", jiangly, 412, 6, 95, LocalDateTime.now().minusDays(10), "tutorial,dp,optimization");
        createBlogPost("How to Prepare for ICPC Regionals", "ICPC regionals are coming up! Here is a comprehensive preparation guide: team practice strategies, topic distribution among team members, library preparation, and mental preparation tips.", ecnerwala, 178, 4, 51, LocalDateTime.now().minusDays(12), "icpc,preparation,team");
    }

    private Tag createTag(String name, int problemCount) {
        Tag tag = new Tag();
        tag.setName(name);
        tag.setProblemCount(problemCount);
        return tagRepository.save(tag);
    }

    private User createUser(String handle, String email, String password, String firstName, String lastName, String country, String city, String org, int rating, int maxRating, String rank, String maxRank, int contribution, int friendCount, LocalDateTime regTime) {
        User user = new User();
        user.setHandle(handle);
        user.setEmail(email);
        user.setPassword(password);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setCountry(country);
        user.setCity(city);
        user.setOrganization(org);
        user.setRating(rating);
        user.setMaxRating(maxRating);
        user.setRank(rank);
        user.setMaxRank(maxRank);
        user.setContribution(contribution);
        user.setFriendCount(friendCount);
        if (regTime != null) user.setRegistrationTime(regTime);
        return userRepository.save(user);
    }

    private void createContest(String name, String type, String phase, int duration, LocalDateTime startTime, String desc, int count, String preparedBy) {
        Contest contest = new Contest();
        contest.setName(name);
        contest.setType(type);
        contest.setPhase(phase);
        contest.setDurationSeconds(duration);
        contest.setStartTime(startTime);
        contest.setDescription(desc);
        contest.setParticipantCount(count);
        contest.setPreparedBy(preparedBy);
        contestRepository.save(contest);
    }

    private void createProblem(String contestId, String index, String name, String statement, String input, String output, String sInput, String sOutput, int time, int mem, int diff, int solved, Set<Tag> tags) {
        Problem p = new Problem();
        p.setContestId(contestId);
        p.setIndexLetter(index);
        p.setName(name);
        p.setStatement(statement);
        p.setInputSpec(input);
        p.setOutputSpec(output);
        p.setSampleInput(sInput);
        p.setSampleOutput(sOutput);
        p.setTimeLimitMs(time);
        p.setMemoryLimitMb(mem);
        p.setDifficultyRating(diff);
        p.setSolvedCount(solved);
        p.setTags(tags);
        problemRepository.save(p);
    }

    private void createBlogPost(String title, String content, User author, int up, int down, int comments, LocalDateTime created, String tags) {
        BlogPost post = new BlogPost();
        post.setTitle(title);
        post.setContent(content);
        post.setAuthor(author);
        post.setUpvotes(up);
        post.setDownvotes(down);
        post.setCommentCount(comments);
        post.setCreatedAt(created);
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
