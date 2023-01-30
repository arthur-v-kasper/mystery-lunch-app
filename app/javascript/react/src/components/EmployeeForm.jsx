import React, { useState, useEffect } from "react";
import { useMutation } from "react-query";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogTitle from "@mui/material/DialogTitle";
import InputLabel from "@mui/material/InputLabel";
import Select from "@mui/material/Select";
import MenuItem from "@mui/material/MenuItem";
import Grid from "@mui/material/Grid";
import { useMysteryLunch } from "../context/MysteryLunchContext";
import {
  getDepartments,
  getEmployee,
  postEmployeeData,
} from "../services/fetchApi";

const EmployeeForm = ({ employeeId = null }) => {
  const { hideFormEmployee, authToken } = useMysteryLunch();
  const [employee, setEmployee] = useState({
    id: null,
    full_name: null,
    email: null,
    department_id: 1,
  });

  const {
    data: dataDepartments,
    error: errorDepartments,
    isLoading: isLoadingDepartments,
  } = getDepartments("departments");

  const {
    data: dataEmployee,
    error: errorEmployee,
    isLoading: isLoadingEmployee,
  } = getEmployee("employee", employeeId);

  useEffect(() => {
    if (!isLoadingEmployee && employeeId) {
      console.log("passou no if ", dataEmployee);
      setEmployee(dataEmployee);
    }
  }, [dataEmployee]);

  const handleChange = (event) => {
    setEmployee({ ...employee, [event.target.name]: event.target.value });
  };

  const { mutateAsync } = useMutation(postEmployeeData);

  const handleSaveEmployee = async () => {
    console.log(authToken);
    const response = await mutateAsync(employee);
    hideFormEmployee();
  };

  console.log("valores::", isLoadingEmployee, errorEmployee);

  if (isLoadingDepartments || isLoadingEmployee) return <div>Loading...</div>;
  if (errorDepartments || errorEmployee)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <Dialog open={true}>
      <DialogTitle>Form Employee</DialogTitle>
      <Box
        component="form"
        sx={{
          "& .MuiTextField-root": { marginBottom: 3 },
        }}
      >
        <DialogContent>
          <Grid justify="center" alignItems="center" direction="row">
            <TextField
              id="outlined-basic"
              fullWidth
              label="Full Name"
              variant="outlined"
              name="full_name"
              value={employee.full_name}
              onChange={handleChange}
            />
            <TextField
              id="outlined-basic"
              fullWidth
              label="Email"
              name="email"
              value={employee.email}
              variant="outlined"
              onChange={handleChange}
            />
            <InputLabel id="dep-label">Department</InputLabel>
            {employee?.department_id && (
              <Select
                id="department"
                label="Departments"
                name="department_id"
                onChange={handleChange}
                value={employee.department_id}
                fullWidth
              >
                {dataDepartments.map((department) => (
                  <MenuItem key={department.id} value={department.id}>
                    {department.name}
                  </MenuItem>
                ))}
              </Select>
            )}
          </Grid>
        </DialogContent>
      </Box>
      <DialogActions>
        <Button onClick={hideFormEmployee}>Cancel</Button>
        <Button onClick={handleSaveEmployee}>Save</Button>
      </DialogActions>
    </Dialog>
  );
};

export default EmployeeForm;
