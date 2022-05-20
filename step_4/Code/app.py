import re
from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
import os
from dotenv import load_dotenv, find_dotenv

# Much of the code below was modified from https://github.com/osu-cs340-ecampus/flask-starter-app, especially
# https://github.com/osu-cs340-ecampus/flask-starter-app/tree/master/bsg_people_app

# Configuration
load_dotenv(find_dotenv())

app = Flask(__name__)
app.config['MYSQL_HOST'] = os.environ.get("340DBHOST")
app.config['MYSQL_USER'] = os.environ.get("340DBUSER")
app.config['MYSQL_PASSWORD'] = os.environ.get("340DBPW")
app.config['MYSQL_DB'] = database = os.environ.get("340DB")
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

mysql = MySQL(app)

def query_db(query):
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    return cursor.fetchall()

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")

@app.route('/employees', methods=["POST", "GET"])
def employees():
    
    if request.method == "GET":

        employees_query =   """
                            SELECT employee_id AS "Employee Id",
                            employee_first_name AS "Employee First Name",
                            employee_last_name AS "Employee Last Name",
                            position AS "Position", 
                            email AS "Email", 
                            desk_phone AS "Desk Phone",
                            NULLIF(employers_employer_id, 0) AS "Employer Id" FROM employees
                            """
        employees = query_db(employees_query)

        employees_int_query =   """
                                SELECT employees_employee_id AS "Employee Id", 
                                clinical_trials_clinical_trial_id AS "Clinical Trial Id", 
                                employee_trial_role AS "Employee Trial Role" FROM employees_supporting_clinical_trials
                                """
        employees_int = query_db(employees_int_query)

        return render_template("employees.j2", employees=employees, employees_int=employees_int)

    # Separate out the request methods, in this case this is for a POST
    # insert an employee into the employees entity
    if request.method == "POST":
        # fire off if user presses the Add Employee button
        if request.form.get("addEmployee"):
            # grab user form inputs
            employee_id = request.form["employee_id"]
            employee_first_name = request.form["employee_first_name"]
            employee_last_name = request.form["employee_last_name"]
            position = request.form["position"]
            email = request.form["email"]
            desk_phone = request.form["desk_phone"]
            employers_employer_id = request.form["employers_employer_id"]

            # account for null email and null desk_phone and null employers_employer_id
            if email == "" and desk_phone == "" and employers_employer_id == "":
                # mySQL query to insert a new employee into employees with our form inputs
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position) VALUES \
                    (%s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position))
                mysql.connection.commit()
            
            # account for null email and null desk_phone
            elif email == "" and desk_phone == "":
                # mySQL query to insert a new employee into employees with our form inputs
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, employers_employer_id) VALUES \
                    (%s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, employers_employer_id))
                mysql.connection.commit()

            # account for null email and null employers_employer_id
            elif email == "" and employers_employer_id == "":
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, desk_phone) VALUES \
                    (%s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, desk_phone))
                mysql.connection.commit()

            # account for null desk_phone and null employers_employer_id
            elif desk_phone == "" and employers_employer_id == "":
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, email) VALUES \
                    (%s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, email))
                mysql.connection.commit()

            # account for null email
            elif email == "":
                # mySQL query to insert a new person into employees with our form inputs
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, desk_phone, employers_employer_id) VALUES \
                    (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, desk_phone, employers_employer_id))
                mysql.connection.commit()

            # account for null desk_phone
            elif desk_phone == "":
                # mySQL query to insert a new person into employees with our form inputs
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, email, employers_employer_id) VALUES \
                    (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, email, employers_employer_id))
                mysql.connection.commit()

            # account for null employers_employer_id
            elif employers_employer_id == "":
                # mySQL query to insert a new person into employees with our form inputs
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, email, desk_phone) VALUES \
                    (%s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, email, desk_phone, employers_employer_id))
                mysql.connection.commit()

            # no null inputs
            else:
                query = "INSERT INTO employees (employee_id, employee_first_name, employee_last_name, \
                    position, email, desk_phone, employers_employer_id) VALUES \
                    (%s, %s, %s, %s, %s, %s, %s)"
                cur = mysql.connection.cursor()
                cur.execute(query, (employee_id, employee_first_name, employee_last_name,
                    position, email, desk_phone, employers_employer_id))
                mysql.connection.commit()

            # redirect back to people page
            return redirect("/employees")

        # fire off if user presses the Add Supporting button
        if request.form.get("addSupporting"):
            # grab user form inputs
            employees_employee_id = request.form["employee_id"]
            clinical_trials_clinical_trial_id = request.form["clinical_trial_id"]
            employee_trial_role = request.form["employee_trial_role"]

            # no null inputs
            query = "INSERT INTO employees_supporting_clinical_trials \
                (employees_employee_id, clinical_trials_clinical_trial_id, employee_trial_role) VALUES \
                (%s, %s, %s)"
            cur = mysql.connection.cursor()
            cur.execute(query, (employees_employee_id, clinical_trials_clinical_trial_id, employee_trial_role))
            mysql.connection.commit()

            # redirect back to people page
            return redirect("/employees")

