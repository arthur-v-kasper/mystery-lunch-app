import React, { useState } from "react";
import { useMutation } from "react-query";
import Alert from "@mui/material/Alert";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogTitle from "@mui/material/DialogTitle";
import { useMysteryLunch } from "../context/MysteryLunchContext";
import { deleteEmployeeData } from "../services/fetchApi";

export default function DeleteEmployee({ employeeId, refetch }) {
  const { hideDeleteEmployee, openDelete } = useMysteryLunch();
  const { mutateAsync } = useMutation(deleteEmployeeData);
  const [errors, setErrors] = useState();

  const deleteEmployee = async () => {
    const res = await mutateAsync(employeeId);
    if (res["errors"]) {
      setErrors(res["errors"]);
    } else {
      refetch();
      hideDeleteEmployee();
    }
  };

  return (
    <div>
      <Dialog open={openDelete} onClose={hideDeleteEmployee}>
        <DialogTitle id="alert-delete">{"Delete the Employee?"}</DialogTitle>
        {errors && (
          <Alert sx={{ margin: 2 }} variant="filled" severity="error">
            {errors}
          </Alert>
        )}
        <DialogActions>
          <Button onClick={hideDeleteEmployee} autoFocus>
            Cancel
          </Button>
          <Button onClick={deleteEmployee}>Yes</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}
