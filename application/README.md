# Login/Registration App

This is a simple login/registration app built with Node.js.

## Installation

1. Make sure you have Node.js installed on your machine. You can download it from the official website: https://nodejs.org/

2. Clone this repository or download the source code.

3. Open a terminal or command prompt and navigate to the project directory.

## Usage

1. Start the application by running the following command:

node app.js


The application will start running and display a message indicating the server is running on `http://localhost:3000`.

2. Open a web browser and access the following URLs:
- Login form: `http://localhost:3000/login`
- Registration form: `http://localhost:3000/register`

Use the provided login and registration forms to interact with the application.

3. Customize the application's behavior by modifying the route handlers in the `app.js` file.

## File Structure

- `app.js`: The main application file that sets up the server and handles routes.
- `views/`: This directory contains the EJS templates for login, registration, and success pages.

## Dependencies

This project has the following dependencies:
- express
- ejs

You can install them by running the following command in the project directory:

npm install express ejs
?