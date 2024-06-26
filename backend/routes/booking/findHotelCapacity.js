// Will find hotel capacity from created view RoomCapacityPerHotel
const router = require("express").Router();
const pool = require("../../db");

router.get("/", async (req, res) => {
  try {
    const fetchDataQuery = "SELECT * FROM HotelRoomCapacities";
    const queryResult = await pool.query(fetchDataQuery);
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying hotel capacity:", err);
    res.status(500).send("Server error");
  }
});

module.exports = router;
