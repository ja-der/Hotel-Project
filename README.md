# ehotels
EHotels Web Application for CSI 2531 Final Project
Built with React.js for frontend, Node.js and Express for backend, and PostgreSQL for the database.

## Installation guide
### Note: Make sure to have Node.js and PostgreSQL installed.

### Database
Please create a database, we suggest naming it `ehotel`. Then execute the queries in `data.sql`. 

Make sure that the database is running on port `5432`

### Frontend

1. In the command line interface, navigate to `/frontend` directory by running the command `cd frontend`. 
2. Run `npm i` to install the required modules
3. Run `npm start` to activate the front-end part. To stop the application, run command `Ctrl + C`.

Make sure the front-end application run on `http://localhost:3000`

### Backend

1. Navigate to `/backend` directory by running `cd backend`. If you are previously in `/frontend` directory, go back to the main directory by running `cd ../`. 
2. Create an `.env` file in the `/backend` directory and include the following information   

```
    POSTGRES_USER = "postgres" //change it to your postgresql user
    HOST = "localhost"
    DATABASE = "ehotel" // change it accordingly to your database name
    PASSWORD = "12345" // change it to your postgresql user password
    jwtSecret = "secret"
```

3. Run `npm i` to install the required dependencies. Then run `npm i nodemon` to install Nodemon.
4. Run `nodemon index` to start the backend server. To terminate the server, run `Ctrl + C` in the command line.

Make sure the back-end application run on `http://localhost:4000`