package models;

import java.util.Date;

public class Review {
    private int reviewId;
    private int tourId;
    private int userId; // Reference to the tourist (User) who wrote the review
    private String comment;
    private int rating; // Rating out of 5
    private Date reviewDate;

    // Constructors
    public Review() {
    }

    public Review(int tourId, int userId, String comment, int rating, Date reviewDate) {
        this.tourId = tourId;
        this.userId = userId;
        this.comment = comment;
        this.rating = rating;
        this.reviewDate = reviewDate;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
}
