<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="${topic} Path" />
    <jsp:param name="activePage" value="practice" />
</jsp:include>

<style>
    .path-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 0;
        position: relative;
    }

    .path-line {
        position: absolute;
        left: 40px;
        top: 100px;
        bottom: 100px;
        width: 4px;
        background: #E2E8F0;
        z-index: 0;
    }

    .level-section {
        position: relative;
        z-index: 1;
        margin-bottom: 80px;
    }

    .level-header {
        display: flex;
        align-items: center;
        gap: 24px;
        margin-bottom: 40px;
    }

    .level-indicator {
        width: 84px;
        height: 84px;
        border-radius: 50%;
        background: white;
        border: 4px solid #E2E8F0;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
        box-shadow: var(--card-shadow);
        flex-shrink: 0;
    }

    .level-section.active .level-indicator { border-color: var(--primary-indigo); color: var(--primary-indigo); }
    .level-section.active .level-title { color: var(--text-dark); }

    .level-content { margin-left: 108px; }

    .problem-node {
        background: white;
        border-radius: 24px;
        padding: 24px 32px;
        margin-bottom: 24px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(0,0,0,0.03);
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: all 0.3s ease;
        position: relative;
    }

    .problem-node::before {
        content: '';
        position: absolute;
        left: -68px;
        top: 50%;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background: #E2E8F0;
        border: 4px solid white;
        transform: translateY(-50%);
    }

    .problem-node.solved::before { background: var(--primary-emerald); }
    .problem-node:hover { transform: translateX(10px); border-color: var(--primary-indigo); }

    .node-info h4 { font-size: 1.1rem; font-weight: 800; margin-bottom: 4px; }
    .node-info p { font-size: 0.85rem; color: var(--text-muted); }

    .status-pill {
        padding: 6px 16px;
        border-radius: 100px;
        font-size: 0.75rem;
        font-weight: 800;
        text-transform: uppercase;
    }

    .status-pill.solved { background: rgba(16, 185, 129, 0.1); color: var(--primary-emerald); }
    .status-pill.pending { background: #F1F5F9; color: var(--text-muted); }

</style>

<div class="main-layout">
    
    <div style="margin-bottom: 40px;">
        <a href="${pageContext.request.contextPath}/practice" style="text-decoration: none; color: var(--text-muted); font-weight: 700;">
            <i class="ph ph-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <div class="path-container">
        <div class="path-line"></div>

        <!-- FOUNDATIONAL STAGE -->
        <div class="level-section active">
            <div class="level-header">
                <div class="level-indicator">🪴</div>
                <div>
                    <h2 class="level-title" style="font-size: 1.75rem; font-weight: 800;">Stage 1: Foundational</h2>
                    <p style="color: var(--text-muted);">Master the core concepts of ${topic}.</p>
                </div>
            </div>
            
            <div class="level-content">
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating < 1200}">
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        
                        <div class="problem-node ${isSolved ? 'solved' : ''}">
                            <div class="node-info">
                                <h4>${problem.name}</h4>
                                <p>Rating: ${problem.difficultyRating} • Mastery Points: +10</p>
                            </div>
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <span class="status-pill ${isSolved ? 'solved' : 'pending'}">${isSolved ? 'Completed' : 'Pending'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="btn btn-primary btn-sm" style="background: ${isSolved ? '#F1F5F9' : 'var(--text-dark)'}; color: ${isSolved ? 'var(--text-dark)' : 'white'}; border:none;">
                                    ${isSolved ? 'Review' : 'Start'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- PROFICIENCY STAGE -->
        <div class="level-section active" style="margin-top: 100px;">
            <div class="level-header">
                <div class="level-indicator" style="border-color: #FEF3C7; color: #D97706;">⚔️</div>
                <div>
                    <h2 class="level-title" style="font-size: 1.75rem; font-weight: 800;">Stage 2: Proficiency</h2>
                    <p style="color: var(--text-muted);">Bridge the gap between theory and implementation.</p>
                </div>
            </div>
            
            <div class="level-content">
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating >= 1200 && problem.difficultyRating < 1800}">
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        
                        <div class="problem-node ${isSolved ? 'solved' : ''}">
                            <div class="node-info">
                                <h4>${problem.name}</h4>
                                <p>Rating: ${problem.difficultyRating} • Mastery Points: +25</p>
                            </div>
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <span class="status-pill ${isSolved ? 'solved' : 'pending'}">${isSolved ? 'Completed' : 'Pending'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="btn btn-primary btn-sm" style="background: ${isSolved ? '#F1F5F9' : 'var(--text-dark)'}; color: ${isSolved ? 'var(--text-dark)' : 'white'}; border:none;">
                                    ${isSolved ? 'Review' : 'Start'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <!-- ADVANCED STAGE -->
        <div class="level-section active" style="margin-top: 100px;">
            <div class="level-header">
                <div class="level-indicator" style="border-color: #FEE2E2; color: #DC2626;">🔥</div>
                <div>
                    <h2 class="level-title" style="font-size: 1.75rem; font-weight: 800;">Stage 3: Advanced</h2>
                    <p style="color: var(--text-muted);">Challenge yourself with complex edge cases and optimization.</p>
                </div>
            </div>
            
            <div class="level-content">
                <c:forEach var="problem" items="${problems}">
                    <c:if test="${problem.difficultyRating >= 1800}">
                        <c:set var="isSolved" value="${false}" />
                        <c:forEach var="solvedId" items="${solvedProblemIds}"><c:if test="${solvedId == problem.id}"><c:set var="isSolved" value="${true}" /></c:if></c:forEach>
                        
                        <div class="problem-node ${isSolved ? 'solved' : ''}">
                            <div class="node-info">
                                <h4>${problem.name}</h4>
                                <p>Rating: ${problem.difficultyRating} • Mastery Points: +50</p>
                            </div>
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <span class="status-pill ${isSolved ? 'solved' : 'pending'}">${isSolved ? 'Completed' : 'Pending'}</span>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" class="btn btn-primary btn-sm" style="background: ${isSolved ? '#F1F5F9' : 'var(--text-dark)'}; color: ${isSolved ? 'var(--text-dark)' : 'white'}; border:none;">
                                    ${isSolved ? 'Review' : 'Start'}
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
