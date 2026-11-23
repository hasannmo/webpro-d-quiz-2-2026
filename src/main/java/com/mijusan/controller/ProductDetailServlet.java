package com.mijusan.controller;

import com.mijusan.model.Product;
import com.mijusan.model.User;
import com.mijusan.service.ProductService;
import com.mijusan.service.WishlistService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product/*"})
public class ProductDetailServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final WishlistService wishlistService = new WishlistService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        String identifier = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";

        Product product = productService.getProductBySlugOrId(identifier);
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        List<Product> recommendations = productService.getRecommendations(product.getId(), 8);

        boolean isWishlisted = false;
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                isWishlisted = wishlistService.isWishlisted(user.getId(), product.getId());
            }
        }

        req.setAttribute("product", product);
        req.setAttribute("recommendations", recommendations);
        req.setAttribute("isWishlisted", isWishlisted);

        req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
    }
}
