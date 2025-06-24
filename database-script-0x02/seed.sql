-- Declare table variables to hold generated IDs
DECLARE @userHost UNIQUEIDENTIFIER, @userGuest UNIQUEIDENTIFIER;
DECLARE @property1 UNIQUEIDENTIFIER, @property2 UNIQUEIDENTIFIER;
DECLARE @booking1 UNIQUEIDENTIFIER, @booking2 UNIQUEIDENTIFIER;

-- USERS
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
OUTPUT INSERTED.user_id INTO @userHost
VALUES ('Alice', 'Johnson', 'alice@example.com', 'hashed_pw_1', '555-1234', 'host');

INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
OUTPUT INSERTED.user_id INTO @userGuest
VALUES ('Bob', 'Smith', 'bob@example.com', 'hashed_pw_2', '555-5678', 'guest');

-- PROPERTIES
INSERT INTO properties (host_id, name, description, location)
OUTPUT INSERTED.property_id INTO @property1
VALUES (@userHost, 'Cozy Cottage', 'A peaceful place in the woods.', 'Colorado');

INSERT INTO properties (host_id, name, description, location)
OUTPUT INSERTED.property_id INTO @property2
VALUES (@userHost, 'Beach House', 'Seaside paradise with ocean view.', 'California');

-- PROPERTY PRICES
INSERT INTO property_prices (property_id, price_per_night, valid_from)
VALUES (@property1, 120.00, '2024-01-01'),
       (@property2, 200.00, '2024-01-01');

-- BOOKINGS
INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
OUTPUT INSERTED.booking_id INTO @booking1
VALUES (@property1, @userGuest, '2024-07-01', '2024-07-05', 480.00, 'confirmed');

INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
OUTPUT INSERTED.booking_id INTO @booking2
VALUES (@property2, @userGuest, '2024-08-10', '2024-08-12', 400.00, 'pending');

-- PAYMENTS
INSERT INTO payments (booking_id, amount, payment_method)
VALUES (@booking1, 480.00, 'credit_card'),
       (@booking2, 200.00, 'paypal');

-- REVIEWS
INSERT INTO reviews (booking_id, rating, comment)
VALUES (@booking1, 5, 'Wonderful place, peaceful and cozy!');

-- MESSAGES
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES (@userGuest, @userHost, 'Hi! Is the beach house available for next weekend?');
