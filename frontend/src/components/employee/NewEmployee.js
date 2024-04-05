import React, { Fragment, useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const NewEmployee = () => {
    const [inputs, setInputs] = useState({
        firstName: '',
        lastName: '',
        address: '',
        ssn: 0,
        email: '',
        password: '',
        hotelID: 0,
        chainName: ''
    });

    const { firstName, lastName, address, ssn, email, password, hotelID, chainName } = inputs;

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    // list of chainNames
    const [chainNames, setChainNames] = useState([]);

    // list of hotelIDs
    const [hotelIDs, setHotelIDs] = useState([]);

    // get all the chainNames 
    async function getChainNames() {
        try {
            const response = await fetch("http://localhost:4000/employee/chain")
            const parseRes = await response.json();
            setChainNames(parseRes);
        } catch (err) {
            console.error(err.message);
        }
    }

    // get all the hotelIDs
    async function getHotelIDs(chainName) {
        try {
            const response = await fetch("http://localhost:4000/employee/hotel")
            const parseRes = await response.json();
            setHotelIDs(parseRes);
        } catch (err) {
            console.error(err.message);
        }
    }
            
    useEffect(() => {
        getChainNames();
        getHotelIDs();
    } , []);

    const navigate = useNavigate();

    const onSubmit = async e => {
        e.preventDefault();
        try {
            const body = { firstName, lastName, address, ssn, email, password, hotelID, chainName };
            const response = await fetch("http://localhost:4000/auth/signupemployee", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            if (parseRes.employeeid) {
                toast.success("Employee created successfully!");
                navigate("/employeehomepage");
            } else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    return (
        <Fragment>
          <h1 className="mt-5 text-center">Create new employee account</h1>
          <form onSubmit={onSubmit} >
            <input
              type="text"
              name="firstName"
              placeholder="First Name"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />
            <input
              type="text"
              name="lastName"
              placeholder="Last Name"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />
            <input
              type="text"
              name="address"
              placeholder="Address"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />
            <input
              type="number"
              name="ssn"
              placeholder="SSN"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />
            <input
              type="email"
              name="email"
              placeholder="Email"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />
            <input
              type="password"
              name="password"
              placeholder="Password"
              className="form-control my-3"
              onChange={e => onChange(e)}
              required
            />

            <select name="chainName" className="form-control my-3" onChange={e => onChange(e)} required>
                <option value="">Select Chain</option>
                {chainNames.map((chain, index) => (
                    <option key={index} value={chainNames[index]}>{chainNames[index]}</option>
                ))}
            </select>

            <select name="hotelID" className="form-control my-3" onChange={e => onChange(e)} required>
                <option value="">Select Hotel</option>
                {hotelIDs.map((hotel, index) => (
                    <option key={index} value={hotelIDs[index]}>{hotelIDs[index]}</option>
                ))}
            </select>
            <button className="btn btn-success btn-block">Submit</button>
          </form>
          <Link to="/employeehomepage" className="mt-2 btn btn-warning btn-block">Go back</Link>
        </Fragment>
      );
}

export default NewEmployee;