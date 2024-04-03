const router = require('express').Router();
const pool = require('../../db');

router.get('/', async (req, res) => {
  try {
    const queryResult = await pool.query('SELECT chainid, chainname FROM chain');
    res.json(queryResult.rows);
  } catch (err) {
    console.error('Error querying hotel chains:', err);
    res.status(500).send('Server error');
  }
});
module.exports = router;