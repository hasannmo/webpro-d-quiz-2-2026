<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<header class="site-header" data-site-header>
    <div class="site-header__inner">
        <a href="${pageContext.request.contextPath}/" class="logo transition-colors duration-300">mijusan</a>

        <c:choose>
            <c:when test="${!isAdminPage}">
                <form class="search-bar" action="${pageContext.request.contextPath}/search" method="GET" role="search">
                    <input type="search" name="q" value="${param.q}"
                           placeholder="Searching for simplicity?"
                           class="desktop-search-input"
                           aria-label="Search">
                    <button type="submit" aria-label="Search">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <circle cx="11" cy="11" r="7.5"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-[26px] md:w-[26px]" aria-hidden="true">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                            </svg>
                        </a>

                        <a href="${empty sessionScope.user ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart')}"
                           aria-label="Shopping Cart" class="relative flex items-center text-white transition-opacity hover:opacity-80">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-[26px] md:w-[26px]" aria-hidden="true">
                                <circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/>
                            </svg>
                            <c:if test="${cartCount > 0}">
                                <span data-cart-badge class="absolute -top-1.5 -right-2 flex h-4 min-w-4 items-center justify-center rounded-full bg-white px-1 text-[10px] font-bold text-brand shadow-xs">
                                    ${cartCount > 99 ? '99+' : cartCount}
                                </span>
                            </c:if>
                        </a>

                        <div data-user-menu class="relative">
                            <button type="button" data-trigger aria-label="Open menu" aria-haspopup="menu" aria-expanded="false"
                                    class="flex cursor-pointer items-center justify-center text-white outline-none transition-opacity duration-200 hover:opacity-80 focus-visible:opacity-80">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                            <line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/>
                                        </svg>
                                    </c:when>
                                    <c:otherwise>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
                                        </svg>
                                    </c:otherwise>
                                </c:choose>
                            </button>

                            <div data-menu role="menu" hidden
                                 class="absolute right-0 top-full z-50 mt-3 w-[220px] overflow-hidden rounded-xl border border-sand bg-white py-2 shadow-[0_8px_28px_rgb(43_36_32/0.10)]">
                                <a href="${pageContext.request.contextPath}/wishlist" role="menuitem"
                                   class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                    Wishlist
                                </a>

                                <a href="${empty sessionScope.user ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart')}" role="menuitem"
                                   class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                    Shopping Cart
                                </a>

                                <a href="${empty sessionScope.user ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/myorder')}" role="menuitem"
                                   class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                    My Order
                                </a>

                                <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                                    <a href="${pageContext.request.contextPath}/admin/order" role="menuitem"
                                       class="block px-5 py-3 text-base font-normal text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                        Manage Orders
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" role="menuitem"
                                       class="block px-5 py-3 text-base font-normal text-brand-text transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                        Admin Panel
                                    </a>
                                </c:if>

                                <div class="my-1 border-t border-sand"></div>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <form method="POST" action="${pageContext.request.contextPath}/logout">
                                            <button type="submit" role="menuitem"
                                                    class="block w-full cursor-pointer px-5 py-3 text-left text-base font-normal text-danger transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                                Log out
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login" role="menuitem"
                                           class="block px-5 py-3 text-base font-normal text-brand-text transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none">
                                            Log In
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="header-icons">
                    <div class="header-glass-pill px-3.5 py-1.5 rounded-full transition-all duration-300">
                        <a href="${pageContext.request.contextPath}/" class="text-sm font-light text-white hover:underline">View Store</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const header = document.querySelector('[data-site-header]');
        if (!header) return;

        const onScroll = () => {
            if (window.scrollY > 20) {
                header.classList.add('site-header--scrolled');
            } else {
                header.classList.remove('site-header--scrolled');
            }
        };

        const searchInput = header.querySelector('.search-bar input');
        const updatePlaceholder = () => {
            if (!searchInput) return;
            if (window.innerWidth <= 768) {
                searchInput.setAttribute('placeholder', 'Searching for...');
            } else {
                searchInput.setAttribute('placeholder', 'Searching for simplicity?');
            }
        };

        window.addEventListener('scroll', onScroll, { passive: true });
        window.addEventListener('resize', updatePlaceholder, { passive: true });
        onScroll();
        updatePlaceholder();
    });
</script>
