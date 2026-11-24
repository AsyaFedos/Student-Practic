require("dotenv").config();
const express = require("express");
const session = require("express-session");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const server = express();
const PORT = process.env.PORT;

server.use(express.static(__dirname, { index: false }));
server.use(express.json());
server.use(express.urlencoded({ extended: false }));

const conn = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    connectionLimit: 5,
});

server.use(
    session({
        secret: process.env.SECRET_KEY,
        resave: false,
        saveUninitialized: true,
        cookie: { secure: false },
    }),
);

server.get("/", checkAuth, (req, res) => {
    res.sendFile(__dirname + "/index.html");
});

server.get("/auth", (req, res) => {
    res.sendFile(__dirname + "/auth.html");
});

server.post("/login", (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    conn.query(
        "SELECT * FROM users WHERE email = ?",
        [email],
        (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).send({ message: "Ошибка сервера" });
            }

            if (results.length == 0) {
                return res.status(404).send({ message: "Пользователь не найден" });
            } else {
                const user = results[0];
                bcrypt.compare(password, user.pass, (err, isMatch) => {
                    if (isMatch) {
                        req.session.user = {
                            id: user.id_user,
                        };
                        return res.send({
                            message: "Вы успешно вошли в свой аккаунт",
                            redirect: "/",
                        });
                    } else {
                        return res
                            .status(401)
                            .send({ message: "Неправильный логин или пароль" });
                    }
                });
            }
        },
    );
});

server.post("/register", (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    if (!email || !password) {
        return res.status(400).send({ message: "Введите логин и пароль" });
    }

    conn.query(
        "SELECT * FROM users WHERE email = ?",
        [email],
        (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).send({ message: "Ошибка сервера" });
            }

            if (results.length > 0) {
                return res.send({ message: "Данный логин уже занят" });
            }
            bcrypt.hash(password, 10, (err, hashPassword) => {
                if (err) {
                    return res
                        .status(500)
                        .send({ message: "Ошибка при хешировании пароля" });
                } else {
                    conn.query(
                        "INSERT INTO users(email, pass) values (?,?)",
                        [email, hashPassword],
                        (err, results) => {
                            if (err) {
                                console.log(err);
                                return res.status(500).send({
                                    message: "Ошибка при добавлении в БД",
                                });
                            } else {
                                req.session.user = {
                                    id: results.insertId,
                                };
                                return res.send({
                                    message: "Вы успешно зарегистрировались",
                                    redirect: "/",
                                });
                            }
                        },
                    );
                }
            });
        },
    );
});

function checkAuth(req, res, next) {
    if (req.session.user) {
        next();
        console.log(req.session.user)
    } else {
        res.redirect("/auth");
        console.log(req.session.user)
    }
}

server.get("/exitAccount", (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.log(err);
            return res.status(500).send({ message: "Ошибка выхода" });
        }
        res.redirect("/auth");
    });
});

server.post("/signUp", (req, res) => {
    conn.query(
        "UPDATE users SET registered = ? WHERE id_user = ?",
        [1, req.session.user.id],
        (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).send({ message: "Ошибка при записи" });
            }

            if (results.length == 0) {
                return res.status(404).send({ message: "Пользователь не найден" });
            }
            
            return res.send({message: "Вы успешно записаны"})
        },
    );
});

server.get("/getEvents", (req, res) => {
    conn.query("SELECT time_event, title_event, description_event, speakers_event FROM events", (err, results) => {
        if (err) {
            console.log(err)
            return res.status(500).send({ message: 'Ошибка при выполнении запроса.' });
        }
        return res.json(results);
    })
})

server.listen(PORT, () => {
    console.log(`Сервер запущен на порту: ${PORT}`);
});
