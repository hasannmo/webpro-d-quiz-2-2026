<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="sel" value="${empty selected ? '7d' : selected}" />
<c:set var="selLabel" value="Last 7 Days" />
<c:if test="${sel == '1m'}"><c:set var="selLabel" value="Last 1 Month" /></c:if>
<c:if test="${sel == '3m'}"><c:set var="selLabel" value="Last 3 Months" /></c:if>
<c:if test="${sel == '6m'}"><c:set var="selLabel" value="Last 6 Months" /></c:if>
<c:if test="${sel == '1y'}"><c:set var="selLabel" value="Last 1 Year" /></c:if>

<div data-range-select data-navigate="true" data-param="range" class="relative inline-block">
    <button type="button" data-trigger aria-haspopup="listbox" aria-expanded="false"
            class="group flex cursor-pointer items-center gap-2 text-base font-normal text-black outline-none focus-visible:text-brand-text">
        <span>Order Over Time : <span data-label class="font-medium text-brand-text">${selLabel}</span></span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"
             class="transition-transform duration-200 group-aria-expanded:rotate-180" aria-hidden="true">
            <path d="m6 9 6 6 6-6" />
        </svg>
    </button>

    <div data-menu role="listbox" hidden
         class="absolute left-0 top-full z-20 mt-2 min-w-[220px] rounded-xl border border-sand bg-white py-1 shadow-[0_8px_28px_rgb(43_36_32/0.10)]">
        <button type="button" role="option" data-value="7d" aria-selected="${sel == '7d' ? 'true' : 'false'}"
                class="block w-full cursor-pointer px-4 py-2 text-left text-base text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none ${sel == '7d' ? 'bg-cream-dark font-medium' : 'font-normal'}">
            Last 7 Days
        </button>
        <button type="button" role="option" data-value="1m" aria-selected="${sel == '1m' ? 'true' : 'false'}"
                class="block w-full cursor-pointer px-4 py-2 text-left text-base text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none ${sel == '1m' ? 'bg-cream-dark font-medium' : 'font-normal'}">
            Last 1 Month
        </button>
        <button type="button" role="option" data-value="3m" aria-selected="${sel == '3m' ? 'true' : 'false'}"
                class="block w-full cursor-pointer px-4 py-2 text-left text-base text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none ${sel == '3m' ? 'bg-cream-dark font-medium' : 'font-normal'}">
            Last 3 Months
        </button>
        <button type="button" role="option" data-value="6m" aria-selected="${sel == '6m' ? 'true' : 'false'}"
                class="block w-full cursor-pointer px-4 py-2 text-left text-base text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none ${sel == '6m' ? 'bg-cream-dark font-medium' : 'font-normal'}">
            Last 6 Months
        </button>
        <button type="button" role="option" data-value="1y" aria-selected="${sel == '1y' ? 'true' : 'false'}"
                class="block w-full cursor-pointer px-4 py-2 text-left text-base text-black transition-colors duration-150 hover:bg-cream-dark focus-visible:bg-cream-dark outline-none ${sel == '1y' ? 'bg-cream-dark font-medium' : 'font-normal'}">
            Last 1 Year
        </button>
    </div>
</div>
