<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Add User — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-6 shadow-sm md:p-9 max-w-2xl">
                        <div class="flex items-center gap-4 border-b border-sand pb-4">
                            <a href="${pageContext.request.contextPath}/admin/account"
                               class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-cream-dark text-ink transition hover:bg-brand hover:text-white">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="19" y1="12" x2="5" y2="12"></line>
                                    <polyline points="12 19 5 12 12 5"></polyline>
                                </svg>
                            </a>
                            <h1 class="text-2xl font-bold leading-tight text-ink">Add User Account</h1>
                        </div>

                        <form method="POST" action="${pageContext.request.contextPath}/admin/add-user" class="mt-6 space-y-6">
                            <div>
                                <label for="name" class="block text-sm font-medium text-ink">Full Name</label>
                                <input type="text" name="name" id="name" required
                                       class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                       placeholder="e.g. John Doe">
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="username" class="block text-sm font-medium text-ink">Username</label>
                                    <input type="text" name="username" id="username"
                                           class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                           placeholder="e.g. johndoe">
                                </div>

                                <div>
                                    <label for="email" class="block text-sm font-medium text-ink">Email Address</label>
                                    <input type="email" name="email" id="email" required
                                           class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                           placeholder="john@example.com">
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="password" class="block text-sm font-medium text-ink">Password</label>
                                    <input type="password" name="password" id="password" required minlength="6"
                                           class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                           placeholder="••••••••">
                                </div>

                                <div>
                                    <label for="role" class="block text-sm font-medium text-ink">Role</label>
                                    <select name="role" id="role"
                                            class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white">
                                        <option value="Customer">Customer</option>
                                        <option value="Administrator">Administrator</option>
                                        <c:if test="${sessionScope.user.creator}">
                                            <option value="Creator">Creator</option>
                                        </c:if>
                                    </select>
                                </div>
                            </div>

                            <div class="flex items-center gap-4 pt-4">
                                <button type="submit"
                                        class="inline-flex h-11 items-center justify-center rounded-xl bg-brand px-6 text-sm font-medium text-white shadow-sm hover:bg-brand-dark">
                                    Create User
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/account" class="text-sm text-muted hover:text-ink">Cancel</a>
                            </div>
                        </form>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
