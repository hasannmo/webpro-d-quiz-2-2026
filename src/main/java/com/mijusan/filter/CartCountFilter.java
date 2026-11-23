package com.mijusan.filter;

import com.mijusan.model.User;
import com.mijusan.service.CartService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "CartCountFilter", urlPatterns = {"/*"})
public class CartCountFilter implements Filter {
    private final CartService cartService = new CartService();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                int count = cartService.getTotalItemCount(user.getId());
                req.setAttribute("cartCount", count);
            }
        }
        chain.doFilter(request, response);
    }
}
