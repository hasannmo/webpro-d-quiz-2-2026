<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="relative flex h-full w-full flex-col justify-between p-2.5 sm:p-4 md:p-6" data-chart-root>
    <div class="relative flex-1 w-full min-h-0">
        <svg viewBox="0 0 800 440" class="h-full w-full" preserveAspectRatio="none">
            <defs>
                <linearGradient id="chartGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stop-color="#f47b2c" stop-opacity="0.35" />
                    <stop offset="100%" stop-color="#f47b2c" stop-opacity="0.0" />
                </linearGradient>
            </defs>

            <!-- Grid horizontal lines and Y axis values -->
            <c:forEach var="gl" items="${chart.gridLines}">
                <line x1="52" y1="${gl.y}" x2="764" y2="${gl.y}"
                      stroke="#efe4d8" stroke-dasharray="4 4" stroke-width="1.2" />
                <text x="40" y="${gl.y + 4}"
                      text-anchor="end" fill="#7a6e65" font-size="12" font-family="sans-serif">${gl.val}</text>
            </c:forEach>

            <!-- Filled Area -->
            <polygon points="${chart.areaStr}" fill="url(#chartGradient)" />

            <!-- Line -->
            <polyline fill="none" stroke="#f47b2c" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round" points="${chart.polylineStr}" />

            <!-- Data points & interactive hover targets -->
            <c:forEach var="pt" items="${chart.points}">
                <g class="chart-point-group cursor-pointer group"
                   data-val="${pt.val}"
                   data-label="${pt.label}"
                   data-x="${(pt.x / 800.0) * 100}"
                   data-y="${(pt.y / 440.0) * 100}">

                    <!-- Invisible larger hit area -->
                    <circle cx="${pt.x}" cy="${pt.y}" r="18" fill="transparent" />

                    <!-- Visible circle -->
                    <circle cx="${pt.x}" cy="${pt.y}" r="5.5"
                            fill="#ffffff" stroke="#f47b2c" stroke-width="3.5"
                            class="transition-transform duration-200 group-hover:scale-150 group-hover:stroke-brand-dark"
                            style="transform-origin: ${pt.x}px ${pt.y}px; transform-box: view-box;" />

                    <!-- Axis text -->
                    <text x="${pt.x}" y="420"
                          text-anchor="middle" fill="#7a6e65" font-size="13" font-family="sans-serif"
                          class="transition-colors group-hover:fill-brand-text group-hover:font-semibold">
                        ${pt.label}
                    </text>
                </g>
            </c:forEach>
        </svg>

        <!-- Floating HTML Tooltip -->
        <div data-tooltip hidden
             class="pointer-events-none absolute z-30 whitespace-nowrap rounded-xl border border-sand bg-white/95 px-3 py-1.5 shadow-[0_4px_16px_rgb(43_36_32/0.14)] backdrop-blur-sm transition-[left,top] duration-75">
            <p class="text-xs font-semibold text-brand-text" data-tooltip-val></p>
            <p class="text-[11px] text-muted" data-tooltip-label></p>
        </div>
    </div>
</div>
