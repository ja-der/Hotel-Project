const router = require("express").Router();
const pool = require("../../db");

//get client info
router.get("/:email", async (req, res) => {
  const email = req.params.email;

  try {
    const queryResult = await pool.query(
      "SELECT * FROM Client WHERE clientemail= $1",
      [email]
    );
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying hotel chains:", err);
    res.status(500).send("Server error");
  }
});
//update client info
router.put("/updateInfo", async (req, res) => {
  try {
    const { firstName, lastName, address, ssn, email } = req.body;
    const updateQuery = `
    UPDATE Client
    SET
      clientfirstname = $1,
      clientlastname = $2,
      clientaddress = $3,
      clientssn = $4,
      clientemail = $5
    WHERE clientemail = $6
    RETURNING *;`;
    const queryResult = await pool.query(updateQuery, [
      firstName,
      lastName,
      address,
      ssn,
      email,
      email,
    ]);
    if (queryResult.rows.length === 0) {
      return res.status(404).json("Client not found");
    }
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying hotel chains:", err);
    res.status(500).send("Server error");
  }
});

//get client reservation
router.get("/reservation/:clientid", async (req, res) => {
  const id = req.params.clientid;
  // SELECT *
  // FROM Room
  // INNER JOIN Reservation ON Room.RoomID = Reservation.roomid
  // WHERE reservation.clientid = 1;
  try {
    const queryResult = await pool.query(
      "SELECT * FROM Room INNER JOIN Reservation ON Room.RoomID = Reservation.roomid WHERE reservation.clientid= $1",
      [id]
    );
    res.json(queryResult.rows);
  } catch (err) {
    console.error("Error querying hotel chains:", err);
    res.status(500).send("Server error");
  }
});
module.exports = router;
