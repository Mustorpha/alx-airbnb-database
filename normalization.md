# Airbnb Database Normalization to 3NF

## 🎯 Goal

The goal of this normalization process is to identify and remove data redundancies and anomalies in the Airbnb database design by applying the principles of database normalization, up to **Third Normal Form (3NF)**.

---

## 🔍 Step-by-Step Normalization

### ✅ First Normal Form (1NF)

**1NF Requirements:**

- Atomic (indivisible) values
- Unique column names
- Unique rows

**Observations:**

- The original schema had atomic fields (no multi-valued or composite attributes), so it satisfies 1NF.

---

### ✅ Second Normal Form (2NF)

**2NF Requirements:**

- Must be in 1NF
- No partial dependencies (i.e., no non-key attribute depends on part of a composite primary key)

**Observations:**

- All primary keys in the original schema are single-column UUIDs.
- There were **no partial dependencies**, so the schema satisfies 2NF.

---

### ❌ Third Normal Form (3NF)

**3NF Requirements:**

- Must be in 2NF
- No transitive dependencies (i.e., non-key attributes must not depend on other non-key attributes)

**Issues Identified and Resolved:**

### 1. Review Table Redundancy

- **Original:** `reviews` table contained both `user_id` and `property_id`.
- **Problem:** These can be inferred from `booking_id`, which already links the user and property.
- **Fix:** Replaced both `user_id` and `property_id` with `booking_id` to eliminate redundancy and ensure consistency.

### 2. Payment Flexibility

- **Original:** Payments linked 1-to-1 with bookings.
- **Problem:** If partial or multiple payments are allowed, this structure violates 1NF and introduces design rigidity.
- **Fix:** The `payments` table now allows multiple rows per `booking_id`, each with its `amount`, `payment_method`, and `payment_date`.

### 3. Property Pricing

- **Original:** `price_per_night` stored directly in the `properties` table.
- **Problem:** This violates 3NF if pricing changes over time, as multiple rows would require redundant data or override history.
- **Fix:** Extracted `price_per_night` into a new `property_prices` table with `valid_from` and optional `valid_to` dates.

---

## ✅ Resulting Benefits

- Reduced **redundancy**
- Improved **data integrity**
- Easier to manage **historical pricing**
- Maintains **3NF compliance**
- Easier to extend and query

---

## 📦 Tables Introduced or Modified

| Table              | Purpose                                         |
|-------------------|-------------------------------------------------|
| `reviews`          | References only `booking_id`                   |
| `payments`         | Allows multiple payments per booking           |
| `property_prices`  | Supports historical and dynamic pricing        |

---

## 📌 Conclusion

The redesigned schema is now fully normalized to **Third Normal Form (3NF)**, ensuring data consistency, scalability, and maintainability in the Airbnb-like application.
