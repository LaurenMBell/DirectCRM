/*
Lauren Bell and Spencer Berg, CS 340 

Resources used to create this code:
- Starter code for Node.js on Canvas, Activity 2
- EJS documentation, URL: https://www.npmjs.com/package/ejs
- Express.js documentation: https://expressjs.com/en/5x/guide/using-template-engines/
- EJS tutorial: https://www.digitalocean.com/community/tutorials/how-to-use-ejs-to-template-your-node-application
- This StackOverflow page: https://stackoverflow.com/questions/29961711/app-setviews-dirname-views-in-express-node-js
*/

/*
    SETUP
*/

// Express
const express = require('express');  // We are using the express library for the web server
const app = express();               // We need to instantiate an express object to interact with the server in our code
const ejs = require('ejs'); //Using EJS templating engine
app.set("view engine", "ejs");
app.set("views", __dirname);
const PORT = 65180;     // Set a port number

// Database 
const db = require('./db-connector');

/*
    ROUTES
*/

//Home Page 
app.get('/', function(req, res) {
    res.render('pages/index');
});

//Clients Page
app.get('/clients', async function(req, res) {
    res.render('pages/clients');

    try {
        
        // Define our queries
        const query1 = 'DROP TABLE IF EXISTS diagnostic;';
        const query2 = 'CREATE TABLE diagnostic(id INT PRIMARY KEY AUTO_INCREMENT, text VARCHAR(255) NOT NULL);';
        const query3 = 'INSERT INTO diagnostic (text) VALUES ("MySQL and Node is working for myONID!");'; // Replace with your ONID
        const query4 = 'SELECT * FROM diagnostic;';
        
        // Execute each query synchronously (await).
        // We want each query to finish before the next one starts.
        await db.query(query1);
        await db.query(query2);
        await db.query(query3);
        const [rows] = await db.query(query4); // Store the results
        
        // Send the results to the browser
        const base = "<h1>DirectCRM: A Multi-Use Customer Relationship Management Platform</h1>";
        res.send(base + JSON.stringify(rows));

    } catch (error) {
        console.error("Error executing queries:", error);

        // Send a generic error message to the browser
        res.status(500).send("An error occurred while executing the database queries.");
    }
});

//Product Page
app.get('/products', function(req, res) {
    res.render('pages/products');
});

//Users Page 
app.get('/users', function(req, res) {
    res.render('pages/users');
});

//Licenses Page 
app.get('/licenses', function(req, res) {
    res.render('pages/licenses');
});

//SupportTickets Page 
app.get('/supporttickets', function(req, res) {
    res.render('pages/supporttickets');
});

//Employees Page 
app.get('/employees', function(req, res) {
    res.render('pages/employees');
});

/*
    LISTENER
*/

app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
