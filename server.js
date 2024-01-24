const express = require('express'); // Use express for setting up the server
const bodyParser = require('body-parser'); // Use Body Parser to send the data more effectively
const mysql = require('mysql2'); // Add Mysql2 for the connection with the database
const path = require('path');
const session = require('express-session'); // Add Express-session to remember the loginID
const multer = require('multer'); // Add multer for file uploads
const fs = require('fs');

const app = express(); // Determined Port on which the Website will run
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); 
app.use(session({ // Details for the Session
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true
}));

const storage = multer.memoryStorage();
const upload = multer({ storage: storage }); // Setup to use Multer, which isnt really implememnted into the code but still helps with getting data from the file upload

const connection = mysql.createConnection({ // Mysql2 connection to the server
    host: 'localhost',
    user: 'root',
    password: 'Root_Password',
    database: 'DispensenDB',
});

app.get('/login', (req, res) => {
    res.sendFile(__dirname + '/login.html'); //Route for the login page
});

app.post('/login', (req, res) => { //Route to push the login page details to log in.
    const { username, password, admin } = req.body;

    const sql = 'SELECT * FROM login WHERE username = ? AND password = ? AND admin < 3';

    connection.query(sql, [username, password, admin], (error, results) => {
        if (error) {
            console.error('Error executing SQL query:', error);
            res.status(500).json({ error: 'Internal Server Error', message: error.message });
        } else {
            if (results.length > 0) {
                const loginID = results[0].loginID;         // Input the results into the session
                const isAdmin = results[0].admin === 1;

                getUserIdFromLoginID(loginID, (err, userID) => {
                    if (err) {
                        res.status(500).json({ error: 'Internal Server Error', message: err.message });
                    } else {
                        req.session.user = {
                            username: results[0].username,
                            loginID: loginID,
                            userID: userID,
                            isAdmin: isAdmin,  // Add admin flag to the session
                        };

                        res.json({ success: true });
                    }
                });
            } else {
                // Failed login
                res.json({ success: false, message: 'Invalid credentials' });
            }
        }
    });
});

// Define a middleware function to check if the user is logged in
const requireLogin = (req, res, next) => {
    const user = req.session.user;

    // If the user is not logged in, redirect to the login page
    if (!user) {
        return res.redirect('/login');
    }

    // If the user is logged in, continue to the next middleware or route handler
    next();
};

// Apply the requireLogin middleware globally to all routes
app.use(requireLogin);

app.get('/home', (req, res) => {
    const user = req.session.user;

    if (!user) {
        res.redirect('/login');
    } else {
        if (user.isAdmin) {
            // Redirect admin to the admin page
            res.redirect('/admin');
        } else {
            // Redirect normal user to the normal home page
            const sql = 'SELECT d.dispensionID, u.user_id, d.start_date, d.end_date, u.name, u.surname, u.email, u.phone_number, u.class, l.location, r.reason, r.reason_abrev, j.job, le.lession ,d.accepted FROM dispensions d JOIN user u ON d.userID = u.user_id JOIN locations l ON u.locationID = l.locationID JOIN reasons r ON r.reasonID = d.reasonID JOIN jobs j ON j.jobID = d.jobID JOIN lessions le on d.lessionID = le.lessionID WHERE d.userID = ? ORDER BY d.end_date;';

            connection.query(sql, [user.userID], (error, results) => {
                if (error) {
                    console.error('Error executing SQL query:', error);
                    res.status(500).json({ error: 'Internal Server Error', message: error.message });
                } else {
                    // Read the HTML template
                    const htmlTemplate = fs.readFileSync(path.join(__dirname, 'home.html'), 'utf-8');

                    // Convert the data to a JSON string
                    const jsonData = JSON.stringify({ user: user, dispensions: results });

                    // Inject the JSON data into the HTML template
                    const updatedHtml = htmlTemplate.replace('<!-- DATA_PLACEHOLDER -->', `<script>const data = ${jsonData};</script>`);

                    // Send the modified HTML
                    res.send(updatedHtml);
                }
            });
        }
    }
});

