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
        if (employeehotelID !== hotelID || employeechainID !== chainID) {
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

module.exports = router;