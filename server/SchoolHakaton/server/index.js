const express = require("express");
const app = express();
const cors = require("cors");
const port = 5000;
const mysql = require("mysql2");
const scraper = require("./scraper");
const getJobs = require("./algorithm");
const request = require("request");
const jwt = require("jsonwebtoken");
const bodyParser = require("body-parser");

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    database: "school",
});

app.use(express.json());
app.use(
    cors({
        origin: "http://localhost:3000",
        methods: ["GET", "POST", "PUT", "DELETE"],
    })
);

function verifyToken(req, res, next) {
    const token = req.body.token;
    jwt.verify(token, "your-secret-key", (err, decoded) => {
        if (err) {
            return res.status(401).json({ valid: false });
        }
        return res.status(200).json({ valid: true });
    });
}

function generateToken(email) {
    const payload = {
        email: email,
    };

    const options = {
        expiresIn: "1d",
    };

    return jwt.sign(payload, "your-secret-key", options);
}

app.post("/api/auth/verify", verifyToken, (req, res) => {});

// app.post("/api/auth/", (req, res) => {
//     const sql = "SELECT * FROM auth WHERE email = ? AND password = ?";
//     let { email, password } = req.body;
//     db.query(sql, [email, password], (error, results, fields) => {
//         if (error) {
//             res.send({
//                 message:
//                     "There was a problem with an authentication. Please contact administrator",
//             });
//         }
//         if (results && results.length > 0) {
//             let token = generateToken(results[0].email);
//             res.status(200).json({ token: token });
//         } else {
//             res.status(404).json({
//                 message: "Invalid Credentials. Please try again.",
//             });
//         }
//     });
// });

app.get("/api/ucenik/skolaId=:schoolId/ucenikId=:studentId", (req, res) => {
    const schoolId = req.params.schoolId;
    const studentId = req.params.studentId;
    let sqlGetStudent = "SELECT * FROM ucenik WHERE id = ? AND skola_id = ?";
    db.query(sqlGetStudent, [studentId, schoolId], (error, results) => {
        if (error) {
            console.error("Error fetching student:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (results && results.length !== 0) {
                res.json(results[0]); // Assuming only one student will be found
            } else {
                res.status(404).json({
                    status: "Not Found",
                    message:
                        "No student found for the specified school and student IDs",
                });
            }
        }
    });
});
app.get("/api/aktivnosti/skolaId=:schoolId/ucenikId=:studentId", (req, res) => {
    const schoolId = req.params.schoolId;
    const studentId = req.params.studentId;
    let sqlActivities =
        "SELECT * FROM aktivnost INNER JOIN ucenik ON aktivnost.ucenik_id = ucenik.id WHERE aktivnost.ucenik_id = ? AND ucenik.skola_id = ?";
    db.query(sqlActivities, [studentId, schoolId], (error, results) => {
        if (error) {
            console.error("Error fetching activities:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (results && results.length !== 0) {
                res.json(results);
            } else {
                res.status(404).json({
                    status: "Not Found",
                    message:
                        "No activities found for the specified school and student IDs",
                });
            }
        }
    });
});

app.get("/api/predmeti/skolaId=:schoolId/ucenikId=:studentId", (req, res) => {
    const schoolId = req.params.schoolId;
    const studentId = req.params.studentId;
    console.log(studentId, schoolId);
    let sqlSubjects =
        "SELECT * FROM predmet INNER JOIN ucenik on predmet.ucenik_id = ucenik.id WHERE predmet.ucenik_id = ? AND ucenik.skola_id = ?";
    db.query(sqlSubjects, [studentId, schoolId], (error, results) => {
        if (error) {
            console.error("Error fetching subjects:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (results && results.length !== 0) {
                res.json(results);
            } else {
                res.status(404).json({
                    status: "Not Found",
                    message:
                        "No subjects found for the specified school and student IDs",
                });
            }
        }
    });
});

app.get(
    "/api/generisi/poslove/skolaId=:schoolId/ucenikId=:studentId",
    (req, res) => {
        const schoolId = req.params.schoolId;
        const studentId = req.params.studentId;
        console.log(studentId, schoolId);
        let sqlSubjects =
            "SELECT * FROM predmet INNER JOIN ucenik on predmet.ucenik_id = ucenik.id WHERE predmet.ucenik_id = ? AND ucenik.skola_id = ?";
        db.query(sqlSubjects, [studentId, schoolId], (error, results) => {
            if (error) {
                console.error("Error fetching subjects:", error);
                res.status(500).json({ error: "Internal Server Error" });
            } else {
                if (results && results.length !== 0) {
                    getJobs(results)
                        .then(() => {
                            res.status(200).json({
                                message: "Jobs generated successfully",
                            });
                        })
                        .catch((error) => {
                            console.error("Error generating jobs:", error);
                            res.status(500).json({
                                error: "Internal Server Error",
                            });
                        });
                } else {
                    res.status(404).json({
                        status: "Not Found",
                        message:
                            "No subjects found for the specified school and student IDs",
                    });
                }
            }
        });
    }
);

