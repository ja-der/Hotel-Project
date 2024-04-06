const express = require("express");
const app = express();
const cors = require("cors");
require("dotenv").config();
const PORT = process.env.PORT || 4000;

//middleware
app.use(cors());
app.use(express.json());

// Register and Login Routes
app.use("/auth", require("./routes/jwtAuth"));

// Routes
app.use("/dashboard", require("./routes/dashboard"));
app.use("/api/searchRooms", require("./routes/booking/searchRooms"));
app.use("/api/hotelChains", require("./routes/booking/hotelChains"));
app.use("/api/hotelcities", require("./routes/booking/hotelCities"));
app.use("/api/makeReservation", require("./routes/booking/makeReservation"));
app.use("/api/personalInfo", require("./routes/booking/personalInfo"));
app.use(
  "/api/availableRoomsPerCity",
  require("./routes/booking/availableRoomsPerCity")
);
app.use(
  "/api/findHotelCapacity",
  require("./routes/booking/findHotelCapacity")
);

// Employee Route
app.use("/employee", require("./routes/employee"));

app.listen(PORT, () => {
  console.log(`Server is running on port 4000`);
});
