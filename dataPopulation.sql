
-- POPULATING DATABASE SHOULD BE THE LAST THING THAT IS IMPLEMENTED
-- basically complete everything else in the project first, then populate the database with data
-- changing the fields is very difficult once the data is populated
-- very time consuming to change the fields and the data

/*
--------------------------------------------------------------
Chain 1
--------------------------------------------------------------
*/
-- Insert data for Chain 1
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) 
VALUES ('Chain 1', '123 Main Street, City1, Countryhq1@example.com', '+1231', 8, '4567890');

-- Insert data for Chain 1 Hotels
INSERT INTO Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID)
VALUES 
    ('123 Hotel Ave, City1', 'Country1', '+1234567890', 'hotel1@example.com', 4, 50, 1), -- Hotel 1
    ('456 Resort St, City2, Country1', '+1234567890', 'resort1@example.com', 5, 100, 1), -- Hotel 2
    ('789 Lodge Blvd, City3, Country2', '+1234567890', 'lodge1@example.com', 3, 80, 1), -- Hotel 3
    ('987 Inn Ln, City4, Country2', '+1234567890', 'inn1@example.com', 4, 120, 1), -- Hotel 4
    ('543 Motel Rd, City5, Country3', '+1234567890', 'motel1@example.com', 2, 60, 1), -- Hotel 5
    ('654 Plaza Dr, City6, Country3', '+1234567890', 'plaza1@example.com', 3, 90, 1), -- Hotel 6
    ('876 Villa Ave, City7, Country4', '+1234567890', 'villa1@example.com', 4, 110, 1), -- Hotel 7
    ('210 Retreat Blvd, City8, Country4', '+1234567890', 'retreat1@example.com', 5, 150, 1); -- Hotel 8

-- Insert data for rooms in each hotel
-- Hotel 1 Rooms
INSERT INTO Room (Price, Amenities, Capacity, View, Extendable, Issues, HotelID, ChainID)
VALUES
   -- hotel 1
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 1, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 1, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 1, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 1, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 1, 1), -- Room 5
    -- hotel 2
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 2, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 2, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 2, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 2, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 2, 1), -- Room 5
    -- hotel 3
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 3, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 3, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 3, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 3, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 3, 1), -- Room 5
    -- hotel 4
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 4, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 4, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 4, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 4, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 4, 1), -- Room 5
    -- hotel 5
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 5, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 5, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 5, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 5, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 5, 1), -- Room 5
    -- hotel 6
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 6, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 6, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 5, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 6, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 6, 1), -- Room 5
    -- hotel 7
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 7, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 7, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 7, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 7, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 7, 1), -- Room 5
    -- hotel 8
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 8, 1), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 8, 1), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 8, 1), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 8, 1), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 8, 1) -- Room 5
;

-- Insert data for Clients
INSERT INTO Client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword)
VALUES 
    ('John', 'Doe', '123 Client St, City1, Country1', 123456789, '2024-03-26', 'johndoe@gmail.com', 'password123'),
    ('Jane', 'Smith', '456 Client Ave, City2, Country1', 987654321, '2024-03-27', 'janesmith@gmail.com', 'password123')
;

-- Insert data for Employees
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeSSN, EmployeeRole, HotelID, ChainID)
VALUES 
    ('Alice', 'Johnson', '123 Employee St, City1, Country1', 111111111, 'Manager', 1, 1),
    ('Bob', 'Smith', '456 Employee Ave, City2, Country1', 222222222, 'Front Desk Clerk', 1, 1)
    
;

-- Insert data for Reservations
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES 
    ('2024-04-01', '2024-04-05', 1, 1, 1), -- Client John Doe reserves Hotel 1 Room 1
    ('2024-04-02', '2024-04-06', 2, 2, 2) -- Client Jane Smith reserves Hotel 2 Room 2
;

-- Insert data for Positions
INSERT INTO Position (JobTitle, Responsibilities, Level, EmployeeID)
VALUES 
    ('Manager', 'Oversee hotel operations', 1, 1), -- Manager position at Hotel 1
    ('Front Desk Clerk', 'Assist guests with check-in and check-out', 2, 1) -- Front Desk Clerk position at Hotel 1
;

