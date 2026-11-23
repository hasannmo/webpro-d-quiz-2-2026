<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Add Product — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <c:set var="isAdminPage" value="true" scope="request"/>
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-3 sm:p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <c:set var="active" value="product" scope="request"/>
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-9 max-w-2xl">
                        <div class="flex items-center gap-4 border-b border-sand pb-4">
                            <a href="${pageContext.request.contextPath}/admin/product" class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-cream-dark text-ink transition hover:bg-brand hover:text-white" aria-label="Back">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="19" y1="12" x2="5" y2="12"></line>
                                    <polyline points="12 19 5 12 12 5"></polyline>
                                </svg>
                            </a>
                            <h1 class="text-[32px] font-bold leading-tight text-black">Add Product</h1>
                        </div>

                        <form method="POST" action="${pageContext.request.contextPath}/admin/add-product" class="mt-6 space-y-6">
                            <div>
                                <label for="name" class="block text-base font-medium text-ink">Product Name</label>
                                <input type="text" name="name" id="name" required
                                       class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                       placeholder="e.g. Fine Knit Polo Neck">
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="price" class="block text-base font-medium text-ink">Price (IDR)</label>
                                    <input type="number" name="price" id="price" required min="0"
                                           class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                           placeholder="99000">
                                </div>

                                <div>
                                    <label for="category" class="block text-base font-medium text-ink">Category</label>
                                    <select name="category" id="category"
                                            class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white">
                                        <option value="top">Top Wear</option>
                                        <option value="outer">Outer Wear</option>
                                        <option value="bottom">Bottom Wear</option>
                                    </select>
                                </div>
                            </div>

                            <div>
                                <label for="image_name" class="block text-base font-medium text-ink">Product Image</label>
                                <input type="text" name="image_name" id="image_name"
                                       class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                       placeholder="e.g. basic-shirt-short-sleeve.png">
                                <p class="mt-1 text-xs text-muted">Filename inside assets/images/</p>
                            </div>

                            <div>
                                <label for="description" class="block text-base font-medium text-ink">Description</label>
                                <textarea name="description" id="description" rows="4"
                                          class="mt-2 w-full rounded-xl border border-sand bg-cream px-4 py-3 text-base text-ink outline-none transition focus:border-brand focus:bg-white"
                                          placeholder="Product details and specifications..."></textarea>
                            </div>

                            <div class="flex items-center gap-4 pt-4">
                                <button type="submit"
                                        class="inline-flex h-11 items-center justify-center rounded-lg bg-warning px-6 text-sm md:text-base font-medium text-white transition duration-200 hover:brightness-95 focus-visible:brightness-95 outline-none">
                                    Save Product
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/product" class="text-sm text-muted hover:text-ink">Cancel</a>
                            </div>
                        </form>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../fragments/footer.jsp" />
</body>
</html>
