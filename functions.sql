-- updating guardian phone number
CREATE OR REPLACE FUNCTION update_guardian_phone_number
(
	g_id guardian.guardian_id%type,
	new_phone guardian.phone%type
)
RETURNS varchar AS $result$
DECLARE 
    result varchar;
BEGIN
    IF EXISTS (SELECT phone FROM guardian WHERE g_id = guardian_id)
	THEN
        UPDATE guardian SET phone = new_phone WHERE g_id = guardian_id;
        return 'Update phone number successfullly';

    ELSE     
        RETURN 'Invalid guardian ID';

    END IF;
END;
$result$ LANGUAGE plpgsql




-- checking if phone number correct length
CREATE OR REPLACE FUNCTION phone_check()
RETURNS trigger AS $phone_check$
DECLARE 
    phone_length INTEGER;
BEGIN
	SELECT length(NEW.phone) INTO phone_length;

	IF (phone_length != 10) THEN
		RAISE EXCEPTION 'Phone number must be 10 digits';
	END IF;
   	RETURN NULL;
END;
$phone_check$ LANGUAGE plpgsql

CREATE OR REPLACE TRIGGER phone_check
AFTER INSERT OR UPDATE of phone
ON staff
FOR EACH ROW EXECUTE FUNCTION phone_check();

CREATE OR REPLACE TRIGGER phone_check
AFTER INSERT OR UPDATE of phone
ON guardian
FOR EACH ROW EXECUTE FUNCTION phone_check();




-- Says if child got enough sleep or not after session
CREATE OR REPLACE FUNCTION valid_sleep()
RETURNS trigger AS $valid_sleep$
BEGIN
	IF (NEW.hours_slept < 2) THEN
		RAISE NOTICE 'Not enough sleep!';
	ELSIF (NEW.hours_slept > 4) THEN
		RAISE NOTICE 'Too much sleep!';
	END IF;
	
   	RETURN NULL;
END;
$valid_sleep$ LANGUAGE plpgsql

CREATE OR REPLACE TRIGGER valid_sleep
AFTER INSERT OR UPDATE of hours_slept
ON session
FOR EACH ROW EXECUTE FUNCTION valid_sleep();