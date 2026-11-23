<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Wishlist — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-8">
            <div class="section__inner max-w-6xl mx-auto px-4">
                <div class="mb-6 flex items-center justify-between border-b border-sand pb-4">
                    <h1 class="font-serif text-2xl font-bold text-ink sm:text-3xl">My Wishlist</h1>
                    <span class="text-sm text-muted">${wishlistItems.size()} items saved</span>
                </div>

                <c:choose>
                    <c:when test="${not empty wishlistItems}">
                        <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4">
                            <c:forEach var="item" items="${wishlistItems}">
                                <article class="flex flex-col rounded-xl border border-sand bg-white p-3 shadow-xs transition hover:shadow-md">
                                    <a href="${pageContext.request.contextPath}/product/${item.product.slug}" class="aspect-square w-full overflow-hidden rounded-lg bg-cream">
                                        <img src="${pageContext.request.contextPath}/assets/images/${item.product.image}"
                                             alt="${item.product.name}" class="h-full w-full object-contain p-2">
                                    </a>
                                    <h3 class="mt-2 text-xs sm:text-sm font-medium text-ink truncate">
                                        <a href="${pageContext.request.contextPath}/product/${item.product.slug}">${item.product.name}</a>
                                    </h3>
                                    <p class="mt-1 text-xs font-semibold text-brand-text">IDR ${item.product.formattedPrice}</p>

                                    <div class="mt-3 flex gap-2">
                                        <form action="${pageContext.request.contextPath}/cart/add" method="POST" class="flex-1">
                                            <input type="hidden" name="product_id" value="${item.product.id}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="w-full rounded bg-brand py-1.5 text-xs font-medium text-white transition hover:bg-brand-dark">
                                                Add to Cart
                                            </button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/wishlist/${item.product.id}/toggle" method="POST">
                                            <input type="hidden" name="productId" value="${item.product.id}">
                                            <button type="submit" class="rounded border border-sand p-1.5 text-muted hover:text-red-500" title="Remove">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="currentColor" stroke="currentColor" stroke-width="2">
                                                    <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>
                                                </svg>
                                            </button>
                                        </form>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm">
                            <p class="font-serif text-xl font-semibold text-ink">Your wishlist is empty</p>
                            <p class="mt-2 text-sm text-muted">Save items you love and find them here anytime.</p>
                            <a href="${pageContext.request.contextPath}/" class="mt-6 inline-flex rounded-lg bg-brand px-6 py-2.5 text-sm font-medium text-white hover:bg-brand-dark">
                                Browse Store
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <jsp:include page="fragments/footer.jsp" />
</body>
</html>
