# 📥 Airbnb Database Sample Data (SQL Server)

This document explains how to populate the normalized Airbnb database (SQL Server version) with **realistic sample data** using auto-generated UUIDs (`NEWID()`).

---

## 🧱 Prerequisites

Before running the insert script:

- Ensure the database schema is created using the `CREATE TABLE` statements with `NEWID()` defaults.
- You're using Microsoft SQL Server (2017+ is ideal).
- You're connected via SQL Server Management Studio (SSMS), Azure Data Studio, or any SQL execution tool.

---

## 📦 Data Included

| Table            | Sample Records | Notes                                                |
|------------------|----------------|------------------------------------------------------|
| `users`          | 2              | 1 Host (Alice), 1 Guest (Bob)                        |
| `properties`     | 2              | Both owned by Alice                                  |
| `property_prices`| 2              | One price per property                               |
| `bookings`       | 2              | Bookings by Bob for both properties                  |
| `payments`       | 2              | One full payment, one partial                        |
| `reviews`        | 1              | Review left for the first booking                    |
| `messages`       | 1              | Message from Bob to Alice                            |

---

## ⚙️ Auto-Generated UUIDs

The schema uses `NEWID()` to automatically generate `UNIQUEIDENTIFIER` primary keys. Instead of manually specifying UUIDs, the script captures generated IDs using `OUTPUT INSERTED`.

---

## 📌 How Relationships Are Maintained

To ensure foreign key integrity, we use **table variables** to store generated IDs:

```sql
DECLARE @userHost UNIQUEIDENTIFIER, @userGuest UNIQUEIDENTIFIER;
DECLARE @property1 UNIQUEIDENTIFIER, @property2 UNIQUEIDENTIFIER;
DECLARE @booking1 UNIQUEIDENTIFIER, @booking2 UNIQUEIDENTIFIER;
