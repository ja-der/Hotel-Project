const express = require("express");
const app = express();
const cors = require("cors");
require("dotenv").config();
const PORT = process.env.PORT || 3000;

//middleware
app.use(cors());
app.use(express.json());

//routes
// Register and Login Routes
app.use("/auth", require("./routes/jwtAuth"));

// Dashboard Route
app.use("/dashboard", require("./routes/dashboard"));

app.use("/api/hotelChains", require("./routes/booking/hotelChains"));
app.use("/api/hotelcities", require("./routes/booking/hotelCities"));
app.use("/api/searchRooms", require("./routes/booking/searchRooms"));

// Employee Route
app.use("/employee", require("./routes/employee"));

app.listen(4000, () => {
  console.log(`Server is running on port 4000`);
});
