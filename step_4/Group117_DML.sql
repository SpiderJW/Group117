-- HOG Clinical Trials Tracker
-- Project Step 3 Draft
-- Group 117
-- Team: Thomas Gathman, John Wong

-- -----------------------------------------------------
-- Clinical Trials Tables
-- -----------------------------------------------------

-- Populate the clinical_trials table on the clinical_trials page
SELECT clinical_trial_id AS "Clinical Trial Id", 
cancer_type AS "Cancer Type", 
trial_description AS "Trial Description", 
maximum_patients AS "Maximum Patients" FROM clinical_trials

-- Insert into clinical_trials
INSERT INTO clinical_trials (clinical_trial_id, cancer_type, trial_description, maximum_patients) VALUES
(:clinical_trial_id, :cancer_type, :trial_description, :maximum_patients)

-- update a clinical trial's data based on submission of the Update Clinical Trial form 
UPDATE clinical_trials 
SET cancer_type= :cancer_typeInput, 
trial_description = :trial_description_Input, 
maximum_patients = :maximum_patientsInput 
WHERE clinical_trial_id = :clinical_trial_idInput_from_update_form

-- delete a clinical trial
DELETE FROM clinical_trials WHERE clinical_trial_id = :clinical_trial_id_selected_from_browse_clinical_trials_page

-- Select clinical trial by cancer type
SELECT clinical_trial_id AS "Clinical Trial Id", 
cancer_type AS "Cancer Type", 
trial_description AS "Trial Description", 
maximum_patients AS "Maximum Patients" FROM clinical_trials
WHERE cancer_type = :cancer_typeInput


-- -----------------------------------------------------
-- Hospital Table
-- -----------------------------------------------------

-- Populate the hospitals table on the hospitals page
SELECT hospital_id AS "Hospital Id", 
hospital_name AS "Hospital Name", 
hospital_street AS "Hospital Street", 
hospital_city AS "Hospital City", 
hospital_state AS "Hospital State", 
hospital_zip AS "Hospital Zip" FROM hospitals

-- Insert into hospitals
INSERT INTO hospitals (hospital_id, hospital_name, hospital_street, hospital_city, hospital_state, hospital_zip) VALUES
(:hospital_id, :hospital_name, :hospital_street, :hospital_city, :hospital_state, :hospital_zip)

-- update a hospital's data based on submission of the Update Hospital form 
UPDATE hospitals
SET hospital_name = :hospital_nameInput, 
hospital_street= :hospital_streetInput, 
hospital_city = :hospital_cityInput,
hospital_state= :hospital_state_from_dropdown_Input,
hospital_zip= :hospital_zipInput
WHERE hospital_id= :hospital_id_from_the_update_form

-- delete a hospital
DELETE FROM hospitals WHERE hospital_id = :hospital_id_selected_from_browse_hospitals_page

-- Select hospital by state 
SELECT hospital_id AS "Hospital Id", 
hospital_name AS "Hospital Name", 
hospital_street AS "Hospital Street", 
hospital_city AS "Hospital City", 
hospital_state AS "Hospital State", 
hospital_zip AS "Hospital Zip" FROM hospitals
WHERE hospital_state = :hospital_stateInput

-- -----------------------------------------------------
-- Hospital/Clinical Trials Intersection Table
-- -----------------------------------------------------

-- Populate the hospitals_supporting_clinical_trials table on the hospital page
SELECT hospitals_hospital_id AS "Hospital Id", 
clinical_trials_clinical_trial_id AS "Clinical Trial Id" FROM hospitals_supporting_clinical_trials

--Insert into hospitals_supporting_clinical_trials
INSERT INTO hospitals_supporting_clinical_trials (hospitals_hospital_id, clinical_trials_clinical_trial_id) VALUES
(:hospitals_hospital_id, :clinical_trials_clinical_trial_id)

-- Disassociate a hospital from a clinical trial
DELETE FROM hospitals_supporting_clinical_trials WHERE clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_id AND hospitals_hospital_id = :hospitals_hospital_id

-- Select available clinical trials by hospital id
SELECT hospitals_hospital_id AS "Hospital Id", 
clinical_trials_clinical_trial_id AS "Clinical Trial Id" FROM hospitals_supporting_clinical_trials
WHERE hospitals_hospital_id = :hospitals_hopsital_id

-- FK user friendly readable Hospitals Supporting Clinical Trials Intersection Table
SELECT hospitals_supporting_clinical_trials.hospitals_hospital_id AS "Hospital Id",
hospitals.hospital_name AS "Hospital Name",
hospitals_supporting_clinical_trials.clinical_trials_clinical_trial_id
FROM hospitals_supporting_clinical_trials
INNER JOIN hospitals ON hospitals_hospital_id = hospital_id;

-- -----------------------------------------------------
-- Patients Table
-- -----------------------------------------------------

-- Populate the patients table on the patients page
SELECT patient_id AS "Patient Id", 
patient_first_name AS "Patient First Name", 
patient_last_name AS "Patient Last Name", 
patient_street AS "Patient Street", 
patient_city AS "Patient City", 
patient_state AS "Patient State", 
patient_zip AS "Patient Zip", 
patient_sex AS "Patient Sex", 
dob AS "DOB", 
hospitals_hospital_id AS "Hospital Id",
clinical_trials_clinical_trial_id AS "Clinical Trials Id" FROM patients

-- Insert into patients table
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, patient_street, patient_city, patient_state, 
patient_zip, patient_sex, dob, hospitals_hospital_id, clinical_trials_clinical_trial_id) VALUES
(:patient_id, :patient_first_name, :patient_last_name, :patient_street, :patient_city, :patient_state, 
:patient_zip, :patient_sex, :dob, :hospitals_hospital_id, :clinical_trials_clinical_trial_id)

