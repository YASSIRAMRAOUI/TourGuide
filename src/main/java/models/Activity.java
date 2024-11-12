package models;

public class Activity {
    private int activityId;
    private String name;
    private String description;
    private int tourId;

    // Constructors
    public Activity() {
    }

    public Activity(String name, String description, int tourId) {
        this.name = name;
        this.description = description;
        this.tourId = tourId;
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
}
