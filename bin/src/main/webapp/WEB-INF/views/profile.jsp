<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="${profileUser.handle} - Profile" />
    <jsp:param name="activePage" value="profile" />
</jsp:include>

<div class="animate-up">
    <!-- Public Profile Header -->
    <header style="margin-bottom: 2.5rem; display: flex; align-items: center; gap: 2rem; background: white; padding: 2.5rem; border-radius: var(--borderRadius-lg); border: 1px solid var(--gray-100); box-shadow: var(--shadow-soft);">
        <div style="width: 120px; height: 120px; background: linear-gradient(135deg, ${profileUser.getRankColor()}, ${profileUser.getRankColor()}88); border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 3rem; font-weight: 800; color: white; transform: rotate(-3deg);">
            ${profileUser.handle.substring(0, 1).toUpperCase()}
        </div>
        <div style="flex: 1;">
            <div style="display: flex; align-items: center; gap: 15px;">
                <h1 style="font-size: 2.5rem; font-weight: 900; color: ${profileUser.getRankColor()}; letter-spacing: -0.04em;">${profileUser.handle}</h1>
                <span class="badge" style="background: ${profileUser.getRankColor()}15; color: ${profileUser.getRankColor()}; font-size: 0.875rem; padding: 6px 14px;">${profileUser.getRankTitle()}</span>
            </div>
            <p style="color: var(--text-secondary); margin-top: 8px; font-size: 1.125rem;">${profileUser.firstName} ${profileUser.lastName}</p>
            <div style="display: flex; gap: 20px; align-items: center; margin-top: 15px; color: var(--text-tertiary); font-size: 0.875rem;">
                <span><i class="ph ph-map-pin"></i> ${profileUser.city}${not empty profileUser.country ? ', ' : ''}${profileUser.country}</span>
                <span><i class="ph ph-buildings"></i> ${profileUser.organization}</span>
                <span><i class="ph ph-calendar"></i> Joined <fmt:parseDate value="${profileUser.registrationTime}" pattern="yyyy-MM-dd'T'HH:mm" var="pDate" type="both"/><fmt:formatDate value="${pDate}" pattern="MMM yyyy"/></span>
            </div>
        </div>
        <c:if test="${currentUser.handle eq profileUser.handle}">
             <a href="${pageContext.request.contextPath}/analytics" class="btn btn-primary">
                View My Analytics <i class="ph ph-chart-line-up"></i>
             </a>
        </c:if>
    </header>

    <div style="display: grid; grid-template-columns: 1fr 320px; gap: 2.5rem;">
        
        <!-- Submission History Table -->
        <div>
            <h2 style="font-size: 1.25rem; font-weight: 800; margin-bottom: 1.5rem;">Recent Activity</h2>
            <div class="glass-card" style="overflow: hidden;">
                <table class="modern-table">
                    <thead>
                        <tr>
                            <th># ID</th>
                            <th>Problem</th>
                            <th>Verdict</th>
                            <th>Time</th>
                            <th>Memory</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sub" items="${submissions}">
                            <tr>
                                <td style="font-family: monospace; font-size: 0.75rem; color: var(--text-tertiary);">${sub.id}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/problem/${sub.problem.id}" style="text-decoration:none; font-weight:700; color: var(--primary);">
                                        ${sub.problem.fullId} - ${sub.problem.name}
                                    </a>
                                </td>
                                <td>
                                    <span class="badge" style="background: ${sub.getVerdictColor()}15; color: ${sub.getVerdictColor()}">
                                        ${sub.getVerdictShort()}
                                    </span>
                                </td>
                                <td style="font-family: monospace; font-size: 0.8125rem;">${sub.timeConsumedMs} ms</td>
                                <td style="font-family: monospace; font-size: 0.8125rem;">${sub.memoryConsumedKb} KB</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Side Stats -->
        <aside style="display: flex; flex-direction: column; gap: 1.5rem;">
            <div class="glass-card" style="padding: 1.5rem;">
                <h3 style="font-size: 0.875rem; font-weight: 700; color: var(--text-tertiary); text-transform: uppercase; margin-bottom: 1.25rem;">Rating Progress</h3>
                <div style="text-align: center; padding: 1rem 0;">
                    <p style="font-size: 2.5rem; font-weight: 900; color: ${profileUser.getRankColor()};">${profileUser.rating}</p>
                    <p style="font-size: 0.8125rem; color: var(--text-tertiary);">Max Rating: ${profileUser.maxRating}</p>
                </div>
            </div>

            <div class="glass-card" style="padding: 1.5rem;">
                <h3 style="font-size: 0.875rem; font-weight: 700; color: var(--text-tertiary); text-transform: uppercase; margin-bottom: 1.25rem;">Quick Stats</h3>
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <div style="display: flex; justify-content: space-between; font-size: 0.875rem;">
                        <span>Submissions</span>
                        <span style="font-weight: 700;">${totalSubmissions}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.875rem;">
                        <span>Solved</span>
                        <span style="font-weight: 700; color: var(--success);">${acceptedSubmissions}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.875rem;">
                        <span>Contribution</span>
                        <span style="font-weight: 700;">+${profileUser.contribution}</span>
                    </div>
                </div>
            </div>
        </aside>

    </div>
</div>

<jsp:include page="common/footer.jsp" />