app.get('/dispension/:dispensionID', (req, res) => {
    const dispensionID = req.params.dispensionID;

    const sql = `
        SELECT
            d.dispensionID,
            u.user_id,
            d.start_date,
            d.end_date,
            u.name,
            u.surname,
            u.email,
            u.phone_number,
            u.class,
            d.teachers,
            l.location,
            r.reason,
            r.reason_abrev,
            d.comment,
            j.job,
            d.work_check,
            d.parent_check,
            f.file_name,  
            d.accepted,
            le.lession
        FROM
            dispensions d
        JOIN
            user u ON d.userID = u.user_id
        JOIN
            locations l ON u.locationID = l.locationID
        JOIN
            reasons r ON r.reasonID = d.reasonID
        JOIN
            jobs j ON j.jobID = d.jobID
        JOIN
            files f ON f.fileID = d.fileID
        JOIN lessions le on d.lessionID = le.lessionID
        WHERE
            d.dispensionID = ?;
    `;

    connection.query(sql, [dispensionID], (error, results) => {
        if (error) {
            console.error('Error executing SQL query:', error);
            res.status(500).json({ error: 'Internal Server Error', message: error.message });
        } else {
            if (results.length > 0) {
                const dispensionData = results[0];

                // Read the HTML template
                const htmlTemplate = fs.readFileSync(path.join(__dirname, 'home-dispension-details.html'), 'utf-8');

                // Inject the data directly into the HTML template
                const updatedHtml = htmlTemplate.replace('/* DISPENSION_DATA_PLACEHOLDER */', `
                    const dispensionData = ${JSON.stringify(dispensionData)};
                `);

                // Send the modified HTML
                res.send(updatedHtml);
            } else {
                res.status(404).json({ error: 'Not Found', message: 'Dispension not found' });
            }
        }
    });
});

app.delete('/dispensions/:dispensionID', (req, res) => {
    const dispensionID = req.params.dispensionID;

    // Add logic to check if the dispension is in the past before allowing deletion
    const currentDate = new Date();
    const sql = `
        SELECT end_date
        FROM dispensions
        WHERE dispensionID = ?;
    `;

    connection.query(sql, [dispensionID], (error, results) => {
        if (error) {
            console.error('Error executing SQL query:', error);
            res.status(500).json({ error: 'Internal Server Error', message: error.message });
        } else {
            if (results.length > 0) {
                const dispensionEndDate = new Date(results[0].end_date);

                // Check if the dispension is in the past
                if (dispensionEndDate <= currentDate) {
                    res.status(403).json({ error: 'Forbidden', message: 'Cannot delete past dispensions' });
                } else {
                    // Perform the actual deletion
                    const deleteSQL = 'DELETE FROM dispensions WHERE dispensionID = ?';

                    connection.query(deleteSQL, [dispensionID], (deleteError, deleteResults) => {
                        if (deleteError) {
                            console.error('Error deleting dispension:', deleteError);
                            res.status(500).json({ success: false, error: 'Internal Server Error', message: deleteError.message });
                        } else {
                            if (deleteResults.affectedRows > 0) {
                                res.json({ success: true, message: 'Dispension deleted successfully' });
                            } else {
                                res.status(404).json({ success: false, error: 'Not Found', message: 'Dispension not found' });
                            }
                        }
                    });
                }
            } else {
                res.status(404).json({ error: 'Not Found', message: 'Dispension not found' });
            }
        }
    });
});

app.get('/edit-dispension/:dispensionID', (req, res) => {
    const dispensionID = req.params.dispensionID;

    const sql = `
        SELECT *
        FROM dispensions
        WHERE dispensionID = ?;
    `;

    connection.query(sql, [dispensionID], (error, results) => {
        if (error) {
            console.error('Error executing SQL query:', error);
            res.status(500).json({ error: 'Internal Server Error', message: error.message });
        } else {
            if (results.length > 0) {
                const dispensionData = results[0];

                // Read the HTML template
                const htmlTemplate = fs.readFileSync(path.join(__dirname, 'edit-dispension.html'), 'utf-8');

                // Read and send the dropdown data
                const getReasonsSql = 'SELECT reasonID as id, reason as name FROM reasons';
                const getJobsSql = 'SELECT jobID as id, job as name FROM jobs';
                const getLessonsSql = 'SELECT lessionID as id, lession as name FROM lessions';

                // Use Promise.all to execute queries concurrently
                Promise.all([
                    queryPromise(connection, getReasonsSql),
                    queryPromise(connection, getJobsSql),
                    queryPromise(connection, getLessonsSql),
                ])
                    .then(([reasons, jobs, lessons]) => {
                        const dropdownData = {
                            reasons,
                            jobs,
                            lessons,
                        };

                        // Replace placeholders in the HTML template
                        const updatedHtml = htmlTemplate
                            .replace('/* DISPENSION_DATA_PLACEHOLDER */', `
                                const dispensionData = ${JSON.stringify(dispensionData)};
                            `)
                            .replace('/* DROPDOWN_DATA_PLACEHOLDER */', `
                                const dropdownData = ${JSON.stringify(dropdownData)};
                            `);

                        // Send the updated HTML to the client
                        res.send(updatedHtml);
                    })
                    .catch(error => {
                        console.error('Error fetching dropdown data:', error);
                        res.status(500).json({ error: 'Internal server error' });
                    });
            } else {
                res.status(404).json({ error: 'Not Found', message: 'Dispension not found' });
            }
        }
    });
});


