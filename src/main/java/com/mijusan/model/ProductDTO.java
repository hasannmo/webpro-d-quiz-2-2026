package com.mijusan.model;

public class ProductDTO {
    private int id;
    private String name;
    private int price;
    private String image;
    private String secondImage;
    private String href;
    private String slug;
    private String description;
    private String formattedPrice;

    public ProductDTO() {}

    public ProductDTO(int id, String name, int price, String image, String secondImage, String href, String slug) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.secondImage = secondImage;
        this.href = href;
        this.slug = slug;
        this.formattedPrice = String.format("%,d", price).replace(',', '.');
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getPrice() { return price; }
    public void setPrice(int price) {
        this.price = price;
        this.formattedPrice = String.format("%,d", price).replace(',', '.');
    }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getSecondImage() { return secondImage; }
    public void setSecondImage(String secondImage) { this.secondImage = secondImage; }

    public String getHref() { return href; }
    public void setHref(String href) { this.href = href; }

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFormattedPrice() {
        if (formattedPrice == null) {
            formattedPrice = String.format("%,d", price).replace(',', '.');
        }
        return formattedPrice;
    }
}
