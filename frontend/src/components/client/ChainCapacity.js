import React from "react";
import HotelCapacities from "./HotelCapacities";

const ChainCapacity = () => {
  return (
    <div>
      {/* Repeat HotelCapacities component 5 times for each chain */}
      <HotelCapacities chainName="1" />
    </div>
  );
};

export default ChainCapacity;
