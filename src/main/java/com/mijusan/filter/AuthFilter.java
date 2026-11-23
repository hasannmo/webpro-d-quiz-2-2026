package com.mijusan.filter;

import com.mijusan.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/cart/*", "/wishlist/*", "/myorder", "/checkout/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());

        if (user == null) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        if (path.startsWith("/admin")) {
            if (!user.isAdmin()) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Administrator privileges required.");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
