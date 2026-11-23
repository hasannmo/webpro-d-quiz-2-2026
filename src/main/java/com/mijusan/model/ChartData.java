package com.mijusan.model;

import java.util.List;

public class ChartData {
    private List<Integer> data;
    private List<String> labels;
    private List<ChartPoint> points;
    private String polylineStr;
    private String areaStr;
    private int maxVal;
    private List<GridLine> gridLines;

    public static class GridLine {
        private double y;
        private int val;

        public GridLine(double y, int val) {
            this.y = y;
            this.val = val;
        }

        public double getY() { return y; }
        public int getVal() { return val; }
    }

    public List<Integer> getData() { return data; }
    public void setData(List<Integer> data) { this.data = data; }

    public List<String> getLabels() { return labels; }
    public void setLabels(List<String> labels) { this.labels = labels; }

    public List<ChartPoint> getPoints() { return points; }
    public void setPoints(List<ChartPoint> points) { this.points = points; }

    public String getPolylineStr() { return polylineStr; }
    public void setPolylineStr(String polylineStr) { this.polylineStr = polylineStr; }

    public String getAreaStr() { return areaStr; }
    public void setAreaStr(String areaStr) { this.areaStr = areaStr; }

    public int getMaxVal() { return maxVal; }
    public void setMaxVal(int maxVal) { this.maxVal = maxVal; }

    public List<GridLine> getGridLines() { return gridLines; }
    public void setGridLines(List<GridLine> gridLines) { this.gridLines = gridLines; }
}
