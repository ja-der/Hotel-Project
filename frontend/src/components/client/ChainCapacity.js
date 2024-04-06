import React from "react";
import HotelCapacities from "./HotelCapacities";

const ChainCapacity = () => {
  return (
    <div>
      {/* Repeat HotelCapacities component 5 times for each chain */}
      <HotelCapacities chainName="1" />
      <HotelCapacities chainName="2" />
      <HotelCapacities chainName="3" />
      <HotelCapacities chainName="4" />
      <HotelCapacities chainName="5" />
    </div>
  );
};

export default ChainCapacity;
