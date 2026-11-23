package com.mijusan.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Wishlist implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private Integer userId;
    private int productId;
    private String sessionId;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private Product product;

    public Wishlist() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}
