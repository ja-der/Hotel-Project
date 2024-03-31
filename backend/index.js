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

app.listen(3000, () => {
    console.log(`Server is running on port 3000`);
});

// const express = require('express')
// const app = express()
// const port = 3000

// const pg = require('pg')
// const client = new pg.Client({
//     user: process.env.DB_USER,
//     host: process.env.DB_HOST,
//     database: process.env.DB_NAME,
//     password: process.env.DB_PASSWORD,
//     port: process.env.DB_PORT,
// });

// app.get('/', (req, res) => {
//   res.send('Hello from the server')
// })

// app.use(function (req, res, next) {
//   res.setHeader("Access-Control-Allow-Origin", "http://localhost:3000");
//   res.setHeader("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
//   res.setHeader(
//     "Access-Control-Allow-Headers",
//     "Content-Type, Access-Control-Allow-Headers"
//   );
//   next();
// });