package com.mijusan.controller;

import com.mijusan.model.Category;
import com.mijusan.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/categories", "/admin/categories/update", "/admin/categories/delete"})
public class CategoryServlet extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/views/categories.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/categories/update".equals(path)) {
            String oldName = req.getParameter("oldCategory");
            String newName = req.getParameter("newCategory");
            if (oldName != null && newName != null && !newName.trim().isEmpty()) {
                categoryService.updateCategory(oldName.trim(), newName.trim());
            }
        } else if ("/admin/categories/delete".equals(path)) {
            String category = req.getParameter("category");
            if (category != null) {
                categoryService.deleteCategory(category.trim());
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }
}
