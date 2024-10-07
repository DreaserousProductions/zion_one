const express = require('express');
const router = express.Router();

const pool = require('../zion').pool;

router.get('/', (req, res) => {
    const query = 'SELECT * FROM announcements';
    pool.getConnection(async (err, connection) => {
        if (err) throw err;
        connection.query(query, (err, results) => {
            connection.release();
            if (err) {
                return res.status(500).json({ message: 'Database error' });
            }
            res.status(200).json(results);
        });
    });
});

module.exports = router;