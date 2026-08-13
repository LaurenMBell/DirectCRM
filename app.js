/*
Lauren Bell and Spencer Berg, CS 340 

Resources used to create this code:
Accessed 7/29 and 7/30
- Starter code for Node.js on Canvas, Activity 2
- Referenced the EJS documentation: https://www.npmjs.com/package/ejs
- Referenced the Express.js documentation: https://expressjs.com/en/5x/guide/using-template-engines/
- Followed the EJS tutorial: https://www.digitalocean.com/community/tutorials/how-to-use-ejs-to-template-your-node-application
- Referenced this StackOverflow page: https://stackoverflow.com/questions/29961711/app-setviews-dirname-views-in-express-node-js

Accessed 8/6
- Adapted the helper code from Step 4 Draft Help Section: https://canvas.oregonstate.edu/courses/2051721/assignments/10565924
- GitHub Copilot was used to connect PL.SQL to app (https://github.com/copilot)
    Prompt: This is the error message I'm getting: [error message]. How do I connect PL.SQL and 
            DML.SQL to the app? 

Accessed 8/12
- Referenced this Mozilla documentation: https://developer.mozilla.org/en-US/docs/Learn_web_development/Extensions/Forms/Sending_and_retrieving_form_data
- Referenced this Express documentation: https://expressjs.com/en/guide/routing/
- Referenced this video on Express.js: https://www.youtube.com/watch?v=SccSCuHhOw0
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

app.post('/clients/add-new-client', async function(req, res) {
    const { clientid, clientname, revenue } = req.body;

    const parsedRevenue = revenue ? parseFloat(revenue) : 0;

    const query = 'CALL InsertClient(?, ?, ?);';
    await db.query(query, [clientid, clientname, parsedRevenue]);

    res.redirect('/clients');
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

app.post('/products/add-new-product', async function(req, res) {
    const { productid, productname } = req.body;

    const query = 'CALL InsertProduct(?, ?);';
    await db.query(query, [productid, productname]);

    res.redirect('/products');
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

app.post('/users/add-new-user', async function(req, res) {
    const { userid, fname, lname, clientid, password, securityquestion, securityanswer} = req.body;

    //ADD CHECK FOR PREEXISTING CLIENT -- "ADD NEW CLIENT FIRST!"

    const query = 'CALL InsertUser(?, ?, ?, ?, ?, ?, ?);';
    await db.query(query, [userid, fname, lname, clientid, password, securityquestion, securityanswer]);

    res.redirect('/users');

    console.log("SOMETHING HAPPENEDDDD!!")
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


//Functions provided by GitHub Copilot, citation above
async function loadSqlFile(fileName) {
    const filePath = path.join(__dirname, fileName);
    return fs.readFileSync(filePath, 'utf8');
}

async function createRichardSmithProcedure() {
    const sql = loadSqlFile('PL.SQL');
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
            message: 'Demo reset!'
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
