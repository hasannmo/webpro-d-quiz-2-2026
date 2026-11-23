package com.mijusan.dao;

import com.mijusan.model.Category;
import com.mijusan.util.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category, COUNT(*) as count FROM products WHERE category IS NOT NULL AND category != '' GROUP BY category ORDER BY category ASC";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String cat = rs.getString("category");
                int count = rs.getInt("count");
                list.add(new Category(cat, cat.substring(0, 1).toUpperCase() + cat.substring(1), count));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateCategoryName(String oldCategory, String newCategory) {
        String sql = "UPDATE products SET category = ? WHERE category = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newCategory);
            ps.setString(2, oldCategory);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(String category) {
        String sql = "UPDATE products SET category = 'general' WHERE category = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
