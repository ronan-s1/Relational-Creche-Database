-- FOR DEMO --
-- showing each table has data
SELECT * FROM child;
SELECT * FROM goals;
SELECT * FROM session;
SELECT * FROM staff;
SELECT * FROM room;
SELECT * FROM goals;
SELECT * FROM guardian;

-- phone check
UPDATE guardian SET phone = '123' WHERE g_id = 1;

-- sleep trigger
UPDATE session SET hours_slept = 1 WHERE child_id = 1 AND date = '2022-11-04';

-- Getting people with same last names from guardian and child table
SELECT name, child_id AS ID FROM child
WHERE name LIKE '%Gus%'
UNION
SELECT name, guardian_id AS ID FROM guardian
WHERE name LIKE '%Gus%';

-- staff that have worked on a given date
SELECT staff_id, name FROM staff
INTERSECT
SELECT staff_id, name FROM session
JOIN staff USING (staff_id)
WHERE date = '2022-11-1';

-- staff that have NOT worked on a given date
SELECT staff_id, name FROM staff
EXCEPT 
SELECT staff_id, name FROM session
JOIN staff USING (staff_id)
WHERE date = '2022-11-1';

-- rooms that share the same stage
SELECT stage_name, room_number FROM stages
JOIN (SELECT stage_name, COUNT(*)
	FROM stages 
	GROUP BY stage_name
	HAVING count(*) > 1 ) s2
USING (stage_name)
ORDER BY stage_name;

-- getting goals based on room number
SELECT room_number, goals FROM goals
JOIN stages USING (stage_id)
WHERE room_number = '2';

-- getting child's guardians using child_id
SELECT g.child_id, g.name as guardians, c.name AS child_name
FROM guardian g
JOIN child c USING(child_id)
WHERE c.child_id = 1;

-- Staff who has been in every room (none currently as room 5 empty)
SELECT * FROM STAFF s WHERE NOT EXISTS
(
	SELECT * FROM room r WHERE NOT EXISTS
	(
		SELECT * FROM session ses
		WHERE ses.staff_id = s.staff_id
		AND
		ses.room_number = r.room_number
	)
);

-- Children who aren't healthy in a session
SELECT name, * FROM session
JOIN child USING (child_id)
WHERE well_being != 'healthy';

-- Getting sessions staff did including staff who didn't do a session yet
SELECT session_id, name FROM session
RIGHT JOIN staff st USING (staff_id)
ORDER BY session_id ASC;

-- all rooms with its corresponding stage
SELECT room_number, stage_name FROM room
FULL JOIN stages using (room_number);

-- rooms which are empty
SELECT room_number, stage_name FROM room
LEFT JOIN stages using (room_number)
WHERE stage_name IS NULL;

-- getting child's end of day log
SELECT g.name AS preferred_guardian_name, c.name, c.nickname AS child_name, hours_slept, food_ate, well_being, date
FROM session
JOIN child c USING (child_id)
JOIN guardian g USING (child_id)
WHERE child_id = 1
AND date = '2022-11-2'
AND preferred = TRUE;

-- last session added
SELECT * FROM session s
WHERE NOT EXISTS
(
	SELECT * FROM session s2
	WHERE s.session_id < s2.session_id
);