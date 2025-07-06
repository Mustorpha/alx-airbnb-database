-- Indexes to improve query performance on User, Booking, and Property tables

-- User Table
CREATE NONCLUSTERED INDEX idx_users_email ON users(email);

-- Booking Table
CREATE NONCLUSTERED INDEX idx_bookings_user_id ON bookings(user_id);
CREATE NONCLUSTERED INDEX idx_bookings_status ON bookings(status);
CREATE NONCLUSTERED INDEX idx_bookings_created_at ON bookings(created_at);

-- Property Table
CREATE NONCLUSTERED INDEX idx_properties_host_id ON properties(host_id);
CREATE NONCLUSTERED INDEX idx_properties_location ON properties(location);
