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
import ReservationCheck from './components/employee/ReservationCheck';
import Rental from './components/employee/Rental';
import RentForm from './components/employee/RentForm';
import NewEmployee from './components/employee/NewEmployee';
import EditProfile from './components/employee/EditProfile';
import EditHotel from './components/employee/EditHotel';
import EditRooms from './components/employee/EditRooms';
import EditRoomInfo from './components/employee/EditRoomInfo';
import AddRoom from './components/employee/AddRoom';

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
            <Route path='/login' element={!isAuthenticated ? <Login setAuth={setAuth} /> : renderHomepage()} />
            <Route path='/signup' element={<Signup/>}/>
            <Route path='/clienthomepage' element={!isAuthenticated ? <Navigate to='/login'/> : renderHomepage()} /> 
            <Route path='/employeehomepage' element={!isAuthenticated ? <Navigate to='/login'/> : renderHomepage()} /> 
            <Route path='/reservationcheck' element={!isAuthenticated ? <Navigate to='/login'/> : <ReservationCheck/>} />     
            <Route path='/rental' element={!isAuthenticated ? <Navigate to='/login'/> : <Rental setAuth={setAuth}/>} />   
            <Route path='/rentform' element={!isAuthenticated ? <Navigate to='/login'/> : <RentForm setAuth={setAuth}/>} />
            <Route path='/newaccount' element={!isAuthenticated ? <Navigate to='/login'/> : <NewEmployee setAuth={setAuth}/>} />
            <Route path='/editprofile' element={!isAuthenticated ? <Navigate to='/login'/> : <EditProfile setAuth={setAuth}/>} />
            <Route path='/edithotel' element={!isAuthenticated ? <Navigate to='/login'/> : <EditHotel setAuth={setAuth}/>} />
            <Route path='/editrooms' element={!isAuthenticated ? <Navigate to='/login'/> : <EditRooms setAuth={setAuth}/>} />
            <Route path='/editroominfo' element={!isAuthenticated ? <Navigate to='/login'/> : <EditRoomInfo setAuth={setAuth}/>} />
            <Route path='/addroom' element={!isAuthenticated ? <Navigate to='/login'/> : <AddRoom setAuth={setAuth}/>} />
            <Route path='/' element={<Navigate to='/login'/>}/> 
          </Routes>
        </div>
      </Router>
      <ToastContainer />
    </Fragment>
  );
}

export default App;
