-- Nous devons stocker dans la base de données l’historique des 
-- réservations et des locations (archives), mais nous n’avons pas besoin de stocker l’historique 
-- des paiements. Les informations sur une ancienne réservation / location de chambre 
-- (archivée) doivent exister dans la base de données, même si les informations sur la chambre 
-- elle-même n’existent plus dans la base de données.

-- Surppprimer base de donnes des chaines, 

/*
--------------------------------------------------------------
Drop Table Queries
--------------------------------------------------------------
*/
-- Start by dropping tables with foreign keys referencing them
DROP TABLE IF EXISTS ArchivesRental;
DROP TABLE IF EXISTS ArchivesReservation;
DROP TABLE IF EXISTS EmployeePosition;
DROP TABLE IF EXISTS Rental;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Position;

-- Then drop the tables that these tables reference
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS Chain;

DROP VIEW IF EXISTS AvailableRoomsPerCity;
DROP VIEW IF EXISTS HotelRoomCapacities;
/*
--------------------------------------------------------------
Queries (Au moins 4 Requetes)
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
UPDATE Hotel SET HotelAddress = 'New Address', HotelCity = 'New City' WHERE HotelID = 1;

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
CREATE VIEW AvailableRoomsPerCity AS
SELECT
    HotelCity,
    COUNT(Room.RoomID) AS AvailableRooms
FROM
    Hotel
LEFT JOIN
    Room ON Hotel.HotelID = Room.HotelID
LEFT JOIN
    Reservation ON Room.RoomID = Reservation.RoomID
WHERE
    Reservation.RoomID IS NULL
GROUP BY
    HotelCity;


--Capacity of All Rooms in a Specific Hotel
CREATE VIEW RoomCapacityPerHotel AS
SELECT h.HotelID,
       h.HotelName,
       SUM(r.Capacity) AS TotalCapacity
FROM Hotel h
JOIN Room r ON h.HotelID = r.HotelID
GROUP BY h.HotelID, h.HotelName;
