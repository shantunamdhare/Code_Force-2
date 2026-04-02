<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Tester Arena Access" />
    <jsp:param name="activePage" value="tester" />
</jsp:include>

<style>
    body {
        background: radial-gradient(at 100% 0%, rgba(255, 107, 107, 0.05) 0, transparent 50%),
                    radial-gradient(at 0% 100%, rgba(78, 205, 196, 0.05) 0, transparent 50%),
                    #FFF8F0 !important;
        position: relative;
    }

    .tester-auth-container {
        min-height: calc(100vh - 120px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
        position: relative;
        z-index: 1;
    }

    .tester-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 32px;
        width: 100%;
        max-width: 1000px;
        display: flex;
        box-shadow: 
            0 20px 60px rgba(0,0,0,0.05),
            0 0 1px rgba(0,0,0,0.1);
        overflow: hidden;
        border: 1px solid rgba(255,255,255,0.8);
        transition: transform 0.3s ease;
    }

    .tester-card:hover {
        transform: translateY(-5px);
    }

    /* Left Side: Info & Branding */
    .tester-hero-side {
        flex: 1;
        background: linear-gradient(135deg, #1E293B 0%, #0F172A 100%);
        padding: 60px;
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }

    .tester-hero-side::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, rgba(78, 205, 196, 0.1) 0%, transparent 70%);
        pointer-events: none;
    }

    .tester-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(78, 205, 196, 0.15);
        color: #4ECDC4;
        padding: 8px 16px;
        border-radius: 100px;
        font-weight: 800;
        font-size: 0.7rem;
        letter-spacing: 1px;
        margin-bottom: 24px;
        text-transform: uppercase;
        border: 1px solid rgba(78, 205, 196, 0.2);
    }

    .tester-hero-side h1 {
        font-size: 2.8rem;
        font-weight: 800;
        line-height: 1.1;
        margin-bottom: 20px;
        letter-spacing: -1.5px;
    }

    .tester-hero-side h1 span {
        color: #4ECDC4;
    }

    .tester-hero-side p {
        font-size: 1.05rem;
        color: rgba(255,255,255,0.6);
        line-height: 1.6;
        margin-bottom: 40px;
    }

    .feature-check {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .feature-check-item {
        display: flex;
        align-items: center;
        gap: 12px;
        font-weight: 600;
        font-size: 0.95rem;
        color: rgba(255,255,255,0.85);
    }

    .feature-check-item i {
        color: #4ECDC4;
        font-size: 1.25rem;
    }

    /* Right Side: Login Form */
    .tester-login-side {
        flex: 0.8;
        padding: 60px;
        background: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .login-header {
        margin-bottom: 32px;
    }

    .login-header h2 {
        font-size: 1.75rem;
        color: #1E293B;
        margin-bottom: 8px;
    }

    .login-header p {
        color: #64748B;
        font-size: 0.95rem;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-label {
        display: block;
        font-weight: 700;
        font-size: 0.85rem;
        color: #64748B;
        margin-bottom: 8px;
    }

    .form-control {
        width: 100%;
        padding: 14px 18px;
        border: 2px solid #F1F5F9;
        border-radius: 12px;
        background: #F8FAFC;
        font-size: 1rem;
        transition: all 0.2s;
        outline: none;
    }

    .form-control:focus {
        border-color: #FF6B6B;
        background: white;
        box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.1);
    }

    .btn-tester-login {
        width: 100%;
        background: #FF6B6B;
        color: white;
        border: none;
        padding: 16px;
        border-radius: 12px;
        font-weight: 700;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s;
        display: flex;
        align-items:center;
        justify-content: center;
        gap: 10px;
        margin-top: 10px;
        box-shadow: 0 10px 20px rgba(255, 107, 107, 0.2);
    }

    .btn-tester-login:hover {
        background: #FF5252;
        transform: translateY(-2px);
        box-shadow: 0 15px 30px rgba(255, 107, 107, 0.3);
    }

    .error-msg {
        background: #FEF2F2;
        color: #DC2626;
        padding: 12px 16px;
        border-radius: 12px;
        margin-bottom: 24px;
        font-size: 0.9rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
        border: 1px solid rgba(220, 38, 38, 0.1);
    }

    .demo-creds {
        margin-top: 32px;
        padding-top: 24px;
        border-top: 1px solid #F1F5F9;
        text-align: center;
        font-size: 0.85rem;
        color: #94A3B8;
    }

    .demo-creds code {
        background: #F1F5F9;
        padding: 2px 6px;
        border-radius: 4px;
        color: #FF6B6B;
        font-weight: 700;
    }

    @media (max-width: 900px) {
        .tester-card { flex-direction: column; max-width: 500px; }
        .tester-hero-side { padding: 40px; }
        .tester-login-side { padding: 40px; }
        .tester-hero-side h1 { font-size: 2rem; }
    }
</style>

<div class="tester-auth-container animate-fade-in">
    <div class="tester-card">
        <!-- Left Side -->
        <div class="tester-hero-side">
            <div class="tester-badge">
                <i class="ph-bold ph-shield-check"></i> QA Environment
            </div>
            <h1>The Arena for<br><span>Precision.</span></h1>
            <p>Access our high-performance testing environment. Validate complex algorithms and ensure platform stability.</p>
            
            <div class="feature-check">
                <div class="feature-check-item">
                    <i class="ph-bold ph-check-circle"></i>
                    Solve & Validate Problems
                </div>
                <div class="feature-check-item">
                    <i class="ph-bold ph-check-circle"></i>
                    Detailed Bug Tracking
                </div>
                <div class="feature-check-item">
                    <i class="ph-bold ph-check-circle"></i>
                    Performance Analytics
                </div>
            </div>
        </div>

        <!-- Right Side -->
        <div class="tester-login-side">
            <div class="login-header">
                <h2>Tester Access</h2>
                <p>Sign in to your authorized tester account</p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-msg">
                    <i class="ph-bold ph-warning-circle"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/tester/login" method="post">
                <div class="form-group">
                    <label class="form-label">Tester Handle</label>
                    <input type="text" name="username" class="form-control" placeholder="e.g. tester_admin" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label">Passkey</label>
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                </div>
                <button type="submit" class="btn-tester-login">
                    Launch Dashboard <i class="ph-bold ph-arrow-right"></i>
                </button>
            </form>

            <div class="demo-creds">
                Trial Access: <code>tester</code> / <code>pass123</code>
            </div>
            
            <div style="margin-top: 20px; text-align: center;">
                <a href="${pageContext.request.contextPath}/login" style="color: #64748B; font-size: 0.85rem; font-weight: 500; text-decoration: none;">
                    Standard User Login?
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
