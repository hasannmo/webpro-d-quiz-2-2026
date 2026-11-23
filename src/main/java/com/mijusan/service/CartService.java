package com.mijusan.service;

import com.mijusan.dao.CartDAO;
import com.mijusan.model.CartItem;

import java.util.List;

public class CartService {
    private final CartDAO cartDAO = new CartDAO();

    public List<CartItem> getCartItems(int userId) {
        return cartDAO.findByUserId(userId);
    }

    public int getSubtotal(int userId) {
        List<CartItem> items = getCartItems(userId);
        int total = 0;
        for (CartItem item : items) {
            total += item.getSubtotal();
        }
        return total;
    }

    public int getTotalItemCount(int userId) {
        return cartDAO.countTotalQuantity(userId);
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        if (quantity <= 0) quantity = 1;
        CartItem existing = cartDAO.findByUserAndProduct(userId, productId);
        if (existing != null) {
            return cartDAO.incrementQuantity(existing.getId(), quantity);
        } else {
            return cartDAO.create(userId, productId, quantity);
        }
    }

    public boolean updateQuantity(int cartItemId, int userId, int quantity) {
        if (quantity <= 0) {
            return cartDAO.delete(cartItemId, userId);
        }
        CartItem item = cartDAO.findById(cartItemId);
        if (item != null && item.getUserId() == userId) {
            return cartDAO.updateQuantity(cartItemId, quantity);
        }
        return false;
    }

    public boolean removeFromCart(int cartItemId, int userId) {
        return cartDAO.delete(cartItemId, userId);
    }

    public boolean clearCart(int userId) {
        return cartDAO.clearByUser(userId);
    }
}
