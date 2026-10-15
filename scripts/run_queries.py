"""
run_queries.py
Builds a SQLite database from data/orders.csv, executes every query in /sql,
saves each result to /results/Qxx_*.csv and prints a summary.

Usage:  python scripts/run_queries.py
"""
import re
import sqlite3
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DB_PATH = ROOT / "orders.db"
SQL_DIR = ROOT / "sql"
RESULTS_DIR = ROOT / "results"
RESULTS_DIR.mkdir(exist_ok=True)


def build_database(conn: sqlite3.Connection) -> None:
    conn.executescript((SQL_DIR / "00_schema.sql").read_text(encoding="utf-8"))
    df = pd.read_csv(ROOT / "data" / "orders.csv")
    df.to_sql("orders", conn, if_exists="append", index=False)
    print(f"Loaded {len(df)} rows into table 'orders'")


def split_queries(sql_text: str):
    """Split a .sql file into (query_id, title, sql) using '-- Qxx: title' markers."""
    pattern = re.compile(r"^-- (Q\d+): (.+)$", re.M)
    marks = list(pattern.finditer(sql_text))
    for i, m in enumerate(marks):
        end = marks[i + 1].start() if i + 1 < len(marks) else len(sql_text)
        yield m.group(1), m.group(2).strip(), sql_text[m.end():end].strip()


def main() -> None:
    if DB_PATH.exists():
        DB_PATH.unlink()
    conn = sqlite3.connect(DB_PATH)
    build_database(conn)

    for sql_file in sorted(SQL_DIR.glob("0[1-9]_*.sql")):
        print(f"\n=== {sql_file.name} ===")
        for qid, title, sql in split_queries(sql_file.read_text(encoding="utf-8")):
            df = pd.read_sql_query(sql, conn)
            safe = re.sub(r"[^a-z0-9]+", "_", title.lower()).strip("_")[:40]
            df.to_csv(RESULTS_DIR / f"{qid}_{safe}.csv", index=False)
            print(f"{qid}: {title}  ->  {len(df)} rows")
    conn.close()
    print("\nDone. Results saved in /results")


if __name__ == "__main__":
    main()
