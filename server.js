const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./config/db');


//load ENV config
dotenv.config();
// connect DB
connectDB();

const app = express();

// setup cors
app.use(cors({
  origin: "*", // allow requests from this origin
  credentials: true
}));

// Routes import
const authRoutes = require('./routes/authRoutes');

//use routes
app.use('/auth', authRoutes);


// middlewares
app.use(express.json());


// running port
const port = process.env.PORT || 5000;

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
