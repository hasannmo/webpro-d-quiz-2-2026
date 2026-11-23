<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="fragments/head.jsp">
        <jsp:param name="title" value="Checkout — ${product.name}" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col bg-cream">
    <jsp:include page="fragments/navbar.jsp" />

    <main class="flex-1">
        <section class="section py-10">
            <div class="section__inner max-w-xl mx-auto px-4">
                <div class="rounded-2xl border border-sand bg-white p-6 sm:p-8 shadow-md">
                    <h1 class="font-serif text-2xl font-bold text-ink sm:text-3xl border-b border-sand pb-4">
                        Confirm Purchase
                    </h1>

                    <div class="mt-6 flex items-center gap-4">
                        <div class="h-20 w-20 overflow-hidden rounded-xl border border-sand bg-cream p-2">
                            <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                                 alt="${product.name}" class="h-full w-full object-contain">
                        </div>
                        <div>
                            <span class="text-xs uppercase text-muted font-semibold">${product.category}</span>
                            <h2 class="text-base font-semibold text-ink">${product.name}</h2>
                            <p class="text-sm font-bold text-brand-text">IDR ${product.formattedPrice}</p>
                        </div>
                    </div>

                    <div class="mt-6 space-y-3 border-t border-sand pt-4 text-sm">
                        <div class="flex justify-between text-muted">
                            <span>Recipient</span>
                            <span class="font-medium text-ink">${sessionScope.user.name}</span>
                        </div>
                        <div class="flex justify-between text-muted">
                            <span>Email</span>
                            <span class="font-medium text-ink">${sessionScope.user.email}</span>
                        </div>
                        <div class="flex justify-between text-muted">
                            <span>Shipping</span>
                            <span class="font-medium text-ink">Free Delivery</span>
                        </div>
                        <div class="border-t border-sand pt-3 flex justify-between font-serif text-lg font-bold text-ink">
                            <span>Total</span>
                            <span class="text-brand-text">IDR ${product.formattedPrice}</span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/checkout/${product.slug}" method="POST" class="mt-8">
                        <button type="submit"
                                class="w-full inline-flex h-12 items-center justify-center rounded-xl bg-brand font-medium text-white shadow-md transition hover:bg-brand-dark">
                            Place Order
                        </button>
                        <a href="${pageContext.request.contextPath}/product/${product.slug}"
                           class="mt-3 block text-center text-sm text-muted hover:text-ink">
                            Cancel
                        </a>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="fragments/footer.jsp" />
</body>
</html>
