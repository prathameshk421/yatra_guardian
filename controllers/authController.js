const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/User");

function generateToken(user) {
  return jwt.sign(
    { id: user._id, email: user.email },
    process.env.JWT_SECRET,
    { expiresIn: "7d" }
  );
}

// Normal signup
exports.signup = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    let user = await User.findOne({ email });
    if (user) return res.status(400).json({ error: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);
    user = await User.create({ name, email, password: hashedPassword });

    const token = generateToken(user);
    res.json({ success: true, token, user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Normal login
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user || !user.password) {
      return res.status(400).json({ error: "Invalid credentials" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ error: "Invalid credentials" });

    const token = generateToken(user);
    res.json({ success: true, token, user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Google/Apple login handled by passport → return JWT
exports.oauthCallback = (req, res) => {
  const token = generateToken(req.user);
  res.json({ success: true, provider: req.user.googleId ? "google" : "apple", token, user: req.user });
};
