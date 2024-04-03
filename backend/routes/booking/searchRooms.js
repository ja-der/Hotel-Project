const router = require("express").Router();
const pool = require("../../db");

router.get("/", async (req, res) => {
  try {
    const {
      arrivalDate,
      departureDate,
      roomCapacity,
      city,
      hotelChain,
      totalRooms,
      price,
      starRating,
      amenities,
      view,
    } = req.query;

    // Construct the base SQL query
    let sqlQuery = `
    SELECT 
        r.*, 
        h.HotelName,
        h.HotelCity, 
        c.ChainName
    FROM 
        Room r 
    INNER JOIN 
        Hotel h ON r.HotelID = h.HotelID
    INNER JOIN 
        Chain c ON h.ChainID = c.ChainID
`;

    // Add conditions based on form inputs
    const conditions = [];

    // Add condition for roomCapacity
    if (roomCapacity) {
      conditions.push(`r.Capacity >= ${roomCapacity}`);
    }

    // Add condition for city
    if (city) {
      conditions.push(`h.HotelCity = '${city}'`);
    }

    // Add condition for hotelChain
    if (hotelChain) {
      conditions.push(`h.ChainID = ${hotelChain}`);
    }

    // Add condition for totalRooms
    if (totalRooms) {
      conditions.push(`h.NumberOfRooms >= ${totalRooms}`);
    }

    // Add condition for price
    if (price) {
      conditions.push(`r.Price <= ${price}`);
    }

    // Add condition for starRating
    if (starRating) {
      conditions.push(`h.StarRating >= ${starRating}`);
    }

    // Add condition for amenities
    // Add condition for amenities
    if (amenities && Array.isArray(amenities) && amenities.length > 0) {
      const amenitiesConditions = amenities.map(
        (amenity) => `r.Amenities LIKE '%${amenity}%'`
      );
      conditions.push(`(${amenitiesConditions.join(" OR ")})`);
    }

    // Add condition for view
    if (view) {
      conditions.push(`r.View = '${view}'`);
    }

    // Add condition to check for room availability during specified dates
    if (arrivalDate && departureDate) {
      conditions.push(`
        r.RoomID NOT IN (
          SELECT RoomID 
          FROM Reservation 
          WHERE (CheckInDate <= '${departureDate}' AND CheckOutDate >= '${arrivalDate}')
        )
      `);
    }

    // Construct the final query
    if (conditions.length > 0) {
      sqlQuery += ` WHERE ${conditions.join(" AND ")}`;
    }
    // Execute the query and return the result
    const queryResult = await pool.query(sqlQuery);
    console.log(queryResult.rows);
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error searching rooms:", err);
    res.status(500).send("Server error");
  }
});

module.exports = router;
