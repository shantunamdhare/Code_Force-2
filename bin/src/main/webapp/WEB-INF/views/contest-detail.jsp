<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="common/header.jsp">
    <jsp:param name="pageTitle" value="${contest.name}" />
    <jsp:param name="activePage" value="contests" />
</jsp:include>

<div class="container">
    <div class="page-title animate-fade-in-up">
        <h1>${contest.name}</h1>
    </div>

    <div class="card animate-fade-in-up">
        <div class="card-body">
            <c:if test="${not empty success}">
                <div style="padding: 12px 16px; background: rgba(39,174,96,0.1); color: #27AE60; border-radius: 8px; margin-bottom: 20px; font-weight: 600; border: 1px solid rgba(39,174,96,0.2);">
                    ✔ ${success}
                </div>
            </c:if>
            <!-- Contest Info -->
            <div class="problem-limits">
                <span><strong>Type:</strong> ${contest.type}</span>
                <span><strong>Duration:</strong> ${contest.formattedDuration}</span>
                <span>
                    <strong>Start:</strong> 
                    <fmt:parseDate value="${contest.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm"/>
                </span>
                <span>
                    <strong>Phase:</strong> 
                    <span class="phase-badge phase-${contest.phase == 'BEFORE' ? 'upcoming' : contest.phase == 'CODING' ? 'running' : 'finished'}">
                        ${contest.phaseLabel}
                    </span>
                </span>
            </div>

            <c:if test="${not empty contest.preparedBy}">
                <p style="margin-bottom:16px;font-size:0.92rem;color:var(--text-secondary);">
                    <strong>Prepared by:</strong> 
                    <a href="${pageContext.request.contextPath}/profile/${contest.preparedBy}" style="color:var(--primary-coral);font-weight:600;">
                        ${contest.preparedBy}
                    </a>
                </p>
            </c:if>

            <c:if test="${not empty contest.description}">
                <div class="problem-section">
                    <h3>Description</h3>
                    <p>${contest.description}</p>
                </div>
            </c:if>

            <c:if test="${contest.participantCount > 0}">
                <p style="font-size:0.92rem;color:var(--text-secondary);margin-top:16px;">
                    &#128101; <strong>${contest.participantCount}</strong> participants
                </p>
            </c:if>

            <c:if test="${contest.phase == 'BEFORE'}">
                <div style="margin-top:24px;padding:20px;background:linear-gradient(135deg,rgba(255,107,107,0.04),rgba(247,183,49,0.04));border-radius:var(--radius-md);border:1px solid var(--border-light);">
                    <h3 style="margin-bottom:12px;font-size:1rem;">&#9200; Contest Starts In</h3>
                    <div class="countdown-timer" data-countdown="${contest.startTime}">
                        <div class="countdown-unit">
                            <span class="number">--</span><span class="label">Days</span>
                        </div>
                        <div class="countdown-unit">
                            <span class="number">--</span><span class="label">Hours</span>
                        </div>
                        <div class="countdown-unit">
                            <span class="number">--</span><span class="label">Min</span>
                        </div>
                        <div class="countdown-unit">
                            <span class="number">--</span><span class="label">Sec</span>
                        </div>
                    </div>
                    <c:if test="${not empty currentUser}">
                        <c:choose>
                            <c:when test="${registered}">
                                <div style="display: flex; align-items: center; gap: 8px; color: #27AE60; font-weight: 700; background: rgba(39,174,96,0.05); padding: 12px; border-radius: 8px; border: 1px dashed #27AE60; margin-top: 10px;">
                                    <i class="ph ph-check-circle" style="font-size: 1.25rem;"></i>
                                    You are registered for this contest
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/contests/register/${contest.id}" method="post">
                                    <button type="submit" class="btn btn-primary mt-2">&#9654; Register for Contest</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${empty currentUser}">
                        <p style="margin-top:12px;font-size:0.88rem;color:var(--text-muted);">
                            <a href="${pageContext.request.contextPath}/login" style="color:var(--primary-coral);font-weight:600;">Login</a> to register for this contest.
                        </p>
                    </c:if>
                </div>
            </c:if>

            <div style="margin-top:24px;">
                <a href="${pageContext.request.contextPath}/contests" class="btn btn-outline">
                    &#8592; Back to Contests
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="common/footer.jsp"/>
