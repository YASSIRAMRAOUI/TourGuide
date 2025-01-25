package models;

public class Tour {
    private int tourId;
    private String title;
    private String description;
    private String start;
    private String end;
    private String date;
    private double price;
    private int guideId;
    private String imagePath;
    private String mapEmbedCode;
    private String category;

    // Constructors
    public Tour() {
    }

    public Tour(String title, String description, String start, String end, String date,
            double price, int guideId, String imagePath, String mapEmbedCode, String category) {
        this.title = title;
        this.description = description;
        this.start = start;
        this.end = end;
        this.date = date;
        this.price = price;
        this.guideId = guideId;
        this.imagePath = imagePath;
        this.mapEmbedCode = mapEmbedCode;
        this.category = category;
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

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
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

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getMapEmbedCode() {
        return mapEmbedCode;
    }

    public void setMapEmbedCode(String mapEmbedCode) {
        this.mapEmbedCode = mapEmbedCode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
