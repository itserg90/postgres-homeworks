from pathlib import Path

ROOT_DIR = Path(__file__).parent
DIR_NORTH_DATA = Path(ROOT_DIR, "north_data")
PATH_CUSTOMERS = Path(DIR_NORTH_DATA, "customers_data.csv")
PATH_EMPLOYEES = Path(DIR_NORTH_DATA, "employees_data.csv")
PATH_ORDERS = Path(DIR_NORTH_DATA, "orders_data.csv")