-- update a patient's data based on submission of the Update Patient form 
UPDATE patients
SET patient_first_name = :patient_first_nameInput, 
patient_last_name= :patient_last_nameInput, 
patient_street = :patient_streetInput,
patient_city= :patient_cityInput,
patient_state= :patient_state_from_dropdown_Input,
patient_zip= :patient_zipInput,
patient_sex= :patient_sex_from_dropdown_Input,
dob= :dobInput,
hospital_id= :hospital_idInput,
clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_idInput
WHERE patient_id= :patient_id_from_the_update_form

-- delete a patient
DELETE FROM patients WHERE patient_id = :patient_id_selected_from_browse_patients_page

-- Select the patients by clinical trial
SELECT patient_id AS "Patient Id", 
patient_first_name AS "Patient First Name", 
patient_last_name AS "Patient Last Name", 
patient_street AS "Patient Street", 
patient_city AS "Patient City", 
patient_state AS "Patient State", 
patient_zip AS "Patient Zip", 
patient_sex AS "Patient Sex", 
dob AS "DOB", 
hospitals_hospital_id AS "Hospital Id",
clinical_trials_clinical_trial_id AS "Clinical Trials Id" FROM patients
WHERE clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_idInput

-- -----------------------------------------------------
-- Employee Table
-- -----------------------------------------------------

-- Populate the employees table on the employees page
SELECT employee_id AS "Employee Id",
employee_first_name AS "Employee First Name",
employee_last_name AS "Employee Last Name",
position AS "Position", 
email AS "Email", 
desk_phone AS "Desk Phone",
NULLIF(employers_employer_id, 0) AS "Employer Id" FROM employees

-- Insert into employees
INSERT INTO employees (employee_id, employee_first_name, employee_last_name, position, email, desk_phone, employers_employer_id) VALUES
(:employee_id, :employee_first_name, :employee_last_name, :position, :email, :desk_phone, :employers_employer_id)

-- update an employees's data based on submission of the Update employee form 
UPDATE employees
SET employee_first_name = :employee_first_nameInput, 
employee_last_name= :employee_last_nameInput, 
position = :positionInput, 
email= :emailInput,
desk_phone= :desk_phoneInput,
employers_employer_id= :employers_employerInput
WHERE employee_id= :employee_id_from_the_update_form
-- delete an employee
DELETE FROM employees WHERE employee_id = :employee_id_selected_from_browse_employees_page

-- Select employee by employer id
SELECT employee_id AS "Employee Id",
employee_first_name AS "Employee First Name",
employee_last_name AS "Employee Last Name",
position AS "Position", 
email AS "Email", 
desk_phone AS "Desk Phone",
NULLIF(employers_employer_id, 0) AS "Employer Id" FROM employees
WHERE employers_employer_id= :employers_employer_idInput

-- -----------------------------------------------------
-- Employee/Clinical Trials Intersection Table
-- -----------------------------------------------------

-- Populate the employees_supporting_clinical_trials table on the employees page
SELECT employees_employee_id AS "Employee Id", 
clinical_trials_clinical_trial_id AS "Clinical Trial Id", 
employee_trial_role AS "Employee Trial Role" FROM employees_supporting_clinical_trials

-- Insert into employees_supporting_clinical_trials and associate employee with clinical trial (M:M)
INSERT INTO employees_supporting_clinical_trials (employees_employee_id, clinical_trials_clinical_trial_id, employee_trial_role) VALUES
(:employees_employee_id, :clinical_trials_clinical_trial_id, :employee_trial_role)

-- update an employee's trial role based on submission of the Update employee role form
UPDATE employees_supporting_clinical_trials
SET employee_trial_role= :employee_trial_roleInput
WHERE employees_employee_id= :employees_employee_idInput,
AND clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_idInput

-- Disassociate an employee from a clinical trial
DELETE FROM employees_supporting_clinical_trials WHERE employees_employee_id = :employees_employee_id AND clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_id

-- Select employees id by clinical trial
SELECT employees_employee_id AS "Employee Id", 
clinical_trials_clinical_trial_id AS "Clinical Trial Id", 
employee_trial_role AS "Employee Trial Role" FROM employees_supporting_clinical_trials
WHERE clinical_trials_clinical_trial_id = :clinical_trials_clinical_trial_idInput

-- FK user friendly readable Employees Supporting Clinical Trials Intersection Table
SELECT employees_supporting_clinical_trials.employees_employee_id AS "Employee Id",
CONCAT(employees.employee_first_name, ' ', employees.employee_last_name) AS "Employee Full Name",
employees_supporting_clinical_trials.clinical_trials_clinical_trial_id AS "Clinical Trial Id",
employees_supporting_clinical_trials.employee_trial_role AS "Employee Trial Role"
FROM employees_supporting_clinical_trials
INNER JOIN employees ON employees_employee_id = employee_id;

-- -----------------------------------------------------
-- Employer Table
-- -----------------------------------------------------

-- Populate the employers table on the employees page
SELECT employer_id AS "Employer Id", 
employer_name AS "Employer Name" FROM employers

-- Insert into employees
INSERT INTO employers (employer_id, employer_name) VALUES
(:employer_id, :employer_name)

-- update an employers's data based on submission of the Update employer form 
UPDATE employees
SET employer_name = :employer_name, 
WHERE employer_id= :employer_id_from_the_update_form

-- delete an employee
DELETE FROM employers WHERE employer_id = :employer_id_selected_from_browse_employees_page
