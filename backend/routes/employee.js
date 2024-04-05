const router = require('express').Router();
const pool = require('../db');

// Make a rental
router.post('/rental', async(req, res) => {
    try {
        // destructure the req.body
        const {firstName, lastName, address, ssn, start_date, end_date, roomID, hotelID, chainID, employeeID} = req.body;

        // check if user exists 
        const user = await pool.query('SELECT * FROM client WHERE ClientSSN = $1', [ssn]);

        // check if the name and address matches the ssn
        if (user.rows.length !== 0) {
            if (user.rows[0].clientfirstname !== firstName || user.rows[0].clientlastname !== lastName || user.rows[0].clientaddress !== address) {
                return res.status(401).json('Name or Address does not match SSN');
            }
        }

        // if user does not exist then add user to the database
        if (user.rows.length === 0) {
            const newUser = await pool.query(
                'INSERT INTO client (ClientFirstName, ClientLastName, ClientAddress, RegistrationDate, ClientSSN) VALUES($1, $2, $3, $4, $5) RETURNING *', [firstName, lastName, address, start_date, parseInt(ssn)]
            );
        }
        // get the client id
        const client = await pool.query('SELECT clientid FROM client WHERE ClientSSN = $1', [ssn]);
        const clientID = client.rows[0].clientid;

        // add the rental to the database
        const newRental = await pool.query(
            'INSERT INTO rental (StartDate, EndDate, RoomID, HotelID, ChainID, EmployeeID, ClientID) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *', [start_date, end_date, roomID, hotelID, chainID, employeeID, clientID]
        );

        res.json(newRental.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// Retrieve reservation details
router.get('/reservation', async (req, res) => {
    try {
       const {reservationID} = req.query;

        // check if reservation exists
        const clientid = await pool.query('SELECT ClientID FROM reservation WHERE ReservationID = $1', [reservationID]);

        // if reservation does not exist then throw error
        if (clientid.rows.length === 0) {
            return res.status(401).json('Reservation does not exist');
        }
        // retrieve client details and reservation details
        const details = await pool.query('SELECT * FROM reservation INNER JOIN Client ON ReservationID = $1 AND Reservation.clientid = Client.clientid', [reservationID]);
        res.json(details.rows[0]);
    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
}
);

// Reservations check in
router.post('/checkin', async(req, res) => {
    try {
        // destructure the req.body
        const {reservationID, employeeID} = req.body;

        // check hotelid and chainid of the employee
        const employeehotelID = await pool.query('SELECT HotelID FROM employee WHERE EmployeeID = $1', [employeeID]);
        const employeechainID = await pool.query('SELECT ChainID FROM employee WHERE EmployeeID = $1', [employeeID]);

        // check if reservation exists
        const reservation = await pool.query('SELECT * FROM reservation WHERE ReservationID = $1', [reservationID]);

        // if reservation does not exist then throw error
        if (reservation.rows.length === 0) {
            return res.status(401).json('Reservation does not exist');
        }

        // retrieve info from the reservation
        const start_date = reservation.rows[0].checkindate;
        const end_date = reservation.rows[0].checkoutdate;
        const clientID = reservation.rows[0].clientid;
        const roomID = reservation.rows[0].roomid;
        const hotelID = reservation.rows[0].hotelid;
        const chainID = reservation.rows[0].chainid;

        // check if the employee is working at the hotel of the reservation
        if (employeehotelID.rows[0].hotelid !== hotelID || employeechainID.rows[0].chainid !== chainID) {
            return res.status(401).json('You are not authorized to check in this reservation');
        }
        
        // check if the rental already exists
        const rental = await pool.query('SELECT * FROM rental WHERE ReservationID = $1', [reservationID]);

        // if rental already exists then throw error
        if (rental.rows.length !== 0) {
            return res.status(401).json('Reservation already checked in');
        }
        
        // add the rental to the database
        const newRental = await pool.query(
            'INSERT INTO rental (StartDate, EndDate, RoomID, HotelID, ChainID, EmployeeID, ClientID, ReservationID) VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *', [start_date, end_date, roomID, hotelID, chainID, employeeID, clientID, reservationID]
        );

        res.json(newRental.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// search for rooms
router.post('/rooms', async(req, res) => {
    try {
        const {hotelID, chainID, minPrice, maxPrice, capacity, start_date, end_date} = req.body;


        // find the rooms that are available during the given time period
        let availableRooms;
        if (capacity === 'any') {
            availableRooms = await pool.query(
                'SELECT * FROM Room WHERE HotelID = $1 AND CHAINID = $2 AND RoomID NOT IN (SELECT RoomID FROM Rental WHERE (StartDate >= $5 AND EndDate <= $6)) AND RoomID NOT IN (SELECT RoomID FROM Reservation WHERE (CheckinDate >= $5 AND CheckoutDate <= $6)) AND RoomID IN (SELECT RoomID FROM Room WHERE Price >= $3 AND Price <= $4)', [hotelID, chainID, minPrice, maxPrice, start_date, end_date]
            );
        } else {
            availableRooms = await pool.query(
                'SELECT * FROM Room WHERE HotelID = $1 AND CHAINID = $2 AND RoomID NOT IN (SELECT RoomID FROM Rental WHERE (StartDate >= $6 AND EndDate <= $7)) AND RoomID NOT IN (SELECT RoomID FROM Reservation WHERE (CheckinDate >= $6 AND CheckoutDate <= $7)) AND RoomID IN (SELECT RoomID FROM Room WHERE Price >= $3 AND Price <= $4 AND Capacity = $5)', [hotelID, chainID, minPrice, maxPrice, capacity, start_date, end_date]
                );
        }

        res.json(availableRooms.rows);
    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get all the chainNames
router.get('/chain', async(req, res) => {
    try {
        const chainNames = await pool.query('SELECT ChainName FROM Chain');
        const chains = chainNames.rows.map(chain => chain.chainname);
        res.json(chains);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get all the hotelIDs
router.get('/hotel', async(req, res) => {
    try {
        const hotelIDs = await pool.query('SELECT DISTINCT HotelID FROM Hotel ORDER BY HotelID ASC');
        const hotels = hotelIDs.rows.map(hotel => hotel.hotelid);
        res.json(hotels);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get chainName from chainID
router.get('/chainID', async(req, res) => {
    try {
        const {chainID} = req.query;
        const chainName = await pool.query('SELECT ChainName FROM Chain WHERE ChainID = $1', [chainID]);
        res.json(chainName.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// update employee profile
router.put('/update', async(req, res) => {
    try {
        const {employeeID, firstName, lastName, address, email, password, ssn, hotelID, chainName} = req.body;

        // get the chainID
        const chain = await pool.query('SELECT ChainID FROM chain WHERE ChainName = $1', [chainName]);
        const chainID = chain.rows[0].chainid;

        // check if the hotelID belongs to the chainID
        const hotel = await pool.query('SELECT ChainID FROM hotel WHERE HotelID = $1', [hotelID]);

        if (hotel.rows[0].chainid !== chainID) {
            return res.status(401).json('Hotel does not belong to the chain');
        }

        const updatedEmployee = await pool.query(
            'UPDATE employee SET EmployeeFirstName = $1, EmployeeLastName = $2, EmployeeAddress = $3, EmployeeEmail = $4, EmployeePassword = $5, EmployeeSSN = $6, HotelID = $7, ChainID = $8 WHERE EmployeeID = $9 RETURNING *', [firstName, lastName, address, email, password, ssn, hotelID, chainID, employeeID]
        );

        res.json(updatedEmployee.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// delete employee profile
router.delete('/delete', async(req, res) => {
    try {
        const {employeeID} = req.query;

        // check if employee exists
        const employee = await pool.query('SELECT * FROM employee WHERE EmployeeID = $1', [employeeID]);

        // if employee does not exist then throw error
        if (employee.rows.length === 0) {
            return res.status(401).json('Employee does not exist');
        }

        const deletedEmployee = await pool.query(
            'DELETE FROM employee WHERE EmployeeID = $1 RETURNING *', [employeeID]
        );

        res.json(deletedEmployee.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get hotel information
router.get('/hotelinfo', async(req, res) => {
    try {
        const {hotelID} = req.query;

        // check if hotel exists
        const hotel = await pool.query('SELECT * FROM hotel WHERE HotelID = $1', [hotelID]);

        // if hotel does not exist then throw error
        if (hotel.rows.length === 0) {
            return res.status(401).json('Hotel does not exist');
        }

        res.json(hotel.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// update hotel information
router.put('/updatehotel', async(req, res) => {
    try {
        const {hotelID, hotelAddress, hotelCity, hotelPhoneNumber, hotelEmail, starRating, numberOfRooms} = req.body;

        const updatedHotel = await pool.query(
            'UPDATE hotel SET HotelAddress = $1, HotelCity = $2, HotelPhoneNumber = $3, HotelEmail = $4, StarRating = $5, NumberOfRooms = $6 WHERE HotelID = $7 RETURNING *', [hotelAddress, hotelCity, hotelPhoneNumber, hotelEmail, parseInt(starRating), parseInt(numberOfRooms), hotelID]
        );

        res.json(updatedHotel.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// delete hotel information
router.delete('/deletehotel', async(req, res) => {
    try {
        const {hotelID} = req.query;

        // check if hotel exists
        const hotel = await pool.query('SELECT * FROM hotel WHERE HotelID = $1', [hotelID]);

        // if hotel does not exist then throw error
        if (hotel.rows.length === 0) {
            return res.status(401).json('Hotel does not exist');
        }

        const deletedHotel = await pool.query(
            'DELETE FROM hotel WHERE HotelID = $1 RETURNING *', [hotelID]
        );

        res.json(deletedHotel.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get all rooms of a hotel
router.get('/rooms', async(req, res) => {
    try {
        const {hotelID, chainID} = req.query;

        // check if chain exists
        const chain = await pool.query('SELECT * FROM chain WHERE ChainID = $1', [chainID]);

        // check if hotel of the chain exists
        const hotel = await pool.query('SELECT * FROM hotel WHERE HotelID = $1 AND ChainID=$2', [hotelID, chainID]);

        // if chain or hotel does not exist then throw error
        if (hotel.rows.length === 0 || chain.rows.length === 0) {
            return res.status(401).json('Hotel does not exist');
        }

        const rooms = await pool.query('SELECT * FROM room WHERE HotelID = $1 AND ChainID=$2 ORDER BY RoomID', [hotelID, chainID]);
        res.json(rooms.rows);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// get specific room information
router.get('/room', async(req, res) => {
    try {
        const {roomID, hotelID, chainID} = req.query;

        // check if room exists
        const room = await pool.query('SELECT * FROM room WHERE RoomID = $1 AND HotelID = $2 AND ChainID=$3', [roomID, hotelID, chainID]);

        // if room does not exist then throw error
        if (room.rows.length === 0) {
            return res.status(401).json('Room does not exist');
        }

        res.json(room.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// delete specific room
router.delete('/deleteroom', async(req, res) => {
    try {
        const {roomID} = req.query;

        // check if room exists
        const room = await pool.query('SELECT * FROM room WHERE RoomID = $1', [roomID]);

        // if room does not exist then throw error
        if (room.rows.length === 0) {
            return res.status(401).json('Room does not exist');
        }

        const deletedRoom = await pool.query(
            'DELETE FROM room WHERE RoomID = $1 RETURNING *', [roomID]
        );

        res.json(deletedRoom.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// update specific room information
router.put('/updateroom', async(req, res) => {
    try {
        const {roomID, hotelID, chainID, price, amenities, capacity, roomView, extendable, issues} = req.body;

        const updatedRoom = await pool.query(
            'UPDATE room SET Price = $1, Amenities = $2, Capacity = $3, RoomView = $4, Extendable = $5, Issues = $6 WHERE RoomID = $7 AND HotelID = $8 AND ChainID = $9 RETURNING *', [price, amenities, capacity, roomView, extendable, issues, roomID, hotelID, chainID]
        );

        res.json(updatedRoom.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// add a new room
router.post('/addroom', async(req, res) => {
    try {
        const {hotelID, chainID, price, amenities, capacity, roomView, extendable, issues} = req.body;

        const newRoom = await pool.query(
            'INSERT INTO room (HotelID, ChainID, Price, Amenities, Capacity, RoomView, Extendable, Issues) VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *', [hotelID, chainID, price, amenities, capacity, roomView, extendable, issues]
        );

        res.json(newRoom.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});
module.exports = router;