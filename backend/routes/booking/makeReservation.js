const router = require("express").Router();
const pool = require("../../db");

router.post("/", async (req, res) => {
  const { arrivalDate, departureDate, clientId, hotelId, roomId, chainId } =
    req.body;
  try {
    const client = await pool.connect();
    const result = await client.query(
      "INSERT INTO Reservation (CheckInDate, CheckOutDate, ClientID, HotelID, RoomID, ChainID) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *",
      [arrivalDate, departureDate, clientId, hotelId, roomId, chainId]
    );
    client.release();
    res
      .status(200)
      .json({ success: true, message: "Reservation booked successfully!" });
  } catch (error) {
    console.error("Error booking reservation:", error);
    res
      .status(500)
      .json({ success: false, message: "Error booking reservation" });
  }
});
module.exports = router;
