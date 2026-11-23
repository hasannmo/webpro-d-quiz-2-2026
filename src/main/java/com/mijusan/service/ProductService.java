package com.mijusan.service;

import com.mijusan.dao.ProductDAO;
import com.mijusan.model.Product;
import com.mijusan.util.SlugUtil;

import java.util.List;

public class ProductService {
    private final ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public List<Product> getProductsByCategory(String category) {
        if (category == null || category.trim().isEmpty() || "all".equalsIgnoreCase(category)) {
            return productDAO.findAll();
        }
        return productDAO.findByCategory(category.trim());
    }

    public List<Product> searchProducts(String query) {
        if (query == null || query.trim().isEmpty()) {
            return productDAO.findAll();
        }
        return productDAO.search(query.trim());
    }

    public Product getProductById(int id) {
        return productDAO.findById(id);
    }

    public Product getProductBySlugOrId(String identifier) {
        Product p = productDAO.findBySlugOrId(identifier);
        if (p == null) {
            List<Product> all = productDAO.findAll();
            if (!all.isEmpty()) {
                p = all.get(0);
            }
        }
        return p;
    }

    public List<Product> getRecommendations(int excludeId, int limit) {
        return productDAO.findRecommendations(excludeId, limit);
    }

    public List<Product> paginate(int page, int pageSize) {
        return productDAO.paginate(page, pageSize);
    }

    public int getTotalCount() {
        return productDAO.count();
    }

    public boolean createProduct(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getSlug() == null || product.getSlug().trim().isEmpty()) {
            product.setSlug(SlugUtil.toSlug(product.getName()));
        }
        if (product.getImage() == null || product.getImage().trim().isEmpty()) {
            product.setImage("basic-shirt-short-sleeve.png");
        }
        if (product.getSecondImage() == null || product.getSecondImage().trim().isEmpty()) {
            product.setSecondImage(product.getImage());
        }
        return productDAO.create(product);
    }

    public boolean updateProduct(Product product) {
        if (product.getId() <= 0 || product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        product.setSlug(SlugUtil.toSlug(product.getName()));
        return productDAO.update(product);
    }

    public boolean deleteProduct(int id) {
        return productDAO.delete(id);
    }
}
