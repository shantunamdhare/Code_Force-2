package com.codeforce.config;

import com.codeforce.model.*;
import com.codeforce.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final ProblemRepository problemRepository;
    private final ContestRepository contestRepository;
    private final BlogPostRepository blogPostRepository;
    private final TagRepository tagRepository;
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

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

        if (userRepository.count() > 1) {
            System.out.println("Data already initialized. Skipping sample users/problems.");
            return;
        }

        System.out.println("Initializing sample data...");
        String defaultPass = passwordEncoder.encode("pass123");

        // Create Tags
        Tag dp = tagRepository.save(Tag.builder().name("dp").problemCount(5).build());
        Tag greedy = tagRepository.save(Tag.builder().name("greedy").problemCount(4).build());
        Tag math = tagRepository.save(Tag.builder().name("math").problemCount(6).build());
        Tag graphs = tagRepository.save(Tag.builder().name("graphs").problemCount(3).build());
        Tag strings = tagRepository.save(Tag.builder().name("strings").problemCount(4).build());
        Tag binarySearch = tagRepository.save(Tag.builder().name("binary search").problemCount(3).build());
        Tag sortings = tagRepository.save(Tag.builder().name("sortings").problemCount(5).build());
        Tag impl = tagRepository.save(Tag.builder().name("implementation").problemCount(7).build());
        Tag bruteForce = tagRepository.save(Tag.builder().name("brute force").problemCount(5).build());
        Tag dataStructures = tagRepository.save(Tag.builder().name("data structures").problemCount(4).build());
        Tag constructive = tagRepository.save(Tag.builder().name("constructive algorithms").problemCount(3).build());
        Tag numberTheory = tagRepository.save(Tag.builder().name("number theory").problemCount(2).build());
        Tag dfs = tagRepository.save(Tag.builder().name("dfs and similar").problemCount(2).build());
        Tag trees = tagRepository.save(Tag.builder().name("trees").problemCount(2).build());

        // Create realistic users
        User u1 = userRepository.save(User.builder()
                .handle("codeMaster99").email("cm99@cf.com").password(defaultPass)
                .firstName("Robert").lastName("Miller")
                .country("USA").city("Austin").organization("University of Texas")
                .rating(2450).maxRating(2600).rank("Grandmaster").maxRank("Grandmaster")
                .contribution(45).friendCount(500).registrationTime(LocalDateTime.now().minusYears(3)).build());

        User u2 = userRepository.save(User.builder()
                .handle("algoExpert").email("ae@cf.com").password(defaultPass)
                .firstName("Elena").lastName("Petrova")
                .country("Russia").city("Saint Petersburg").organization("ITMO University")
                .rating(2900).maxRating(2950).rank("International Grandmaster").maxRank("International Grandmaster")
                .contribution(120).friendCount(1200).registrationTime(LocalDateTime.now().minusYears(5)).build());

        User u3 = userRepository.save(User.builder()
                .handle("dpGeek").email("dg@cf.com").password(defaultPass)
                .firstName("Sanjay").lastName("Gupta")
                .country("India").city("Bangalore").organization("IIT Bombay")
                .rating(1950).maxRating(2100).rank("Candidate Master").maxRank("Master")
                .contribution(30).friendCount(300).registrationTime(LocalDateTime.now().minusYears(2)).build());

        User u4 = userRepository.save(User.builder()
                .handle("graphViz").email("gv@cf.com").password(defaultPass)
                .firstName("Li").lastName("Wei")
                .country("China").city("Shanghai").organization("Tsinghua University")
                .rating(3200).maxRating(3300).rank("International Grandmaster").maxRank("International Grandmaster")
                .contribution(85).friendCount(2500).registrationTime(LocalDateTime.now().minusYears(6)).build());

        User u5 = userRepository.save(User.builder()
                .handle("fastCoderX").email("fcx@cf.com").password(defaultPass)
                .firstName("Hans").lastName("Schmidt")
                .country("Germany").city("Berlin").organization("TU Berlin")
                .rating(1550).maxRating(1700).rank("Expert").maxRank("Expert")
                .contribution(15).friendCount(80).registrationTime(LocalDateTime.now().minusYears(1)).build());

        User u6 = userRepository.save(User.builder()
                .handle("newbieAlgo").email("na@cf.com").password(defaultPass)
                .firstName("Sarah").lastName("Jones")
                .country("UK").city("Manchester")
                .rating(1100).maxRating(1200).rank("Pupil").maxRank("Pupil")
                .contribution(5).friendCount(15).registrationTime(LocalDateTime.now().minusMonths(6)).build());

        User u7 = userRepository.save(User.builder()
                .handle("bitManipulator").email("bm@cf.com").password(defaultPass)
                .firstName("Yuki").lastName("Tanaka")
                .country("Japan").city("Tokyo").organization("University of Tokyo")
                .rating(2750).maxRating(2800).rank("Grandmaster").maxRank("Grandmaster")
                .contribution(50).friendCount(900).registrationTime(LocalDateTime.now().minusYears(4)).build());

        User newbie = userRepository.save(User.builder()
                .handle("newbieCoder").email("newbie@cf.com").password(defaultPass)
                .firstName("Min").lastName("Park")
                .country("South Korea").city("Seoul")
                .rating(800).maxRating(900)
                .rank("Newbie").maxRank("Newbie")
                .contribution(0).friendCount(5)
                .registrationTime(LocalDateTime.of(2025, 1, 1, 0, 0))
                .build());

        // Create Default Syed account for testing
        userRepository.save(User.builder()
                .handle("syed").email("syed@cf.com").password(defaultPass)
                .firstName("Syed").lastName("User")
                .country("Global")
                .rating(0).maxRating(0)
                .rank("Newbie").maxRank("Newbie")
                .build());

        // Create Contests
        contestRepository.save(Contest.builder()
                .name("Codeforces Round #940 (Div. 2)")
                .type("CF").phase("BEFORE")
                .durationSeconds(7200)
                .startTime(LocalDateTime.now().plusDays(3))
                .description("Rated contest for Div. 2 participants. Problems cover math, DP, and graph algorithms.")
                .participantCount(0)
                .preparedBy("tourist")
                .build());

        contestRepository.save(Contest.builder()
                .name("Codeforces Round #939 (Div. 1 + Div. 2)")
                .type("CF").phase("BEFORE")
                .durationSeconds(9000)
                .startTime(LocalDateTime.now().plusDays(7))
                .description("Combined division contest with challenging problems from easy to extremely hard.")
                .participantCount(0)
                .preparedBy("jiangly")
                .build());

        contestRepository.save(Contest.builder()
                .name("Educational Codeforces Round 170")
                .type("ICPC").phase("BEFORE")
                .durationSeconds(7200)
                .startTime(LocalDateTime.now().plusDays(10))
                .description("Educational round focusing on important algorithms and data structures.")
                .participantCount(0)
                .preparedBy("Errichto")
                .build());

        contestRepository.save(Contest.builder()
                .name("Codeforces Round #938 (Div. 2)")
                .type("CF").phase("FINISHED")
                .durationSeconds(7200)
                .startTime(LocalDateTime.now().minusDays(2))
                .description("Standard Div. 2 round with 6 problems of increasing difficulty.")
                .participantCount(18542)
                .preparedBy("Benq")
                .build());

        contestRepository.save(Contest.builder()
                .name("Codeforces Round #937 (Div. 3)")
                .type("CF").phase("FINISHED")
                .durationSeconds(7200)
                .startTime(LocalDateTime.now().minusDays(5))
                .description("Div. 3 round designed for newcomers to competitive programming.")
                .participantCount(25630)
                .preparedBy("Um_nik")
                .build());

        contestRepository.save(Contest.builder()
                .name("Codeforces Round #936 (Div. 1)")
                .type("CF").phase("FINISHED")
                .durationSeconds(7200)
                .startTime(LocalDateTime.now().minusDays(8))
                .description("High-level Div. 1 contest with advanced algorithmic challenges.")
                .participantCount(5200)
                .preparedBy("algoExpert")
                .build());

        contestRepository.save(Contest.builder()
                .name("Global Round 28")
                .type("CF").phase("FINISHED")
                .durationSeconds(10800)
                .startTime(LocalDateTime.now().minusDays(15))
                .description("Open global round rated for all participants with 9 problems.")
                .participantCount(32000)
                .preparedBy("codeMaster99")
                .build());

        // Create Problems
        Set<Tag> p1Tags = new HashSet<>(); p1Tags.add(math); p1Tags.add(impl);
        problemRepository.save(Problem.builder()
                .contestId("1920").indexLetter("A")
                .name("Satisfying Constraints")
                .statement("You are given n constraints on variable x. Each constraint says x must be >= some value, <= some value, or != some value. Find how many integer values of x satisfy all constraints.")
                .inputSpec("First line: t (1 <= t <= 500) test cases. Each test case: first line n, then n lines with constraint type and value.")
                .outputSpec("For each test case, print one integer - the number of valid values.")
                .sampleInput("6\n4\n1 3\n2 10\n3 1\n3 5\n2\n1 5\n2 4\n10\n3 6\n3 7\n1 2\n1 7\n3 100\n3 44\n2 100\n2 98\n1 3\n3 99\n6\n1 5\n2 10\n1 9\n2 2\n3 2\n3 9\n5\n1 1\n2 2\n3 1\n3 2\n3 3\n6\n1 10000\n2 900000000\n3 500000000\n1 100000000\n3 10000\n3 900000001")
                .sampleOutput("7\n0\n90\n0\n0\n800000000")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(800).solvedCount(42150)
                .tags(p1Tags)
                .build());

        Set<Tag> p2Tags = new HashSet<>(); p2Tags.add(greedy); p2Tags.add(sortings);
        problemRepository.save(Problem.builder()
                .contestId("1920").indexLetter("B")
                .name("Summation Game")
                .statement("Alice and Bob play a game with an array. Alice removes at most k elements, then Bob negates at most m elements. Alice wants to maximize sum, Bob wants to minimize. Both play optimally. Find the final sum.")
                .inputSpec("First line t test cases. Each: first line n, k, m. Second line: array a.")
                .outputSpec("For each test case, print Alice's optimal sum.")
                .sampleInput("5\n4 1 1\n3 1 2 4\n6 6 3\n1 4 3 2 5 6")
                .sampleOutput("2\n0")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(1100).solvedCount(28300)
                .tags(p2Tags)
                .build());

        Set<Tag> p3Tags = new HashSet<>(); p3Tags.add(dp); p3Tags.add(math);
        problemRepository.save(Problem.builder()
                .contestId("1920").indexLetter("C")
                .name("Partitioning the Array")
                .statement("You have an array of n elements (n is composite). For each divisor d of n, check if you can assign values to make all consecutive blocks of size d equal. Count valid divisors.")
                .inputSpec("First line t. Each test case: first line n, second line array.")
                .outputSpec("For each test case, print the count of valid divisors.")
                .sampleInput("3\n4\n4 2 4 2\n6\n1 2 3 1 2 3")
                .sampleOutput("2\n3")
                .timeLimitMs(2000).memoryLimitMb(256)
                .difficultyRating(1500).solvedCount(15600)
                .tags(p3Tags)
                .build());

        Set<Tag> p4Tags = new HashSet<>(); p4Tags.add(binarySearch); p4Tags.add(dp); p4Tags.add(dataStructures);
        problemRepository.save(Problem.builder()
                .contestId("1920").indexLetter("D")
                .name("Array Repetition")
                .statement("You start with an empty array s. You perform n operations: either append a value or repeat the entire current array d times. Answer q queries asking for the value at position pos.")
                .inputSpec("First line t test cases. Each: n and q, then n operations, then q queries.")
                .outputSpec("For each query, print the value at that position.")
                .sampleInput("3\n5 10\n1 1\n1 2\n2 3\n1 3\n2 2\n1 2 3 4 5 6 14 15 16 20")
                .sampleOutput("1 2 1 2 3 1 2 3 1 3")
                .timeLimitMs(2000).memoryLimitMb(256)
                .difficultyRating(1800).solvedCount(8500)
                .tags(p4Tags)
                .build());

        Set<Tag> p5Tags = new HashSet<>(); p5Tags.add(graphs); p5Tags.add(dp); p5Tags.add(trees);
        problemRepository.save(Problem.builder()
                .contestId("1920").indexLetter("E")
                .name("Reversible Permutation Pairs")
                .statement("Count the number of ordered pairs (p, q) of permutations of length n such that for every integer i from 1 to n, p(q(i)) = q(p(i)). Since the answer can be large, output it modulo 998244353.")
                .inputSpec("Single integer n.")
                .outputSpec("Single integer - the answer modulo 998244353.")
                .sampleInput("3")
                .sampleOutput("18")
                .timeLimitMs(3000).memoryLimitMb(512)
                .difficultyRating(2400).solvedCount(1200)
                .tags(p5Tags)
                .build());

        Set<Tag> p6Tags = new HashSet<>(); p6Tags.add(impl); p6Tags.add(bruteForce);
        problemRepository.save(Problem.builder()
                .contestId("1921").indexLetter("A")
                .name("Square")
                .statement("Given 4 corner points of a square (not necessarily axis-aligned), find its area.")
                .inputSpec("First line t test cases. Each test case has 4 lines with x, y coordinates.")
                .outputSpec("For each test case, print the area.")
                .sampleInput("3\n1 2 4 5 1 5 4 2\n-1 1 1 -1 -1 -1 1 1\n45 11 45 39 17 11 17 39")
                .sampleOutput("9\n4\n784")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(800).solvedCount(55000)
                .tags(p6Tags)
                .build());

        Set<Tag> p7Tags = new HashSet<>(); p7Tags.add(constructive); p7Tags.add(greedy);
        problemRepository.save(Problem.builder()
                .contestId("1921").indexLetter("B")
                .name("Arranging Cats")
                .statement("You have a binary string of length n representing cats on a shelf. In one operation you can place a cat, remove a cat, or swap two positions. Find the minimum operations to transform string s into string t.")
                .inputSpec("First line t. Each test case: n, strings s and t.")
                .outputSpec("Minimum number of operations per test case.")
                .sampleInput("4\n5\n10010\n00001\n1\n1\n1\n4\n0101\n1010\n3\n100\n101")
                .sampleOutput("2\n0\n2\n1")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(900).solvedCount(48000)
                .tags(p7Tags)
                .build());

        Set<Tag> p8Tags = new HashSet<>(); p8Tags.add(strings); p8Tags.add(dp);
        problemRepository.save(Problem.builder()
                .contestId("1921").indexLetter("C")
                .name("Sending Messages")
                .statement("Your phone has charge f. At each moment i you can send messages. Between moments phone loses charge. You can turn it off and on for free. Can you send all n messages?")
                .inputSpec("First line t. Each test case: n, f, a, b. Next line: n message times.")
                .outputSpec("YES or NO for each test case.")
                .sampleInput("6\n1 10 3 1\n6\n2 10 3 1\n6 10\n2 10 3 2\n6 10\n1 1000000000000000000 1000000000000000000 1000000000000000000\n1000000000000000000\n3 11 9 6\n6 8 12\n12 621526648202 708592 1000000000\n1 51 96 98 102 192 200 257 512 621526648201")
                .sampleOutput("YES\nYES\nNO\nNO\nYES\nYES")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(1300).solvedCount(20100)
                .tags(p8Tags)
                .build());

        Set<Tag> p9Tags = new HashSet<>(); p9Tags.add(math); p9Tags.add(numberTheory);
        problemRepository.save(Problem.builder()
                .contestId("1921").indexLetter("D")
                .name("Very Different Array")
                .statement("You have two arrays a and b of length n. You can rearrange both arrays. Maximize the sum of |a[i] - b[i]| over all i from 1 to n.")
                .inputSpec("First line t. Each test case: n, then arrays a and b.")
                .outputSpec("Maximum possible sum for each test case.")
                .sampleInput("5\n1\n5\n3\n2\n1 2\n4 3\n4\n1 2 3 4\n5 6 7 8\n5\n1 1 1 1 1\n1000000000 1000000000 1000000000 1000000000 1000000000")
                .sampleOutput("2\n6\n20\n4999999995")
                .timeLimitMs(2000).memoryLimitMb(256)
                .difficultyRating(1100).solvedCount(30500)
                .tags(p9Tags)
                .build());

        Set<Tag> p10Tags = new HashSet<>(); p10Tags.add(graphs); p10Tags.add(dfs);
        problemRepository.save(Problem.builder()
                .contestId("1921").indexLetter("E")
                .name("Counting Prefixes")
                .statement("You are given a tree with n vertices rooted at vertex 1. Each vertex has a character. Count the number of distinct strings that appear as a prefix of the path from root to any leaf.")
                .inputSpec("First line n. Next line characters. Next n-1 lines: edges.")
                .outputSpec("Number of distinct prefix strings.")
                .sampleInput("5\nabcab\n1 2\n1 3\n2 4\n2 5")
                .sampleOutput("4")
                .timeLimitMs(2000).memoryLimitMb(256)
                .difficultyRating(2100).solvedCount(3200)
                .tags(p10Tags)
                .build());

        // Additional problems from different rounds
        Set<Tag> p11Tags = new HashSet<>(); p11Tags.add(impl); p11Tags.add(math);
        problemRepository.save(Problem.builder()
                .contestId("1922").indexLetter("A")
                .name("Tricky Template")
                .statement("You are given three binary strings a, b, c of the same length. Find a template string that matches a and b but not c, or report it's impossible.")
                .inputSpec("First line t. Each test case: n, then strings a, b, c.")
                .outputSpec("YES or NO for each test case.")
                .sampleInput("4\n1\na\nb\nc\n2\naa\nbb\naa\n10\nmathforces\nluckforces\nadhoccoder")
                .sampleOutput("YES\nNO\nYES")
                .timeLimitMs(1000).memoryLimitMb(256)
                .difficultyRating(800).solvedCount(51000)
                .tags(p11Tags)
                .build());

        Set<Tag> p12Tags = new HashSet<>(); p12Tags.add(sortings); p12Tags.add(greedy); p12Tags.add(dataStructures);
        problemRepository.save(Problem.builder()
                .contestId("1922").indexLetter("B")
                .name("Forming Triangles")
                .statement("You have n sticks with lengths that are powers of 2. Count the number of ways to choose 3 sticks that can form a non-degenerate triangle.")
                .inputSpec("First line t. Each test case: n, then array of exponents.")
                .outputSpec("Number of valid triangles for each test case.")
                .sampleInput("4\n1\n1\n3\n1 1 1\n6\n0 1 2 3 4 5")
                .sampleOutput("0\n1\n0")
                .timeLimitMs(2000).memoryLimitMb(256)
                .difficultyRating(1200).solvedCount(22000)
                .tags(p12Tags)
                .build());

        // Create Blog Posts
        blogPostRepository.save(BlogPost.builder()
                .title("Codeforces Round #940 Editorial")
                .content("Here we present the editorial for all problems from Round #940. Problem A (Satisfying Constraints): The key observation is to track the maximum lower bound and minimum upper bound from type 1 and 2 constraints, then subtract excluded values. Problem B uses a greedy sorting approach...")
                .author(u1)
                .upvotes(156).downvotes(3)
                .commentCount(42)
                .createdAt(LocalDateTime.now().minusHours(6))
                .tags("editorial,div2,round940")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("Tips for Competitive Programming Beginners")
                .content("Welcome to competitive programming! Here are my top tips for getting started: 1. Master the basics - arrays, strings, sorting. 2. Learn standard algorithms - BFS, DFS, binary search. 3. Practice daily on Codeforces. 4. Read editorials after contests. 5. Don't give up after wrong answers!")
                .author(u2)
                .upvotes(320).downvotes(5)
                .commentCount(89)
                .createdAt(LocalDateTime.now().minusDays(1))
                .tags("tutorial,beginners,tips")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("Segment Trees: A Complete Guide")
                .content("In this blog, I explain segment trees from scratch. A segment tree is a data structure that allows you to answer range queries and perform range updates efficiently. Topics covered: basic segment tree, lazy propagation, persistent segment tree, and 2D segment trees.")
                .author(u3)
                .upvotes(528).downvotes(8)
                .commentCount(134)
                .createdAt(LocalDateTime.now().minusDays(3))
                .tags("tutorial,segment-tree,data-structures")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("My Journey to Grandmaster")
                .content("After 3 years of competitive programming, I finally reached Grandmaster rank! Here's what I learned along the way: consistency is key, always upsolve contest problems, focus on weak topics, and participate in every contest you can.")
                .author(u4)
                .upvotes(245).downvotes(12)
                .commentCount(67)
                .createdAt(LocalDateTime.now().minusDays(5))
                .tags("experience,journey,motivation")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("Educational Round 170 Announcement")
                .content("We are pleased to announce Educational Codeforces Round 170! The round will take place in 10 days. It will be rated for users with rating below 2100. Please register in advance. Good luck to all participants!")
                .author(u5)
                .upvotes(89).downvotes(2)
                .commentCount(23)
                .createdAt(LocalDateTime.now().minusDays(7))
                .tags("announcement,educational,contest")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("Dynamic Programming Optimization Techniques")
                .content("Advanced DP optimization techniques every competitive programmer should know: Convex Hull Trick, Divide and Conquer optimization, Knuth's optimization, and Aliens trick. Each technique with detailed examples and practice problems.")
                .author(u6)
                .upvotes(412).downvotes(6)
                .commentCount(95)
                .createdAt(LocalDateTime.now().minusDays(10))
                .tags("tutorial,dp,optimization")
                .build());

        blogPostRepository.save(BlogPost.builder()
                .title("How to Prepare for ICPC Regionals")
                .content("ICPC regionals are coming up! Here is a comprehensive preparation guide: team practice strategies, topic distribution among team members, library preparation, and mental preparation tips.")
                .author(u7)
                .upvotes(178).downvotes(4)
                .commentCount(51)
                .createdAt(LocalDateTime.now().minusDays(12))
                .tags("icpc,preparation,team")
                .build());
    }
}
