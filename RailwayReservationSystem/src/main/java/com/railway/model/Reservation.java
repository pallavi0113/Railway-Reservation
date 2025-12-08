package com.railway.model;

import java.util.Date;

public class Reservation {
	private int reservationId;
	private int userId;
	private int trainId;
	private String passengerName;
	private int age;
	private String gender;
	private Date journeyDate;
	private int seatsBooked;
	private double totalFare;
	private String bookingStatus;
	private Date bookingDate;
	
	private String trainName;
	private String trainNumber;
	private String sourceStation;
	private String destinationStation;

	public Reservation() {}

	/**
	 * @param userId
	 * @param trainId
	 * @param passengerName
	 * @param age
	 * @param gender
	 * @param journeyDate
	 * @param seatsBooked
	 * @param totalFare
	 * @param bookingStatus
	 * @param bookingDate
	 * @param trainName
	 * @param trainNumber
	 * @param sourceStation
	 * @param destinationStation
	 */
	public Reservation(int userId, int trainId, String passengerName, int age, String gender, Date journeyDate,
			int seatsBooked, double totalFare, String bookingStatus, Date bookingDate, String trainName,
			String trainNumber, String sourceStation, String destinationStation) {
		super();
		this.userId = userId;
		this.trainId = trainId;
		this.passengerName = passengerName;
		this.age = age;
		this.gender = gender;
		this.journeyDate = journeyDate;
		this.seatsBooked = seatsBooked;
		this.totalFare = totalFare;
		this.bookingStatus = bookingStatus;
		this.bookingDate = bookingDate;
		this.trainName = trainName;
		this.trainNumber = trainNumber;
		this.sourceStation = sourceStation;
		this.destinationStation = destinationStation;
	}

	public int getReservationId() {
		return reservationId;
	}

	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getTrainId() {
		return trainId;
	}

	public void setTrainId(int trainId) {
		this.trainId = trainId;
	}

	public String getPassengerName() {
		return passengerName;
	}

	public void setPassengerName(String passengerName) {
		this.passengerName = passengerName;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getJourneyDate() {
		return journeyDate;
	}

	public void setJourneyDate(Date journeyDate) {
		this.journeyDate = journeyDate;
	}

	public int getSeatsBooked() {
		return seatsBooked;
	}

	public void setSeatsBooked(int seatsBooked) {
		this.seatsBooked = seatsBooked;
	}

	public double getTotalFare() {
		return totalFare;
	}

	public void setTotalFare(double totalFare) {
		this.totalFare = totalFare;
	}

	public String getBookingStatus() {
		return bookingStatus;
	}

	public void setBookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}

	public Date getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}

	public String getTrainName() {
		return trainName;
	}

	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}

	public String getTrainNumber() {
		return trainNumber;
	}

	public void setTrainNumber(String trainNumber) {
		this.trainNumber = trainNumber;
	}

	public String getSourceStation() {
		return sourceStation;
	}

	public void setSourceStation(String sourceStation) {
		this.sourceStation = sourceStation;
	}

	public String getDestinationStation() {
		return destinationStation;
	}

	public void setDestinationStation(String destinationStation) {
		this.destinationStation = destinationStation;
	}
	
	
	
}
