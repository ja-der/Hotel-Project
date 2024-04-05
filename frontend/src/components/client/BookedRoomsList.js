import React, { useState, useEffect } from "react";

const initialRooms = [
  { id: 1, name: "Room 101", capacity: 2, price: 100 },
  { id: 2, name: "Room 102", capacity: 3, price: 150 },
  // Add more predefined rooms
];

const BookedRoomsList = (props) => {
  const [rooms, setRooms] = useState({
    id: 0,
    name: "tien",
    capacity: 0,
    price: 0,
  });

  console.log(props.user.clientid);
  const deleteRoom = (roomId) => {
    setRooms(rooms.filter((room) => room.id !== roomId));
  };
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
      console.log(data.roomview);
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
  }, []);

  return (
    <div>
      <h2>Booked Rooms</h2>
      {rooms.length > 0 ? (
        <ul>
          {rooms.map((room) => (
            <li key={room.id}>
              {room.name} - Capacity: {room.capacity} - Price: ${room.price}
              <button onClick={() => deleteRoom(room.id)}>Delete</button>
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
