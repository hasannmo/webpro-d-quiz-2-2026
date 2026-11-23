package com.mijusan.dao;

import com.mijusan.model.Product;
import com.mijusan.model.Wishlist;
import com.mijusan.util.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public List<Wishlist> findByUserId(int userId) {
        List<Wishlist> list = new ArrayList<>();
        String sql = "SELECT w.*, p.name AS p_name, p.slug AS p_slug, p.price AS p_price, " +
                     "p.category AS p_category, p.image AS p_image, p.second_image AS p_second_image, " +
                     "p.description AS p_description " +
                     "FROM wishlists w " +
                     "JOIN products p ON w.product_id = p.id " +
                     "WHERE w.user_id = ? " +
                     "ORDER BY w.id DESC";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Wishlist w = new Wishlist();
                    w.setId(rs.getInt("id"));
                    w.setUserId(rs.getInt("user_id"));
                    w.setProductId(rs.getInt("product_id"));
                    w.setCreatedAt(rs.getTimestamp("created_at"));
                    w.setUpdatedAt(rs.getTimestamp("updated_at"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("p_name"));
                    p.setSlug(rs.getString("p_slug"));
                    p.setPrice(rs.getInt("p_price"));
                    p.setCategory(rs.getString("p_category"));
                    p.setImage(rs.getString("p_image"));
                    p.setSecondImage(rs.getString("p_second_image"));
                    p.setDescription(rs.getString("p_description"));
                    w.setProduct(p);

                    list.add(w);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isWishlisted(int userId, int productId) {
        String sql = "SELECT 1 FROM wishlists WHERE user_id = ? AND product_id = ? LIMIT 1";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean create(int userId, int productId) {
        String sql = "INSERT OR IGNORE INTO wishlists (user_id, product_id, created_at, updated_at) " +
                     "VALUES (?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int userId, int productId) {
        String sql = "DELETE FROM wishlists WHERE user_id = ? AND product_id = ?";
        try (Connection conn = Database.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean toggle(int userId, int productId) {
        if (isWishlisted(userId, productId)) {
            delete(userId, productId);
            return false;
        } else {
            create(userId, productId);
            return true;
        }
    }
}
