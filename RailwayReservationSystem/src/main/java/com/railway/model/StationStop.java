package com.railway.model;

public class StationStop {
    private int distanceId;
    private String stationName;
    private int kmFromSource;

    public StationStop(int distanceId, String stationName, int kmFromSource) {
        this.distanceId = distanceId;
        this.stationName = stationName;
        this.kmFromSource = kmFromSource;
    }

    // Getters
    public int getDistanceId() { return distanceId; }
    public String getStationName() { return stationName; }
    public int getKmFromSource() { return kmFromSource; }
}