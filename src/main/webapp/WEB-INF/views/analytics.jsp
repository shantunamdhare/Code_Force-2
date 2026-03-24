<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Performance Analytics" />
    <jsp:param name="activePage" value="analytics" />
</jsp:include>

<!-- Analytics Logic Calculations -->
<c:set var="waCount" value="0"/>
<c:set var="tleCount" value="0"/>
<c:set var="reCount" value="0"/>
<c:forEach var="s" items="${submissions}">
    <c:if test="${s.verdict == 'Wrong Answer'}"><c:set var="waCount" value="${waCount + 1}"/></c:if>
    <c:if test="${s.verdict == 'Time Limit Exceeded'}"><c:set var="tleCount" value="${tleCount + 1}"/></c:if>
    <c:if test="${s.verdict == 'Runtime Error'}"><c:set var="reCount" value="${reCount + 1}"/></c:if>
</c:forEach>
<c:set var="accuracy" value="${totalSubmissions > 0 ? (acceptedSubmissions * 100 / totalSubmissions) : 0}"/>

<div class="main-layout">
    
    <!-- Left Column: Deep Insights -->
    <div>
        <h1 style="font-size: 1.75rem; margin-bottom: 24px; color: var(--text-primary);">&#128202; Performance Dashboard</h1>
        
        <!-- Summary Dashboard Cards -->
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 24px;">
            <div class="card" style="padding: 16px; text-align: center; border-bottom: 4px solid var(--primary-teal);">
                <p style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">ACURACY</p>
                <p style="font-size: 1.25rem; font-weight: 800; color: var(--primary-teal);"><fmt:formatNumber value="${accuracy}" maxFractionDigits="1"/>%</p>
            </div>
            <div class="card" style="padding: 16px; text-align: center; border-bottom: 4px solid var(--primary-coral);">
                <p style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">WRONG ANSWERS</p>
                <p style="font-size: 1.25rem; font-weight: 800; color: var(--primary-coral);">${waCount}</p>
            </div>
            <div class="card" style="padding: 16px; text-align: center; border-bottom: 4px solid var(--primary-amber);">
                <p style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">TIME LIMITS</p>
                <p style="font-size: 1.25rem; font-weight: 800; color: var(--primary-amber);">${tleCount}</p>
            </div>
            <div class="card" style="padding: 16px; text-align: center; border-bottom: 4px solid var(--primary-violet);">
                <p style="font-size: 0.72rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">TOTAL ATTEMPTS</p>
                <p style="font-size: 1.25rem; font-weight: 800; color: var(--primary-violet);">${totalSubmissions}</p>
            </div>
        </div>

        <!-- Failure Analysis Section -->
        <div class="card" style="padding: 32px; margin-bottom: 32px;">
            <h2 style="font-size: 1.15rem; margin-bottom: 20px; border-left: 4px solid var(--primary-coral); padding-left: 12px;">"Why You Failed" SQL Analysis</h2>
            <div style="display: flex; flex-direction: column; gap: 16px;">
                <c:choose>
                    <c:when test="${waCount > tleCount}">
                        <div style="background: rgba(255, 107, 107, 0.05); border: 1.5px solid rgba(255, 107, 107, 0.15); border-radius: var(--radius-md); padding: 20px;">
                            <h4 style="color: var(--primary-coral); font-size: 1rem; margin-bottom: 8px;">Logical Consistency Issues</h4>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6;">Your SQL submission history shows a high 'Wrong Answer' rate. This likely means you are not considering all hidden test cases or logic constraints.</p>
                        </div>
                    </c:when>
                    <c:when test="${tleCount > 0}">
                        <div style="background: rgba(59, 130, 246, 0.05); border: 1.5px solid rgba(59, 130, 246, 0.15); border-radius: var(--radius-md); padding: 20px;">
                            <h4 style="color: var(--primary-blue); font-size: 1rem; margin-bottom: 8px;">Efficiency Hotspots</h4>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6;">Multiple Time Limit Exceeded (TLE) entries found. Consider using Greedy or Segment trees to optimize your O(N²) solutions.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="background: rgba(0, 184, 148, 0.05); border: 1.5px solid rgba(0, 184, 148, 0.15); border-radius: var(--radius-md); padding: 20px;">
                            <h4 style="color: var(--primary-teal); font-size: 1rem; margin-bottom: 8px;">Excellent Accuracy</h4>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); line-height: 1.6;">Great job! You have very few failures in your history. Challenge yourself with harder problems.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Topic Mastery -->
        <h2 style="font-size: 1.15rem; margin-bottom: 20px; border-left: 4px solid var(--primary-teal); padding-left: 12px;">Topic Progress Breakdown</h2>
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
             <div class="card" style="padding: 24px;">
                <div style="display:flex; justify-content:space-between; margin-bottom:12px;">
                    <span style="font-weight:700;">Arrays & Strings</span>
                    <span style="color:var(--primary-teal); font-weight:800;">88% Strength</span>
                </div>
                <div style="height:8px; background:var(--bg-cream); border-radius:4px; overflow:hidden;">
                    <div style="width:88%; height:100%; background:var(--primary-teal);"></div>
                </div>
             </div>
             <div class="card" style="padding: 24px;">
                <div style="display:flex; justify-content:space-between; margin-bottom:12px;">
                    <span style="font-weight:700;">Dynamic Programming</span>
                    <span style="color:var(--primary-coral); font-weight:800;">22% Strength</span>
                </div>
                <div style="height:8px; background:var(--bg-cream); border-radius:4px; overflow:hidden;">
                    <div style="width:22%; height:100%; background:var(--primary-coral);"></div>
                </div>
             </div>
        </div>
    </div>

    <!-- Right Column: Context Widgets -->
    <aside class="sidebar">
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(255,107,107,0.1);color:var(--primary-coral);">&#128337;</span>Efficiency</h3>
            </div>
            <div class="card-body">
                <p style="font-size: 0.8125rem; color: var(--text-muted);">Your average solution speed and memory usage trend per submission.</p>
                <div style="margin-top: 20px; padding: 16px; border-radius: 8px; background: var(--bg-cream); text-align: center;">
                    <span style="font-family: 'JetBrains Mono', monospace; font-size: 1.25rem; font-weight: 800;">242 ms</span>
                    <p style="font-size: 0.65rem; color: var(--text-muted); text-transform: uppercase; margin-top: 4px;">AVG EXECUTION TIME</p>
                </div>
            </div>
        </div>
    </aside>

</div>

<jsp:include page="common/footer.jsp" />
