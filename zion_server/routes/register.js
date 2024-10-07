const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');

const pool = require('../zion').pool;

// Registration endpoint
router.post('/', async (req, res) => {
    const { email, password } = req.body;

    // Validate email and password
    if (!email || !password) {
        return res.status(400).json({ message: 'Invalid email or password' });
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insert user into database
    const validationQuery = 'SELECT acc_type FROM registered_accounts WHERE email = ?';
    const query = 'INSERT INTO users (email, password) VALUES (?, ?)';
    pool.getConnection(async (err, connection) => {
        if (err) throw err;

        connection.query(validationQuery, [email], (err, result) => {
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }
            if (result.length !== 0) {
                connection.query(query, [email, hashedPassword], (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).json({ message: 'Database error' });
                    }
                    res.status(200).json({ message: 'User registered successfully' });
                });
            }
        });
    });
});

module.exports = router;