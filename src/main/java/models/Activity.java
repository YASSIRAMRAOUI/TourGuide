package models;

import java.util.List;

public class Activity {
    private int activityId;
    private String name;
    private String description;
    private List<Tour> associatedTours;

    // Constructors
    public Activity() {
    }

    public Activity(String name, String description, List<Tour> associatedTours) {
        this.name = name;
        this.description = description;
        this.associatedTours = associatedTours;
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

    public List<Tour> getAssociatedTours() {
        return associatedTours;
    }

    public void setAssociatedTours(List<Tour> associatedTours) {
        this.associatedTours = associatedTours;
    }
}