app.post('/edit-dispension/:dispensionID', (req, res) => {
    const dispensionID = req.params.dispensionID;
    const { startDate, endDate, reasonID, comment, lessonID, teachers, workCheck, parentCheck, jobID } = req.body;

    // Add your logic here to update the dispension in the database
    const updateSql = `
        UPDATE dispensions
        SET
            start_date = ?,
            end_date = ?,
            reasonID = ?,
            comment = ?,
            lessionID = ?,
            teachers = ?,
            work_check = ?,
            parent_check = ?,
            JobID = ?
        WHERE dispensionID = ?;
    `;

    connection.query(
        updateSql,
        [startDate, endDate, reasonID, comment, lessonID, teachers, workCheck, parentCheck, jobID, dispensionID],
        (error, results) => {
            if (error) {
                console.error('Error updating dispension:', error);
                res.status(500).json({ success: false, error: 'Internal Server Error', message: error.message });
            } else {
                console.log('Dispension updated successfully');
                res.json({ success: true, message: 'Dispension updated successfully' });
            }
        }
    );
});

app.get('/submit', (req, res) => {
    res.sendFile(__dirname + '/add-dispension.html');
});

// Add a new route for fetching dropdown data
app.get('/dropdownData', (req, res) => {
    // Fetch data for dropdowns from the database
    const getReasonsSql = 'SELECT reasonID as id, reason as name FROM reasons';
    const getJobsSql = 'SELECT jobID as id, job as name FROM jobs';
    const getLessonsSql = 'SELECT lessionID as id, lession as name FROM lessions';

    // Use Promise.all to execute queries concurrently
    Promise.all([
        queryPromise(connection, getReasonsSql),
        queryPromise(connection, getJobsSql),
        queryPromise(connection, getLessonsSql),
    ])
    .then(([reasons, jobs, lessons]) => {
        // Send the fetched data as JSON response
        res.json({ reasons, jobs, lessons });
    })
    .catch(error => {
        console.error('Error fetching dropdown data:', error);
        res.status(500).json({ error: 'Internal server error' });
    });
});

app.post('/submit', upload.single('fileInput'), (req, res) => {
    // Ensure user is logged in
    const user = req.session.user;
    if (!user) {
        return res.status(401).json({ error: 'Unauthorized', message: 'User not logged in' });
    }

    // Ensure all required fields are provided
    const { startDate, endDate, reason, job, lesson, teachers, workCheck, parentCheck, comment } = req.body;
    if (!startDate || !endDate || !reason || !job || !lesson || !teachers || workCheck === undefined || parentCheck === undefined) {
        return res.status(400).json({ error: 'Bad Request', message: 'Missing required fields' });
    }

    // Ensure start date is in the future
    const currentDate = new Date().toISOString().split('T')[0];
    if (startDate < currentDate) {
        return res.status(400).json({ error: 'Bad Request', message: 'Start date must be in the future' });
    }

    // Handle file upload
    const fileInput = req.file;
    if (!fileInput) {
        return res.status(400).json({ error: 'Bad Request', message: 'File is required' });
    }

    // Insert file data into the files table
    const fileSql = 'INSERT INTO files (file_name, file_data) VALUES (?, ?)';
    connection.query(fileSql, [fileInput.originalname, fileInput.mimetype], (fileError, fileResults) => {
        if (fileError) {
            console.error('Error inserting file:', fileError);
            return res.status(500).json({ error: 'Internal Server Error', message: fileError.message });
        }

        const fileID = fileResults.insertId;

        // Insert dispension data into the dispensions table
        const dispensionSql = 'INSERT INTO dispensions (userID, start_date, end_date, reasonID, comment, lessionID, teachers, work_check, parent_check, JobID, fileID, accepted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)';
        connection.query(
            dispensionSql,
            [user.userID, startDate, endDate, reason, comment, lesson, teachers, workCheck, parentCheck, job, fileID],
            (dispensionError, dispensionResults) => {
                if (dispensionError) {
                    console.error('Error inserting dispension:', dispensionError);
                    return res.status(500).json({ error: 'Internal Server Error', message: dispensionError.message });
                }

                console.log('Dispension data inserted successfully');
                res.json({ success: true });
            }
        );
    });
});

