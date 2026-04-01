<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="1v1 Battle Arena" />
    <jsp:param name="activePage" value="contests" />
</jsp:include>

<div class="main-layout" style="grid-template-columns: 1fr;">
    <div class="card" style="background: linear-gradient(145deg, #1a1a2e, #16213e); border: none; padding: 60px; text-align: center; color: white; min-height: 500px; display: flex; flex-direction: column; justify-content: center; position: relative; overflow: hidden;">
        
        <!-- Background decorative elements -->
        <div style="position: absolute; top: -50px; left: -50px; width: 200px; height: 200px; background: rgba(0, 255, 255, 0.05); border-radius: 50%; filter: blur(50px);"></div>
        <div style="position: absolute; bottom: -50px; right: -50px; width: 200px; height: 200px; background: rgba(255, 0, 255, 0.05); border-radius: 50%; filter: blur(50px);"></div>

        <div id="searchingState">
            <div style="font-size: 4rem; margin-bottom: 24px;">⚔️</div>
            <h1 style="font-family: 'Space Grotesk', sans-serif; font-size: 2.5rem; margin-bottom: 16px; background: linear-gradient(to right, #00d2ff, #3a7bd5); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Finding Your Match</h1>
            <p style="font-size: 1.1rem; opacity: 0.7; margin-bottom: 40px; max-width: 500px; margin-left: auto; margin-right: auto;">The CodeForce algorithm is scanning the global network for an opponent at your skill level...</p>
            
            <div class="matchmaking-loader" style="margin: 0 auto 40px auto; width: 80px; height: 80px; border: 4px solid rgba(255,255,255,0.1); border-top: 4px solid #00d2ff; border-radius: 50%; animation: spin 1s linear infinite;"></div>
            
            <div style="display: flex; gap: 20px; justify-content: center; align-items: center;">
                <div class="user-preview">
                    <img src="https://ui-avatars.com/api/?name=${currentUser.handle}&background=0D8ABC&color=fff" style="width: 60px; height: 60px; border-radius: 50%; border: 3px solid #00d2ff;">
                    <div style="margin-top: 8px; font-weight: 700;">${currentUser.handle}</div>
                </div>
                <div style="font-size: 1.5rem; font-weight: 900; opacity: 0.3;">VS</div>
                <div class="user-preview" style="opacity: 0.4;">
                    <div style="width: 60px; height: 60px; border-radius: 50%; background: #333; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">?</div>
                    <div style="margin-top: 8px;">Searching...</div>
                </div>
            </div>

            <div style="margin-top: 50px;">
                <button onclick="window.location.href='${pageContext.request.contextPath}/contests'" class="btn btn-outline" style="border-color: rgba(255,255,255,0.3); color: white;">Cancel Search</button>
            </div>
        </div>

        <style>
            @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
            .matchmaking-loader { box-shadow: 0 0 20px rgba(0, 210, 255, 0.3); }
        </style>

        <script>
            // Data passed from controller
            const opponentHandle = "${opponent.handle}";
            const problemId = "${battleProblem.id}";

            // Simulate finding a match
            const isInvite = ${not empty sessionScope.battleInvite || not empty battleInvite ? true : false};
            const waitTime = isInvite ? 1500 : 3500;

            setTimeout(() => {
                const state = document.getElementById('searchingState');
                state.innerHTML = `
                    <div style="font-size: 4rem; margin-bottom: 24px;">🔥</div>
                    <h1 style="font-family: 'Space Grotesk', sans-serif; font-size: 2.5rem; margin-bottom: 16px; color: #ff4757;">MATCH FOUND!</h1>
                    <p style="font-size: 1.1rem; opacity: 0.7; margin-bottom: 40px;">Your opponent has been selected.</p>
                    
                    <div style="display: flex; gap: 40px; justify-content: center; align-items: center; margin-bottom: 40px;">
                        <div style="text-align: center;">
                            <div style="width: 100px; height: 100px; border-radius: 50%; border: 4px solid #00d2ff; box-shadow: 0 0 20px rgba(0,210,255,0.4); display: flex; align-items: center; justify-content: center; background: #00d2ff22; font-size: 2.5rem; font-weight: 800; color: white; margin: 0 auto;">
                                ${currentUser.handle.substring(0,2).toUpperCase()}
                            </div>
                            <div style="margin-top: 12px; font-size: 1.25rem; font-weight: 900;">${currentUser.handle}</div>
                        </div>
                        <div style="font-size: 2rem; font-weight: 900; color: #ff4757;">VS</div>
                        <div style="text-align: center;">
                            <div style="width: 100px; height: 100px; border-radius: 50%; border: 4px solid #ff4757; box-shadow: 0 0 20px rgba(255,71,87,0.4); display: flex; align-items: center; justify-content: center; background: #ff475722; font-size: 2.5rem; font-weight: 800; color: #ff4757; margin: 0 auto;">
                                ${opponent.handle.substring(0,2).toUpperCase()}
                            </div>
                            <div style="margin-top: 12px; font-size: 1.25rem; font-weight: 900; color: #ff4757;">${opponent.handle}</div>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/problem/${battleProblem.id}" class="btn btn-primary btn-lg" style="background: #ff4757; border: none; padding: 15px 40px; font-size: 1.2rem; text-decoration: none; border-radius: 12px; font-weight: 800;">ENTER ARENA</a>
                `;
            }, waitTime);
        </script>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
