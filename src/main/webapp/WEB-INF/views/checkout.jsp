<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Checkout — ${product.name}" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-8 md:py-16">
            <div class="section__inner max-w-4xl mx-auto">
                <div class="mb-6 flex items-center">
                    <a href="${cancelHref}"
                       class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-white text-ink shadow-[0_2px_8px_rgb(43_36_32/0.12)] transition duration-200 hover:bg-brand hover:text-white"
                       aria-label="Back to product">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                    </a>
                </div>

                <div class="grid w-full gap-6 rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:grid-cols-2 md:gap-10 md:p-10">
                    <div class="flex items-center justify-center p-2">
                        <img src="${product.image}" alt="${product.name}" class="block max-h-[260px] sm:max-h-[340px] md:max-h-[420px] w-full object-contain">
                    </div>

                    <div class="flex flex-col">
                        <h1 class="border-b border-ink pb-1 font-heading text-2xl sm:text-3xl font-medium leading-tight tracking-tight text-ink md:text-[36px]">Finish Your Checkout</h1>

                        <h2 class="mt-3 sm:mt-4 font-heading text-lg sm:text-xl font-medium leading-tight text-ink md:text-[26px]">${product.name}</h2>
                        <p class="mt-1 sm:mt-2 font-heading text-base sm:text-lg font-medium leading-tight text-brand-text">IDR ${product.formattedPrice}</p>

                        <c:choose>
                            <c:when test="${confirmed}">
                                <div aria-disabled="true" role="status"
                                     class="mt-6 sm:mt-8 flex h-11 sm:h-12 w-full cursor-not-allowed select-none items-center justify-center rounded-lg bg-sand text-sm sm:text-base font-normal text-muted">
                                    Checkout Confirmed
                                </div>
                                <p class="mt-4 sm:mt-6 text-xs sm:text-sm md:text-base font-normal leading-snug text-black">Your order will be recorded and processed shortly.</p>
                            </c:when>
                            <c:otherwise>
                                <form method="POST" action="${confirmAction}" class="mt-6 sm:mt-8">
                                    <button type="submit"
                                            class="flex h-11 sm:h-12 w-full cursor-pointer items-center justify-center rounded-lg bg-brand text-sm sm:text-base font-medium text-white transition-colors duration-200 hover:bg-brand-dark focus-visible:bg-brand-dark outline-none">
                                        Confirm Checkout
                                    </button>
                                </form>

                                <a href="${cancelHref}"
                                   class="mt-2.5 sm:mt-3 flex h-11 sm:h-12 w-full items-center justify-center rounded-lg bg-danger text-sm sm:text-base font-medium text-white transition-opacity duration-200 hover:opacity-90 focus-visible:opacity-90 outline-none">
                                    Cancel Checkout
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <p class="${confirmed ? 'mt-6' : 'mt-6 sm:mt-8'} text-xs sm:text-sm font-normal leading-snug text-black">
                            Having any issues?<br>
                            contact us at <a href="mailto:customerservice@mijusan.com" class="text-brand-text hover:underline">customerservice@mijusan.com</a>
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="fragments/footer.jsp" />
</body>
</html>
