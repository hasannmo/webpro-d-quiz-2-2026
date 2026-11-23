<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Order Management — mijusan" />
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
                        <div class="border-b border-sand pb-4">
                            <h1 class="text-2xl sm:text-3xl font-bold leading-tight text-ink">Order Management</h1>
                            <p class="text-sm text-muted mt-1">Total: ${total} orders recorded</p>
                        </div>

                        <!-- Orders Table -->
                        <div class="mt-6 overflow-x-auto">
                            <table class="w-full text-left text-sm text-ink">
                                <thead class="border-b border-sand bg-cream-dark text-xs uppercase text-muted">
                                    <tr>
                                        <th class="p-3">Order Number</th>
                                        <th class="p-3">Product</th>
                                        <th class="p-3">Price</th>
                                        <th class="p-3">Customer Email</th>
                                        <th class="p-3">Status</th>
                                        <th class="p-3 text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-sand/70">
                                    <c:forEach var="ord" items="${orders}">
                                        <tr class="hover:bg-cream/50">
                                            <td class="p-3 font-mono font-medium text-brand-text">${ord.orderNumber}</td>
                                            <td class="p-3 font-medium">${ord.productName}</td>
                                            <td class="p-3">IDR ${ord.formattedPrice}</td>
                                            <td class="p-3 text-muted">${ord.customerEmail}</td>
                                            <td class="p-3">
                                                <form action="${pageContext.request.contextPath}/admin/order/update" method="POST" class="inline">
                                                    <input type="hidden" name="id" value="${ord.id}">
                                                    <select name="status" onchange="this.form.submit()"
                                                            class="rounded-lg border border-sand bg-white px-2 py-1 text-xs font-semibold uppercase ${ord.status == 'completed' ? 'text-green-700' : 'text-yellow-700'}">
                                                        <option value="completed" ${ord.status == 'completed' ? 'selected' : ''}>Completed</option>
                                                        <option value="pending" ${ord.status == 'pending' ? 'selected' : ''}>Pending</option>
                                                        <option value="cancelled" ${ord.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                                                    </select>
                                                </form>
                                            </td>
                                            <td class="p-3 text-right">
                                                <form action="${pageContext.request.contextPath}/admin/order/delete" method="POST" class="inline"
                                                      onsubmit="return confirm('Delete order ${ord.orderNumber}?');">
                                                    <input type="hidden" name="id" value="${ord.id}">
                                                    <button type="submit" class="text-xs text-red-600 hover:underline">
                                                        Delete
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="mt-8 flex justify-center gap-2 border-t border-sand pt-6">
                                <c:forEach begin="1" end="${totalPages}" var="pageIndex">
                                    <a href="${pageContext.request.contextPath}/admin/order?page=${pageIndex}"
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
