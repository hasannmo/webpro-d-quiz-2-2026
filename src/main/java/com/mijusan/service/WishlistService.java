package com.mijusan.service;

import com.mijusan.dao.WishlistDAO;
import com.mijusan.model.Wishlist;

import java.util.List;

public class WishlistService {
    private final WishlistDAO wishlistDAO = new WishlistDAO();

    public List<Wishlist> getUserWishlist(int userId) {
        return wishlistDAO.findByUserId(userId);
    }

    public boolean isWishlisted(int userId, int productId) {
        return wishlistDAO.isWishlisted(userId, productId);
    }

    public boolean toggle(int userId, int productId) {
        return wishlistDAO.toggle(userId, productId);
    }

    public boolean remove(int userId, int productId) {
        return wishlistDAO.delete(userId, productId);
    }
}
