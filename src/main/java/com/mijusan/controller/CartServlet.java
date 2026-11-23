package com.mijusan.controller;

import com.google.gson.Gson;
import com.mijusan.model.CartItem;
import com.mijusan.model.User;
import com.mijusan.service.CartService;
import com.mijusan.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove", "/cart/checkout"})
public class CartServlet extends HttpServlet {
    private final CartService cartService = new CartService();
    private final OrderService orderService = new OrderService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<CartItem> cartItems = cartService.getCartItems(user.getId());
        int subtotal = cartService.getSubtotal(user.getId());
        int totalItems = cartService.getTotalItemCount(user.getId());

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("subtotal", subtotal);
        req.setAttribute("totalItems", totalItems);

        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        String action = req.getParameter("action");
        if (action != null && !action.isEmpty()) {
            path = "/cart/" + action;
        }

        if ("/cart/add".equals(path)) {
            handleAdd(req, resp, user);
        } else if ("/cart/update".equals(path)) {
            handleUpdate(req, resp, user);
        } else if ("/cart/remove".equals(path)) {
            handleRemove(req, resp, user);
        } else if ("/cart/checkout".equals(path)) {
            handleCheckout(req, resp, user);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        int productId = Integer.parseInt(req.getParameter("product_id"));
        int quantity = 1;
        try {
            String qParam = req.getParameter("quantity");
            if (qParam != null) quantity = Integer.parseInt(qParam);
        } catch (NumberFormatException ignored) {}

        boolean success = cartService.addToCart(user.getId(), productId, quantity);
        int totalCartCount = cartService.getTotalItemCount(user.getId());

        String accept = req.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            resp.setContentType("application/json");
            Map<String, Object> map = new HashMap<>();
            map.put("success", success);
            map.put("cartCount", totalCartCount);
            map.put("cart_count", totalCartCount);
            map.put("message", "Item added to your cart!");
            resp.getWriter().write(gson.toJson(map));
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        boolean success = cartService.updateQuantity(id, user.getId(), quantity);
        int subtotal = cartService.getSubtotal(user.getId());
        int totalCartCount = cartService.getTotalItemCount(user.getId());

        String accept = req.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            resp.setContentType("application/json");
            Map<String, Object> map = new HashMap<>();
            map.put("success", success);
            map.put("subtotal", subtotal);
            map.put("cartCount", totalCartCount);
            resp.getWriter().write(gson.toJson(map));
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleRemove(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        cartService.removeFromCart(id, user.getId());

        String accept = req.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            int subtotal = cartService.getSubtotal(user.getId());
            int totalCartCount = cartService.getTotalItemCount(user.getId());
            resp.setContentType("application/json");
            Map<String, Object> map = new HashMap<>();
            map.put("success", true);
            map.put("subtotal", subtotal);
            map.put("cartCount", totalCartCount);
            map.put("isEmpty", totalCartCount == 0);
            resp.getWriter().write(gson.toJson(map));
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void handleCheckout(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        boolean success = orderService.checkoutCart(user);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/myorder?success=OrderPlaced");
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart?error=CartEmpty");
        }
    }

    private User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }
}
