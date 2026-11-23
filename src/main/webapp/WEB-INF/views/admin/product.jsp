<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Product Management — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-sm md:p-8">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-sand pb-4">
                            <div>
                                <h1 class="text-2xl sm:text-3xl font-bold leading-tight text-ink">Product Management</h1>
                                <p class="text-sm text-muted mt-1">Total: ${total} items</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/add-product"
                               class="inline-flex h-10 items-center justify-center rounded-xl bg-brand px-5 text-sm font-medium text-white shadow-sm hover:bg-brand-dark">
                                + Add Product
                            </a>
                        </div>

                        <!-- Product Grid -->
                        <div class="mt-6 grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
                            <c:forEach var="p" items="${products}">
                                <article class="flex flex-col rounded-xl border border-sand bg-white p-2.5 shadow-xs transition hover:shadow-md">
                                    <div class="relative w-full aspect-square overflow-hidden rounded-lg bg-cream">
                                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                             alt="${p.name}" class="h-full w-full object-contain p-1">
                                    </div>

                                    <div class="flex-1 pt-2 pb-1">
                                        <span class="text-[10px] uppercase font-semibold text-muted">${p.category}</span>
                                        <p class="text-xs sm:text-sm font-medium text-ink truncate" title="${p.name}">${p.name}</p>
                                        <p class="mt-0.5 text-xs font-bold text-brand-text">IDR ${p.formattedPrice}</p>
                                    </div>

                                    <div class="flex gap-2 pt-2 border-t border-sand/60">
                                        <a href="${pageContext.request.contextPath}/admin/edit-product?id=${p.id}"
                                           class="flex-1 text-center py-1.5 rounded bg-cream text-xs font-medium text-ink hover:bg-sand/30">
                                            Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/admin/delete-product" method="POST" class="flex-1"
                                              onsubmit="return confirm('Remove product ${p.name}?');">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit"
                                                    class="w-full py-1.5 rounded bg-red-50 text-xs font-medium text-red-600 hover:bg-red-100">
                                                Delete
                                            </button>
                                        </form>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="mt-8 flex justify-center gap-2 border-t border-sand pt-6">
                                <c:forEach begin="1" end="${totalPages}" var="pageIndex">
                                    <a href="${pageContext.request.contextPath}/admin/product?page=${pageIndex}"
                                       class="px-3.5 py-1.5 rounded-lg text-sm font-medium ${currentPage == pageIndex ? 'bg-brand text-white' : 'bg-white border border-sand text-ink hover:bg-cream'}">
                                        ${pageIndex}
                                    </a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
