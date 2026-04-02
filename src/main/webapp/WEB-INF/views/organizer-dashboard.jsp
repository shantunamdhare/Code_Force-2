<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organizer Dashboard | CodeForce Pro</title>
    
    <!-- Modern Typography -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Icons -->
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <style>
        :root {
            --primary: #4ECDC4;
            --accent: #FF6B6B;
            --dark: #0F172A;
            --sidebar-w: 280px;
            --glass: rgba(255, 255, 255, 0.03);
            --border: rgba(255, 255, 255, 0.1);
        }

        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: #020617;
            color: #F8FAFC;
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* --- Sidebar Navigation --- */
        .sidebar {
            width: var(--sidebar-w);
            border-right: 1px solid var(--border);
            padding: 40px 24px;
            display: flex;
            flex-direction: column;
            background: #0F172A;
            position: fixed;
            height: 100vh;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.5rem;
            font-weight: 800;
            color: white;
            text-decoration: none;
            margin-bottom: 60px;
            font-family: 'Outfit';
        }

        .nav-group { margin-bottom: 40px; }
        .nav-label { font-size: 0.75rem; text-transform: uppercase; color: #475569; letter-spacing: 1px; font-weight: 800; margin-bottom: 16px; display: block; }
        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            color: #94A3B8;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s;
            margin-bottom: 4px;
        }
        .nav-item:hover, .nav-item.active {
            background: rgba(255,255,255,0.05);
            color: var(--primary);
        }
        .nav-item i { font-size: 1.25rem; }

        /* --- Main Content --- */
        .main {
            margin-left: var(--sidebar-w);
            flex: 1;
            padding: 40px 60px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 60px;
        }

        .welcome h1 { font-family: 'Outfit'; font-size: 2.5rem; letter-spacing: -2px; margin-bottom: 8px; }
        .welcome p { color: #64748B; font-weight: 500; }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 60px;
        }

        .stat-card {
            background: var(--glass);
            border: 1px solid var(--border);
            padding: 32px;
            border-radius: 24px;
            backdrop-filter: blur(10px);
        }
        .stat-card h3 { color: #64748B; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px; }
        .stat-card .val { font-size: 2rem; font-weight: 800; color: white; display: flex; align-items: baseline; gap: 8px; }
        .stat-card .val span { color: var(--primary); font-size: 0.9rem; font-weight: 600; }

        /* --- Dashboard Grid --- */
        .tools-section h2 { font-family: 'Outfit'; font-size: 1.5rem; margin-bottom: 32px; display: flex; align-items: center; gap: 12px; }
        
        .tools-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
        }

        .tool-card {
            background: rgba(15, 23, 42, 0.4);
            border: 1px solid var(--border);
            padding: 32px;
            border-radius: 24px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        .tool-card:hover {
            transform: translateY(-8px);
            background: rgba(255,255,255,0.03);
            border-color: var(--primary);
        }
        .tool-card i { font-size: 2.5rem; color: var(--primary); margin-bottom: 24px; display: block; }
        .tool-card h4 { font-size: 1.25rem; font-weight: 700; margin-bottom: 12px; }
        .tool-card p { color: #64748B; font-size: 0.9rem; line-height: 1.6; }
        
        .tool-card .badge {
            position: absolute;
            top: 24px;
            right: 24px;
            background: rgba(78, 205, 196, 0.1);
            color: var(--primary);
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 800;
        }

    </style>
</head>
<body>

    <nav class="sidebar">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <i class="ph-fill ph-rocket-launch" style="color:var(--accent)"></i>
            CodeForce
        </a>

        <div class="nav-group">
            <span class="nav-label">Main Dashboard</span>
            <a href="${pageContext.request.contextPath}/organizer/dashboard" class="nav-item active">
                <i class="ph ph-squares-four"></i> Overview
            </a>
            <a href="${pageContext.request.contextPath}/organizer/contests" class="nav-item">
                <i class="ph ph-calendar-star"></i> Contests
            </a>
            <a href="${pageContext.request.contextPath}/organizer/problems" class="nav-item">
                <i class="ph ph-brackets-curly"></i> Problems
            </a>
        </div>

        <div class="nav-group">
            <span class="nav-label">Operations</span>
            <a href="#" class="nav-item"><i class="ph ph-users-three"></i> Participants</a>
            <a href="#" class="nav-item"><i class="ph ph-shield-check"></i> Anti-Cheat</a>
            <a href="#" class="nav-item"><i class="ph ph-chats-circle"></i> Clarifications</a>
        </div>

        <div style="margin-top: auto;">
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--accent)">
                <i class="ph ph-sign-out"></i> Logout
            </a>
        </div>
    </nav>

    <main class="main">
        <header class="header">
            <div class="welcome">
                <h1>Organizer Deck</h1>
                <p>Monitor your contests, manage quality, and drive engagement.</p>
            </div>
            <div style="display:flex; gap:16px;">
                 <button style="background:var(--primary); color:var(--dark); border:none; padding:14px 28px; border-radius:12px; font-weight:800; cursor:pointer;" onclick="location.href='${pageContext.request.contextPath}/organizer/contests'">
                    <i class="ph-bold ph-plus"></i> Create Contest
                 </button>
            </div>
        </header>

        <section class="stats-grid">
            <div class="stat-card">
                <h3>Total Contests</h3>
                <div class="val">${totalContests} <span>Rounds</span></div>
            </div>
            <div class="stat-card">
                <h3>Managed Problems</h3>
                <div class="val">${totalProblems} <span>Files</span></div>
            </div>
            <div class="stat-card">
                <h3>Registered Users</h3>
                <div class="val">${totalUsers} <span>Active</span></div>
            </div>
            <div class="stat-card">
                <h3>Live Activity</h3>
                <div class="val">350 <span>Submissions</span></div>
            </div>
        </section>

        <section class="tools-section">
            <h2><i class="ph ph-shapes" style="color:var(--accent)"></i> Operational Suite</h2>
            
            <div class="tools-grid">
                <!-- 1. Create Contest -->
                <div class="tool-card" onclick="location.href='${pageContext.request.contextPath}/organizer/contests'">
                    <i class="ph ph-calendar-plus"></i>
                    <h4>Create & Schedule</h4>
                    <p>Initialize new competitive rounds with precise timing and metadata.</p>
                    <span class="badge">CORE</span>
                </div>
                <!-- 2. Manage Problems -->
                <div class="tool-card" onclick="location.href='${pageContext.request.contextPath}/organizer/problems'">
                    <i class="ph ph-files"></i>
                    <h4>Problem Master</h4>
                    <p>Select, arrange, and deploy problemsets from the global vault.</p>
                    <span class="badge">CORE</span>
                </div>
                <!-- 3. Testers -->
                <div class="tool-card" onclick="location.href='${pageContext.request.contextPath}/admin/dashboard'">
                    <i class="ph ph-fingerprint"></i>
                    <h4>Quality Control</h4>
                    <p>Assign problems to expert testers for validation and feedback.</p>
                </div>
            </div>
        </section>
    </main>

</body>
</html>
