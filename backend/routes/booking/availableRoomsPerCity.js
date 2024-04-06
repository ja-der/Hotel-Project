const router = require("express").Router();
const pool = require("../../db");

router.get("/", async (req, res) => {
  try {
    // Fetch data from the existing view
    const fetchDataQuery = "SELECT * FROM AvailableRoomsPerCity";
    const queryResult = await pool.query(fetchDataQuery);
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying available rooms:", err);
    res.status(500).send("Server error");
  }
});

module.exports = router;
