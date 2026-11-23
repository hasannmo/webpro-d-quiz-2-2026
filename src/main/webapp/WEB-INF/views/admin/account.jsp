<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../fragments/head.jsp">
        <jsp:param name="title" value="Admin Account Management — mijusan" />
    </jsp:include>
</head>
<body class="flex min-h-screen flex-col">
    <c:set var="isAdminPage" value="true" scope="request"/>
    <jsp:include page="../fragments/navbar.jsp" />

    <main class="flex-1">
        <div class="min-h-[calc(100vh-200px)] bg-cream">
            <div class="mx-auto flex w-full max-w-[1440px] flex-col items-start gap-4 p-3 sm:p-4 md:flex-row md:gap-6 md:px-8 md:py-10">
                <c:set var="active" value="account" scope="request"/>
                <jsp:include page="../fragments/admin-sidebar.jsp" />

                <div class="w-full flex-1 min-w-0">
                    <section class="w-full rounded-2xl border border-sand bg-white p-4 sm:p-6 shadow-[0_4px_20px_rgb(43_36_32/0.06)] md:p-8">
                        <h1 class="text-xl sm:text-2xl md:text-[32px] font-bold leading-tight text-black">Account Management</h1>

                        <a href="${pageContext.request.contextPath}/admin/add-user"
                           class="mt-4 sm:mt-6 inline-flex h-9 sm:h-11 items-center justify-center rounded-lg bg-warning px-3 sm:px-4 text-xs sm:text-sm md:text-base font-medium text-white transition duration-200 hover:brightness-95 focus-visible:brightness-95 outline-none">
                            Add User
                        </a>

                        <div class="mt-4 sm:mt-6 flex min-h-[48px] sm:min-h-[60px] items-center border-t border-muted/40 px-1 sm:px-3">
                            <p class="text-xs sm:text-sm md:text-base font-medium text-black">Total User : ${String.format("%,d", total).replace(',', '.')}</p>
                        </div>

                        <!-- Responsive Table Container -->
                        <div class="w-full overflow-x-auto [scrollbar-width:thin]">
                            <div class="min-w-[620px] md:min-w-0">
                                 <!-- Table Header -->
                                <div class="hidden border-t border-muted/40 px-3 py-3 text-xs font-semibold tracking-wider text-muted uppercase md:grid md:grid-cols-[1.5fr_1.8fr_1fr_1.3fr_90px] md:items-center md:gap-3">
                                    <span>Username</span>
                                    <span>Email Address</span>
                                    <span>Role</span>
                                    <span class="text-right">Created Date</span>
                                    <span class="text-center">Action</span>
                                </div>

                                <ul>
                                    <c:forEach var="u" items="${users}">
                                        <c:set var="isSelf" value="${sessionScope.user.id == u.id}" />
                                        <c:set var="canManage" value="${sessionScope.user.creator ? !isSelf : !u.creator}" />
                                        <li class="flex flex-col gap-1 border-t border-muted/20 px-2 py-2.5 text-xs md:text-sm font-light text-black md:grid md:min-h-[54px] md:grid-cols-[1.5fr_1.8fr_1fr_1.3fr_90px] md:items-center md:gap-3 md:py-0">
                                            <div class="flex items-center justify-between md:block">
                                                <span class="font-normal text-ink leading-tight truncate font-medium md:font-normal block" title="${u.username}">${u.username}</span>
                                                <span class="inline-block md:hidden rounded-full px-2 py-0.5 text-[10px] ${u.role == 'Creator' ? 'bg-amber-100 text-amber-800 font-semibold border border-amber-300' : (u.role == 'Administrator' ? 'bg-brand/10 text-brand-text font-medium' : 'bg-cream-dark text-black font-normal')}">
                                                    ${u.role}
                                                </span>
                                            </div>

                                            <div class="flex items-center justify-between md:block">
                                                <a href="mailto:${u.email}" class="w-fit text-brand-text truncate hover:underline block" title="${u.email}">${u.email}</a>
                                                <c:if test="${canManage}">
                                                    <button type="button"
                                                            data-manage-user
                                                            data-id="${u.id}"
                                                            data-username="${u.username}"
                                                            data-email="${u.email}"
                                                            data-role="${u.role}"
                                                            class="md:hidden inline-flex h-7 items-center justify-center rounded bg-sage px-2 text-xs font-normal text-white transition hover:brightness-95">
                                                        Manage
                                                    </button>
                                                </c:if>
                                            </div>

                                            <div class="hidden md:block">
                                                <span class="inline-block rounded-full px-2.5 py-0.5 text-xs ${u.role == 'Creator' ? 'bg-amber-100 text-amber-800 font-semibold border border-amber-300' : (u.role == 'Administrator' ? 'bg-brand/10 text-brand-text font-medium' : 'bg-cream-dark text-black font-normal')}">
                                                    ${u.role}
                                                </span>
                                            </div>

                                            <span class="hidden md:block text-xs text-muted md:text-right whitespace-nowrap">${u.createdAt}</span>

                                            <c:choose>
                                                <c:when test="${canManage}">
                                                    <button type="button"
                                                            data-manage-user
                                                            data-id="${u.id}"
                                                            data-username="${u.username}"
                                                            data-email="${u.email}"
                                                            data-role="${u.role}"
                                                            class="hidden md:inline-flex h-8 w-[72px] cursor-pointer items-center justify-center rounded-md bg-sage text-xs font-normal text-white transition duration-200 hover:brightness-95 focus-visible:brightness-95 outline-none justify-self-center">
                                                        Manage
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="hidden md:inline-flex h-8 w-[72px] items-center justify-center rounded-md bg-sand/60 text-xs font-normal text-muted cursor-not-allowed justify-self-center" title="${isSelf ? 'You cannot manage your own account' : 'Only Creators can manage Creator accounts'}">
                                                        ${isSelf ? 'You' : 'Locked'}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="mt-8 flex justify-center gap-2 border-t border-sand pt-6">
                                <c:forEach begin="1" end="${totalPages}" var="pageIndex">
                                    <a href="${pageContext.request.contextPath}/admin/account?page=${pageIndex}"
                                       class="px-3.5 py-1.5 rounded-lg text-sm font-medium ${currentPage == pageIndex ? 'bg-brand text-white' : 'bg-white border border-sand text-ink hover:bg-cream'}">
                                        ${pageIndex}
                                    </a>
                                </c:forEach>
                            </div>
                        </c:if>
                    </section>
                </div>
            </div>
        </div>
    </main>

    <!-- Manage User Modal -->
    <div id="manageUserModal" hidden class="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4 backdrop-blur-[2px]">
        <div class="relative w-full max-w-md rounded-2xl border border-sand bg-white p-6 shadow-2xl">
            <div class="flex items-center justify-between border-b border-sand pb-3">
                <h3 class="font-heading text-2xl font-medium text-ink">Manage User</h3>
                <button type="button" id="closeManageModal" class="text-muted hover:text-ink text-2xl font-light">&times;</button>
            </div>

            <div class="mt-4">
                <p class="text-sm text-muted">User Account</p>
                <p id="modalUserDisplay" class="font-medium text-lg text-ink"></p>
                <p id="modalEmailDisplay" class="text-sm text-brand-text"></p>
            </div>

            <!-- Role Update Form -->
            <form id="updateRoleForm" method="POST" action="${pageContext.request.contextPath}/admin/update-role" class="mt-5 border-t border-sand pt-4">
                <input type="hidden" name="id" id="modalUserId">
                <label for="modalRoleSelect" class="block text-sm font-medium text-ink">Change Role</label>
                <div class="mt-2 flex gap-3">
                    <select name="role" id="modalRoleSelect" class="flex-1 rounded-lg border border-sand bg-cream-dark px-3 py-2 text-base text-ink outline-none focus:border-brand">
                        <option value="Customer">Customer</option>
                        <option value="Administrator">Administrator</option>
                        <c:if test="${sessionScope.user.creator}">
                            <option value="Creator">Creator</option>
                        </c:if>
                    </select>
                    <button type="submit" class="rounded-lg bg-brand px-5 py-2 text-sm font-medium text-white transition hover:bg-brand-dark">
                        Save Role
                    </button>
                </div>
            </form>

            <!-- Delete User Form -->
            <form id="deleteUserForm" method="POST" action="${pageContext.request.contextPath}/admin/delete-user" class="mt-6 border-t border-sand pt-4" onsubmit="return confirm('Are you sure you want to permanently remove this user?');">
                <input type="hidden" name="id" id="modalDeleteUserId">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-danger">Remove User</p>
                        <p class="text-xs text-muted">This action will delete user data.</p>
                    </div>
                    <button type="submit" class="rounded-lg bg-danger px-4 py-2 text-sm font-medium text-white transition hover:opacity-90">
                        Remove
                    </button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="../fragments/footer.jsp" />

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const modal = document.getElementById('manageUserModal');
            const closeBtn = document.getElementById('closeManageModal');
            const userDisplay = document.getElementById('modalUserDisplay');
            const emailDisplay = document.getElementById('modalEmailDisplay');
            const roleSelect = document.getElementById('modalRoleSelect');
            const userIdInput = document.getElementById('modalUserId');
            const deleteUserIdInput = document.getElementById('modalDeleteUserId');

            const closeModal = () => { modal.hidden = true; };
            closeBtn.addEventListener('click', closeModal);
            modal.addEventListener('click', (e) => { if (e.target === modal) closeModal(); });

            document.querySelectorAll('[data-manage-user]').forEach((btn) => {
                btn.addEventListener('click', () => {
                    userDisplay.textContent = btn.dataset.username;
                    emailDisplay.textContent = btn.dataset.email;
                    roleSelect.value = btn.dataset.role;
                    userIdInput.value = btn.dataset.id;
                    deleteUserIdInput.value = btn.dataset.id;
                    modal.hidden = false;
                });
            });
        });
    </script>
</body>
</html>
