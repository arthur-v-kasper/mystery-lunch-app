import React, { useContext, createContext, useState } from "react";
import useCookie, { getCookie } from "react-use-cookie";

export const MysteryLunchContext = createContext();

export function MysteryLunchProvider({ children }) {
  const [openLogin, setOpenLogin] = useState(false);
  const [formEmployee, setFormEmployee] = useState(false);
  const [currentEmployee, setCurrentEmployee] = useState(0);
  const [openDelete, setOpenDelete] = React.useState(false);
  const valueCookie = getCookie("authtoken");
  const [authToken, setAuthToken] = useCookie("authtoken", valueCookie);

  const handleOpenLogin = () => {
    setOpenLogin(true);
  };

  const handleCloseLogin = () => {
    setOpenLogin(false);
  };

  const showFormEmployee = () => {
    setFormEmployee(true);
  };

  const hideFormEmployee = () => {
    setFormEmployee(false);
  };

  const handleAuthToken = (authToken) => {
    setAuthToken(authToken);
  };

  const handleLogout = () => {
    setAuthToken("");
  };

  const showDeleteEmployee = () => {
    setOpenDelete(true);
  };

  const hideDeleteEmployee = () => {
    setOpenDelete(false);
  };

  return (
    <MysteryLunchContext.Provider
      value={{
        openLogin,
        authToken,
        formEmployee,
        handleOpenLogin,
        handleCloseLogin,
        handleAuthToken,
        handleLogout,
        showFormEmployee,
        hideFormEmployee,
        setCurrentEmployee,
        currentEmployee,
        showDeleteEmployee,
        hideDeleteEmployee,
        openDelete,
      }}
    >
      {children}
    </MysteryLunchContext.Provider>
  );
}

export const useMysteryLunch = () => useContext(MysteryLunchContext);
