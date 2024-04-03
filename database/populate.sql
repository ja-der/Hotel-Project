CREATE DATABASE ehotel;

-- CREATE CHAINS TABLE
CREATE TABLE Chain (
    ChainID SERIAL PRIMARY KEY,
    ChainName VARCHAR(255) NOT NULL,
    HeadquartersAddress VARCHAR(255) NOT NULL,
    NumberOfHotels INT NOT NULL,
    HeadquartersEmail VARCHAR(255) NOT NULL,
    HeadquartersPhoneNumber VARCHAR(20) NOT NULL
);

-- INSERT CHAINS DATA
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Schimmel-Zieme', '6 Springview Avenue', 8, 'schimmelzieme@gmail.com', '213-858-2040');
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Walsh and Sons', '406 Duke Junction', 8, 'walshandsons@gmail.com', '230-349-0576');
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Halvorson-Hettinger', '594 Milwaukee Avenue', 8, 'halvorson_hettinger@gmail.com', '212-486-6750');
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Goyette Group', '491 Iowa Road', 8, 'info@goyette.com', '320-980-6866');
INSERT INTO Chain (ChainName, HeadquartersAddress, NumberOfHotels, HeadquartersEmail, HeadquartersPhoneNumber) VALUES ('Jaskolski Inc', '06684 Roth Point', 8, 'contact@jaskolski.com', '426-791-7238');

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
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

-- INSERT HOTEL DATA FOR CHAIN 1
INSERT INTO Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID)
VALUES
    ('123 Main Street', 'New York', '123-456-7890', 'hotel1@schimmelzieme.com', 4, 5, 1),
    ('456 Oak Avenue', 'Los Angeles', '987-654-3210', 'hotel2@examschimmelziemeple.com', 3, 5, 1),
    ('789 Elm Drive', 'Chicago', '555-555-5555', 'hotel3@schimmelzieme.com', 5, 5, 1),
    ('101 Pine Lane', 'New York', '111-222-3333', 'hotel4@schimmelzieme.com', 4, 5, 1),
    ('202 Maple Street', 'Boston', '444-444-4444', 'hotel5@schimmelzieme.com', 3, 5, 1),
    ('303 Cedar Avenue', 'San Francisco', '777-888-9999', 'hotel6@schimmelzieme.com', 4, 5, 1),
    ('404 Birch Road', 'Los Angele', '333-333-3333', 'hotel7@schimmelzieme.com', 3, 5, 1),
    ('505 Walnut Circle', 'Boston', '666-777-8888', 'hotel8@schimmelzieme.com', 5, 5, 1);

-- INSERT HOTEL DATA FOR CHAIN 2
INSERT INTO Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID) 
VALUES 
    ('18 Bashford Trail', 'Santa Cruz', '321-201-3503', 'hotel1@walshandsons.com', 1, 5, 2),
    ('436 Namekagon Point', 'Santa Cruz', '173-161-4827', 'hotel2@walshandsons.com', 3, 5, 2),
    ('86930 Susan Crossing', 'Toronto', '713-150-3950', 'hotel3@walshandsons.com', 4, 5, 2),
    ('10 Arkansas Plaza', 'Toronto', '167-369-8443', 'hotel4@walshandsons.com', 1, 5, 2),
    ('84681 Bunker Hill Park', 'Montreal', '817-743-5582', 'hotel5@walshandsons.com', 1, 5, 2),
    ('83649 Sheridan Place', 'Montreal', '624-548-0784', 'hotel6@walshandsons.com', 4, 5, 2),
    ('11371 Larry Drive', 'Montreal', '967-970-2455', 'hotel7@walshandsons.com', 2, 5, 2),
    ('031 Waywood Circle', 'Vancouver', '810-196-7148', 'hotel8@walshandsons.com', 2, 5, 2);

