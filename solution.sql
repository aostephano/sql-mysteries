SELECT * FROM crime_scene_report WHERE type == 'murder' AND city == 'SQL City';

-- Possible - First witness
SELECT * FROM person WHERE address_street_name == 'Northwestern Dr' ORDER BY address_number DESC LIMIT 1;

-- Possible - Second witness
SELECT * FROM person WHERE name LIKE 'Annabel%' AND address_street_name LIKE 'Franklin Ave%';

-- Possible - First witness (Morty Schapiro) Interview
SELECT *
FROM (SELECT * FROM interview INNER JOIN person ON interview.person_id = person.id) AS interview_person_result
 WHERE address_street_name == 'Northwestern Dr' ORDER BY address_number DESC LIMIT 1;
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
-- The membership number on the bag started with "48Z". Only gold members have those bags.
-- The man got into a car with a plate that included "H42W".

-- Second witness (Anabell) Interview
SELECT *
FROM (SELECT * FROM interview INNER JOIN person ON interview.person_id = person.id) AS interview_person_result
WHERE name LIKE 'Annabel%' AND address_street_name LIKE 'Franklin Ave%';
-- I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT * FROM (SELECT * FROM get_fit_now_check_in INNER JOIN get_fit_now_member ON get_fit_now_check_in.membership_id = get_fit_now_member.id) AS check_in_and_membership
WHERE check_in_date == 20180109;
--Joe Germuska
--Jeremy Bowers

SELECT * FROM person WHERE person.name == 'Joe Germuska';
-- PK: 28819 | License_id: 173289
SELECT * FROM person WHERE person.name == 'Jeremy Bowers';
-- PK ID: 67318 | License_id: 423327

SELECT * FROM ( SELECT * FROM drivers_license INNER JOIN person ON drivers_license.id = person.license_id ) AS person_driver_license_result
WHERE license_id == 423327;

SELECT * FROM person WHERE name == 'Jeremy Bowers';

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;
-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge,
-- try querying the interview transcript of the murderer to find the real villain behind this crime.
-- If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries.
-- Use this same INSERT statement with your new suspect to check your answer.

SELECT * FROM interview WHERE person_id == 67318;
-- I was hired by a woman with a lot of money.
-- I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
-- She has red hair and she drives a Tesla Model S.
-- I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT person_driver_license_result.id, license_id, name FROM ( SELECT * FROM drivers_license INNER JOIN person ON drivers_license.id = person.license_id ) AS person_driver_license_result
WHERE hair_color == 'red' AND gender == 'female' AND car_make == 'Tesla';

SELECT person_driver_license_result.id FROM ( SELECT * FROM drivers_license INNER JOIN person ON drivers_license.id = person.license_id ) AS person_driver_license_result
WHERE hair_color == 'red' AND gender == 'female' AND car_make == 'Tesla';
-- id, license_id, name
-- 918773,918773,Red Korb
-- 291182,291182,Regina George
-- 202298,202298,Miranda Priestly

SELECT * FROM (SELECT person_driver_license_result.id FROM ( SELECT * FROM drivers_license INNER JOIN person ON drivers_license.id = person.license_id ) AS person_driver_license_result
WHERE hair_color == 'red' AND gender == 'female' AND car_make == 'Tesla') AS suspects_id_result;

SELECT *
FROM income
INNER JOIN person ON income.ssn = person.ssn;

SELECT *
FROM income
INNER JOIN person ON income.ssn = person.ssn
WHERE person.id IN (
    SELECT person_driver_license_result.id
    FROM (
        SELECT *
        FROM drivers_license
        INNER JOIN person ON drivers_license.id = person.license_id
    ) AS person_driver_license_result
    WHERE hair_color = 'red' AND gender = 'female' AND car_make = 'Tesla'
);

SELECT * FROM income ORDER BY annual_income DESC;

SELECT * FROM drivers_license where id == 918773;
SELECT * FROM person WHERE license_id == 918773;
-- ID: 78881 License_id: 918773


SELECT person_id, event_name, COUNT(*) as visit_count
FROM facebook_event_checkin
WHERE event_name LIKE 'SQL Symphony%'
GROUP BY person_id, event_name
HAVING COUNT(*) == 3
ORDER BY person_id DESC;

SELECT * from facebook_event_checkin WHERE date LIKE '2017%' and event_name LIKE 'SQL Symphony%';

INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;

