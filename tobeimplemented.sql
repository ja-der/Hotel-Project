/*
--------------------------------------------------------------
Table Creation Queries
APPLY QUERIES IN ORDER (or else it won't work)
--------------------------------------------------------------
*/
CREATE TABLE Chain (
    ChainID SERIAL PRIMARY KEY,
    ChainName VARCHAR(255) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    HeadquartersEmail VARCHAR(255) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    HotelAddress VARCHAR(255) NOT NULL,
    HotelPhoneNumber VARCHAR(20) NOT NULL,
    HotelEmail VARCHAR(100) NOT NULL,
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
    ClientFirstName VARCHAR(20) NOT NULL,
    ClientLastName VARCHAR(20) NOT NULL,
    ClientAddress VARCHAR(255) NOT NULL,
    ClientSSN INT NOT NULL,
    RegistrationDate DATE NOT NULL,
    ClientEmail VARCHAR(100),
    ClientPassword VARCHAR(255)
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
    EmployeeFirstName VARCHAR(20) NOT NULL,
    EmployeeLastName VARCHAR(20) NOT NULL,
    EmployeeAddress VARCHAR(255) NOT NULL,
    EmployeeSSN INT NOT NULL,
    EmployeeRole VARCHAR(50) NOT NULL,
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
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);


/*
--------------------------------------------------------------
Random Data Pop Queries
--------------------------------------------------------------
*/

-- Insert data for Chain 1
INSERT INTO Chain (Name, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) 
VALUES ('Chain 1', '123 Main Street, City1, Country1', 8, 'hq1@example.com', '+1234567890');

-- Insert data for Chain 1 Hotels
INSERT INTO Hotel (Address, PhoneNumber, Email, StarRating, NumberOfRooms, ChainID)
VALUES 
    ('123 Hotel Ave, City1, Country1', '+1234567890', 'hotel1@example.com', 4, 50, 1), -- Hotel 1
    ('456 Resort St, City2, Country1', '+1234567890', 'resort1@example.com', 5, 100, 1), -- Hotel 2
    ('789 Lodge Blvd, City3, Country1', '+1234567890', 'lodge1@example.com', 3, 80, 1), -- Hotel 3
    ('987 Inn Ln, City4, Country1', '+1234567890', 'inn1@example.com', 4, 120, 1), -- Hotel 4
    ('543 Motel Rd, City5, Country1', '+1234567890', 'motel1@example.com', 2, 60, 1), -- Hotel 5
    ('654 Plaza Dr, City6, Country1', '+1234567890', 'plaza1@example.com', 3, 90, 1), -- Hotel 6
    ('876 Villa Ave, City7, Country1', '+1234567890', 'villa1@example.com', 4, 110, 1), -- Hotel 7
    ('210 Retreat Blvd, City8, Country1', '+1234567890', 'retreat1@example.com', 5, 150, 1); -- Hotel 8

-- Insert data for rooms in each hotel
-- Hotel 1 Rooms
INSERT INTO Room (Price, Amenities, Capacity, View, Extendable, Issues, HotelID, ChainID)
VALUES
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 1, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 1, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 1, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 1, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 2, 'City view', 'Yes', NULL, 1, 1) -- Room 5
;

-- Insert data for Clients
INSERT INTO Client (FirstName, LastName, Address, SSN, RegistrationDate)
VALUES 
    ('John', 'Doe', '123 Client St, City1, Country1', 123456789, '2024-03-26'),
    ('Jane', 'Smith', '456 Client Ave, City2, Country1', 987654321, '2024-03-27'),
    -- Add more clients for Chain 1 as needed
;

-- Insert data for Employees
INSERT INTO Employee (FirstName, LastName, Address, SSN, Role, HotelID, ChainID)
VALUES 
    ('Alice', 'Johnson', '123 Employee St, City1, Country1', 111111111, 'Manager', 1, 1),
    ('Bob', 'Smith', '456 Employee Ave, City2, Country1', 222222222, 'Front Desk Clerk', 1, 1),
    -- Add more employees for Chain 1 as needed
;

-- Insert data for Reservations
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES 
    ('2024-04-01', '2024-04-05', 1, 1, 1), -- Client John Doe reserves Hotel 1 Room 1
    ('2024-04-02', '2024-04-06', 2, 2, 2), -- Client Jane Smith reserves Hotel 2 Room 2
    -- Add more reservations for Chain 1 as needed
;

-- Insert data for Positions
INSERT INTO Position (JobTitle, Responsibilities, Level, HotelID)
VALUES 
    ('Manager', 'Oversee hotel operations', 3, 1), -- Manager position at Hotel 1
    ('Front Desk Clerk', 'Assist guests with check-in and check-out', 1, 1), -- Front Desk Clerk position at Hotel 1
    -- Add more positions for Chain 1 as needed
;


-- Insert data for Chain 2
INSERT INTO Chain (Name, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) 
VALUES ('Chain 2', '456 Elm Street, City2, Country2', 8, 'hq2@example.com', '+1234567890');

