<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="${product.name} — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section pt-4 pb-10 sm:pt-6 sm:pb-16">
            <div class="section__inner">
                <div class="mb-4 sm:mb-6 flex items-center">
                    <a href="${pageContext.request.contextPath}/"
                       class="inline-flex h-9 w-9 sm:h-10 sm:w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                       aria-label="Back to home">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="sm:h-5 sm:w-5">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                </div>

                <div class="grid grid-cols-1 items-start gap-6 sm:gap-10 md:grid-cols-2 md:gap-14 lg:gap-20">
                    <div class="flex w-full items-center justify-center rounded-2xl bg-white p-6 sm:p-8 md:p-14 shadow-[0_4px_20px_rgb(43_36_32/0.05)]">
                        <img src="${product.image}"
                             alt="${product.name}"
                             class="aspect-square max-h-[300px] sm:max-h-[380px] md:max-h-[460px] w-full object-contain">
                    </div>

                    <div class="flex flex-col justify-center pt-1 md:pt-6">
                        <div class="w-full">
                            <h1 class="font-heading text-2xl sm:text-3xl md:text-[36px] font-medium leading-tight tracking-tight text-ink">${product.name}</h1>

                            <p class="mt-2 sm:mt-3 font-heading text-xl sm:text-2xl md:text-[28px] font-medium leading-tight text-brand-text">IDR ${product.formattedPrice}</p>

                            <div class="mt-6 sm:mt-8 flex flex-wrap items-center gap-2.5 sm:gap-3">
                                <a href="${pageContext.request.contextPath}/checkout/${product.slug}"
                                   class="inline-flex h-11 sm:h-12 flex-1 sm:flex-initial sm:min-w-[170px] items-center justify-center rounded-lg bg-brand px-6 text-sm sm:text-base font-medium text-white transition-colors duration-200 hover:bg-brand-dark focus-visible:bg-brand-dark outline-none">
                                    Checkout Now
                                </a>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <form action="${pageContext.request.contextPath}/cart/add" method="POST" data-cart-form class="inline-flex">
                                            <input type="hidden" name="product_id" value="${product.id}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit"
                                                    data-cart-button
                                                    class="inline-flex h-11 sm:h-12 items-center justify-center gap-2 rounded-lg border border-brand bg-white px-5 text-sm sm:text-base font-medium text-brand transition-colors duration-200 hover:bg-brand hover:text-white outline-none">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
                                                </svg>
                                                <span>Add to Cart</span>
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login"
                                           class="inline-flex h-11 sm:h-12 items-center justify-center gap-2 rounded-lg border border-brand bg-white px-5 text-sm sm:text-base font-medium text-brand transition-colors duration-200 hover:bg-brand hover:text-white outline-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
                                            </svg>
                                            <span>Add to Cart</span>
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <button type="button"
                                                data-wishlist
                                                data-toggle-url="${pageContext.request.contextPath}/wishlist/${product.id}/toggle"
                                                aria-label="${isWishlisted ? 'Remove from wishlist' : 'Add to wishlist'}"
                                                aria-pressed="${isWishlisted ? 'true' : 'false'}"
                                                class="group flex h-11 w-11 sm:h-12 sm:w-12 shrink-0 cursor-pointer items-center justify-center rounded-lg border bg-transparent transition-colors duration-200 outline-none ${isWishlisted ? 'border-brand text-brand' : 'border-sage text-sage hover:border-brand hover:text-brand'}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="${isWishlisted ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" data-heart>
                                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                                            </svg>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login"
                                           aria-label="Add to wishlist"
                                           class="group flex h-11 w-11 sm:h-12 sm:w-12 shrink-0 items-center justify-center rounded-lg border border-sage bg-transparent text-sage transition-colors duration-200 hover:border-brand hover:text-brand outline-none">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                                            </svg>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div id="cart-notification" class="hidden mt-3 rounded-lg bg-green-50 border border-green-200 px-4 py-2.5 text-xs sm:text-sm font-medium text-green-800 transition-all duration-300">
                                Item added to your cart! <a href="${pageContext.request.contextPath}/cart" class="underline font-semibold ml-1">View Cart</a>
                            </div>

                            <c:if test="${not empty product.description}">
                                <h2 class="mt-6 sm:mt-8 font-heading text-lg sm:text-xl font-medium leading-tight text-ink">Product Description</h2>
                                <p class="mt-1.5 sm:mt-2 whitespace-pre-line text-xs sm:text-sm md:text-base font-normal leading-relaxed text-black/80">${product.description}</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Discover your style (Product Cards) -->
        <c:if test="${not empty discoverProducts}">
            <section class="section pb-12 sm:pb-20">
                <div class="section__inner">
                    <h2 class="mb-4 sm:mb-8 font-serif text-2xl font-semibold text-ink sm:text-3xl md:text-4xl">
                        Discover your style
                    </h2>

                    <div class="grid grid-cols-2 gap-3 sm:gap-4 md:[grid-template-columns:repeat(auto-fill,minmax(min(100%,260px),1fr))]">
                        <c:forEach var="item" items="${discoverProducts}">
                            <a href="${item.href}"
                               class="group relative flex flex-col w-full rounded-xl bg-white p-3 sm:p-5 md:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] transition-shadow duration-200 hover:shadow-[0_8px_28px_rgb(43_36_32/0.10)] focus-visible:shadow-[0_8px_28px_rgb(43_36_32/0.10)] outline-none overflow-hidden">
                                <div class="relative w-full aspect-[3/4] bg-white flex items-center justify-center">
                                    <img src="${item.image}" alt="${item.name}" loading="lazy" class="block h-full w-full object-contain">
                                    <c:if test="${not empty item.secondImage and item.secondImage != item.image}">
                                        <img src="${item.secondImage}" alt="" loading="lazy"
                                             class="absolute inset-0 block h-full w-full object-contain opacity-0 transition-opacity duration-300 group-hover:opacity-100 group-focus-visible:opacity-100">
                                    </c:if>
                                    <div class="hidden md:block absolute inset-x-0 bottom-0 bg-white/95 px-3 py-2.5 backdrop-blur-[2px] opacity-0 translate-y-1 transition duration-200 group-hover:opacity-100 group-hover:translate-y-0 group-focus-visible:opacity-100 group-focus-visible:translate-y-0">
                                        <p class="text-sm md:text-base font-light uppercase leading-snug text-black truncate" title="${item.name}">${item.name}</p>
                                        <p class="mt-0.5 text-sm md:text-base font-light leading-tight text-brand-text">IDR ${item.formattedPrice}</p>
                                    </div>
                                </div>
                                <div class="md:hidden mt-2.5 pt-1.5 border-t border-sand/40 flex flex-col">
                                    <p class="text-[11px] sm:text-xs font-light uppercase leading-tight text-ink truncate" title="${item.name}">${item.name}</p>
                                    <p class="mt-0.5 text-xs sm:text-sm font-medium leading-tight text-brand-text">IDR ${item.formattedPrice}</p>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>
    </main>

    <jsp:include page="fragments/footer.jsp" />

    <script>
        document.querySelectorAll('[data-cart-form]').forEach((form) => {
            form.addEventListener('submit', async (e) => {
                e.preventDefault();
                const button = form.querySelector('[data-cart-button]');
                const origHtml = button.innerHTML;
                button.disabled = true;
                button.innerHTML = '<span>Adding...</span>';

                try {
                    const formData = new FormData(form);
                    const res = await fetch(form.action, {
                        method: 'POST',
                        body: formData,
                        headers: {
                            'Accept': 'application/json'
                        }
                    });

                    if (res.ok) {
                        const data = await res.json();
                        const badge = document.getElementById('cart-count-badge');
                        if (badge) {
                            badge.textContent = data.cart_count || data.cartCount;
                            badge.classList.remove('hidden');
                        }

                        const notif = document.getElementById('cart-notification');
                        if (notif) {
                            notif.classList.remove('hidden');
                            setTimeout(() => {
                                notif.classList.add('hidden');
                            }, 4000);
                        }
                    } else {
                        form.submit();
                    }
                } catch (err) {
                    form.submit();
                } finally {
                    button.disabled = false;
                    button.innerHTML = origHtml;
                }
            });
        });

        document.querySelectorAll('[data-wishlist]').forEach((button) => {
            button.addEventListener('click', async () => {
                const heart = button.querySelector('[data-heart]');
                const toggleUrl = button.dataset.toggleUrl;

                if (toggleUrl) {
                    try {
                        const res = await fetch(toggleUrl, {
                            method: 'POST',
                            headers: {
                                'Accept': 'application/json'
                            }
                        });
                        const data = await res.json();
                        const active = data.isWishlisted;

                        button.setAttribute('aria-pressed', active ? 'true' : 'false');
                        button.setAttribute('aria-label', active ? 'Remove from wishlist' : 'Add to wishlist');
                        heart.classList.toggle('fill-current', active);
                        button.classList.toggle('text-brand', active);
                        button.classList.toggle('border-brand', active);
                        button.classList.toggle('text-sage', !active);
                        button.classList.toggle('border-sage', !active);
                    } catch (e) {
                        console.error('Wishlist toggle error', e);
                    }
                }
            });
        });
    </script>
</body>
</html>
