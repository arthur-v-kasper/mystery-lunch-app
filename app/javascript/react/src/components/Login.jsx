import React, { useState } from "react";
import { useMutation } from "react-query";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogTitle from "@mui/material/DialogTitle";
import { useMysteryLunch } from "../context/MysteryLunchContext";

export default function Login() {
  const { openLogin, handleCloseLogin } = useMysteryLunch();
  const [user, setUSer] = useState("");
  const [password, setPassword] = useState("");

  // // const [postData, { status }] = useMutation(async (data) => {
  //   const response = await fetch("http://localhost:3000/auth", {
  //     method: "POST",
  //     body: JSON.stringify(data),
  //     headers: { "Content-Type": "application/json" },
  //   });
  //   return response.json();
  // // });
  // https://www.youtube.com/watch?v=r9aDSqIhiwU

  const postData = async (user) => {
    const response = await fetch("http://localhost:3000/auth", {
      method: "POST",
      body: JSON.stringify({
        user_name: user.user_name,
        password: user.password,
      }),
      headers: { "Content-Type": "application/json" },
    });
    return response.json();
  };

  const { mutate, isLoading, error } = useMutation(postData);

  const handleSubmit = (e) => {
    e.preventDefault();
    postData({ username, password });
  };

  const handleUser = (event) => setUSer(event.target.value);
  const handlePassword = (event) => setPassword(event.target.value);

  if (isLoading) return <div>Loading...</div>;
  if (error)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <div>
      <Dialog open={openLogin} onClose={handleCloseLogin}>
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
          <Button
            type="submit"
            onClick={() => mutate({ user_name: user, password: password })}
          >
            Login
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}
