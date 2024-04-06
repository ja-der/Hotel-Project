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
          {result.hotelcity}, {result.hoteladdress}
        </p>
      </div>
      <div className="details">
        <div className="hotel-info">
          <p>
            <strong>Hotel Phone Number:</strong> {result.hotelphonenumber}
          </p>
          <p>
            <strong>Star Rating:</strong> {result.starrating}
          </p>
        </div>
        <div className="room-info">
          <p>
            <strong>Room Price:</strong> ${result.price}
          </p>
          <p>
            <strong>Room Capacity:</strong> {result.capacity}
          </p>
          <p>
            <strong>Room View:</strong> {result.roomview}
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
      </div>
      <div className="booking-info">
        <p>
          <strong>Check-In Date:</strong> {arrivalDate}
        </p>
        <p>
          <strong>Check-Out Date:</strong> {departureDate}
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
