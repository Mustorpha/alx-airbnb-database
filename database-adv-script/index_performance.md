# Index Performance

## Query

```sql
-- Before Indexing
-- Before indexes
EXPLAIN ANALYZE
SELECT 
  u.first_name, u.last_name, b.booking_id, p.name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
ORDER BY b.created_at DESC;


-- Create Index
-- User Table
CREATE NONCLUSTERED INDEX idx_users_email ON users(email);

-- Booking Table
CREATE NONCLUSTERED INDEX idx_bookings_user_id ON bookings(user_id);
CREATE NONCLUSTERED INDEX idx_bookings_status ON bookings(status);
CREATE NONCLUSTERED INDEX idx_bookings_created_at ON bookings(created_at);

-- Property Table
CREATE NONCLUSTERED INDEX idx_properties_host_id ON properties(host_id);
CREATE NONCLUSTERED INDEX idx_properties_location ON properties(location);

-- After Indexing
EXPLAIN ANALYZE
SELECT 
  u.first_name, u.last_name, b.booking_id, p.name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
ORDER BY b.created_at DESC;

```
