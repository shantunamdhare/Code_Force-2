<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Login" />
    <jsp:param name="activePage" value="" />
</jsp:include>

<div class="auth-container">
    <div class="auth-card animate-fade-in-up">
        <div class="auth-header">
            <h1>&#128274; Welcome Back</h1>
            <p>Sign in to your CodeForce account</p>
        </div>
        <div class="auth-body">
            <c:if test="${not empty error}">
                <div class="error-message">
                    &#9888; ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="form-label">Handle / Username</label>
                    <input type="text" name="handle" class="form-control" placeholder="Enter your handle" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-lg" style="width:100%;">
                    Sign In &#10140;
                </button>
            </form>
        </div>
        <div class="auth-footer">
            Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
