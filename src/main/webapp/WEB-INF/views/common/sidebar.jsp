<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- Sidebar -->
<aside class="sidebar">

    <!-- Upcoming Contests -->
    <div class="card animate-fade-in-up">
        <div class="card-header">
            <h3>
                <span class="card-icon" style="background:rgba(247,183,49,0.1);color:#D4960A;">&#9200;</span>
                Pay Attention
            </h3>
        </div>
        <c:forEach var="contest" items="${upcomingContests}">
            <div class="contest-countdown">
                <a href="${pageContext.request.contextPath}/contests/${contest.id}" class="contest-name">
                    ${contest.name}
                </a>
                <div class="countdown-timer" data-countdown="${contest.startTime}">
                    <div class="countdown-unit">
                        <span class="number">--</span>
                        <span class="label">Days</span>
                    </div>
                    <div class="countdown-unit">
                        <span class="number">--</span>
                        <span class="label">Hours</span>
                    </div>
                    <div class="countdown-unit">
                        <span class="number">--</span>
                        <span class="label">Min</span>
                    </div>
                    <div class="countdown-unit">
                        <span class="number">--</span>
                        <span class="label">Sec</span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/contests/${contest.id}" class="contest-register-btn">
                    &#9654; Register
                </a>
            </div>
        </c:forEach>
        <c:if test="${empty upcomingContests}">
            <div class="card-body">
                <p style="color:var(--text-muted);font-size:0.85rem;">No upcoming contests at the moment.</p>
            </div>
        </c:if>
    </div>

    <!-- Top Rated -->
    <div class="card animate-fade-in-up">
        <div class="card-header">
            <h3>
                <span class="card-icon" style="background:rgba(255,107,107,0.1);color:#E84545;">&#9733;</span>
                Top Rated
            </h3>
            <a href="${pageContext.request.contextPath}/rating" class="btn btn-sm btn-outline">View All</a>
        </div>
        <div class="card-body stagger-children">
            <c:forEach var="user" items="${topRated}" varStatus="status">
                <div class="top-rated-item">
                    <span class="top-rated-rank">#${status.index + 1}</span>
                    <a href="${pageContext.request.contextPath}/profile/${user.handle}" 
                       class="top-rated-handle" style="color:${user.rankColor}">
                        ${user.handle}
                    </a>
                    <span class="top-rated-rating" style="color:${user.rankColor}">
                        ${user.rating}
                    </span>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Find User -->
    <div class="card animate-fade-in-up">
        <div class="card-header">
            <h3>
                <span class="card-icon" style="background:rgba(0,184,148,0.1);color:#00A885;">&#128270;</span>
                Find User
            </h3>
        </div>
        <div class="card-body">
            <input type="text" id="findUserInput" class="find-user-input" 
                   placeholder="Enter handle and press Enter...">
        </div>
    </div>
</aside>
