package com.mijusan.controller;

import com.mijusan.model.Category;
import com.mijusan.model.Product;
import com.mijusan.service.CategoryService;
import com.mijusan.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String category = req.getParameter("category");
        List<Product> products;
        if (category != null && !category.trim().isEmpty() && !"all".equalsIgnoreCase(category)) {
            products = productService.getProductsByCategory(category.trim());
        } else {
            products = productService.getAllProducts();
        }

        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategory", category != null ? category : "all");

        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
