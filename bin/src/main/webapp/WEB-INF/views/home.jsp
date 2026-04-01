<style>
    :root {
        --primary-indigo: #6366F1;
        --primary-purple: #8B5CF6;
        --primary-emerald: #10B981;
        --bg-glass: rgba(255, 255, 255, 0.8);
        --card-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
    }

    .dashboard-container {
        display: grid;
        grid-template-columns: 1fr 340px;
        gap: 32px;
        padding: 40px 0;
    }

    /* Stats Overview */
    .stats-header {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
        margin-bottom: 40px;
    }

    .stat-card-modern {
        background: white;
        padding: 24px;
        border-radius: 24px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(0,0,0,0.03);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .stat-card-modern:hover { transform: translateY(-5px); box-shadow: 0 20px 40px -10px rgba(0,0,0,0.1); }

    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin-bottom: 16px;
    }

    .stat-val { font-size: 1.75rem; font-weight: 800; color: var(--text-dark); display: block; }
    .stat-lbl { font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }

    /* Topic Grid */
    .section-title { font-size: 1.5rem; font-weight: 800; margin-bottom: 24px; color: var(--text-dark); display: flex; align-items: center; gap: 12px; }

    .topic-grid-modern {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 24px;
        margin-bottom: 48px;
    }

    .topic-card-modern {
        background: white;
        padding: 32px;
        border-radius: 32px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(0,0,0,0.02);
        display: flex;
        flex-direction: column;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        text-decoration: none;
        color: inherit;
        position: relative;
    }

    .topic-card-modern:hover { transform: scale(1.02); border-color: var(--primary-indigo); }

    .topic-card-modern h3 { font-size: 1.25rem; font-weight: 800; margin-bottom: 8px; }
    .topic-card-modern p { font-size: 0.9rem; color: var(--text-slate); margin-bottom: 20px; line-height: 1.5; }

    .progress-bar-container {
        height: 8px;
        background: #F1F5F9;
        border-radius: 4px;
        width: 100%;
        margin-bottom: 12px;
    }

    .progress-bar-fill { height: 100%; border-radius: 4px; background: var(--primary-indigo); transition: width 1s ease-out; }

    .level-badge {
        position: absolute;
        top: 24px;
        right: 24px;
        padding: 6px 12px;
        background: #EEF2FF;
        color: var(--primary-indigo);
        font-weight: 800;
        font-size: 0.7rem;
        border-radius: 100px;
        text-transform: uppercase;
    }

    /* Second Chance Banner */
    .second-chance-banner {
        background: linear-gradient(135deg, var(--text-dark), #2D3748);
        border-radius: 32px;
        padding: 40px;
        color: white;
        margin-bottom: 48px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        position: relative;
        overflow: hidden;
    }

    .second-chance-banner::after {
        content: '\21BA';
        position: absolute;
        right: -20px;
        bottom: -40px;
        font-size: 12rem;
        opacity: 0.05;
        transform: rotate(-15deg);
    }

    .btn-white {
        background: white;
        color: var(--text-dark);
        padding: 14px 28px;
        border-radius: 16px;
        font-weight: 800;
        text-decoration: none;
        transition: all 0.3s;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    .btn-white:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }

    /* Side Column Widgets */
    .widget-modern {
        background: white;
        border-radius: 24px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: var(--card-shadow);
    }

    .activity-item {
        display: flex;
        gap: 16px;
        margin-bottom: 20px;
        padding-bottom: 20px;
        border-bottom: 1px solid #F1F5F9;
    }

    .activity-icon {
        width: 40px;
        height: 40px;
        background: #F8FAFC;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary-indigo);
    }
</style>

<div class="main-layout">
    
    <div class="dashboard-container">
        <!-- Main Column -->
        <div>
            <!-- Stats -->
            <div class="stats-header">
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(99, 102, 241, 0.1); color: var(--primary-indigo);"><i class="ph-bold ph-bullseye"></i></div>
                    <span class="stat-val">${acceptedSubmissions}</span>
                    <span class="stat-lbl">Solved</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(16, 185, 129, 0.1); color: var(--primary-emerald);"><i class="ph-bold ph-chart-line-up"></i></div>
                    <span class="stat-val">${accuracy}%</span>
                    <span class="stat-lbl">Accuracy</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(255, 107, 107, 0.1); color: #FF6B6B;"><i class="ph-bold ph-fire"></i></div>
                    <span class="stat-val">${streak}</span>
                    <span class="stat-lbl">Day Streak</span>
                </div>
                <div class="stat-card-modern">
                    <div class="stat-icon" style="background: rgba(245, 158, 11, 0.1); color: #F59E0B;"><i class="ph-bold ph-clock"></i></div>
                    <span class="stat-val">${timeSpent}</span>
                    <span class="stat-lbl">Learning Time</span>
                </div>
            </div>

            <!-- Second Chance -->
            <c:if test="${not empty secondChanceContest}">
                <div class="second-chance-banner">
                    <div style="z-index: 1;">
                        <h2 style="font-size: 1.75rem; margin-bottom: 12px;">Second Chance Available</h2>
                        <p style="opacity: 0.8; margin-bottom: 24px; max-width: 450px;">
                            Improve your score on <strong>${secondChanceContest.name}</strong>. Retry missed problems to gain mastery points!
                        </p>
                        <a href="${pageContext.request.contextPath}/contests/${secondChanceContest.id}?retry=true" class="btn-white">
                            Try Again <i class="ph-bold ph-arrow-counter-clockwise"></i>
                        </a>
                    </div>
                    <div style="font-size: 5rem; opacity: 0.2; z-index: 0;">🎯</div>
                </div>
            </c:if>

            <!-- Topic Based Learning Paths -->
            <h2 class="section-title"><i class="ph-bold ph-graduation-cap" style="color:var(--primary-indigo)"></i> Topic Learning Paths</h2>
            <div class="topic-grid-modern">
                <a href="${pageContext.request.contextPath}/practice/Arrays" class="topic-card-modern">
                    <div class="level-badge">Easy</div>
                    <h3>Arrays & Strings</h3>
                    <p>Foundation of data manipulation and linear traversals.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Arrays']}%"></div>
                    </div>
                    <div style="display:flex; justify-content: space-between; font-size: 0.75rem; font-weight:700;">
                        <span>Progress</span>
                        <span>${topicProgress['Arrays']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/Trees" class="topic-card-modern">
                    <div class="level-badge" style="background:#FEF3C7; color:#D97706;">Medium</div>
                    <h3>Binary Trees & BST</h3>
                    <p>Recursive thinking and hierarchical data structures.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Trees']}%"></div>
                    </div>
                    <div style="display:flex; justify-content: space-between; font-size: 0.75rem; font-weight:700;">
                        <span>Progress</span>
                        <span>${topicProgress['Trees']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/DP" class="topic-card-modern">
                    <div class="level-badge" style="background:#FEE2E2; color:#DC2626;">Hard</div>
                    <h3>Dynamic Programming</h3>
                    <p>Optimization through subproblem memoization.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['DP']}%"></div>
                    </div>
                    <div style="display:flex; justify-content: space-between; font-size: 0.75rem; font-weight:700;">
                        <span>Progress</span>
                        <span>${topicProgress['DP']}%</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/practice/Graphs" class="topic-card-modern">
                    <div class="level-badge" style="background:#FEF3C7; color:#D97706;">Medium</div>
                    <h3>Graph Algorithms</h3>
                    <p>Master BFS, DFS, and pathfinding in networks.</p>
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topicProgress['Graphs']}%"></div>
                    </div>
                    <div style="display:flex; justify-content: space-between; font-size: 0.75rem; font-weight:700;">
                        <span>Progress</span>
                        <span>${topicProgress['Graphs']}%</span>
                    </div>
                </a>
            </div>

            <!-- Smart Recommendations -->
            <div class="widget-modern" style="background: linear-gradient(135deg, #F9FAFB, #F3F4F6); border: 2px dashed #E2E8F0;">
                <h3 style="margin-bottom: 20px; display: flex; align-items: center; gap: 12px;">
                    <span style="font-size: 1.5rem;">💡</span> Smart Recommendation
                </h3>
                <p style="color: var(--text-slate); margin-bottom: 24px;">Based on your recent performance, we recommend focusing on <strong>Graph Theory</strong> to improve your overall accuracy.</p>
                <a href="${pageContext.request.contextPath}/practice/Graphs" class="btn btn-primary" style="background: var(--text-dark); border:none;">Focus on Graphs</a>
            </div>
        </div>

        <!-- Sidebar Column -->
        <aside>
            <div class="widget-modern">
                <h3 class="stat-lbl" style="margin-bottom: 20px;">Recent Activity</h3>
                <div class="activity-item">
                    <div class="activity-icon"><i class="ph ph-check-circle"></i></div>
                    <div>
                        <div style="font-weight: 700; font-size: 0.9rem;">Solved Problem A</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">2 hours ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon" style="color:var(--primary-emerald)"><i class="ph ph-trophy"></i></div>
                    <div>
                        <div style="font-weight: 700; font-size: 0.9rem;">Entered Round #842</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Yesterday</div>
                    </div>
                </div>
                <div class="activity-item" style="border:none; margin:0; padding:0;">
                    <div class="activity-icon" style="color:#FF6B6B"><i class="ph ph-flame"></i></div>
                    <div>
                        <div style="font-weight: 700; font-size: 0.9rem;">12 Day Streak!</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Keep it up!</div>
                    </div>
                </div>
            </div>

            <div class="widget-modern">
                <h3 class="stat-lbl" style="margin-bottom: 20px;">Upcoming Contests</h3>
                <c:forEach var="contest" items="${upcomingContests}" varStatus="loop">
                    <c:if test="${loop.index < 3}">
                        <div style="margin-bottom: 16px;">
                            <div style="font-weight: 800; font-size: 0.95rem; margin-bottom: 4px;">${contest.name}</div>
                            <div style="font-size: 0.8rem; color: var(--primary-indigo); font-weight: 700;">Starts in 22h 15m</div>
                        </div>
                    </c:if>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/contests" style="font-size: 0.8rem; font-weight: 700; color: var(--text-muted); text-decoration: none;">View All Contests →</a>
            </div>

            <div class="widget-modern" style="border-top: 4px solid var(--primary-indigo);">
                <h3 class="stat-lbl" style="margin-bottom: 16px;">Community Rank</h3>
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 12px;">
                    <div style="width: 48px; height: 48px; background: #F8FAFC; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800;">#42</div>
                    <div>
                        <div style="font-weight: 800; font-size: 1.1rem; color: ${currentUser.getRankColor()}">${currentUser.handle}</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">Elite Rank</div>
                    </div>
                </div>
                <div class="progress-bar-container" style="height: 6px;">
                    <div class="progress-bar-fill" style="width: 65%; background: var(--primary-purple);"></div>
                </div>
                <div style="font-size: 0.7rem; color: var(--text-muted); margin-top: 8px;">Top 15% of all users</div>
            </div>
        </aside>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
