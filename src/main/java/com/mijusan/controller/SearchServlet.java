package com.mijusan.controller;

import com.mijusan.model.Product;
import com.mijusan.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Product> products = productService.searchProducts(query);

        req.setAttribute("query", query != null ? query : "");
        req.setAttribute("products", products);
        req.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(req, resp);
    }
}
