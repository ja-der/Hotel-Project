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
app.use("/api/search", require("./routes/booking/searchRooms"));

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
