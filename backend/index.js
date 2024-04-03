const express = require("express");
const pool = require('./db');
const app = express();
const cors = require("cors");

app.get('/api/hotelChains', async (req, res) => {
  try {
    const queryResult = await pool.query('SELECT chainid, chainname FROM chain');
    console.log(queryResult);
    res.json(queryResult.rows);
  } catch (err) {
    console.error('Error querying hotel chains:', err);
    res.status(500).send('Server error');
  }
});

app.get('/api/hotelAreas', async (req, res) => {
  try {
    const queryResult = await pool.query('SELECT DISTINCT hoteladdress FROM hotel');
    const areas = queryResult.rows.map(row => row.HotelAddress);
    res.json(areas);
  } catch (err) {
    console.error('Error querying hotel areas:', err);
    res.status(500).send('Server error');
  }
});

//middleware
app.use(cors());
app.use(express.json());

//routes
// Register and Login Routes
app.use("/auth", require("./routes/jwtAuth"));

// Dashboard Route
app.use("/dashboard", require("./routes/dashboard"));



app.listen(3000, () => {
  console.log(`Server is running on port 3000`);
});
