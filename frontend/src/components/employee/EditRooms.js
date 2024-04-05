import React, {Fragment, useState, useEffect} from 'react';
import {Link} from 'react-router-dom';
import { toast } from 'react-toastify';

const EditRooms = () => {

    const [inputs, setInputs] = useState({
        roomID: 0,
        hotelID: 0,
        chainID: 0
    });

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    const [rooms, setRooms] = useState([]);
    const {roomID, hotelID, chainID} = inputs;

    // retrieve employeeID, hotelID, chainID from localStorage
    async function getInfo() {
        try {
            const response = await fetch("http://localhost:4000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });
            const parseRes = await response.json();
            setInputs({ ...inputs, employeeID: parseRes.employeeid, hotelID: parseRes.hotelid, chainID: parseRes.chainid });
        } catch (err) {
            console.error(err.message);
        }
    }

    // get all the rooms of the hotel from hotelID and chainID
    async function getRooms() {
        try {
            const response = await fetch(`http://localhost:4000/employee/rooms?hotelID=${hotelID}&chainID=${chainID}`);
            const parseRes = await response.json();
            setRooms(parseRes);
        } catch (err) {
            console.error(err.message);
        }
    }

    // search for a specific room
    const onSearch = async e => {
        e.preventDefault();
        if (roomID === 0 || roomID === "") {
            getRooms();
        }
        try {
            const response = await fetch(`http://localhost:4000/employee/room?roomID=${roomID}&hotelID=${hotelID}&chainID=${chainID}`);
            const parseRes = await response.json();
            if (parseRes !== "Room does not exist") {
                setRooms([parseRes]);
            }
            else {
                setRooms([]);
            }
        } catch (err) {
            console.error(err.message);
        }
    }

    useEffect(() => {
        getInfo();
    }, []);

    useEffect(() => {
        if (hotelID !== 0) {
            getRooms();
        }
    } , [hotelID]);

    const deleteRoom = async (roomID) => {
        try {
            const deleteRoom = await fetch(`http://localhost:4000/employee/deleteroom?roomID=${roomID}`, {
                method: "DELETE"
            });

            setRooms(rooms.filter(room => room.roomid !== roomID));
            const parseRes = await deleteRoom.json();
            if (parseRes.roomid) {
                toast.success("Room deleted successfully!");
            }
            else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    const onEdit = async (roomID) => {
        localStorage.setItem("roomID", roomID);
        localStorage.setItem("hotelID", hotelID);
        localStorage.setItem("chainID", chainID);
    }

    const addRoom = async () => {
        localStorage.setItem("hotelID", hotelID);
        localStorage.setItem("chainID", chainID);
    }
    return (
        <Fragment>
        <h1 className="mt-5 text-center">Search for specific room</h1>
        <form onSubmit={onSearch}>
            <input type="text" placeholder="Room ID" name="roomID" className="form-control my-3" onChange={onChange}/>
            <button className="btn btn-primary btn-block">Get room details</button>
        </form>
    
        <h2 className="text-center mt-5">Rooms Details</h2>
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
                        <td><Link to="/editroominfo" className="btn btn-success" onClick={()=> onEdit(room.roomid)}>Edit</Link></td>
                        <td><button className="btn btn-danger" onClick={() => deleteRoom(room.roomid)}>Delete</button></td>
                    </tr>
                ))}
            </tbody>
            {rooms.length === 0 && <tr><td colSpan="7">No rooms available</td></tr>}
        </table>
        <Link to="/addroom" className="btn btn-info btn-block" onClick={addRoom}>Add a room</Link>
        <Link to="/employeehomepage" className="btn btn-block btn-warning mt-2">Go back</Link>
        </Fragment>
    );
}

export default EditRooms;