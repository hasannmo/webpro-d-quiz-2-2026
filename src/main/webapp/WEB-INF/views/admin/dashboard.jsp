<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Dashboard — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <c:set var="isAdminPage" value="true" scope="request"/>
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-3 sm:p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <c:set var="active" value="dashboard" scope="request"/>
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-8">
                        <!-- Range Select Header -->
                        <jsp:include page="../fragments/admin-range-select.jsp" />

                        <!-- Chart Container -->
                        <div class="mt-3 h-[240px] sm:h-[320px] w-full rounded-lg bg-cream-dark md:h-[500px]">
                            <jsp:include page="../fragments/order-chart.jsp" />
                        </div>

                        <!-- Total Order Stat Row -->
                        <div class="mt-3 flex min-h-[64px] sm:min-h-[76px] items-center justify-between gap-3 border-t border-muted/40 px-1 sm:px-2.5">
                            <p class="text-sm sm:text-base md:text-[18px] font-medium text-black">Total Order : ${String.format("%,d", totalOrder).replace(',', '.')}</p>
                            <a href="${pageContext.request.contextPath}/admin/order"
                               class="inline-flex h-9 sm:h-11 shrink-0 items-center justify-center rounded-md bg-sage px-3 text-xs sm:text-sm md:text-base font-light text-white transition duration-200 hover:brightness-95">
                                Manage
                            </a>
                        </div>

                        <!-- Total User Stat Row -->
                        <div class="flex min-h-[64px] sm:min-h-[76px] items-center justify-between gap-3 border-t border-muted/40 px-1 sm:px-2.5">
                            <p class="text-sm sm:text-base md:text-[18px] font-medium text-black">Total User : ${String.format("%,d", totalUser).replace(',', '.')}</p>
                            <a href="${pageContext.request.contextPath}/admin/account"
                               class="inline-flex h-9 sm:h-11 shrink-0 items-center justify-center rounded-md bg-sage px-3 text-xs sm:text-sm md:text-base font-light text-white transition duration-200 hover:brightness-95">
                                Manage
                            </a>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
