<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Global Ranking" />
    <jsp:param name="activePage" value="rating" />
</jsp:include>

<div class="animate-up">
    <!-- Ranking Header -->
    <header style="margin-bottom: 2.5rem;">
        <h1 style="font-size: 2.5rem; font-weight: 900; letter-spacing: -0.04em;">Global Ranks 🏆</h1>
        <p style="color: var(--text-tertiary); font-size: 1.125rem;">The top competitive programmers on the platform.</p>
    </header>

    <div class="glass-card" style="padding: 1.5rem; overflow: hidden;">
        <table class="modern-table">
            <thead>
                <tr>
                    <th style="width: 60px;"># Rank</th>
                    <th>User Handle</th>
                    <th>Region</th>
                    <th>Current Rating</th>
                    <th>Max Rating</th>
                    <th>Rank Title</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}" varStatus="status">
                    <tr class="${not empty currentUser && currentUser.handle == user.handle ? 'user-row' : ''}">
                        <td style="font-weight: 800; color: var(--text-tertiary);">${status.index + 1}</td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <div style="width: 28px; height: 28px; background: ${user.getRankColor()}15; color: ${user.getRankColor()}; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.75rem;">
                                    ${user.handle.substring(0, 1).toUpperCase()}
                                </div>
                                <a href="${pageContext.request.contextPath}/profile/${user.handle}" 
                                   style="text-decoration: none; font-weight: 800; color: ${user.getRankColor()}; font-size: 0.9375rem;">
                                    ${user.handle}
                                </a>
                            </div>
                        </td>
                        <td style="color: var(--text-tertiary); font-size: 0.8125rem;">
                            <c:out value="${not empty user.country ? user.country : 'Unknown'}" />
                        </td>
                        <td style="font-weight: 800; color: ${user.getRankColor()};">${user.rating}</td>
                        <td style="color: var(--text-tertiary); font-size: 0.8125rem;">${user.maxRating}</td>
                        <td>
                            <span class="badge" style="background: ${user.getRankColor()}15; color: ${user.getRankColor()}">
                                ${user.getRankTitle()}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty users}">
            <div style="padding: 4rem; text-align: center; color: var(--text-tertiary);">
                <i class="ph ph-mask-sad" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                <p>No rated users found. Be the first to join a contest!</p>
            </div>
        </c:if>
    </div>

    <!-- Stats summary section -->
    <div style="margin-top: 3rem; display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem;">
        <div class="glass-card" style="padding: 1.5rem; text-align: center;">
            <p style="font-size: 0.75rem; color: var(--text-tertiary); text-transform: uppercase;">Total Active Users</p>
            <p style="font-size: 1.5rem; font-weight: 800;">${users.size()}</p>
        </div>
        <div class="glass-card" style="padding: 1.5rem; text-align: center;">
            <p style="font-size: 0.75rem; color: var(--text-tertiary); text-transform: uppercase;">Avg Rating</p>
            <p style="font-size: 1.5rem; font-weight: 800;">1422</p>
        </div>
        <div class="glass-card" style="padding: 1.5rem; text-align: center;">
            <p style="font-size: 0.75rem; color: var(--text-tertiary); text-transform: uppercase;">Next Rank Goal</p>
            <p style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">2000+</p>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
