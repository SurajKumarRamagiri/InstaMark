import json
import csv
import MySQLdb as mysql

# Database connection
conn = mysql.connect(
    host="localhost",
    user="root",
    password="password",
    database="instamark"
)
cursor = conn.cursor()

# Query to fetch schema details
query = """
SELECT 
    TABLE_SCHEMA AS database_name,
    TABLE_NAME AS table_name,
    COLUMN_NAME AS column_name,
    DATA_TYPE AS data_type,
    CHARACTER_MAXIMUM_LENGTH AS max_length,
    IS_NULLABLE AS is_nullable,
    COLUMN_KEY AS column_key,
    EXTRA AS extra
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = %s
"""

# Execute query
cursor.execute(query, ("instamark",))
rows = cursor.fetchall()

# Columns
columns = [desc[0] for desc in cursor.description]

# Export to CSV
with open("schema.csv", "w", newline="") as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow(columns)
    csv_writer.writerows(rows)

#  Export to JSON
# with open("schema.json", "w") as json_file:
#     json_data = [dict(zip(columns, row)) for row in rows]
#     json.dump(json_data, json_file, indent=4)

# Close connection
cursor.close()
conn.close()
