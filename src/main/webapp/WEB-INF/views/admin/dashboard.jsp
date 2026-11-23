<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Dashboard — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-6 shadow-sm md:p-8">
                        <h1 class="text-2xl sm:text-3xl font-bold leading-tight text-ink">Dashboard Overview</h1>

                        <div class="mt-8 grid grid-cols-1 gap-6 sm:grid-cols-3">
                            <div class="rounded-xl border border-sand bg-cream p-6">
                                <span class="text-xs font-semibold uppercase text-muted">Total Products</span>
                                <p class="mt-2 text-3xl font-bold text-ink">${totalProduct}</p>
                                <a href="${pageContext.request.contextPath}/admin/product" class="mt-4 inline-block text-xs font-semibold text-brand hover:underline">
                                    Manage Products &rarr;
                                </a>
                            </div>

                            <div class="rounded-xl border border-sand bg-cream p-6">
                                <span class="text-xs font-semibold uppercase text-muted">Total Orders</span>
                                <p class="mt-2 text-3xl font-bold text-ink">${totalOrder}</p>
                                <a href="${pageContext.request.contextPath}/admin/order" class="mt-4 inline-block text-xs font-semibold text-brand hover:underline">
                                    Manage Orders &rarr;
                                </a>
                            </div>

                            <div class="rounded-xl border border-sand bg-cream p-6">
                                <span class="text-xs font-semibold uppercase text-muted">Registered Users</span>
                                <p class="mt-2 text-3xl font-bold text-ink">${totalUser}</p>
                                <a href="${pageContext.request.contextPath}/admin/account" class="mt-4 inline-block text-xs font-semibold text-brand hover:underline">
                                    Manage Accounts &rarr;
                                </a>
                            </div>
                        </div>

                        <div class="mt-10 border-t border-sand pt-6">
                            <h2 class="text-lg font-bold text-ink mb-4">Quick Shortcuts</h2>
                            <div class="flex flex-wrap gap-4">
                                <a href="${pageContext.request.contextPath}/admin/add-product"
                                   class="rounded-xl bg-brand px-5 py-2.5 text-sm font-medium text-white shadow-sm hover:bg-brand-dark">
                                    + Add New Product
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/add-user"
                                   class="rounded-xl border border-sand bg-white px-5 py-2.5 text-sm font-medium text-ink hover:bg-cream">
                                    + Add New User
                                </a>
                                <a href="${pageContext.request.contextPath}/"
                                   class="rounded-xl border border-sand bg-white px-5 py-2.5 text-sm font-medium text-ink hover:bg-cream">
                                    View Storefront
                                </a>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
