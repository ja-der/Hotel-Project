const router = require("express").Router();
const pool = require("../db");

router.get("/", async (req, res) => {
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
module.exports = router;
