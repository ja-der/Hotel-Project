import React, { useState } from "react";

const initialRooms = [
  { id: 1, name: "Room 101", capacity: 2, price: 100 },
  { id: 2, name: "Room 102", capacity: 3, price: 150 },
  // Add more predefined rooms
];

const BookedRoomsList = ({ onToggleShowList }) => {
  const [rooms, setRooms] = useState(initialRooms);

  const deleteRoom = (roomId) => {
    setRooms(rooms.filter((room) => room.id !== roomId));
  };

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
      <button onClick={onToggleShowList}>Book your next Stay!</button>
    </div>
  );
};

export default BookedRoomsList;
