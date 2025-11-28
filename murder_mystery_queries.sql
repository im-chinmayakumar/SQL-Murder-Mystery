-- Q1. Where did the crime happen?
SELECT DISTINCT room AS crime_location
FROM evidence
WHERE room = 'CEO Office';

-- Q2. What was the approximate time of the crime?
SELECT MIN(found_time) AS earliest_evidence_time
FROM evidence
WHERE room = 'CEO Office';

-- Q3. Who entered the CEO Office around the crime time?
SELECT e.name, k.entry_time, k.exit_time
FROM employees e
JOIN keycard_logs k ON e.employee_id = k.employee_id
WHERE k.room = 'CEO Office'
AND k.entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:15:00';

-- Q4.Who provided a false alibi?
SELECT e.name, a.claimed_location, k.room AS actual_location
FROM employees e
JOIN alibis a ON e.employee_id = a.employee_id
JOIN keycard_logs k ON e.employee_id = k.employee_id
WHERE a.claimed_location <> k.room
AND k.room = 'CEO Office';

-- Q5. Who made suspicious calls between 20:50 and 21:00?
SELECT e.name, c.call_time, c.duration_sec
FROM employees e
JOIN calls c ON e.employee_id = c.caller_id
WHERE c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';

-- Q6. What evidence was found at the crime scene?
SELECT description, found_time
FROM evidence
WHERE room = 'CEO Office';

-- Q7. Who is the killer? (Final Case Solved Query)
SELECT e.name AS killer
FROM employees e
JOIN keycard_logs k ON e.employee_id = k.employee_id
JOIN alibis a ON e.employee_id = a.employee_id
JOIN calls c ON e.employee_id = c.caller_id
WHERE k.room = 'CEO Office'
AND k.entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:15:00'
AND a.claimed_location <> k.room
AND c.call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00';
