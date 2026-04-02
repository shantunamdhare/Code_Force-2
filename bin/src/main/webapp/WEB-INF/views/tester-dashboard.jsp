<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Tester Dashboard" />
    <jsp:param name="activePage" value="tester" />
</jsp:include>

<div class="main-layout">
    <div style="width: 100%;">
        <div class="card" style="padding: 24px; margin-bottom: 24px;">
            <h1 style="font-size: 1.75rem; color: var(--text-primary); margin-bottom: 8px;">Tester Dashboard</h1>
            <p style="color: var(--text-secondary);">Validate, test, and provide feedback on upcoming problems.</p>
        </div>

        <c:set var="isTester" value="${not empty currentUser and currentUser.handle eq 'tester'}" />

        <c:if test="${not isTester}">
            <div class="card" style="padding: 32px; margin-bottom: 32px; border-top: 4px solid var(--primary-coral); max-width: 500px; margin-left: auto; margin-right: auto;">
                <h2 style="text-align: center; margin-bottom: 24px;">Tester Authentication</h2>
                <c:if test="${not empty currentUser}">
                    <div style="text-align: center; margin-bottom: 16px; color: var(--text-secondary);">
                        Currently logged in as <strong>${currentUser.handle}</strong>.
                        <br>Please switch to the tester account to continue.
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div style="color: var(--primary-coral); margin-bottom: 16px; text-align: center;">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/tester/login" method="post">
                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" value="tester" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" value="pass123" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 16px;">Login as Tester</button>
                </form>
                <p style="margin-top: 16px; font-size: 0.85rem; color: var(--text-muted); text-align: center;">
                    Demo Credentials: <code>tester</code> / <code>pass123</code>
                </p>
            </div>
        </c:if>

        <c:if test="${isTester}">
            <!-- Assigned Problems -->
        <h2 style="font-size: 1.25rem; margin-bottom: 16px;">My Assigned Problems</h2>
        <div class="card" style="margin-bottom: 32px;">
            <table class="problem-table">
                <thead>
                    <tr>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 40%;">Problem Name</th>
                        <th style="width: 20%;">Status</th>
                        <th style="width: 30%;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="problem" items="${assignedProblems}">
                        <tr>
                            <td>${problem.fullId}</td>
                            <td><a href="${pageContext.request.contextPath}/tester/problem/${problem.id}" style="font-weight: 600;">${problem.name}</a></td>
                            <td>
                                <span class="tag" style="background: 
                                    ${problem.status == 'TESTING' ? '#3498DB' : 
                                      problem.status == 'NEEDS_FIX' ? '#E67E22' : '#27AE60'}; color: white;">
                                    ${problem.status}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/tester/problem/${problem.id}" class="btn btn-sm btn-secondary">Open Testing Interface</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty assignedProblems}">
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 20px; color: var(--text-muted);">No problems currently assigned to you.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pending Problems -->
        <h2 style="font-size: 1.25rem; margin-bottom: 16px;">Available for Testing</h2>
        <div class="card">
            <table class="problem-table">
                <thead>
                    <tr>
                        <th style="width: 10%;">ID</th>
                        <th style="width: 40%;">Problem Name</th>
                        <th style="width: 20%;">Difficulty</th>
                        <th style="width: 30%;">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="problem" items="${pendingProblems}">
                        <tr>
                            <td>${problem.fullId}</td>
                            <td>${problem.name}</td>
                            <td>
                                <span style="color: ${problem.getDifficultyColor()}; font-weight: 700;">
                                    ${problem.difficultyRating}
                                </span>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/tester/assign/${problem.id}" method="post">
                                    <button type="submit" class="btn btn-sm btn-primary">Assign to Me</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingProblems}">
                        <tr>
                            <td colspan="4" style="text-align: center; padding: 20px; color: var(--text-muted);">No new problems pending review.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Bug Report System -->
        <h2 style="font-size: 1.25rem; margin-top: 40px; margin-bottom: 16px;">
            <span style="color: var(--primary-coral);">&#128027;</span> Bug Report System
        </h2>

        <c:if test="${not empty bugSuccess}">
            <div style="background: #d4edda; color: #155724; padding: 12px 20px; border-radius: 8px; margin-bottom: 16px; border: 1px solid #c3e6cb;">
                ${bugSuccess}
            </div>
        </c:if>

        <div class="card" style="padding: 28px; margin-bottom: 24px; border-left: 4px solid var(--primary-coral);">
            <h3 style="margin-bottom: 20px; font-size: 1.1rem;">Report a Bug</h3>
            <form action="${pageContext.request.contextPath}/tester/dashboard/bug" method="post">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label">Problem</label>
                        <select name="problemId" class="form-control" required>
                            <option value="">-- Select Problem --</option>
                            <c:forEach var="p" items="${allProblems}">
                                <option value="${p.id}">${p.fullId} - ${p.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label class="form-label">Severity</label>
                        <select name="severity" class="form-control" required>
                            <option value="LOW">Low</option>
                            <option value="MEDIUM">Medium</option>
                            <option value="HIGH" selected>High</option>
                        </select>
                    </div>
                </div>
                <div class="form-group" style="margin-bottom: 16px;">
                    <label class="form-label">Issue Description</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Describe the bug clearly, e.g. 'Fails for n=1, expected output 10 but got nothing'" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="background: var(--primary-coral); border-color: var(--primary-coral);">
                    Submit Bug Report
                </button>
            </form>
        </div>

        <!-- Bug Report History -->
        <c:if test="${not empty bugReports}">
            <h3 style="font-size: 1.1rem; margin-bottom: 12px;">My Bug Reports</h3>
            <div class="card" style="margin-bottom: 32px;">
                <table class="problem-table">
                    <thead>
                        <tr>
                            <th style="width: 15%;">Problem</th>
                            <th style="width: 45%;">Issue</th>
                            <th style="width: 15%;">Severity</th>
                            <th style="width: 25%;">Reported</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bug" items="${bugReports}">
                            <tr>
                                <td style="font-weight: 600;">${bug.problem.fullId}</td>
                                <td>${bug.description}</td>
                                <td>
                                    <span class="tag" style="color: white; background:
                                        ${bug.severity == 'HIGH' ? '#E74C3C' :
                                          bug.severity == 'MEDIUM' ? '#F39C12' : '#27AE60'};">
                                        ${bug.severity}
                                    </span>
                                </td>
                                <td style="color: var(--text-muted); font-size: 0.85rem;">
                                    <fmt:parseDate value="${bug.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="dd MMM yyyy, HH:mm"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        </c:if>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