-- INSERT HOTEL DATA FOR CHAIN 3
INSERT INTO Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID) 
VALUES 
    ('98933 Artisan Terrace', 'Seattle', '202-102-9343', 'hotel1@halvorson_hettinger.com', 3, 5, 3),
    ('39770 Everett Court', 'Seattle', '588-471-1937', 'hotel2@halvorson_hettinger.com', 4, 5, 3),
    ('0785 Warbler Drive', 'Calgary', '470-180-9071', 'hotel3@halvorson_hettinger.com', 3, 5, 3),
    ('4 Corben Junction', 'Calgary', '899-324-9669', 'hotel4@halvorson_hettinger.com', 3, 5, 3),
    ('12247 Judy Park', 'Calgary', '145-417-6042', 'hotel5@halvorson_hettinger.com', 2, 5, 3),
    ('6 Sutherland Place', 'Ottawa', '195-978-9018', 'hotel6@halvorson_hettinger.com', 5, 5, 3),
    ('439 Dennis Junction', 'Ottawa', '858-386-7379', 'hotel7@halvorson_hettinger.com', 3, 5, 3),
    ('6 Sutherland Place', 'Ottawa', '195-978-9018', 'hotel8@halvorson_hettinger.com', 5, 5, 3);

-- INSERT HOTEL DATA FOR CHAIN 4
INSERT INTO  Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID) 
VALUES 
    ('559 Meadow Valley Parkway', 'Boston', '501-999-1561', 'hotel1@goyette.com', 4, 5, 4),
    ('1 Dexter Trail', 'Boston', '325-499-9872', 'hotel2@goyette.com', 5, 5, 4),
    ('4 Porter Junction', 'Boston', '210-837-4802', 'hotel3@goyette.com', 2, 5, 4),
    ('44 Bartillon Place', 'Chicago', '474-336-5222', 'hotel4@goyette.com', 2, 5, 4),
    ('55159 Meadow Vale Place', 'Chicago', '233-713-1707', 'hotel5@goyette.com', 4, 5, 4),
    ('00217 Memorial Drive', 'Chicago', '923-122-2988', 'hotel6@goyette.com', 3, 5, 4),
    ('6003 Harbort Alley', 'Chicago', '581-182-5233', 'hotel7@goyette.com', 4, 5, 4),
    ('529 Stone Corner Circle', 'Miami', '713-385-1886', 'hotel8@goyette.com', 1, 5, 4);

-- INSERT HOTEL DATA FOR CHAIN 5
INSERT INTO  Hotel (HotelAddress, HotelCity, HotelPhoneNumber, HotelEmail, StarRating, NumberOfRooms, ChainID) 
VALUES 
    ('2492 Village Green Circle', 'Quebec', '236-158-8589', 'hotel1@jaskolski.com', 5, 5, 5),
    ('61525 Esker Point', 'Quebec', '227-964-6536', 'hotel2@jaskolski.com', 2, 5, 5),
    ('1887 Hagan Parkway', 'Montreal', '500-818-3515', 'hotel3@jaskolski.com', 3, 5, 5),
    ('96 Northport Pass', 'Montreal', '246-832-3503', 'hotel4@jaskolski.com', 1, 5, 5),
    ('8641 Bonner Parkway', 'Ottawa', '323-528-1787', 'hotel5@jaskolski.com', 3, 5, 5),
    ('3029 Autumn Leaf Hill', 'Ottawa', '975-244-8235', 'hotel6@jaskolski.com', 4, 5, 5),
    ('3106 Westend Junction', 'Kingston', '436-398-5997', 'hotel7@jaskolski.com', 1, 5, 5),
    ('28 Ridgeview Trail', 'Kingston', '500-801-2838', 'hotel8@jaskolski.com', 1, 5, 5);

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
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

-- INSERT ROOM DATA FOR CHAIN 1
-- HOTEL 1
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 1, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 1, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 1, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 1, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 1, 1);

-- HOTEL 2
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 2, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 2, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'No hot water', 2, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 2, 1);

-- HOTEL 3
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 3, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 3, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 3, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 3, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 3, 1);

-- HOTEL 4
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 4, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'None', 4, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 4, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 4, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 4, 1);

-- HOTEL 5
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 5, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 5, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 5, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 5, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'None', 5, 1);

-- HOTEL 6
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 6, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 6, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 6, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 6, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 6, 1);

-- HOTEL 7
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 7, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 7, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 7, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'Broken TV', 7, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 7, 1);

-- HOTEL 8
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 8, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 8, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 8, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 8, 1);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 8, 1);

-- INSERT ROOM DATA FOR CHAIN 2
-- HOTEL 1
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 1, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 1, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 1, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 1, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 1, 2);

-- HOTEL 2
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 2, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 2, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'No hot water', 2, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 2, 2);

-- HOTEL 3
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 3, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 3, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 3, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 3, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 3, 2);

-- HOTEL 4
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 4, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'None', 4, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 4, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 4, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 4, 2);

