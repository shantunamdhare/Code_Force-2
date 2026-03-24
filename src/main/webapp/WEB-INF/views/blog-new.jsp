<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="New Blog Post" />
    <jsp:param name="activePage" value="home" />
</jsp:include>

<div class="main-layout" style="grid-template-columns: 1fr;">
    <div class="card" style="max-width: 800px; margin: 0 auto; padding: 40px;">
        <h1 style="font-size: 1.75rem; margin-bottom: 24px; color: var(--text-primary);">Create New Blog Post</h1>
        
        <form action="${pageContext.request.contextPath}/blog/new" method="post">
            <div class="form-group" style="margin-bottom: 20px;">
                <label class="form-label" style="display: block; margin-bottom: 8px; font-weight: 700;">Post Title</label>
                <input type="text" name="title" class="find-user-input" style="width: 100%;" placeholder="Enter a catchy title..." required>
            </div>
            
            <div class="form-group" style="margin-bottom: 24px;">
                <label class="form-label" style="display: block; margin-bottom: 8px; font-weight: 700;">Content</label>
                <textarea name="content" class="find-user-input" style="width: 100%; min-height: 250px; padding: 15px;" placeholder="Write your thoughts here..." required></textarea>
            </div>
            
            <div style="display: flex; gap: 12px; justify-content: flex-end;">
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline">Cancel</a>
                <button type="submit" class="btn btn-primary">Publish Post</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="common/footer.jsp" />
