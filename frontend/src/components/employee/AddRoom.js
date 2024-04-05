import React, { Fragment, useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const AddRoom = () => {
    const navigate = useNavigate();
    const [inputs, setInputs] = useState({
        hotelID: 0,
        chainID: 0,
        price: 0,
        amenities: '',
        capacity: 0,
        roomView: '',
        extendable : '',
        issues: ''
    });

    const {hotelID, chainID, price, amenities, capacity, roomView, extendable, issues} = inputs;

    // retrieve hotelID, chainID from localStorage
    async function getInfo() {
        try {
            setInputs({ ...inputs, hotelID: localStorage.hotelID, chainID: localStorage.chainID });
        } catch (err) {
            console.error(err.message);
        }
    }

    const onChange = e => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    }

    useEffect(() => {
        getInfo();
    }, []);

    const onSubmit = async e => {
        e.preventDefault();
        try {
            const body = { hotelID, chainID, price, amenities, capacity, roomView, extendable, issues };
            const response = await fetch("http://localhost:4000/employee/addroom", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            if (parseRes.roomid) {
                toast.success("Room created successfully!");
                navigate("/editrooms");
            }
            else {
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    }

    const goBack = () => {
        localStorage.removeItem("hotelID");
        localStorage.removeItem("chainID");
    }

    return (
        <Fragment>
          <h1 className="mt-5 text-center">Add a new room</h1>
            <form onSubmit={onSubmit}>
                <input type="number" name="price" placeholder="Price" className="form-control my-3" onChange={e => onChange(e)} />
                <input type="text" name="amenities" placeholder="Amenities" className="form-control my-3" onChange={e => onChange(e)} />
                <input type="number" name="capacity" placeholder="Capacity" className="form-control my-3" onChange={e => onChange(e)} />
                <input type="text" name="roomView" placeholder="Room View" className="form-control my-3" onChange={e => onChange(e)} />
                <input type="text" name="extendable" placeholder="Extendable" className="form-control my-3" onChange={e => onChange(e)} />
                <input type="text" name="issues" placeholder="Issues" className="form-control my-3" onChange={e => onChange(e)} />
                <button className="btn btn-success btn-block">Add</button>
            </form>
            <Link to="/editrooms" className="btn btn-primary mt-2 btn-block" onClick={goBack}>Go back</Link>
        </Fragment>
      );
}

export default AddRoom;