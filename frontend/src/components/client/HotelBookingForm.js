import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

const HotelBookingForm = () => {
  const [formData, setFormData] = useState({
    arrivalDate: "",
    roomCapacity: "",
    area: "",
    hotelChain: "",
    totalRooms: "",
    price: "",
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    console.log("Form Data Submitted:", formData);
    // Add your submission logic here (e.g., sending data to a server)
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Arrival Date:
        <input
          type="date"
          name="arrivalDate"
          value={formData.arrivalDate}
          onChange={handleInputChange}
        />
      </label>
      <br />
      <label>
        Room Capacity:
        <input
          type="number"
          name="roomCapacity"
          value={formData.roomCapacity}
          onChange={handleInputChange}
        />
      </label>
      <br />
      <label>
        Area:
        <select name="area" value={formData.area} onChange={handleInputChange}>
          <option value="">Select Area</option>
          {/* Add options here */}
        </select>
      </label>
      <br />
      <label>
        Hotel Chain:
        <select
          name="hotelChain"
          value={formData.hotelChain}
          onChange={handleInputChange}
        >
          <option value="">Select Hotel Chain</option>
          {/* Add options here */}
        </select>
      </label>
      <br />
      <label>
        Total Rooms:
        <input
          type="number"
          name="totalRooms"
          value={formData.totalRooms}
          onChange={handleInputChange}
        />
      </label>
      <br />
      <label>
        Price:
        <input
          type="number"
          name="price"
          step="0.01"
          value={formData.price}
          onChange={handleInputChange}
        />
      </label>
      <br />
      <button type="submit">Submit</button>
    </form>
  );
};

export default HotelBookingForm;
