/*
Lauren Bell and Spencer Berg, CS 340 

Resources used to create this code:
Accessed 7/29 and 7/30
- Starter code for Node.js on Canvas, Activity 2
- EJS documentation, URL: https://www.npmjs.com/package/ejs
- Express.js documentation: https://expressjs.com/en/5x/guide/using-template-engines/
- EJS tutorial: https://www.digitalocean.com/community/tutorials/how-to-use-ejs-to-template-your-node-application
- This StackOverflow page: https://stackoverflow.com/questions/29961711/app-setviews-dirname-views-in-express-node-js

Accessed 8/6
- Helper code from Step 4 Draft Help Section: https://canvas.oregonstate.edu/courses/2051721/assignments/10565924
- GitHub Copilot was used to connect PL.SQL to app (https://github.com/copilot)
    Prompt: This is the error message I'm getting: [error message]. How do I connect PL.SQL and 
            DDL.SQL to the app? 
*/


/*
    SETUP
*/

// Express
const express = require('express');  // We are using the express library for the web server
const app = express();               // We need to instantiate an express object to interact with the server in our code
const ejs = require('ejs'); //Using EJS templating engine
const fs = require('fs'); 
const path = require('path');
app.set("view engine", "ejs");
app.set("views", __dirname);
app.use(express.static(__dirname));
app.use(express.urlencoded({ extended: true }));
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
    try {
        const [rows] = await db.query('SELECT * FROM Clients ORDER BY ClientName');
        res.render('pages/clients', { clients: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/clients', {
            clients: [],
            error: 'Unable to load clients.'
        });
    }
});

//Product Page
app.get('/products', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM Products ORDER BY ProductName');
        res.render('pages/products', { products: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/products', {
            products: [],
            error: 'Unable to load products.'
        });
    }
});

//Users Page 
app.get('/users', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM Users');
        res.render('pages/users', { users: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/users', {
            users: [],
            error: 'Unable to load users.'
        });
    }
});

//Licenses Page 
app.get('/licenses', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM Licenses ORDER BY LicenseID');
        res.render('pages/licenses', { licenses: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/licenses', {
            licenses: [],
            error: 'Unable to load licenses.'
        });
    }
});

//SupportTickets Page 
app.get('/supporttickets', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM SupportTickets');
        res.render('pages/supporttickets', { supporttickets: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/supporttickets', {
            supporttickets: [],
            error: 'Unable to load supporttickets.'
        });
    }
});

//Employees Page 
app.get('/employees', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM Employees');
        res.render('pages/employees', { employees: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/employees', {
            employees: [],
            error: 'Unable to load employees.'
        });
    }
});

//User Products Page 
app.get('/userproducts', async function(req, res) {
    try {
        const [rows] = await db.query('SELECT * FROM UserProducts');
        res.render('pages/userproducts', { userproducts: rows, error: null });
    } catch (error) {
        console.error("Error executing queries:", error);
        res.status(500).render('pages/userproducts', {
            userproducts: [],
            error: 'Unable to load userproducts.'
        });
    }
});

async function loadSqlFile(fileName) {
    const filePath = path.join(__dirname, fileName);
    return fs.readFileSync(filePath, 'utf8');
}

function normalizeSqlText(sqlText) {
    return sqlText
        .replace(/DELIMITER\s+[^\r\n]+/gi, '')
        .replace(/\/\/\s*$/gm, ';')
        .trim();
}

async function createRichardSmithProcedure() {
    const sql = normalizeSqlText(await loadSqlFile('PL.SQL'));
    await db.query(sql);
}

//Reset Demo Page 
app.get('/resetdemo', function(req, res) {
    res.render('pages/resetdemo', { message: null });
});

app.post('/resetdemo/delete-rsmith', async function(req, res) {
    try {
        await createRichardSmithProcedure();
        await db.query('CALL DeleteRichardSmith();');
        res.render('pages/resetdemo', {
            message: 'Richard Smith was removed from the demo data.'
        });
    } catch (error) {
        console.error("Error executing PL/SQL:", error);
        res.status(500).render('pages/resetdemo', {
            message: 'An error occurred while resetting the demo: ' + error.message
        });
    }
});

app.post('/resetdemo/reset-demo', async function(req, res) {
    try {
        const ddlSql = normalizeSqlText(await loadSqlFile('DDL.sql'));
        await db.query(ddlSql);
        res.render('pages/resetdemo', {
            message: 'DDL.SQL WAS RAN!!'
        });
    } catch (error) {
        console.error("Error executing DDL.SQL:", error);
        res.status(500).render('pages/resetdemo', {
            message: 'An error occurred while resetting the demo: ' + error.message
        });
    }
});

/*
    LISTENER
*/

app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});
