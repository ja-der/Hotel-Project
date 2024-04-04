import React, {Fragment, useState, useEffect} from 'react';
import {toast} from 'react-toastify';
import {Link} from 'react-router-dom';

const ReservationCheck = ( ) => {
    const [inputs, setInputs] = useState({
        reservationID: '',
        employeeID: '',
    });

    const [clientID, setClientID] = useState("");
    const [firstName, setFirstName] = useState("");
    const [lastName, setLastName] = useState("");
    const [startDate, setStartDate] = useState("");
    const [endDate, setEndDate] = useState("");
    const [roomID, setRoomID] = useState("");
    const [employeeHotelID, setHotelID] = useState("");
    const [employeeChainID, setChainID] = useState("");
    

    const {reservationID, employeeID} = inputs;

    // retrieve employeeID from localStorage
    async function getEmployeeID() {
        try {
            const response = await fetch("http://localhost:4000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            setInputs({ ...inputs, employeeID: parseRes.employeeid });
            setHotelID(parseRes.hotelid);
            setChainID(parseRes.chainid);

        } catch (err) {
            console.error(err.message);
        }
    }
    
    
    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    useEffect(() => {
        getEmployeeID();
    }, []);


    const onCheckin = async e => {
        e.preventDefault();
        try {
            const body = { reservationID, employeeID};
            const response = await fetch("http://localhost:4000/employee/checkin", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();

            // Display success message if the reservation is checked in
            if (parseRes.rentalid) {
                toast.success("Reservation checked in successfully!");
            } else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }


    // Retrieve reservation details using get request
    const onSubmitForm = async e => {
        e.preventDefault();
        try {
            // clear the fields
            setClientID("");
            setFirstName("");
            setLastName("");
            setStartDate("");
            setEndDate("");
            setRoomID("");

            const response = await fetch(`http://localhost:4000/employee/reservation?reservationID=${reservationID}`);
            const parseRes = await response.json();

            // check if the reservation is at the hotel of the employee
            if (parseRes.hotelid !== employeeHotelID || parseRes.chainid !== employeeChainID) {
                toast.error("Reservation does not exist");
                return;
            }
            setClientID(parseRes.clientid);
            setFirstName(parseRes.clientfirstname);
            setLastName(parseRes.clientlastname);
            setStartDate(trimDate(parseRes.checkindate));
            setEndDate(trimDate(parseRes.checkoutdate));
            setRoomID(parseRes.roomid);

        } catch (err) {
            toast.error("Reservation does not exist");
            console.error(err.message);
        }
    }

    // Trim the date to display only the date
    function trimDate(date) {
        return date.substring(0, 10);
    }
    


    return (
        <Fragment>
            <div className="d-flex flex-column align-items-center justify-content-center vh-100">
        <h1 className="text-center">Reservation Check-in</h1>
        <form onSubmit={onSubmitForm}>
            <input type="text" placeholder="Reservation ID" name="reservationID" className="form-control my-3" onChange={onChange} required/>
            <button className="btn btn-primary btn-block">Get reservation details</button>
        </form>

        <h2 className="text-center mt-5">Reservation Details</h2>
        <table className="table mt-4 mb-5 text-center">
            <thead>
                <tr>
                    <th>Reservation ID</th>
                    <th>Client ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Room ID</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>{reservationID}</td>
                    <td>{clientID}</td>
                    <td>{firstName}</td>
                    <td>{lastName}</td>
                    <td>{startDate}</td>
                    <td>{endDate}</td>
                    <td>{roomID}</td>
                </tr>
            </tbody>
        </table>
        <div className="d-flex flex-row align-items-center justify-content-center">
        <button className="btn btn-success btn-lg mr-5" onClick={onCheckin}>Check-in</button>
        <Link to="/employeehomepage" className="btn btn-lg btn-warning">Go back</Link>
        </div>
    </div>
        </Fragment>
    );
}

export default ReservationCheck;