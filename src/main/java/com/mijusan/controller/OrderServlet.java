package com.mijusan.controller;

import com.mijusan.model.Order;
import com.mijusan.model.Product;
import com.mijusan.model.User;
import com.mijusan.service.OrderService;
import com.mijusan.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/myorder", "/checkout/*"})
public class OrderServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String servletPath = req.getServletPath();
        if ("/myorder".equals(servletPath)) {
            List<Order> orders = orderService.getOrdersByUser(user.getId());
            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/myorder.jsp").forward(req, resp);
        } else if ("/checkout".equals(servletPath)) {
            String pathInfo = req.getPathInfo();
            String productSlug = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";
            Product product = productService.getProductBySlugOrId(productSlug);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
            req.setAttribute("product", product);
            req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String servletPath = req.getServletPath();
        if ("/checkout".equals(servletPath)) {
            String pathInfo = req.getPathInfo();
            String productSlug = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";
            Product product = productService.getProductBySlugOrId(productSlug);
            if (product != null) {
                orderService.createSingleOrder(user, product);
                resp.sendRedirect(req.getContextPath() + "/myorder?success=OrderPlaced");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        }
    }

    private User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }
}
