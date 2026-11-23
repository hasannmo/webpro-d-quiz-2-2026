<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%--
  Re-usable pagination fragment matching Laravel Tailwind paginator
  Expected request attributes:
    - totalPages (int)
    - currentPage (int)
    - pageBaseUrl (String, e.g. "${pageContext.request.contextPath}/admin/order?range=${selected}&")
--%>
<c:if test="${totalPages > 1}">
    <nav role="navigation" aria-label="Pagination Navigation" class="mt-6 border-t border-muted/40 pt-6 flex items-center justify-between">
        <%-- Mobile View: Previous / Next buttons --%>
        <div class="flex gap-2 items-center justify-between w-full sm:hidden">
            <c:choose>
                <c:when test="${currentPage <= 1}">
                    <span class="inline-flex items-center px-4 py-2 text-sm font-medium text-muted bg-white/70 border border-sand cursor-not-allowed rounded-lg shadow-xs">
                        Previous
                    </span>
                </c:when>
                <c:otherwise>
                    <a href="${pageBaseUrl}page=${currentPage - 1}" rel="prev"
                       class="inline-flex items-center px-4 py-2 text-sm font-medium text-ink bg-white border border-sand rounded-lg shadow-xs transition hover:border-brand hover:text-brand">
                        Previous
                    </a>
                </c:otherwise>
            </c:choose>

            <span class="text-xs text-muted font-medium">Page ${currentPage} of ${totalPages}</span>

            <c:choose>
                <c:when test="${currentPage >= totalPages}">
                    <span class="inline-flex items-center px-4 py-2 text-sm font-medium text-muted bg-white/70 border border-sand cursor-not-allowed rounded-lg shadow-xs">
                        Next
                    </span>
                </c:when>
                <c:otherwise>
                    <a href="${pageBaseUrl}page=${currentPage + 1}" rel="next"
                       class="inline-flex items-center px-4 py-2 text-sm font-medium text-ink bg-white border border-sand rounded-lg shadow-xs transition hover:border-brand hover:text-brand">
                        Next
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Desktop / Tablet View: Numeric links with arrows and scrolling container --%>
        <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between sm:gap-2 md:gap-4">
            <div class="shrink-0">
                <p class="text-xs md:text-sm text-muted">
                    Page <span class="font-semibold text-ink">${currentPage}</span> of <span class="font-semibold text-ink">${totalPages}</span>
                </p>
            </div>

            <div class="overflow-x-auto [scrollbar-width:none] [&::-webkit-scrollbar]:hidden py-1">
                <span class="inline-flex items-center gap-1 shrink-0">
                    <%-- Previous arrow --%>
                    <c:choose>
                        <c:when test="${currentPage <= 1}">
                            <span class="inline-flex items-center justify-center h-8 w-8 text-xs font-medium text-muted/50 bg-white/50 border border-sand/70 rounded-md cursor-not-allowed" aria-hidden="true">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageBaseUrl}page=${currentPage - 1}" rel="prev"
                               class="inline-flex items-center justify-center h-8 w-8 text-xs font-medium text-ink bg-white border border-sand rounded-md transition hover:border-brand hover:text-brand hover:bg-cream-dark" aria-label="Previous">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
                                </svg>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <%-- Numbered pages --%>
                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <c:choose>
                            <c:when test="${p == currentPage}">
                                <span class="inline-flex items-center justify-center h-8 min-w-8 px-2.5 text-xs font-semibold text-white bg-brand border border-brand rounded-md shadow-xs" aria-current="page">
                                    ${p}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageBaseUrl}page=${p}"
                                   class="inline-flex items-center justify-center h-8 min-w-8 px-2.5 text-xs font-medium text-ink bg-white border border-sand rounded-md transition hover:border-brand hover:text-brand hover:bg-cream-dark">
                                    ${p}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <%-- Next arrow --%>
                    <c:choose>
                        <c:when test="${currentPage >= totalPages}">
                            <span class="inline-flex items-center justify-center h-8 w-8 text-xs font-medium text-muted/50 bg-white/50 border border-sand/70 rounded-md cursor-not-allowed" aria-hidden="true">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                                </svg>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageBaseUrl}page=${currentPage + 1}" rel="next"
                               class="inline-flex items-center justify-center h-8 w-8 text-xs font-medium text-ink bg-white border border-sand rounded-md transition hover:border-brand hover:text-brand hover:bg-cream-dark" aria-label="Next">
                                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
                                </svg>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </nav>
</c:if>
