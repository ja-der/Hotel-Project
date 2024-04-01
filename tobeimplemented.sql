/*
--------------------------------------------------------------
Drop Table Queries
For testing only
--------------------------------------------------------------
*/
DROP TABLE Rental;
DROP TABLE Position;
DROP TABLE Employee;
DROP TABLE Reservation;
DROP TABLE Client;
DROP TABLE Room;
DROP TABLE Hotel;
DROP TABLE Chain;

/*
--------------------------------------------------------------
Table Creation Queries
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
    EmployeeID INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);


/*
--------------------------------------------------------------
Queries (Au moins 4 Requetes) and Triggers (au moins 2)
--------------------------------------------------------------
*/

-- Inserting a reservation
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES ('2024-04-20', '2024-04-25', 1, 2, 3);

-- Trigger before inserting a new reservation to check room availability 
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS
$$
BEGIN
    IF (SELECT COUNT(*) FROM Reservation WHERE RoomID = NEW.RoomID AND (CheckInDate <= NEW.CheckOutDate AND CheckOutDate >= NEW.CheckInDate)) > 0 THEN
        RAISE EXCEPTION 'Room not available for specified dates';
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER before_reservation_insert
BEFORE INSERT ON Reservation
FOR EACH ROW
EXECUTE FUNCTION check_room_availability();


-- Deleting a client and all associated reservations
DELETE FROM Client WHERE ClientID = 1;

-- Trigger after deleting a client to delete all associated reservations
CREATE OR REPLACE FUNCTION delete_related_reservations()
RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM Reservation WHERE ClientID = OLD.ClientID;
    RETURN OLD;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER after_client_delete
AFTER DELETE ON Client
FOR EACH ROW
EXECUTE FUNCTION delete_related_reservations();

--Updating the address of a hotel:
UPDATE Hotel SET HotelAddress = 'New Address' WHERE HotelID = 1;

-- Finding all reservations for a specific client
SELECT * FROM Reservation WHERE ClientID = 1;


/*
--------------------------------------------------------------
Indexes
--------------------------------------------------------------
*/
-- Used for indexing by room price to speed up searches for rooms within a specific price range:
CREATE INDEX idx_room_price ON Room(Price);
-- Expected Queries: Queries that involve checking room price and filtering reservations by price
-- Expected Data Updates: Updates to room data that may affect pricing, such as inserting or updating rooms.

-- Used for Hotel.ChainID to optimize queries filtering hotels by their chain:
CREATE INDEX idx_hotel_chainid ON Hotel(ChainID);
-- Expected Queries: Queries that involve filtering hotels by their chain, retrieving hotels associated with a particular chain, or identifying chains that own specific hotels.
-- Expected Data Updates: Updates to hotel data that may involve changes in the chain association, such as reassigning hotels to different chains or adding new hotels to existing chains.

---- On Client.LastName and Client.FirstName to improve search performance for clients by name:
CREATE INDEX idx_client_lastname_firstname ON Client(LastName, FirstName);
-- Expected Queries: Queries that involve searching for clients by their last name, first name, or both, such as retrieving client information for bookings or filtering clients for specific marketing campaigns.
-- Expected Data Updates: Updates or adding to client data that may involve changes in the last name or first name

/*
--------------------------------------------------------------
Views
--------------------------------------------------------------
*/
--Number of Available Rooms per City
-- Problem is what do they mean by zone, and if they do mean city, may need to change column in Hotel table
CREATE VIEW AvailableRoomsPerCity AS
SELECT h.HotelAddress AS City,
       COUNT(r.RoomID) AS AvailableRooms
FROM Hotel h
LEFT JOIN Room r ON h.HotelID = r.HotelID
WHERE r.RoomID NOT IN (SELECT Reservation.RoomID FROM Reservation)
GROUP BY h.HotelAddress;

--Capacity of All Rooms in a Specific Hotel
CREATE VIEW RoomCapacityPerHotel AS
SELECT h.HotelID,
       h.HotelName,
       SUM(r.Capacity) AS TotalCapacity
FROM Hotel h
JOIN Room r ON h.HotelID = r.HotelID
GROUP BY h.HotelID, h.HotelName;
