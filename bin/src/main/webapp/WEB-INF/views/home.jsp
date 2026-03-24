<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
    <jsp:param name="activePage" value="home" />
</jsp:include>

<div class="main-layout">
    
    <!-- Left Column: Key Content -->
    <div>
        <!-- Welcome Card -->
        <div class="card" style="padding: 24px; margin-bottom: 24px; background: linear-gradient(135deg, white, white, rgba(255, 107, 107, 0.03));">
            <h1 style="font-size: 1.75rem; color: var(--text-primary);">
                <c:choose>
                    <c:when test="${not empty currentUser}">
                        Welcome back, ${currentUser.handle}!
                    </c:when>
                    <c:otherwise>
                        Welcome to CodeForce Pro
                    </c:otherwise>
                </c:choose>
            </h1>
            <p style="color: var(--text-secondary); margin-top: 8px;">Explore the latest algorithmic challenges and compete in our live contests.</p>
        </div>

        <c:if test="${not empty currentUser}">
            <!-- Modern Stats Grid -->
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 28px;">
                <div class="card" style="padding: 16px; text-align: center; background: white; border-top: 4px solid var(--primary-coral);">
                    <p style="font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">Your Rating</p>
                    <p style="font-size: 1.5rem; font-weight: 800; color: ${currentUser.getRankColor()}">${currentUser.rating}</p>
                </div>
                <div class="card" style="padding: 16px; text-align: center; background: white; border-top: 4px solid var(--primary-teal);">
                    <p style="font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">Problems Solved</p>
                    <p style="font-size: 1.5rem; font-weight: 800;">${not empty acceptedSubmissions ? acceptedSubmissions : '0'}</p>
                </div>
                <div class="card" style="padding: 16px; text-align: center; background: white; border-top: 4px solid var(--primary-amber);">
                    <p style="font-size: 0.75rem; text-transform: uppercase; color: var(--text-muted); font-weight: 700;">Global Rank</p>
                    <p style="font-size: 1.5rem; font-weight: 800;">Newbie</p>
                </div>
            </div>
        </c:if>

        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
            <h2 style="font-size: 1.25rem;">Recent Blog Posts</h2>
            <c:if test="${not empty currentUser}">
                <a href="${pageContext.request.contextPath}/blog/new" class="btn btn-primary btn-sm">+ New Post</a>
            </c:if>
        </div>
        <div class="card">
            <c:forEach var="post" items="${posts}">
                <article class="blog-post">
                    <div class="blog-post-header">
                        <a href="#" class="blog-post-title">${post.title}</a>
                        <div class="blog-post-meta">
                            <span class="blog-post-author" style="color:${post.author.getRankColor()}">${post.author.handle}</span>
                            <span>•</span>
                            <span>
                                <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy"/>
                            </span>
                        </div>
                    </div>
                    
                    <div class="blog-post-content">${post.content}</div>

                    <div class="blog-post-footer">
                        <div class="vote-section">
                            <form action="${pageContext.request.contextPath}/blog/upvote/${post.id}" method="post" style="display:inline;">
                                <button type="submit" class="vote-btn"><i class="ph ph-caret-up"></i></button>
                            </form>
                            <span class="vote-score ${post.score < 0 ? 'negative' : ''}">${post.score}</span>
                            <form action="${pageContext.request.contextPath}/blog/downvote/${post.id}" method="post" style="display:inline;">
                                <button type="submit" class="vote-btn downvote"><i class="ph ph-caret-down"></i></button>
                            </form>
                        </div>
                        <a href="#" style="color:var(--primary-teal); font-size: 0.82rem; font-weight: 600;">View Comments (${post.commentCount})</a>
                    </div>
                </article>
            </c:forEach>
        </div>
    </div>

    <!-- Right Column: Info & Widgets -->
    <aside class="sidebar">
        
        <!-- Upcoming Contests -->
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(255,107,107,0.1);color:var(--primary-coral);">&#127942;</span>Upcoming</h3>
            </div>
            <div class="card-body" style="padding:0;">
                <c:forEach var="contest" items="${upcomingContests}">
                    <div class="contest-countdown">
                        <div class="contest-name">${contest.name}</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted);">
                           <fmt:parseDate value="${contest.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="cDate" type="both"/>
                           <fmt:formatDate value="${cDate}" pattern="MMM dd, HH:mm"/>
                        </div>
                        <a href="${pageContext.request.contextPath}/contests/${contest.id}" class="contest-register-btn" style="margin-top: 10px; display: inline-block; text-align: center;">Register</a>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Top Users -->
        <div class="card">
            <div class="card-header">
                <h3><span class="card-icon" style="background:rgba(0,184,148,0.1);color:var(--primary-teal);">&#128101;</span>Top Rated</h3>
            </div>
            <div class="card-body">
                <c:forEach var="user" items="${topRated}" varStatus="status">
                    <div class="top-rated-item">
                        <span class="top-rated-rank">${status.index + 1}</span>
                        <a href="${pageContext.request.contextPath}/profile/${user.handle}" 
                           class="top-rated-handle" style="color:${user.getRankColor()}">
                            ${user.handle}
                        </a>
                        <span class="top-rated-rating">${user.rating}</span>
                    </div>
                </c:forEach>
                <div style="margin-top: 16px; text-align: center;">
                    <a href="${pageContext.request.contextPath}/rating" style="color:var(--primary-coral); font-size: 0.8rem; font-weight: 700;">View Global Ranking</a>
                </div>
            </div>
        </div>

    </aside>

</div>

<jsp:include page="common/footer.jsp" />
