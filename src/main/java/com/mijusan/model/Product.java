package com.mijusan.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String slug;
    private int price;
    private String category;
    private String image;
    private String secondImage;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Product() {}

    public Product(int id, String name, String slug, int price, String category, String image, String secondImage, String description) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.price = price;
        this.category = category;
        this.image = image;
        this.secondImage = secondImage;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getSecondImage() { return secondImage; }
    public void setSecondImage(String secondImage) { this.secondImage = secondImage; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getFormattedPrice() {
        return String.format("%,d", price).replace(',', '.');
    }
}
