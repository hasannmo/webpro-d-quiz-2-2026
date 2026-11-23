<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="My Orders — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-6 md:py-14">
            <div class="section__inner max-w-5xl mx-auto">
                <div class="mb-4 sm:mb-6 flex items-center gap-3 sm:gap-4">
                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                       aria-label="Back to home">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="sm:h-5 sm:w-5">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <h1 class="font-serif text-2xl font-semibold text-ink sm:text-3xl md:text-4xl">
                        My Orders
                    </h1>
                </div>

                <c:choose>
                    <c:when test="${not empty orders}">
                        <div class="rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-8">
                            <div class="hidden border-b border-sand pb-3 text-xs font-semibold tracking-wider text-muted uppercase md:grid md:grid-cols-[1.4fr_2fr_1fr_1fr_1fr] md:gap-4">
                                <span>Order ID</span>
                                <span>Item</span>
                                <span>Price</span>
                                <span>Status</span>
                                <span class="text-right">Date</span>
                            </div>

                            <ul class="divide-y divide-sand/70">
                                <c:forEach var="order" items="${orders}">
                                    <li class="py-3 sm:py-4 md:grid md:grid-cols-[1.4fr_2fr_1fr_1fr_1fr] md:items-center md:gap-4 text-xs sm:text-sm">
                                        <div class="flex items-center justify-between md:block">
                                            <span class="font-mono text-[11px] sm:text-xs md:text-sm font-medium text-ink">${order.orderNumber}</span>
                                            <span class="inline-flex md:hidden items-center rounded-full bg-green-50 px-2 py-0.5 text-[10px] font-medium text-success capitalize border border-green-200">
                                                ${order.status}
                                            </span>
                                        </div>
                                        <div class="mt-1 md:mt-0 font-medium text-ink truncate">
                                            ${order.productName}
                                        </div>
                                        <div class="mt-1 flex items-center justify-between md:mt-0 md:block">
                                            <span class="text-brand-text font-medium whitespace-nowrap text-xs sm:text-sm">IDR ${order.formattedPrice}</span>
                                            <span class="text-[11px] text-muted md:hidden">${order.createdAt}</span>
                                        </div>
                                        <div class="hidden md:block">
                                            <span class="inline-flex items-center rounded-full bg-green-50 px-2.5 py-0.5 text-xs font-medium text-success capitalize border border-green-200">
                                                ${order.status}
                                            </span>
                                        </div>
                                        <span class="hidden md:block text-xs text-muted md:text-right whitespace-nowrap">
                                            ${order.createdAt}
                                        </span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm">
                            <p class="font-heading text-xl font-medium text-ink">You haven't placed any orders yet</p>
                            <p class="mt-2 text-sm text-muted">When you checkout items, your receipts and order histories will appear here.</p>
                            <a href="${pageContext.request.contextPath}/"
                               class="mt-6 inline-flex h-11 items-center justify-center rounded-lg bg-brand px-6 text-sm font-medium text-white transition hover:bg-brand-dark">
                                Start Shopping
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
