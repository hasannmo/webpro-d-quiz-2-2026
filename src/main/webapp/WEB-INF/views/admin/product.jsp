<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Product Management — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <c:set var="isAdminPage" value="true" scope="request"/>
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-3 sm:p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <c:set var="active" value="product" scope="request"/>
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-8">
                        <h1 class="text-xl sm:text-2xl md:text-[32px] font-bold leading-tight text-black">Product Management</h1>

                        <a href="${pageContext.request.contextPath}/admin/add-product"
                           class="mt-4 sm:mt-6 inline-flex h-9 sm:h-11 items-center justify-center rounded-lg bg-warning px-3 sm:px-4 text-xs sm:text-sm md:text-base font-medium text-white transition duration-200 hover:brightness-95 focus-visible:brightness-95 outline-none">
                            Add Product
                        </a>

                        <div class="mt-4 sm:mt-5 grid grid-cols-2 gap-2.5 sm:gap-3.5 md:[grid-template-columns:repeat(auto-fill,minmax(min(100%,200px),1fr))]">
                            <c:forEach var="product" items="${products}">
                                <article class="flex flex-col rounded-xl border border-sand bg-white p-2 sm:p-2.5 shadow-xs transition hover:shadow-md">
                                    <div class="relative w-full aspect-[3/4] overflow-hidden rounded-lg bg-white">
                                        <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                                             alt="${product.name}" loading="lazy" class="h-full w-full object-contain">
                                    </div>

                                    <div class="flex-1 px-0.5 pt-1.5 pb-1 sm:pt-2 sm:pb-2">
                                        <p class="text-[11px] sm:text-xs md:text-sm font-light uppercase leading-snug text-ink truncate" title="${product.name}">${product.name}</p>
                                        <p class="mt-0.5 text-xs sm:text-sm font-light leading-tight text-brand-text">IDR ${product.formattedPrice}</p>
                                    </div>

                                    <div class="flex gap-1.5 pt-1">
                                        <a href="${pageContext.request.contextPath}/admin/edit-product?id=${product.id}"
                                           class="flex h-7 sm:h-8 flex-1 items-center justify-center rounded bg-sage text-[11px] sm:text-xs font-light text-white transition hover:brightness-95">
                                            Edit
                                        </a>

                                        <form method="POST" action="${pageContext.request.contextPath}/admin/delete-product" class="flex-1"
                                              onsubmit="return confirm('Remove this product?')">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <button type="submit"
                                                    class="flex h-7 sm:h-8 w-full cursor-pointer items-center justify-center rounded bg-danger text-[11px] sm:text-xs font-light text-white transition hover:brightness-95">
                                                Remove
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
