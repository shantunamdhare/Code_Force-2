<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="${problem.fullId} - ${problem.name}" />
    <jsp:param name="activePage" value="problemset" />
</jsp:include>

<div class="container">
    <div class="card animate-fade-in-up" style="margin:28px 0;">
        <div class="problem-statement">

            <!-- Title -->
            <div class="problem-title-header">
                <h1>
                    <span style="color:${problem.difficultyColor};margin-right:8px;">${problem.fullId}.</span>
                    ${problem.name}
                </h1>
                <span class="problem-difficulty" style="color:${problem.difficultyColor};font-size:1.2rem;">
                    &#9733; ${problem.difficultyRating}
                </span>
            </div>

            <!-- Limits -->
            <div class="problem-limits">
                <span>&#9201; <strong>Time Limit:</strong> ${problem.timeLimitMs / 1000.0} seconds</span>
                <span>&#128190; <strong>Memory Limit:</strong> ${problem.memoryLimitMb} MB</span>
                <span>&#10004; <strong>Solved by:</strong> ${problem.solvedCount} users</span>
            </div>

            <!-- Tags -->
            <div style="margin-bottom:24px;">
                <c:forEach var="tag" items="${problem.tags}">
                    <span class="tag tag-teal">${tag.name}</span>
                </c:forEach>
            </div>

            <!-- Statement -->
            <c:if test="${not empty problem.statement}">
                <div class="problem-section">
                    <h3>Statement</h3>
                    <p>${problem.statement}</p>
                </div>
            </c:if>

            <!-- Input Specification -->
            <c:if test="${not empty problem.inputSpec}">
                <div class="problem-section">
                    <h3>Input</h3>
                    <p>${problem.inputSpec}</p>
                </div>
            </c:if>

            <!-- Output Specification -->
            <c:if test="${not empty problem.outputSpec}">
                <div class="problem-section">
                    <h3>Output</h3>
                    <p>${problem.outputSpec}</p>
                </div>
            </c:if>

            <!-- Sample Input -->
            <c:if test="${not empty problem.sampleInput}">
                <div class="problem-section">
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <h3>Sample Input</h3>
                        <button class="btn btn-sm btn-outline" onclick="copySample(this)">&#128203; Copy</button>
                    </div>
                    <div class="sample-box">${problem.sampleInput}</div>
                </div>
            </c:if>

            <!-- Sample Output -->
            <c:if test="${not empty problem.sampleOutput}">
                <div class="problem-section">
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <h3>Sample Output</h3>
                        <button class="btn btn-sm btn-outline" onclick="copySample(this)">&#128203; Copy</button>
                    </div>
                    <div class="sample-box">${problem.sampleOutput}</div>
                </div>
            </c:if>

            <!-- Note -->
            <c:if test="${not empty problem.note}">
                <div class="problem-section">
                    <h3>Note</h3>
                    <p>${problem.note}</p>
                </div>
            </c:if>

            <!-- Verdict Flash -->
            <c:if test="${not empty verdict}">
                <div style="margin:24px 0;padding:20px;border-radius:var(--radius-md);border:1px solid var(--border-light);
                    background:${verdict == 'Accepted' ? 'rgba(0,184,148,0.06)' : 'rgba(255,107,107,0.06)'};">
                    <h3 style="margin-bottom:8px;color:${submission.verdictColor};">
                        ${verdict == 'Accepted' ? '&#10004;' : '&#10008;'} Verdict: ${verdict}
                    </h3>
                    <p style="font-size:0.88rem;color:var(--text-secondary);">
                        Time: <strong>${submission.timeConsumedMs} ms</strong> | 
                        Memory: <strong>${submission.memoryConsumedKb} KB</strong> |
                        Tests passed: <strong>${submission.passedTestCount}</strong>
                    </p>
                </div>
            </c:if>

            <!-- Submit Solution -->
            <c:if test="${not empty currentUser}">
                <div class="submit-panel">
                    <h3>&#128187; Submit Solution</h3>
                    <form action="${pageContext.request.contextPath}/problem/${problem.id}/submit" method="post">
                        <input type="hidden" name="contestId" value="${contestId}">
                        <input type="hidden" name="isSecondChance" value="${isSecondChance}">
                        <div class="form-group">
                            <label class="form-label">Programming Language</label>
                            <select name="language" class="form-control" style="max-width:300px;">
                                <option value="C++17">C++ 17</option>
                                <option value="Java 17">Java 17</option>
                                <option value="Python 3">Python 3</option>
                                <option value="JavaScript">JavaScript</option>
                                <option value="C">C</option>
                                <option value="Kotlin">Kotlin</option>
                                <option value="Rust">Rust</option>
                                <option value="Go">Go</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Source Code</label>
                            <textarea name="sourceCode" class="form-control form-control-code" placeholder="Paste your solution here..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-secondary">
                            &#9654; Submit Solution
                        </button>
                    </form>
                </div>
            </c:if>

            <c:if test="${empty currentUser}">
                <div style="margin-top:24px;padding:20px;background:rgba(247,183,49,0.06);border-radius:var(--radius-md);border:1px solid var(--border-light);text-align:center;">
                    <p style="font-size:0.92rem;color:var(--text-secondary);">
                        <a href="${pageContext.request.contextPath}/login" style="color:var(--primary-coral);font-weight:700;">Login</a> 
                        to submit your solution.
                    </p>
                </div>
            </c:if>

            <!-- Back Link -->
            <div style="margin-top:24px;">
                <a href="${pageContext.request.contextPath}/problemset" class="btn btn-outline">
                    &#8592; Back to Problemset
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
