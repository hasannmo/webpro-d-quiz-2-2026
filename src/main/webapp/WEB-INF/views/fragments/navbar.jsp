<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="site-header" data-site-header>
    <div class="site-header__inner">
        <a href="${pageContext.request.contextPath}/" class="logo transition-colors duration-300">mijusan</a>

        <form class="search-bar" action="${pageContext.request.contextPath}/search" method="GET" role="search">
            <input type="search" name="q" value="${param.q}"
                   placeholder="Searching for simplicity?"
                   class="desktop-search-input"
                   aria-label="Search">
            <button type="submit" aria-label="Search">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </form>

        <div class="header-icons">
            <div class="header-glass-pill flex items-center gap-2 md:gap-3 px-2 md:px-3.5 py-1 md:py-1.5 rounded-full transition-all duration-300">
                <c:if test="${not empty sessionScope.user}">
                    <span class="hidden md:inline-block text-xs md:text-sm font-medium text-white/95 truncate max-w-[120px]">
                        Hi, ${sessionScope.user.name}!
                    </span>
                </c:if>

                <a href="${empty sessionScope.user ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/wishlist')}"
                   aria-label="Wishlist" class="flex items-center text-white transition-opacity hover:opacity-80">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="md:h-[26px] md:w-[26px]">
                        <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/>
                    </svg>
                </a>

                <a href="${empty sessionScope.user ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart')}"
                   aria-label="Shopping Cart" class="relative flex items-center text-white transition-opacity hover:opacity-80">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="md:h-[26px] md:w-[26px]">
                        <circle cx="8" cy="21" r="1"></circle>
                        <circle cx="19" cy="21" r="1"></circle>
                        <path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"></path>
                    </svg>
                    <c:if test="${cartCount > 0}">
                        <span class="absolute -top-1.5 -right-2 flex h-4 min-w-4 items-center justify-center rounded-full bg-white px-1 text-[10px] font-bold text-brand shadow-xs">
                            ${cartCount > 99 ? '99+' : cartCount}
                        </span>
                    </c:if>
                </a>

                <!-- User dropdown menu -->
                <div data-user-menu class="relative">
                    <button type="button" data-trigger aria-label="Open menu" aria-haspopup="menu" aria-expanded="false"
                            class="flex cursor-pointer items-center justify-center text-white outline-none transition-opacity duration-200 hover:opacity-80 focus-visible:opacity-80">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="4" x2="20" y1="12" y2="12"/><line x1="4" x2="20" y1="6" y2="6"/><line x1="4" x2="20" y1="18" y2="18"/>
                                </svg>
                            </c:when>
                            <c:otherwise>
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                                </svg>
                            </c:otherwise>
                        </c:choose>
                    </button>

                    <div data-menu role="menu" hidden
                         class="absolute right-0 top-full z-50 mt-3 w-[220px] overflow-hidden rounded-xl border border-sand bg-white py-2 shadow-[0_8px_28px_rgb(43_36_32/0.10)]">
                        <a href="${pageContext.request.contextPath}/wishlist" role="menuitem"
                           class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark outline-none">
                            Wishlist
                        </a>
                        <a href="${pageContext.request.contextPath}/cart" role="menuitem"
                           class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark outline-none">
                            Shopping Cart
                        </a>
                        <a href="${pageContext.request.contextPath}/myorder" role="menuitem"
                           class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark outline-none">
                            My Order
                        </a>

                        <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                            <a href="${pageContext.request.contextPath}/admin/order" role="menuitem"
                               class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark outline-none">
                                Manage Orders
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/dashboard" role="menuitem"
                               class="block px-5 py-3 text-base font-normal text-brand-text transition-colors duration-150 hover:bg-cream-dark outline-none font-semibold">
                                Admin Panel
                            </a>
                        </c:if>

                        <div class="my-1 border-t border-sand"></div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <form method="POST" action="${pageContext.request.contextPath}/logout">
                                    <button type="submit" role="menuitem"
                                            class="block w-full cursor-pointer px-5 py-3 text-left text-base font-normal text-danger transition-colors duration-150 hover:bg-cream-dark outline-none">
                                        Log out
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" role="menuitem"
                                   class="block px-5 py-3 text-base font-normal text-brand-text transition-colors duration-150 hover:bg-cream-dark outline-none">
                                    Log In
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const header = document.querySelector('[data-site-header]');
        if (header) {
            const onScroll = () => {
                if (window.scrollY > 20) {
                    header.classList.add('site-header--scrolled');
                } else {
                    header.classList.remove('site-header--scrolled');
                }
            };
            window.addEventListener('scroll', onScroll, { passive: true });
            onScroll();
        }

        document.querySelectorAll('[data-user-menu]').forEach((root) => {
            const trigger = root.querySelector('[data-trigger]');
            const menu = root.querySelector('[data-menu]');
            const close = () => { menu.hidden = true; trigger.setAttribute('aria-expanded', 'false'); };
            const open = () => { menu.hidden = false; trigger.setAttribute('aria-expanded', 'true'); };

            trigger.addEventListener('click', () => (menu.hidden ? open() : close()));
            document.addEventListener('click', (e) => { if (!root.contains(e.target)) close(); });
        });
    });
</script>
