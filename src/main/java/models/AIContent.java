package models;

public class AIContent {
    private int contentId;
    private int tourId;
    private String generatedDescription;

    // Constructors
    public AIContent() {
    }

    public AIContent(int tourId, String generatedDescription) {
        this.tourId = tourId;
        this.generatedDescription = generatedDescription;
    }

    // Getters and Setters
    public int getContentId() {
        return contentId;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getGeneratedDescription() {
        return generatedDescription;
    }

    public void setGeneratedDescription(String generatedDescription) {
        this.generatedDescription = generatedDescription;
    }
}
