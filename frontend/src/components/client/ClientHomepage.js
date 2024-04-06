import React, { Fragment, useState, useEffect } from "react";
import { toast } from "react-toastify";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import HotelBookingForm from "./HotelBookingForm";
import BookedRoomsList from "./BookedRoomsList";
import HotelCapacities from "./HotelCapacities"; // Imported the new page component

import "./Client.css";

const ClientHomepage = ({ setAuth }) => {
  const [bookings, setBookings] = useState([]); // State to hold bookings
  // Fetch bookings
  const fetchBookings = async () => {
    // Assuming you have an endpoint to fetch bookings
    const response = await fetch("API_ENDPOINT_HERE");
    if (response.ok) {
      const data = await response.json();
      setBookings(data); // Update your state with the new bookings
    }
  };

  useEffect(() => {
    fetchBookings(); // Initial fetch
  }, []);

  const navigate = useNavigate();
  // const [name, setName] = useState("");
  const [showList, setShowList] = useState(true);

  const [user, setUser] = useState({
    clientid: "",
    firstName: "",
    lastName: "",
    address: "",
    ssn: "",
    email: "",
  });
  const [clientId, setClientId] = useState(null); // State to hold client ID

  async function getUser() {
    try {
      const response = await fetch("http://localhost:4000/dashboard/", {
        method: "GET",
        headers: { token: localStorage.token },
      });
      const parseRes = await response.json();
      // console.log(parseRes);
      setUser({
        clientid: parseRes.clientid,
        firstName: parseRes.clientfirstname,
        lastName: parseRes.clientlastname,
        address: parseRes.clientaddress,
        ssn: parseRes.clientssn,
        email: parseRes.clientemail,
      });
      setClientId(parseRes.clientid); // Set the client ID in state
    } catch (err) {
      console.error(err.message);
    }
  }
  const toggleShowList = () => {
    setShowList(!showList);
  };

  const logout = (e) => {
    e.preventDefault();
    localStorage.removeItem("token");
    localStorage.removeItem("role");
    setAuth(false, "");
    toast.success("Logged out successfully");
  };

  useEffect(() => {
    getUser();
  }, []);
  const goToUserAccount = () => {
    navigate("/useraccount"); // Navigate to the UserAccount component
  };
  const goToHotelCapacities = () => {
    navigate("/chaincapacity"); // Added function to navigate to Hotel Capacities page
  };

  return (
    <Fragment>
      <h1>Hello {user.firstName}</h1>
      <p>Yay! You are logged in as a client!</p>
      <button onClick={goToUserAccount}>User Account</button>
      <button onClick={goToHotelCapacities}>Hotel Capacities</button>{" "}
      {/* Added button for navigating to Hotel Capacities page */}
      {showList ? (
        <BookedRoomsList
          onToggleShowList={toggleShowList}
          onRefresh={fetchBookings}
          clientid={user.clientid}
        />
      ) : (
        <HotelBookingForm
          onToggleShowList={toggleShowList}
          clientId={user.clientid}
        />
      )}
      <button className="btn btn-danger" onClick={(e) => logout(e)}>
        Logout
      </button>
    </Fragment>
  );
};

export default ClientHomepage;
