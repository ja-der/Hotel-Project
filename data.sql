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
    HotelID INT NOT NULL,
    HotelAddress VARCHAR(255) NOT NULL,
    HotelPhoneNumber VARCHAR(20) NOT NULL,
    HotelEmail VARCHAR(100) NOT NULL,
    StarRating INT NOT NULL,
    NumberOfRooms INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (HotelID, ChainID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Room (
    RoomID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Amenities VARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    RoomView VARCHAR(255) NOT NULL,
    Extendable VARCHAR(25) NOT NULL,
    Issues VARCHAR(255) NOT NULL,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (RoomID, HotelID, ChainID),
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
    ReservationID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    ClientID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (ReservationID, HotelID, RoomID, ChainID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Employee (
    EmployeeID INT NOT NULL,
    EmployeeFirstName VARCHAR(20) NOT NULL,
    EmployeeLastName VARCHAR(20) NOT NULL,
    EmployeeAddress VARCHAR(255) NOT NULL,
    EmployeeEmail VARCHAR(100) NOT NULL,
    EmployeePassword VARCHAR(255) NOT NULL,
    EmployeeSSN INT NOT NULL,
    EmployeeRole VARCHAR(50) NOT NULL,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (EmployeeID, HotelID, ChainID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE Rental (
    RentalID INT NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ReservationID INT,
    EmployeeID INT NOT NULL,
    ClientID INT NOT NULL,
    ChainID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    PRIMARY KEY (RentalID, ChainID, HotelID, RoomID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Position (
    JobTitle VARCHAR(255) NOT NULL,
    Responsibilities VARCHAR(1000),
    JobLevel INT,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (JobTitle, HotelID, ChainID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

CREATE TABLE EmployeePosition (
    EmployeeID INT NOT NULL,
    JobTitle VARCHAR(255) NOT NULL,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    PRIMARY KEY (EmployeeID, JobTitle, HotelID, ChainID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (JobTitle) REFERENCES Position(JobTitle),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);


