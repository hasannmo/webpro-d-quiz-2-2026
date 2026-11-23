<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="relative w-full h-[240px] sm:h-[320px] md:h-[500px] flex items-end px-6 pb-8 pt-4">
    <!-- SVG Order Chart -->
    <svg viewBox="0 0 800 440" class="w-full h-full overflow-visible" preserveAspectRatio="none">
        <defs>
            <linearGradient id="orderChartGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" stop-color="#CA6531" stop-opacity="0.35"/>
                <stop offset="100%" stop-color="#CA6531" stop-opacity="0.0"/>
            </linearGradient>
        </defs>

        <!-- Horizontal Grid lines -->
        <line x1="52" y1="28" x2="764" y2="28" stroke="#E5E0D8" stroke-width="1" stroke-dasharray="4 4" />
        <line x1="52" y1="118" x2="764" y2="118" stroke="#E5E0D8" stroke-width="1" stroke-dasharray="4 4" />
        <line x1="52" y1="208" x2="764" y2="208" stroke="#E5E0D8" stroke-width="1" stroke-dasharray="4 4" />
        <line x1="52" y1="298" x2="764" y2="298" stroke="#E5E0D8" stroke-width="1" stroke-dasharray="4 4" />
        <line x1="52" y1="388" x2="764" y2="388" stroke="#9A9084" stroke-width="1.5" />

        <!-- Chart Fill and Stroke Curve -->
        <polygon points="52,388 52,310 170,220 288,270 406,140 524,190 642,80 764,110 764,388" fill="url(#orderChartGradient)" />
        <polyline points="52,310 170,220 288,270 406,140 524,190 642,80 764,110" fill="none" stroke="#CA6531" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />

        <!-- Dots -->
        <circle cx="52" cy="310" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="170" cy="220" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="288" cy="270" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="406" cy="140" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="524" cy="190" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="642" cy="80" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>
        <circle cx="764" cy="110" r="5" fill="#CA6531" stroke="#FFFFFF" stroke-width="2"/>

        <!-- X Axis Labels -->
        <text x="52" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Mon</text>
        <text x="170" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Tue</text>
        <text x="288" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Wed</text>
        <text x="406" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Thu</text>
        <text x="524" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Fri</text>
        <text x="642" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Sat</text>
        <text x="764" y="415" text-anchor="middle" class="text-[12px] fill-[#716960] font-sans">Sun</text>
    </svg>
</div>
