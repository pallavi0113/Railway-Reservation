package com.railway.model;

public class Train {
    private int trainId;
    private String trainName;
    private String trainNumber;
    private String sourceStation;
    private String destinationStation;
    private String departureTime;
    private String arrivalTime;
    private int totalSeats;
    private int availableSeats;
    
    // Base fare (General)
    private double fare; 
    
    // 🆕 NEW FIELDS YOU WERE MISSING
    private int journeyDistance;
    private String viaStations; // This fixes the JSP error
    
    // Class-specific fares (For DAO extraction)
    private double fareGeneral;
    private double fareSleeper;
    private double fare3AC;
    private double fare2AC;
    private double fare1AC;

    public Train() {}

    // --- GETTERS AND SETTERS ---

    public int getTrainId() { return trainId; }
    public void setTrainId(int trainId) { this.trainId = trainId; }

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public String getTrainNumber() { return trainNumber; }
    public void setTrainNumber(String trainNumber) { this.trainNumber = trainNumber; }

    public String getSourceStation() { return sourceStation; }
    public void setSourceStation(String sourceStation) { this.sourceStation = sourceStation; }

    public String getDestinationStation() { return destinationStation; }
    public void setDestinationStation(String destinationStation) { this.destinationStation = destinationStation; }

    public String getDepartureTime() { return departureTime; }
    public void setDepartureTime(String departureTime) { this.departureTime = departureTime; }

    public String getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(String arrivalTime) { this.arrivalTime = arrivalTime; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }

    // 🆕 The missing ones causing your error
    public int getJourneyDistance() { return journeyDistance; }
    public void setJourneyDistance(int journeyDistance) { this.journeyDistance = journeyDistance; }

    public String getViaStations() { return viaStations; }
    public void setViaStations(String viaStations) { this.viaStations = viaStations; }

    // 🆕 Fare Getters/Setters
    public double getFareGeneral() { return fareGeneral; }
    public void setFareGeneral(double fareGeneral) { this.fareGeneral = fareGeneral; }

    public double getFareSleeper() { return fareSleeper; }
    public void setFareSleeper(double fareSleeper) { this.fareSleeper = fareSleeper; }

    public double getFare3AC() { return fare3AC; }
    public void setFare3AC(double fare3AC) { this.fare3AC = fare3AC; }

    public double getFare2AC() { return fare2AC; }
    public void setFare2AC(double fare2AC) { this.fare2AC = fare2AC; }

    public double getFare1AC() { return fare1AC; }
    public void setFare1AC(double fare1AC) { this.fare1AC = fare1AC; }
}