-- ============================================================
-- 00_schema.sql  |  Table definition for the Orders dataset
-- Dialect: SQLite (works in any SQLite client / DB Browser)
-- ============================================================

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id         TEXT PRIMARY KEY,   -- e.g. ORD200000
    order_date       TEXT NOT NULL,      -- ISO format YYYY-MM-DD
    customer_id      TEXT NOT NULL,
    product          TEXT NOT NULL,
    quantity         INTEGER NOT NULL,
    unit_price       REAL NOT NULL,
    shipping_address TEXT,
    payment_method   TEXT,
    order_status     TEXT,               -- Delivered / Shipped / Pending / Cancelled / Returned
    tracking_number  TEXT,
    items_in_cart    INTEGER,
    coupon_code      TEXT,               -- NULL when no coupon was used
    referral_source  TEXT,
    total_price      REAL NOT NULL       -- quantity * unit_price
);
