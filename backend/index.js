const express = require('express');
const app = express();
const cors = require('cors');

//middleware
app.use(cors());
app.use(express.json());

//routes
// Register and Login Routes
app.use('/auth', require('./routes/jwtAuth'));

// Dashboard Route
app.use('/dashboard', require('./routes/dashboard'));

// Employee Route
app.use('/employee', require('./routes/employee'));


app.listen(4000, () => {
    console.log(`Server is running on port 4000`);
});
