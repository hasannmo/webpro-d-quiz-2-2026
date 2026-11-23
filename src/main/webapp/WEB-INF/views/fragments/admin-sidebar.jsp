<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="w-full md:w-[240px] md:sticky md:top-20 md:z-10 md:self-start">
    <nav aria-label="Dashboard menu"
         class="rounded-xl bg-brand-soft p-3 md:rounded-2xl md:p-5 md:py-8 shadow-xs md:shadow-none">
        <ul class="flex flex-col gap-1.5 md:gap-2.5">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 ${active == 'dashboard' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/>
                    </svg>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/order"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 ${active == 'order' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/>
                    </svg>
                    <span>Order</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/product"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 ${active == 'product' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"/>
                        <path d="m3.3 7 8.7 5 8.7-5"/><path d="M12 22V12"/>
                    </svg>
                    <span>Product</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/account"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 ${active == 'account' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="5" r="1"/><path d="m9 20 3-6 3 6"/><path d="m6 8 6 2 6-2"/><path d="M12 10v4"/>
                    </svg>
                    <span>Account</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
