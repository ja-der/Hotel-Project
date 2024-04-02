import React, { Fragment, useState, useEffect } from "react";
import { toast } from "react-toastify";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import HotelBookingForm from "./HotelBookingForm";
import BookedRoomsList from "./BookedRoomsList";

const ClientHomepage = ({ setAuth }) => {
  const [name, setName] = useState("");

  async function getName() {
    try {
      const response = await fetch("http://localhost:4000/dashboard/", {
        method: "GET",
        headers: { token: localStorage.token },
      });

      const parseRes = await response.json();
      setName(parseRes.clientfirstname);
    } catch (err) {
      console.error(err.message);
    }
  }

  const logout = (e) => {
    e.preventDefault();
    localStorage.removeItem("token");
    localStorage.removeItem("role");
    setAuth(false, "");
    toast.success("Logged out successfully");
  };

  useEffect(() => {
    getName();
  }, []);

  return (
    <Fragment>
      <h1>Hello {name}</h1>
      <p>Yay! You are logged in as a client!</p>
      <Routes>
        <Route path="/" element={<HotelBookingForm />} />
        <Route path="/booked-rooms" element={<BookedRoomsList />} />
      </Routes>
      <button className="btn btn-danger" onClick={(e) => logout(e)}>
        Logout
      </button>
    </Fragment>
  );
};

export default ClientHomepage;
