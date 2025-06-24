-- USERS
CREATE TABLE users (
    user_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at DATETIME DEFAULT GETDATE()
);

-- PROPERTIES
CREATE TABLE properties (
    property_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    host_id UNIQUEIDENTIFIER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

-- PROPERTY_PRICES
CREATE TABLE property_prices (
    price_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- BOOKINGS
CREATE TABLE bookings (
    booking_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- PAYMENTS
CREATE TABLE payments (
    payment_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    booking_id UNIQUEIDENTIFIER NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- REVIEWS
CREATE TABLE reviews (
    review_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    booking_id UNIQUEIDENTIFIER NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- MESSAGES
CREATE TABLE messages (
    message_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    sender_id UNIQUEIDENTIFIER NOT NULL,
    recipient_id UNIQUEIDENTIFIER NOT NULL,
    message_body TEXT NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);
