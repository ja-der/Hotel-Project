CREATE DATABASE ehotel;

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
    Amenities VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    RoomView VARCHAR(255) NOT NULL,
    Extendable VARCHAR(25) NOT NULL,
    Issues VARCHAR(255) NOT NULL,
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
    ChainID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    EmployeeFirstName VARCHAR(20) NOT NULL,
    EmployeeLastName VARCHAR(20) NOT NULL,
    EmployeeAddress VARCHAR(255) NOT NULL,
    EmployeeEmail VARCHAR(100) NOT NULL,
    EmployeePassword VARCHAR(255) NOT NULL,
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
    ReservationID INT,
    EmployeeID INT NOT NULL,
    ClientID INT NOT NULL,
    ChainID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
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

-- Insert data into the tables
INSERT INTO Chain(ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Fairmont', '1234 Elm St', 2, 'headquarters@fairmont.com', '123-456-7890');
INSERT INTO Hotel(HotelAddress, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID) VALUES ('1234 Elm St', '123-456-7890', '2laurier@fairmont.com', 5, 100, 1);
INSERT INTO Employee(EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, EmployeeRole, HotelID, ChainID) VALUES ('Alice', 'Johnson', '1234 Elm St', 'alice.johnson@ottawa.com', 'password', 123456789, 'Manager', 1, 1);

INSERT INTO Room(Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (200.00, 'TV, mini fridge, coffee maker', 2, 'City view', TRUE, 'None', 1, 1);
INSERT INTO Reservation(CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) VALUES ('2021-12-01', '2021-12-05', 1, 1, 1, 1);

-- Find available rooms
SELECT Rooms.*
FROM Rooms
WHERE Rooms.RoomID NOT IN (
    -- Subquery for rooms with overlapping reservations
    SELECT Reservation.RoomID
    FROM Reservation
    WHERE NOT (Reservation.StartDate > @EndDate OR Reservation.EndDate < @StartDate)
)
AND Rooms.RoomID NOT IN (
    -- Subquery for rooms with overlapping rentals
    SELECT Rental.RoomID
    FROM Rental
    WHERE NOT (Rental.StartDate > @EndDate OR Rental.EndDate < @StartDate)
)
