<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Practice" />
    <jsp:param name="activePage" value="practice" />
</jsp:include>

<style>
    /* ========== Practice Specific Styles ========== */
    :root {
        --practice-indigo: #6366F1;
        --practice-purple: #8B5CF6;
        --practice-bg: #F8FAFC;
    }

    .learning-path-header {
        background: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
        color: white;
        padding: 60px 50px;
        border-radius: 32px;
        margin-bottom: 48px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 20px 50px -15px rgba(99, 102, 241, 0.3);
    }

    .learning-path-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 450px;
        height: 450px;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        border-radius: 50%;
        animation: pulse 8s infinite alternate;
    }

    @keyframes pulse {
        0% { transform: scale(1); opacity: 0.5; }
        100% { transform: scale(1.2); opacity: 0.8; }
    }

    .learning-path-header h1 {
        font-size: 2.75rem;
        font-weight: 800;
        margin-bottom: 16px;
        letter-spacing: -1px;
    }

    .learning-path-header p {
        font-size: 1.15rem;
        opacity: 0.9;
        max-width: 650px;
        line-height: 1.6;
    }

    .topic-journey-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 28px;
        margin-bottom: 60px;
    }

    .journey-card {
        background: white;
        border-radius: 28px;
        padding: 40px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.04);
        border: 1px solid rgba(0,0,0,0.02);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        text-decoration: none;
        color: inherit;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .journey-card::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: var(--practice-indigo);
        transform: scaleX(0);
        transition: transform 0.3s ease;
    }

    .journey-card:hover {
        transform: translateY(-12px);
        box-shadow: 0 25px 50px -12px rgba(0,0,0,0.08);
        border-color: rgba(99, 102, 241, 0.2);
    }

    .journey-card:hover::after {
        transform: scaleX(1);
    }

    .journey-icon {
        width: 88px;
        height: 88px;
        border-radius: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        margin-bottom: 24px;
        background: #F8FAFC;
        color: var(--practice-indigo);
        transition: all 0.3s ease;
    }

    .journey-card:hover .journey-icon {
        background: var(--practice-indigo);
        color: white;
        transform: rotate(5deg) scale(1.1);
    }

    .path-step {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.72rem;
        font-weight: 800;
        text-transform: uppercase;
        margin-bottom: 16px;
        color: var(--text-muted);
        letter-spacing: 0.5px;
    }

    .step-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: #E2E8F0;
    }

    .step-dot.active {
        background: var(--practice-indigo);
        box-shadow: 0 0 10px rgba(99, 102, 241, 0.5);
    }

    .journey-card h3 {
        font-size: 1.4rem;
        font-weight: 800;
        margin-bottom: 10px;
        color: var(--text-primary);
    }

    .journey-card p {
        color: var(--text-muted);
        font-size: 0.95rem;
        margin-bottom: 30px;
        line-height: 1.5;
        flex: 1;
    }

    .progress-info {
        width: 100%;
    }

    .progress-bar-container {
        height: 10px;
        background: #F1F5F9;
        border-radius: 100px;
        width: 100%;
        margin-bottom: 12px;
        overflow: hidden;
    }

    .progress-bar-fill {
        height: 100%;
        border-radius: 100px;
        background: linear-gradient(90deg, #6366F1, #8B5CF6);
        transition: width 1s ease-out;
    }

    .progress-meta {
        display: flex;
        justify-content: space-between;
        font-weight: 800;
        font-size: 0.75rem;
        color: var(--text-muted);
    }

    /* AI Stats Widget */
    .ai-widget {
        margin-top: 40px;
        background: white;
        border-radius: 32px;
        padding: 60px;
        display: flex;
        align-items: center;
        gap: 60px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.03);
        border: 1px solid rgba(0,0,0,0.02);
    }

    .ai-content h2 {
        font-size: 2.25rem;
        font-weight: 800;
        margin-bottom: 20px;
        color: var(--text-primary);
    }

    .ai-content p {
        color: var(--text-muted);
        font-size: 1.1rem;
        margin-bottom: 32px;
        line-height: 1.6;
        max-width: 600px;
    }

    .rec-grid {
        display: flex;
        gap: 16px;
        flex-wrap: wrap;
    }

    .rec-card {
        background: #F8FAFC;
        padding: 20px 24px;
        border-radius: 20px;
        min-width: 200px;
        text-decoration: none;
        border-left: 4px solid var(--practice-purple);
        transition: all 0.3s ease;
    }

    .rec-card:hover {
        transform: scale(1.05);
        background: white;
        box-shadow: 0 10px 20px rgba(0,0,0,0.05);
    }

    .rec-card .name {
        font-weight: 800;
        font-size: 0.95rem;
        color: var(--text-primary);
        margin-bottom: 4px;
        display: block;
    }

    .rec-card .difficulty {
        font-size: 0.75rem;
        color: var(--practice-purple);
        font-weight: 700;
    }

    .ai-avatar {
        width: 280px;
        height: 280px;
        background: linear-gradient(135deg, #F8FAFC, #EEF2FF);
        border-radius: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 8rem;
        box-shadow: inset 0 0 20px rgba(99, 102, 241, 0.05);
        animation: float 4s ease-in-out infinite;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-15px); }
    }

    @media (max-width: 1100px) {
        .topic-journey-grid { grid-template-columns: repeat(2, 1fr); }
        .ai-widget { flex-direction: column; text-align: center; padding: 40px; }
        .ai-content p { margin: 0 auto 32px; }
        .rec-grid { justify-content: center; }
    }

    @media (max-width: 640px) {
        .topic-journey-grid { grid-template-columns: 1fr; }
        .learning-path-header { padding: 40px 30px; }
        .learning-path-header h1 { font-size: 2rem; }
    }