-- Insert data for Chain 2 Hotels
INSERT INTO Hotel (Address, PhoneNumber, Email, StarRating, NumberOfRooms, ChainID)
VALUES 
    ('123 Resort Ave, City1, Country2', '+1234567890', 'resort2@example.com', 4, 50, 2), -- Hotel 1
    ('456 Lodge St, City2, Country2', '+1234567890', 'lodge2@example.com', 5, 100, 2), -- Hotel 2
    ('789 Inn Blvd, City3, Country2', '+1234567890', 'inn2@example.com', 3, 80, 2), -- Hotel 3
    ('987 Motel Ln, City4, Country2', '+1234567890', 'motel2@example.com', 4, 120, 2), -- Hotel 4
    ('543 Plaza Rd, City5, Country2', '+1234567890', 'plaza2@example.com', 2, 60, 2), -- Hotel 5
    ('654 Villa Dr, City6, Country2', '+1234567890', 'villa2@example.com', 3, 90, 2), -- Hotel 6
    ('876 Retreat Ave, City7, Country2', '+1234567890', 'retreat2@example.com', 4, 110, 2), -- Hotel 7
    ('210 Beach Blvd, City8, Country2', '+1234567890', 'beach2@example.com', 5, 150, 2); -- Hotel 8

-- Insert data for rooms in each hotel in Chain 2
-- Repeat the process similarly to Chain 1 for each hotel in Chain 2

-- Insert data for Clients for Chain 2
INSERT INTO Client (FirstName, LastName, Address, SSN, RegistrationDate)
VALUES 
    ('Michael', 'Brown', '123 Client St, City1, Country2', 111111111, '2024-03-28'),
    ('Jennifer', 'Davis', '456 Client Ave, City2, Country2', 222222222, '2024-03-29'),
    -- Add more clients for Chain 2 as needed
;

-- Insert data for Employees for Chain 2
INSERT INTO Employee (FirstName, LastName, Address, SSN, Role, HotelID, ChainID)
VALUES 
    ('David', 'Wilson', '123 Employee St, City1, Country2', 333333333, 'Manager', 1, 2),
    ('Jessica', 'Martinez', '456 Employee Ave, City2, Country2', 444444444, 'Front Desk Clerk', 1, 2),
    -- Add more employees for Chain 2 as needed
;

-- Insert data for Reservations for Chain 2
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES 
    ('2024-04-03', '2024-04-07', 1, 1, 1), -- Client Michael Brown reserves Hotel 1 Room 1
    ('2024-04-04', '2024-04-08', 2, 2, 2), -- Client Jennifer Davis reserves Hotel 2 Room 2
    -- Add more reservations for Chain 2 as needed
;

-- Insert data for Positions for Chain 2
INSERT INTO Position (JobTitle, Responsibilities, Level, HotelID)
VALUES 
    ('Manager', 'Oversee hotel operations', 3, 1), -- Manager position at Hotel 1
    ('Front Desk Clerk', 'Assist guests with check-in and check-out', 1, 1), -- Front Desk Clerk position at Hotel 1
    -- Add more positions for Chain 2 as needed
;

--- .... continue 


/*
--------------------------------------------------------------
Example Queries
--------------------------------------------------------------
*/
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES ('2024-04-20', '2024-04-25', 1, 2, 3);

UPDATE Room SET Issues = 'Water leak' WHERE RoomID = 3;

DELETE FROM Chain WHERE ChainID = 1;


/*
--------------------------------------------------------------
Indexes
--------------------------------------------------------------
*/
-- On Reservation.RoomID to speed up room availability searches:
CREATE INDEX idx_reservation_roomid ON Reservation(RoomID);

-- On Hotel.ChainID to optimize queries filtering hotels by their chain:
CREATE INDEX idx_hotel_chainid ON Hotel(ChainID);

-- On Client.LastName and Client.FirstName to improve search performance for clients by name:
CREATE INDEX idx_client_lastname_firstname ON Client(LastName, FirstName);


/*
--------------------------------------------------------------
Triggers
--------------------------------------------------------------
*/

-- Before deleting a hotel chain, ensure no hotels are linked to this chain:
CREATE OR REPLACE FUNCTION prevent_chain_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT count(*) FROM Hotel WHERE ChainID = OLD.ChainID) > 0 THEN
        RAISE EXCEPTION 'Cannot delete chain % because it still has hotels.', OLD.Name;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER BeforeChainDeletion
BEFORE DELETE ON Chain
FOR EACH ROW EXECUTE FUNCTION prevent_chain_deletion();

-- After inserting a reservation, verify room capacity and adjust the available number of rooms accordingly:1
-- Assuming you have a column or logic to manage availability, this trigger is conceptual
CREATE OR REPLACE FUNCTION update_room_availability()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Hotel SET NumberOfRooms = NumberOfRooms - 1 WHERE HotelID = NEW.HotelID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AfterReservationInsertion
AFTER INSERT ON Reservation
FOR EACH ROW EXECUTE FUNCTION update_room_availability();
