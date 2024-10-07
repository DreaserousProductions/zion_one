const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');

const pool = require('../zion').pool;

// Login endpoint
router.post('/', async (req, res) => {
    const { email, password } = req.body;

    // Validate email and password
    if (!email || !password) {
        return res.status(400).json({ message: 'Invalid email or password' });
    }

    // Query to find the user by email
    const query = 'SELECT password FROM users WHERE email = ?';
    pool.getConnection(async (err, connection) => {
        if (err) throw err;
        connection.query(query, [email], async (err, result) => {
            connection.release();
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }

            if (result.length === 0) {
                // User not found
                return res.status(400).json({ message: 'Invalid email or password' });
            }

            const hashedPassword = result[0].password;

            // Compare provided password with stored hash
            const isMatch = await bcrypt.compare(password, hashedPassword);

            if (isMatch) {
                res.status(200).json({ message: 'User logged in successfully' });
            } else {
                res.status(400).json({ message: 'Invalid email or password' });
            }
        });
    });
});

module.exports = router;