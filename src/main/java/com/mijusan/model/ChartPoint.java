package com.mijusan.model;

public class ChartPoint {
    private double x;
    private double y;
    private int val;
    private String label;

    public ChartPoint(double x, double y, int val, String label) {
        this.x = x;
        this.y = y;
        this.val = val;
        this.label = label;
    }

    public double getX() { return x; }
    public double getY() { return y; }
    public int getVal() { return val; }
    public String getLabel() { return label; }
}
