-- Preview Data
SELECT * 
FROM twc-vrproject.VRDataset.VRData;

-- Create new table
CREATE TABLE VRDataset.VRData1 AS
SELECT *,
-- Update closure type from qualitative to quantitative and modify VRData
 CASE WHEN closure_type = 'Unsuccessful' THEN 0
 WHEN closure_type = 'Successful' THEN 1
 END AS new_closure_type,
FROM twc-vrproject.VRDataset.VRData;

-- Calculate average case length and case payment
SELECT AVG(total_case_payment) AS avg_succ_pmnt
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 1;
SELECT AVG(case_length_months) AS avg_succ_length
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 1;
SELECT AVG(total_case_payment) AS avg_succ_pmnt
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 0;
SELECT AVG(case_length_months) AS avg_succ_length
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 0;

-- Percentage successful
SELECT (COUNT(CASE WHEN new_closure_type = 1 THEN 1 END) / COUNT(ID)) * 100 AS percentage_succ
FROM twc-vrproject.VRDataset.VRData1;
-- Percentage unsuccessful
SELECT (COUNT(CASE WHEN new_closure_type = 0 THEN 0 END) / COUNT(ID)) * 100 AS percentage_succ
FROM twc-vrproject.VRDataset.VRData1;

-- Calculate the correlation between case length and total payment for successful cases
SELECT CORR(case_length_months, total_case_payment) AS correlation
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 1;
-- Calculate the correlation between case length and total payment for unsuccessful cases
SELECT CORR(case_length_months, total_case_payment) AS correlation
FROM twc-vrproject.VRDataset.VRData1
WHERE new_closure_type = 0;

--Calculate the correlation between case length and total payment for successful cases based on ethnicity
SELECT CORR(case_length_months, total_case_payment) AS correlation
FROM twc-vrproject.VRDataset.VRData1
WHERE ethnicity = 'Asiatic or Pacific' AND new_closure_type = 1;

--Calculate the correlation between case length and total payment for successful cases based on disability
SELECT CORR(case_length_months, total_case_payment) AS correlation
FROM twc-vrproject.VRDataset.VRData1
WHERE primary_disability = 'Auditory/Communicative Disability' AND new_closure_type = 1;

--Calculate the correlation between case length and total payment for successful cases based on region
SELECT CORR(case_length_months, total_case_payment) AS correlation
FROM twc-vrproject.VRDataset.VRData1
WHERE region_id = 500 AND new_closure_type = 1;
