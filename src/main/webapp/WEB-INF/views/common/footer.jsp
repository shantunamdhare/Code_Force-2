    </div> <!-- end of container -->

    <footer class="site-footer" style="padding: 40px 0; margin-top: 60px; border-top: 1px solid var(--border-light); background: white;">
        <div class="container" style="text-align: center;">
            <div style="font-family: 'Space Grotesk', sans-serif; font-size: 1.25rem; font-weight: 800; color: var(--primary-coral); margin-bottom: 20px;">
                CodeForce
            </div>
            <p style="font-size: 0.85rem; color: var(--text-muted); max-width: 500px; margin: 0 auto 20px;">
                The premier competitive programming platform. Join the global community of top problem solvers.
            </p>
            <div style="font-size: 0.75rem; color: var(--text-muted); display:flex; justify-content:center; gap: 20px;">
                <span>&copy; 2024-2026 CodeForce. All rights reserved.</span>
                <span id="serverTime"></span>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        function findUser() {
            const input = document.getElementById('findUserInput');
            if (input && input.value.trim()) {
                window.location.href = '${pageContext.request.contextPath}/profile/' + encodeURIComponent(input.value.trim());
            }
        }
    </script>
</body>
</html>
