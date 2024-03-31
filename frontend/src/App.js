import './App.css';
import React, {Fragment, useState} from 'react';
import {BrowserRouter as Router, Route, Routes, Navigate} from 'react-router-dom';

// Components
import ClientHomepage from './components/ClientHomepage';
import EmployeeHomepage from './components/EmployeeHomepage';
import Login from './components/Login';
import Signup from './components/Signup';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [role, setRole] = useState('');

  const setAuth = (boolean, userRole) => {
    setIsAuthenticated(boolean);
    if (boolean && userRole) {
      setRole(userRole);
    }
  }

  const renderHomepage = () => {
    switch (role) {
      case 'client':
        return <ClientHomepage setAuth={setAuth} />;
      case 'employee':
        return <EmployeeHomepage setAuth={setAuth} />;
      default:
        // Redirect to login if the role is not recognized, or not authenticated
        return <Navigate to='/login'/>;
    }
  };


  return (
    <Fragment>
      <Router>
        <div className="container">
          <Routes>
            <Route path='/login' element={!isAuthenticated ? <Login setAuth={setAuth} /> : renderHomepage()} />
            <Route path='/signup' element={!isAuthenticated ? <Signup setAuth={setAuth}  /> : renderHomepage()} />
            <Route path='/clienthomepage' element={!isAuthenticated ? <Navigate to='/login'/> : renderHomepage()} /> 
            <Route path='/employeehomepage' element={!isAuthenticated ? <Navigate to='/login'/> : renderHomepage()} />          
          </Routes>
        </div>
      </Router>
    </Fragment>
  );
}

export default App;
