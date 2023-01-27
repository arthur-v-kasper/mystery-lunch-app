import React, { useContext, createContext, useState } from "react";
import useCookie, { getCookie } from "react-use-cookie";

export const MysteryLunchContext = createContext();

export function MysteryLunchProvider({ children }) {
  const [openLogin, setOpenLogin] = useState(false);
  const valueCookie = getCookie("authtoken");
  console.log({ valueCookie });
  const [authToken, setAuthToken] = useCookie("authtoken", valueCookie);

  const handleOpenLogin = () => {
    setOpenLogin(true);
  };

  const handleCloseLogin = () => {
    setOpenLogin(false);
  };

  const handleAuthToken = (authToken) => {
    setAuthToken(authToken);
  };

  const handleLogout = () => {
    setAuthToken("");
  };

  return (
    <MysteryLunchContext.Provider
      value={{
        openLogin,
        handleOpenLogin,
        handleCloseLogin,
        handleAuthToken,
        handleLogout,
        authToken,
      }}
    >
      {children}
    </MysteryLunchContext.Provider>
  );
}

export const useMysteryLunch = () => useContext(MysteryLunchContext);
