<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Register — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex flex-1 items-center justify-center p-4 py-12">
        <div class="w-full max-w-md rounded-2xl border border-sand bg-white p-6 sm:p-8 shadow-md">
            <h1 class="font-serif text-2xl sm:text-3xl font-bold text-ink text-center">Create Account</h1>
            <p class="mt-2 text-center text-sm text-muted">Join Mijusan to curate your personal style</p>

            <c:if test="${not empty error}">
                <div class="mt-4 rounded-xl border border-red-200 bg-red-50 p-3 text-xs sm:text-sm text-red-700">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="POST" class="mt-6 space-y-4">
                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Full Name</label>
                    <input type="text" name="name" required
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="Jane Doe">
                </div>

                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Username</label>
                    <input type="text" name="username"
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="janedoe">
                </div>

                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Email Address</label>
                    <input type="email" name="email" required
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="jane@example.com">
                </div>

                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Password</label>
                    <input type="password" name="password" required minlength="6"
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="••••••••">
                </div>

                <div>
                    <label class="block text-xs sm:text-sm font-medium text-ink">Confirm Password</label>
                    <input type="password" name="password_confirmation" required minlength="6"
                           class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-sm text-ink outline-none focus:border-brand focus:bg-white"
                           placeholder="••••••••">
                </div>

                <button type="submit"
                        class="w-full rounded-xl bg-brand py-3 text-sm font-semibold text-white shadow-md transition hover:bg-brand-dark">
                    Register
                </button>
            </form>

            <div class="mt-6 text-center text-xs text-muted">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login" class="font-semibold text-brand hover:underline">Log in</a>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
