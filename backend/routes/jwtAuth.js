const router = require('express').Router();
const pool = require('../db');
const jwtGenerator = require('../utils/jwtGenerator');
const validInfo = require('../middleware/validInfo');
const authorization = require('../middleware/authorization');

// Register
router.post('/signup', validInfo, async(req, res) => {
    try {
        // destructure the req.body (firstName, lastName, address, ssn, registrationDate, email, password)
        const { firstName, lastName, address, ssn, registrationDate, email, password } = req.body;

        // check if user exists (if user exists then throw error)
        const user = await pool.query('SELECT * FROM client WHERE ClientEmail = $1', [email]);

        if (user.rows.length !== 0) {
            return res.status(401).json('User already exists');
        }

        // check if the ssn exists
        const ssnCheck = await pool.query('SELECT * FROM client WHERE ClientSSN = $1', [ssn]);

        if (ssnCheck.rows.length !== 0) {
            return res.status(401).json('SSN already exists');
        }

        // enter the new user inside our database
        const newUser = await pool.query(
            'INSERT INTO client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *', [firstName, lastName, address, parseInt(ssn), registrationDate, email, password]
        );
        // generating our jwt token
        const token = jwtGenerator(newUser.rows[0].clientid);
        res.json({ token });

    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

// Login
router.post('/login', validInfo, async(req, res) => {
    try{
        // destructure the req.body
        const { email, password, role } = req.body;
        //check if user doesn't exist (if not then we throw error)
        let user;
        if (role === 'client') {
            user = await pool.query('SELECT * FROM client WHERE ClientEmail = $1', [email]);
            if (user.rows.length === 0) {
                return res.status(401).json('Password or Email is incorrect');
            }
        } else if (role === 'employee') {
            user = await pool.query('SELECT * FROM employee WHERE EmployeeEmail = $1', [email]);
            if (user.rows.length === 0) {
                return res.status(401).json('Password or Email is incorrect');
            }
        }
        // check if incoming password is the same as the database password
        if (role === 'client') {
            const clientPassword = user.rows[0].clientpassword;
            if (password !== clientPassword) {
                return res.status(401).json('Password or Email is incorrect');
            }
        } else if (role === 'employee') {
            const employeePassword = user.rows[0].employeepassword;
            if (password !== employeePassword) {
                return res.status(401).json('Password or Email is incorrect');
            }
        }

        // give them the jwt token
        if (role === 'client') {
            const token = jwtGenerator(user.rows[0].clientid, role);
            res.json({ token });
        } else if (role === 'employee') {
            const token = jwtGenerator(user.rows[0].employeeid, role);
            res.json({ token });
        }
    } 
    catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});

router.get('/is-verify', authorization, require('../middleware/authorization'), async(req, res) => {
    try {
        res.json(true);
    } catch (err) {
        console.error(err.message);
        res.status(500).json('Server error');
    }
});
module.exports = router;