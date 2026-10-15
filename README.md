# 🛒 SQL Data Analysis – E-Commerce Orders

> **DecodeLabs Industrial Training Kit · Data Analytics · Project 3**
> Goal: use SQL to turn raw order data into actionable business insights.

![SQL](https://img.shields.io/badge/SQL-SQLite-blue) ![Python](https://img.shields.io/badge/Python-3.9%2B-green) ![Status](https://img.shields.io/badge/Project-Completed-brightgreen)

---

## 📌 Project Overview
This project analyses **1,200 e-commerce orders (Jan 2023 – Jun 2025)** using pure SQL.
It covers every requirement of Project 3:

| Requirement | Where it is used |
|---|---|
| `SELECT` queries | `sql/01_select_basics.sql` |
| `WHERE` filtering (=, >=, AND, IN, BETWEEN, IS NULL, LIKE) | `sql/02_where_filters.sql` |
| `ORDER BY` | `sql/03_order_by.sql` |
| `GROUP BY` + `COUNT`, `SUM`, `AVG` | `sql/04_group_by_aggregations.sql` |
| `HAVING`, % contribution, `CASE WHEN` (bonus) | `sql/05_having_and_advanced.sql` |

## 🗂️ Dataset
`data/orders.csv` (cleaned copy of `data/orders_raw.xlsx`) – 1,200 rows, 14 columns, no duplicate order IDs.

| Column | Description |
|---|---|
| order_id | Unique order ID |
| order_date | Date of order (YYYY-MM-DD) |
| customer_id | Customer ID |
| product | Laptop, Phone, Tablet, Monitor, Printer, Chair, Desk |
| quantity / unit_price | Units and price per unit |
| shipping_address, tracking_number | Delivery details |
| payment_method | Credit Card, Debit Card, Cash, Gift Card, Online |
| order_status | Delivered, Shipped, Pending, Cancelled, Returned |
| items_in_cart | Cart size at checkout |
| coupon_code | SAVE10, WINTER15, FREESHIP (**309 NULLs = no coupon**) |
| referral_source | Instagram, Email, Google, Facebook, Referral |
| total_price | quantity × unit_price |

## 📁 Repository Structure
```
sql-data-analysis/
├── data/
│   ├── orders.csv            # cleaned dataset (used by the script)
│   └── orders_raw.xlsx       # original Excel file
├── sql/
│   ├── 00_schema.sql
│   ├── 01_select_basics.sql
│   ├── 02_where_filters.sql
│   ├── 03_order_by.sql
│   ├── 04_group_by_aggregations.sql
│   └── 05_having_and_advanced.sql
├── scripts/run_queries.py    # builds SQLite DB + runs all 30 queries
├── results/                  # CSV output of every query (Q01 … Q30)
├── requirements.txt
├── LICENSE
└── README.md
```

## ▶️ How to Run
```bash
git clone https://github.com/<your-username>/sql-data-analysis.git
cd sql-data-analysis
pip install -r requirements.txt
python scripts/run_queries.py
```
This creates `orders.db` (SQLite) and saves each query result in `/results`.
You can also open `orders.db` in **DB Browser for SQLite** and run the `.sql` files manually.

> ℹ️ Syntax is SQLite. For MySQL/PostgreSQL replace `strftime('%Y', order_date)` with `YEAR(order_date)` / `EXTRACT(YEAR FROM order_date)`.

---

## 🔍 Key Insights

| Metric | Result |
|---|---|
| Total orders / unique customers | 1,200 / 1,189 |
| Gross revenue (all statuses) | **1,264,761.96** |
| Net revenue (excl. Cancelled & Returned) | **745,088.05** |
| Orders lost to Cancelled + Returned | **41.42 %** |
| Orders placed without a coupon | 309 (25.75 %) |

1. **Top products:** Chair and Printer are tied at **15.47 %** of revenue each (~195.6K); Phone is the weakest at 12.0 % (Q17, Q27).
2. **Best marketing channel:** **Instagram** drives the most revenue (275,285), but **Facebook** has the highest average order value (1,098) – and 1,241 on delivered orders (Q19, Q30).
3. **Biggest problem – order leakage:** ~4 in 10 orders end up Cancelled or Returned. Monitor (43.6 %) and Tablet (43.0 %) are worst (Q28).
4. **Gross vs net revenue differs by ~41 %** – reporting only gross revenue would badly overstate performance (Q17 vs Q23).
5. **Best month:** June 2024 with 68,068 revenue (Q29).
6. **Coupons:** average order value is nearly identical with or without a coupon (~1,043 – 1,070), so discounts don't appear to raise basket size (Q22).
7. **Repeat customers are rare:** only 11 customers ordered more than once (Q26).
8. **Note:** 2025 data ends in June, so the 2025 total is a half-year figure, not a decline (Q20).

## 🧠 Concepts Demonstrated
- SQL **logical execution order**: `FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`
- The **Alias Trap** (why `WHERE` can't use a `SELECT` alias) – Q12
- **NULL handling:** `COUNT(*)` vs `COUNT(column)`, `IS NULL`, `COALESCE` – Q10, Q21, Q22
- `WHERE` (row filter) vs `HAVING` (group filter) – Q25
- Conditional aggregation with `CASE WHEN` – Q28
- Percentage contribution with a scalar subquery – Q27

## 🛠️ Tech Stack
SQL (SQLite) · Python 3 · pandas

## 👤 Author
**Ayush** – Data Analytics Intern @ DecodeLabs (Batch 2026)

## 📄 License
MIT – see [LICENSE](LICENSE).
