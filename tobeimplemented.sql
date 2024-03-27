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
Random Data Pop Queries
--------------------------------------------------------------
*/

-- Inserting data into Chain table
INSERT INTO Chain (Name, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber)
VALUES 
    ('Chain A', '123 Main St, CityA', 10, 'chainA@example.com', '123-456-7890'),
    ('Chain B', '456 Elm St, CityB', 8, 'chainB@example.com', '987-654-3210'),
    ('Chain C', '789 Oak St, CityC', 12, 'chainC@example.com', '555-123-4567'),
    ('Chain D', '321 Pine St, CityD', 9, 'chainD@example.com', '111-222-3333'),
    ('Chain E', '654 Maple St, CityE', 11, 'chainE@example.com', '999-888-7777');

-- Inserting data into Hotel table
INSERT INTO Hotel (Address, PhoneNumber, Email, StarRating, NumberOfRooms, ChainID)
VALUES 
    ('123 Broadway, CityA', '111-222-3333', 'hotelA1@example.com', 4, 50, 1),
    ('456 Broadway, CityB', '222-333-4444', 'hotelB1@example.com', 3, 60, 2),
    ('789 Broadway, CityC', '333-444-5555', 'hotelC1@example.com', 5, 70, 3),
    ('321 Broadway, CityD', '444-555-6666', 'hotelD1@example.com', 4, 55, 4),
    ('654 Broadway, CityE', '555-666-7777', 'hotelE1@example.com', 3, 65, 5);

-- Inserting data into Room table
INSERT INTO Room (Price, Amenities, Capacity, View, Extendable, Issues, HotelID, ChainID)
VALUES 
    (100.00, 'WiFi, TV', 2, 'City View', 'Yes', NULL, 1, 1),
    (120.00, 'WiFi, TV, Mini-Bar', 2, 'Ocean View', 'No', NULL, 1, 1),
    (150.00, 'WiFi, TV, Kitchenette', 4, 'Mountain View', 'Yes', 'None', 2, 2),
    (80.00, 'WiFi', 1, 'No View', 'Yes', 'None', 2, 2),
    (200.00, 'WiFi, TV, Mini-Bar, Kitchenette', 4, 'Lake View', 'No', 'None', 3, 3),
    (180.00, 'WiFi, TV', 3, 'Garden View', 'Yes', 'None', 3, 3),
    (90.00, 'WiFi', 2, 'City View', 'No', 'None', 4, 4),
    (110.00, 'WiFi, TV', 2, 'City View', 'Yes', 'None', 4, 4),
    (130.00, 'WiFi, TV', 3, 'Ocean View', 'Yes', 'None', 5, 5),
    (160.00, 'WiFi, TV, Mini-Bar', 3, 'Mountain View', 'No', 'None', 5, 5);

-- Inserting data into Client table
INSERT INTO Client (FirstName, LastName, Address, SSN, RegistrationDate)
VALUES 
    ('John', 'Doe', '789 Elm St, CityX', 123456789, '2023-01-15'),
    ('Jane', 'Smith', '456 Oak St, CityY', 987654321, '2023-02-20'),
    ('Alice', 'Johnson', '123 Maple St, CityZ', 456789123, '2023-03-25'),
    ('Bob', 'Brown', '654 Pine St, CityW', 789123456, '2023-04-30'),
    ('Emily', 'Davis', '321 Cedar St, CityV', 654321789, '2023-05-05');

-- Inserting data into Reservation table
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES 
    ('2023-06-01', '2023-06-05', 1, 1, 1),
    ('2023-06-10', '2023-06-15', 2, 2, 3),
    ('2023-07-01', '2023-07-07', 3, 3, 5),
    ('2023-07-15', '2023-07-20', 4, 4, 7),
    ('2023-08-01', '2023-08-10', 5, 5, 9);

-- Inserting data into Employee table
INSERT INTO Employee (FirstName, LastName, Address, SSN, Role, HotelID, ChainID)
VALUES 
    ('Michael', 'Johnson', '123 Elm St, CityM', 987654321, 'Manager', 1, 1),
    ('Jennifer', 'Williams', '456 Oak St, CityN', 123456789, 'Receptionist', 2, 2),
    ('David', 'Brown', '789 Maple St, CityO', 456789123, 'Housekeeping', 3, 3),
    ('Michelle', 'Garcia', '321 Pine St, CityP', 789123456, 'Chef', 4, 4),
    ('Christopher', 'Martinez', '654 Cedar St, CityQ', 654321789, 'Waiter', 5, 5);

-- Inserting data into Rental table
INSERT INTO Rental (StartDate, EndDate, ReservationID, EmployeeID, ChainID, HotelID, RoomID)
VALUES 
    ('2023-06-01', '2023-06-05', 1, 1, 1, 1, 1),
    ('2023-06-10', '2023-06-15', 2, 2, 2, 2, 3),
    ('2023-07-01', '2023-07-07', 3, 3, 3, 3, 5),
    ('2023-07-15', '2023-07-20', 4, 4, 4, 4, 7),
    ('2023-08-01', '2023-08-10', 5, 5, 5, 5, 9);

-- Inserting data into Position table
INSERT INTO Position (JobTitle, Responsibilities, Level, HotelID)
VALUES 
    ('Manager', 'Oversee hotel operations', 3, 1),
    ('Receptionist', 'Manage check-ins and check-outs', 2, 2),




/*
--------------------------------------------------------------
Not final Yet
--------------------------------------------------------------
*/
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
