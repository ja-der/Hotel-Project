const router = require('express').Router();
const pool = require('../db');
const authorization = require('../middleware/authorization');

router.get('/', authorization, async(req, res) => {
    try {
        if (req.userRole === 'client') {
            const client = await pool.query('SELECT clientfirstname FROM client WHERE clientid = $1', [req.userID]);
            res.json(client.rows[0]);
        }
        else if (req.userRole === 'employee') {
            const employee = await pool.query('SELECT employeefirstname FROM employee WHERE employeeid = $1', [req.userID]);
            res.json(employee.rows[0]);
        }
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
    }
});

module.exports = router;