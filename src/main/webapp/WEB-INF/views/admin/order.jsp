<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Order Management — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <c:set var="isAdminPage" value="true" scope="request"/>
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-3 sm:p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <c:set var="active" value="order" scope="request"/>
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-8">
                        <!-- Range Select Header -->
                        <jsp:include page="../fragments/admin-range-select.jsp" />

                        <!-- Chart Container -->
                        <div class="mt-3 h-[240px] sm:h-[320px] w-full rounded-lg bg-cream-dark md:h-[500px]">
                            <jsp:include page="../fragments/order-chart.jsp" />
                        </div>

                        <div class="mt-3 flex min-h-[60px] sm:min-h-[76px] items-center border-t border-muted/40 px-1 sm:px-2.5">
                            <p class="text-sm sm:text-base md:text-[18px] font-medium text-black">Total Order : ${String.format("%,d", total).replace(',', '.')}</p>
                        </div>

                        <!-- Responsive Table Container -->
                        <div class="w-full overflow-x-auto [scrollbar-width:thin]">
                            <div class="min-w-[640px] md:min-w-0">
                                <!-- Table Header -->
                                <div class="hidden border-t border-muted/40 px-3 py-3 text-xs font-semibold tracking-wider text-muted uppercase md:grid md:grid-cols-[1.5fr_2fr_1.1fr_1.8fr_1.2fr] md:items-center md:gap-3">
                                    <span>Order ID</span>
                                    <span>Product</span>
                                    <span>Price</span>
                                    <span>Customer Email</span>
                                    <span class="text-right">Date & Time</span>
                                </div>

                                <ul>
                                    <c:forEach var="order" items="${orders}">
                                        <li class="flex flex-col gap-1 border-t border-muted/20 px-2 py-2.5 text-xs md:text-sm font-light text-black md:grid md:min-h-[54px] md:grid-cols-[1.5fr_2fr_1.1fr_1.8fr_1.2fr] md:items-center md:gap-3 md:py-0">
                                            <div class="flex items-center justify-between md:block">
                                                <span class="font-mono text-[11px] md:text-xs font-medium text-ink truncate block" title="${order.orderNumber}">${order.orderNumber}</span>
                                                <span class="text-[10px] md:hidden text-muted whitespace-nowrap">${order.createdAt}</span>
                                            </div>
                                            <span class="font-normal text-ink leading-tight pr-2 truncate block" title="${order.productName}">${order.productName}</span>
                                            <div class="flex items-center justify-between md:block">
                                                <span class="font-medium text-brand-text md:text-ink md:font-normal whitespace-nowrap text-xs md:text-sm">IDR ${order.formattedPrice}</span>
                                                <a href="mailto:${order.customerEmail}" class="w-fit text-brand-text truncate text-xs hover:underline md:hidden" title="${order.customerEmail}">${order.customerEmail}</a>
                                            </div>
                                            <a href="mailto:${order.customerEmail}" class="hidden md:inline-block w-fit text-brand-text truncate hover:underline" title="${order.customerEmail}">${order.customerEmail}</a>
                                            <span class="hidden md:block text-xs text-muted md:text-right whitespace-nowrap">${order.createdAt}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <c:set var="pageBaseUrl" value="${pageContext.request.contextPath}/admin/order?range=${selected}&" scope="request"/>
                        <jsp:include page="../fragments/pagination.jsp" />
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