/*
--------------------------------------------------------------
Chain 2
--------------------------------------------------------------
*/

-- Insert data for Chain 2
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) 
VALUES ('Chain 2', '456 Elm Street, City2, Country2', 8, 'hq2@example.com', '+1234567890');

-- Insert data for Chain 2 Hotels
INSERT INTO Hotel (HotelAddress, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID)
VALUES 
    ('123 Resort Ave, City1, Country2', '+1234567890', 'resort2@example.com', 4, 50, 2), -- Hotel 1
    ('456 Lodge St, City2, Country2', '+1234567890', 'lodge2@example.com', 5, 100, 2), -- Hotel 2
    ('789 Inn Blvd, City3, Country2', '+1234567890', 'inn2@example.com', 3, 80, 2), -- Hotel 3
    ('987 Motel Ln, City4, Country2', '+1234567890', 'motel2@example.com', 4, 120, 2), -- Hotel 4
    ('543 Plaza Rd, City5, Country2', '+1234567890', 'plaza2@example.com', 2, 60, 2), -- Hotel 5
    ('654 Villa Dr, City6, Country2', '+1234567890', 'villa2@example.com', 3, 90, 2), -- Hotel 6
    ('876 Retreat Ave, City7, Country2', '+1234567890', 'retreat2@example.com', 4, 110, 2), -- Hotel 7
    ('210 Beach Blvd, City8, Country2', '+1234567890', 'beach2@example.com', 5, 150, 2); -- Hotel 8

-- Insert data 5 rooms in each hotel in Chain 2
-- Hotel 2 Rooms
INSERT INTO Room (Price, Amenities, Capacity, View, Extendable, Issues, HotelID, ChainID)
VALUES
    -- hotel 1
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 1, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 1, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 1, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 1, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 1, 2), -- Room 5
    -- hotel 2
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 2, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 2, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 2, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 2, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 2, 2), -- Room 5
    -- hotel 3
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 3, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 3, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 3, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 3, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 3, 2), -- Room 5
    -- hotel 4
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 4, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 4, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 4, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 4, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 4, 2), -- Room 5
    -- hotel 5
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 5, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 5, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 5, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 5, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 5, 2), -- Room 5
    -- hotel 6
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 6, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 6, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 5, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 6, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 6, 2), -- Room 5
    -- hotel 7
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 7, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 7, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 7, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 7, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 7, 2), -- Room 5
    -- hotel 8
    (100.00, 'Wi-Fi, TV, AC', 2, 'City view', 'Yes', NULL, 8, 2), -- Room 1
    (150.00, 'Wi-Fi, TV, AC, Mini Fridge', 4, 'Ocean view', 'No', NULL, 8, 2), -- Room 2
    (120.00, 'Wi-Fi, TV, AC', 5, 'City view', 'Yes', NULL, 8, 2), -- Room 3
    (200.00, 'Wi-Fi, TV, AC, Kitchenette', 3, 'Mountain view', 'No', NULL, 8, 2), -- Room 4
    (180.00, 'Wi-Fi, TV, AC, Balcony', 1, 'City view', 'Yes', NULL, 8, 2) -- Room 5
;


-- Insert data for Clients for Chain 2
INSERT INTO Client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword)
VALUES 
    ('Michael', 'Brown', '123 Client St, City1, Country2', 111111111, '2024-03-28', 'michael@gmail.com', 'password123'),
    ('Jennifer', 'Davis', '456 Client Ave, City2, Country2', 222222222, '2024-03-29', 'davis@gmail.com', 'password123')
;

-- Insert data for Employees for Chain 2
INSERT INTO Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeSSN, EmployeeRole, HotelID, ChainID)
VALUES 
    ('David', 'Wilson', '123 Employee St, City1, Country2', 333333333, 'Manager', 1, 2),
    ('Jessica', 'Martinez', '456 Employee Ave, City2, Country2', 444444444, 'Front Desk Clerk', 1, 2)
;

-- Insert data for Reservations for Chain 2
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID)
VALUES 
    ('2024-04-03', '2024-04-07', 1, 1, 1), -- Client Michael Brown reserves Hotel 1 Room 1
    ('2024-04-04', '2024-04-08', 2, 2, 2) -- Client Jennifer Davis reserves Hotel 2 Room 2
;
