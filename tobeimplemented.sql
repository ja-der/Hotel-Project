/*
--------------------------------------------------------------
Table Creation Queries
APPLY QUERIES IN ORDER (or else it won't work)
--------------------------------------------------------------
*/
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