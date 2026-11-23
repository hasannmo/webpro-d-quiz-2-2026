<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Your Wishlist" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-6 md:py-12">
            <div class="section__inner">
                <div class="mb-6 flex items-center gap-3 md:gap-4">
                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex h-9 w-9 md:h-10 md:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                       aria-label="Back to Home">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-5 md:w-5">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                    <h1 class="font-serif text-2xl font-semibold text-ink sm:text-3xl md:text-4xl">
                        Your Wishlist
                    </h1>
                </div>

                <c:choose>
                    <c:when test="${not empty wishlistItems}">
                        <c:set var="items" value="${wishlistItems}" scope="request"/>
                        <jsp:include page="fragments/product-table.jsp" />
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm">
                            <p class="font-heading text-xl font-medium text-ink">Your wishlist is currently empty</p>
                            <p class="mt-2 text-sm text-muted">Explore our catalog and heart your favorite items to save them here.</p>
                            <a href="${pageContext.request.contextPath}/"
                               class="mt-6 inline-flex h-11 items-center justify-center rounded-lg bg-brand px-6 text-sm font-medium text-white transition hover:bg-brand-dark">
                                Discover Products
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
