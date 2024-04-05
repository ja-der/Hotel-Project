import React, { Fragment, useState, useEffect } from "react";
import { toast } from "react-toastify";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import HotelBookingForm from "./HotelBookingForm";
import BookedRoomsList from "./BookedRoomsList";

import "./Client.css";

const ClientHomepage = ({ setAuth }) => {
  const navigate = useNavigate();
  // const [name, setName] = useState("");
  const [showList, setShowList] = useState(true);

  // async function getName() {
  //   try {
  //     const response = await fetch("http://localhost:4000/dashboard/", {
  //       method: "GET",
  //       headers: { token: localStorage.token },
  //     });

  //     const parseRes = await response.json();
  //     console.log(parseRes);
  //     setName(parseRes.clientfirstname);
  //   } catch (err) {
  //     console.error(err.message);
  //   }
  // }
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

  return (
    <Fragment>
      <h1>Hello {user.firstName}</h1>
      <p>Yay! You are logged in as a client!</p>
      <button onClick={goToUserAccount}>User Account</button>
      {showList ? (
        <BookedRoomsList onToggleShowList={toggleShowList} user={user} />
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
