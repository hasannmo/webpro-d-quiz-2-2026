package com.mijusan.service;

import com.mijusan.dao.CategoryDAO;
import com.mijusan.model.Category;

import java.util.List;

public class CategoryService {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    public boolean updateCategory(String oldCat, String newCat) {
        return categoryDAO.updateCategoryName(oldCat, newCat);
    }

    public boolean deleteCategory(String cat) {
        return categoryDAO.deleteCategory(cat);
    }
}
