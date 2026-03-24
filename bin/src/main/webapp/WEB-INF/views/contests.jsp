<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Contests" />
    <jsp:param name="activePage" value="contests" />
</jsp:include>

<div class="main-layout">
    
    <!-- Left Column: Contest Table -->
    <div>
        <h1 style="font-size: 1.75rem; margin-bottom: 24px; color: var(--text-primary);">Contest Battleground</h1>
        
        <!-- My Registered Contests -->
        <c:if test="${not empty myContests}">
            <h2 style="font-size: 1rem; color: var(--primary-blue); margin-bottom: 12px; display: flex; align-items: center; gap: 8px;">
                <i class="ph ph-check-circle" style="color: var(--primary-blue);"></i> MY REGISTRATIONS
            </h2>
            <div class="card" style="padding: 0; margin-bottom: 32px; border-bottom: none; border: 1px solid rgba(52,152,219,0.3); background: rgba(52,152,219,0.02);">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="background: rgba(52,152,219,0.05);">Official Contest</th>
                            <th style="background: rgba(52,152,219,0.05);">Starts At</th>
                            <th style="background: rgba(52,152,219,0.05);">Status</th>
                            <th style="background: rgba(52,152,219,0.05);">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="contest" items="${myContests}">
                             <tr>
                                <td style="font-weight: 700;">${contest.name}</td>
                                <td>
                                    <fmt:parseDate value="${contest.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="mDate" type="both"/>
                                    <fmt:formatDate value="${mDate}" pattern="MMM dd, HH:mm"/>
                                </td>
                                <td style="color: var(--primary-blue); font-weight: 600; font-size: 0.82rem;">REGISTERED</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/contests/${contest.id}" 
                                       class="btn btn-primary btn-sm">Enter Arena</a>
                                </td>
                             </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <!-- Running Contests -->
        <c:if test="${not empty runningContests}">
            <h2 style="font-size: 1rem; color: var(--primary-coral); margin-bottom: 12px; display: flex; align-items: center; gap: 8px;">
                <span style="width: 10px; height: 10px; background: var(--primary-coral); border-radius: 50%; box-shadow: 0 0 10px rgba(255,107,107,0.5);"></span> RUNNING CONTESTS
            </h2>
            <div class="card" style="padding: 0; margin-bottom: 32px; border-bottom: none;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Contest Name</th>
                            <th>Participants</th>
                            <th>Ending In</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="contest" items="${runningContests}">
                             <tr>
                                <td style="font-weight: 700; color: var(--primary-coral);">${contest.name}</td>
                                <td class="mono">&#128101; ${contest.participantCount}</td>
                                <td class="mono">01:42:55</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/contests/${contest.id}" 
                                       class="btn btn-primary btn-sm">Enter</a>
                                </td>
                             </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <!-- Upcoming Contests -->
        <h2 style="font-size: 1rem; color: var(--text-secondary); margin-bottom: 12px;">REGISTRATION OPEN</h2>
        <div class="card" style="padding: 0; margin-bottom: 32px; border-bottom: none;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Upcoming Contest</th>
                        <th>Starts At</th>
                        <th>Duration</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="contest" items="${upcomingContests}">
                        <tr>
                            <td>
                                <div style="font-weight: 700;">${contest.name}</div>
                                <div style="font-size: 0.72rem; color: var(--text-muted); text-transform: uppercase;">${contest.type}</div>
                            </td>
                            <td>
                                <fmt:parseDate value="${contest.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="uDate" type="both"/>
                                <fmt:formatDate value="${uDate}" pattern="MMM dd, HH:mm"/>
                            </td>
                            <td class="mono">${contest.getFormattedDuration()}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/contests/${contest.id}" 
                                   class="btn btn-outline btn-sm">Register</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Finished Contests -->
        <h2 style="font-size: 1rem; color: var(--text-muted); margin-bottom: 12px;">PAST CONTESTS</h2>
        <div class="card" style="padding: 0; border-bottom: none;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Finished Contest</th>
                        <th>Date</th>
                        <th>Participants</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="contest" items="${finishedContests}">
                        <tr>
                            <td style="font-weight: 500;">${contest.name}</td>
                            <td>
                                <fmt:parseDate value="${contest.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="fDate" type="both"/>
                                <fmt:formatDate value="${fDate}" pattern="MMM dd, yyyy"/>
                            </td>
                            <td class="mono">&#128101; ${contest.participantCount}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/contests/${contest.id}" 
                                   class="btn btn-outline btn-sm" style="font-size: 0.75rem;">Standings</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Right Column: Sidebar -->
    <aside class="sidebar">
        
        <!-- 1v1 Battle Logic -->
        <div class="card" style="background: linear-gradient(135deg, var(--primary-blue), var(--primary-violet)); color: white; border: none;">
            <div class="card-body" style="padding: 24px; text-align: center;">
                <h3 style="font-family: 'Space Grotesk', sans-serif; font-size: 1.5rem; color: white; margin-bottom: 8px;">1v1 DUEL ⚔️</h3>
                <p style="font-size: 0.82rem; opacity: 0.9; margin-bottom: 20px;">Challenge a matched opponent to a real-time coding battle.</p>
                <a href="${pageContext.request.contextPath}/contests/battle" class="btn" style="background: white; color: var(--primary-blue); width: 100%; font-weight: 700;">START BATTLE</a>
            </div>
        </div>

        <!-- Hall of Fame -->
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(255,107,107,0.1);color:var(--primary-coral);">&#9889;</span>Top Authors</h3>
            </div>
            <div class="card-body">
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <div style="display: flex; align-items: center; gap: 10px; font-size: 0.85rem;">
                        <span style="font-weight: 700; color: #FF0000;">tourist</span>
                        <span style="color: var(--text-muted); font-size: 0.72rem; margin-left: auto;">42 contests</span>
                    </div>
                </div>
            </div>
        </div>

    </aside>

</div>

<jsp:include page="common/footer.jsp" />
