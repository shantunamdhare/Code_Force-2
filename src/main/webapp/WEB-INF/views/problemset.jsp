<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Problemset" />
    <jsp:param name="activePage" value="problemset" />
</jsp:include>

<div class="main-layout">
    
    <!-- Left Column: Problems Table -->
    <div>
        <h1 style="font-size: 1.75rem; margin-bottom: 24px; color: var(--text-primary);">
            <c:choose>
                <c:when test="${not empty selectedTag}">${selectedTag} Problems</c:when>
                <c:otherwise>Browse Problemset</c:otherwise>
            </c:choose>
        </h1>
        
        <div class="card" style="padding: 0; overflow: hidden; border-bottom: none;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th style="width: 80px;"># ID</th>
                        <th>Problem Name</th>
                        <th>Rating</th>
                        <th>Solved</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="problem" items="${problems}">
                        <tr>
                            <td class="mono" style="font-weight:700;">${problem.fullId}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" style="font-weight:600; color:var(--primary-coral);">
                                    ${problem.name}
                                </a>
                                <div style="display: flex; gap: 8px; margin-top: 6px;">
                                    <c:forEach var="tag" items="${problem.tags}">
                                        <span class="tag tag-amber">${tag.name}</span>
                                    </c:forEach>
                                </div>
                            </td>
                            <td>
                                <span style="font-weight: 700; color:${problem.getDifficultyColor()}">${problem.difficultyRating}</span>
                            </td>
                            <td class="mono" style="font-size: 0.82rem; color: var(--text-muted);">&#128101; ${problem.solvedCount}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/problem/${problem.id}" 
                                   class="btn btn-outline btn-sm">Solve</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty problems}">
                <div style="padding: 40px; text-align: center; color: var(--text-muted);">
                    <p>No problems found for "${selectedTag}".</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Right Column: Filters & Tags -->
    <aside class="sidebar">
        
        <!-- Filter Card -->
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(59,130,246,0.1);color:var(--primary-blue);">&#128269;</span>Search</h3>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/problemset" method="get">
                    <div class="form-group" style="margin-bottom: 12px;">
                        <input type="text" name="tag" class="find-user-input" placeholder="Search by tag..." value="${selectedTag}">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Apply Filters</button>
                    <a href="${pageContext.request.contextPath}/problemset" class="btn btn-outline btn-sm" style="width: 100%; margin-top: 8px;">Reset All</a>
                </form>
            </div>
        </div>

        <!-- Populat Tags Card -->
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(247,183,49,0.1);color:var(--primary-amber);">&#127991;</span>Popular Tags</h3>
            </div>
            <div class="card-body" style="display: flex; flex-wrap: wrap; gap: 8px;">
                <c:set var="tagNames" value="${['Math', 'Implementation', 'DP', 'Greedy', 'Data Structures', 'Graphs', 'Strings', 'Sorting', 'Geometry']}" />
                <c:forEach var="tagName" items="${tagNames}">
                    <a href="${pageContext.request.contextPath}/problemset?tag=${tagName}" 
                       class="tag ${selectedTag == tagName ? 'tag-coral' : 'tag-amber'}">
                       ${tagName}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Rating Filter -->
        <div class="card" style="padding: 16px; background: rgba(0, 184, 148, 0.04);">
            <h3 style="font-size: 0.875rem; color: var(--text-secondary); margin-bottom: 12px;">Difficulty Ranges</h3>
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <a href="${pageContext.request.contextPath}/problemset?minDiff=0&maxDiff=1200" style="color:var(--primary-teal); font-size: 0.8rem; font-weight: 700;">Easy (< 1200)</a>
                <a href="${pageContext.request.contextPath}/problemset?minDiff=1201&maxDiff=1800" style="color:var(--primary-teal); font-size: 0.8rem; font-weight: 700;">Medium (1200-1800)</a>
                <a href="${pageContext.request.contextPath}/problemset?minDiff=1801&maxDiff=3500" style="color:var(--primary-teal); font-size: 0.8rem; font-weight: 700;">Hard (> 1800)</a>
            </div>
        </div>

    </aside>

</div>

<jsp:include page="common/footer.jsp" />
