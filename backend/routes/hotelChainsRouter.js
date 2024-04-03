const express = require('express');
const pool = require('../db');
const router = express.Router();

app.get('/api/hotelChains', async (req, res) => {
    try {
      const queryResult = await pool.query('SELECT id, name FROM hotel_chains'); // Adjust SQL query based on your schema
      res.json(queryResult.rows);
    } catch (err) {
      console.error('Error querying hotel chains', err);
      res.status(500).send('Server error');
    }
  });

