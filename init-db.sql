-- TourGuide Database Initialization Script
-- This script will run automatically when the MySQL container starts

USE TourGuide;

-- Create users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    image_path VARCHAR(255),
    role VARCHAR(50) NOT NULL
);

-- Create tours table
CREATE TABLE tours (
    tour_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    start VARCHAR(255) NOT NULL,
    end VARCHAR(255) NOT NULL,
    date VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    guide_id INT,
    image_path VARCHAR(255),
    map_embed_code TEXT,
    category VARCHAR(100),
    FOREIGN KEY (guide_id) REFERENCES users(user_id)
);

-- Create activities table
CREATE TABLE activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_path VARCHAR(255)
);

-- Create activity_tour junction table
CREATE TABLE activity_tour (
    activity_id INT,
    tour_id INT,
    PRIMARY KEY (activity_id, tour_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id),
    FOREIGN KEY (tour_id) REFERENCES tours(tour_id)
);

-- Create reservations table
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

-- Create reviews table
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

-- Create password_reset_tokens table
CREATE TABLE password_reset_tokens (
    token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert some sample data (optional)
INSERT INTO users (name, email, password, role) VALUES 
('Admin User', 'admin@tourguide.com', '$2a$10$example.hash.here', 'admin'),
('John Doe', 'john@example.com', '$2a$10$example.hash.here', 'guide'),
('Jane Smith', 'jane@example.com', '$2a$10$example.hash.here', 'customer');

INSERT INTO activities (name, description) VALUES 
('Hiking', 'Explore nature trails and scenic landscapes'),
('Photography', 'Capture beautiful moments and landscapes'),
('Cultural Tours', 'Learn about local history and traditions'),
('Food Tasting', 'Experience local cuisine and specialties');

COMMIT;