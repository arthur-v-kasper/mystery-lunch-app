import React, { useContext, createContext, useState } from "react";

export const MysteryLunchContext = createContext();

export function MysteryLunchProvider({ children }) {
  const [openLogin, setOpenLogin] = useState(false);

  const handleOpenLogin = () => {
    console.log("chamandoooo");
    setOpenLogin(true);
  };

  const handleCloseLogin = () => {
    setOpenLogin(false);
  };

  return (
    <MysteryLunchContext.Provider
      value={{ openLogin, handleOpenLogin, handleCloseLogin }}
    >
      {children}
    </MysteryLunchContext.Provider>
  );
}

export const useMysteryLunch = () => useContext(MysteryLunchContext);
