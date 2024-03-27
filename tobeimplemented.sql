-- Final Usable queries
-- APPLY QUERIES IN ORDER (or else it won't work)
CREATE TABLE Chain (
    ChainID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT,
    HeadquartersEmail VARCHAR(100) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    StarRating INT NOT NULL,
    NumberOfRooms INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Room (
    RoomID SERIAL PRIMARY KEY,
    Price DECIMAL(10, 2) NOT NULL,
    Amenities TEXT,
    Capacity INT NOT NULL,
    View VARCHAR(50),
    Extendable VARCHAR(255) NOT NULL,
    Issues TEXT,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Client (
    ClientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    SSN INT NOT NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Reservation (
    ReservationID SERIAL PRIMARY KEY,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    ClientID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    SSN INT NOT NULL,
    Role VARCHAR(50) NOT NULL,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Rental (
    RentalID SERIAL PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    ReservationID INT NOT NULL,
    EmployeeID INT NOT NULL,
    ChainID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Position (
    JobTitle VARCHAR(255) PRIMARY KEY,
    Responsibilities VARCHAR(1000),
    Level INT,
    HotelID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);



/*
--------------------------------------------------------------
Not final Yet
--------------------------------------------------------------
*/

-- Insertions

-- Insertion de données pour une chaîne hôtelière
INSERT INTO HotelChain (chain_Name, headquarters_addr, contact_email, contact_phone)
VALUES ('Example Hotels', '123 Main Street, City, Country', 'info@examplehotels.com', '+1234567890');

-- Insertion de données pour les hôtels de la chaîne
INSERT INTO Hotel (ChainID, manager_id, hotel_name, address, contact_email)
VALUES (1, 1, 'Example Hotel 1', '456 Elm Street, City, Country', 'hotel1@examplehotels.com');

-- Insertion de données pour les chambres de l'hôtel
INSERT INTO Room (HotelID, room_number, capacity, amenities, price, view_type, extendable, issues)
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
UPDATE Room SET price = 120.00 WHERE RoomID = 1;


-- Triggers
CREATE OR REPLACE FUNCTION prevent_manager_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.role = 'Manager' THEN
        IF NOT EXISTS (SELECT 1 FROM Employee WHERE hotel_id = OLD.hotel_id AND role = 'Manager' AND EmployeeID != OLD.employee_id) THEN
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
