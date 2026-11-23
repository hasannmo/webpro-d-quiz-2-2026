<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Sign Up — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-16 md:py-24">
            <div class="mx-auto max-w-md px-4">
                <div class="rounded-2xl border border-sand bg-white p-8 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-10">
                    <div class="flex items-center gap-4 border-b border-sand pb-4">
                        <a href="${pageContext.request.contextPath}/" class="inline-flex h-9 w-9 items-center justify-center rounded-full bg-cream-dark text-ink transition hover:bg-brand hover:text-white" aria-label="Back to home">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="19" y1="12" x2="5" y2="12"></line>
                                <polyline points="12 19 5 12 12 5"></polyline>
                            </svg>
                        </a>
                        <h1 class="font-serif text-3xl font-semibold text-ink">Create Account</h1>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="mt-5 rounded-lg bg-red-50 p-3 text-sm text-red-600 border border-red-200">
                            ${error}
                        </div>
                    </c:if>

                    <form method="POST" action="${pageContext.request.contextPath}/register" class="mt-6 space-y-4">
                        <div>
                            <label for="name" class="block text-sm font-medium text-ink">Full Name</label>
                            <input type="text" name="name" id="name" required autofocus
                                   class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                   placeholder="e.g. Jane Doe">
                        </div>

                        <div>
                            <label for="username" class="block text-sm font-medium text-ink">Username (Optional)</label>
                            <input type="text" name="username" id="username"
                                   class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                   placeholder="e.g. janedoe">
                        </div>

                        <div>
                            <label for="email" class="block text-sm font-medium text-ink">Email Address</label>
                            <input type="email" name="email" id="email" required
                                   class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                   placeholder="your.email@example.com">
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-medium text-ink">Password</label>
                            <input type="password" name="password" id="password" required minlength="6"
                                   class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                   placeholder="At least 6 characters">
                        </div>

                        <div>
                            <label for="password_confirmation" class="block text-sm font-medium text-ink">Confirm Password</label>
                            <input type="password" name="password_confirmation" id="password_confirmation" required minlength="6"
                                   class="mt-1.5 w-full rounded-xl border border-sand bg-cream px-4 py-2.5 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                   placeholder="Repeat password">
                        </div>

                        <button type="submit"
                                class="mt-2 flex h-12 w-full cursor-pointer items-center justify-center rounded-lg bg-brand text-base font-normal text-white transition-colors duration-200 hover:bg-brand-dark focus-visible:bg-brand-dark outline-none">
                            Sign Up
                        </button>
                    </form>

                    <p class="mt-6 text-center text-sm text-muted">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="font-medium text-brand-text hover:underline">Sign In</a>
                    </p>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
