<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Practice" />
    <jsp:param name="activePage" value="practice" />
</jsp:include>

<style>
    .learning-path-header {
        background: linear-gradient(135deg, var(--primary-indigo), var(--primary-purple));
        color: white;
        padding: 60px 40px;
        border-radius: 40px;
        margin-bottom: 48px;
        position: relative;
        overflow: hidden;
    }

    .learning-path-header::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 400px;
        height: 400px;
        background: rgba(255,255,255,0.1);
        border-radius: 50%;
    }

    .topic-journey-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 32px;
    }

    .journey-card {
        background: white;
        border-radius: 32px;
        padding: 40px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(0,0,0,0.02);
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        text-decoration: none;
        color: inherit;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .journey-card:hover { transform: translateY(-10px); background: #fafafa; }

    .journey-icon {
        width: 80px;
        height: 80px;
        border-radius: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        margin-bottom: 24px;
        background: #F8FAFC;
        color: var(--primary-indigo);
    }

    .path-step {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 0.7rem;
        font-weight: 800;
        text-transform: uppercase;
        margin-bottom: 12px;
    }

    .step-dot { width: 8px; height: 8px; border-radius: 50%; background: #E2E8F0; }
    .step-dot.active { background: var(--primary-indigo); box-shadow: 0 0 10px var(--primary-indigo); }
</style>

<div class="main-layout">
    <div class="learning-path-header">
        <h1 style="font-size: 3rem; font-weight: 800; margin-bottom: 16px;">Guided Learning Paths</h1>
        <p style="font-size: 1.25rem; opacity: 0.9; max-width: 600px;">
            Master competitive programming through our structured CURRICULUM. No more random problems—follow a logical progression.
        </p>
    </div>

    <div class="topic-journey-grid">

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

    </div>

    <div class="widget-modern" style="margin-top: 60px; background: #F8FAFC; border-radius: 40px; padding: 60px; display: flex; align-items: center; gap: 60px;">
        <div style="flex: 1;">
            <h2 style="font-size: 2.25rem; font-weight: 800; margin-bottom: 24px;">Smart Recommendations</h2>
            <p style="color: var(--text-slate); font-size: 1.1rem; margin-bottom: 32px; line-height: 1.6;">
                Our AI analyzes your submission history to detect patterns in your mistakes. We currently suggest focusing on <strong>Dynamic Programming</strong> to bridge your complexity analysis gap.
            </p>
            <div style="display: flex; gap: 16px;">
                <c:forEach var="prob" items="${recommendations}">
                    <a href="${pageContext.request.contextPath}/problem/${prob.id}" class="card" style="padding: 16px; min-width: 180px; text-decoration: none; border-left: 4px solid var(--primary-purple);">
                        <div style="font-weight: 800; font-size: 0.9rem; color: var(--text-dark);">${prob.name}</div>
                        <div style="font-size: 0.75rem; color: var(--primary-purple); margin-top: 4px;">Rating: ${prob.difficultyRating}</div>
                    </a>
                </c:forEach>
            </div>
        </div>
        <div style="width: 300px; height: 300px; background: white; border-radius: 32px; box-shadow: var(--card-shadow); display: flex; align-items: center; justify-content: center; font-size: 8rem;">
            🤖
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
