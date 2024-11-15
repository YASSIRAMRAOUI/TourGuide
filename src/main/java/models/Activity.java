package models;

import java.util.List;

public class Activity {
    private int activityId;
    private String name;
    private String description;
    private int tourId;
    private String tourTitle;

    private List<Tour> tours;

    // Constructors
    public Activity() {
    }

    public Activity(String name, String description, int tourId, String tourTitle, List<Tour> tours) {
        this.name = name;
        this.description = description;
        this.tourId = tourId;
        this.tourTitle = tourTitle;
        this.tours = tours;
    }

    // Getters and Setters

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTourTitle() {
        return tourTitle;
    }

    public void setTourTitle(String tourTitle) {
        this.tourTitle = tourTitle;
    }

    public List<Tour> getTours() {
        return tours;
    }

    public void setTours(List<Tour> tours) {
        this.tours = tours;
    }
}
