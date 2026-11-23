package com.mijusan.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int userId;
    private int productId;
    private int quantity;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private Product product;

    public CartItem() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getSubtotal() {
        return product != null ? product.getPrice() * quantity : 0;
    }

    public String getFormattedSubtotal() {
        return String.format("%,d", getSubtotal()).replace(',', '.');
    }
}
