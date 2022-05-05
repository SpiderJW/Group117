-- HOG Clinical Trials Tracker
-- Project Step 3 Draft
-- Group 117
-- Team: Thomas Gathman, John Wong

-- Populate the clinical_trials table on the clinical_trials page
SELECT * FROM clinical_trials

-- Populate the hospitals table on the hospitals page
SELECT * FROM hospitals

-- Populate the hospitals_supporting_clinical_trials table on the hospital page
SELECT * FROM hospitals_supporting_clinical_trials

-- Populate the patients table on the patients page
SELECT * FROM patients

-- Populate the employees table on the employees page
SELECT * FROM employees

-- Populate the employees_supporting_clinical_trials table on the employees page
SELECT * FROM employees_supporting_clinical_trials


-- get all characters and their homeworld name for the List People page
SELECT bsg_people.character_id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.planet_id

-- get a single character's data for the Update People form
SELECT character_id, fname, lname, homeworld, age FROM bsg_people WHERE character_id = :character_ID_selected_from_browse_character_page

-- get all character's data to populate a dropdown for associating with a certificate  
SELECT character_id AS pid, fname, lname FROm bsg_people 
-- get all certificates to populate a dropdown for associating with people
SELECT certification_id AS cid, title FROM bsg_cert

-- get all peoople with their current associated certificates to list
SELECT pid, cid, CONCAT(fname,' ',lname) AS name, title AS certificate 
FROM bsg_people 
INNER JOIN bsg_cert_people ON bsg_people.character_id = bsg_cert_people.pid 
INNER JOIN bsg_cert on bsg_cert.certification_id = bsg_cert_people.cid 
ORDER BY name, certificate

-- add a new character
INSERT INTO bsg_people (fname, lname, homeworld, age) VALUES (:fnameInput, :lnameInput, :homeworld_id_from_dropdown_Input, :ageInput)

-- associate a character with a certificate (M-to-M relationship addition)
INSERT INTO bsg_cert_people (pid, cid) VALUES (:character_id_from_dropdown_Input, :certification_id_from_dropdown_Input)

-- update a clinical trial's data based on submission of the Update Clinical Trial form 
UPDATE clinical_trials 
SET cancer_type= :cancer_typeInput, 
trial_description = :trial_description_Input, 
maximum_patients = :maximum_patientsInput 
WHERE clinical_trial_id = :clinical_trial_idInput_from_update_form

-- update a hospital's data based on submission of the Update Hospital form 
UPDATE hospitals
SET hospital_name = :hospital_nameInput, 
hospital_street= :hospital_streetInput, 
hospital_city = :hospital_cityInput,
hospital_state= :hospital_state_from_dropdown_Input,
hospital_zip= :hospital_zipInput
WHERE hospital_id= :hospital_id_from_the_update_form

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
clinical_trial_id = :clinical_trial_idInput
WHERE patient_id= :patient_id_from_the_update_form

-- update an employee's trial role based on submission of the Update employee role form
UPDATE employees_supporting_clinical_trials
SET employee_trial_role= :employee_trial_roleInput
WHERE employees_employee_id= :employees_employee_idInput,
AND clinical_trial_id= :clinical_trial_idInput

-- update an employees's data based on submission of the Update employee form 
UPDATE employees
SET employee_first_name = :employee_first_nameInput, 
employee_last_name= :employee_last_nameInput, 
position = :positionInput, 
email= :emailInput,
desk_phone= :desk_phoneInput,
email= :emailInput,
employer= :employerInput
WHERE employee_id= :employee_id_from_the_update_form

-- delete a clinical trial
DELETE FROM clinical_trials WHERE clinical_trial_id = :clinical_trial_id_selected_from_browse_clinical_trials_page

-- delete a hospital
DELETE FROM hospitals WHERE hospital_id = :hospital_id_selected_from_browse_hospitals_page

-- delete a patient
DELETE FROM patients WHERE patient_id = :patient_id_selected_from_browse_patients_page

-- delete an employee
DELETE FROM employees WHERE employee_id = :employee_id_selected_from_browse_employees_page

-- dis-associate a certificate from a person (M-to-M relationship deletion)
DELETE FROM bsg_cert_people WHERE pid = :character_ID_selected_from_certificate_and_character_list AND cid = :certification_ID_selected_from-certificate_and_character_list
