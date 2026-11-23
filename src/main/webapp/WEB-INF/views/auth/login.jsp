<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Log In — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex flex-1 items-center justify-center p-4 py-12">
        <div class="w-full max-w-md rounded-2xl border border-sand bg-white p-6 sm:p-8 shadow-md">
            <h1 class="font-serif text-2xl sm:text-3xl font-bold text-ink text-center">Welcome Back</h1>
            <p class="mt-2 text-center text-sm text-muted">Log in to your account to view your orders & cart</p>

            <c:if test="${not empty error}">
                <div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-3 text-xs sm:text-sm text-red-700">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST" class="mt-6 space-y-4">
                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Email or Username</label>
                    <input type="text" name="email" required
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="your@email.com">
                </div>

                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Password</label>
                    <input type="password" name="password" required
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="••••••••">
                </div>

                <button type="submit"
                        class="w-full rounded-xl bg-brand py-3 text-sm font-semibold text-white shadow-md transition hover:bg-brand-dark">
                    Log In
                </button>
            </form>

            <div class="mt-6 text-center text-xs text-muted">
                Don't have an account yet?
                <a href="${pageContext.request.contextPath}/register" class="font-semibold text-brand hover:underline">Register</a>
            </div>

            <div class="mt-6 border-t border-sand pt-4 text-center text-[11px] text-muted">
                Demo accounts: <br>
                Admin: <span class="font-mono text-ink">admin@mijusan.com</span> / <span class="font-mono text-ink">password</span><br>
                Customer: <span class="font-mono text-ink">sarah.smith@example.com</span> / <span class="font-mono text-ink">password</span>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
