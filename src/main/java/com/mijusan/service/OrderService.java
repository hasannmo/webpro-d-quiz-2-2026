package com.mijusan.service;

import com.mijusan.dao.CartDAO;
import com.mijusan.dao.OrderDAO;
import com.mijusan.model.CartItem;
import com.mijusan.model.Order;
import com.mijusan.model.Product;
import com.mijusan.model.User;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

public class OrderService {
    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();
    private final Random random = new Random();

    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.findByUserId(userId);
    }

    public List<Order> paginate(int page, int pageSize) {
        return orderDAO.paginate(page, pageSize);
    }

    public int getTotalCount() {
        return orderDAO.count();
    }

    public Order getOrderById(int id) {
        return orderDAO.findById(id);
    }

    public Order getOrderByNumber(String orderNumber) {
        return orderDAO.findByOrderNumber(orderNumber);
    }

    public boolean createSingleOrder(User user, Product product) {
        if (user == null || product == null) return false;
        Order order = new Order();
        order.setOrderNumber(generateOrderNumber());
        order.setUserId(user.getId());
        order.setProductId(product.getId());
        order.setProductName(product.getName());
        order.setPrice(product.getPrice());
        order.setCustomerEmail(user.getEmail());
        order.setStatus("completed");
        return orderDAO.create(order);
    }

    public boolean checkoutCart(User user) {
        if (user == null) return false;
        List<CartItem> items = cartDAO.findByUserId(user.getId());
        if (items.isEmpty()) return false;

        for (CartItem item : items) {
            Product p = item.getProduct();
            if (p != null) {
                for (int i = 0; i < item.getQuantity(); i++) {
                    Order order = new Order();
                    order.setOrderNumber(generateOrderNumber());
                    order.setUserId(user.getId());
                    order.setProductId(p.getId());
                    order.setProductName(p.getName());
                    order.setPrice(p.getPrice());
                    order.setCustomerEmail(user.getEmail());
                    order.setStatus("completed");
                    orderDAO.create(order);
                }
            }
        }
        cartDAO.clearByUser(user.getId());
        return true;
    }

    public boolean updateStatus(int id, String status) {
        return orderDAO.updateStatus(id, status);
    }

    public boolean deleteOrder(int id) {
        return orderDAO.delete(id);
    }

    private String generateOrderNumber() {
        String dateStr = LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE);
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return "ORD-" + dateStr + "-" + sb.toString();
    }
}
