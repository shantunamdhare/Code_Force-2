<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
    <jsp:param name="activePage" value="dashboard" />
</jsp:include>

<style>
    /* ========== Dashboard Specific Styles ========== */
    :root {
        --dash-indigo: #6366F1;
        --dash-purple: #8B5CF6;
        --dash-emerald: #10B981;
        --dash-rose: #F43F5E;
        --dash-amber: #F59E0B;
        --dash-sky: #0EA5E9;
    }

    .dashboard-container {
        display: grid;
        grid-template-columns: 1fr 360px;
        gap: 32px;
        padding: 32px 0 60px;
    }

    /* ---- Greeting Banner ---- */
    .greeting-banner {
        background: linear-gradient(135deg, #667EEA 0%, #764BA2 50%, #F093FB 100%);
        border-radius: 28px;
        padding: 40px 44px;
        color: white;
        margin-bottom: 32px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 20px 60px -15px rgba(102, 126, 234, 0.4);
    }

    .greeting-banner::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 70%);
        border-radius: 50%;
        animation: floatOrb 8s ease-in-out infinite alternate;
    }

    .greeting-banner::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: 10%;
        width: 250px;
        height: 250px;
        background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 70%);
        border-radius: 50%;
        animation: floatOrb 6s ease-in-out infinite alternate-reverse;
    }

    @keyframes floatOrb {
        0% { transform: translate(0, 0) scale(1); }
        100% { transform: translate(30px, -20px) scale(1.1); }
    }

    .greeting-banner h1 {
        font-size: 2rem;
        font-weight: 800;
        margin-bottom: 8px;
        position: relative;
        z-index: 1;
        letter-spacing: -0.5px;
    }

    .greeting-banner p {
        font-size: 1rem;
        opacity: 0.85;
        position: relative;
        z-index: 1;
        max-width: 500px;
        line-height: 1.6;
    }

    .greeting-emoji {
        position: absolute;
        right: 50px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 5rem;
        opacity: 0.25;
        z-index: 0;
    }

    /* ---- Stats Row ---- */
    .stats-header {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 36px;
    }

    .stat-card-modern {
        background: white;
        padding: 28px 24px;
        border-radius: 22px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        border: 1px solid rgba(0, 0, 0, 0.04);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        position: relative;
        overflow: hidden;
    }

    .stat-card-modern::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        border-radius: 22px 22px 0 0;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .stat-card-modern:nth-child(1)::before { background: linear-gradient(90deg, #6366F1, #818CF8); }
    .stat-card-modern:nth-child(2)::before { background: linear-gradient(90deg, #10B981, #34D399); }
    .stat-card-modern:nth-child(3)::before { background: linear-gradient(90deg, #F43F5E, #FB7185); }
    .stat-card-modern:nth-child(4)::before { background: linear-gradient(90deg, #F59E0B, #FBBF24); }

    .stat-card-modern:hover {
        transform: translateY(-6px);
        box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.1);
    }

    .stat-card-modern:hover::before {
        opacity: 1;
    }

    .stat-icon {
        width: 52px;
        height: 52px;
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.4rem;
        margin-bottom: 18px;
    }

    .stat-val {
        font-size: 2rem;
        font-weight: 800;
        color: var(--text-primary);
        display: block;
        font-family: 'Space Grotesk', 'Inter', sans-serif;
        letter-spacing: -1px;
        line-height: 1;
        margin-bottom: 6px;
    }

    .stat-lbl {
        font-size: 0.78rem;
        font-weight: 700;
        color: var(--text-muted);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* ---- Section Title ---- */
    .section-title {
        font-size: 1.35rem;
        font-weight: 800;
        margin-bottom: 24px;
        color: var(--text-primary);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .section-title i {
        font-size: 1.3rem;
    }

    /* ---- Topic Grid ---- */
    .topic-grid-modern {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        margin-bottom: 36px;
    }

    .topic-card-modern {
        background: white;
        padding: 28px;
        border-radius: 22px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        border: 1px solid rgba(0, 0, 0, 0.04);
        display: flex;
        flex-direction: column;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        text-decoration: none;
        color: inherit;
        position: relative;
        overflow: hidden;
    }

    .topic-card-modern::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--dash-indigo), var(--dash-purple));
        transform: scaleX(0);
        transition: transform 0.4s ease;
        transform-origin: left;
    }

    .topic-card-modern:hover {
        transform: translateY(-4px);
        box-shadow: 0 16px 40px -10px rgba(99, 102, 241, 0.15);
        border-color: rgba(99, 102, 241, 0.15);
    }

    .topic-card-modern:hover::after {
        transform: scaleX(1);
    }

    .topic-card-modern h3 {
        font-size: 1.15rem;
        font-weight: 800;
        margin-bottom: 6px;
        color: var(--text-primary);
    }

    .topic-card-modern p {
        font-size: 0.88rem;
        color: var(--text-muted);
        margin-bottom: 20px;
        line-height: 1.5;
        flex: 1;
    }

    .progress-bar-container {
        height: 8px;
        background: #F1F5F9;
        border-radius: 100px;
        width: 100%;
        margin-bottom: 10px;
        overflow: hidden;
    }

    .progress-bar-fill {
        height: 100%;
        border-radius: 100px;
        background: linear-gradient(90deg, var(--dash-indigo), var(--dash-purple));
        transition: width 1.2s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
    }

    .progress-bar-fill::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.3) 50%, transparent 100%);
        animation: shimmerBar 2s ease-in-out infinite;
    }

    @keyframes shimmerBar {
        0% { transform: translateX(-100%); }
        100% { transform: translateX(100%); }
    }

    .progress-meta {
        display: flex;
        justify-content: space-between;
        font-size: 0.75rem;
        font-weight: 700;
        color: var(--text-muted);
    }

    .progress-meta .progress-pct {
        color: var(--dash-indigo);
    }

    .level-badge {
        position: absolute;
        top: 20px;
        right: 20px;
        padding: 5px 14px;
        background: #EEF2FF;
        color: var(--dash-indigo);
        font-weight: 800;
        font-size: 0.68rem;
        border-radius: 100px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .level-badge.medium {
        background: #FEF3C7;
        color: #D97706;
    }

    .level-badge.hard {
        background: #FEE2E2;
        color: #DC2626;
    }

    /* ---- Second Chance Banner ---- */
    .second-chance-banner {
        background: linear-gradient(135deg, #1E1B4B, #312E81, #4338CA);
        border-radius: 22px;
        padding: 36px 40px;
        color: white;
        margin-bottom: 36px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: relative;
        overflow: hidden;
        box-shadow: 0 16px 40px -10px rgba(67, 56, 202, 0.4);
    }

    .second-chance-banner::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(129, 140, 248, 0.2) 0%, transparent 70%);
        border-radius: 50%;
    }

    .btn-white {
        background: white;
        color: #312E81;
        padding: 14px 28px;
        border-radius: 14px;
        font-weight: 800;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-size: 0.92rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .btn-white:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
    }

    /* ---- Smart Recommendation ---- */
    .recommendation-card {
        background: linear-gradient(135deg, #FAFAFE, #F0F0FF);
        border: 2px dashed #E0E0F0;
        border-radius: 22px;
        padding: 32px;
        margin-bottom: 8px;
        transition: all 0.3s ease;
    }

    .recommendation-card:hover {
        border-color: var(--dash-indigo);
        background: linear-gradient(135deg, #F5F3FF, #EEF2FF);
    }

    .recommendation-card h3 {
        font-size: 1.1rem;
        font-weight: 800;
        margin-bottom: 12px;
        display: flex;
        align-items: center;
        gap: 10px;
        color: var(--text-primary);
    }

    .recommendation-card p {
        font-size: 0.9rem;
        color: var(--text-muted);
        line-height: 1.6;
        margin-bottom: 20px;
    }

    .btn-dark {
        background: linear-gradient(135deg, #1E1B4B, #312E81);
        color: white;
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 700;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 0.88rem;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(30, 27, 75, 0.2);
    }

    .btn-dark:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(30, 27, 75, 0.3);
    }

    /* ---- Sidebar Widgets ---- */
    .widget-modern {
        background: white;
        border-radius: 22px;
        padding: 28px;
        margin-bottom: 24px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        border: 1px solid rgba(0, 0, 0, 0.04);
        transition: all 0.3s ease;
    }

    .widget-modern:hover {
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.07);
    }

    .widget-title {
        font-size: 0.78rem;
        font-weight: 700;
        color: var(--text-muted);
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .widget-title i {
        font-size: 1rem;
        color: var(--dash-indigo);
    }

    /* Activity Items */
    .activity-item {
        display: flex;
        gap: 14px;
        padding: 14px 0;
        border-bottom: 1px solid #F1F5F9;
        align-items: center;
        transition: all 0.2s ease;
    }

    .activity-item:first-of-type {
        padding-top: 0;
    }

    .activity-item:last-child {
        border-bottom: none;
        padding-bottom: 0;
    }

    .activity-item:hover {
        transform: translateX(4px);
    }

    .activity-icon {
        width: 42px;
        height: 42px;
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
        flex-shrink: 0;
    }

    .activity-icon.solved {
        background: rgba(99, 102, 241, 0.08);
        color: var(--dash-indigo);
    }

    .activity-icon.contest {
        background: rgba(16, 185, 129, 0.08);
        color: var(--dash-emerald);
    }

    .activity-icon.streak {
        background: rgba(244, 63, 94, 0.08);
        color: var(--dash-rose);
    }

    .activity-title {
        font-weight: 700;
        font-size: 0.9rem;
        color: var(--text-primary);
        margin-bottom: 2px;
    }

    .activity-time {
        font-size: 0.75rem;
        color: var(--text-muted);
    }

    /* Contest Widget */
    .contest-item {
        padding: 14px 0;
        border-bottom: 1px solid #F1F5F9;
    }

    .contest-item:first-of-type {
        padding-top: 0;
    }

    .contest-item:last-child {
        border-bottom: none;
    }

    .contest-name {
        font-weight: 800;
        font-size: 0.92rem;
        color: var(--text-primary);
        margin-bottom: 4px;
    }

    .contest-time {
        font-size: 0.8rem;
        color: var(--dash-indigo);
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .contest-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 0.82rem;
        font-weight: 700;
        color: var(--dash-indigo);
        text-decoration: none;
        margin-top: 12px;
        transition: all 0.3s ease;
    }

    .contest-link:hover {
        gap: 10px;
        color: var(--dash-purple);
    }

    /* Community Rank Widget */
    .rank-widget {
        border-top: 4px solid var(--dash-indigo);
    }

    .rank-profile {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-bottom: 16px;
    }

    .rank-number {
        width: 52px;
        height: 52px;
        background: linear-gradient(135deg, #EEF2FF, #E0E7FF);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 900;
        font-size: 1rem;
        color: var(--dash-indigo);
        font-family: 'Space Grotesk', sans-serif;
    }

    .rank-handle {
        font-weight: 800;
        font-size: 1.1rem;
    }

    .rank-label {
        font-size: 0.75rem;
        color: var(--text-muted);
    }

    .rank-bar {
        height: 6px;
        background: #F1F5F9;
        border-radius: 100px;
        overflow: hidden;
        margin-bottom: 8px;
    }

    .rank-bar-fill {
        height: 100%;
        border-radius: 100px;
        background: linear-gradient(90deg, var(--dash-indigo), var(--dash-purple));
        transition: width 1s ease;
    }

    .rank-desc {
        font-size: 0.72rem;
        color: var(--text-muted);
        font-weight: 600;
    }

    /* ---- Animations ---- */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .dashboard-container > div > * {
        animation: fadeInUp 0.6s ease forwards;
    }

    .dashboard-container > div > *:nth-child(1) { animation-delay: 0.05s; }
    .dashboard-container > div > *:nth-child(2) { animation-delay: 0.1s; }
    .dashboard-container > div > *:nth-child(3) { animation-delay: 0.15s; }
    .dashboard-container > div > *:nth-child(4) { animation-delay: 0.2s; }
    .dashboard-container > div > *:nth-child(5) { animation-delay: 0.25s; }

    .dashboard-container > aside > * {
        animation: fadeInUp 0.6s ease forwards;
    }

    .dashboard-container > aside > *:nth-child(1) { animation-delay: 0.1s; }
    .dashboard-container > aside > *:nth-child(2) { animation-delay: 0.2s; }
    .dashboard-container > aside > *:nth-child(3) { animation-delay: 0.3s; }

    /* ---- Responsive ---- */
    @media (max-width: 1024px) {
        .dashboard-container {
            grid-template-columns: 1fr;
        }
        .stats-header {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 640px) {
        .stats-header {
            grid-template-columns: 1fr;
        }
        .topic-grid-modern {
            grid-template-columns: 1fr;
        }
        .greeting-banner {
            padding: 28px;
        }
        .greeting-banner h1 {
            font-size: 1.5rem;
        }
        .greeting-emoji {
            display: none;
        }
    }
</style>

<div class="main-layout" style="display: block;">
    <div class="dashboard-container">
        <!-- ============ Main Column ============ -->
        <div>
            <!-- Battle Invitation -->
            <c:if test="${not empty battleInvite}">
                <div class="battle-invite-banner" style="background: linear-gradient(135deg, #FF4B2B 0%, #FF416C 100%); border-radius: 28px; padding: 24px 32px; color: white; margin-bottom: 32px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 15px 40px -10px rgba(255, 75, 43, 0.4); animation: pulseGlow 2s infinite alternate; position: relative; overflow: hidden;">
                    <div style="display: flex; align-items: center; gap: 20px; position: relative; z-index: 1;">
                        <div style="font-size: 2.5rem;">⚔️</div>
                        <div>
                            <h2 style="font-size: 1.25rem; font-weight: 800; margin-bottom: 4px;">1v1 Battle Invitation!</h2>
                            <p style="opacity: 0.9; font-size: 0.95rem;">
                                <strong>${battleInvite.challenger.handle}</strong> has challenged you to a battle on <strong>${battleInvite.problem.name}</strong>!
                            </p>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/contests/battle" class="btn-white" style="color: #FF416C; position: relative; z-index: 1; min-width: 160px; justify-content: center;">
                        Accept Battle <i class="ph-bold ph-sword"></i>
                    </a>
                    <div style="position: absolute; right: -20px; bottom: -20px; font-size: 120px; opacity: 0.1; transform: rotate(-15deg);">⚔️</div>
                </div>
                <style>
                    @keyframes pulseGlow {
                        0% { transform: scale(1); }
                        100% { transform: scale(1.01); }
                    }
                </style>
            </c:if>

            <!-- Greeting Banner -->
            <div class="greeting-banner">
                <h1>Welcome back, ${currentUser.handle}! &#128075;</h1>
                <p>Ready to level up your competitive programming skills? Track your progress, explore new topics, and conquer challenges.</p>
                <div class="greeting-emoji">&#128640;</div>
            </div>

            <!-- Stats Row -->
            <div class="stats-header">
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(99, 102, 241, 0.1); color: var(--dash-indigo);">
                        <i class="ph-bold ph-bullseye"></i>
                    </div>
                    <span class="stat-val">${acceptedSubmissions}</span>
                    <span class="stat-lbl">Solved</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(16, 185, 129, 0.1); color: var(--dash-emerald);">
                        <i class="ph-bold ph-chart-line-up"></i>
                    </div>
                    <span class="stat-val">${accuracy}%</span>
                    <span class="stat-lbl">Accuracy</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(244, 63, 94, 0.1); color: var(--dash-rose);">
                        <i class="ph-bold ph-fire"></i>
                    </div>
                    <span class="stat-val">${streak}</span>
                    <span class="stat-lbl">Day Streak</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(245, 158, 11, 0.1); color: var(--dash-amber);">
                        <i class="ph-bold ph-clock"></i>
                    </div>
                    <span class="stat-val">${timeSpent}</span>
                    <span class="stat-lbl">Learning Time</span>
                </div>
            </div>

            <!-- Second Chance Banner -->
            <c:if test="${not empty secondChanceContest}">
                <div class="second-chance-banner">
                    <div style="z-index: 1;">
                        <h2 style="font-size: 1.5rem; margin-bottom: 10px; font-weight: 800;">&#127919; Second Chance Available</h2>
                        <p style="opacity: 0.8; margin-bottom: 20px; max-width: 420px; line-height: 1.6;">
                            Improve your score on <strong>${secondChanceContest.name}</strong>. Retry missed problems to gain mastery points!
                        </p>
                        <a href="${pageContext.request.contextPath}/contests/${secondChanceContest.id}?retry=true" class="btn-white">
                            Try Again <i class="ph-bold ph-arrow-counter-clockwise"></i>
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- Topic Learning Paths -->
            <h2 class="section-title">
                <i class="ph-bold ph-graduation-cap" style="color: var(--dash-indigo);"></i>
                Topic Learning Paths
            </h2>
            <div class="topic-grid-modern">
                <a href="${pageContext.request.contextPath}/practice/Arrays" class="topic-card-modern">
                    <div class="level-badge">Easy</div>
                    <h3>Arrays & Strings</h3>
                    <p>Foundation of data manipulation and linear traversals.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Arrays']}%"></div>
                    </div>
                    <div class="progress-meta">
                        <span>Progress</span>
                        <span class="progress-pct">${topicProgress['Arrays']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/Trees" class="topic-card-modern">
                    <div class="level-badge medium">Medium</div>
                    <h3>Binary Trees & BST</h3>
                    <p>Recursive thinking and hierarchical data structures.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Trees']}%"></div>
                    </div>
                    <div class="progress-meta">
                        <span>Progress</span>
                        <span class="progress-pct">${topicProgress['Trees']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/DP" class="topic-card-modern">
                    <div class="level-badge hard">Hard</div>
                    <h3>Dynamic Programming</h3>
                    <p>Optimization through subproblem memoization.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['DP']}%"></div>
                    </div>
                    <div class="progress-meta">
                        <span>Progress</span>
                        <span class="progress-pct">${topicProgress['DP']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/Graphs" class="topic-card-modern">
                    <div class="level-badge medium">Medium</div>
                    <h3>Graph Algorithms</h3>
                    <p>Master BFS, DFS, and pathfinding in networks.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Graphs']}%"></div>
                    </div>
                    <div class="progress-meta">
                        <span>Progress</span>
                        <span class="progress-pct">${topicProgress['Graphs']}%</span>
                    </div>
                </a>
            </div>

            <!-- Smart Recommendation -->
            <div class="recommendation-card">
                <h3>
                    <span style="font-size: 1.4rem;">&#128161;</span>
                    Smart Recommendation
                </h3>
                <p>Based on your recent performance, we recommend focusing on <strong>Graph Theory</strong> to improve your overall accuracy.</p>
                <a href="${pageContext.request.contextPath}/practice/Graphs" class="btn-dark">
                    <i class="ph-bold ph-graph"></i> Focus on Graphs
                </a>
            </div>
        </div>

        <!-- ============ Sidebar Column ============ -->
        <aside>
            <!-- Recent Activity -->
            <div class="widget-modern">
                <div class="widget-title">
                    <i class="ph-bold ph-clock-counter-clockwise"></i>
                    Recent Activity
                </div>
                <c:choose>
                    <c:when test="${not empty activities}">
                        <c:forEach var="activity" items="${activities}">
                            <div class="activity-item">
                                <div class="activity-icon ${activity.iconClass}"><i class="ph-bold ${activity.icon}"></i></div>
                                <div>
                                    <div class="activity-title">${activity.title}</div>
                                    <div class="activity-time">${activity.time}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="activity-item">
                            <div class="activity-icon solved"><i class="ph-bold ph-info"></i></div>
                            <div>
                                <div class="activity-title">No recent activity</div>
                                <div class="activity-time">Start practicing to see updates!</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Upcoming Contests -->
            <div class="widget-modern">
                <div class="widget-title">
                    <i class="ph-bold ph-calendar-check"></i>
                    Upcoming Contests
                </div>
                <c:forEach var="contest" items="${upcomingContests}" varStatus="loop">
                    <c:if test="${loop.index < 3}">
                        <div class="contest-item">
                            <div class="contest-name">${contest.name}</div>
                            <div class="contest-time">
                                <i class="ph ph-clock"></i> ${contest.time}
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/contests" class="contest-link">
                    View All Contests <i class="ph-bold ph-arrow-right"></i>
                </a>
            </div>

            <!-- Community Rank -->
            <div class="widget-modern rank-widget">
                <div class="widget-title">
                    <i class="ph-bold ph-ranking"></i>
                    Community Rank
                </div>
                <div class="rank-profile">
                    <div class="rank-number">#${userRank}</div>
                    <div>
                        <div class="rank-handle" style="color: ${currentUser.getRankColor()}">${currentUser.handle}</div>
                        <div class="rank-label">${currentUser.getRankTitle()}</div>
                    </div>
                </div>
                <div class="rank-bar">
                    <div class="rank-bar-fill" style="width: ${userPercentile}%;"></div>
                </div>
                <div class="rank-desc">Top ${100 - userPercentile}% of all users</div>
            </div>
        </aside>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
