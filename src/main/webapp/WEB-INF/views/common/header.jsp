<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} | CodeForce</title>
    
    <!-- Original Theme Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <!-- Icons -->
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🚀</text></svg>">
</head>
<body>

    <!-- Top Bar -->
    <div class="top-bar">
        <div>
            <a href="${pageContext.request.contextPath}/">CodeForce Pro</a> | 
            <a href="#">Help</a>
        </div>
        <div class="top-bar-auth">
            <c:choose>
                <c:when test="${not empty currentUser}">
                    <span class="user-handle" style="color:${currentUser.rankColor}">${currentUser.handle}</span> |
                    <a href="${pageContext.request.contextPath}/profile/${currentUser.handle}">Profile</a> |
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">Enter</a> |
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Main Navbar -->
    <nav class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <div class="brand-icon">&#9876;</div>
                <span>CodeForce</span>
            </a>

            <ul class="navbar-nav" id="navbarNav">
                <li><a href="${pageContext.request.contextPath}/" class="${param.activePage == 'home' ? 'active' : ''}">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/problemset" class="${param.activePage == 'problemset' ? 'active' : ''}">Practice</a></li>
                <li><a href="${pageContext.request.contextPath}/contests" class="${param.activePage == 'contests' ? 'active' : ''}">Contests</a></li>
                <c:if test="${not empty currentUser}">
                    <li><a href="${pageContext.request.contextPath}/analytics" class="${param.activePage == 'analytics' ? 'active' : ''}">Analytics</a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/rating" class="${param.activePage == 'rating' ? 'active' : ''}">Rating</a></li>
            </ul>

            <div class="navbar-search">
                <input type="text" id="findUserInput" placeholder="Find user...">
                <button onclick="findUser()"><i class="ph ph-magnifying-glass"></i></button>
            </div>
            
            <button class="navbar-toggle" id="navbarToggle">
                <span>&#2630;</span>
            </button>
        </div>
    </nav>

    <div class="container">
        <!-- Start of page content -->
