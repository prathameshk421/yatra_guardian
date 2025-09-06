const express = require("express");
const passport = require("passport");
const { signup, login, oauthCallback } = require("../controllers/authController");

const router = express.Router();

// Normal signup/login
router.post("/signup", signup);
router.post("/login", login);

// google authentication routes 
router.get("/google", passport.authenticate("google", { scope: ["profile", "email"] }));
router.get("/google/callback", passport.authenticate("google", { failureRedirect: "/login" }), oauthCallback);

// apple authentication routes 
router.get("/apple", passport.authenticate("apple"));
router.post("/apple/callback", passport.authenticate("apple", { failureRedirect: "/login" }), oauthCallback);

module.exports = router;
