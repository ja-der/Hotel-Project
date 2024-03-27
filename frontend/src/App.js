import './App.css';
import React, {Fragment, useState} from 'react';
import {BrowserRouter as Router, Route, Routes, Navigate} from 'react-router-dom';

// Components
import Dashboard from './components/Dashboard';
import Login from './components/Login';
import Signup from './components/Signup';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const setAuth = (boolean) => {
    setIsAuthenticated(boolean);
  }

  return (
    <Fragment>
      <Router>
        <div className="container">
          <Routes>
            <Route path='/login' element={!isAuthenticated ? <Login setAuth={setAuth} /> : <Navigate to='/dashboard'/>} />
            <Route path='/signup' element={!isAuthenticated ? <Signup setAuth={setAuth}  /> : <Navigate to='/dashboard'/>} />
            <Route path='/dashboard' element={!isAuthenticated ? <Navigate to='/login'/> : <Dashboard setAuth={setAuth} />} />          
          </Routes>
        </div>
      </Router>
    </Fragment>
  );
}

export default App;