</style>

<div class="main-layout" style="display: block;">
    <div class="learning-path-header">
        <h1>Guided Learning Paths</h1>
        <p>Master competitive programming through our structured curriculum. No more random problems, follow a logical progression tailored to your current level.</p>
    </div>

    <div class="topic-journey-grid">
<<<<<<< HEAD

        <%-- Arrays --%>
        <a href="${pageContext.request.contextPath}/practice/Arrays" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-brackets-square"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">Arrays</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Foundational data structures</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['Arrays']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['Arrays']}%</span>
            </div>
        </a>

        <%-- Trees --%>
        <a href="${pageContext.request.contextPath}/practice/Trees" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-tree-structure"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">Trees</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Recursive hierarchical logic</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['Trees']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['Trees']}%</span>
            </div>
        </a>

        <%-- DP --%>
        <a href="${pageContext.request.contextPath}/practice/DP" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-cube"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">DP</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Advanced optimization</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['DP']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['DP']}%</span>
            </div>
        </a>

        <%-- Graphs --%>
        <a href="${pageContext.request.contextPath}/practice/Graphs" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-graph"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">Graphs</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Network &amp; connectivity</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['Graphs']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['Graphs']}%</span>
            </div>
        </a>

        <%-- Math --%>
        <a href="${pageContext.request.contextPath}/practice/Math" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-function"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">Math</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Number theory &amp; combinatorics</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['Math']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['Math']}%</span>
            </div>
        </a>

        <%-- Strings --%>
        <a href="${pageContext.request.contextPath}/practice/Strings" class="journey-card">
            <div class="journey-icon"><i class="ph-bold ph-text-t"></i></div>
            <div class="path-step">
                <div class="step-dot active"></div>
                <div class="step-dot"></div>
                <div class="step-dot"></div>
                <span style="color: var(--primary-indigo); margin-left:8px;">Easy Level</span>
            </div>
            <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 8px;">Strings</h3>
            <p style="color: var(--text-muted); font-size: 0.95rem; margin-bottom: 32px;">Parsing &amp; logic</p>
            <div class="progress-bar-container" style="height: 10px; border-radius: 5px;">
                <div class="progress-bar-fill" style="width: ${topicProgress['Strings']}%; border-radius: 5px;"></div>
            </div>
            <div style="display:flex; justify-content: space-between; width: 100%; margin-top: 12px; font-weight: 800; font-size: 0.8rem;">
                <span style="color: var(--text-muted);">Mastery</span>
                <span>${topicProgress['Strings']}%</span>
            </div>
        </a>


        <c:forEach var="topic" items="${topics}">
            <a href="${pageContext.request.contextPath}/practice/${topic.name}" class="journey-card">
                <div class="journey-icon">
                    <i class="ph-bold ${topic.icon}"></i>
                </div>
                <div class="path-step">
                    <div class="step-dot active"></div>
                    <div class="step-dot"></div>
                    <div class="step-dot"></div>
                    <span style="color: var(--practice-indigo); margin-left:8px;">Easy Level</span>
                </div>
                <h3>${topic.name}</h3>
                <p>${topic.description}</p>
                
                <div class="progress-info">
                    <div class="progress-bar-container">
                        <div class="progress-bar-fill" style="width: ${topic.progress}%"></div>
                    </div>
                    <div class="progress-meta">
                        <span>Mastery</span>
                        <span style="color: var(--practice-indigo);">${topic.progress}%</span>
                    </div>
                </div>
            </a>
        </c:forEach>

    </div>

    <!-- AI Recommendation Section -->
    <div class="ai-widget">
        <div class="ai-content">
            <h2>Smart Recommendations</h2>
            <p>Our AI analyzes your submission history to detect patterns in your mistakes. We currently suggest focusing on <strong>Dynamic Programming</strong> to bridge your complexity analysis gap.</p>
            
            <div class="rec-grid">
                <c:forEach var="prob" items="${recommendations}">
                    <a href="${pageContext.request.contextPath}/problem/${prob.id}" class="rec-card">
                        <span class="name">${prob.name}</span>
                        <span class="difficulty">Rating: ${prob.difficultyRating}</span>
                    </a>
                </c:forEach>
                <c:if test="${empty recommendations}">
                    <div style="color: var(--text-muted); font-style: italic;">Complete more problems to see personalized suggestions!</div>
                </c:if>
            </div>
        </div>
        <div class="ai-avatar"><i class="ph-bold ph-robot"></i></div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
