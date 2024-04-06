import React, { useState, useEffect } from "react";
import "./Client.css"; //  // Import CSS file
import ResultCard from "./ResultCard"; // Adjust the path as necessary

const HotelBookingForm = ({ onToggleShowList, clientId }) => {
  const today = new Date().toISOString().split("T")[0]; // Get today's date in "yyyy-mm-dd" format
  const [formData, setFormData] = useState({
    arrivalDate: today,
    departureDate: today,
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

  const [availableRoomsPerCity, setAvailableRoomsPerCity] = useState([]);

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

  useEffect(() => {
    const fetchAvailableRoomsPerCity = async () => {
      try {
        const response = await fetch(
          "http://localhost:4000/api/availableRoomsPerCity"
        );
        if (!response.ok) throw new Error("Network response was not ok");
        const data = await response.json();
        console.log(data);

        setAvailableRoomsPerCity(data);
      } catch (error) {
        console.error("Error fetching available rooms per city:", error);
      }
    };

    fetchAvailableRoomsPerCity();
  }, []);

  const fetchAvailableRoomsPerCity = async () => {
    try {
      const response = await fetch(
        "http://localhost:4000/api/availableRoomsPerCity"
      );
      if (!response.ok) throw new Error("Network response was not ok");
      const data = await response.json();
      console.log(data);

      setAvailableRoomsPerCity(data);
    } catch (error) {
      console.error("Error fetching available rooms per city:", error);
    }
  };

  // Function to trigger search
  const searchRooms = async () => {
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

  const handleSubmit = async (event) => {
    event.preventDefault();
    await searchRooms();
  };

  return (
    <>
      <div className="results-container">
        <h2>Available Rooms Per City</h2>
        <table>
          <thead>
            <tr>
              <th>City</th>
              <th>Available Rooms</th>
            </tr>
          </thead>
          <tbody>
            {availableRoomsPerCity.map((cityData, index) => (
              <tr key={index}>
                <td>{cityData.hotelcity}</td>
                <td>{cityData.availablerooms}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
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
            <option value="Schimmel-Zieme">Schimmel-Zieme</option>
            <option value="Walsh and Sons">Walsh and Sons</option>
            <option value="Halvorson-Hettinger">Halvorson-Hettinger</option>
            <option value="Goyette Group">Goyette Group</option>
            <option value="Jaskolski Inc">Jaskolski Inc</option>
          </select>
        </label>
        <label>
          City:
          <select
            name="city"
            value={formData.city}
            onChange={handleInputChange}
          >
            <option value="">Any</option>
            <option value="Toronto">Toronto</option>
            <option value="Montreal">Montreal</option>
            <option value="Ottawa">Ottawa</option>
            <option value="Kingston">Kingston</option>
            <option value="Quebec City">Quebec City</option>
            <option value="Vancouver">Vancouver</option>
            <option value="Calgary">Calgary</option>
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
            <option value="200">$200</option>
            <option value="300">$300</option>
            <option value="400">$400</option>
            <option value="500">$400</option>
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
            <option value="200">$200</option>
            <option value="300">$300</option>
            <option value="400">$400</option>
            <option value="500">$500</option>
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
          <select
            name="view"
            value={formData.view}
            onChange={handleInputChange}
          >
            <option value="">Any</option>
            <option value="Ocean View">Ocean View</option>
            <option value="Mountain View">Mountain View</option>
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
                name="Mini Fridge"
                checked={formData.amenities.includes("Mini Fridge")}
                onChange={handleAmenitiesChange}
              />
              Mini Fridge
            </div>
            <div className="amenities-checkbox">
              <input
                type="checkbox"
                name="Balcony"
                checked={formData.amenities.includes("Balcony")}
                onChange={handleAmenitiesChange}
              />
              Balcony
            </div>
            <div className="amenities-checkbox">
              <input
                type="checkbox"
                name="Coffee Maker"
                checked={formData.amenities.includes("Coffee Maker")}
                onChange={handleAmenitiesChange}
              />
              Coffee Maker
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
            <div className="amenities-checkbox">
              <input
                type="checkbox"
                name="Kitchenette"
                checked={formData.amenities.includes("Kitchenette")}
                onChange={handleAmenitiesChange}
              />
              Kitchenette
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
              clientId={clientId}
              onSearch={searchRooms}
              onRefreshAvailableRoomsPerCity={fetchAvailableRoomsPerCity}
            />
          ))}
        </div>
      </form>
    </>
  );
};

export default HotelBookingForm;
