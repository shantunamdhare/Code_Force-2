<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="${topic} Mastery Path" />
    <jsp:param name="activePage" value="practice" />
</jsp:include>

<style>
    :root {
        --stage-1-bg: #818cf8;
        --stage-2-bg: #fbbf24;
        --stage-3-bg: #f87171;
    }

    .topic-path-container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 60px 20px;
    }

    .path-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 60px;
    }

    .path-back-btn {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 12px 24px;
        background: white;
        border-radius: 16px;
        text-decoration: none;
        color: #1e293b;
        font-weight: 800;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .path-back-btn:hover {
        transform: translateX(-8px);
        background: #f8fafc;
    }

    .path-title-group h1 {
        font-size: 3rem;
        font-weight: 900;
        letter-spacing: -1px;
        margin: 0;
        background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .topic-stats-card {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(12px);
        padding: 20px 32px;
        border-radius: 24px;
        border: 1px solid rgba(255, 255, 255, 0.4);
        display: flex;
        gap: 40px;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
    }

    .stat-item { text-align: center; }
    .stat-val { font-size: 1.75rem; font-weight: 900; color: #1e293b; line-height: 1; margin-bottom: 4px; }
    .stat-lbl { font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 1px; }

    .roadmap-timeline {
        position: relative;
        padding-left: 100px;
    }

    .roadmap-timeline::before {
        content: '';
        position: absolute;
        left: 42px;
        top: 40px;
        bottom: 40px;
        width: 4px;
        background: #e2e8f0;
        border-radius: 10px;
    }

    .stage-wrapper {
        position: relative;
        margin-bottom: 80px;
    }

    .stage-marker {
        position: absolute;
        left: -100px;
        width: 88px;
        height: 88px;
        background: white;
        border: 6px solid #e2e8f0;
        border-radius: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.2rem;
        z-index: 2;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .stage-wrapper:hover .stage-marker {
        transform: scale(1.1) rotate(5deg);
    }

    .stage-info { margin-bottom: 32px; }
    .stage-name { font-size: 2rem; font-weight: 900; color: #0f172a; margin-bottom: 8px; }
    .stage-subtitle { font-size: 1.1rem; color: #64748b; font-weight: 600; }

    .problem-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 20px;
    }

    .road-card {
        background: white;
        border_radius: 28px;
        padding: 28px 40px;
        display: flex;
        justify_content: space_between;
        align_items: center;
        box_shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        border: 1px solid rgba(0, 0, 0, 0.02);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    /* Fixed border radius and spacing names */
    .road-card {
        border-radius: 28px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }

    .road-card::after {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 8px;
        background: #e2e8f0;
    }

    .road-card.card-solved::after { background: #10b981; }
    .road-card:hover { transform: translateX(12px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); border-color: #cbd5e1; }

    .road-title { font-size: 1.25rem; font-weight: 800; color: #1e293b; margin-bottom: 6px; }
    .road-meta { font-size: 0.9rem; color: #64748b; font-weight: 700; display: flex; align-items: center; gap: 8px; }

    .status-capsule {
        padding: 8px 20px;
        border-radius: 100px;
        font-size: 0.8rem;
        font-weight: 900;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .capsule-solved { background: #d1fae5; color: #065f46; }
    .capsule-pending { background: #f1f5f9; color: #64748b; }

    .path-action-btn {
        padding: 12px 32px;
        border-radius: 16px;
        text-decoration: none;
        font-weight: 800;
        font-size: 0.95rem;
        transition: all 0.3s;
    }

    .btn-start { background: #0f172a; color: white; border: 2px solid #0f172a; }
    .btn-review { background: white; color: #0f172a; border: 2px solid #e2e8f0; }

    .btn-start:hover { background: #334155; transform: scale(1.05); }
    .btn-review:hover { background: #f8fafc; border-color: #cbd5e1; }

    .empty-road {
        padding: 40px;
        text-align: center;
        background: #f8fafc;
        border-radius: 28px;
        border: 3px dashed #e2e8f0;
        color: #94a3b8;
        font-weight: 700;
        font-size: 1.1rem;
    }

    /* Stage Themes */
    .stage-1 .stage-marker { border-color: var(--stage-1-bg); color: var(--stage-1-bg); }
    .stage-2 .stage-marker { border-color: var(--stage-2-bg); color: var(--stage-2-bg); }
    .stage-3 .stage-marker { border-color: var(--stage-3-bg); color: var(--stage-3-bg); }

    .stage-1 .road-card:not(.card-solved):hover::after { background: var(--stage-1-bg); }
    .stage-2 .road-card:not(.card-solved):hover::after { background: var(--stage-2-bg); }
    .stage-3 .road-card:not(.card-solved):hover::after { background: var(--stage-3-bg); }

</style>

<div class="topic-path-container">
    <div class="path-header">
        <div class="path-title-group">
            <a href="${pageContext.request.contextPath}/practice" class="path-back-btn">
                <i class="ph-bold ph-arrow-left"></i> Practice Overview
            </a>
            <h1 style="margin-top: 20px;">${topic} Path</h1>
        </div>

        <div class="topic-stats-card">
            <div class="stat-item">
                <div class="stat-val">${fn:length(problems)}</div>
                <div class="stat-lbl">Problems</div>
            </div>
            <div class="stat-item">
                <div class="stat-val" style="color: #10b981;">${fn:length(solvedProblemIds)}</div>
                <div class="stat-lbl">Solved</div>
            </div>
            <div class="stat-item">
                <div class="stat-val" style="color: #6366f1;">
                    <c:choose>
                        <c:when test="${fn:length(problems) > 0}">
                            <fmt:formatNumber value="${fn:length(solvedProblemIds) / fn:length(problems) * 100}" maxFractionDigits="0"/>%
                        </c:when>
                        <c:otherwise>0%</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-lbl">Mastery</div>
            </div>
        </div>
    </div>

    <div class="roadmap-timeline">
        <!-- STAGE 1 -->
        <div class="stage-wrapper stage-1">
            <div class="stage-marker">
                <i class="ph-bold ph-plant"></i>
            </div>
            <div class="stage-info">
                <h2 class="stage-name">Stage 1: Core Fundamentals</h2>
                <p class="stage-subtitle">Master the basics and foundational implementation of ${topic}.</p>
            </div>
            <div class="problem-grid">
                <c:set var="count1" value="0" />
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating < 1200}">
                        <c:set var="count1" value="${count1 + 1}" />
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        <div class="road-card ${isSolved ? 'card-solved' : ''}">
                            <div>
                                <h3 class="road-title">${problem.name}</h3>
                                <div class="road-meta">
                                    <span style="color: #6366f1;"><i class="ph-fill ph-shield-check"></i> Rating ${problem.difficultyRating}</span>
                                    <span>•</span>
                                    <span>+10 Mastery Points</span>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 24px;">
                                <span class="status-capsule ${isSolved ? 'capsule-solved' : 'capsule-pending'}">${isSolved ? 'Solved' : 'Incomplete'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="path-action-btn ${isSolved ? 'btn-review' : 'btn-start'}">
                                    ${isSolved ? 'Review' : 'Start Challenge'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${count1 == 0}">
                    <div class="empty-road">Coming soon: Foundational challenges for ${topic}.</div>
                </c:if>
            </div>
        </div>

        <!-- STAGE 2 -->
        <div class="stage-wrapper stage-2">
            <div class="stage-marker">
                <i class="ph-bold ph-sword"></i>
            </div>
            <div class="stage-info">
                <h2 class="stage-name">Stage 2: Tactical Proficiency</h2>
                <p class="stage-subtitle">Develop complex problem-solving patterns and efficient logic.</p>
            </div>
            <div class="problem-grid">
                <c:set var="count2" value="0" />
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating >= 1200 && problem.difficultyRating < 1800}">
                        <c:set var="count2" value="${count2 + 1}" />
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        <div class="road-card ${isSolved ? 'card-solved' : ''}">
                            <div>
                                <h3 class="road-title">${problem.name}</h3>
                                <div class="road-meta">
                                    <span style="color: #f59e0b;"><i class="ph-fill ph-sword"></i> Rating ${problem.difficultyRating}</span>
                                    <span>•</span>
                                    <span>+25 Mastery Points</span>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 24px;">
                                <span class="status-capsule ${isSolved ? 'capsule-solved' : 'capsule-pending'}">${isSolved ? 'Solved' : 'Incomplete'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="path-action-btn ${isSolved ? 'btn-review' : 'btn-start'}">
                                    ${isSolved ? 'Review' : 'Start Challenge'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${count2 == 0}">
                    <div class="empty-road">Coming soon: Intermediate tactical problems for ${topic}.</div>
                </c:if>
            </div>
        </div>

        <!-- STAGE 3 -->
        <div class="stage-wrapper stage-3">
            <div class="stage-marker">
                <i class="ph-bold ph-fire"></i>
            </div>
            <div class="stage-info">
                <h2 class="stage-name">Stage 3: Legendary Mastery</h2>
                <p class="stage-subtitle">Optimize to the extreme and tackle advanced algorithmic edge cases.</p>
            </div>
            <div class="problem-grid">
                <c:set var="count3" value="0" />
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating >= 1800}">
                        <c:set var="count3" value="${count3 + 1}" />
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        <div class="road-card ${isSolved ? 'card-solved' : ''}">
                            <div>
                                <h3 class="road-title">${problem.name}</h3>
                                <div class="road-meta">
                                    <span style="color: #ef4444;"><i class="ph-fill ph-fire"></i> Rating ${problem.difficultyRating}</span>
                                    <span>•</span>
                                    <span>+50 Mastery Points</span>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 24px;">
                                <span class="status-capsule ${isSolved ? 'capsule-solved' : 'capsule-pending'}">${isSolved ? 'Solved' : 'Incomplete'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="path-action-btn ${isSolved ? 'btn-review' : 'btn-start'}">
                                    ${isSolved ? 'Review' : 'Start Challenge'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${count3 == 0}">
                    <div class="empty-road">Coming soon: Advanced legendary challenges for ${topic}.</div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
