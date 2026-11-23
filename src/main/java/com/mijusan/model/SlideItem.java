package com.mijusan.model;

import java.io.Serializable;

public class SlideItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private String image;
    private String alt;
    private String href;

    public SlideItem() {}

    public SlideItem(String image, String alt, String href) {
        this.image = image;
        this.alt = alt;
        this.href = href;
    }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getAlt() { return alt; }
    public void setAlt(String alt) { this.alt = alt; }

    public String getHref() { return href; }
    public void setHref(String href) { this.href = href; }
}
