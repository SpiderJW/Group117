-- HOG Clinical Trials Tracker
-- Project Step 3 Draft
-- Group 117
-- Team: Thomas Gathman, John Wong

-- phpMyAdmin SQL Dump
-- version 5.1.3-2.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 06, 2022 at 02:35 AM
-- Server version: 10.6.7-MariaDB-log
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------
DROP TABLE IF EXISTS employees_supporting_clinical_trials;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS hospitals_supporting_clinical_trials;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS hospitals;
DROP TABLE IF EXISTS employers;
DROP TABLE IF EXISTS clinical_trials;

--
-- Table structure for table `clinical_trials`
--

CREATE TABLE `clinical_trials` (
  `clinical_trial_id` varchar(10) NOT NULL,
  `cancer_type` varchar(180) NOT NULL,
  `trial_description` varchar(256) NOT NULL,
  `maximum_patients` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `clinical_trials`
--

INSERT INTO `clinical_trials` (`clinical_trial_id`, `cancer_type`, `trial_description`, `maximum_patients`) VALUES
('HG1141', 'Breast', 'This randomized phase II trial studies how well abbreviated breast magnetic resonance imaging (MRI) and digital tomosynthesis mammography work in detecting cancer in women with dense breasts.', 1500),
('HG8143', 'Kidney', 'This phase III trial compares nephrectomy (surgery to remove a kidney or part of a kidney) with nivolumab to the usual approach of nephrectomy followed by standard post-operative follow-up and monitoring.', 750),
('HGG173', 'Myeloma', 'This phase III trial studies how well lenalidomide and dexamethasone works with or without daratumumab in treating patients with high-risk smoldering myeloma. ', 300);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `employee_first_name` varchar(45) NOT NULL,
  `employee_last_name` varchar(45) NOT NULL,
  `position` varchar(45) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `desk_phone` varchar(18) DEFAULT NULL,
  `employers_employer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `employee_first_name`, `employee_last_name`, `position`, `email`, `desk_phone`, `employers_employer_id`) VALUES
(1, 'Regina', 'Dutch', 'Recruiter', 'dregina@hog.com', '402-250-8329', 117),
(2, 'Calvin', 'Jonas', 'Project Coordinator', 'cjonas@hog.com', '714-338-2340', 117),
(3, 'Haylie', 'Sandra', 'Data Manager', 'hsandra@hog.com', '832-209-6628', 117),
(4, 'Steve', 'Glenna', 'M.D.', 'sglenna@case.edu', '775-981-5220', 1),
(5, 'Deitra', 'Gracie', 'M.D.', 'dgracie@baylor.edu', '561-552-5564', 2),
(6, 'Alex', 'King', 'M.D.', 'aking@geisinger.edu', '914-774-0513', 3),
(7, 'Alexander', 'Fleming', 'PharmD.', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees_supporting_clinical_trials`
--

CREATE TABLE `employees_supporting_clinical_trials` (
  `employees_employee_id` int(11) NOT NULL,
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL,
  `employee_trial_role` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `employees_supporting_clinical_trials`
--

INSERT INTO `employees_supporting_clinical_trials` (`employees_employee_id`, `clinical_trials_clinical_trial_id`, `employee_trial_role`) VALUES
(1, 'HG1141', 'Recruiter'),
(2, 'HG8143', 'Project Coordinator'),
(3, 'HGG173', 'Data Manager'),
(4, 'HG1141', 'Study Chair'),
(5, 'HG8143', 'Committee Chair'),
(6, 'HGG173', 'Study Co-Chair'),
(7, 'HGG173', 'Pharmacist');

-- --------------------------------------------------------

--
-- Table structure for table `employers`
--

CREATE TABLE `employers` (
  `employer_id` int(11) NOT NULL,
  `employer_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `employers`
--

INSERT INTO `employers` (`employer_id`, `employer_name`) VALUES
(0, 'Health Oncology Group'),
(1, 'Baylor University Medical Center'),
(2, 'Case Western Reserve University'),
(3, 'Geisinger Medical Center');

-- --------------------------------------------------------

--
-- Table structure for table `hospitals`
--

CREATE TABLE `hospitals` (
  `hospital_id` int(11) NOT NULL,
  `hospital_name` varchar(100) NOT NULL,
  `hospital_street` varchar(180) NOT NULL,
  `hospital_city` varchar(64) NOT NULL,
  `hospital_state` varchar(45) NOT NULL,
  `hospital_zip` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `hospitals`
--

INSERT INTO `hospitals` (`hospital_id`, `hospital_name`, `hospital_street`, `hospital_city`, `hospital_state`, `hospital_zip`) VALUES
(1, 'Baylor University Medical Center', '3500 Gaston Ave', 'Dallas', 'TX', '75246'),
(2, 'Case Western Reserve University', '9501 Euclid Ave', 'Cleveland', 'OH', '44106'),
(3, 'Geisinger Medical Center', '100 N Academy Ave', 'Danville', 'PA', '17821');

-- --------------------------------------------------------

--
-- Table structure for table `hospitals_supporting_clinical_trials`
--

CREATE TABLE `hospitals_supporting_clinical_trials` (
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL,
  `hospitals_hospital_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `hospitals_supporting_clinical_trials`
--

INSERT INTO `hospitals_supporting_clinical_trials` (`clinical_trials_clinical_trial_id`, `hospitals_hospital_id`) VALUES
('HG1141', 1),
('HG1141', 3),
('HG8143', 2),
('HGG173', 3);

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `patient_first_name` varchar(45) NOT NULL,
  `patient_last_name` varchar(45) NOT NULL,
  `patient_street` varchar(180) NOT NULL,
  `patient_city` varchar(64) NOT NULL,
  `patient_state` varchar(45) NOT NULL,
  `patient_zip` varchar(5) NOT NULL,
  `patient_sex` char(1) NOT NULL,
  `dob` date NOT NULL,
  `hospitals_hospital_id` int(11) NOT NULL,
  `clinical_trials_clinical_trial_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `patient_first_name`, `patient_last_name`, `patient_street`, `patient_city`, `patient_state`, `patient_zip`, `patient_sex`, `dob`, `hospitals_hospital_id`, `clinical_trials_clinical_trial_id`) VALUES
(10001, 'Gaviin', 'Jep', ' 9020 Garland Rd', 'Dallas', 'TX', '75218', 'M', '2000-11-01', 1, 'HG1141'),
(13001, 'Herbie', 'Williams', '2136 Murray Hill Rd', 'Cleveland', 'OH', '44106', 'M', '1995-09-21', 2, 'HG8143'),
(38001, 'Terry', 'Noel', '502 Church St', 'Danville', 'PA', '17821', 'F', '2000-02-28', 3, 'HGG173'),
(38002, 'Paden', 'Heidi', '331 W Mahoning St', 'Danville', 'PA', '17821', 'F', '1984-08-27', 3, 'HG1141');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clinical_trials`
--
ALTER TABLE `clinical_trials`
  ADD PRIMARY KEY (`clinical_trial_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`,`employers_employer_id`),
  ADD KEY `fk_employees_employers1_idx` (`employers_employer_id`);

--
-- Indexes for table `employees_supporting_clinical_trials`
--
ALTER TABLE `employees_supporting_clinical_trials`
  ADD PRIMARY KEY (`employees_employee_id`,`clinical_trials_clinical_trial_id`),
  ADD KEY `fk_employees_has_clinical_trials_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`),
  ADD KEY `fk_employees_has_clinical_trials_employees1_idx` (`employees_employee_id`);

--
-- Indexes for table `employers`
--
ALTER TABLE `employers`
  ADD PRIMARY KEY (`employer_id`);

--
-- Indexes for table `hospitals`
--
ALTER TABLE `hospitals`
  ADD PRIMARY KEY (`hospital_id`);

--
-- Indexes for table `hospitals_supporting_clinical_trials`
--
ALTER TABLE `hospitals_supporting_clinical_trials`
  ADD PRIMARY KEY (`clinical_trials_clinical_trial_id`,`hospitals_hospital_id`),
  ADD KEY `fk_clinical_trials_has_hospitals_hospitals1_idx` (`hospitals_hospital_id`),
  ADD KEY `fk_clinical_trials_has_hospitals_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`,`hospitals_hospital_id`,`clinical_trials_clinical_trial_id`),
  ADD KEY `fk_patients_hospitals_idx` (`hospitals_hospital_id`),
  ADD KEY `fk_patients_clinical_trials1_idx` (`clinical_trials_clinical_trial_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hospitals`
--
ALTER TABLE `hospitals`
  MODIFY `hospital_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_employees_employers1` FOREIGN KEY (`employers_employer_id`) REFERENCES `employers` (`employer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employees_supporting_clinical_trials`
--
ALTER TABLE `employees_supporting_clinical_trials`
  ADD CONSTRAINT `fk_employees_has_clinical_trials_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_employees_has_clinical_trials_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `hospitals_supporting_clinical_trials`
--
ALTER TABLE `hospitals_supporting_clinical_trials`
  ADD CONSTRAINT `fk_clinical_trials_has_hospitals_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clinical_trials_has_hospitals_hospitals1` FOREIGN KEY (`hospitals_hospital_id`) REFERENCES `hospitals` (`hospital_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `fk_patients_clinical_trials1` FOREIGN KEY (`clinical_trials_clinical_trial_id`) REFERENCES `clinical_trials` (`clinical_trial_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_patients_hospitals` FOREIGN KEY (`hospitals_hospital_id`) REFERENCES `hospitals` (`hospital_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
