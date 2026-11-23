<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div data-user-menu class="relative">
    <button type="button" data-trigger aria-label="Open menu" aria-haspopup="menu" aria-expanded="false"
            class="flex cursor-pointer items-center justify-center text-white outline-none transition-opacity duration-200 hover:opacity-80 focus-visible:opacity-80">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <!-- Menu Icon -->
                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/>
                </svg>
            </c:when>
            <c:otherwise>
                <!-- User Icon -->
                <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
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
