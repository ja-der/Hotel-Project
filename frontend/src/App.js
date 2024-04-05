import "./App.css";
import React, { Fragment, useState, useEffect } from "react";
import {
  BrowserRouter as Router,
  Route,
  Routes,
  Navigate,
} from "react-router-dom";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

// Components
import ClientHomepage from "./components/client/ClientHomepage";
import EmployeeHomepage from "./components/employee/EmployeeHomepage";
import Login from "./components/Login";
import Signup from "./components/Signup";
import ReservationCheck from "./components/employee/ReservationCheck";
import Rental from "./components/employee/Rental";
import RentForm from "./components/employee/RentForm";
import UserAccount from "./components/client/UserAccount";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [role, setRole] = useState("");

  const setAuth = (boolean, userRole) => {
    setIsAuthenticated(boolean);
    if (boolean && userRole) {
      setRole(userRole);
    }
  };

  useEffect(() => {
    isAuth();
  }, []);

  async function isAuth() {
    try {
      const response = await fetch("http://localhost:4000/auth/is-verify", {
        method: "GET",
        headers: { token: localStorage.token },
      });

      const parseRes = await response.json();
      parseRes === true ? setIsAuthenticated(true) : setIsAuthenticated(false);
      parseRes === true ? setRole(localStorage.role) : setRole("");
    } catch (err) {
      console.error(err.message);
    }
  }

  const renderHomepage = () => {
    switch (role) {
      case "client":
        return <ClientHomepage setAuth={setAuth} />;
      case "employee":
        return <EmployeeHomepage setAuth={setAuth} />;
      default:
        // Redirect to login if the role is not recognized, or not authenticated
        return <Navigate to="/login" />;
    }
  };

  return (
    <Fragment>
      <Router>
        <div className="container">
          <Routes>
            <Route
              path="/login"
              element={
                !isAuthenticated ? (
                  <Login setAuth={setAuth} />
                ) : (
                  renderHomepage()
                )
              }
            />
            <Route path="/signup" element={<Signup />} />
            <Route
              path="/clienthomepage"
              element={
                !isAuthenticated ? <Navigate to="/login" /> : renderHomepage()
              }
            />
            <Route
              path="/employeehomepage"
              element={
                !isAuthenticated ? <Navigate to="/login" /> : renderHomepage()
              }
            />
            <Route
              path="/useraccount"
              element={
                !isAuthenticated ? <Navigate to="/login" /> : <UserAccount />
              }
            />
            <Route
              path="/reservationcheck"
              element={
                !isAuthenticated ? (
                  <Navigate to="/login" />
                ) : (
                  <ReservationCheck />
                )
              }
            />
            <Route
              path="/rental"
              element={!isAuthenticated ? <Navigate to="/login" /> : <Rental />}
            />
            <Route
              path="/rentform"
              element={
                !isAuthenticated ? <Navigate to="/login" /> : <RentForm />
              }
            />
            <Route path="/" element={<Navigate to="/login" />} />
          </Routes>
        </div>
      </Router>
      <ToastContainer />
    </Fragment>
  );
}

export default App;
