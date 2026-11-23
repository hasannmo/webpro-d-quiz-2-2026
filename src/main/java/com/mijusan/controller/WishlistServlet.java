package com.mijusan.controller;

import com.google.gson.Gson;
import com.mijusan.model.User;
import com.mijusan.model.Wishlist;
import com.mijusan.service.WishlistService;
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

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist", "/wishlist/*"})
public class WishlistServlet extends HttpServlet {
    private final WishlistService wishlistService = new WishlistService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Wishlist> wishlistItems = wishlistService.getUserWishlist(user.getId());
        req.setAttribute("wishlistItems", wishlistItems);
        req.getRequestDispatcher("/WEB-INF/views/wishlist.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getCurrentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String pathInfo = req.getPathInfo();
        int productId = 0;
        try {
            if (pathInfo != null && pathInfo.length() > 1) {
                // e.g. /12/toggle
                String[] parts = pathInfo.split("/");
                if (parts.length > 1) {
                    productId = Integer.parseInt(parts[1]);
                }
            } else if (req.getParameter("productId") != null) {
                productId = Integer.parseInt(req.getParameter("productId"));
            }
        } catch (NumberFormatException ignored) {}

        boolean isWishlisted = false;
        if (productId > 0) {
            isWishlisted = wishlistService.toggle(user.getId(), productId);
        }

        String accept = req.getHeader("Accept");
        if (accept != null && accept.contains("application/json")) {
            resp.setContentType("application/json");
            Map<String, Object> map = new HashMap<>();
            map.put("success", true);
            map.put("isWishlisted", isWishlisted);
            resp.getWriter().write(gson.toJson(map));
        } else {
            resp.sendRedirect(req.getContextPath() + "/wishlist");
        }
    }

    private User getCurrentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }
}
