CREATE TABLE Chain (
    chain_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    headquarters_address VARCHAR(255) NOT NULL,
    number_of_hotels INT,
    headquarters_email VARCHAR(100) NOT NULL,
    headquarters_phone_number VARCHAR(20) NOT NULL
);

-- Not final
-- This is a draft of stuff that will be implemented in the final project

CREATE TABLE Hotel (
    hotel_id SERIAL PRIMARY KEY,
    chain_id INT NOT NULL,
    manager_id INT NOT NULL,
    hotel_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    FOREIGN KEY (chain_id) REFERENCES HotelChain(chain_id)
);

CREATE TABLE Room (
    room_id SERIAL PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_number INT NOT NULL,
    capacity INT NOT NULL,
    amenities TEXT,
    price DECIMAL(10, 2) NOT NULL,
    view_type VARCHAR(50),
    extendable BOOLEAN NOT NULL,
    issues TEXT,
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    hotel_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    social_security VARCHAR(20) NOT NULL,
    role VARCHAR(50) NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);

CREATE TABLE Client (
    client_id SERIAL PRIMARY KEY,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    social_security VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);


CREATE TABLE Reservation (
    reservation_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    room_id INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(client_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

-- Insertions

-- Insertion de données pour une chaîne hôtelière
INSERT INTO HotelChain (chain_name, headquarters_addr, contact_email, contact_phone)
VALUES ('Example Hotels', '123 Main Street, City, Country', 'info@examplehotels.com', '+1234567890');

-- Insertion de données pour les hôtels de la chaîne
INSERT INTO Hotel (chain_id, manager_id, hotel_name, address, contact_email)
VALUES (1, 1, 'Example Hotel 1', '456 Elm Street, City, Country', 'hotel1@examplehotels.com');

-- Insertion de données pour les chambres de l'hôtel
INSERT INTO Room (hotel_id, room_number, capacity, amenities, price, view_type, extendable, issues)
VALUES (1, 101, 2, 'TV, Air Conditioning, Mini Fridge', 100.00, 'City View', TRUE, NULL);

-- Insertion de données pour les employés de l'hôtel
INSERT INTO Employee (hotel_id, full_name, address, social_security, role)
VALUES (1, 'John Doe', '789 Oak Street, City, Country', '123-45-6789', 'Manager');

-- Insertion de données pour les clients
INSERT INTO Client (checkin_date, checkout_date, social_security, name, address)
VALUES ('2024-03-25', '2024-03-27', '987-65-4321', 'Jane Smith', '789 Maple Ave, City, Country');



-- SQL Queries
SELECT * FROM Hotel WHERE chain_id = 1;
SELECT COUNT(*) FROM Room WHERE hotel_id = 1;
SELECT * FROM Client WHERE social_security = '987-65-4321';
UPDATE Room SET price = 120.00 WHERE room_id = 1;


-- Triggers
CREATE OR REPLACE FUNCTION prevent_manager_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.role = 'Manager' THEN
        IF NOT EXISTS (SELECT 1 FROM Employee WHERE hotel_id = OLD.hotel_id AND role = 'Manager' AND employee_id != OLD.employee_id) THEN
            RAISE EXCEPTION 'Cannot delete the only manager of the hotel';
        END IF;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER manager_deletion_trigger
BEFORE DELETE ON Employee
FOR EACH ROW
EXECUTE FUNCTION prevent_manager_deletion();



CREATE OR REPLACE FUNCTION update_available_rooms()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Hotel
    SET available_rooms = available_rooms - 1
    WHERE hotel_id = NEW.hotel_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER reservation_trigger
AFTER INSERT ON Client
FOR EACH ROW
EXECUTE FUNCTION update_available_rooms();
