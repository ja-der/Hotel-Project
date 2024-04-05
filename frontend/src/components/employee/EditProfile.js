import React, { Fragment, useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const EditProfile = ({setAuth}) => {
    const [inputs, setInputs] = useState({
        employeeID: '',
        firstName: '',
        lastName: '',
        address: '',
        ssn: 0,
        email: '',
        password: '',
        hotelID: 0,
        chainName: '',
        chainID: 0
    });

    const { employeeID, firstName, lastName, address, ssn, email, password, hotelID, chainName, chainID } = inputs;

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    // fetch employee information
    const getEmployeeInfo = async () => {
        try {
            const response = await fetch("http://localhost:4000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            setInputs({ ...inputs, employeeID: parseRes.employeeid, firstName: parseRes.employeefirstname, lastName: parseRes.employeelastname, address: parseRes.employeeaddress, ssn: parseRes.employeessn, email: parseRes.employeeemail, password: parseRes.employeepassword, hotelID: parseRes.hotelid, chainID: parseRes.chainid });
        } catch (err) {
            console.error(err.message);
        }
    }

    // get chainName from chainID
    const getChainName = async () => {
        try {
            const response = await fetch(`http://localhost:4000/employee/chainID?chainID=${inputs.chainID}`)
            const parseRes = await response.json();
            setInputs({ ...inputs, chainName: parseRes.chainname });
            console.log(chainName);
        } catch (err) {
            console.error(err.message);
        }
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
    async function getHotelIDs() {
        try {
            const response = await fetch("http://localhost:4000/employee/hotel")
            const parseRes = await response.json();
            setHotelIDs(parseRes);
        } catch (err) {
            console.error(err.message);
        }
    }
            
    useEffect(() => {
        getEmployeeInfo();
    }, []);

    useEffect(() => {
        if (inputs.chainID !== 0) {
            getChainName();
        }
    }, [inputs.chainID]); 

    useEffect(() => {
        getChainNames();
        getHotelIDs();
    } , []);

    const navigate = useNavigate();

    const editProfile = async e => {
        e.preventDefault();
        try {
            const body = { employeeID, firstName, lastName, address, ssn, email, password, hotelID, chainName };
            const response = await fetch("http://localhost:4000/employee/update", {
                method: "PUT",
                headers: { "Content-Type": "application/json", token: localStorage.token },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            if (parseRes.employeeid) {
                toast.success("Profile updated successfully!");
                navigate("/employeehomepage");
            } else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    const deleteAccount = async e => {
        e.preventDefault();
        try {
            const response = await fetch(`http://localhost:4000/employee/delete?employeeID=${employeeID}`, {
                method: "DELETE",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            if (parseRes.employeeid)
            {
                toast.success("Account deleted successfully!");
                localStorage.removeItem("token");
                localStorage.removeItem("role");
                setAuth(false, '');
                navigate("/login");
            } else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    return (
        <Fragment>
          <h1 className="mt-5 text-center">Edit Profile</h1>
          <form onSubmit={editProfile} >
            <input
              type="text"
              name="firstName"
              placeholder="First Name"
              className="form-control my-3"
              value={firstName}
              onChange={e => onChange(e)}
              required
            />
            <input
              type="text"
              name="lastName"
              placeholder="Last Name"
              className="form-control my-3"
              value={lastName}
              onChange={e => onChange(e)}
              required
            />
            <input
              type="text"
              name="address"
              placeholder="Address"
              className="form-control my-3"
              value={address}
              onChange={e => onChange(e)}
              required
            />
            <input
              type="number"
              name="ssn"
              placeholder="SSN"
              className="form-control my-3"
              value={ssn}
              onChange={e => onChange(e)}
              required
            />
            <input
              type="email"
              name="email"
              placeholder="Email"
              className="form-control my-3"
                value={email}
              onChange={e => onChange(e)}
              required
            />
            <input
              type="password"
              name="password"
              placeholder="Password"
              className="form-control my-3"
              value={password}
              onChange={e => onChange(e)}
              required
            />

            <select name="chainName" className="form-control my-3" onChange={e => onChange(e)} required>
                <option >{chainName}</option>
                {chainNames.map((chain, index) => (
                    <option key={index} value={chainNames[index]}>{chainNames[index]}</option>
                ))}
            </select>

            <select name="hotelID" className="form-control my-3" onChange={e => onChange(e)} required>
                <option value={hotelID}>{hotelID}</option>
                {hotelIDs.map((hotel, index) => (
                    <option key={index} value={hotelIDs[index]}>{hotelIDs[index]}</option>
                ))}
            </select>
            <button className="btn btn-success btn-block">Submit</button>
          </form>
          <button className="btn btn-danger btn-block mt-2" onClick={deleteAccount}>Delete Account</button>
          <Link to="/employeehomepage" className="mt-2 btn btn-warning btn-block">Go back</Link>
        </Fragment>
      );
}

export default EditProfile;