@app.route('/edit-employee/<int:id>', methods=["POST", "GET"])
def edit_employee(id):
    
    if request.method == "GET":

        employee_query =    f"""
                            SELECT employee_id AS "Employee Id",
                            employee_first_name AS "Employee First Name",
                            employee_last_name AS "Employee Last Name",
                            position AS "Position", 
                            email AS "Email", 
                            desk_phone AS "Desk Phone",
                            NULLIF(employers_employer_id, 0) AS "Employer Id" 
                            FROM employees 
                            WHERE employee_id = {id}
                            """
        employee = query_db(employee_query)

        return render_template("edit_employee.j2", employee=employee)

    if request.method == "POST":

        if request.form.get("Edit_Employee"):

            query = f"""UPDATE employees
                    SET employee_first_name = '{request.form['employee_first_name']}', 
                    employee_last_name = '{request.form['employee_last_name']}',
                    position = '{request.form['position']}',
                    email = '{request.form['email']}',
                    desk_phone = '{request.form['desk_phone']}',
                    employers_employer_id = {request.form['employers_employer_id']}
                    WHERE employee_id = {request.form['employee_id']}"""
            cur = mysql.connection.cursor()
            cur.execute(query)
            mysql.connection.commit()
        
        return redirect("/employees")

@app.route('/delete-employee/<int:id>')
def delete_employee(id):
    delete_query = f"DELETE FROM employees WHERE employee_id = {id};"
    cur = mysql.connection.cursor()
    cur.execute(delete_query)
    mysql.connection.commit()

    return redirect("/employees")

@app.route('/edit-supporting-employee/<int:id>', methods=["POST", "GET"])
def edit_supporting_employee(id):
    
    if request.method == "GET":

        supporting_employee_query =    f"""
                            SELECT employees_employee_id AS "Employee Id",
                            clinical_trials_clinical_trial_id AS "Clinical Trial Id",
                            employee_trial_role AS "employee_trial_role"
                            FROM employees_supporting_clinical_trials 
                            WHERE employees_employee_id = {id}
                            """
        supporting_employee = query_db(supporting_employee_query)

        return render_template("edit_supporting_employee.j2", supporting_employee=supporting_employee)

    if request.method == "POST":

        if request.form.get("Edit_Supporting_Employee"):#

            query = f"""UPDATE employees_supporting_clinical_trials
                    SET clinical_trials_clinical_trial_id = '{request.form['clinical_trial_id']}', 
                    employee_trial_role = '{request.form['employee_trial_role']}'
                    WHERE employees_employee_id = {request.form['employee_id']}"""
            cur = mysql.connection.cursor()
            cur.execute(query)
            mysql.connection.commit()
        return redirect("/employees")

@app.route('/delete-supporting-employee/<int:id>')
def delete_supporting_employee(id):
    delete_query = f"DELETE FROM employees_supporting_clinical_trials WHERE employees_employee_id = {id};"
    cur = mysql.connection.cursor()
    cur.execute(delete_query)
    mysql.connection.commit()

    return redirect("/employees")

# @app.route('/clinical_trials', methods=["POST", "GET"])
# def clinical_trials():
    
#     if request.method == "GET":
#         clinical_trials_query = """
#                                 SELECT clinical_trial_id AS "Clinical Trial Id", 
#                                 cancer_type AS "Cancer Type", 
#                                 trial_description AS "Trial Description", 
#                                 maximum_patients AS "Maximum Patients" FROM clinical_trials
#                                 """
#         clinical_trials = query_db(clinical_trials_query)
        
#         return render_template("clinical_trials.j2", clinical_trials = clinical_trials)


# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 52415))   
    app.run(port=port, debug=True) 