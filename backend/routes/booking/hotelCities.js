// const router = require('express').Router();
// const pool = require('../../db');

// router.get('/', async (req, res) => {
//   try {
//     const queryResult = await pool.query('SELECT hotelid, hotelcity FROM hotel');
//     res.json(queryResult.rows);
//   } catch (err) {
//     console.error('Error querying cities:', err);
//     res.status(500).send('Server error');
//   }
// });
// module.exports = router;
