package com.mijusan.controller;

import com.mijusan.model.Order;
import com.mijusan.model.Product;
import com.mijusan.model.User;
import com.mijusan.service.OrderService;
import com.mijusan.service.ProductService;
import com.mijusan.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {
        "/admin/dashboard",
        "/admin/product",
        "/admin/add-product",
        "/admin/edit-product",
        "/admin/delete-product",
        "/admin/order",
        "/admin/order/update",
        "/admin/order/delete",
        "/admin/account",
        "/admin/add-user",
        "/admin/update-role",
        "/admin/delete-user"
})
public class AdminServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final UserService userService = new UserService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/dashboard".equals(path)) {
            String selected = req.getParameter("range");
            if (selected == null || selected.trim().isEmpty()) selected = "7d";
            com.mijusan.model.ChartData chart = orderService.getChartForRange(selected);

            req.setAttribute("active", "dashboard");
            req.setAttribute("selected", selected);
            req.setAttribute("chart", chart);
            req.setAttribute("totalOrder", orderService.getTotalCount());
            req.setAttribute("totalUser", userService.getTotalCount());
            req.setAttribute("totalProduct", productService.getTotalCount());
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);

        } else if ("/admin/product".equals(path)) {
            int page = parsePage(req.getParameter("page"));
            int pageSize = 10;
            List<Product> products = productService.paginate(page, pageSize);
            int total = productService.getTotalCount();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("active", "product");
            req.setAttribute("products", products);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/WEB-INF/views/admin/product.jsp").forward(req, resp);

        } else if ("/admin/add-product".equals(path)) {
            req.setAttribute("active", "product");
            req.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(req, resp);

        } else if ("/admin/edit-product".equals(path)) {
            String identifier = req.getParameter("id");
            if (identifier == null) identifier = req.getParameter("slug");
            Product product = productService.getProductBySlugOrId(identifier);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/product");
                return;
            }
            req.setAttribute("active", "product");
            req.setAttribute("product", product);
            req.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(req, resp);

        } else if ("/admin/order".equals(path)) {
            String selected = req.getParameter("range");
            if (selected == null || selected.trim().isEmpty()) selected = "7d";
            com.mijusan.model.ChartData chart = orderService.getChartForRange(selected);

            int page = parsePage(req.getParameter("page"));
            int pageSize = 10;
            List<Order> orders = orderService.paginate(page, pageSize);
            int total = orderService.getTotalCount();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("active", "order");
            req.setAttribute("selected", selected);
            req.setAttribute("chart", chart);
            req.setAttribute("orders", orders);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/WEB-INF/views/admin/order.jsp").forward(req, resp);

        } else if ("/admin/account".equals(path)) {
            int page = parsePage(req.getParameter("page"));
            int pageSize = 10;
            List<User> users = userService.paginate(page, pageSize);
            int total = userService.getTotalCount();
            int totalPages = (int) Math.ceil((double) total / pageSize);

            req.setAttribute("active", "account");
            req.setAttribute("users", users);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/WEB-INF/views/admin/account.jsp").forward(req, resp);

        } else if ("/admin/add-user".equals(path)) {
            req.setAttribute("active", "account");
            req.getRequestDispatcher("/WEB-INF/views/admin/add-user.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        User currentUser = getCurrentUser(req);

        if ("/admin/add-product".equals(path)) {
            String name = req.getParameter("name");
            int price = Integer.parseInt(req.getParameter("price"));
            String category = req.getParameter("category");
            String image = req.getParameter("image_name");
            if (image == null || image.trim().isEmpty()) image = "basic-shirt-short-sleeve.png";
            String description = req.getParameter("description");

            Product p = new Product();
            p.setName(name);
            p.setPrice(price);
            p.setCategory(category);
            p.setImage(image);
            p.setSecondImage(image);
            p.setDescription(description);

            productService.createProduct(p);
            resp.sendRedirect(req.getContextPath() + "/admin/product?success=ProductCreated");

        } else if ("/admin/edit-product".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            int price = Integer.parseInt(req.getParameter("price"));
            String category = req.getParameter("category");
            String image = req.getParameter("image_name");
            String description = req.getParameter("description");

            Product p = productService.getProductById(id);
            if (p != null) {
                p.setName(name);
                p.setPrice(price);
                p.setCategory(category);
                if (image != null && !image.trim().isEmpty()) {
                    p.setImage(image);
                    p.setSecondImage(image);
                }
                p.setDescription(description);
                productService.updateProduct(p);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product?success=ProductUpdated");

        } else if ("/admin/delete-product".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.deleteProduct(id);
            resp.sendRedirect(req.getContextPath() + "/admin/product?success=ProductDeleted");

        } else if ("/admin/order/update".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            orderService.updateStatus(id, status);
            resp.sendRedirect(req.getContextPath() + "/admin/order?success=OrderUpdated");

        } else if ("/admin/order/delete".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            orderService.deleteOrder(id);
            resp.sendRedirect(req.getContextPath() + "/admin/order?success=OrderDeleted");

        } else if ("/admin/add-user".equals(path)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String role = req.getParameter("role");

            userService.createUser(name, email, username, password, role);
            resp.sendRedirect(req.getContextPath() + "/admin/account?success=UserCreated");

        } else if ("/admin/update-role".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String role = req.getParameter("role");
            User target = userService.getUserById(id);

            if (target != null) {
                if (target.isCreator() && !currentUser.isCreator()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/account?error=UnauthorizedCreatorModification");
                    return;
                }
                userService.updateUserRole(id, role);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/account?success=RoleUpdated");

        } else if ("/admin/delete-user".equals(path)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if (currentUser.getId() == id) {
                resp.sendRedirect(req.getContextPath() + "/admin/account?error=CannotDeleteSelf");
                return;
            }
            User target = userService.getUserById(id);
            if (target != null && target.isCreator() && !currentUser.isCreator()) {
                resp.sendRedirect(req.getContextPath() + "/admin/account?error=CannotDeleteCreator");
                return;
            }
            userService.deleteUser(id);
            resp.sendRedirect(req.getContextPath() + "/admin/account?success=UserDeleted");
        }
    }

    private int parsePage(String pageStr) {
        if (pageStr == null) return 1;
        try {
            int p = Integer.parseInt(pageStr);
            return Math.max(1, p);
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    private User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }
}
