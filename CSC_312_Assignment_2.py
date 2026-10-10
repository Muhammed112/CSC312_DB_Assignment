#Team Name: Mo & co.
#Student Numbers:

import getpass
import mysql.connector
from mysql.connector import Error

#Database Connection
def create_connection():
    host_input = input("Enter MySQL host (default: localhost): ") or "localhost"
    user_input = input("Enter MySQL username (default: root): ") or "root"
    port_input = input("Enter MySQL port (default: 3306): ") or "port"
    password_input = getpass.getpass("Enter MySQL password: ")
    database_input = input("Enter MySQL database name (default: mydatabase): ") or "mydatabase"
    
    try:
        connection = mysql.connector.connect(
            host=host_input,
            user=user_input,
            port=port_input,
            password=password_input,
            database=database_input
        )
        if connection.is_connected():
            print("Connection to the database was successful.")
            return connection
    except Error as e:
        print(f"Error while connecting to the database: {e}")
        return None

def tabulate(columns, results):
    if not results:
        print("No results found.")
        return

    str_results = [[str(val) if val is not None else "NULL" for val in row] for row in results]

    col_widths =[]
    for i in range(len(columns)):
        max_width = max(len(columns[i]), max(len(row[i]) for row in str_results))
        col_widths.append(max_width)

    border = "+" + "+".join("-" * col_widths[i] for i in range(len(columns))) + "+"

    header = " | " + " | ".join(f"{columns[i].ljust(col_widths[i])}" for i in range(len(columns))) + " |"
    print(border)
    print(header)
    print(border)

    for row in str_results:
        row_str = " | " + " | ".join(f"{row[i].ljust(col_widths[i])}" for i in range(len(row))) + " |"
        print(row_str)

    print(border + "\n")

def run_query(cursor, query_num, title, sql):
    print("=" * 80)
    print(f"Query {query_num} : {title}")
    print("-" * 80)

    cursor.execute(sql)
    results = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    tabulate(columns, results)

#Query 1: Find Active Employees
def query_1(cursor):
    sql= """
    SELECT employee_id, first_name, last_name, job_role, phone
    FROM employees
    WHERE is_active = TRUE;
    """
    run_query(cursor, 1, "Find Active Employees", sql)

#Query 2: Products Above R150
def query_2(cursor):
    sql= """
    SELECT product_id, product_name, category, price
    FROM products
    WHERE price > 150;
    """
    run_query(cursor, 2, "Products Above R150", sql)

#Query 3: Active Products Count & Price per Category
def query_3(cursor):
    sql= """
    SELECT category, COUNT(*) as product_count, ROUND(AVG(price),2) as average_price
    FROM products
    WHERE is_active = TRUE
    GROUP BY category;
    """
    run_query(cursor, 3, "Active Products Count & Price per Category", sql)

#Query 4: Customer Sales Summary With Loyalty Points
def query_4(cursor):
    sql= """
    SELECT CONCAT (c.first_name, ' ', c.last_name) AS customer_name,
        c.loyalty_points,
        COUNT(s.sale_id) AS total_sales,
        s.payment_method
    FROM sales s
    INNER JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.customer_id, s.payment_method;
    """
    run_query(cursor, 4, "Customer Sales Summary With Loyalty Points", sql)

#Query 5: Equipment Assigned to Active Employees
def query_5(cursor):
    sql= """
    SELECT e.equipment_id, e.equipment_name, e.employee_id, emp.first_name, emp.last_name
    FROM equipment e
    INNER JOIN employees emp ON e.employee_id = emp.employee_id
    WHERE emp.is_active = TRUE;
    """
    run_query(cursor, 5, "Equipment Assigned to Active Employees", sql)

#Query 6: Inventory Batches Expiring Within 30 Days
def query_6(cursor):
    sql= """
    SELECT batch_id, product_id, manufacture_date, expiry_date
    FROM inventory_batches
    WHERE DATEDIFF(expiry_date, manufacture_date) <= 30;
    """
    run_query(cursor, 6, "Inventory Batches Expiring Within 30 Days", sql)


