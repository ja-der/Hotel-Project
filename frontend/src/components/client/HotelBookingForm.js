import React, { useState, useEffect } from "react";

const HotelBookingForm = ({ onToggleShowList }) => {
  const [formData, setFormData] = useState({
    arrivalDate: "",
    roomCapacity: "",
    area: "",
    hotelChain: "",
    totalRooms: "",
    price: "",
  });
  
  const [hotelChains, setHotelChains] = useState([]);
  useEffect(() => {
    const fetchHotelChains = async () => {
      try {
        const response = await fetch('/api/hotelChains');
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();
        setHotelChains(data);
      } catch (error) {
        console.error('Error fetching hotel chains:', error);
      }
    };

    fetchHotelChains();
  }, []);

  const [hotelAreas, setHotelAreas] = useState([]);
  useEffect(() => {
    const fetchHotelAreas = async () => {
      try {
        const response = await fetch('/api/hotelAreas');
        if (!response.ok) throw new Error('Network response was not ok');
        const data = await response.json();
        setHotelAreas(data);
      } catch (error) {
        console.error('Error fetching hotel areas:', error);
      }
    };
  
    fetchHotelAreas();
  }, []);
  
  
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
    onToggleShowList();
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
    {hotelAreas.map((area, index) => (
      <option key={index} value={area}>{area}</option>
    ))}
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
  {hotelChains.map((chain) => (
    <option key={chain.ChainID} value={chain.ChainID}>
      {chain.ChainName}
    </option>
  ))}
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
