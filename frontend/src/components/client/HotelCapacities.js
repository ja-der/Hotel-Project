// HotelCapacities.js

import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";

const HotelCapacities = ({ chainName }) => {
  // State to hold hotel capacities data
  const [hotelCapacities, setHotelCapacities] = useState([]);

  // Function to fetch hotel capacities data
  const fetchHotelCapacities = async () => {
    try {
      // Fetch hotel capacities data from your API endpoint for the specified chain
      const response = await fetch(
        `http://localhost:4000/api/findHotelCapacity?chainName=${chainName}`
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
  }, [chainName]);

  return (
    <div>
      <h2>Hotel Capacities of {chainName}</h2>
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

HotelCapacities.propTypes = {
  chainName: PropTypes.string.isRequired,
};

export default HotelCapacities;