app.get("/api/posao/skolaId=:schoolId/ucenikId=:studentId", (req, res) => {
    const schoolId = req.params.schoolId;
    const studentId = req.params.studentId;
    let sqlJobs =
        "SELECT * FROM posao inner join ucenik on ucenik_id = id where ucenik_id = ? and skola_id=?";
    db.query(sqlJobs, [studentId, schoolId], (error, results) => {
        if (error) {
            console.error("Error fetching all students:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (results && results.length !== 0) {
                res.json(results);
            } else {
                res.status(404).json({
                    status: "Not Found",
                    message: "No students found for the specified school ID",
                });
            }
        }
    });
});

// need to add school id later
app.put("/api/poslovi/ucenik/:id", (req, res) => {
    const studentId = req.params.id;
    const updatedJobInfo = req.body;
    let sqlUpdateJob = "UPDATE posao SET ? WHERE ucenik_id = ?";
    db.query(sqlUpdateJob, [updatedJobInfo, studentId], (error, result) => {
        if (error) {
            console.error("Error updating job for student:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            if (result.affectedRows > 0) {
                res.json({ message: "Job updated successfully" });
            } else {
                res.status(404).json({
                    status: "Not Found",
                    message: "No job found for the specified student ID",
                });
            }
        }
    });
});

app.get("/api/ucenik/skolaId=:schoolId", (req, res) => {
    const schoolId = req.params.schoolId;

    const sqlAll = "SELECT * FROM ucenik  WHERE skola_id = ?";
    db.query(sqlAll, [schoolId], (error, result) => {
        if (error) {
            console.log("Error finding ucenik");
            res.status(500).json({ error: "Internal Server error" });
        } else {
            if (result.length > 0) {
                res.json(result);
            } else {
                res.json({ message: "Not found" });
            }
        }
    });
});

app.post("/api/ucenik", (req, res) => {
    const { ime, prezime, razred, skola_id } = req.body;

    let sqlUpdateJob =
        "INSERT INTO ucenik (ime,prezime,razred,skola_id) values(?,?,?,?) ";
    db.query(
        sqlUpdateJob,
        [ime, prezime, razred, skola_id],
        (error, result) => {
            if (error) {
                console.error("Error updating job for student:", error);
                res.status(500).json({ error: "Internal Server Error" });
            } else {
                if (result.affectedRows > 0) {
                    res.json({ message: "Job updated successfully" });
                } else {
                    res.status(404).json({
                        status: "Not Found",
                        message: "No job found for the specified student ID",
                    });
                }
            }
        }
    );
});

app.post("/api/poslovi", (req, res) => {
    const items = req.body;

    let sql =
        "INSERT IGNORE INTO posao (item_name, item_category, item_brand, predmet_id, ucenik_id) VALUES ?";

    const values = items.map((item) => [
        item.item_name,
        item.item_category,
        item.item_brand,
        item.predmet_id,
        item.ucenik_id,
    ]);

    db.query(sql, [values], (error, result, fields) => {
        if (error) {
            console.error("Error inserting posao:", error);
            res.status(500).json({ error: "Internal Server Error" });
        } else {
            res.status(201).json({ message: "Inserted successfully" });
        }
    });
});

// app.post("/api/ucenik", (req, res) => {
//     try {
//         let sql =
//             "INSERT INTO ucenik (ime, razred, skola_id, ocene, datum, posao) VALUES (?, ?, ?, ?, ?, ?)";

//         db.query(
//             sql,
//             [
//                 ime,
//                 razred,
//                 skola_id,
//                 JSON.stringify(ocene),
//                 datum,
//                 JSON.stringify(posao),
//             ],
//             (error, results, fields) => {
//                 if (error) {
//                     console.error("Error inserting student:", error);
//                     res.status(500).json({ error: "Internal Server Error" });
//                 } else {
//                     res.status(201).json({
//                         status: "Success",
//                         id: results.insertId,
//                     });
//                 }
//             }
//         );
//     } catch (error) {
//         console.error("Error processing request:", error);
//         res.status(400).json({ error: "Bad Request" });
//     }
// });

// app.delete("/api/ucenik/:id", (req, res) => {
//     const id = req.params.id;
//     const sql = "DELETE FROM ucenik WHERE id = ?";

//     db.query(sql, [id], (error, results, fields) => {
//         if (error) {
//             console.error("Error deleting student:", error);
//             res.status(500).json({ error: "Internal Server Error" });
//         } else {
//             if (results.affectedRows > 0) {
//                 res.status(200).json({
//                     status: "Success",
//                     message: "Student deleted successfully",
//                 });
//             } else {
//                 res.status(404).json({
//                     status: "Not Found",
//                     message: "Student not found",
//                 });
//             }
//         }
//     });
// });

// app.get("/api/skola/:idSkola/ucenik/", (req, res) => {
//     let idSkola = req.params.idSkola;
//     let sqlAll = "SELECT * FROM ucenik WHERE skola_id = ?";
//     db.query(sqlAll, [idSkola], (error, results, fields) => {
//         if (results && results.length !== 0) {
//             res.json(results);
//         } else {
//             res.status(404).json({ status: "Not Found" });
//         }
//     });
// });

// app.get("/api/scrape/:posao", (req, res) => {
//     let posao = req.params.posao;
//     scraper.scrape(posao, (error, result) => {
//         if (error) {
//             console.error("Error:", error);
//         } else {
//             res.json(result);
//         }
//     });
// });

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});
