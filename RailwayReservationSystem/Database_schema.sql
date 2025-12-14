--------------------------------------------------------
-- RAILWAY RESERVATION SYSTEM - FULL DATABASE BACKUP
--------------------------------------------------------

-- 1. DROP EXISTING TABLES (Clean Slate)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE reservations';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE station_distances';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE trains';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE users';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE user_seq';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE train_seq';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE dist_seq';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE reservation_seq';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- 2. CREATE SEQUENCES
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE train_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE dist_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE reservation_seq START WITH 1000 INCREMENT BY 1;

-- 3. CREATE TABLES

-- Users Table
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    fullname VARCHAR2(100),
    email VARCHAR2(100) UNIQUE,
    phone VARCHAR2(15),
    username VARCHAR2(50) UNIQUE,
    password VARCHAR2(50),
    role VARCHAR2(20) DEFAULT 'USER',
    created_date DATE DEFAULT SYSDATE
);

-- Admin User Insert
INSERT INTO users (user_id, fullname, email, phone, username, password, role) 
VALUES (user_seq.NEXTVAL, 'System Admin', 'admin@railway.com', '9999999999', 'admin', 'admin123', 'ADMIN');

-- Trains Table
CREATE TABLE trains (
    train_id NUMBER PRIMARY KEY,
    train_name VARCHAR2(100),
    train_number VARCHAR2(20) UNIQUE,
    source_station VARCHAR2(50),
    destination_station VARCHAR2(50),
    departure_time VARCHAR2(10),
    arrival_time VARCHAR2(10),
    total_seats NUMBER,
    available_seats NUMBER,
    fare_general NUMBER,
    fare_sleeper NUMBER,
    fare_3ac NUMBER,
    fare_2ac NUMBER,
    fare_1ac NUMBER
);

-- Station Distances (The "Route" Table)
CREATE TABLE station_distances (
    distance_id NUMBER PRIMARY KEY,
    train_id NUMBER REFERENCES trains(train_id),
    station_name VARCHAR2(100),
    km_from_source NUMBER
);

-- Reservations Table
CREATE TABLE reservations (
    reservation_id NUMBER PRIMARY KEY,
    user_id NUMBER REFERENCES users(user_id),
    train_id NUMBER REFERENCES trains(train_id),
    passenger_name VARCHAR2(100),
    age NUMBER,
    gender VARCHAR2(10),
    journey_date DATE,
    seats_booked NUMBER,
    total_fare NUMBER,
    booking_status VARCHAR2(20),
    booking_date DATE DEFAULT SYSDATE
);


-- 4. INSERT TRAIN DATA (Trains + Routes)

-- Train 1: Rajdhani Express
INSERT INTO trains VALUES (train_seq.NEXTVAL, 'Rajdhani Express', 'RJ12301', 'Kolkata', 'Delhi', '16:30', '10:00', 300, 300, 400, 900, 2200, 3200, 5000);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Kolkata', 0);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Dhanbad', 280);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Gaya', 460);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Patna', 540);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Prayagraj', 800);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='RJ12301'), 'Delhi', 1450);

-- Train 2: Poorva Express
INSERT INTO trains VALUES (train_seq.NEXTVAL, 'Poorva Express', '12303', 'Kolkata', 'Delhi', '08:00', '07:00', 800, 800, 250, 600, 1600, 2400, 4200);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Kolkata', 0);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Asansol', 200);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Patna', 540);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Prayagraj', 800);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Kanpur', 1000);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12303'), 'Delhi', 1450);

-- Train 3: Shatabdi Express
INSERT INTO trains VALUES (train_seq.NEXTVAL, 'Lucknow Shatabdi', '12004', 'Delhi', 'Lucknow', '06:10', '12:40', 600, 600, 400, 0, 1200, 1800, 2500);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12004'), 'Delhi', 0);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12004'), 'Ghaziabad', 30);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12004'), 'Kanpur', 440);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='12004'), 'Lucknow', 510);

-- Train 4: Chennai Express
INSERT INTO trains VALUES (train_seq.NEXTVAL, 'Chennai Express', 'CH12345', 'Chennai', 'Bangalore', '06:00', '13:30', 500, 500, 150, 350, 800, 1200, 2000);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='CH12345'), 'Chennai', 0);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='CH12345'), 'Katpadi', 130);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='CH12345'), 'Jolarpettai', 215);
INSERT INTO station_distances VALUES (dist_seq.NEXTVAL, (SELECT train_id FROM trains WHERE train_number='CH12345'), 'Bangalore', 350);

-- 5. COMMIT CHANGES
COMMIT;

-- 6. VERIFY
SELECT 'Database Setup Complete!' AS Status FROM DUAL;