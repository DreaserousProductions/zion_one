const express = require('express');
const router = express.Router();

const pool = require('../zion').pool;

router.post('/get_rating', async (req, res) => {
    const { email } = req.body;

    // Validate email and password
    if (!email) {
        return res.status(400).json({ message: 'Invalid email or password' });
    }

    // Get last meal
    const idQuery = 'SELECT id FROM users WHERE email = ?';
    const query = 'SELECT * FROM user_meals WHERE id = ? ORDER BY meal_date DESC LIMIT 1;';
    pool.getConnection(async (err, connection) => {
        if (err) throw err;

        connection.query(idQuery, [email], (err, result) => {
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }
            if (result.length !== 0) {
                connection.query(query, [result[0]['id']], (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).json({ message: 'Database error' });
                    }
                    if (results[0]["rating"] === null) {
                        res.status(200).json({ status: true, mealId: results[0]["meal_id"], date: results[0]["meal_date"], day: results[0]["day"], meal: results[0]["meal"] });
                    } else {
                        res.status(200).json({ status: false });
                    }
                });
            }
        });
    });
});

router.post('/set_rating', async (req, res) => {
    const { mealId, rating } = req.body;

    const query = 'UPDATE user_meals SET rating = ? WHERE meal_id = ?;';
    pool.getConnection(async (err, connection) => {
        if (err) throw err;

        connection.query(query, [rating, mealId], (err, result) => {
            connection.release();
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }
            res.status(200).json({ message: 'Rating updated successfully' });
        });
    });
});

module.exports = router;