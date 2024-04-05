import React, { Fragment, useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const EditHotel = ({setAuth}) => {
    const [inputs, setInputs] = useState({
        employeeID: 0,
        hotelID: 0,
        hotelAddress: '',
        hotelCity: '',
        hotelPhoneNumber: 0,
        hotelEmail: '',
        starRating: 0,
        numberOfRooms: 0
    });

    const { hotelID, hotelAddress, hotelCity, hotelPhoneNumber, hotelEmail, starRating, numberOfRooms } = inputs;

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
            setInputs({ ...inputs, employeeID: parseRes.employeeid, hotelID: parseRes.hotelid});
        } catch (err) {
            console.error(err.message);
        }
    }

    // fetch hotel information
    const getHotelInfo = async () => {
        try {
            const response = await fetch(`http://localhost:4000/employee/hotelinfo?hotelID=${hotelID}`)
            const parseRes = await response.json();
            setInputs({ ...inputs, hotelAddress: parseRes.hoteladdress, hotelCity: parseRes.hotelcity, hotelPhoneNumber: parseRes.hotelphonenumber, hotelEmail: parseRes.hotelemail, starRating: parseRes.starrating, numberOfRooms: parseRes.numberofrooms });
        } catch (err) {
            console.error(err.message);
        }
    }

    useEffect(() => {
        getEmployeeInfo();
    }, []);

    useEffect(() => {
        if (inputs.hotelID !== 0) {
            getHotelInfo();
        }
    }, [inputs.hotelID]);


    const navigate = useNavigate();

    const onSubmitForm = async e => {
        e.preventDefault();
        try {
            const body = { hotelID, hotelAddress, hotelCity, hotelPhoneNumber, hotelEmail, starRating, numberOfRooms };
            const response = await fetch("http://localhost:4000/employee/updatehotel", {
                method: "PUT",
                headers: {
                    "Content-type": "application/json",
                    token: localStorage.token
                },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            if (parseRes.hotelid) {
                toast.success("Hotel information updated successfully");
                navigate("/employeehomepage");
            } else {
                toast.error(parseRes);
            }
        } catch (err) {
            console.error(err.message);
        }
    }

    const deleteHotel = async e => {
        e.preventDefault();
        try {
            const response = await fetch(`http://localhost:4000/employee/deletehotel?hotelID=${hotelID}`, {
                method: "DELETE",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            if (parseRes.hotelid) {
                toast.success("Hotel deleted successfully");
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
          <h1 className="mt-5 text-center">Edit Hotel Information</h1>
          <form onSubmit={onSubmitForm}>
            <label htmlFor="hotelAddress">Hotel Address</label>
            <input
              type="text"
              name="hotelAddress"
              placeholder="Address"
              className="form-control mb-2"
              value={hotelAddress}
              onChange={e => onChange(e)}
              required
            />
            <label htmlFor="hotelCity">Hotel City</label>
            <input
              type="text"
              name="hotelCity"
              placeholder="City"
              className="form-control mb-2"
              value={hotelCity}
              onChange={e => onChange(e)}
              required
            />
            <label htmlFor="hotelPhoneNumber">Hotel Phone Number</label>
            <input
              type="text"
              name="hotelPhoneNumber"
              placeholder="Phone Number"
              className="form-control mb-2"
              value={hotelPhoneNumber}
              onChange={e => onChange(e)}
              required
            />
            <label htmlFor="hotelEmail">Hotel Email</label>
            <input
              type="email"
              name="hotelEmail"
              placeholder="Email"
              className="form-control mb-2"
              value={hotelEmail}
              onChange={e => onChange(e)}
              required
            />
            <label htmlFor="numberOfRooms">Number of Rooms</label>
            <input
              type="number"
              name="numberOfRooms"
              placeholder="Number of Rooms"
              className="form-control mb-2"
              value={numberOfRooms}
              onChange={e => onChange(e)}
              required
            />
            <label htmlFor="starRating">Star Rating</label>
            <select name="starRating" className="form-control" onChange={e => onChange(e)} required>
                <option value ={starRating}>{starRating}</option>
                <option value ="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>

            <button className="btn btn-success btn-block mt-4">Update</button>
          </form>
          <button onClick={deleteHotel} className="btn btn-danger btn-block mt-2" >Delete Hotel</button>
          <Link to="/employeehomepage" className="mt-2 btn btn-warning btn-block">Go back</Link>
        </Fragment>
      );
}

export default EditHotel;