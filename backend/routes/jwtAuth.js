const router = require('express').Router();
const pool = require('../db');
const bcrypt = require('bcrypt');
const jwtGenerator = require('../utils/jwtGenerator');
const validInfo = require('../middleware/validInfo');
const authorize = require('../middleware/authorization');
const authorization = require('../middleware/authorization');

// Register
router.post('/signup', validInfo, async(req, res) => {
    try {
        // destructure the req.body (firstName, lastName, address, ssn, registrationDate, email, password)
        const { firstName, lastName, address, ssn, registrationDate, email, password } = req.body;

        // check if user exists (if user exists then throw error)
        const user = await pool.query('SELECT * FROM client WHERE ClientEmail = $1', [email]);

        if (user.rows.length !== 0) {
            return res.status(401).send('User already exists');
        }

        // Bcrypt the user password
        const saltRounds = 10;
        const salt = await bcrypt.genSaltSync(saltRounds);

        const bcryptPassword = await bcrypt.hash(password, salt);

        // enter the new user inside our database
        const newUser = await pool.query(
            'INSERT INTO client (ClientFirstName, ClientLastName, ClientAddress, ClientSSN, RegistrationDate, ClientEmail, ClientPassword) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *', [firstName, lastName, address, parseInt(ssn), registrationDate, email, bcryptPassword]
        );
        // generating our jwt token
        const token = jwtGenerator(newUser.rows[0].clientid);
        res.json({ token });

    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
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
                return res.status(401).send('Password or Email is incorrect');
            }
        } else if (role === 'employee') {
            user = await pool.query('SELECT * FROM employee WHERE EmployeeEmail = $1', [email]);
            if (user.rows.length === 0) {
                return res.status(401).send('Password or Email is incorrect');
            }
        }
        // check if incoming password is the same as the database password
        if (role === 'client') {
            const validPassword = await bcrypt.compare(password, user.rows[0].clientpassword);
            if (!validPassword) {
                return res.status(401).send('Password or Email is incorrect');
            }
        } else if (role === 'employee') {
            const employeePassword = user.rows[0].employeepassword;
            if (password !== employeePassword) {
                return res.status(401).send('Password or Email is incorrect');
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
        res.status(500).send('Server error');
    }
});

router.get('/is-verify', authorization, require('../middleware/authorization'), async(req, res) => {
    try {
        res.json(true);
    } catch (err) {
        console.error(err.message);
        res.status(500).send('Server error');
    }
});
module.exports = router;