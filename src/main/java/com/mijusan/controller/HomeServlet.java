package com.mijusan.controller;

import com.mijusan.model.Product;
import com.mijusan.model.ProductDTO;
import com.mijusan.model.SlideItem;
import com.mijusan.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ctx = req.getContextPath();

        // 1. Hero Banners
        List<String> bannerFiles = Arrays.asList(
                "hero-banner.jpeg",
                "hero-banner1.jpg",
                "hero-banner2.jpg",
                "hero-banner3.jpg"
        );
        List<SlideItem> heroSlides = new ArrayList<>();
        for (int i = 0; i < bannerFiles.size(); i++) {
            heroSlides.add(new SlideItem(
                    ctx + "/assets/images/" + bannerFiles.get(i),
                    "mijusan hero banner " + (i + 1),
                    "#"
            ));
        }

        // 2. Hero Lookbook Cards
        List<String> cardFiles = Arrays.asList(
                "hero-1.png",
                "hero-2.png",
                "hero-3.png",
                "hero-4.jpeg",
                "hero-5.jpg"
        );
        List<SlideItem> heroCardItems = new ArrayList<>();
        for (int i = 0; i < cardFiles.size(); i++) {
            heroCardItems.add(new SlideItem(
                    ctx + "/assets/images/" + cardFiles.get(i),
                    "Lookbook " + (i + 1),
                    "#"
            ));
        }

        // 3. Popular Products (first 8 items)
        List<Product> all = productService.getAllProducts();
        List<ProductDTO> popularProducts = new ArrayList<>();
        int popLimit = Math.min(8, all.size());
        for (int i = 0; i < popLimit; i++) {
            popularProducts.add(toDTO(all.get(i), ctx));
        }

        // 4. Category Products
        List<ProductDTO> topWearProducts = toDTOList(productService.getProductsByCategory("top"), ctx);
        List<ProductDTO> outerWearProducts = toDTOList(productService.getProductsByCategory("outer"), ctx);
        List<ProductDTO> bottomWearProducts = toDTOList(productService.getProductsByCategory("bottom"), ctx);

        req.setAttribute("heroSlides", heroSlides);
        req.setAttribute("heroCardItems", heroCardItems);
        req.setAttribute("popularProducts", popularProducts);
        req.setAttribute("topWearProducts", topWearProducts);
        req.setAttribute("outerWearProducts", outerWearProducts);
        req.setAttribute("bottomWearProducts", bottomWearProducts);

        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }

    private List<ProductDTO> toDTOList(List<Product> list, String ctx) {
        List<ProductDTO> dtos = new ArrayList<>();
        for (Product p : list) {
            dtos.add(toDTO(p, ctx));
        }
        return dtos;
    }

    private ProductDTO toDTO(Product p, String ctx) {
        String img = ctx + "/assets/images/" + p.getImage();
        String secImg = (p.getSecondImage() != null && !p.getSecondImage().isEmpty())
                ? ctx + "/assets/images/" + p.getSecondImage()
                : img;
        String href = ctx + "/product/" + p.getSlug();
        return new ProductDTO(p.getId(), p.getName(), p.getPrice(), img, secImg, href, p.getSlug());
    }
}
