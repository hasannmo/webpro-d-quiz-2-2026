<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Shopping Cart — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-6 md:py-14">
            <div class="section__inner max-w-5xl mx-auto">
                <div class="mb-6 flex items-center justify-between">
                    <div class="flex items-center gap-3 sm:gap-4">
                        <a href="${pageContext.request.contextPath}/"
                           class="inline-flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                           aria-label="Back to home">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="sm:h-5 sm:w-5">
                                <line x1="19" y1="12" x2="5" y2="12"></line>
                                <polyline points="12 19 5 12 12 5"></polyline>
                            </svg>
                        </a>
                        <h1 class="font-serif text-2xl font-semibold text-ink sm:text-3xl md:text-4xl">
                            Shopping Cart
                        </h1>
                    </div>
                    <span class="text-sm sm:text-base text-muted font-medium">
                        ${totalItems} items
                    </span>
                </div>

                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <div class="grid grid-cols-1 gap-8 lg:grid-cols-3">
                            <!-- Cart Items List -->
                            <div class="lg:col-span-2 space-y-4">
                                <div class="rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)]">
                                    <ul class="divide-y divide-sand/70">
                                        <c:forEach var="item" items="${cartItems}">
                                            <li class="py-4 first:pt-0 last:pb-0 flex flex-col sm:flex-row sm:items-center justify-between gap-4" id="cart-item-${item.id}">
                                                <div class="flex items-center gap-4">
                                                    <a href="${pageContext.request.contextPath}/product/${item.product.slug}" class="shrink-0">
                                                        <div class="h-20 w-20 sm:h-24 sm:w-24 overflow-hidden rounded-xl border border-sand bg-cream flex items-center justify-center p-2">
                                                            <img src="${pageContext.request.contextPath}/assets/images/${item.product.image}"
                                                                 alt="${item.product.name}"
                                                                 class="h-full w-full object-contain">
                                                        </div>
                                                    </a>
                                                    <div class="min-w-0 flex-1">
                                                        <a href="${pageContext.request.contextPath}/product/${item.product.slug}"
                                                           class="font-heading text-sm sm:text-base font-medium text-ink hover:text-brand-text line-clamp-1">
                                                            ${item.product.name}
                                                        </a>
                                                        <p class="mt-1 text-xs sm:text-sm font-semibold text-brand-text">
                                                            IDR ${item.product.formattedPrice}
                                                        </p>
                                                    </div>
                                                </div>

                                                <div class="flex items-center justify-between sm:justify-end gap-6 pt-2 sm:pt-0 border-t sm:border-t-0 border-sand/50">
                                                    <!-- Quantity Controls -->
                                                    <div class="flex items-center rounded-lg border border-sand bg-cream">
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="POST" class="inline">
                                                            <input type="hidden" name="id" value="${item.id}">
                                                            <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                                            <button type="submit"
                                                                    class="px-2.5 py-1 text-sm font-bold text-ink hover:bg-sand/30 disabled:opacity-40"
                                                                    ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
                                                        </form>
                                                        <span class="px-3 py-1 text-xs sm:text-sm font-semibold text-ink">${item.quantity}</span>
                                                        <form action="${pageContext.request.contextPath}/cart/update" method="POST" class="inline">
                                                            <input type="hidden" name="id" value="${item.id}">
                                                            <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                                            <button type="submit" class="px-2.5 py-1 text-sm font-bold text-ink hover:bg-sand/30">+</button>
                                                        </form>
                                                    </div>

                                                    <div class="text-right min-w-[100px]">
                                                        <span class="text-xs text-muted block sm:hidden">Total</span>
                                                        <span class="text-sm sm:text-base font-semibold text-ink">
                                                            IDR ${item.formattedSubtotal}
                                                        </span>
                                                    </div>

                                                    <!-- Delete Button -->
                                                    <form action="${pageContext.request.contextPath}/cart/remove" method="POST" class="inline"
                                                          onsubmit="return confirm('Remove this item from your cart?')">
                                                        <input type="hidden" name="id" value="${item.id}">
                                                        <button type="submit"
                                                                class="p-1.5 text-muted hover:text-red-600 transition"
                                                                aria-label="Remove item">
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/>
                                                            </svg>
                                                        </button>
                                                    </form>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>

                            <!-- Order Summary -->
                            <div class="lg:col-span-1">
                                <div class="sticky top-24 rounded-2xl border border-sand bg-white p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)]">
                                    <h2 class="font-serif text-xl font-semibold text-ink border-b border-sand pb-4">
                                        Order Summary
                                    </h2>

                                    <div class="mt-4 space-y-3 text-sm">
                                        <div class="flex justify-between text-muted">
                                            <span>Subtotal (${totalItems} items)</span>
                                            <span class="font-medium text-ink">IDR ${String.format("%,d", subtotal).replace(',', '.')}</span>
                                        </div>
                                        <div class="flex justify-between text-muted">
                                            <span>Shipping Estimate</span>
                                            <span class="font-medium text-ink">Free</span>
                                        </div>
                                        <div class="border-t border-sand pt-4 flex justify-between font-serif text-lg font-bold text-ink">
                                            <span>Total</span>
                                            <span class="text-brand-text">IDR ${String.format("%,d", subtotal).replace(',', '.')}</span>
                                        </div>
                                    </div>

                                    <form action="${pageContext.request.contextPath}/cart/checkout" method="POST" class="mt-6">
                                        <button type="submit"
                                                class="w-full inline-flex h-12 items-center justify-center rounded-xl bg-brand px-6 font-medium text-white shadow-md transition hover:bg-brand-dark focus:outline-none">
                                            Proceed to Checkout
                                        </button>
                                    </form>

                                    <div class="mt-4 text-center">
                                        <a href="${pageContext.request.contextPath}/" class="text-xs sm:text-sm text-muted hover:text-brand underline">
                                            Continue Shopping
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm">
                            <div class="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-cream text-muted mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
                                </svg>
                            </div>
                            <p class="font-serif text-xl sm:text-2xl font-semibold text-ink">Your cart is empty</p>
                            <p class="mt-2 text-sm text-muted max-w-md mx-auto">Looks like you haven't added any curated pieces to your bag yet.</p>
                            <a href="${pageContext.request.contextPath}/"
                               class="mt-6 inline-flex h-11 items-center justify-center rounded-lg bg-brand px-6 text-sm font-medium text-white transition hover:bg-brand-dark">
                                Discover Products
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
