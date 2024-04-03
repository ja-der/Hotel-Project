import React, {Fragment, useState, useEffect} from 'react';
import {toast} from 'react-toastify';
import {Link} from 'react-router-dom';

const RentForm = () => {
    const [inputs, setInputs] = useState({
        firstName: '',
        lastName: '',
        address: '',
        ssn: 0,
        start_date: '',
        end_date: '',
        roomID: 0,
        hotelID: 0,
        chainID: 0,
        employeeID: 0,
    });

    const {firstName, lastName, address, ssn, start_date, end_date, roomID, hotelID, chainID, employeeID} = inputs;

    // retrieve employeeID, hotelID, chainID, startDate, endDate from localStorage
    async function getInfo() {
        try {
            setInputs({ ...inputs, employeeID: localStorage.employeeID, roomID: localStorage.roomID, hotelID: localStorage.hotelID, chainID: localStorage.chainID, start_date: localStorage.startDate, end_date: localStorage.endDate });
        } catch (err) {
            console.error(err.message);
        }
    }

    useEffect(() => {
        getInfo();
    }, []);

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    const onSubmit = async e => {
        e.preventDefault();
        try {
            const body = { firstName, lastName, address, ssn, start_date, end_date, roomID, hotelID, chainID, employeeID };
            const response = await fetch("http://localhost:4000/employee/rental", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            if (parseRes.rentalid) {
                toast.success("Rental created successfully!");
            }
            else {
                toast.error(parseRes);
            }
        } catch (err) {
            console.error(err.message);
        }
    }

    const goBack = () => {
        localStorage.removeItem("roomID");
        localStorage.removeItem("hotelID");
        localStorage.removeItem("chainID");
        localStorage.removeItem("startDate");
        localStorage.removeItem("endDate");
        localStorage.removeItem("employeeID");
    }

    return (
        <Fragment>
            <h1 className="mt-5 text-center">Rental Form</h1>
            <form onSubmit={onSubmit}>
                <input
                    type="text"
                    name="firstName"
                    placeholder="First Name"
                    className="form-control my-3"
                    value={firstName}
                    onChange={onChange} required
                />
                <input
                    type="text"
                    name="lastName"
                    placeholder="Last Name"
                    className="form-control my-3"
                    value={lastName}
                    onChange={onChange} required
                />
                <input
                    type="text"
                    name="address"
                    placeholder="Address"
                    className="form-control my-3"
                    value={address}
                    onChange={onChange} required
                />
                <input
                    type="text"
                    name="ssn"
                    placeholder="SSN"
                    className="form-control my-3"
                    value={ssn}
                    onChange={onChange} required
                />
                <button className="btn btn-success btn-block">Submit</button>
                <Link to="/rental" className="btn btn-block btn-danger" onClick={goBack}>Go back</Link>
            </form>
        </Fragment>
    );
}


export default RentForm;