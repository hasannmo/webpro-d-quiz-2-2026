package com.mijusan.service;

import com.mijusan.dao.CartDAO;
import com.mijusan.dao.OrderDAO;
import com.mijusan.model.CartItem;
import com.mijusan.model.ChartData;
import com.mijusan.model.ChartPoint;
import com.mijusan.model.Order;
import com.mijusan.model.Product;
import com.mijusan.model.User;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
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

    public ChartData getChartForRange(String range) {
        if (range == null || range.trim().isEmpty()) {
            range = "7d";
        }

        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter sqlFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        DateTimeFormatter dayFmt = DateTimeFormatter.ofPattern("EEE");
        DateTimeFormatter monthFmt = DateTimeFormatter.ofPattern("MMM");

        List<String> labels = new ArrayList<>();
        List<Integer> data = new ArrayList<>();
        LocalDateTime startDate;

        switch (range) {
            case "1m":
                startDate = now.minusDays(28).withHour(0).withMinute(0).withSecond(0);
                labels.add("Week 1");
                labels.add("Week 2");
                labels.add("Week 3");
                labels.add("Week 4");
                for (int i = 0; i < 4; i++) data.add(0);

                List<Order> orders1m = orderDAO.findCreatedAfter(startDate.format(sqlFmt));
                for (Order o : orders1m) {
                    if (o.getCreatedAt() != null) {
                        LocalDateTime orderTime = o.getCreatedAt().toLocalDateTime();
                        long daysAgo = Math.abs(ChronoUnit.DAYS.between(orderTime, now));
                        int weekIdx = 3 - Math.min(3, Math.max(0, (int) (daysAgo / 7)));
                        data.set(weekIdx, data.get(weekIdx) + 1);
                    }
                }
                break;

            case "3m":
                startDate = now.minusMonths(3).withHour(0).withMinute(0).withSecond(0);
                labels.add(now.minusMonths(2).format(monthFmt));
                labels.add(now.minusMonths(1).format(monthFmt));
                labels.add(now.format(monthFmt));
                for (int i = 0; i < 3; i++) data.add(0);

                List<Order> orders3m = orderDAO.findCreatedAfter(startDate.format(sqlFmt));
                for (Order o : orders3m) {
                    if (o.getCreatedAt() != null) {
                        LocalDateTime orderTime = o.getCreatedAt().toLocalDateTime();
                        long monthDiff = Math.abs(ChronoUnit.MONTHS.between(orderTime.withDayOfMonth(1), now.withDayOfMonth(1)));
                        int mIdx = 2 - Math.min(2, Math.max(0, (int) monthDiff));
                        data.set(mIdx, data.get(mIdx) + 1);
                    }
                }
                break;

            case "6m":
                startDate = now.minusMonths(6).withHour(0).withMinute(0).withSecond(0);
                for (int i = 5; i >= 0; i--) {
                    labels.add(now.minusMonths(i).format(monthFmt));
                    data.add(0);
                }

                List<Order> orders6m = orderDAO.findCreatedAfter(startDate.format(sqlFmt));
                for (Order o : orders6m) {
                    if (o.getCreatedAt() != null) {
                        LocalDateTime orderTime = o.getCreatedAt().toLocalDateTime();
                        long monthDiff = Math.abs(ChronoUnit.MONTHS.between(orderTime.withDayOfMonth(1), now.withDayOfMonth(1)));
                        int mIdx = 5 - Math.min(5, Math.max(0, (int) monthDiff));
                        data.set(mIdx, data.get(mIdx) + 1);
                    }
                }
                break;

            case "1y":
                startDate = now.minusYears(1).withHour(0).withMinute(0).withSecond(0);
                labels.add("Q1");
                labels.add("Q2");
                labels.add("Q3");
                labels.add("Q4");
                for (int i = 0; i < 4; i++) data.add(0);

                List<Order> orders1y = orderDAO.findCreatedAfter(startDate.format(sqlFmt));
                for (Order o : orders1y) {
                    if (o.getCreatedAt() != null) {
                        LocalDateTime orderTime = o.getCreatedAt().toLocalDateTime();
                        long monthDiff = Math.abs(ChronoUnit.MONTHS.between(orderTime.withDayOfMonth(1), now.withDayOfMonth(1)));
                        int qIdx = 3 - Math.min(3, Math.max(0, (int) (monthDiff / 3)));
                        data.set(qIdx, data.get(qIdx) + 1);
                    }
                }
                break;

            case "7d":
            default:
                startDate = now.minusDays(6).withHour(0).withMinute(0).withSecond(0);
                for (int i = 6; i >= 0; i--) {
                    labels.add(now.minusDays(i).format(dayFmt));
                    data.add(0);
                }

                List<Order> orders7d = orderDAO.findCreatedAfter(startDate.format(sqlFmt));
                for (Order o : orders7d) {
                    if (o.getCreatedAt() != null) {
                        LocalDateTime orderTime = o.getCreatedAt().toLocalDateTime();
                        long dayDiff = Math.abs(ChronoUnit.DAYS.between(orderTime.toLocalDate(), now.toLocalDate()));
                        int idx = 6 - Math.min(6, Math.max(0, (int) dayDiff));
                        data.set(idx, data.get(idx) + 1);
                    }
                }
                break;
        }

        // SVG Coordinate calculations
        int maxVal = Collections.max(data);
        if (maxVal < 1) maxVal = 1;

        double viewWidth = 800;
        double viewHeight = 440;
        double paddingTop = 28;
        double paddingBottom = 42;
        double paddingLeft = 52;
        double paddingRight = 36;

        double plotWidth = viewWidth - paddingLeft - paddingRight;
        double plotHeight = viewHeight - paddingTop - paddingBottom;

        int count = data.size();
        double stepX = count > 1 ? plotWidth / (count - 1) : plotWidth;

        List<ChartPoint> points = new ArrayList<>();
        StringBuilder polylineSb = new StringBuilder();

        for (int i = 0; i < count; i++) {
            int val = data.get(i);
            double x = paddingLeft + (i * stepX);
            double y = paddingTop + plotHeight - (((double) val / maxVal) * plotHeight);
            String label = (i < labels.size()) ? labels.get(i) : "";
            points.add(new ChartPoint(x, y, val, label));

            if (i > 0) polylineSb.append(" ");
            polylineSb.append(String.format(java.util.Locale.US, "%.1f,%.1f", x, y));
        }

        String polylineStr = polylineSb.toString();
        double startX = points.get(0).getX();
        double endX = points.get(points.size() - 1).getX();
        double bottomY = paddingTop + plotHeight;
        String areaStr = String.format(java.util.Locale.US, "%.1f,%.1f %s %.1f,%.1f", startX, bottomY, polylineStr, endX, bottomY);

        int gridLinesCount = 4;
        List<ChartData.GridLine> gridLines = new ArrayList<>();
        for (int g = 0; g <= gridLinesCount; g++) {
            double lineY = paddingTop + (plotHeight / gridLinesCount) * g;
            int gridVal = (int) Math.round(maxVal - ((double) maxVal / gridLinesCount) * g);
            gridLines.add(new ChartData.GridLine(lineY, gridVal));
        }

        ChartData cd = new ChartData();
        cd.setData(data);
        cd.setLabels(labels);
        cd.setPoints(points);
        cd.setPolylineStr(polylineStr);
        cd.setAreaStr(areaStr);
        cd.setMaxVal(maxVal);
        cd.setGridLines(gridLines);

        return cd;
    }
}
