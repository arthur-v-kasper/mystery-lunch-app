import * as React from "react";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogTitle from "@mui/material/DialogTitle";
import { useMysteryLunch } from "../context/MysteryLunchContext";

export default function Login() {
  const { openLogin, handleCloseLogin } = useMysteryLunch();

  return (
    <div>
      <Dialog open={openLogin} onClose={handleCloseLogin}>
        <DialogTitle>Login</DialogTitle>
        <DialogContent>
          <TextField
            autoFocus
            margin="dense"
            id="user"
            label="User"
            type="text"
            fullWidth
            variant="standard"
          />
          <TextField
            margin="dense"
            id="password"
            label="Password"
            type="password"
            fullWidth
            variant="standard"
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseLogin}>Cancel</Button>
          <Button onClick={handleCloseLogin}>Login</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}