-- HOTEL 5
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 5, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 5, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 5, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 5, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'None', 5, 2);

-- HOTEL 6
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 6, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 6, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 6, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 6, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 6, 2);

-- HOTEL 7
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 7, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 7, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 7, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'Broken TV', 7, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 7, 2);

-- HOTEL 8
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 8, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 8, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 8, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 8, 2);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 8, 2);

-- INSERT ROOM DATA FOR CHAIN 3
-- HOTEL 1
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 1, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 1, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 1, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 1, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 1, 3);

-- HOTEL 2
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 2, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 2, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'No hot water', 2, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 2, 3);

-- HOTEL 3
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 3, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 3, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 3, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 3, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 3, 3);

-- HOTEL 4
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 4, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'None', 4, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 4, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 4, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 4, 3);

-- HOTEL 5
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 5, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 5, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 5, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 5, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'None', 5, 3);

-- HOTEL 6
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 6, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 6, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 6, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 6, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 6, 3);

-- HOTEL 7
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 7, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 7, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 7, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'Broken TV', 7, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 7, 3);

-- HOTEL 8
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 8, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 8, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 8, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 8, 3);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 8, 3);

-- INSERT ROOM DATA FOR CHAIN 4
-- HOTEL 1
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 1, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 1, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 1, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 1, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 1, 4);

-- HOTEL 2
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 2, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 2, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'No hot water', 2, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 2, 4);

-- HOTEL 3
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 3, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 3, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 3, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 3, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 3, 4);

-- HOTEL 4
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 4, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'None', 4, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 4, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 4, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 4, 4);

-- HOTEL 5
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 5, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 5, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 5, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 5, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'None', 5, 4);

-- HOTEL 6
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 6, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 6, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 6, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 6, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 6, 4);

-- HOTEL 7
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 7, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 7, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 7, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'Broken TV', 7, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 7, 4);

-- HOTEL 8
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 8, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 8, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 8, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 8, 4);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 8, 4);

-- INSERT ROOM DATA FOR CHAIN 5
-- HOTEL 1
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 1, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 1, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 1, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 1, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 1, 5);

-- HOTEL 2
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 2, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 2, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'No hot water', 2, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 2, 5);

-- HOTEL 3
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 3, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 3, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'None', 3, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 3, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 3, 5);

-- HOTEL 4
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 4, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'None', 4, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'None', 4, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 4, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'Faulty AC', 4, 5);

-- HOTEL 5
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'None', 5, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 5, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 5, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 5, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'None', 5, 5);

-- HOTEL 6
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 6, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 6, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 6, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 6, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 6, 5);

-- HOTEL 7
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (312.73, 'Wi-Fi, AC, Mini Fridge', 3, 'Ocean View', 'No', 'No hot water', 7, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (395.42, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 5, 'Mountain View', 'No', 'None', 7, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (131.98, 'Wi-Fi, AC, Mini Fridge', 1, 'Ocean View', 'No', 'Broken TV', 7, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (331.3, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'Broken TV', 7, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (154.3, 'Wi-Fi, AC, Mini Fridge, TV', 2, 'Ocean View', 'No', 'Faulty AC', 7, 5);

-- HOTEL 8
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (165.06, 'Wi-Fi, AC, Mini Fridge', 1, 'Mountain View', 'No', 'None', 8, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (382.77, 'Wi-Fi, AC, Mini Fridge, Kitchenette', 5, 'Ocean View', 'Yes', 'Clogged sink', 8, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (227.99, 'Wi-Fi, AC, Mini Fridge, TV', 3, 'Mountain View', 'Yes', 'Faulty AC', 8, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (341.67, 'Wi-Fi, AC, Mini Fridge, TV, Balcony', 4, 'Mountain View', 'Yes', 'None', 8, 5);
INSERT INTO Room (Price, Amenities, Capacity, RoomView, Extendable, Issues, HotelID, ChainID) VALUES (243.02, 'Wi-Fi, AC, Mini Fridge, TV, Coffee Maker', 2, 'Ocean View', 'No', 'None', 8, 5);



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

-- INSERT CLIENT DATA
INSERT INTO Client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword) VALUES ('Lea', 'De Cruze', '5083 Westport Junction', '294676900', '2024-04-03', 'ldecruze0@nps.gov', '$2b$10$mmnQAu66wWWHhxVqpMXXJ.1wlLll/Qyp9P4z6mAqdIFda8Oa17gIi');
INSERT INTO Client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword) VALUES ('Red', 'Galiero', '1139 Novick Road', '322803219', '2024-04-03', 'rgaliero1@answers.com', '$2b$10$P/sFOzclauQABqTMZZJfZuUWSXz4KeCxaT0fifqUQYZPOKi68pgG.');
INSERT INTO Client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword) VALUES ('Philip', 'Ubank', '1 Warrior Road', '535798918', '2024-04-03', 'pubank2@narod.ru', '$2b$10$40lFuv9H2tp0T7mIqxW6t.8amRdAwE2dx69264QluBUgVBqfHK79m');

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

-- INSERT RESERVATION DATA
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) values ('2023-12-02', '2023-12-10', 1, 1, 2, 1);
insert into Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) values ('2024-01-21', '2024-02-01', 2, 2, 3, 2);
insert into Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) values ('2024-05-24', '2023-05-30', 3, 3, 4, 3);
INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) values ('2023-12-02', '2023-12-10', 1, 4, 5, 4);
insert into Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) values ('2024-01-21', '2024-02-01', 2, 5, 1, 5);


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
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

