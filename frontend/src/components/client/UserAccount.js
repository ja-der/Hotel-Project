import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
function UserAccount() {
  const navigate = useNavigate();
  const [user, setUser] = useState({
    firstName: "",
    lastName: "",
    address: "",
    ssn: "",
    email: "",
  });
  async function getUser() {
    try {
      const response = await fetch("http://localhost:4000/dashboard/", {
        method: "GET",
        headers: { token: localStorage.token },
      });
      const parseRes = await response.json();
      console.log(parseRes);
      setUser({
        firstName: parseRes.clientfirstname,
        lastName: parseRes.clientlastname,
        address: parseRes.clientaddress,
        ssn: parseRes.clientssn,
        email: parseRes.clientemail,
      });
    } catch (err) {
      console.error(err.message);
    }
  }
  useEffect(() => {
    getUser();
  }, []);

  useEffect(() => {
    // Fetch user info
    fetch("http://localhost:4000/api/personalInfo/${user.email}")
      .then((res) => res.json())
      .catch((error) => console.error("Error fetching user data:", error));
  }, []);
  const goToClientHomepage = () => {
    navigate("/clienthomepage");
  };
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setUser((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Submit updated info
    // fetch("/api/user", {
    //   method: "PUT",
    //   headers: { "Content-Type": "application/json" },
    //   body: JSON.stringify(user),
    // })
    //   .then((res) => res.json())
    //   .then((data) => console.log("User updated:", data))
    //   .catch((error) => console.error("Error updating user:", error));
  };

  return (
    <form onSubmit={handleSubmit}>
      <h1>{user.firstName}</h1>

      <label>
        First Name:
        <input
          type="text"
          name="firstName"
          value={user.firstName}
          onChange={handleInputChange}
          required
        />
      </label>

      <label>
        Last Name:
        <input
          type="text"
          name="lastName"
          value={user.lastName}
          onChange={handleInputChange}
          required
        />
      </label>

      <label>
        Address:
        <input
          type="text"
          name="address"
          value={user.address}
          onChange={handleInputChange}
          required
        />
      </label>

      <label>
        SSN:
        <input
          type="text"
          name="ssn"
          value={user.ssn}
          onChange={handleInputChange}
          required
        />
      </label>

      <label>
        Email:
        <input
          type="email"
          name="email"
          value={user.email}
          onChange={handleInputChange}
          required
        />
      </label>

      <button type="submit">Update Information</button>
      <button type="button" onClick={goToClientHomepage}>
        HomePage
      </button>
    </form>
  );
}

export default UserAccount;
