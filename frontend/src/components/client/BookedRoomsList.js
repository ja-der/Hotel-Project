import React, { useState, useEffect } from "react";
const BookedRoomsList = (props) => {
  const [rooms, setRooms] = useState({
    id: 0,
    name: "tien",
    capacity: 0,
    price: 0,
  });
  //delete function
  async function deleteReservation(reservationId) {
    try {
      const reservationId = 1;
      const response = await fetch(
        `http://localhost:4000/api/personalInfo/delete-reservation/${reservationId}`
      );

      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      setRooms(rooms.filter((room) => room.id !== reservationId));
    } catch (error) {
      console.error("Error:", error);
    }
  }
  const deleteRoom = (reservationId) => {
    setRooms(rooms.filter((room) => room.id !== reservationId));
  };
  //get reservation
  async function getReservation() {
    const clientid = 1;
    try {
      const response = await fetch(
        `http://localhost:4000/api/personalInfo/reservation/${clientid}`
      );
      if (!response.ok) {
        throw new Error("Network response was not ok " + response.statusText);
      }
      const data = await response.json(); // Convert the response body to JSON
      const transformedData = data.map((item) => ({
        name: item.roomview,
        capacity: item.capacity,
        price: item.price,
        id: item.reservationid,
      }));
      setRooms(transformedData);
    } catch (error) {
      console.error("Error:", error);
    }
  }
  useEffect(() => {
    getReservation();
  }, [rooms]);

  return (
    <div>
      <h2>Booked Rooms</h2>
      {rooms.length > 0 ? (
        <ul>
          {rooms.map((room) => (
            <li key={room.id}>
              {room.name} - Capacity: {room.capacity} - Price: ${room.price}
              <button onClick={() => deleteReservation(room.id)}>Delete</button>
            </li>
          ))}
        </ul>
      ) : (
        <p>No rooms booked yet.</p>
      )}
      <button onClick={props.onToggleShowList}>Book your next Stay!</button>
    </div>
  );
};

export default BookedRoomsList;
