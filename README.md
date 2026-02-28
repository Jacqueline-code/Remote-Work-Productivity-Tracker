# Remote-Work-Productivity-Tracker
A python based system to track the productivity of remote workers
# Remote Work Productivity Dashboard

A Streamlit-based dashboard that monitors and visualizes remote work productivity metrics for remote teams.

## Overview

This application connects to a MySQL database to fetch and display real-time productivity metrics across employees, departments, and projects. It provides comprehensive analytics and reporting for remote work environments.

### Data Displayed

- **Employee Productivity** - Individual performance scores, hours worked, tasks completed, and status
- **Department Metrics** - Department-wide productivity summaries and department scores
- **Project Management** - Active projects, deadlines, project creators, and team member assignments
- **Time Logs** - Recent employee work hours, project assignments, and task completions
- **Alerts** - Real-time alerts for productivity issues organized by employee and alert type

## Features

- **Interactive Dashboard** - Multiple data views with sortable tables
- **Visualizations** - Pie charts for status breakdown, bar charts for top performers
- **Top Performers Ranking** - Displays top 5 most productive employees
- **JSON Report Export** - Download complete productivity report as JSON
- **Database Error Handling** - Robust connection management with error logging
- **Non-Serializable Data Handling** - Custom serialization for dates and datetime objects

## Technical Stack

- **Frontend**: Streamlit
- **Database**: MySQL
- **Data Processing**: Pandas
- **Visualizations**: Plotly Express
- **Configuration**: python-dotenv for environment variables

## Requirements

- Python 3.7+
- MySQL Server 5.7+
- Dependencies:
  - `streamlit` - Web app framework
  - `mysql-connector-python` - MySQL database connector
  - `pandas` - Data manipulation
  - `plotly` - Interactive visualizations
  - `simplejson` - JSON serialization with custom type handling
  - `python-dotenv` - Environment variable management

## Installation

1. Clone or download the project
2. Install Python dependencies:
   ```bash
   pip install streamlit mysql-connector-python pandas plotly simplejson python-dotenv
   ```

## Configuration

Create a `.env` file in the project directory with your MySQL credentials:

```
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=your_database_name
```

## Usage

Run the Streamlit application:

```bash
streamlit run remote.py
```

The dashboard will open in your default browser at `http://localhost:8501`

## Database Schema

The application queries data from the following MySQL views:

| View | Description | Key Columns |
|------|-------------|------------|
| `employee_productivity_summary` | Individual employee performance | full_name, total_hours, total_tasks, productivity_score, status |
| `department_productivity` | Department-level metrics | department_name, department_score |
| `project_overview` | Project information | project_name, deadline, created_by, team_members |
| `recent_time_logs` | Time tracking data | employee_name, project_id, date, hours_worked, tasks_completed |
| `alerts` | Productivity alerts | employee_id, alert_type, alert_time |

## Dashboard Sections

1. **Employee Productivity Summary** - Table view of all employee metrics
2. **Department Productivity Summary** - Department-level performance data
3. **Project Overview** - Current projects and team assignments
4. **Recent Time Logs** - Latest time tracking entries
5. **Recent Alerts** - Latest system alerts (newest first)
6. **Productivity Status Breakdown** - Pie chart showing employee status distribution
7. **Top 5 Most Productive Employees** - Bar chart highlighting top performers
8. **Download Report** - Button to export all data as JSON

## Error Handling

- Missing environment variables trigger an error message and exit
- Database connection failures display user-friendly error messages
- Non-serializable objects are handled gracefully for JSON export

## Notes

- The application uses `SQL_NO_CACHE` hint to ensure fresh data on each query
- Logging is configured to ERROR level to suppress debug messages
- All database connections are properly closed after data retrieval

## Author

AKOTH JACQUELINE OCHIENG

