package com.mijusan.controller;

import com.mijusan.model.Product;
import com.mijusan.model.ProductDTO;
import com.mijusan.model.User;
import com.mijusan.service.ProductService;
import com.mijusan.service.WishlistService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product/*"})
public class ProductDetailServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final WishlistService wishlistService = new WishlistService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        String identifier = (pathInfo != null && pathInfo.length() > 1) ? pathInfo.substring(1) : "";

        Product product = productService.getProductBySlugOrId(identifier);
        if (product == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String ctx = req.getContextPath();
        String img = ctx + "/assets/images/" + product.getImage();
        String secImg = (product.getSecondImage() != null && !product.getSecondImage().isEmpty())
                ? ctx + "/assets/images/" + product.getSecondImage()
                : img;

        ProductDTO productDTO = new ProductDTO(
                product.getId(),
                product.getName(),
                product.getPrice(),
                img,
                secImg,
                ctx + "/product/" + product.getSlug(),
                product.getSlug()
        );
        productDTO.setDescription(product.getDescription());

        // 8 Recommendations for "Discover your style"
        List<Product> recs = productService.getRecommendations(product.getId(), 8);
        List<ProductDTO> discoverProducts = new ArrayList<>();
        for (Product p : recs) {
            String pImg = ctx + "/assets/images/" + p.getImage();
            String pSec = (p.getSecondImage() != null && !p.getSecondImage().isEmpty())
                    ? ctx + "/assets/images/" + p.getSecondImage()
                    : pImg;
            discoverProducts.add(new ProductDTO(
                    p.getId(),
                    p.getName(),
                    p.getPrice(),
                    pImg,
                    pSec,
                    ctx + "/product/" + p.getSlug(),
                    p.getSlug()
            ));
        }

        boolean isWishlisted = false;
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                isWishlisted = wishlistService.isWishlisted(user.getId(), product.getId());
            }
        }

        req.setAttribute("product", productDTO);
        req.setAttribute("isWishlisted", isWishlisted);
        req.setAttribute("discoverProducts", discoverProducts);

        req.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(req, resp);
    }
}
