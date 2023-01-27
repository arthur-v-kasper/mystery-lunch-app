import React, { useEffect } from "react";
import AppBar from "@mui/material/AppBar";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import { useMysteryLunch } from "../context/MysteryLunchContext";

const Navbar = () => {
  const { handleOpenLogin, handleLogout, authToken } = useMysteryLunch();
  console.log({ authToken });
  const handleAuthentication = authToken ? handleLogout : handleOpenLogin;
  const textAuthButton = authToken ? "Logout" : "Login";

  return (
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }} />
        <Button color="inherit" onClick={handleAuthentication}>
          {textAuthButton}
        </Button>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar;
