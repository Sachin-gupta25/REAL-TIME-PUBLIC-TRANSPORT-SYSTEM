-- Yatra Yatri Management System Database Schema
-- MySQL Database Schema

CREATE DATABASE IF NOT EXISTS yatra_yatri_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE yatra_yatri_db;

-- Users table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('ADMIN', 'OPERATOR', 'TRAVELER') DEFAULT 'TRAVELER',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_role (role)
);

-- Trips table
CREATE TABLE trips (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    trip_name VARCHAR(255) NOT NULL,
    destination VARCHAR(255) NOT NULL,
    departure_location VARCHAR(255) NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    description TEXT,
    trip_status ENUM('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') DEFAULT 'SCHEDULED',
    vehicle_type ENUM('BUS', 'TRAIN', 'FLIGHT', 'CAR'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_destination (destination),
    INDEX idx_departure_location (departure_location),
    INDEX idx_departure_time (departure_time),
    INDEX idx_trip_status (trip_status),
    INDEX idx_available_seats (available_seats)
);

-- Bookings table
CREATE TABLE bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    trip_id BIGINT NOT NULL,
    seats_booked INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    booking_status ENUM('CONFIRMED', 'CANCELLED', 'COMPLETED') DEFAULT 'CONFIRMED',
    booking_reference VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES trips(id) ON DELETE CASCADE,
    
    INDEX idx_user_id (user_id),
    INDEX idx_trip_id (trip_id),
    INDEX idx_booking_reference (booking_reference),
    INDEX idx_booking_status (booking_status)
);

-- Payments table (for future enhancement)
CREATE TABLE payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('CREDIT_CARD', 'DEBIT_CARD', 'UPI', 'NET_BANKING', 'CASH') NOT NULL,
    payment_status ENUM('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED') DEFAULT 'PENDING',
    transaction_id VARCHAR(100),
    payment_gateway VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    
    INDEX idx_booking_id (booking_id),
    INDEX idx_payment_status (payment_status),
    INDEX idx_transaction_id (transaction_id)
);

-- Vehicles table (for future enhancement)
CREATE TABLE vehicles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_number VARCHAR(20) NOT NULL UNIQUE,
    vehicle_type ENUM('BUS', 'TRAIN', 'FLIGHT', 'CAR') NOT NULL,
    capacity INT NOT NULL,
    manufacturer VARCHAR(100),
    model VARCHAR(100),
    year_of_manufacture YEAR,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_vehicle_number (vehicle_number),
    INDEX idx_vehicle_type (vehicle_type),
    INDEX idx_is_active (is_active)
);

-- Insert sample data
INSERT INTO users (username, email, password, first_name, last_name, phone_number, role) VALUES
('admin', 'admin@yatrayatri.com', '$2a$10$XZOmn/FH8YGa5S1Qx5BSeOYJSSE4D8k0LFKGRVqZ3ZJXZOmYQx2NG', 'Admin', 'User', '9876543210', 'ADMIN'),
('operator1', 'operator@yatrayatri.com', '$2a$10$XZOmn/FH8YGa5S1Qx5BSeOYJSSE4D8k0LFKGRVqZ3ZJXZOmYQx2NG', 'Travel', 'Operator', '9876543211', 'OPERATOR'),
('traveler1', 'user@yatrayatri.com', '$2a$10$XZOmn/FH8YGa5S1Qx5BSeOYJSSE4D8k0LFKGRVqZ3ZJXZOmYQx2NG', 'John', 'Doe', '9876543212', 'TRAVELER');

INSERT INTO trips (trip_name, destination, departure_location, departure_time, arrival_time, price, total_seats, available_seats, description, vehicle_type) VALUES
('Delhi to Mumbai Express', 'Mumbai', 'Delhi', '2024-12-01 08:00:00', '2024-12-01 20:00:00', 1500.00, 50, 50, 'Comfortable journey from Delhi to Mumbai', 'BUS'),
('Bangalore to Chennai Special', 'Chennai', 'Bangalore', '2024-12-02 06:00:00', '2024-12-02 12:00:00', 800.00, 40, 40, 'Express service to Chennai', 'BUS'),
('Goa Beach Holiday', 'Goa', 'Mumbai', '2024-12-05 22:00:00', '2024-12-06 08:00:00', 2000.00, 30, 30, 'Overnight journey to beautiful Goa', 'BUS');