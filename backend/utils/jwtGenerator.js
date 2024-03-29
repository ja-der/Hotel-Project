const jwt = require('jsonwebtoken');
require('dotenv').config();

function jwtGenerator(userid, role) {
    const payload = {
        userID: userid,
        userRole: role
    };

    return jwt.sign(payload, process.env.jwtSecret, { expiresIn: '1hr' });
}

module.exports = jwtGenerator;