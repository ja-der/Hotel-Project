const router = require("express").Router();
const pool = require("../../db");

router.get("/", async (req, res) => {
  try {
    const { arrivalDate, roomCapacity, area, hotelChain, totalRooms, price } =
      req.query;

    // Construct the base SQL query
    let sqlQuery = `SELECT * FROM Room`;

    // Add conditions based on form inputs
    const conditions = [];
    if (arrivalDate) {
      conditions.push(
        `RoomID NOT IN (SELECT RoomID FROM Reservation WHERE CheckInDate = '${arrivalDate}')`
      );
    }
    if (roomCapacity) {
      conditions.push(`Capacity >= ${roomCapacity}`);
    }
    if (area) {
      conditions.push(`HotelAddress = '${area}'`);
    }
    if (hotelChain) {
      conditions.push(`ChainID = ${hotelChain}`);
    }
    if (totalRooms) {
      conditions.push(`NumberOfRooms >= ${totalRooms}`);
    }
    if (price) {
      conditions.push(`Price <= ${price}`);
    }

    // Add WHERE clause if conditions exist
    if (conditions.length > 0) {
      sqlQuery += ` WHERE ${conditions.join(" AND ")}`;
    }

    // Execute the query and return the result
    const queryResult = await pool.query(sqlQuery);
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error searching hotels:", err);
    res.status(500).send("Server error");
  }
});

module.exports = router;
