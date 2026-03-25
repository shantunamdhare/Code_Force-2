<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeForce Pro | World-Class Competitive Coding Platform</title>
    
    <!-- Base Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <!-- Icons -->
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- Modern Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-coral: #FF6B6B;
            --primary-teal: #4ECDC4;
            --primary-blue: #3498DB;
            --text-dark: #1E293B;
            --text-slate: #475569;
            --text-muted: #94A3B8;
            --bg-glass: rgba(255, 255, 255, 0.75);
            --header-h: 90px;
        }

        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Outfit', sans-serif;
            background: #FBFCFE;
            color: var(--text-dark);
            line-height: 1.5;
            overflow-x: hidden;
        }

        /* --- Header: Ultra Modern Glass --- */
        .header {
            height: var(--header-h);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 6%;
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 88%;
            z-index: 1000;
            background: var(--bg-glass);
            backdrop-filter: blur(25px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            box-shadow: 0 10px 40px rgba(0,0,0,0.03);
            transition: all 0.4s ease;
        }

        .header.scrolled { top: 0; width: 100%; border-radius: 0; }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 800;
            font-size: 1.6rem;
            color: var(--text-dark);
            text-decoration: none;
            letter-spacing: -1.5px;
        }

        .logo-symbol {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, var(--primary-coral), #FF8E53);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: 0 8px 20px rgba(255,107,107,0.3);
        }

        .header-btns { display: flex; gap: 16px; align-items: center; }

        .btn-lp {
            padding: 14px 32px;
            border-radius: 16px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .btn-outline-lp { color: var(--text-dark); border: 2px solid #E2E8F0; }
        .btn-outline-lp:hover { background: #fff; border-color: var(--text-dark); transform: scale(1.02); }

        .btn-primary-lp { 
            background: var(--text-dark); 
            color: white; 
            box-shadow: 0 10px 30px rgba(30, 41, 59, 0.2);
        }
        .btn-primary-lp:hover { background: #000; transform: scale(1.05) translateY(-2px); box-shadow: 0 15px 40px rgba(30, 41, 59, 0.4); }

        /* --- Hero: Soft Mesh Gradient --- */
        .hero {
            padding: 220px 6% 120px 6%;
            background: radial-gradient(at 100% 0%, rgba(255, 107, 107, 0.08) 0, transparent 50%),
                        radial-gradient(at 0% 100%, rgba(78, 205, 196, 0.08) 0, transparent 50%),
                        white;
            display: flex;
            align-items: center;
            min-height: 90vh;
            position: relative;
        }

        .hero-left { max-width: 680px; position: relative; z-index: 10; }

        .hero-badge {
            background: white;
            padding: 10px 24px;
            border-radius: 100px;
            font-weight: 800;
            font-size: 0.8rem;
            color: var(--primary-coral);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            margin-bottom: 32px;
            border: 1px solid rgba(0,0,0,0.02);
        }

        .hero h1 {
            font-size: clamp(4rem, 7vw, 5.8rem);
            font-weight: 800;
            line-height: 0.95;
            letter-spacing: -4px;
            margin-bottom: 32px;
            font-family: 'Outfit', sans-serif;
            color: var(--text-dark);
        }

        .hero h1 span {
            background: linear-gradient(to right, var(--primary-coral), #FF8E53);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero p {
            font-size: 1.4rem;
            color: var(--text-slate);
            margin-bottom: 48px;
            max-width: 550px;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .hero-right { position: absolute; right: 0; width: 45%; height: 100%; display: flex; align-items: center; justify-content: flex-end; }
        .hero-floating-img { width: 120%; transform: perspective(1000px) rotateY(-15deg) rotateX(5deg); border-radius: 40px; box-shadow: -50px 50px 150px rgba(0,0,0,0.1); }

        /* --- Global Stats Strip --- */
        .stats-section {
            padding: 80px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-box { display: flex; flex-direction: column; align-items: flex-start; }
        .stat-box h2 { font-size: 3.5rem; letter-spacing: -2px; font-weight: 800; line-height: 1; margin-bottom: 8px; }
        .stat-box p { color: var(--text-muted); font-weight: 700; font-size: 0.85rem; letter-spacing: 1px; }

        /* --- Interactive Feature Tiles --- */
        .features-grid {
            padding: 60px 6% 120px 6%;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
        }

        .feature-tile {
            padding: 50px;
            background: #fff;
            border-radius: 40px;
            border: 1px solid rgba(0,0,0,0.03);
            transition: all 0.5s ease;
            position: relative;
            cursor: pointer;
        }

        .feature-tile:hover {
            transform: translateY(-15px);
            background: #fff;
            box-shadow: 0 40px 100px rgba(0,0,0,0.06);
            border-color: rgba(255,107,107,0.1);
        }

        .tile-icon {
            width: 72px;
            height: 72px;
            background: var(--bg-subtle);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-coral);
            margin-bottom: 32px;
            transition: all 0.3s ease;
        }

        .feature-tile:hover .tile-icon { background: var(--primary-coral); color: white; transform: rotate(-10deg) scale(1.1); }

        .feature-tile h3 { font-size: 1.8rem; letter-spacing: -1px; margin-bottom: 16px; font-weight: 700; }
        .feature-tile p { color: var(--text-slate); font-size: 1rem; line-height: 1.6; }

        /* --- Wide Battle Segment --- */
        .battle-segment {
            margin: 0 6% 120px 6%;
            padding: 100px 80px;
            background: var(--text-dark);
            border-radius: 50px;
            display: flex;
            align-items: center;
            gap: 80px;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .battle-segment::before {
            content: '';
            position: absolute;
            top: -20%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: var(--primary-coral);
            filter: blur(200px);
            opacity: 0.15;
        }

        .battle-left { flex: 1.2; }
        .battle-right { flex: 0.8; }

        .battle-badge { background: rgba(255,107,107,0.2); color: var(--primary-coral); padding: 8px 16px; border-radius: 8px; font-weight: 800; font-size: 0.75rem; display: inline-block; margin-bottom: 24px; }

        .battle-segment h2 { font-size: 3.5rem; font-weight: 800; letter-spacing: -2px; margin-bottom: 24px; line-height: 1.1; }

        /* --- Footer: Dark Corporate --- */
        .footer {
            padding: 120px 6% 60px 6%;
            background: #fff;
            border-top: 1px solid rgba(0,0,0,0.05);
        }

        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 60px; margin-bottom: 80px; }
        .footer-heading { font-weight: 800; margin-bottom: 24px; color: var(--text-dark); text-transform: uppercase; font-size: 0.85rem; letter-spacing: 1px; }
        .footer-link { display: block; margin-bottom: 12px; color: var(--text-slate); text-decoration: none; font-weight: 600; font-size: 0.95rem; transition: all 0.2s; }
        .footer-link:hover { color: var(--primary-coral); padding-left: 5px; }

        /* --- Organizer Suite: Dashboard Previews --- */
        .organizer-section {
            padding: 120px 6%;
            background: linear-gradient(180deg, #FFFFFF 0%, #F1F5F9 100%);
            display: grid;
            grid-template-columns: 1.3fr 0.7fr;
            gap: 80px;
            align-items: center;
        }

        .org-features-list {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .org-feature-item {
            background: white;
            padding: 24px;
            border-radius: 20px;
            border: 1px solid rgba(0,0,0,0.03);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .org-feature-item:hover {
            transform: translateX(10px);
            border-color: var(--primary-teal);
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }

        .org-icon {
            width: 48px;
            height: 48px;
            background: #F8FAFC;
            color: var(--primary-teal);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .org-feature-item h4 { font-weight: 700; font-size: 1rem; color: var(--text-dark); margin:0 }

        .org-login-card {
            background: var(--text-dark);
            border-radius: 32px;
            padding: 48px;
            color: white;
            position: relative;
            overflow: hidden;
            box-shadow: 0 40px 100px rgba(0,0,0,0.2);
        }

        .org-login-card h3 { font-size: 2rem; margin-bottom: 24px; font-weight: 800; }
        .org-login-card input {
            width: 100%;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            padding: 16px 20px;
            border-radius: 12px;
            color: white;
            margin-bottom: 16px;
            outline: none;
        }
        .org-login-card input:focus { border-color: var(--primary-coral); }
        .org-login-card .btn-org {
            width: 100%;
            background: var(--primary-coral);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }
        .org-login-card .btn-org:hover { background: #ff5252; transform: translateY(-2px); }

    </style>
</head>
<body>

    <header class="header" id="navbar">
        <a href="#" class="logo">
            <div class="logo-symbol"><i class="ph-bold ph-rocket-launch"></i></div>
            <span>CodeForce</span>
        </a>
        <div class="header-btns">
            <a href="${pageContext.request.contextPath}/tester/quick-access" class="btn-lp btn-outline-lp" style="border-color: var(--primary-teal); color: var(--primary-teal);">Tester Area</a>
            <a href="${pageContext.request.contextPath}/login" class="btn-lp btn-outline-lp">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-lp btn-primary-lp">Get Professional <i class="ph ph-arrow-right"></i></a>
        </div>
    </header>

    <section class="hero">
        <div class="hero-left">
            <div class="hero-badge">
                <i class="ph-fill ph-sketch-logo"></i> NEXT GENERATION ENGINE
            </div>
            <h1>Compete at the <br> <span>Scale of Talent.</span></h1>
            <p>Master complex algorithms, engage in high-speed 1v1 duels, and track your global rank on a platform built for professionals.</p>
            <div style="display:flex; gap: 20px;">
                <a href="${pageContext.request.contextPath}/register" class="btn-lp btn-primary-lp" style="padding: 18px 48px; font-size: 1.1rem;">Build Your Profile</a>
                <a href="${pageContext.request.contextPath}/problemset" class="btn-lp btn-outline-lp" style="padding: 18px 40px; font-size: 1.1rem; background:#fff">View Problem Set</a>
            </div>
        </div>
        <div class="hero-right">
            <img src="${pageContext.request.contextPath}/resources/images/landing_hero_light.png" class="hero-floating-img" alt="Professional UI">
        </div>
    </section>

    <section class="stats-section">
        <div class="stat-box">
            <h2>500+</h2>
            <p>CURATED PROBLEMS</p>
        </div>
        <div class="stat-box">
            <h2>12K+</h2>
            <p>ACTIVE ARCHITECTS</p>
        </div>
        <div class="stat-box">
            <h2 style="color:var(--primary-teal)">0.5s</h2>
            <p>LATENCY BENCHMARK</p>
        </div>
        <div class="stat-box">
            <h2>150+</h2>
            <p>GLOBAL REGIONS</p>
        </div>
    </section>

    <div class="battle-segment">
        <div class="battle-left">
            <div class="battle-badge">EXCLUSIVE FEATURE</div>
            <h2>1v1 Instant Duel <br> <span style="color:var(--primary-coral)">The Arena Unleashed.</span></h2>
            <p style="font-size: 1.25rem; opacity: 0.8; margin-bottom: 40px;">Experience head-to-head tactical warfare. Challenge top-rated developers in real-time speed coding battles powered by our proprietary matchmaking engine.</p>
            <a href="${pageContext.request.contextPath}/register" class="btn-lp btn-primary-lp" style="background:var(--primary-coral); display:inline-flex;">Launch Battle Now</a>
        </div>
        <div class="battle-right">
            <img src="${pageContext.request.contextPath}/resources/images/coding_battle_light.png" style="width:100%; border-radius:30px;" alt="Battle Arena">
        </div>
    </div>

    <!-- Organizer Suite: Power Section -->
    <section class="organizer-section">
        <div>
            <div class="hero-badge" style="color:var(--primary-teal); background:rgba(78,205,196,0.1)">
                <i class="ph-fill ph-crown-simple"></i> CONTEST MASTER SUITE
            </div>
            <h2 style="font-size: 3.5rem; font-weight: 800; letter-spacing: -2px; margin-bottom: 48px; line-height: 1.1;">
                Scale Your Competitive <br> <span style="color:var(--primary-teal)">Spirit Without Limits.</span>
            </h2>

            <div class="org-features-list">
                <a href="${pageContext.request.contextPath}/organizer/contests" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-calendar-plus"></i></div>
                    <h4>Contest Scheduler</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/problems" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-brackets-curly"></i></div>
                    <h4>Problem Master</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-fingerprint"></i></div>
                    <h4>Tester Workflow</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-git-merge"></i></div>
                    <h4>Status Control</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-users-three"></i></div>
                    <h4>Participant Mod</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-chart-line-up"></i></div>
                    <h4>Real-time Sentinel</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-snow-flake"></i></div>
                    <h4>Rankings Freeze</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-shield-check"></i></div>
                    <h4>Anti-Cheat Monitor</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-megaphone"></i></div>
                    <h4>Relay Hub</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-chats-circle"></i></div>
                    <h4>Query Resolver</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-activity"></i></div>
                    <h4>Deep Analytics</h4>
                </a>
                <a href="${pageContext.request.contextPath}/organizer/dashboard" class="org-feature-item">
                    <div class="org-icon"><i class="ph-bold ph-file-arrow-down"></i></div>
                    <h4>Data Vault Export</h4>
                </a>
            </div>
        </div>

        <div class="org-login-card">
            <h3>Organizer Login</h3>
            <p style="opacity: 0.6; margin-bottom: 32px; font-size: 0.9rem;">Access your private dashboards, manage ongoing rounds, and review submissions.</p>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" name="handle" placeholder="Organizer Handle" required>
                <input type="password" name="password" placeholder="Passkey" required>
                <button type="submit" class="btn-org">Launch Organizer Dash</button>
            </form>
            <div style="margin-top: 24px; text-align: center; font-size: 0.8rem; opacity: 0.5;">
                <i class="ph-bold ph-lock-key"></i> Restricted Corporate Access
            </div>
        </div>
    </section>

    <section class="features-grid">
        <div class="feature-tile">
            <div class="tile-icon"><i class="ph-bold ph-lightning"></i></div>
            <h3>Atomic Speed</h3>
            <p>Our infrastructure is optimized for micro-latency. Get instant test results and judge feedback faster than any platform.</p>
        </div>
        <div class="feature-tile" style="background: #F8FAFC;">
            <div class="tile-icon" style="background:#fff;"><i class="ph-bold ph-globe"></i></div>
            <h3>Global Network</h3>
            <p>Join a world-class community of problem solvers. Engage in discussions and learn from elite grandmasters.</p>
        </div>
        <div class="feature-tile">
            <div class="tile-icon"><i class="ph-bold ph-trend-up"></i></div>
            <h3>Career Analytics</h3>
            <p>Visualize your technical growth with industry-standard heatmaps and precision rating analysis.</p>
        </div>
    </section>

    <div style="padding: 100px 6%; display: flex; align-items: center; gap: 80px; background: #fff;">
        <div style="flex:1;">
            <img src="${pageContext.request.contextPath}/resources/images/global_coding_network_light.png" style="width:100%;" alt="Network">
        </div>
        <div style="flex:1;">
            <div class="badge">🌐 GLOBAL ECOSYSTEM</div>
            <h2 style="font-size: 3.5rem; font-weight:800; letter-spacing:-2px; margin-bottom:32px;">Every Continent. <br> Every Technology.</h2>
            <p style="font-size: 1.2rem; color: var(--text-slate); margin-bottom: 40px;">Our network connects the brightest minds from 150+ countries. Whether you are in New York, Mumbai, or Seoul, the battle for the top spot is real.</p>
            <div style="display:flex; gap:32px;">
                <div>
                    <h3 style="font-size: 2rem; color:var(--text-dark); margin:0">30+</h3>
                    <p style="font-size:0.8rem; font-weight:700; color:var(--text-muted);">DAILY ROUNDS</p>
                </div>
                <div>
                    <h3 style="font-size: 2rem; color:var(--text-dark); margin:0">1M+</h3>
                    <p style="font-size:0.8rem; font-weight:700; color:var(--text-muted);">CODE SUBMISSIONS</p>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-grid">
            <div>
                <a href="#" class="logo" style="margin-bottom: 32px;">
                    <div class="logo-symbol" style="background:var(--text-dark)"><i class="ph-bold ph-rocket-launch"></i></div>
                    <span>CodeForce</span>
                </a>
                <p style="color:var(--text-slate); font-size: 0.95rem; max-width: 300px;">Developing the future of competitive programming through high-performance engineering.</p>
            </div>
            <div>
                <div class="footer-heading">Platform</div>
                <a href="#" class="footer-link">Problem Set</a>
                <a href="#" class="footer-link">Live Contests</a>
                <a href="#" class="footer-link">1v1 Battle</a>
                <a href="#" class="footer-link">Global Rating</a>
            </div>
            <div>
                <div class="footer-heading">Community</div>
                <a href="#" class="footer-link">Blog Posts</a>
                <a href="#" class="footer-link">Discussion</a>
                <a href="#" class="footer-link">Hall of Fame</a>
            </div>
            <div>
                <div class="footer-heading">Company</div>
                <a href="#" class="footer-link">About Us</a>
                <a href="#" class="footer-link">Privacy Policy</a>
                <a href="#" class="footer-link">Contact Support</a>
            </div>
        </div>
        <div style="display:flex; justify-content: space-between; align-items: center; padding-top: 40px; border-top: 1px solid rgba(0,0,0,0.05);">
            <p style="color:var(--text-muted); font-size: 0.85rem;">&copy; 2026 CodeForce Pro. All rights Reserved.</p>
            <div style="display:flex; gap: 24px; font-size: 1.25rem; color: var(--text-slate);">
                <i class="ph ph-twitter-logo"></i>
                <i class="ph ph-github-logo"></i>
                <i class="ph ph-linkedin-logo"></i>
            </div>
        </div>
    </footer>

    <script>
        window.onscroll = function() {
            var navbar = document.getElementById("navbar");
            if (window.pageYOffset > 50) {
                navbar.classList.add("scrolled");
            } else {
                navbar.classList.remove("scrolled");
            }
        };
    </script>
</body>
</html>
