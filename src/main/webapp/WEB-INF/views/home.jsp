<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Home — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <!-- Hero Banner Carousel -->
        <c:if test="${not empty heroSlides}">
            <section data-hero-banner data-interval="5000" aria-roledescription="carousel"
                class="relative w-full overflow-hidden bg-cream-dark select-none touch-pan-y">
                <div data-track
                    class="flex overflow-x-auto snap-x snap-mandatory [scrollbar-width:none] [-ms-overflow-style:none] [&::-webkit-scrollbar]:hidden transition-transform duration-500 ease-out cursor-grab active:cursor-grabbing">
                    <c:forEach var="slide" items="${heroSlides}" varStatus="status">
                        <div class="w-full shrink-0 snap-start" aria-roledescription="slide">
                            <c:choose>
                                <c:when test="${not empty slide.href}">
                                    <a href="${slide.href}" class="block draggable-false">
                                        <img src="${slide.image}" alt="${slide.alt}"
                                            class="pointer-events-none block h-[260px] w-full object-cover object-center sm:h-[380px] md:h-[540px] lg:h-[700px]"
                                            <c:if test="${!status.first}">loading="lazy"</c:if>>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <img src="${slide.image}" alt="${slide.alt}"
                                        class="pointer-events-none block h-[260px] w-full object-cover object-center sm:h-[380px] md:h-[540px] lg:h-[700px]"
                                        <c:if test="${!status.first}">loading="lazy"</c:if>>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${heroSlides.size() > 1}">
                    <div class="absolute bottom-3 md:bottom-5 left-1/2 flex -translate-x-1/2 items-center gap-2 z-10">
                        <c:forEach var="slide" items="${heroSlides}" varStatus="status">
                            <button type="button" data-dot aria-label="Go to slide ${status.count}"
                                class="h-2 w-2 md:h-2.5 md:w-2.5 cursor-pointer rounded-full transition-all duration-300 ${status.first ? 'bg-brand w-5 md:w-6' : 'bg-white/60'}"></button>
                        </c:forEach>
                    </div>
                </c:if>
            </section>
        </c:if>

        <!-- Main Cards Carousel (Lookbook) -->
        <c:if test="${not empty heroCardItems}">
            <section class="section">
                <div class="section__inner hero-cards-wrap">
                    <div data-main-carousel class="relative">
                        <div data-track
                            class="flex gap-5 overflow-x-auto scroll-smooth snap-x snap-proximity [scrollbar-width:none] [-ms-overflow-style:none] [&::-webkit-scrollbar]:hidden">
                            <c:forEach var="item" items="${heroCardItems}" varStatus="status">
                                <div class="block w-[280px] shrink-0 snap-start md:w-[400px]">
                                    <img src="${item.image}" alt="${item.alt}"
                                        <c:if test="${!status.first}">loading="lazy"</c:if>
                                        class="block aspect-[2/3] w-full bg-cream-dark object-cover">
                                </div>
                            </c:forEach>
                        </div>

                        <button type="button" data-prev aria-label="Previous"
                            class="absolute left-3 top-1/2 z-10 hidden h-11 w-11 -translate-y-1/2 cursor-pointer items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_12px_rgb(43_36_32/0.18)] transition duration-200 hover:bg-brand hover:text-white md:flex">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="m15 18-6-6 6-6" />
                            </svg>
                        </button>

                        <button type="button" data-next aria-label="Next"
                            class="absolute right-3 top-1/2 z-10 hidden h-11 w-11 -translate-y-1/2 cursor-pointer items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_12px_rgb(43_36_32/0.18)] transition duration-200 hover:bg-brand hover:text-white md:flex">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="m9 18 6-6-6-6" />
                            </svg>
                        </button>
                    </div>
                </div>
            </section>
        </c:if>

        <!-- Popular Products -->
        <c:if test="${not empty popularProducts}">
            <section class="section">
                <div class="section__inner">
                    <h2 class="section-title">Popular Product</h2>
                    <c:set var="items" value="${popularProducts}" scope="request"/>
                    <jsp:include page="fragments/product-table.jsp" />
                </div>
            </section>
        </c:if>

        <!-- Top Wear -->
        <c:if test="${not empty topWearProducts}">
            <section class="section">
                <div class="section__inner">
                    <h2 class="section-title">Top Wear</h2>
                    <c:set var="carouselItems" value="${topWearProducts}" scope="request"/>
                    <jsp:include page="fragments/section-carousel.jsp" />
                </div>
            </section>
        </c:if>

        <!-- Outer Wear -->
        <c:if test="${not empty outerWearProducts}">
            <section class="section">
                <div class="section__inner">
                    <h2 class="section-title">Outer Wear</h2>
                    <c:set var="carouselItems" value="${outerWearProducts}" scope="request"/>
                    <jsp:include page="fragments/section-carousel.jsp" />
                </div>
            </section>
        </c:if>

        <!-- Bottom Wear -->
        <c:if test="${not empty bottomWearProducts}">
            <section class="section">
                <div class="section__inner">
                    <h2 class="section-title">Bottom Wear</h2>
                    <c:set var="carouselItems" value="${bottomWearProducts}" scope="request"/>
                    <jsp:include page="fragments/section-carousel.jsp" />
                </div>
            </section>
        </c:if>
    </main>

    <jsp:include page="fragments/footer.jsp" />

    <script>
        // Hero banner autoplay & swipe logic
        document.querySelectorAll('[data-hero-banner]').forEach((banner) => {
            const track = banner.querySelector('[data-track]');
            const dots = banner.querySelectorAll('[data-dot]');
            const total = track.children.length;
            const interval = parseInt(banner.dataset.interval, 10) || 5000;
            const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
            let index = 0;
            let timer = null;

            const updateDots = (activeIdx) => {
                dots.forEach((dot, i) => {
                    const active = i === activeIdx;
                    dot.classList.toggle('bg-brand', active);
                    dot.classList.toggle('w-5', active);
                    dot.classList.toggle('md:w-6', active);
                    dot.classList.toggle('bg-white/60', !active);
                    dot.classList.toggle('w-2', !active);
                    dot.classList.toggle('md:w-2.5', !active);
                    dot.setAttribute('aria-current', active ? 'true' : 'false');
                });
            };

            const scrollToSlide = (next) => {
                index = (next + total) % total;
                const targetLeft = track.clientWidth * index;
                track.scrollTo({ left: targetLeft, behavior: 'smooth' });
                updateDots(index);
            };

            const start = () => {
                if (total < 2 || reduceMotion || timer) return;
                timer = setInterval(() => {
                    scrollToSlide(index + 1);
                }, interval);
            };

            const stop = () => {
                if (timer) {
                    clearInterval(timer);
                    timer = null;
                }
            };

            let isScrolling = null;
            track.addEventListener('scroll', () => {
                stop();
                clearTimeout(isScrolling);
                isScrolling = setTimeout(() => {
                    const newIdx = Math.round(track.scrollLeft / track.clientWidth);
                    if (!isNaN(newIdx) && newIdx >= 0 && newIdx < total) {
                        index = newIdx;
                        updateDots(index);
                    }
                    start();
                }, 120);
            }, { passive: true });

            dots.forEach((dot, i) => {
                dot.addEventListener('click', () => {
                    stop();
                    scrollToSlide(i);
                    start();
                });
            });

            banner.addEventListener('mouseenter', stop);
            banner.addEventListener('mouseleave', start);
            banner.addEventListener('touchstart', stop, { passive: true });
            banner.addEventListener('touchend', start, { passive: true });
            document.addEventListener('visibilitychange', () => (document.hidden ? stop() : start()));

            updateDots(0);
            start();
        });

        // Horizontal carousel controls
        const initCarousel = (carousel) => {
            const track = carousel.querySelector('[data-track]');
            const prev = carousel.querySelector('[data-prev]');
            const next = carousel.querySelector('[data-next]');
            if (!track || !prev || !next) return;

            const hiddenClasses = ['opacity-0', 'pointer-events-none'];
            const toggle = (btn, visible) => {
                hiddenClasses.forEach((c) => btn.classList.toggle(c, !visible));
            };

            const update = () => {
                const max = track.scrollWidth - track.clientWidth - 2;
                toggle(prev, track.scrollLeft > 4);
                toggle(next, track.scrollLeft < max);
            };

            const step = () => Math.max(280, track.clientWidth * 0.75);

            prev.addEventListener('click', () => track.scrollBy({ left: -step(), behavior: 'smooth' }));
            next.addEventListener('click', () => track.scrollBy({ left: step(), behavior: 'smooth' }));
            track.addEventListener('scroll', update, { passive: true });
            window.addEventListener('resize', update, { passive: true });

            update();
            setTimeout(update, 200);
            setTimeout(update, 800);
        };

        document.querySelectorAll('[data-main-carousel]').forEach(initCarousel);
        document.querySelectorAll('[data-section-carousel]').forEach(initCarousel);
    </script>
</body>
</html>
