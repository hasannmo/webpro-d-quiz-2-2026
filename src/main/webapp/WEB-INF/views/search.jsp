<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="${not empty query ? 'Search results for \"'.concat(query).concat('\"') : 'Search Products'} — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-6 md:py-14">
            <div class="section__inner">
                <div class="mb-6 flex flex-col gap-2 border-b border-sand pb-4 md:mb-8 md:pb-6">
                    <div class="flex items-center gap-3 md:gap-4">
                        <a href="${pageContext.request.contextPath}/"
                           class="inline-flex h-9 w-9 md:h-10 md:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                           aria-label="Back to home">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-5 md:w-5">
                                <line x1="19" y1="12" x2="5" y2="12"></line>
                                <polyline points="12 19 5 12 12 5"></polyline>
                            </svg>
                        </a>
                        <h1 class="font-serif text-2xl font-semibold text-ink sm:text-3xl md:text-4xl">
                            <c:choose>
                                <c:when test="${not empty query}">
                                    Search Results for &ldquo;${query}&rdquo;
                                </c:when>
                                <c:otherwise>
                                    Search Products
                                </c:otherwise>
                            </c:choose>
                        </h1>
                    </div>

                    <c:if test="${not empty query}">
                        <p class="text-xs md:text-sm text-muted ml-12 md:ml-14">
                            Found ${products.size()} ${products.size() == 1 ? 'product' : 'products'}
                        </p>
                    </c:if>
                </div>

                <c:choose>
                    <c:when test="${not empty products}">
                        <c:set var="items" value="${products}" scope="request"/>
                        <jsp:include page="fragments/product-table.jsp" />
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center shadow-sm max-w-2xl mx-auto">
                            <span class="inline-flex h-16 w-16 items-center justify-center rounded-full bg-cream-dark text-muted mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="11" cy="11" r="7.5"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
                                </svg>
                            </span>
                            <h2 class="font-heading text-xl font-medium text-ink">
                                <c:choose>
                                    <c:when test="${not empty query}">
                                        No products match your search &ldquo;${query}&rdquo;
                                    </c:when>
                                    <c:otherwise>
                                        Enter a search keyword
                                    </c:otherwise>
                                </c:choose>
                            </h2>
                            <p class="mt-2 text-sm text-muted">Try checking for spelling errors or searching for broader terms like "shirt", "blazer", "denim", or "jacket".</p>
                            <a href="${pageContext.request.contextPath}/"
                               class="mt-6 inline-flex h-11 items-center justify-center rounded-lg bg-brand px-6 text-sm font-medium text-white transition hover:bg-brand-dark">
                                Browse All Products
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
