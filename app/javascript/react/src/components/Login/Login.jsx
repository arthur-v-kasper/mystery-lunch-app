import React, { useState } from "react";
import { useMutation } from "react-query";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogTitle from "@mui/material/DialogTitle";
import { useMysteryLunch } from "../../context/MysteryLunchContext";
import { postLoginData } from "../../services/fetchApi";

export default function Login() {
  const { openLogin, handleCloseLogin, handleAuthToken } = useMysteryLunch();
  const [user, setUSer] = useState("");
  const [password, setPassword] = useState("");

  const { mutateAsync, isLoading, error } = useMutation(postLoginData);

  const handleLogin = async () => {
    const response = await mutateAsync({
      user_name: user,
      password: password,
    });
    const authToken = response?.token;
    if (authToken) handleAuthToken(authToken);
    handleCloseLogin();
  };

  const handleUser = (event) => setUSer(event.target.value);
  const handlePassword = (event) => setPassword(event.target.value);

  if (isLoading) return <div>Loading...</div>;
  if (error)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <div>
      <Dialog open={openLogin}>
        <DialogTitle>Login</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            id="user_name"
            label="User"
            type="text"
            fullWidth
            variant="standard"
            value={user}
            onChange={handleUser}
          />
          <TextField
            margin="dense"
            id="password"
            label="Password"
            type="password"
            fullWidth
            variant="standard"
            value={password}
            onChange={handlePassword}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseLogin}>Cancel</Button>
          <Button onClick={() => handleLogin()}>Login</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}
