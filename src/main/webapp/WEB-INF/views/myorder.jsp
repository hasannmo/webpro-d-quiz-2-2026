<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="My Orders — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-8">
            <div class="section__inner max-w-5xl mx-auto px-4">
                <div class="mb-6 border-b border-sand pb-4">
                    <h1 class="font-serif text-2xl font-bold text-ink sm:text-3xl">My Orders</h1>
                    <p class="mt-1 text-sm text-muted">Track your recent order history and delivery status</p>
                </div>

                <c:choose>
                    <c:when test="${not empty orders}">
                        <div class="space-y-4">
                            <c:forEach var="ord" items="${orders}">
                                <div class="rounded-2xl border border-sand bg-white p-5 shadow-xs">
                                    <div class="flex flex-col sm:flex-row sm:items-center justify-between border-b border-sand pb-3">
                                        <div>
                                            <span class="font-mono text-sm font-semibold text-brand-text">${ord.orderNumber}</span>
                                            <span class="ml-3 text-xs text-muted">${ord.createdAt}</span>
                                        </div>
                                        <span class="mt-2 sm:mt-0 inline-flex items-center rounded-full bg-green-100 px-3 py-0.5 text-xs font-semibold text-green-800 uppercase">
                                            ${ord.status}
                                        </span>
                                    </div>
                                    <div class="mt-4 flex items-center justify-between">
                                        <div>
                                            <h3 class="text-base font-medium text-ink">${ord.productName}</h3>
                                            <p class="text-xs text-muted">${ord.customerEmail}</p>
                                        </div>
                                        <p class="text-base font-bold text-ink">IDR ${ord.formattedPrice}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm">
                            <p class="font-serif text-xl font-semibold text-ink">No orders yet</p>
                            <p class="mt-2 text-sm text-muted">When you place an order, it will appear right here.</p>
                            <a href="${pageContext.request.contextPath}/" class="mt-6 inline-flex rounded-lg bg-brand px-6 py-2.5 text-sm font-medium text-white hover:bg-brand-dark">
                                Shop Now
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
