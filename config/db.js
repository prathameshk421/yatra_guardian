const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

function connectDB() {
 
  const mongoURI = process.env.MONGO_URI;

  mongoose.connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => {
    console.log('MongoDB connected');
  })
  .catch((err) => {
    console.error('MongoDB connection error:', err);
  });
}

module.exports = connectDB;
