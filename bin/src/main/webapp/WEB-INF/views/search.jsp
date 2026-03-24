<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Search Results" />
    <jsp:param name="activePage" value="" />
</jsp:include>

<div class="container" style="padding:28px 24px;">
    <div class="page-title animate-fade-in-up">
        <h1>&#128270; Search Results</h1>
        <p>Showing results for "<strong>${query}</strong>"</p>
    </div>

    <div class="card animate-fade-in-up">
        <c:forEach var="user" items="${users}">
            <div class="search-result-item">
                <div class="profile-avatar" style="width:48px;height:48px;font-size:1.2rem;border-radius:var(--radius-md);background:linear-gradient(135deg,${user.rankColor},${user.rankColor}DD);">
                    ${user.handle.substring(0, 1).toUpperCase()}
                </div>
                <div style="flex:1;">
                    <a href="${pageContext.request.contextPath}/profile/${user.handle}" 
                       style="font-weight:700;font-size:0.95rem;color:${user.rankColor};">
                        ${user.handle}
                    </a>
                    <div style="font-size:0.82rem;color:var(--text-muted);">
                        ${user.rankTitle} | Rating: ${user.rating}
                        <c:if test="${not empty user.country}"> | ${user.country}</c:if>
                    </div>
                </div>
                <span class="rating-value" style="color:${user.rankColor};">${user.rating}</span>
            </div>
        </c:forEach>

        <c:if test="${empty users}">
            <div class="no-data">
                <div class="no-data-icon">&#128270;</div>
                <h3>No Users Found</h3>
                <p>Try a different search term.</p>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
