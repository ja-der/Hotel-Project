import React, {Fragment, useState, useEffect} from 'react';
import {toast} from 'react-toastify';

const EmployeeHomepage = ({setAuth} ) => {
    const [name, setName] = useState("");

    async function getName() {
        try {
            const response = await fetch("http://localhost:4000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            console.log(parseRes);
            setName(parseRes.employeefirstname);
        } catch (err) {
            console.error(err.message);
        }
    }

    const logout = (e) => {
        e.preventDefault();
        localStorage.removeItem("token");
        localStorage.removeItem("role");
        setAuth(false, '');
        toast.success("Logged out successfully");
    }

    
    


    useEffect(() => {
        getName();
    }, []);
    
    return (
        <Fragment>
        <div className="d-flex flex-column align-items-center justify-content-center vh-100"> 
            <h1 className="text-center mb-3">Welcome {name}!</h1>
            <div className="button-group-container" style={{ display: 'flex', justifyContent: 'center' }}>
                    <div className="btn-group-vertical">
                        <a href="#Link" className="btn btn-primary mb-3">Make a rental</a>
                        <button className="btn btn-primary mb-3">Reservation Check-in</button>
                        <button className="btn btn-danger" onClick={e => logout(e)}>Logout</button>
                    </div>
            </div>
        </div>
        </Fragment>
    );
}

export default EmployeeHomepage;