app.get('/admin', (req, res) => {
    const admin = req.session.user;

    if (!admin || !admin.isAdmin) {
        res.redirect('/login');
    } else {
        const sql = 'SELECT d.dispensionID, u.user_id, d.start_date, d.end_date, u.name, u.surname, u.email, u.phone_number, u.class, l.location, r.reason, r.reason_abrev, j.job, le.lession , d.accepted FROM dispensions d JOIN user u ON d.userID = u.user_id JOIN locations l ON u.locationID = l.locationID JOIN reasons r ON r.reasonID = d.reasonID JOIN jobs j ON j.jobID = d.jobID JOIN lessions le on le.lessionID = d.lessionID WHERE d.accepted = 0 ORDER BY d.end_date;';

        connection.query(sql, (error, results) => {
            if (error) {
                console.error('Error executing SQL query:', error);
                res.status(500).json({ error: 'Internal Server Error', message: error.message });
            } else {
                const htmlTemplate = fs.readFileSync(path.join(__dirname, 'admin.html'), 'utf-8');
                const jsonData = JSON.stringify({ admin: admin, dispensions: results });

                // Inject the JSON data into the HTML template
                const updatedHtml = htmlTemplate.replace('<!-- DATA_PLACEHOLDER -->', `<script>const data = ${jsonData};</script>`);

                // Send the modified HTML
                res.send(updatedHtml);
            }
        });
    }
});




app.get('/admin/dispension/:dispensionID', (req, res) => {
    const admin = req.session.user;
    const dispensionID = req.params.dispensionID;

    if (!admin || !admin.isAdmin) {
        res.redirect('/login');
    } else {
        const sql = `
            SELECT
                d.dispensionID,
                u.user_id,
                d.start_date,
                d.end_date,
                u.name,
                u.surname,
                u.email,
                u.phone_number,
                u.class,
                d.teachers,
                l.location,
                r.reason,
                r.reason_abrev,
                d.comment,
                j.job,
                d.work_check,
                d.parent_check,
                f.file_name, 
                d.accepted,
                le.lession
            FROM
                dispensions d
            JOIN
                user u ON d.userID = u.user_id
            JOIN
                locations l ON u.locationID = l.locationID
            JOIN
                reasons r ON r.reasonID = d.reasonID
            JOIN
                jobs j ON j.jobID = d.jobID
            JOIN
                files f ON f.fileID = d.fileID
            JOIN lessions le on d.lessionID = le.lessionID
            WHERE
                d.dispensionID = ?;
        `;

        connection.query(sql, [dispensionID], (error, results) => {
            if (error) {
                console.error('Error executing SQL query:', error);
                res.status(500).json({ error: 'Internal Server Error', message: error.message });
            } else {
                if (results.length > 0) {
                    const dispensionData = results[0];

                    // Read the HTML template
                    const htmlTemplate = fs.readFileSync(path.join(__dirname, 'admin-dispension-details.html'), 'utf-8');

                    // Inject the data directly into the HTML template
                    const updatedHtml = htmlTemplate.replace('/* DISPENSION_DATA_PLACEHOLDER */', `
                        const dispensionData = ${JSON.stringify(dispensionData)};
                    `);

                    // Send the modified HTML
                    res.send(updatedHtml);
                } else {
                    res.status(404).json({ error: 'Not Found', message: 'Dispension not found' });
                }
            }
        });
    }
});



// Assuming you already have the required modules and middleware set up

app.post('/admin/dispension/:dispensionID/accept', (req, res) => {
    const admin = req.session.user;
    const dispensionID = req.params.dispensionID;
    const accepted = req.body.accepted;

    if (!admin || !admin.isAdmin) {
        res.status(403).json({ error: 'Forbidden', message: 'Permission denied' });
    } else {
        const sql = `
            UPDATE dispensions
            SET accepted = ?
            WHERE dispensionID = ?;
        `;

        connection.query(sql, [accepted, dispensionID], (error, results) => {
            if (error) {
                console.error('Error updating dispension:', error);
                res.status(500).json({ error: 'Internal Server Error', message: error.message });
            } else {
                res.json({ success: true });
            }
        });
    }
});

function queryPromise(connection, sql) {
    return new Promise((resolve, reject) => {
        connection.query(sql, (error, results) => {
            if (error) {
                reject(error);
            } else {
                resolve(results);
            }
        });
    });
}

// Your function to get userID based on loginID
function getUserIdFromLoginID(loginID, callback) {
    const sql = 'SELECT user_id FROM user WHERE loginID = ?';

    connection.query(sql, [loginID], (error, results) => {
        if (error) {
            console.error('Error executing SQL query:', error);
            callback(error, null);
        } else {
            if (results.length > 0) {
                const userID = results[0].user_id;
                callback(null, userID);
            } else {
                // No user found for the given loginID
                callback(null, null);
            }
        }
    });
}

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
