<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Home — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <!-- Hero Banner -->
        <section class="relative overflow-hidden bg-white">
            <div class="relative mx-auto flex min-h-[460px] max-w-[1440px] items-center justify-between px-6 py-12 md:px-14">
                <div class="z-10 max-w-xl">
                    <span class="inline-block rounded-full bg-brand-soft px-4 py-1.5 text-xs font-semibold uppercase tracking-wider text-brand-text">
                        New Collection 2026
                    </span>
                    <h1 class="mt-4 font-serif text-4xl font-bold leading-tight text-ink md:text-5xl lg:text-6xl">
                        Searching for simplicity.
                    </h1>
                    <p class="mt-4 text-base text-muted md:text-lg">
                        Thoughtfully designed everyday essentials. Pure fabrics, understated style, and timeless silhouettes.
                    </p>
                    <div class="mt-8 flex gap-4">
                        <a href="#catalog"
                           class="inline-flex h-12 items-center justify-center rounded-xl bg-brand px-8 text-base font-medium text-white shadow-md transition hover:bg-brand-dark">
                            Explore Catalog
                        </a>
                        <a href="${pageContext.request.contextPath}/search"
                           class="inline-flex h-12 items-center justify-center rounded-xl border border-sand bg-white px-8 text-base font-medium text-ink transition hover:bg-cream">
                            Search Products
                        </a>
                    </div>
                </div>
                <div class="hidden md:block w-1/2 max-w-[500px]">
                    <img src="${pageContext.request.contextPath}/assets/images/hero-1.png" alt="Mijusan Fashion" class="w-full object-contain">
                </div>
            </div>
        </section>

        <!-- Category Filter & Product Grid -->
        <section id="catalog" class="section py-10">
            <div class="section__inner max-w-[1440px] mx-auto px-4 md:px-8">
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 border-b border-sand pb-6">
                    <div>
                        <h2 class="font-serif text-2xl font-bold text-ink sm:text-3xl">Curated Collection</h2>
                        <p class="mt-1 text-sm text-muted">Showing all items curated for elegance and everyday wear</p>
                    </div>

                    <!-- Category Pills -->
                    <div class="flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/"
                           class="rounded-full px-4 py-2 text-xs md:text-sm font-medium transition ${selectedCategory == 'all' ? 'bg-brand text-white shadow-sm' : 'bg-white text-ink border border-sand hover:bg-cream-dark'}">
                            All Products
                        </a>
                        <c:forEach var="cat" items="${categories}">
                            <a href="${pageContext.request.contextPath}/?category=${cat.id}"
                               class="rounded-full px-4 py-2 text-xs md:text-sm font-medium transition ${selectedCategory == cat.id ? 'bg-brand text-white shadow-sm' : 'bg-white text-ink border border-sand hover:bg-cream-dark'}">
                                ${cat.name} (${cat.productCount})
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="mt-8 grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-4">
                    <c:forEach var="p" items="${products}">
                        <article class="group flex flex-col rounded-2xl border border-sand bg-white p-3 sm:p-4 shadow-sm transition hover:shadow-lg">
                            <a href="${pageContext.request.contextPath}/product/${p.slug}" class="block relative aspect-square w-full overflow-hidden rounded-xl bg-cream">
                                <img src="${pageContext.request.contextPath}/assets/images/${p.image}"
                                     alt="${p.name}" loading="lazy"
                                     class="h-full w-full object-contain p-2 transition duration-300 group-hover:scale-105">
                            </a>

                            <div class="mt-3 flex flex-1 flex-col justify-between">
                                <div>
                                    <span class="text-[11px] font-semibold uppercase tracking-wider text-muted">${p.category}</span>
                                    <h3 class="mt-1 font-heading text-sm sm:text-base font-medium text-ink line-clamp-1 hover:text-brand-text">
                                        <a href="${pageContext.request.contextPath}/product/${p.slug}">${p.name}</a>
                                    </h3>
                                </div>
                                <div class="mt-3 flex items-center justify-between pt-2 border-t border-sand/60">
                                    <span class="text-xs sm:text-sm font-bold text-brand-text">
                                        IDR ${p.formattedPrice}
                                    </span>
                                    <a href="${pageContext.request.contextPath}/product/${p.slug}"
                                       class="rounded-lg bg-cream px-3 py-1.5 text-xs font-medium text-ink transition hover:bg-brand hover:text-white">
                                        View
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="fragments/footer.jsp" />
</body>
</html>