#Query 7: Supplier Lead Time and Order Fulfillment Summary
def query_7(cursor):
    sql= """
    SELECT s.supplier_id, s.supplier_name, s.contact_person, s.lead_days, COUNT(o.order_id) AS total_orders,
        COUNT(CASE WHEN o.order_status = 'Received' THEN 1 END) AS orders_received,
        COUNT(CASE WHEN o.order_status = 'Pending' THEN 1 END) AS orders_pending
    FROM suppliers s
    LEFT JOIN orders o ON s.supplier_id = o.supplier_id
    GROUP BY s.supplier_id, s.supplier_name, s.contact_person, s.lead_days;
    """
    run_query(cursor, 7, "Supplier Lead Time and Order Fulfillment Summary", sql)


#Query 8: Tracking Employee Activity On Audit Logs
def query_8(cursor):
    sql= """
    SELECT al.log_id, al.employee_id, emp.first_name, emp.last_name, al.action_type, al.changed_at
    FROM audit_logs al
    INNER JOIN employees emp ON al.employee_id = emp.employee_id
    ORDER BY al.changed_at DESC;
    """
    run_query(cursor, 8, "Tracking Employee Activity On Audit Logs", sql)

#Query 9: Cold Storage & Inventory Distribution
def query_9(cursor):
    sql= """
    SELECT eq.equipment_id, eq.equipment_name, eq.location, CONCAT(emp.first_name, ' ', emp.last_name) AS assigned_employee,
        COUNT(DISTINCT ib.batch_id) AS total_batches,
        COUNT(DISTINCT p.product_id) AS total_products,
        SUM(ib.quantity_on_hand) AS total_kg_in_storage
    FROM equipment eq
    LEFT JOIN employees emp ON eq.employee_id = emp.employee_id
    LEFT JOIN inventory_batches ib ON eq.equipment_id = ib.equipment_id
    LEFT JOIN products p ON ib.product_id = p.product_id
    WHERE ib.batch_status = 'Available'
    GROUP BY eq.equipment_id, eq.equipment_name, eq.location, emp.first_name, emp.last_name;
    ORDER BY total_kg_in_storage DESC;
    """    
    run_query(cursor, 9, "Cold Storage & Inventory Distribution", sql)

#Query 10: Stock Selling Below Target
def query_10(cursor):
    sql= """
    SELECT p.product_id, p.product_name, p.category, p.minimum_stock_level, p.target_stock_level,
        COALESCE(SUM(ib.quantity_on_hand), 0) AS current_stock_level,
        (p.target_stock_level - COALESCE(SUM(ib.quantity_on_hand), 0)) AS stock_shortfall,
        s.supplier_name
    FROM products p
    LEFT JOIN inventory_batches ib ON p.product_id = ib.product_id AND ib.batch_status = 'Available'
    LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
    WHERE p.is_active = TRUE
    GROUP BY p.product_id, p.product_name, p.category, p.minimum_stock_level, p.target_stock_level, s.supplier_name
    HAVING stock_shortfall <= p.target_stock_level
    ORDER BY stock_shortfall DESC;
    """
    run_query(cursor, 10, "Stock Selling Below Target", sql)

def main():
    connection = create_connection()
  
    if connection:
        query_1(connection.cursor()); 
        query_2(connection.cursor());  
        query_3(connection.cursor());  
        query_4(connection.cursor());  
        query_5(connection.cursor());  
        query_6(connection.cursor());  
        query_7(connection.cursor());  
        query_8(connection.cursor());  
        query_9(connection.cursor());
        connection.ping(reconnect= True, attempts= 3, delay= 2)  
        query_10(connection.cursor());  
        # Perform database operations here
        # For example, you can execute queries, fetch data, etc.
        # Remember to close the connection when done
        connection.close()
        print("Database connection closed.")

if __name__ == "__main__":
    main()