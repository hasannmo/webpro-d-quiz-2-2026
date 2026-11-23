<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="${product.name} — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section pt-4 pb-10 sm:pt-6 sm:pb-16">
            <div class="section__inner max-w-6xl mx-auto px-4">
                <div class="mb-4 sm:mb-6 flex items-center">
                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                       aria-label="Back to home">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                </div>

                <div class="grid grid-cols-1 items-start gap-6 sm:gap-10 md:grid-cols-2 md:gap-14 lg:gap-20">
                    <div class="flex w-full items-center justify-center rounded-2xl bg-white p-6 sm:p-8 md:p-14 shadow-[0_4px_20px_rgb(43_36_32/0.05)]">
                        <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                             alt="${product.name}"
                             class="aspect-square max-h-[300px] sm:max-h-[380px] md:max-h-[460px] w-full object-contain">
                    </div>

                    <div class="flex flex-col justify-center pt-1 md:pt-6">
                        <span class="text-xs font-semibold uppercase tracking-wider text-muted">${product.category}</span>
                        <h1 class="mt-2 font-serif text-2xl font-bold text-ink sm:text-3xl md:text-4xl">
                            ${product.name}
                        </h1>
                        <p class="mt-4 font-serif text-2xl sm:text-3xl font-semibold text-brand-text">
                            IDR ${product.formattedPrice}
                        </p>

                        <p class="mt-6 text-sm sm:text-base leading-relaxed text-ink/80">
                            ${empty product.description ? 'High-quality garment crafted for comfort and long-lasting minimalist elegance.' : product.description}
                        </p>

                        <!-- Action Buttons: Add to Cart, Buy Now, Wishlist -->
                        <div class="mt-8 flex flex-col gap-3 sm:flex-row sm:items-center">
                            <!-- Add to Cart Form -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="POST" class="flex-1">
                                <input type="hidden" name="product_id" value="${product.id}">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit"
                                        class="w-full inline-flex h-12 items-center justify-center rounded-xl bg-brand px-6 font-medium text-white shadow-md transition hover:bg-brand-dark focus:outline-none">
                                    Add to Cart
                                </button>
                            </form>

                            <!-- Direct Checkout -->
                            <a href="${pageContext.request.contextPath}/checkout/${product.slug}"
                               class="inline-flex h-12 items-center justify-center rounded-xl border border-sand bg-white px-6 font-medium text-ink transition hover:bg-cream-dark">
                                Buy Now
                            </a>

                            <!-- Wishlist Toggle -->
                            <form action="${pageContext.request.contextPath}/wishlist/${product.id}/toggle" method="POST">
                                <input type="hidden" name="productId" value="${product.id}">
                                <button type="submit"
                                        class="inline-flex h-12 w-12 items-center justify-center rounded-xl border border-sand bg-white transition hover:bg-cream-dark ${isWishlisted ? 'text-red-500' : 'text-ink'}"
                                        title="${isWishlisted ? 'Remove from Wishlist' : 'Add to Wishlist'}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="${isWishlisted ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Recommendations -->
                <div class="mt-16 sm:mt-24 border-t border-sand pt-10">
                    <h2 class="font-serif text-2xl font-bold text-ink sm:text-3xl mb-6">You May Also Like</h2>
                    <div class="grid grid-cols-2 gap-4 sm:grid-cols-4">
                        <c:forEach var="rec" items="${recommendations}">
                            <article class="flex flex-col rounded-xl border border-sand bg-white p-3 shadow-xs transition hover:shadow-md">
                                <a href="${pageContext.request.contextPath}/product/${rec.slug}" class="aspect-square w-full overflow-hidden rounded-lg bg-cream">
                                    <img src="${pageContext.request.contextPath}/assets/images/${rec.image}"
                                         alt="${rec.name}" loading="lazy" class="h-full w-full object-contain p-2">
                                </a>
                                <h3 class="mt-2 text-xs sm:text-sm font-medium text-ink truncate">
                                    <a href="${pageContext.request.contextPath}/product/${rec.slug}">${rec.name}</a>
                                </h3>
                                <p class="mt-1 text-xs font-semibold text-brand-text">IDR ${rec.formattedPrice}</p>
                            </article>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="fragments/footer.jsp" />
</body>
</html>