-- INSERT EMPLOYEE DATA
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Frieda', 'Newcom', '71160 Prairie Rose Park', 'fnewcom0@cpanel.net', 'password', '137234687', 1, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Packston', 'Shortland', '82 Clyde Gallagher Plaza', 'pshortland1@pinterest.com', 'password', '375321765', 2, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Lizzie', 'Fairholme', '2 Ridgeview Street', 'lfairholme2@t-online.de', 'password', '376687958', 3, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Freeman', 'Wadesworth', '2501 Laurel Place', 'fwadesworth3@linkedin.com', 'password', '599080981', 4, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Ricoriki', 'Flatte', '97 Pennsylvania Center', 'rflatte4@nsw.gov.au', 'password', '836880559', 5, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Chere', 'Jacombs', '20 Commercial Junction', 'cjacombs5@slate.com', 'password', '186557489', 6, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Vita', 'Gledstane', '21127 Lake View Plaza', 'vgledstane6@guardian.co.uk', 'password', '514906769', 7, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Mabel', 'Tandey', '5 Thompson Center', 'mtandey7@seattletimes.com', 'password', '624209190', 8, 1);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Miran', 'Shambrooke', '7860 Fulton Crossing', 'mshambrooke0@businessinsider.com', 'password', '545108078', 1, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Zulema', 'Harflete', '33 Scofield Court', 'zharflete1@mysql.com', 'password', '918911594', 2, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Dorelle', 'Shyres', '39917 Fuller Center', 'dshyres2@rambler.ru', 'password', '074317452', 3, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Rocky', 'MacKniely', '38 Calypso Place', 'rmackniely3@abc.net.au', 'password', '485806234', 4, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Luz', 'Garvagh', '190 Dexter Lane', 'lgarvagh4@tamu.edu', 'password', '708251533', 5, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Flo', 'Dawdary', '2 Kropf Point', 'fdawdary5@thetimes.co.uk', 'password', '731901329', 6, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Fanni', 'Towsey', '70744 Katie Plaza', 'ftowsey6@indiegogo.com', 'password', '646017962', 7, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Wynn', 'Tarburn', '08998 Rutledge Park', 'wtarburn7@ovh.net', 'password', '047202097', 8, 2);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Beverly', 'Rodway', '3 Bunker Hill Plaza', 'brodway0@360.cn', 'password', '062481855', 1, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Ferris', 'Holyland', '4045 Everett Trail', 'fholyland1@wired.com', 'password', '441394066', 2, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Elysia', 'Woodley', '209 Lakewood Gardens Drive', 'ewoodley2@howstuffworks.com', 'password', '405191255', 3, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Dominique', 'Watmough', '6 Weeping Birch Pass', 'dwatmough3@bravesites.com', 'password', '280000069', 4, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Rochelle', 'Mikalski', '9 Anzinger Avenue', 'rmikalski4@tiny.cc', 'password', '730408329', 5, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Micheline', 'Meckiff', '26 Clove Terrace', 'mmeckiff5@nymag.com', 'password', '249416535', 6, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Ruy', 'Carbert', '71648 Manufacturers Trail', 'rcarbert6@ustream.tv', 'password', '040566449', 7, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Sibylle', 'Gatchell', '7874 West Circle', 'sgatchell7@usda.gov', 'password', '928849536', 8, 3);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Karmen', 'Cuddehy', '9348 Magdeline Parkway', 'kcuddehy0@purevolume.com', 'password', '539669359', 1, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Alleen', 'Klamman', '86 Carpenter Drive', 'aklamman1@hubpages.com', 'password', '256968058', 2, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Gan', 'Moxon', '0923 Bonner Crossing', 'gmoxon2@mit.edu', 'password', '860151096', 3, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Cicely', 'Bernardotte', '2994 Namekagon Alley', 'cbernardotte3@ibm.com', 'password', '212703229', 4, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Duff', 'Gary', '9273 Pleasure Street', 'dgary4@nature.com', 'password', '529487362', 5, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Evelina', 'Yglesia', '79813 Weeping Birch Pass', 'eyglesia5@reference.com', 'password', '983235964', 6, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Inge', 'Huyhton', '28 Muir Alley', 'ihuyhton6@nytimes.com', 'password', '869582773', 7, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Dniren', 'Itzhaiek', '18 Helena Crossing', 'ditzhaiek7@mit.edu', 'password', '882522162', 8, 4);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Bren', 'Jobbins', '5 Village Pass', 'bjobbins0@github.com', 'password', '523980885', 1, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Thorin', 'Prayer', '68635 Birchwood Junction', 'tprayer1@irs.gov', 'password', '498674297', 2, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Jeannie', 'Roxbrough', '29 Summit Way', 'jroxbrough2@godaddy.com', 'password', '030370605', 3, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Napoleon', 'Matignon', '75 Hovde Crossing', 'nmatignon3@noaa.gov', 'password', '600074118', 4, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Tamqrah', 'Caldaro', '9675 Shopko Crossing', 'tcaldaro4@japanpost.jp', 'password', '487233969', 5, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Garry', 'Redit', '709 Ruskin Road', 'gredit5@cbsnews.com', 'password', '161863745', 6, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Guthry', 'Gehricke', '1 Farragut Drive', 'ggehricke6@theglobeandmail.com', 'password', '295802133', 7, 5);
insert into Employee (EmployeeFirstName, EmployeeLastName, EmployeeAddress, EmployeeEmail, EmployeePassword, EmployeeSSN, HotelID, ChainID) values ('Abbie', 'Parkyns', '9 Reindahl Alley', 'aparkyns7@list-manage.com', 'password', '067912089', 8, 5);

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

