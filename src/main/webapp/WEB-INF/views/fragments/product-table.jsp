<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="grid grid-cols-2 gap-2.5 sm:gap-3.5 md:gap-4 md:grid-cols-[repeat(auto-fill,minmax(min(100%,240px),1fr))]">
    <c:forEach var="item" items="${items}">
        <a href="${item.href}"
           class="group relative flex flex-col w-full rounded-xl bg-white p-3 sm:p-5 md:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] transition-shadow duration-200 hover:shadow-[0_8px_28px_rgb(43_36_32/0.10)] focus-visible:shadow-[0_8px_28px_rgb(43_36_32/0.10)] outline-none overflow-hidden">
            <div class="relative w-full aspect-[3/4] bg-white flex items-center justify-center">
                <img src="${item.image}" alt="${item.name}" loading="lazy" class="block h-full w-full object-contain">

                <c:if test="${not empty item.secondImage and item.secondImage != item.image}">
                    <img src="${item.secondImage}" alt="" loading="lazy"
                         class="absolute inset-0 block h-full w-full object-contain opacity-0 transition-opacity duration-300 group-hover:opacity-100 group-focus-visible:opacity-100">
                </c:if>

                <!-- Desktop Hover Overlay -->
                <div class="hidden md:block absolute inset-x-0 bottom-0 bg-white/95 px-3 py-2.5 backdrop-blur-[2px] opacity-0 translate-y-1 transition duration-200 group-hover:opacity-100 group-hover:translate-y-0 group-focus-visible:opacity-100 group-focus-visible:translate-y-0">
                    <p class="text-sm md:text-base font-light uppercase leading-snug text-black truncate" title="${item.name}">${item.name}</p>
                    <p class="mt-0.5 text-sm md:text-base font-light leading-tight text-brand-text">IDR ${item.formattedPrice}</p>
                </div>
            </div>

            <!-- Mobile Info Below Image -->
            <div class="md:hidden mt-2.5 pt-1.5 border-t border-sand/40 flex flex-col">
                <p class="text-[11px] sm:text-xs font-light uppercase leading-tight text-ink truncate" title="${item.name}">${item.name}</p>
                <p class="mt-0.5 text-xs sm:text-sm font-medium leading-tight text-brand-text">IDR ${item.formattedPrice}</p>
            </div>
        </a>
    </c:forEach>
</div>
