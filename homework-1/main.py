"""Скрипт для заполнения данными таблиц в БД Postgres."""

import psycopg2
import csv

from config import PATH_CUSTOMERS, PATH_EMPLOYEES, PATH_ORDERS

conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password="****"
)

try:
    with conn:
        with conn.cursor() as cur:
            with open(PATH_EMPLOYEES, newline="") as file_employees:
                reader = csv.DictReader(file_employees)
                for current_dict in reader:
                    cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                                (int(current_dict["employee_id"]),
                                 current_dict["first_name"],
                                 current_dict["last_name"],
                                 current_dict["title"],
                                 current_dict["birth_date"],
                                 current_dict["notes"]))
            with open(PATH_CUSTOMERS, newline="") as file_customers:
                reader = csv.DictReader(file_customers)
                for current_dict in reader:
                    cur.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                                (current_dict["customer_id"],
                                 current_dict["company_name"],
                                 current_dict["contact_name"]))
            with open(PATH_ORDERS, newline="") as file_orders:
                reader = csv.DictReader(file_orders)
                for current_dict in reader:
                    cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                                (int(current_dict["order_id"]),
                                 current_dict["customer_id"],
                                 int(current_dict["employee_id"]),
                                 current_dict["order_date"],
                                 current_dict["ship_city"]))

finally:
    conn.close()
