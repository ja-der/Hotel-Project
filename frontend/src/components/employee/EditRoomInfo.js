import React, {Fragment, useState, useEffect} from 'react';
import {toast} from 'react-toastify';
import {Link} from 'react-router-dom';
import { useNavigate } from 'react-router-dom';

const EditRoomInfo = () => {
    const navigate = useNavigate();
    const [inputs, setInputs] = useState({
        roomID: 0,
        hotelID: 0,
        chainID: 0,
        price: 0,
        amenities: '',
        capacity: 0,
        roomView: '',
        extendable : '',
        issues: ''
    });

    const {roomID, hotelID, chainID, price, amenities, capacity, roomView, extendable, issues} = inputs;

    // retrieve employeeID, hotelID, chainID from localStorage
    async function getInfo() {
        try {
            setInputs({ ...inputs, roomID: localStorage.roomID, hotelID: localStorage.hotelID, chainID: localStorage.chainID});
        } catch (err) {
            console.error(err.message);
        }
    }

    // fetch room information
    const getRoomInfo = async () => {
        try {
            const response = await fetch(`http://localhost:4000/employee/room?roomID=${roomID}&hotelID=${hotelID}&chainID=${chainID}`)
            const parseRes = await response.json();
            setInputs({ ...inputs, price: parseRes.price, amenities: parseRes.amenities, capacity: parseRes.capacity, roomView: parseRes.roomview, extendable: parseRes.extendable, issues: parseRes.issues });
        } catch (err) {
            console.error(err.message);
        }
    }

    useEffect(() => {
        getInfo();
    }, []);

    useEffect(() => {
        if (inputs.roomID !== 0) {
            getRoomInfo();
        }
    }, [inputs.roomID]);

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }


    const goBack = () => {
        localStorage.removeItem("roomID");
        localStorage.removeItem("hotelID");
        localStorage.removeItem("chainID");
        navigate('/editrooms');
    }

    const onSubmitForm = async e => {
        e.preventDefault();
        try {
            const body = { roomID, hotelID, chainID, price, amenities, capacity, roomView, extendable, issues };
            const response = await fetch("http://localhost:4000/employee/updateroom", {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();

            // Display success message if the room is edited
            if (parseRes.roomid) {
                toast.success("Room information updated successfully!");
                goBack();
            } else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    return (
        <Fragment>
            <h1 className="mt-5 text-center">Room {roomID} information</h1>
            <form onSubmit={onSubmitForm} >
                <label htmlFor="price">Price</label>
                <input
                    type="text"
                    name="price"
                    placeholder="Price"
                    className="form-control mb-2"
                    value={price}
                    onChange={e => onChange(e)}
                    required
                />
                <label htmlFor="amenities">Amenities</label>
                <input
                    type="text"
                    name="amenities"
                    placeholder="Amenities"
                    className="form-control mb-2"
                    value={amenities}
                    onChange={e => onChange(e)}
                    required
                />
                <label htmlFor="capacity">Capacity</label>
                <input
                    type="text"
                    name="capacity"
                    placeholder="Capacity"
                    className="form-control mb-2"
                    value={capacity}
                    onChange={e => onChange(e)}
                    required
                />
                <label htmlFor="roomView">Room View</label>
                <input
                    type="text"
                    name="roomView"
                    placeholder="Room View"
                    className="form-control mb-2"
                    value={roomView}
                    onChange={e => onChange(e)}
                    required
                />
                <label htmlFor="extendable">Extendable</label>
                <input
                    type="text"
                    name="extendable"
                    placeholder="Extendable"
                    className="form-control mb-2"
                    value={extendable}
                    onChange={e => onChange(e)}
                    required
                />
                <label htmlFor="issues">Issues</label>
                <input
                    type="text"
                    name="issues"
                    placeholder="Issues"
                    className="form-control mb-2"
                    value={issues}
                    onChange={e => onChange(e)}
                    required
                />
                <button className="btn btn-success btn-block mt-3">Update</button>
            </form>
            <button className="btn btn-warning btn-block mt-2" onClick={goBack}>Go back</button>
        </Fragment>
    );
}


export default EditRoomInfo;