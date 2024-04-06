import React, { useState, useEffect } from "react";
import "./Client.css"; //  // Import CSS file

const HotelCapacities = () => {
  // State to hold hotel capacities data
  const [hotelCapacities, setHotelCapacities] = useState([]);

  // Function to fetch hotel capacities data
  const fetchHotelCapacities = async () => {
    try {
      const response = await fetch(
        "http://localhost:4000/api/findHotelCapacity"
      );
      if (response.ok) {
        const data = await response.json();
        setHotelCapacities(data); // Update state with the fetched data
      } else {
        console.error("Failed to fetch hotel capacities data");
      }
    } catch (error) {
      console.error("Error fetching hotel capacities data:", error);
    }
  };

  useEffect(() => {
    fetchHotelCapacities(); // Fetch hotel capacities data on component mount
  }, []);

  return (
    <div className="roomCapacityDisplay">
      <h1>Hotel Room Capacities</h1>
      <table>
        <thead>
          <tr>
            <th>Chain ID</th>
            <th>Chain Name</th>
            <th>Hotel Address</th>
            <th>Hotel ID</th>
            <th>Total Capacity</th>
          </tr>
        </thead>
        <tbody>
          {hotelCapacities.map((hotel) => (
            <tr key={`${hotel.chainid}-${hotel.hotelid}`}>
              <td>{hotel.chainid}</td>
              <td>{hotel.chainname}</td>
              <td>{hotel.chainaddress}</td>
              <td>{hotel.hotelid}</td>
              <td>{hotel.totalcapacity}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default HotelCapacities;
