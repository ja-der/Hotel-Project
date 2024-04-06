CREATE DATABASE ehotel;

-- CREATE TABLE QUERIES

-- CREATE CHAIN TABLE
CREATE TABLE Chain (
    ChainID SERIAL PRIMARY KEY,
    ChainName VARCHAR(255) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    HeadquartersEmail VARCHAR(255) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);

-- CREATE HOTEL TABLE
CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    HotelAddress VARCHAR(255) NOT NULL,
    HotelCity VARCHAR(255) NOT NULL,
    HotelPhoneNumber VARCHAR(20) NOT NULL,
    HotelEmail VARCHAR(100) NOT NULL,
    StarRating INT NOT NULL,
    NumberOfRooms INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID) ON DELETE CASCADE
  );
  
  -- CREATE ROOM TABLE
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
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE,
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID) ON DELETE CASCADE
);

-- CREATE CLIENT TABLE
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

-- CREATE RESERVATION TABLE
CREATE TABLE Reservation (
    ReservationID SERIAL PRIMARY KEY,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    ClientID INT NOT NULL,
    HotelID INT NOT NULL,
    RoomID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID) ON DELETE CASCADE
);
-- CREATE EMPLOYEE TABLE
CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    EmployeeFirstName VARCHAR(20) NOT NULL,
    EmployeeLastName VARCHAR(20) NOT NULL,
    EmployeeAddress VARCHAR(255) NOT NULL,
    EmployeeEmail VARCHAR(100) NOT NULL,
    EmployeePassword VARCHAR(255) NOT NULL,
    EmployeeSSN INT NOT NULL,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE,
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID) ON DELETE CASCADE
);

-- CREATE RENTAL TABLE
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
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID) ON DELETE CASCADE,
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID) ON DELETE CASCADE,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

-- CREATE POSITION TABLE
CREATE TABLE Position (
    JobCode SERIAL PRIMARY KEY,
    JobTitle VARCHAR(255) NOT NULL,
    Responsibilities VARCHAR(1000),
    JobLevel INT,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE,
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID) ON DELETE CASCADE
);

-- CREATE EMPLOYEEPOSITION TABLE
CREATE TABLE EmployeePosition (
    EmployeeID INT NOT NULL,
    JobCode INT NOT NULL,
    PRIMARY KEY (EmployeeID, JobCode),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (JobCode) REFERENCES Position(JobCode) ON DELETE CASCADE
);

-- CREATE ARCHIVESRESERVATION TABLE
CREATE TABLE ArchivesReservation (
    ArchiveID SERIAL PRIMARY KEY,
    ReservationID INT,
    CheckinDate DATE NOT NULL,
    CheckoutDate DATE NOT NULL,
    ClientID INT NOT NULL,
    ClientFirstName VARCHAR(20) NOT NULL,
    ClientLastName VARCHAR(20) NOT NULL,
    ClientAddress VARCHAR(255) NOT NULL,
    ClientSSN INT NOT NULL,
    RoomID INT NOT NULL,
    RoomPrice DECIMAL(10, 2) NOT NULL,
    RoomAmenities VARCHAR(255) NOT NULL,
    RoomCapacity INT NOT NULL,
    RoomView VARCHAR(255) NOT NULL,
    RoomExtendable VARCHAR(3) NOT NULL,
    RoomIssues VARCHAR(255) NOT NULL,
    HotelID INT NOT NULL,
    HotelAddress VARCHAR(255) NOT NULL,
    HotelCity VARCHAR(255) NOT NULL,
    HotelPhoneNumber VARCHAR(20) NOT NULL,
    HotelEmail VARCHAR(100) NOT NULL,
    StarRating INT NOT NULL,
    NumberOfRooms INT NOT NULL,
    ChainID INT NOT NULL,
    ChainName VARCHAR(255) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    HeadquartersEmail VARCHAR(255) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);

-- CREATE ARCHIVESRENTAL TABLE
CREATE TABLE ArchivesRental (
    ArchiveID SERIAL PRIMARY KEY,
    RentalID INT NOT NULL,
    ReservationID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    ClientID INT NOT NULL,
    ClientFirstName VARCHAR(20) NOT NULL,
    ClientLastName VARCHAR(20) NOT NULL,
    ClientAddress VARCHAR(255) NOT NULL,
    ClientSSN INT NOT NULL,
    EmployeeID INT NOT NULL,
    EmployeeFirstName VARCHAR(20) NOT NULL,
    EmployeeLastName VARCHAR(20) NOT NULL,
    EmployeeAddress VARCHAR(255) NOT NULL,
    EmployeeSSN INT NOT NULL,
    RoomID INT NOT NULL,
    RoomPrice DECIMAL(10, 2) NOT NULL,
    RoomAmenities VARCHAR(255) NOT NULL,
    RoomCapacity INT NOT NULL,
    RoomView VARCHAR(255) NOT NULL,
    RoomExtendable VARCHAR(3) NOT NULL,
    RoomIssues VARCHAR(255) NOT NULL,
    HotelID INT NOT NULL,
    HotelAddress VARCHAR(255) NOT NULL,
    HotelCity VARCHAR(255) NOT NULL,
    HotelPhoneNumber VARCHAR(20) NOT NULL,
    HotelEmail VARCHAR(100) NOT NULL,
    StarRating INT NOT NULL,
    NumberOfRooms INT NOT NULL,
    ChainID INT NOT NULL,
    ChainName VARCHAR(255) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    HeadquartersEmail VARCHAR(255) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);
