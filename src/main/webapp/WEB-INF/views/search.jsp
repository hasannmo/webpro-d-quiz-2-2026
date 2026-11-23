<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Search Results — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-8">
            <div class="section__inner max-w-[1440px] mx-auto px-4 md:px-8">
                <div class="border-b border-sand pb-4 mb-6">
                    <h1 class="font-serif text-2xl font-bold text-ink sm:text-3xl">Search Results</h1>
                    <p class="text-sm text-muted mt-1">
                        Showing results for <span class="font-semibold text-ink">"${query}"</span> (${products.size()} found)
                    </p>
                </div>

                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4">
                            <c:forEach var="p" items="${products}">
                                <article class="flex flex-col rounded-2xl border border-sand bg-white p-3 sm:p-4 shadow-sm hover:shadow-md transition">
                                    <a href="${pageContext.request.contextPath}/product/${p.slug}" class="aspect-square w-full overflow-hidden rounded-xl bg-cream">
                                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                             alt="${p.name}" class="h-full w-full object-contain p-2">
                                    </a>
                                    <span class="mt-3 text-[11px] uppercase tracking-wider text-muted">${p.category}</span>
                                    <h3 class="mt-1 font-heading text-sm font-medium text-ink truncate">
                                        <a href="${pageContext.request.contextPath}/product/${p.slug}">${p.name}</a>
                                    </h3>
                                    <p class="mt-2 text-sm font-bold text-brand-text">IDR ${p.formattedPrice}</p>
                                </article>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="rounded-2xl border border-sand bg-white p-12 text-center">
                            <p class="font-serif text-xl font-semibold text-ink">No products found</p>
                            <p class="text-sm text-muted mt-2">Try different search keywords or explore categories on the home page.</p>
                            <a href="${pageContext.request.contextPath}/" class="mt-6 inline-flex rounded-lg bg-brand px-6 py-2.5 text-sm font-medium text-white hover:bg-brand-dark">
                                Back to Home
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
