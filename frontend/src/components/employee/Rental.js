import React, {Fragment, useState, useEffect} from 'react';
import {Link} from 'react-router-dom';

const Rental = ({setAuth}) => {
    const [search, setSearch] = useState({
        minPrice: 0,
        maxPrice: 10000,
        capacity: "any",
        startDate: "",
        endDate: "",
    });

    const [inputs, setInputs] = useState({
        roomID: 0,
        hotelID: 0,
        chainID: 0,
        employeeID: 0,
    });

    const [rooms, setRooms] = useState([]);

    const {minPrice, maxPrice, capacity, startDate, endDate} = search;
    const {hotelID, chainID, employeeID} = inputs;

    // retrieve employeeID, hotelID, chainID from localStorage
    async function getInfo() {
        try {
            const response = await fetch("http://localhost:4000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });
            const parseRes = await response.json();
            setInputs({ ...inputs, employeeID: parseRes.employeeid, hotelID: parseRes.hotelid, chainID: parseRes.chainid });
            
            // set minimum date for the start date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById("startDate").setAttribute('min', today);

            // set minimum date for the end date to one day after the chosen date
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const tomorrowString = tomorrow.toISOString().split('T')[0];
            document.getElementById("endDate").setAttribute('min', tomorrowString);

        } catch (err) {
            console.error(err.message);
        }
    }

    useEffect(() => {
        getInfo();
    }, []);

    const onChange = e => {
        setSearch({ ...search, [e.target.id]: e.target.value });
    }

    const onSearch = async e => {
        e.preventDefault();
        try {
            const body = { hotelID, chainID, minPrice, maxPrice, capacity, startDate, endDate };
            const response = await fetch("http://localhost:4000/employee/rooms", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });
            const parseRes = await response.json();
            setRooms(parseRes);
        } catch (err) {
            console.error(err.message);
        }
    }

    const onRent = async (roomID) => {
        // store the info in localStorage: start date, end date, roomID, hotelID, chainID, employeeID
        localStorage.setItem("startDate", startDate);
        localStorage.setItem("endDate", endDate);
        localStorage.setItem("roomID", roomID);
        localStorage.setItem("hotelID", hotelID);
        localStorage.setItem("chainID", chainID);
        localStorage.setItem("employeeID", employeeID);
    }

    return (
        <Fragment>
        <h1 className="mt-5 text-center">Search for rooms</h1>
        <form onSubmit={onSearch}>
            <div className="form-row">
                <div className="form-group col-md-6">
                    <label htmlFor="minPrice">Minimum Price</label>
                    <input type="number" className="form-control" id="minPrice" placeholder="0" min="0" max="10000" value={minPrice} onChange={onChange} required/>
                </div>
                <div className="form-group col-md-6">
                    <label htmlFor="maxPrice">Maximum Price</label>
                    <input type="number" className="form-control" id="maxPrice" placeholder="10000" min="0" max="10000" value={maxPrice} onChange={onChange} required/>
                </div>
            </div>
            <div className="form-row">
                <div className="form-group col-md-6">
                    <label htmlFor="startDate">Start Date</label>
                    <input type="date" className="form-control" value={startDate} onChange={onChange} id="startDate" required/>
                </div>
                <div className="form-group col-md-6">
                    <label htmlFor="endDate">End Date</label>
                    <input type="date" className="form-control" id="endDate" value={endDate} onChange={onChange} required/>
                </div>
            </div>
            <div className="form-row">
                <div className="form-group col-md-6">
                    <label htmlFor="capacity">Capacity</label>
                    <select id="capacity" className="form-control" value={capacity} onChange={onChange}required>
                        <option value="any">Any</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                </div>
            </div>
            <button type="submit" className="btn btn-primary btn-block">Search</button>
        </form>

        <Link to="/employeehomepage" className="btn btn-block btn-warning mt-2">Go back</Link>

        <h2 className="text-center mt-5">Available Rooms</h2>
        <table className="table mt-4 mb-5 text-center">
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Price</th>
                    <th>Capacity</th>
                    <th>Amenities</th>
                    <th>View</th>
                    <th>Extendable</th>
                    <th>Issues</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {rooms.map(room => (
                    <tr key={room.roomid}>
                        <td>{room.roomid}</td>
                        <td>{room.price}</td>
                        <td>{room.capacity}</td>
                        <td>{room.amenities}</td>
                        <td>{room.roomview}</td>
                        <td>{room.extendable}</td>
                        <td>{room.issues}</td>
                        <td>
                            <Link to="/RentForm" className="btn btn-warning" onClick={() => onRent(room.roomid)}>Rent</Link>
                        </td>
                    </tr>
                ))}
                
            </tbody>
            {rooms.length === 0 && <tr><td colSpan="7">No rooms available</td></tr>}
        </table>

        </Fragment>
    );
}

export default Rental;