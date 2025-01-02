# Database Schema

This document outlines the database schema for the application. Below are the SQL table definitions required for the project.

## Tables

### `users`
Stores user information.

```sql
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    image_path VARCHAR(255),
    role VARCHAR(50) NOT NULL
);
```
### `tours`
Stores tour information.

```sql
CREATE TABLE tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    guide_id INT,
    image_path VARCHAR(255),
    map_embed_code TEXT,
    category VARCHAR(100),
    FOREIGN KEY (guide_id) REFERENCES users(user_id)
);
```
### `activities`
Stores activity information.

```sql
CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_path VARCHAR(255)
);
```
### `activity_tour`
Manages the many-to-many relationship between activities and tours.

```sql
CREATE TABLE activity_tour (
    activity_id INT,
    tour_id INT,
    PRIMARY KEY (activity_id, tour_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id),
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id)
);
```
### `reservations`
Stores reservation information.

```sql
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_id INT NOT NULL,
    user_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    number_of_people INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```
### `reviews`
Stores review information.

```sql
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    tour_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT,
    rating INT NOT NULL,
    review_date DATE NOT NULL,
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```
### `password_reset_tokens`
Stores password reset tokens for users.

```sql
CREATE TABLE password_reset_tokens (
    token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```
Notes
Primary Keys: Each table has an AUTO_INCREMENT primary key to ensure unique identifiers.

Foreign Keys: Relationships between tables are enforced using foreign key constraints.

Unique Constraints: The email column in the users table is unique to prevent duplicate registrations.
