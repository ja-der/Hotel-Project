import React, { useState, useEffect } from "react";
import "./Client.css"; //  // Import CSS file

const BookedRoomsList = ({ onToggleShowList, clientid }) => {
  const [reservations, setReservations] = useState([]);

  async function deleteReservation(reservationId) {
    try {
      const response = await fetch(
        `http://localhost:4000/api/personalInfo/delete-reservation/${reservationId}`
      );

      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      // Filter out the deleted reservation from the reservations array
      setReservations(
        reservations.filter((reservation) => reservation.id !== reservationId)
      );
    } catch (error) {
      console.error("Error:", error);
    }
  }

  async function getReservations() {
    try {
      const response = await fetch(
        `http://localhost:4000/api/personalInfo/reservation/${clientid}`
      );
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      const data = await response.json();
      setReservations(
        data.map((item) => ({
          name: item.roomview,
          capacity: item.capacity,
          price: item.price,
          id: item.reservationid,
        }))
      );
    } catch (error) {
      console.error("Error:", error);
    }
  }

  useEffect(() => {
    getReservations();
  }, [clientid, reservations]); // Only fetch reservations when clientid changes

  return (
    <div className="booked-rooms-container">
      <h2>Booked Reservations</h2>
      {reservations.length > 0 ? (
        <ul>
          {reservations.map((reservation) => (
            <li key={reservation.id}>
              {reservation.name} - Capacity: {reservation.capacity} - Price: $
              {reservation.price}
              <button onClick={() => deleteReservation(reservation.id)}>
                Delete
              </button>
            </li>
          ))}
        </ul>
      ) : (
        <p>No reservations booked yet.</p>
      )}
      <button onClick={onToggleShowList}>Book your next Stay!</button>
    </div>
  );
};

export default BookedRoomsList;
