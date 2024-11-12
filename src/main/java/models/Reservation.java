package models;

import java.util.Date;

public class Reservation {
    private int reservationId;
    private int tourId;
    private int userId; // Reference to the tourist (User) who made the reservation
    private Date reservationDate;
    private int numberOfPeople;
    private String status; // e.g., "Confirmed", "Pending", "Cancelled"

    // Constructors
    public Reservation() {
    }

    public Reservation(int tourId, int userId, Date reservationDate, int numberOfPeople, String status) {
        this.tourId = tourId;
        this.userId = userId;
        this.reservationDate = reservationDate;
        this.numberOfPeople = numberOfPeople;
        this.status = status;
    }

    // Getters and Setters
    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public int getNumberOfPeople() {
        return numberOfPeople;
    }

    public void setNumberOfPeople(int numberOfPeople) {
        this.numberOfPeople = numberOfPeople;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
