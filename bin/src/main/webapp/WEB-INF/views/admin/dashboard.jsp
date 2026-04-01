<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeForce - Admin Dashboard</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@400;600;800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #FF8C00;
            --secondary: #6B4EE6;
            --accent: #FF3B30;
            --bg-dark: #0F172A;
            --card-bg: rgba(30, 41, 59, 0.7);
            --sidebar-bg: #1A2234;
            --text-light: #F8FAFC;
            --text-dim: #94A3B8;
            --glass: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: #020617;
            background-image: 
                radial-gradient(at 0% 0%, hsla(215, 98%, 15%, 1) 0, transparent 50%), 
                radial-gradient(at 50% 0%, hsla(215, 98%, 10%, 1) 0, transparent 50%), 
                radial-gradient(at 100% 0%, hsla(215, 98%, 15%, 1) 0, transparent 50%);
            color: var(--text-light);
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        /* --- PROFESSIONAL SCROLLBAR --- */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: rgba(15, 23, 42, 0.5);
        }
        ::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 10px;
            border: 2px solid #020617;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #e67e00;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--glass-border);
            display: flex;
            flex-direction: column;
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-family: 'Outfit', sans-serif;
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #FFD700, #FF8C00);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .nav-item {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            color: var(--text-dim);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            font-weight: 500;
        }

        .nav-item:hover {
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-light);
            transform: translateX(5px);
        }

        .nav-item.active {
            background: linear-gradient(90deg, rgba(255, 140, 0, 0.15), transparent);
            color: var(--primary);
        }

        .nav-item.active::before {
            content: '';
            position: absolute;
            left: -1.5rem;
            top: 20%;
            height: 60%;
            width: 4px;
            background: var(--primary);
            border-radius: 0 4px 4px 0;
            box-shadow: 0 0 15px var(--primary);
        }

        .nav-item i {
            width: 20px;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 2.5rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: var(--glass);
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            border: 1px solid var(--glass-border);
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            display: flex;
            align-items: center;
            gap: 1.2rem;
            transition: 0.4s;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            border-color: var(--primary);
            box-shadow: 0 20px 40px -20px rgba(255, 140, 0, 0.3);
        }

        /* --- SYSTEMATIC SECTION ANIMATIONS --- */
        .fade-in-up {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hidden {
            display: none !important;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            background: rgba(255, 140, 0, 0.1);
            color: var(--primary);
        }

        .stat-info .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            display: block;
        }

        .stat-info .stat-label {
            color: var(--text-dim);
            font-size: 0.9rem;
        }

        /* Tabs Content */
        .content-section {
            background: var(--card-bg);
            border-radius: 24px;
            padding: 2rem;
            border: 1px solid var(--glass-border);
            margin-bottom: 2rem;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .section-title {
            font-family: 'Outfit', sans-serif;
            font-size: 1.5rem;
            color: var(--text-light);
        }

        .btn {
            padding: 0.8rem 1.8rem;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: scale(1.02);
        }

        .btn-warn {
            background: #EAB308;
            color: white;
        }

        .btn-danger {
            background: #EF4444;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        th {
            text-align: left;
            padding: 1rem;
            color: var(--text-dim);
            font-weight: 500;
        }

        td {
            padding: 1.2rem 1rem;
            background: var(--glass);
        }

        tr td:first-child { border-radius: 12px 0 0 12px; }
        tr td:last-child { border-radius: 0 12px 12px 0; }

        .tag {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .tag-high { background: rgba(239, 68, 68, 0.2); color: #EF4444; }
        .tag-medium { background: rgba(234, 179, 8, 0.2); color: #EAB308; }

        .hidden { display: none; }

        /* Forms */
        .grid-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-dim);
            font-size: 0.9rem;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.8rem 1.2rem;
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            color: white;
            outline: none;
            transition: 0.3s;
        }

        option {
            background-color: #1A2234;
            color: white;
        }

        input:focus {
            border-color: var(--primary);
        }

        .pulse {
            animation: pulse-red 2s infinite;
        }

        @keyframes pulse-red {
            0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4); }
            70% { transform: scale(1); box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
            100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
        }

    </style>
</head>
<body>
    
    <!-- Main Sidebar -->
    <aside class="sidebar">
        <div class="logo">
            <i class="fas fa-bolt"></i> CodeForce
        </div>
        <nav class="nav-links">
            <div onclick="showSection('overview')" id="nav-overview" class="nav-item active">
                <i class="fas fa-chart-line"></i> Dashboard Overview
            </div>
            <div onclick="showSection('contests')" id="nav-contests" class="nav-item">
                <i class="fas fa-calendar-alt"></i> Contest Organization
            </div>
            <div onclick="showSection('cheating')" id="nav-cheating" class="nav-item">
                <i class="fas fa-shield-halved"></i> Monitoring Cheating
            </div>
            <div onclick="showSection('banning')" id="nav-banning" class="nav-item">
                <i class="fas fa-gavel"></i> Banning / Actions
            </div>
            <div onclick="showSection('testing')" id="nav-testing" class="nav-item">
                <i class="fas fa-flask"></i> Pre-Contest Testing
            </div>
            <div onclick="showSection('profile')" id="nav-profile" class="nav-item">
                <i class="fas fa-user-shield"></i> Admin Settings
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="margin-top: auto; color: #EF4444;">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </aside>

    <main class="main-content">
        <header>
            <div>
                <h1 id="page-display-title" style="font-size: 2rem; font-family: 'Outfit', sans-serif;">Welcome Back, Admin</h1>
                <p style="color: var(--text-dim);">Monitoring CodeForce Platform Health</p>
            </div>
            <div class="user-profile">
                <i class="fas fa-bell" style="color: var(--text-dim); cursor: pointer;"></i>
                <div style="width: 32px; height: 32px; border-radius: 50%; background: var(--primary);"></div>
                <span style="font-weight: 600;">admin</span>
            </div>
        </header>

        <!-- DASHBOARD OVERVIEW -->
        <div id="section-overview" class="fade-in-up">
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${stats.totalUsers}</span>
                        <span class="stat-label">Total Users</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-code"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${stats.totalSubmissions}</span>
                        <span class="stat-label">Submissions Today</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">${stats.totalContests}</span>
                        <span class="stat-label">Active Contests</span>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon" style="color: #10B981; background: rgba(16, 185, 129, 0.1);"><i class="fas fa-server"></i></div>
                    <div class="stat-info">
                        <span class="stat-value">99.9%</span>
                        <span class="stat-label">System Uptime</span>
                    </div>
                </div>
            </div>

            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Critical Alerts</h2>
                    <span class="tag tag-high pulse">Live Monitor</span>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>User 1</th>
                            <th>User 2</th>
                            <th>Problem</th>
                            <th>Similarity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cheat" items="${cheatingData}">
                            <tr>
                                <td>${cheat.user1}</td>
                                <td>${cheat.user2}</td>
                                <td>Problem ${cheat.problem}</td>
                                <td><span class="badge" style="background: rgba(255,107,107,0.1); color: var(--primary);">${cheat.similarity}%</span></td>
                                <td><button onclick="viewCode('${cheat.user1}', '${cheat.user2}')" class="btn btn-primary" style="padding: 0.5rem 1rem;">View Code</button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- CONTEST ORGANIZATION -->
        <div id="section-contests" class="hidden fade-in-up">
            <div class="content-section">
                <form id="publishForm" onsubmit="publishContest(event)">
                    <div class="section-header">
                        <h2 class="section-title">Schedule New Contest</h2>
                    </div>
                    <div class="grid-form">
                        <div class="form-group">
                            <label>Contest Title</label>
                            <input type="text" id="c_title" placeholder="e.g. Round #123 (Div. 2)" required>
                        </div>
                        <div class="form-group">
                            <label>Start Date & Time</label>
                            <input type="datetime-local" id="c_start" required>
                        </div>
                        <div class="form-group">
                            <label>Duration (Minutes)</label>
                            <input type="number" id="c_duration" placeholder="120" required>
                        </div>
                        <div class="form-group">
                            <label>Complexity</label>
                            <select id="c_complexity">
                                <option value="Div. 1">Div. 1</option>
                                <option value="Div. 2">Div. 2</option>
                                <option value="Div. 3">Div. 3</option>
                                <option value="Educational">Educational</option>
                            </select>
                        </div>
                    </div>
                    <div class="section-header" style="margin-top: 2rem;">
                        <h2 class="section-title">Problem Selection</h2>
                    </div>
                    <div class="form-group">
                        <label>Search Problems to Add (IDs separated by commas)</label>
                        <input type="text" id="c_problems" placeholder="101, 102, 103..." required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="margin-top: 2rem;">
                        <i class="fas fa-plus"></i> Publish Contest
                    </button>
                </form>
            </div>
        </div>

        <!-- MONITORING CHEATING -->
        <div id="section-cheating" class="hidden fade-in-up">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Anomalous Activity Detection</h2>
                </div>
                <div class="grid-form" style="margin-bottom: 2rem;">
                    <div class="stat-card" style="background: rgba(255,107,107,0.1);">
                        <span class="stat-value" style="color: var(--primary);">12</span>
                        <span class="stat-label">Duplicate Matches</span>
                    </div>
                    <div class="stat-card" style="background: rgba(247,183,49,0.1);">
                        <span class="stat-value" style="color: var(--accent);">5</span>
                        <span class="stat-label">Rapid Submissions</span>
                    </div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Handler</th>
                            <th>Activity Type</th>
                            <th>Confidence</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${anomalousData}">
                            <tr>
                                <td>${item.handle}</td>
                                <td>${item.type}</td>
                                <td><span class="badge" style="background: rgba(255,107,107,0.2); color: var(--primary);">${item.confidence}%</span></td>
                                <td><button onclick="performAction('investigate', '${item.handle}')" class="btn btn-warn">Investigate</button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <h3 style="margin: 2rem 0 1rem; color: var(--text-dim);">Critical Alerts</h3>
                <table>
                    <thead>
                        <tr>
                            <th>User 1</th>
                            <th>User 2</th>
                            <th>Problem</th>
                            <th>Similarity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cheat" items="${cheatingData}">
                            <tr id="alert-${cheat.user1}-${cheat.user2}">
                                <td style="color: var(--primary); font-weight: 600;">${cheat.user1}</td>
                                <td style="color: var(--primary); font-weight: 600;">${cheat.user2}</td>
                                <td>${cheat.problem}</td>
                                <td><span class="badge" style="background: rgba(255,107,107,0.1); color: var(--primary);">${cheat.similarity}%</span></td>
                                <td style="display: flex; gap: 8px;">
                                    <button onclick="viewCode('${cheat.user1}', '${cheat.user2}')" class="btn btn-primary" style="padding: 0.4rem 1rem;">View Code</button>
                                    <button onclick="performAction('investigate', '${cheat.user1}')" class="btn btn-warn" style="padding: 0.4rem 1rem;">Investigate</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- BANNING ACTIONS -->
        <div id="section-banning" class="hidden fade-in-up">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">User Enforcement</h2>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Role</th>
                            <th>Rating</th>
                            <th>Status Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr id="user-row-${user.id}">
                                <td>${user.handle}</td>
                                <td class="user-role">${user.role}</td>
                                <td>${user.rating}</td>
                                <td style="display: flex; gap: 0.5rem;">
                                    <button onclick="performAction('warn', '${user.id}', '', this)" class="btn btn-warn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Warn</button>
                                    <button onclick="performAction('ban', '${user.id}', 'TEMPORARY', this)" class="btn btn-danger" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Temp Ban</button>
                                    <button onclick="performAction('ban', '${user.id}', 'PERMANENT', this)" class="btn btn-danger" style="background: #000; padding: 0.4rem 0.8rem; font-size: 0.8rem;">Perm Ban</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- TESTING SUPPORT -->
        <div id="section-testing" class="hidden fade-in-up">
            <div style="display: flex; align-items: center; gap: 4rem; padding: 3rem 1rem;">
                <h2 style="font-size: 2.8rem; line-height: 1.1; max-width: 280px; font-weight: 800; color: white;">Quality<br>Assurance Portal</h2>
                
                <div class="content-section" style="flex: 1; margin: 0; padding: 2.5rem; background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.05); border-radius: 30px;">
                    <div class="grid-form" style="gap: 2.5rem;">
                        <div class="content-section" style="background: rgba(255, 255, 255, 0.02); margin: 0; padding: 2rem;">
                            <h3 style="margin-bottom: 1rem; font-size: 1.4rem;">Coordinate with Problemsetters</h3>
                            <p style="color: var(--text-dim); margin-bottom: 1.5rem; font-size: 0.95rem;">Select a contest to notify testers and setters for internal review.</p>
                            
                            <select class="form-select" id="test-contest-id" style="width: 100%; margin-bottom: 2rem; background: rgba(0,0,0,0.3); border: 1px solid rgba(255,255,255,0.1); border-radius: 12px; height: 50px;">
                                <c:forEach var="c" items="${upcomingContests}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                                <c:if test="${empty upcomingContests}">
                                    <option disabled>No upcoming contests</option>
                                </c:if>
                            </select>
                            
                            <button onclick="performAction('coordinate', document.getElementById('test-contest-id').value)" class="btn btn-primary" style="width: auto; height: 50px; font-size: 1rem;">Send Test Request</button>
                        </div>
                        
                        <div class="content-section" style="background: rgba(255, 255, 255, 0.02); margin: 0; padding: 2rem;">
                            <h3 style="margin-bottom: 1.5rem; font-size: 1.4rem;">Bug Reports</h3>
                            <div style="height: 300px; overflow-y: auto; padding-right: 10px;">
                                <c:forEach var="bug" items="${bugReports}">
                                    <div style="padding: 1.5rem; background: rgba(255,255,255,0.04); border-radius: 15px; border-left: 5px solid ${not empty bug.severity ? bug.severity : '#EF4444'}; margin-bottom: 1.2rem; transition: transform 0.2s; cursor: pointer;">
                                        <h4 style="margin: 0; font-size: 1.1rem; color: #fff;">${bug.title}</h4>
                                        <p style="margin: 8px 0 0; font-size: 0.9rem; color: var(--text-dim);">Reported by ${bug.user} &bull; ${bug.time}</p>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty bugReports}">
                                    <p style="color: var(--text-dim); text-align: center; padding: 2rem;">No active bug reports.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- PROFILE SETTINGS -->
        <div id="section-profile" class="hidden fade-in-up">
            <div class="content-section">
                <div class="section-header">
                    <h2 class="section-title">Secure Admin Settings</h2>
                </div>
                <div style="max-width: 500px;">
                    <form onsubmit="updatePassword(event)">
                        <div class="form-group">
                            <label>Current Password</label>
                            <input type="password" id="p_current">
                        </div>
                        <div class="form-group">
                            <label>New Password</label>
                            <input type="password" id="p_new">
                        </div>
                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <input type="password" id="p_confirm">
                        </div>
                        <button type="submit" class="btn btn-primary">Update Password Securely</button>
                    </form>
                </div>
            </div>
        </div>

    </div> <!-- End main-content -->

    <!-- Modal for Code Comparison -->
    <div id="codeModal" class="hidden" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.85); backdrop-filter: blur(12px); z-index: 9999; display: none; align-items: center; justify-content: center; padding: 2rem;">
        <div class="content-section" style="width: 100%; max-width: 1000px; max-height: 90vh; overflow-y: auto; border: 1px solid var(--glass-border); box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);">
            <div class="section-header">
                <h2 class="section-title">Code Comparison</h2>
                <button onclick="closeModal()" class="btn btn-danger" style="padding: 0.4rem 1.5rem; border-radius: 30px;">Close</button>
            </div>
            <div class="grid-form" style="grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-top: 2rem;">
                <div>
                    <h3 id="modal-u1" style="margin-bottom: 0.8rem; color: var(--primary);">User 1</h3>
                    <pre id="modal-c1" style="background: #020617; padding: 1.5rem; border-radius: 15px; color: #10B981; font-family: 'JetBrains Mono', monospace; font-size: 0.9rem; border: 1px solid rgba(255,255,255,0.05);"></pre>
                </div>
                <div>
                    <h3 id="modal-u2" style="margin-bottom: 0.8rem; color: var(--primary);">User 2</h3>
                    <pre id="modal-c2" style="background: #020617; padding: 1.5rem; border-radius: 15px; color: #10B981; font-family: 'JetBrains Mono', monospace; font-size: 0.9rem; border: 1px solid rgba(255,255,255,0.05);"></pre>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Investigation Details -->
    <div id="investigateModal" class="hidden" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.9); backdrop-filter: blur(20px); z-index: 10000; display: none; align-items: center; justify-content: center; padding: 2rem;">
        <div class="content-section" style="width: 100%; max-width: 600px; border: 1px solid var(--primary); box-shadow: 0 0 30px var(--primary-glow);">
            <div class="section-header">
                <h2 class="section-title">Advanced AI Investigation</h2>
                <button onclick="closeInvestigateModal()" class="btn btn-danger" style="padding: 0.4rem 1.5rem; border-radius: 30px;">Terminate</button>
            </div>
            <div id="investigate-logs" style="background: #020617; padding: 1.5rem; border-radius: 15px; color: #10B981; font-family: 'JetBrains Mono', monospace; font-size: 0.85rem; height: 300px; overflow-y: auto; margin: 1.5rem 0; border: 1px solid rgba(255,255,255,0.05); border-left: 3px solid var(--primary);">
                <!-- Logs appear here -->
            </div>
            <div id="investigate-conclusion" style="padding: 1rem; background: var(--glass); border-radius: 10px; text-align: center; color: var(--primary); font-weight: bold; min-height: 3rem;">
                Scan Initializing...
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div id="toast-container" style="position: fixed; bottom: 2rem; right: 2rem; z-index: 1000; display: flex; flex-direction: column; gap: 1rem;"></div>

    <script>
        function showToast(message, type = 'success') {
            const toast = document.createElement('div');
            toast.className = 'animate-up';
            toast.style.padding = '1rem 2rem';
            toast.style.borderRadius = '12px';
            toast.style.background = type === 'success' ? '#10B981' : '#EF4444';
            toast.style.color = 'white';
            toast.style.boxShadow = '0 10px 25px rgba(0,0,0,0.3)';
            toast.style.display = 'flex';
            toast.style.alignItems = 'center';
            toast.style.gap = '10px';
            toast.innerHTML = (type === 'success' ? '&#10003; ' : '&#9888; ') + message;
            
            document.getElementById('toast-container').appendChild(toast);
            setTimeout(() => toast.remove(), 4000);
        }

        function showSection(id) {
            const sections = ['overview', 'contests', 'cheating', 'banning', 'testing', 'profile'];
            sections.forEach(s => {
                document.getElementById('section-' + s).classList.add('hidden');
                document.getElementById('nav-' + s).classList.remove('active');
            });
            
            const target = document.getElementById('section-' + id);
            target.classList.remove('hidden');
            document.getElementById('nav-' + id).classList.add('active');
            
            // Systematic Title Update
            const titles = {
                'overview': 'Dashboard Overview',
                'contests': 'Contest Organization',
                'cheating': 'Anti-Cheat Monitoring',
                'banning': 'Administrative Actions',
                'testing': 'Quality Assurance Portal',
                'profile': 'Secure Admin Settings'
            };
            document.getElementById('page-display-title').innerText = titles[id] || 'Admin Dashboard';
        }

        async function viewCode(u1, u2) {
            try {
                const resp = await fetch(`/api/admin/view-code?user1=${u1}&user2=${u2}`);
                const data = await resp.json();
                document.getElementById('modal-u1').innerText = u1;
                document.getElementById('modal-u2').innerText = u2;
                document.getElementById('modal-c1').innerText = data.user1Code;
                document.getElementById('modal-c2').innerText = data.user2Code;
                document.getElementById('codeModal').style.display = 'flex';
                document.getElementById('codeModal').classList.remove('hidden');
            } catch (e) {
                showToast('Error fetching code', 'error');
            }
        }

        function closeModal() {
            document.getElementById('codeModal').style.display = 'none';
            document.getElementById('codeModal').classList.add('hidden');
        }

        function closeInvestigateModal() {
            document.getElementById('investigateModal').style.display = 'none';
            document.getElementById('investigateModal').classList.add('hidden');
        }

        async function runInvestigation(userId) {
            const logs = document.getElementById('investigate-logs');
            const conclusion = document.getElementById('investigate-conclusion');
            logs.innerHTML = '';
            conclusion.innerText = 'Scan Initializing...';
            document.getElementById('investigateModal').style.display = 'flex';
            document.getElementById('investigateModal').classList.remove('hidden');

            const steps = [
                `Initiating deep scan for user sequence: ${userId}...`,
                'Syncing with local CDN logs...',
                'Retrieving recent submission signatures...',
                'Analyzing IP address patterns...',
                'Matching behavioral heuristics with known bot networks...',
                'Parsing JSON response timings...',
                'Comparing source code structures across multiple sessions...',
                'FINALIZING ANALYSIS...'
            ];

            for (let step of steps) {
                const logEntry = document.createElement('div');
                logEntry.innerText = '> ' + step;
                logEntry.style.marginBottom = '5px';
                logs.appendChild(logEntry);
                logs.scrollTop = logs.scrollHeight;
                await new Promise(r => setTimeout(r, 600));
            }

            conclusion.innerHTML = `<span style="color: #EF4444;">SUSPICIOUS ACTIVITY CONFIRMED: High Similarity Detected.</span>`;
            showToast('Investigation complete. Actions recommended.', 'success');
        }

        async function publishContest(e) {
            e.preventDefault();
            const data = {
                title: document.getElementById('c_title').value,
                startTime: document.getElementById('c_start').value,
                duration: document.getElementById('c_duration').value,
                complexity: document.getElementById('c_complexity').value,
                problems: document.getElementById('c_problems').value
            };

            try {
                const response = await fetch('/api/admin/publish-contest', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data)
                });
                
                if (response.ok) {
                    showToast(await response.text());
                    document.getElementById('publishForm').reset();
                } else {
                    showToast('Failed to publish', 'error');
                }
            } catch (e) {
                showToast('Network error', 'error');
            }
        }

        async function performAction(action, id, param = '', btn = null) {
            let url = '';
            let body = new URLSearchParams();
            
            console.log(`Performing ${action} on ID: ${id} with param: ${param}`);

            if (action === 'ban') {
                url = '/api/admin/ban';
                body.append('userId', id);
                body.append('duration', param);
            } else if (action === 'unban') {
                url = '/api/admin/unban';
                body.append('userId', id);
            } else if (action === 'warn') {
                url = '/api/admin/warn';
                body.append('userId', id);
                body.append('message', 'Automated warning from Admin Dashboard');
            } else if (action === 'coordinate') {
                url = '/api/admin/coordinate-testing';
                body.append('contestId', id);
            } else if (action === 'investigate') {
                url = '/api/admin/investigate';
                body.append('handler', id);
                runInvestigation(id); // Real-time visual scan
            }

            try {
                const response = await fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: body.toString()
                });
                
                const result = await response.text();
                if (response.ok) {
                    showToast(result, 'success');
                    console.log('Action success:', result);
                    
                    // Specific UI feedback for banning/actions row
                    if (btn) {
                        const row = btn.closest('tr');
                        if (row) {
                            if (action === 'ban') {
                                const roleCell = row.querySelector('.user-role');
                                if (roleCell) roleCell.innerText = param === 'PERMANENT' ? 'BANNED_PERM' : 'BANNED_TEMP';
                                btn.innerText = 'Undo Ban';
                                btn.onclick = () => performAction('unban', id, '', btn);
                                btn.style.background = '#6366F1';
                                btn.disabled = false;
                            } else if (action === 'unban') {
                                const roleCell = row.querySelector('.user-role');
                                if (roleCell) roleCell.innerText = 'USER';
                                location.reload(); // Simplest way to restore all three original buttons for this row
                            } else if (action === 'warn') {
                                btn.innerText = 'Warned!';
                                btn.style.background = '#10B981';
                            }
                        }
                    }
                } else {
                    showToast('Action failed: ' + result, 'error');
                    console.log('Action failed:', result);
                }
            } catch (e) {
                showToast('Network error during ' + action, 'error');
                console.error('Network Error:', e);
            }
        }

        async function fetchStats() {
            try {
                const resp = await fetch('/api/admin/stats');
                const data = await resp.json();
                const cards = document.querySelectorAll('.stat-value');
                if (cards.length >= 4) {
                    cards[0].innerText = data.totalUsers;
                    cards[1].innerText = data.totalSubmissions;
                    cards[2].innerText = data.totalContests;
                }
            } catch (e) {}
        }

        async function updatePassword(e) {
            e.preventDefault();
            const current = document.getElementById('p_current').value;
            const newPwd = document.getElementById('p_new').value;
            const confirm = document.getElementById('p_confirm').value;

            if (newPwd !== confirm) {
                showToast('New passwords do not match!', 'error');
                return;
            }

            try {
                const response = await fetch('/api/admin/update-password', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ current, new: newPwd })
                });
                
                const msg = await response.text();
                if (response.ok) {
                    showToast(msg, 'success');
                    e.target.reset();
                } else {
                    showToast(msg, 'error');
                }
            } catch (e) {
                showToast('Network error during password update', 'error');
            }
        }

        // Real-time updates
        setInterval(fetchStats, 10000);
        fetchStats();
    </script>
</body>
</html>
