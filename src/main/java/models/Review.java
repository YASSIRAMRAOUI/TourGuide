package models;

import java.util.Date;

public class Review {
    private int reviewId;
    private int tourId;
    private int userId;
    private String comment;
    private int rating;
    private Date reviewDate;
    private String userName;
    private String tourTitle;
    private String userEmail;
    private String userImagePath;

    // Constructors
    public Review() {
    }

    public Review(int tourId, int userId, String comment, int rating, Date reviewDate, String userName,
            String tourTitle, String userEmail, String userImagePath) {
        this.tourId = tourId;
        this.userId = userId;
        this.comment = comment;
        this.rating = rating;
        this.reviewDate = reviewDate;
        this.userName = userName;
        this.tourTitle = tourTitle;
        this.userEmail = userEmail;
        this.userImagePath = userImagePath;
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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTourTitle() {
        return tourTitle;
    }

    public void setTourTitle(String tourTitle) {
        this.tourTitle = tourTitle;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserImagePath() {
        return userImagePath;
    }

    public void setUserImagePath(String userImagePath) {
        this.userImagePath = userImagePath;
    }
}
