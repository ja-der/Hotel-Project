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
      starRating,
      amenities,
      view,
      minPrice,
      maxPrice, // Include minPrice and maxPrice
    } = req.query;

    // Construct the base SQL query
    let sqlQuery = `
    SELECT 
        r.*, 
        h.HotelID,
        h.HotelCity, 
        h.HotelAddress,
        h.HotelPhoneNumber,
        h.StarRating,
        c.ChainName
    FROM 
        Room r 
    INNER JOIN 
        Hotel h ON r.HotelID = h.HotelID
    INNER JOIN 
        Chain c ON r.ChainID = c.ChainID
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
      conditions.push(`c.ChainName = '${hotelChain}'`);
    }

    // Add condition for totalRooms
    if (totalRooms) {
      conditions.push(`h.NumberOfRooms >= ${totalRooms}`);
    }

    // Add condition for price range
    if (minPrice) {
      conditions.push(`r.Price >= ${minPrice}`);
    }
    if (maxPrice) {
      conditions.push(`r.Price <= ${maxPrice}`);
    }

    // Add condition for starRating
    if (starRating) {
      conditions.push(`h.StarRating >= ${starRating}`);
    }

    if (amenities && typeof amenities === "string" && amenities.trim() !== "") {
      // Split the string into an array using comma as the delimiter
      const amenitiesArray = amenities.split(",").map((item) => item.trim());

      // Map each amenity in the array to a condition
      const amenitiesConditions = amenitiesArray.map(
        (amenity) => `r.Amenities LIKE '%${amenity}%'`
      );

      // Add the conditions to the overall conditions array
      conditions.push(`(${amenitiesConditions.join(" AND ")})`);
    }

    // Add condition for view
    if (view) {
      conditions.push(`r.RoomView = '${view}'`);
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
