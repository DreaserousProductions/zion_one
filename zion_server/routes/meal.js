const express = require('express');
const router = express.Router();
const pool = require('../zion').pool;

router.get('/', (req, res) => {
    const beforeNow = new Date().getTime();
    const now = new Date(beforeNow + 5 * 60 * 60 * 1000 + 30 * 60 * 1000);
    const dayOfWeek = now.toLocaleString('en-US', { weekday: 'long' });
    const hours = now.getHours();
    const minutes = now.getMinutes();

    let mealOfDay = '';
    if (hours < 9 || (hours === 9 && minutes < 30)) {
        mealOfDay = 'Breakfast';
    } else if (hours < 14 || (hours === 14 && minutes < 30)) {
        mealOfDay = 'Lunch';
    } else if (hours < 18 || (hours === 18 && minutes < 30)) {
        mealOfDay = 'Snacks';
    } else if (hours < 21 || (hours === 21 && minutes < 30)) {
        mealOfDay = 'Dinner';
    } else {
        mealOfDay = 'Breakfast';
    }

    const query = 'SELECT * FROM meals WHERE day = ? AND meal = ?';
    pool.getConnection((err, connection) => {
        if (err) throw err;
        connection.query(query, [dayOfWeek, mealOfDay], (err, results) => {
            connection.release();
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }
            if (results.length === 0) {
                return res.status(200).json({ message: 'No meal found' });
            }
            res.status(200).json(results[0].items);
        });
    });
});

module.exports = router;
