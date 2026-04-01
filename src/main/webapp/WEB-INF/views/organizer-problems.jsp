<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Problem Registry | CodeForce Pro</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <style>
        :root {
            --primary: #4ECDC4;
            --accent: #FF6B6B;
            --sidebar-w: 280px;
            --bg: #020617;
            --card: rgba(15, 23, 42, 0.4);
            --border: rgba(255, 255, 255, 0.1);
        }

        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); color: #F8FAFC; display: flex; min-height: 100vh; }

        /* --- Sidebar Navigation (Same as Dashboard) --- */
        .sidebar { width: var(--sidebar-w); border-right: 1px solid var(--border); padding: 40px 24px; display: flex; flex-direction: column; background: #0F172A; position: fixed; height: 100vh; }
        .logo { display:flex; align-items:center; gap:12px; font-size:1.5rem; font-weight:800; color:white; text-decoration:none; margin-bottom:60px; font-family:'Outfit'; }
        .nav-group { margin-bottom: 40px; }
        .nav-label { font-size: 0.75rem; text-transform: uppercase; color: #475569; letter-spacing: 1px; font-weight: 800; margin-bottom: 16px; display: block; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 14px 16px; color: #94A3B8; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s; margin-bottom: 4px; }
        .nav-item:hover, .nav-item.active { background: rgba(255,255,255,0.05); color: var(--primary); }

        .main { margin-left: var(--sidebar-w); flex: 1; padding: 40px 60px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 48px; }
        .header h1 { font-family: 'Outfit'; font-size: 2.2rem; letter-spacing: -1.5px; }

        .table-card { background: var(--card); border: 1px solid var(--border); border-radius: 24px; overflow: hidden; padding: 24px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 20px 24px; color: #64748B; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; border-bottom: 1px solid var(--border); }
        td { padding: 24px; border-bottom: 1px solid var(--border); font-size: 0.95rem; font-weight: 500; }
        .tr-hover:hover { background: rgba(255,255,255,0.02); }

        .tag { padding: 4px 10px; border-radius: 6px; font-size: 0.7rem; font-weight: 800; background: rgba(255,255,255,0.05); color: #64748B; margin-right: 4px; }

        .btn-action { background: rgba(255,255,255,0.05); color: #F8FAFC; border: none; padding: 10px 16px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.3s; text-decoration: none; font-size: 0.85rem; }
        .btn-action:hover { background: var(--primary); color: var(--bg); }
    </style>
</head>
<body>

    <nav class="sidebar">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <i class="ph-fill ph-rocket-launch" style="color:var(--accent)"></i>
            CodeForce
        </a>
        <div class="nav-group">
            <span class="nav-label">Main Dashboard</span>
            <a href="${pageContext.request.contextPath}/organizer/dashboard" class="nav-item"><i class="ph ph-squares-four"></i> Overview</a>
            <a href="${pageContext.request.contextPath}/organizer/contests" class="nav-item"><i class="ph ph-calendar-star"></i> Contests</a>
            <a href="${pageContext.request.contextPath}/organizer/problems" class="nav-item active"><i class="ph ph-brackets-curly"></i> Problems</a>
        </div>
    </nav>

    <main class="main">
        <header class="header">
            <h1>Problem Inventory</h1>
            <button class="btn-action" style="background:var(--primary); color:var(--bg)" onclick="openProblemModal()">+ Add New Problem</button>
        </header>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Difficulty</th>
                        <th>Tags</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${problems}" var="problem">
                        <tr class="tr-hover">
                            <td style="color:#64748B">#${problem.id}</td>
                            <td>${problem.name}</td>
                            <td>
                                <span style="font-weight: 800; color:${problem.difficultyRating > 2000 ? '#FF6B6B' : (problem.difficultyRating > 1200 ? '#4ECDC4' : '#94A3B8')}">
                                    ${problem.difficultyRating}
                                </span>
                            </td>
                            <td>
                                <c:forEach items="${problem.tags}" var="tag">
                                    <span class="tag">${tag.name}</span>
                                </c:forEach>
                            </td>
                            <td>
                                <button class="btn-action" onclick="openProblemModal('${problem.id}', '${problem.name}', '${problem.difficultyRating}')">Edit</button>
                                <button class="btn-action" style="margin-left: 8px; background:var(--primary); color:var(--bg)" onclick="openTestCaseModal('${problem.id}', '${problem.name}')">Test Cases</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

    <!-- Modal for Create/Edit Problem -->
    <div id="problemModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); backdrop-filter:blur(8px); z-index:1000; justify-content:center; align-items:center;">
        <div style="background:#0F172A; width:90%; max-width:600px; padding:40px; border-radius:32px; border:1px solid var(--border); color-scheme: dark;">
            <h2 id="modalTitle" style="font-family:'Outfit'; font-size:2rem; margin-bottom:32px;">Add New Problem</h2>
            <form id="problemForm">
                <input type="hidden" id="p_id">
                <label style="display:block; margin-bottom:8px; color:#64748B; font-weight:600;">Problem Name</label>
                <input type="text" id="p_name" required style="width:100%; padding:14px; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:12px; color:white; margin-bottom:24px;">
                
                <div style="display:grid; grid-template-columns:1fr 1fr; gap:24px; margin-bottom:32px;">
                    <div>
                        <label style="display:block; margin-bottom:8px; color:#64748B; font-weight:600;">Difficulty</label>
                        <input type="number" id="p_difficulty" value="800" required style="width:100%; padding:14px; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:12px; color:white;">
                    </div>
                    <div>
                        <label style="display:block; margin-bottom:8px; color:#64748B; font-weight:600;">Time Limit (sec)</label>
                        <input type="number" value="1.0" step="0.1" style="width:100%; padding:14px; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:12px; color:white;">
                    </div>
                </div>

                <div style="display:flex; justify-content:flex-end; gap:16px;">
                    <button type="button" class="btn-action" onclick="closeProblemModal()">Cancel</button>
                    <button type="submit" class="btn-action" style="background:var(--primary); color:var(--bg)">Deploy Problem</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openProblemModal(id = '', name = '', difficulty = '800') {
            document.getElementById('p_id').value = id;
            document.getElementById('p_name').value = name;
            document.getElementById('p_difficulty').value = difficulty;
            document.getElementById('modalTitle').innerText = id ? 'Edit Problem' : 'Add New Problem';
            document.getElementById('problemModal').style.display = 'flex';
        }

        function closeProblemModal() {
            document.getElementById('problemModal').style.display = 'none';
        }

        function openTestCaseModal(problemId, problemName) {
            document.getElementById('tc_problemId').value = problemId;
            document.getElementById('tc_title').innerText = 'Test Cases: ' + problemName;
            document.getElementById('testCaseModal').style.display = 'flex';
        }

        function closeTestCaseModal() {
            document.getElementById('testCaseModal').style.display = 'none';
        }

        document.getElementById('problemForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Problem details saved to vault. You can now manage its test cases.');
            closeProblemModal();
        });

        document.getElementById('testCaseForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Test cases for problem #' + document.getElementById('tc_problemId').value + ' updated successfully!');
            closeTestCaseModal();
        });
    </script>

    <!-- Modal for Test Cases -->
    <div id="testCaseModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); backdrop-filter:blur(10px); z-index:2000; justify-content:center; align-items:center;">
        <div style="background:#0F172A; width:95%; max-width:900px; padding:40px; border-radius:32px; border:1px solid var(--border); box-shadow:0 0 50px rgba(0,0,0,0.5); color-scheme: dark;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:32px;">
                <h2 id="tc_title" style="font-family:'Outfit'; font-size:2rem;">Manage Test Cases</h2>
                <button class="btn-action" style="background:var(--primary); color:var(--bg)">+ Add Case</button>
            </div>
            
            <form id="testCaseForm">
                <input type="hidden" id="tc_problemId">
                <div style="max-height:500px; overflow-y:auto; margin-bottom:32px;">
                    <table style="width:100%">
                        <thead>
                            <tr style="border-bottom:1px solid var(--border)">
                                <th style="width:50px">#</th>
                                <th>Input</th>
                                <th>Output</th>
                                <th style="width:80px">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td><textarea style="width:100%; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:8px; padding:10px; color:white;">5\n1 2 3 4 5</textarea></td>
                                <td><textarea style="width:100%; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:8px; padding:10px; color:white;">15</textarea></td>
                                <td><i class="ph ph-trash" style="color:var(--accent); cursor:pointer; font-size:1.2rem"></i></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td><textarea style="width:100%; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:8px; padding:10px; color:white;">3\n10 20 30</textarea></td>
                                <td><textarea style="width:100%; background:rgba(255,255,255,0.05); border:1px solid var(--border); border-radius:8px; padding:10px; color:white;">60</textarea></td>
                                <td><i class="ph ph-trash" style="color:var(--accent); cursor:pointer; font-size:1.2rem"></i></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div style="display:flex; justify-content:flex-end; gap:16px;">
                    <button type="button" class="btn-action" onclick="closeTestCaseModal()">Cancel</button>
                    <button type="submit" class="btn-action" style="background:var(--primary); color:var(--bg)">Save All Test Cases</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
