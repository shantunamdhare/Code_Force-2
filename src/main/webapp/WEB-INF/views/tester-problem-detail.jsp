<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="Testing: ${problem.name}" />
    <jsp:param name="activePage" value="tester" />
</jsp:include>

<div class="container" style="max-width: 1200px;">
    <div style="display: flex; gap: 24px; margin: 28px 0;">
        <!-- Left: Problem Statement & Test Cases -->
        <div style="flex: 2;">
            <div class="card" style="padding: 24px; margin-bottom: 24px;">
                <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                    <h1 style="font-size: 1.5rem; margin-bottom: 16px;">
                        <span style="color: var(--text-muted);">${problem.fullId}.</span> ${problem.name}
                    </h1>
                    <span class="tag" style="background: var(--primary-teal); color: white;">${problem.status}</span>
                </div>
                
                <div class="problem-section">
                    <h3>Statement</h3>
                    <p>${problem.statement}</p>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="problem-section">
                        <h3>Input Spec</h3>
                        <p style="font-size: 0.9rem;">${problem.inputSpec}</p>
                    </div>
                    <div class="problem-section">
                        <h3>Output Spec</h3>
                        <p style="font-size: 0.9rem;">${problem.outputSpec}</p>
                    </div>
                </div>

                <div class="problem-section">
                    <h3>Test Cases</h3>
                    <div style="display: flex; flex-direction: column; gap: 12px;">
                        <c:forEach var="tc" items="${testCases}">
                            <div class="sample-box" style="margin: 0; padding: 12px; border: 1px solid var(--border-light);">
                                <div style="display: flex; justify-content: space-between; font-size: 0.75rem; color: var(--text-muted); margin-bottom: 4px;">
                                    <span>${tc.publiclyVisible ? 'Public' : 'Private'} Test Case</span>
                                </div>
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                                    <div><strong>In:</strong> <code style="display:block; padding: 4px; background: #f8f9fa;">${tc.input}</code></div>
                                    <div><strong>Exp:</strong> <code style="display:block; padding: 4px; background: #f8f9fa;">${tc.expectedOutput}</code></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Execution & Feedback -->
        <div style="flex: 1; display: flex; flex-direction: column; gap: 24px;">
            <!-- Mini Compiler / Executor -->
            <div class="card" style="padding: 24px; border-top: 4px solid var(--primary-teal);">
                <h3 style="margin-bottom: 16px;"><i class="ph ph-terminal"></i> Custom Execution</h3>
                <div class="form-group">
                    <label class="form-label">Input Data</label>
                    <textarea id="customInput" class="form-control" style="height: 100px; font-family: monospace;" placeholder="Enter custom input..."></textarea>
                </div>
                <button onclick="runCustomTest()" class="btn btn-primary" style="width: 100%;">Run Test</button>
                
                <div id="testResult" style="margin-top: 16px; display: none;">
                    <div style="padding: 12px; border-radius: 4px; background: #2d3436; color: #dfe6e9; font-family: monospace; font-size: 0.85rem;">
                        <div style="color: #00b894; margin-bottom: 4px;">>>> Output:</div>
                        <div id="resultOutput" style="margin-bottom: 10px;"></div>
                        <div style="border-top: 1px solid #636e72; padding-top: 4px; color: #b2bec3; font-size: 0.75rem;">
                            Time: <span id="resultTime"></span> | Memory: <span id="resultMemory"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bug Report -->
            <div class="card" style="padding: 24px; border-top: 4px solid var(--primary-coral);">
                <h3 style="margin-bottom: 16px;"><i class="ph ph-bug"></i> Report Bug</h3>
                <form action="${pageContext.request.contextPath}/tester/problem/${problem.id}/bug" method="post">
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" style="height: 80px;" required></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Severity</label>
                        <select name="severity" class="form-control">
                            <option value="LOW">Low</option>
                            <option value="MEDIUM">Medium</option>
                            <option value="HIGH">High</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-outline" style="width: 100%; border-color: var(--primary-coral); color: var(--primary-coral);">Submit Bug Report</button>
                </form>
            </div>

            <!-- Final Decision -->
            <div class="card" style="padding: 24px; border-top: 4px solid var(--primary-teal);">
                <h3 style="margin-bottom: 16px;"><i class="ph ph-check-circle"></i> Final Evaluation</h3>
                <form action="${pageContext.request.contextPath}/tester/problem/${problem.id}/feedback" method="post">
                    <div class="form-group">
                        <label class="form-label">Suggested Difficulty</label>
                        <select name="difficulty" class="form-control">
                            <option value="EASY">Easy</option>
                            <option value="MEDIUM">Medium</option>
                            <option value="HARD">Hard</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Comments</label>
                        <textarea name="comment" class="form-control" style="height: 80px;" placeholder="Overall feedback..."></textarea>
                    </div>
                    <div class="form-group">
                        <label><input type="checkbox" name="isFair" checked> Constraints are fair</label>
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                        <button type="submit" name="status" value="APPROVED" class="btn btn-primary">Approve</button>
                        <button type="submit" name="status" value="NEEDS_FIX" class="btn" style="background:#dfe6e9;">Needs Fix</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
async function runCustomTest() {
    const input = document.getElementById('customInput').value;
    const resultDiv = document.getElementById('testResult');
    const outputDiv = document.getElementById('resultOutput');
    const timeSpan = document.getElementById('resultTime');
    const memSpan = document.getElementById('resultMemory');

    resultDiv.style.display = 'block';
    outputDiv.innerText = 'Running...';

    try {
        const response = await fetch('${pageContext.request.contextPath}/tester/problem/${problem.id}/test', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ input: input })
        });
        const data = await response.json();
        
        outputDiv.innerText = data.output;
        timeSpan.innerText = data.time;
        memSpan.innerText = data.memory;
    } catch (error) {
        outputDiv.innerText = 'Error executing test.';
    }
}
</script>

<jsp:include page="common/footer.jsp" />
