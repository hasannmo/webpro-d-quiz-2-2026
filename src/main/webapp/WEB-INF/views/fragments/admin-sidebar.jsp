<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div data-admin-menu-root class="w-full md:w-[240px] md:sticky md:top-20 md:z-10 md:self-start">
    <!-- Mobile Hamburger Trigger & Active Tab Bar -->
    <div class="flex items-center justify-between rounded-xl bg-brand-soft p-3 md:hidden">
        <div class="flex items-center gap-2.5">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="text-brand-text">
                <rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/>
            </svg>
            <span class="text-sm font-semibold capitalize text-ink">
                Admin : ${active}
            </span>
        </div>

        <button type="button" data-mobile-menu-btn aria-expanded="false" aria-label="Toggle admin navigation"
                class="flex h-9 w-9 items-center justify-center rounded-lg bg-white/80 text-ink shadow-xs transition hover:bg-white active:scale-95">
            <svg data-icon-bars xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="4" x2="20" y1="12" y2="12"/><line x1="4" x2="20" y1="6" y2="6"/><line x1="4" x2="20" y1="18" y2="18"/>
            </svg>
            <svg data-icon-close class="hidden" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M18 6 6 18"/><path d="m6 6 12 12"/>
            </svg>
        </button>
    </div>

    <!-- Menu List (Collapsible on Mobile, Static on Desktop) -->
    <nav aria-label="Dashboard menu"
         data-mobile-menu
         class="hidden mt-2 rounded-xl bg-brand-soft p-2.5 md:mt-0 md:block md:rounded-2xl md:p-5 md:py-8 shadow-xs md:shadow-none">
        <ul class="flex flex-col gap-1.5 md:gap-2.5">
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 focus-visible:bg-white/60 outline-none ${active == 'dashboard' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-6 md:w-6">
                        <rect width="7" height="9" x="3" y="3" rx="1"/><rect width="7" height="5" x="14" y="3" rx="1"/><rect width="7" height="9" x="14" y="12" rx="1"/><rect width="7" height="5" x="3" y="16" rx="1"/>
                    </svg>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/order"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 focus-visible:bg-white/60 outline-none ${active == 'order' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-6 md:w-6">
                        <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/>
                    </svg>
                    <span>Order</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/product"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 focus-visible:bg-white/60 outline-none ${active == 'product' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-6 md:w-6">
                        <path d="M2.97 12.92A2 2 0 0 0 2 14.63v3.24a2 2 0 0 0 .97 1.71l3 1.8a2 2 0 0 0 2.06 0L12 19v-5.5l-5-3-4.03 2.42Z"/><path d="m7 16.5-4.74-2.85"/><path d="m7 16.5 5-3"/><path d="M7 16.5v5.17"/><path d="M12 13.5V19l3.97 2.38a2 2 0 0 0 2.06 0l3-1.8a2 2 0 0 0 .97-1.71v-3.24a2 2 0 0 0-.97-1.71L17 10.5l-5 3Z"/><path d="m17 16.5-5-3"/><path d="m17 16.5 4.74-2.85"/><path d="M17 16.5v5.17"/><path d="M7.97 4.42A2 2 0 0 0 7 6.13v4.37l5 3 5-3V6.13a2 2 0 0 0-.97-1.71l-3-1.8a2 2 0 0 0-2.06 0l-3 1.8Z"/><path d="M12 8 7.26 5.15"/><path d="m12 8 4.74-2.85"/><path d="M12 13.5V8"/>
                    </svg>
                    <span>Product</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/account"
                   class="flex items-center gap-3 rounded-lg px-3.5 py-2.5 text-sm md:text-base leading-tight text-black transition-colors duration-200 hover:bg-white/60 focus-visible:bg-white/60 outline-none ${active == 'account' ? 'bg-white font-semibold text-brand-text shadow-xs' : 'font-normal'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" class="md:h-6 md:w-6">
                        <circle cx="12" cy="5" r="1"/><path d="m9 20 3-6 3 6"/><path d="m6 8 6 2 6-2"/><path d="M12 10v4"/>
                    </svg>
                    <span>Account</span>
                </a>
            </li>
        </ul>
    </nav>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('[data-admin-menu-root]').forEach((root) => {
            const btn = root.querySelector('[data-mobile-menu-btn]');
            const menu = root.querySelector('[data-mobile-menu]');
            const iconBars = root.querySelector('[data-icon-bars]');
            const iconClose = root.querySelector('[data-icon-close]');

            if (!btn || !menu) return;

            btn.addEventListener('click', () => {
                const isClosed = menu.classList.contains('hidden');
                menu.classList.toggle('hidden', !isClosed);
                if (iconBars) iconBars.classList.toggle('hidden', isClosed);
                if (iconClose) iconClose.classList.toggle('hidden', !isClosed);
                btn.setAttribute('aria-expanded', isClosed ? 'true' : 'false');
            });
        });
    });
</script>
