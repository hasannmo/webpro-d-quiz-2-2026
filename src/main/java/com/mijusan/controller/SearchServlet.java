package com.mijusan.controller;

import com.mijusan.model.Product;
import com.mijusan.model.ProductDTO;
import com.mijusan.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Product> products = productService.searchProducts(query);

        String ctx = req.getContextPath();
        List<ProductDTO> dtos = new ArrayList<>();
        for (Product p : products) {
            String img = ctx + "/assets/images/" + p.getImage();
            String secImg = (p.getSecondImage() != null && !p.getSecondImage().isEmpty())
                    ? ctx + "/assets/images/" + p.getSecondImage()
                    : img;
            dtos.add(new ProductDTO(p.getId(), p.getName(), p.getPrice(), img, secImg, ctx + "/product/" + p.getSlug(), p.getSlug()));
        }

        req.setAttribute("query", query != null ? query : "");
        req.setAttribute("products", dtos);
        req.getRequestDispatcher("/WEB-INF/views/search.jsp").forward(req, resp);
    }
}
