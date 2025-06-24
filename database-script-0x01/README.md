# 🏡 Airbnb Database Schema (Normalized - 3NF)

This project defines a relational database schema for an Airbnb-style application. The schema includes users, properties, bookings, payments, reviews, and messaging, all normalized to **Third Normal Form (3NF)** to ensure data integrity and reduce redundancy.

---

## 📘 Overview

The schema includes the following entities:

- `users`: Registered individuals including guests, hosts, and admins.
- `properties`: Listings available for booking.
- `property_prices`: Historical price tracking for properties.
- `bookings`: Reservation details for users and properties.
- `payments`: Payment records per booking.
- `reviews`: Feedback provided by users after bookings.
- `messages`: Internal messaging between users.

---

## 🧱 Schema Design Highlights

- Fully normalized to **3NF**
- Uses **UUIDs** as primary keys for scalability
- **ENUM-like constraints** via `CHECK` clauses
- **Foreign keys** to maintain referential integrity
- **Indexing** on key lookup fields for performance

---

## 🗃️ Database Tables

### users

Stores personal details and login credentials.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| user_id        | UUID     | Primary Key                              |
| email          | VARCHAR  | Unique, Indexed                          |
| role           | VARCHAR  | guest, host, admin (CHECK constraint)    |
| created_at     | TIMESTAMP | Default: CURRENT_TIMESTAMP               |

---

### properties

Represents listings added by hosts.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| property_id    | UUID     | Primary Key                              |
| host_id        | UUID     | FK → users(user_id)                      |

---

### property_prices

Tracks price changes over time.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| price_id       | UUID     | Primary Key                              |
| property_id    | UUID     | FK → properties(property_id)             |
| valid_from     | DATE     | Required                                 |

---

### bookings

Captures reservation info.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| booking_id     | UUID     | Primary Key                              |
| property_id    | UUID     | FK → properties(property_id)             |
| user_id        | UUID     | FK → users(user_id)                      |
| status         | VARCHAR  | pending, confirmed, canceled             |

---

### payments

Supports multiple payments per booking.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| payment_id     | UUID     | Primary Key                              |
| booking_id     | UUID     | FK → bookings(booking_id)                |
| payment_method | VARCHAR  | credit_card, paypal, stripe              |

---

### reviews

Review tied to a booking (not directly to user/property).

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| review_id      | UUID     | Primary Key                              |
| booking_id     | UUID     | FK → bookings(booking_id)                |
| rating         | INTEGER  | CHECK (1-5)                              |

---

### messages

Private messaging between users.

| Column         | Type     | Constraints                              |
|----------------|----------|------------------------------------------|
| message_id     | UUID     | Primary Key                              |
| sender_id      | UUID     | FK → users(user_id)                      |
| recipient_id   | UUID     | FK → users(user_id)                      |

---

## 🚀 Getting Started

### Prerequisites

- PostgreSQL (or compatible RDBMS)
- SQL client or interface like DBeaver, pgAdmin, or psql

### Run the SQL Schema

```bash
psql -U your_user -d your_db -f schema.sql
