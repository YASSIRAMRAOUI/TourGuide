package models;

import java.util.Date;

public class Comment {
    private int commentId;
    private int userId;
    private int tourId;
    private String content;
    private Date commentDate;
    private String userName;

    // Constructors
    public Comment() {
    }

    public Comment(int userId, int tourId, String content, Date commentDate, String userName) {
        this.userId = userId;
        this.tourId = tourId;
        this.content = content;
        this.commentDate = commentDate;
        this.userName = userName;
    }

    // Getters and Setters

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
