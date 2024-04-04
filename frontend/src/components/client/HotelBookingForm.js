import React, { useState, useEffect } from "react";
import "./Client.css"; // Import CSS file
import ResultCard from "./ResultCard"; // Adjust the path as necessary

const HotelBookingForm = ({ onToggleShowList }) => {
  const [formData, setFormData] = useState({
    arrivalDate: "",
    departureDate: "",
    roomCapacity: "",
    city: "",
    hotelChain: "",
    totalRooms: "1",
    price: "",
    starRating: "", // Added starRating field
    amenities: [], // Added amenities field
    view: "", // Added view field
  });

  const [hotelChains, setHotelChains] = useState([]);
  useEffect(() => {
    const fetchHotelChains = async () => {
      try {
        const response = await fetch("http://localhost:4000/api/hotelChains");
        if (!response.ok) throw new Error("Network response was not ok");
        const data = await response.json();
        setHotelChains(data);
      } catch (error) {
        console.error("Error fetching hotel chains:", error);
      }
    };

    fetchHotelChains();
  }, []);

  const [hotelCities, setHotelCities] = useState([]);
  useEffect(() => {
    const fetchHotelCities = async () => {
      try {
        const response = await fetch("http://localhost:4000/api/hotelCities");
        if (!response.ok) throw new Error("Network response was not ok");
        const data = await response.json();
        setHotelCities(data);
      } catch (error) {
        console.error("Error fetching hotel cities:", error);
      }
    };

    fetchHotelCities();
  }, []);

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleAmenitiesChange = (event) => {
    const { name, checked } = event.target;
    setFormData((prevState) => {
      let updatedAmenities;
      if (checked) {
        updatedAmenities = [...prevState.amenities, name];
      } else {
        updatedAmenities = prevState.amenities.filter(
          (amenity) => amenity !== name
        );
      }
      return { ...prevState, amenities: updatedAmenities };
    });
  };

  const [searchResults, setSearchResults] = useState([]);
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const queryParams = new URLSearchParams(formData);
      const url = `http://localhost:4000/api/searchRooms?${queryParams}`;
      const response = await fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      });
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      const data = await response.json();
      setSearchResults(data);
    } catch (error) {
      console.error("Error searching hotels:", error);
    }
  };

  const handleBookNow = async (result) => {
    try {
      const response = await fetch(
        "http://localhost:4000/api/bookReservation",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            arrivalDate: formData.arrivalDate,
            departureDate: formData.departureDate,
            // clientId: /* Provide the client ID here */,
            hotelId: result.hotelId, // Adjust as per your result object structure
            roomId: result.roomId, // Adjust as per your result object structure
          }),
        }
      );
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      // Show notification upon successful booking
      alert("Reservation booked successfully!");
      // Clear the search form back to default
      setFormData({
        arrivalDate: "",
        departureDate: "",
        roomCapacity: "",
        city: "",
        hotelChain: "",
        totalRooms: "1",
        price: "",
        starRating: "",
        amenities: [],
        view: "",
      });
      setSearchResults([]);
    } catch (error) {
      console.error("Error booking reservation:", error);
    }
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
      <label>
        Departure Date:
        <input
          type="date"
          name="departureDate"
          value={formData.departureDate}
          onChange={handleInputChange}
        />
      </label>
      <br />

      <label>
        Room Capacity:
        <input
          type="number"
          name="totalRooms"
          value={formData.totalRooms}
          onChange={handleInputChange}
          min="0"
          max="10"
        />
      </label>
      <br />

      <label>
        City:
        <select name="city" value={formData.city} onChange={handleInputChange}>
          <option value="">Select City</option>
          {hotelCities.map((city) => (
            <option key={city.hotelid} value={city.hotelid}>
              {city.hotelcity}
            </option>
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
            <option key={chain.chainid} value={chain.chainid}>
              {chain.chainname}
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
          min="0"
          max="10"
        />
      </label>
      <br />
      <label>
        Price Range:
        <input
          type="number"
          step="100"
          value={formData.price}
          onChange={handleInputChange}
        />
      </label>
      <br />
      <label>
        Star Rating:
        <select
          name="starRating"
          value={formData.starRating}
          onChange={handleInputChange}
        >
          <option value="">Select Star Rating</option>
          <option value="1">1 Star</option>
          <option value="2">2 Stars</option>
          <option value="3">3 Stars</option>
          <option value="4">4 Stars</option>
          <option value="5">5 Stars</option>
        </select>
      </label>
      <br />
      <label>
        Amenities:
        <div className="amenities-container">
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="freeWifi"
              checked={formData.amenities.includes("freeWifi")}
              onChange={handleAmenitiesChange}
            />
            Free WiFi
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="tv"
              checked={formData.amenities.includes("tv")}
              onChange={handleAmenitiesChange}
            />
            TV
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="minibar"
              checked={formData.amenities.includes("minibar")}
              onChange={handleAmenitiesChange}
            />
            Minibar
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="roomService"
              checked={formData.amenities.includes("roomService")}
              onChange={handleAmenitiesChange}
            />
            Room Service
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="balcony"
              checked={formData.amenities.includes("balcony")}
              onChange={handleAmenitiesChange}
            />
            Balcony
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="jacuzzi"
              checked={formData.amenities.includes("jacuzzi")}
              onChange={handleAmenitiesChange}
            />
            Jacuzzi
          </div>
        </div>
      </label>
      <br />
      <label>
        View:
        <select name="view" value={formData.view} onChange={handleInputChange}>
          <option value="">Select View</option>
          <option value="sea">Sea View</option>
          <option value="mountain">Mountain View</option>
          <option value="city">City View</option>
          <option value="garden">Garden View</option>
        </select>
      </label>
      <br />

      <button type="submit">Search</button>

      <div className="results-container">
        {searchResults.map((result, index) => (
          <ResultCard
            key={index}
            result={result}
            arrivalDate={formData.arrivalDate}
            departureDate={formData.departureDate}
          />
        ))}
      </div>
    </form>
  );
};

export default HotelBookingForm;
