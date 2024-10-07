require('dotenv').config();
const http = require('http');
const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');

const app = express();
const port = 7898;

// Configure middleware
app.use(bodyParser.json());

// Create a MySQL connection pool
const pool = mysql.createPool({
    host: '172.17.0.6',
    user: 'root',
    password: process.env.DATABASE_PASSWORD,
    database: 'zion',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Export the pool to be used in other modules
module.exports.pool = pool;

// Import routes
const defaultRoute = require('./routes/default');
const registerRoute = require('./routes/register');
const loginRoute = require('./routes/login');
const announcementsRoute = require('./routes/announcements');
const mealRoute = require('./routes/meal');
const lastMealRating = require('./routes/lastMealRating');

// Use routes
app.use("/", defaultRoute);
app.use("/register", registerRoute);
app.use("/login", loginRoute);
app.use("/announcements", announcementsRoute);
app.use("/meal", mealRoute);
app.use("/last_meal_rating", lastMealRating);

// Start HTTP server
http.createServer(app).listen(port, () => {
    console.log(`HTTP Server running on port ${port}`);
});

// require('dotenv').config();
// const https = require('https');
// const express = require('express');
// const mysql = require('mysql2');
// const bodyParser = require('body-parser');

// const app = express();
// const port = 7898;

// // Configure middleware
// app.use(bodyParser.json());

// // Create a MySQL connection pool
// const pool = mysql.createPool({
//     host: 'localhost',
//     user: 'root',
//     password: process.env.DATABASE_PASSWORD,
//     database: 'zion',
//     waitForConnections: true,
//     connectionLimit: 10,
//     queueLimit: 0
// });

// // Export the pool to be used in other modules
// module.exports.pool = pool;

// // Import routes
// const registerRoute = require('./routes/register');
// const loginRoute = require('./routes/login');
// const announcementsRoute = require('./routes/announcements');
// const mealRoute = require('./routes/meal');
// const lastMealRating = require('./routes/lastMealRating');

// // Use routes
// app.use("/register", registerRoute);
// app.use("/login", loginRoute);
// app.use("/announcements", announcementsRoute);
// app.use("/meal", mealRoute);
// app.use("/last_meal_rating", lastMealRating);

// // // SSL options
// // const options = {
// //     key: fs.readFileSync('/etc/letsencrypt/live/evergladefoundation.tech/privkey.pem'),
// //     cert: fs.readFileSync('/etc/letsencrypt/live/evergladefoundation.tech/fullchain.pem')
// // };

// // Start HTTPS server
// https.createServer(options, app).listen(port, () => {
//     console.log(`HTTPS Server running on port ${port}`);
// });
