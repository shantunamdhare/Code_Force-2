<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Register" />
    <jsp:param name="activePage" value="" />
</jsp:include>

<div class="auth-container">
    <div class="auth-card animate-fade-in-up" style="max-width:520px;">
        <div class="auth-header">
            <h1>&#128640; Join CodeForce</h1>
            <p>Create your account and start competing</p>
        </div>
        <div class="auth-body">
            <c:if test="${not empty error}">
                <div class="error-message">
                    &#9888; ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label class="form-label">Handle (Username) *</label>
                    <input type="text" name="handle" class="form-control" placeholder="Choose a unique handle" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label">Email *</label>
                    <input type="email" name="email" class="form-control" placeholder="your@email.com" required>
                </div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
                    <div class="form-group">
                        <label class="form-label">Password *</label>
                        <input type="password" name="password" class="form-control" placeholder="Min 6 characters" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirm Password *</label>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Re-enter password" required>
                    </div>
                </div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <input type="text" name="firstName" class="form-control" placeholder="John">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <input type="text" name="lastName" class="form-control" placeholder="Doe">
                    </div>
                </div>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
                    <div class="form-group">
                        <label class="form-label">Country</label>
                        <input type="text" name="country" class="form-control" placeholder="e.g. India">
                    </div>
                    <div class="form-group">
                        <label class="form-label">City</label>
                        <input type="text" name="city" class="form-control" placeholder="e.g. Mumbai">
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Organization</label>
                    <input type="text" name="organization" class="form-control" placeholder="e.g. MIT, Google">
                </div>
                <button type="submit" class="btn btn-secondary btn-lg" style="width:100%;">
                    Create Account &#128640;
                </button>
            </form>
        </div>
        <div class="auth-footer">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
