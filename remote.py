from dotenv import load_dotenv
import mysql.connector
import os
import logging
from mysql.connector import Error

# Load environment variables from .env file
load_dotenv()

# Configure logging to only show error messages
logging.basicConfig(level=logging.ERROR)

# Retrieve sensitive data from environment variables
try:
    db_host = os.getenv('DB_HOST')
    db_user = os.getenv('DB_USER')
    db_password = os.getenv('DB_PASSWORD')
    db_name = os.getenv('DB_NAME')

    if not all([db_host, db_user, db_password, db_name]):
        raise ValueError("One or more required environment variables are missing.")
except ValueError as e:
    logging.error(f"Environment variable error: {e}")
    print("Failed to load required environment variables. Please check your .env file.")
    exit(1)
conn=None
# Database connection and query execution
try:
    with mysql.connector.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        database=db_name
    ) as conn:
        if conn.is_connected():
            print("Connected to MySQL database.")
            query = "SELECT * FROM employees"
            with conn.cursor() as cursor:
                cursor.execute(query)
                rows = cursor.fetchall()
                for row in rows:
                    print(row)

except Error as err:
    logging.error(f"Database connection error: {err}")
    print("Failed to connect to the database. Please try again later.")
except Exception as e:
    logging.error(f"Unexpected error: {e}")
    print("An unexpected error occurred.")
finally:
    if conn and conn.is_connected():
        conn.close()
        print("MySQL connection is closed.")

import streamlit as st
import mysql.connector
from dotenv import load_dotenv
import os
import pandas as pd
import plotly.express as px
import simplejson as json  # Use simplejson for Decimal serialization
from datetime import date, datetime

# Load Environment Variables (.env file)
load_dotenv()

# Database Connection Function
def connect_to_db():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )

# Custom function to handle non-serializable objects
def custom_serializer(obj):
    if isinstance(obj, (date, datetime)):
        return obj.isoformat()  # Convert date/datetime to ISO 8601 string
    raise TypeError(f"Object of type {type(obj).__name__} is not JSON serializable")

# Fetch Data from MySQL
try:
    conn = connect_to_db()
    cursor = conn.cursor()

    # Fetch Employee Productivity View
    cursor.execute("""
        SELECT SQL_NO_CACHE full_name, total_hours, total_tasks, productivity_score, status
        FROM employee_productivity_summary
    """)
    emp_columns = [col[0] for col in cursor.description]
    emp_data = cursor.fetchall()
    emp_list = [dict(zip(emp_columns, row)) for row in emp_data]
    emp_df = pd.DataFrame(emp_list)

    # Fetch Department Productivity View
    cursor.execute("""
        SELECT SQL_NO_CACHE department_name, department_score
        FROM department_productivity
    """)
    dept_columns = [col[0] for col in cursor.description]
    dept_data = cursor.fetchall()
    dept_list = [dict(zip(dept_columns, row)) for row in dept_data]
    dept_df = pd.DataFrame(dept_list)

    # Fetch Project Overview View
    cursor.execute("""
        SELECT SQL_NO_CACHE project_name, deadline, created_by, team_members
        FROM project_overview
    """)
    proj_columns = [col[0] for col in cursor.description]
    proj_data = cursor.fetchall()
    proj_list = [dict(zip(proj_columns, row)) for row in proj_data]
    proj_df = pd.DataFrame(proj_list)

    # Fetch Recent Time Logs View
    cursor.execute("""
        SELECT SQL_NO_CACHE employee_name, project_id, date, hours_worked, tasks_completed
        FROM recent_time_logs
    """)
    logs_columns = [col[0] for col in cursor.description]
    logs_data = cursor.fetchall()
    logs_list = [dict(zip(logs_columns, row)) for row in logs_data]
    logs_df = pd.DataFrame(logs_list)

    # Fetch Recent Alerts Table
    cursor.execute("""
        SELECT SQL_NO_CACHE employee_id, alert_type, alert_time
        FROM alerts
        ORDER BY alert_time DESC
    """)
    alert_columns = [col[0] for col in cursor.description]
    alert_data = cursor.fetchall()
    alert_list = [dict(zip(alert_columns, row)) for row in alert_data]

    # Close the connection
    cursor.close()
    conn.close()
except Exception as e:
    st.error(f"Database connection error: {e}")
    st.stop()

# Dashboard Layout
st.title("Remote Work Productivity Dashboard")

# Employee Productivity Summary
st.subheader("Employee Productivity Summary")
if not emp_df.empty:
    st.dataframe(emp_df, use_container_width=True)
else:
    st.warning("No employee productivity data available.")

# Department Productivity Summary
st.subheader("Department Productivity Summary")
if not dept_df.empty:
    st.dataframe(dept_df, use_container_width=True)
else:
    st.warning("No department productivity data available.")

# Project Overview
st.subheader("Project Overview")
if not proj_df.empty:
    st.dataframe(proj_df, use_container_width=True)
else:
    st.warning("No project overview data available.")

# Recent Time Logs
st.subheader("Recent Time Logs")
if not logs_df.empty:
    st.dataframe(logs_df, use_container_width=True)
else:
    st.warning("No recent time logs available.")

# Recent Alerts
st.subheader("Recent Alerts")
if alert_list:
    st.table(pd.DataFrame(alert_list))
else:
    st.warning("No alerts found.")

# Charts and Visualizations
# Pie Chart - Productivity Status Breakdown
st.subheader("Productivity Status Breakdown")
if not emp_df.empty:
    status_counts = emp_df["status"].value_counts().reset_index()
    status_counts.columns = ["Status", "Count"]

    fig_pie = px.pie(
        status_counts,
        values="Count",
        names="Status",
        title="Employee Productivity Status Distribution"
    )
    st.plotly_chart(fig_pie, use_container_width=True)
else:
    st.warning("No data available for productivity status breakdown.")

# Bar Chart - Top 5 Productive Employees
st.subheader("Top 5 Most Productive Employees")
if not emp_df.empty:
    top5 = emp_df.sort_values(by="productivity_score", ascending=False).head(5)

    fig_bar = px.bar(
        top5,
        x="full_name",
        y="productivity_score",
        color="productivity_score",
        title="Top 5 Employee Productivity Scores"
    )
    st.plotly_chart(fig_bar, use_container_width=True)
else:
    st.warning("No data available for top productive employees.")

# Prepare Full JSON Report for Download
summary_report = {
    "Employee Productivity Summary": emp_list,
    "Department Productivity Summary": dept_list,
    "Project Overview": proj_list,
    "Recent Time Logs": logs_list,
    "Recent Alerts": alert_list
}

# Convert full report to JSON string using simplejson
json_data = json.dumps(summary_report, indent=4, default=custom_serializer)

# Download Button for JSON
st.subheader("Download Full Productivity Report")
st.download_button(
    label="Download JSON Report",
    data=json_data,
    file_name="remote_productivity_report.json",
    mime="application/json"
)