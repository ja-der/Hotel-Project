import React from "react";
import "./Client.css"; // Import CSS

const ResultCard = ({
  result,
  arrivalDate,
  departureDate,
  clientId,
  onSearch,
}) => {
  const handleBookNow = async (result, event) => {
    event.preventDefault();
    try {
      const response = await fetch(
        "http://localhost:4000/api/makeReservation",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            arrivalDate: arrivalDate,
            departureDate: departureDate,
            clientId: clientId, // Pass the clientId
            hotelId: result.hotelid,
            roomId: result.roomid,
            chainId: result.chainid,
          }),
        }
      );
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      // Show notification upon successful booking
      alert("Reservation booked successfully!");
      onSearch();
    } catch (error) {
      console.error("Error booking reservation:", error);
    }
  };
  return (
    <div className="result-card">
      <div className="header">
        <h3>{result.chainname}</h3>
        <p>
          {result.hotelcity}, {result.country}
        </p>
      </div>
      <div className="details">
        <p>
          <strong>CheckIn Date:</strong> {arrivalDate}
        </p>
        <p>
          <strong>CheckOut Date:</strong> {departureDate}
        </p>
        <p>
          <strong>Price:</strong> ${result.price}
        </p>
        <p>
          <strong>Capacity:</strong> {result.capacity}
        </p>
        <p>
          <strong>View:</strong> {result.view}
        </p>
        <p>
          <strong>Extendable:</strong> {result.extendable}
        </p>
        <p>
          <strong>Issues:</strong> {result.issues}
        </p>
        <p>
          <strong>Amenities:</strong> {result.amenities}
        </p>
      </div>
      <button
        className="book-now-button"
        onClick={(event) => handleBookNow(result, event)}
      >
        Book Now
      </button>
    </div>
  );
};

export default ResultCard;
