import React from "react";

const ResultCard = ({ result }) => {
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
      <button className="book-now-button">Book Now</button>
    </div>
  );
};

export default ResultCard;
