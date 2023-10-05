const express = require('express');
const app = express();
const port = 3000;

// Set the view engine to EJS
app.set('view engine', 'ejs');

// Parse URL-encoded bodies (as sent by HTML forms)
app.use(express.urlencoded({ extended: false }));

// Render the login form
app.get('/login', (req, res) => {
  res.render('login');
});

// Handle login form submission
app.post('/login', (req, res) => {
  const { email, password } = req.body;
  // Perform login validation and authentication here
  // Replace this with your actual implementation

  // For demonstration purposes, we'll simply render a success message
  res.render('success', { message: 'Login successful!' });
});

// Render the registration form
app.get('/register', (req, res) => {
  res.render('register');
});

// Handle registration form submission
app.post('/register', (req, res) => {
  const { email, password } = req.body;
  // Perform registration validation and user creation here
  // Replace this with your actual implementation

  // For demonstration purposes, we'll simply render a success message
  res.render('success', { message: 'Registration successful!' });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