-- INSERT RENTAL DATA
insert into Rental (StartDate, EndDate, EmployeeID, ClientID, HotelID, RoomID, ChainID, ReservationID) values ('2024-02-04', '2024-03-23', 1, 2, 1, 3, 1, null);
insert into Rental (StartDate, EndDate, EmployeeID, ClientID, HotelID, RoomID, ChainID, ReservationID) values ('2024-02-04', '2024-03-30', 1, 3, 1, 4, 1, null);

CREATE TABLE Position (
    JobCode SERIAL PRIMARY KEY,
    JobTitle VARCHAR(255) NOT NULL,
    Responsibilities VARCHAR(1000),
    JobLevel INT,
    HotelID INT NOT NULL,
    ChainID INT NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    FOREIGN KEY (ChainID) REFERENCES Chain(ChainID)
);

-- INSERT POSITION DATA
INSERT INTO Position (JobTitle, Responsibilities, JobLevel, HotelID, ChainID)
VALUES 
('General Manager', 'Oversee all hotel operations', 1, 1, 1),
('Front Desk Clerk', 'Check-in/check-out guests, answer queries', 2, 1, 1),
('Housekeeping', 'Clean and maintain guest rooms', 2, 2, 2),
('Chef', 'Prepare and cook meals for hotel guests', 2, 2, 2),
('Waiter/Waitress', 'Serve food and beverages to restaurant guests', 2, 3, 3);


CREATE TABLE EmployeePosition (
    EmployeeID INT NOT NULL,
    JobCode INT NOT NULL,
    PRIMARY KEY (EmployeeID, JobCode),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (JobCode) REFERENCES Position(JobCode)
);

-- INSERT EMPLOYEE POSITION DATA
INSERT INTO EmployeePosition (EmployeeID, JobCode) VALUES (1, 1);
INSERT INTO EmployeePosition (EmployeeID, JobCode) VALUES (1, 2);



