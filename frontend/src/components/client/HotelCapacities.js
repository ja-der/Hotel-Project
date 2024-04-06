import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";

const HotelCapacities = () => {
  // State to hold hotel capacities data
  const [hotelCapacities, setHotelCapacities] = useState([]);

  // Function to fetch hotel capacities data
  const fetchHotelCapacities = async () => {
    try {
      // Fetch hotel capacities data from your API endpoint for all chains and hotels
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
    <div>
      <h2>Hotel Capacities of </h2>
      {/* Display hotel capacities data */}
      <table>
        <thead>
          <tr>
            <th>Hotel ID</th>
            <th>Hotel Address</th>
            <th>Total Capacity</th>
            <th>Chain ID</th>
          </tr>
        </thead>
        <tbody>
          {hotelCapacities.map((hotel) => (
            <tr key={hotel.HotelID}>
              <td>{hotel.hotelid}</td>
              <td>{hotel.hoteladdress}</td>
              <td>{hotel.totalcapacity}</td>
              <td>{hotel.ChainName}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default HotelCapacities;
