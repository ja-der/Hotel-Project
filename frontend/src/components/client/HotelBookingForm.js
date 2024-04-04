import React, { useState, useEffect } from "react";
import "./Client.css"; //  // Import CSS file
import ResultCard from "./ResultCard"; // Adjust the path as necessary

const HotelBookingForm = ({ onToggleShowList }) => {
  const [formData, setFormData] = useState({
    arrivalDate: "",
    departureDate: "",
    roomCapacity: "1",
    city: "",
    hotelChain: "",
    totalRooms: "1",
    starRating: "", // Added starRating field
    amenities: [], // Added amenities field
    view: "", // Added view field
    minPrice: "", // Added minprice field
    maxPrice: "", // Added maxprice field
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
      console.log(formData);
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
        Hotel Chain:
        <select
          name="hotelChain"
          value={formData.hotelChain}
          onChange={handleInputChange}
        >
          <option value="">Any</option>
          <option value="Hilton Hotel">Hilton Hotel</option>
          <option value="Mariott">Mariott</option>
          <option value="3">idk</option>
          <option value="4">anotherchain</option>
          <option value="5">random</option>
        </select>
      </label>
      <label>
        City:
        <select name="city" value={formData.city} onChange={handleInputChange}>
          <option value="">Any</option>
          <option value="United States">United States</option>
          <option value="Ottawa">2- Ottawa</option>
          <option value="Montreal">Montreal</option>
          <option value="Vancouver">Vancouver</option>
          <option value="Halifax">Halifax</option>
        </select>
      </label>
      <label>
        Select Minimum Star Rating
        <select
          name="starRating"
          value={formData.starRating}
          onChange={handleInputChange}
        >
          <option value="">Any</option>
          <option value="1">1 Star</option>
          <option value="2">2 Stars</option>
          <option value="3">3 Stars</option>
          <option value="4">4 Stars</option>
          <option value="5">5 Stars</option>
        </select>
      </label>
      <label>
        Select Minimum Price (per night):
        <select
          name="minPrice"
          value={formData.minPrice}
          onChange={handleInputChange}
        >
          <option value="">Any</option>
          <option value="100">$100</option>
          <option value="500">$500</option>
          <option value="1000">$1000</option>
          <option value="1500">$1500</option>
        </select>
      </label>
      <label>
        Select Maximum Price (per night):
        <select
          name="maxPrice"
          value={formData.maxPrice}
          onChange={handleInputChange}
        >
          <option value="">Any</option>
          <option value="500">$500</option>
          <option value="1000">$1000</option>
          <option value="1500">$1500</option>
          <option value="2000">$2000</option>
        </select>
      </label>
      <br />
      <br />

      <h3>Additional Criteria</h3>
      <label>
        Room Capacity:
        <input
          type="number"
          name="roomCapacity"
          value={formData.roomCapacity}
          onChange={handleInputChange}
          min="1"
          max="10"
        />
      </label>
      <label>
        Number of Available Rooms in hotel:
        <input
          type="number"
          name="totalRooms"
          value={formData.totalRooms}
          onChange={handleInputChange}
          min="1"
          max="10"
        />
      </label>
      <label>
        View:
        <select name="view" value={formData.view} onChange={handleInputChange}>
          <option value="">Any</option>
          <option value="Sea">Sea View</option>
          <option value="Mountain">Mountain View</option>
          <option value="City">City View</option>
          <option value="Garden">Garden View</option>
        </select>
      </label>
      <br />
      <br />
      <label>
        Amenities:
        <div className="amenities-container">
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="Wi-Fi"
              checked={formData.amenities.includes("Wi-Fi")}
              onChange={handleAmenitiesChange}
            />
            Free Wi-Fi
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="TV"
              checked={formData.amenities.includes("TV")}
              onChange={handleAmenitiesChange}
            />
            TV
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
              name="Jacuzzi"
              checked={formData.amenities.includes("Jacuzzi")}
              onChange={handleAmenitiesChange}
            />
            Jacuzzi
          </div>
          <div className="amenities-checkbox">
            <input
              type="checkbox"
              name="AC"
              checked={formData.amenities.includes("AC")}
              onChange={handleAmenitiesChange}
            />
            AC
          </div>
        </div>
      </label>
      <br />

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
