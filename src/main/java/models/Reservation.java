package models;

import java.util.Date;

public class Reservation {
    private int reservationId;
    private int tourId;
    private int userId;
    private Date reservationDate;
    private int numberOfPeople;
    private String status;
    private String userName;
    private String userEmail;
    private String tourTitle;

    // Constructors
    public Reservation() {
    }

    public Reservation(int tourId, int userId, Date reservationDate, int numberOfPeople, String status, String userName,
            String tourTitle, String userEmail) {
        this.tourId = tourId;
        this.userId = userId;
        this.reservationDate = reservationDate;
        this.numberOfPeople = numberOfPeople;
        this.status = status;
        this.userName = userName;
        this.userEmail = userEmail;
        this.tourTitle = tourTitle;
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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getTourTitle() {
        return tourTitle;
    }

    public void setTourTitle(String tourTitle) {
        this.tourTitle = tourTitle;
    }
}
