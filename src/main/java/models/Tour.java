package models;

import java.util.Date;

public class Tour {
    private int tourId;
    private String title;
    private String description;
    private String location;
    private Date date;
    private double price;
    private int guideId; // Reference to the guide (User) who created the tour

    // Constructors
    public Tour() {
    }

    public Tour(String title, String description, String location, Date date, double price, int guideId) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
        this.guideId = guideId;
    }

    // Getters and Setters
    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getGuideId() {
        return guideId;
    }

    public void setGuideId(int guideId) {
        this.guideId = guideId;
    }
}
