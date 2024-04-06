// Will find hotel capacity from created view RoomCapacityPerHotel
const router = require("express").Router();
const pool = require("../../db");

router.get("/", async (req, res) => {
  try {
    const { chainName } = req.query;

    // Check if chainName is provided
    if (!chainName) {
      return res.status(400).json({ error: "Chain name is required" });
    }

    // Fetch data from the existing view for the specified chain
    const fetchDataQuery = `
      SELECT * FROM HotelRoomCapacities;
    `;
    const queryResult = await pool.query(fetchDataQuery, [chainName]);
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying hotel capacity:", err);
    res.status(500).send("Server error");
  }
});

module.exports = router;
