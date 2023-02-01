import React, { useState, useEffect } from "react";
import { useMutation } from "react-query";
import Box from "@mui/material/Box";
import Container from "@mui/material/Container";
import Alert from "@mui/material/Alert";
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
import Loading from "../States/Loading";
import Error from "../States/Error";
import { useMysteryLunch } from "../../context/MysteryLunchContext";
import {
  getDepartments,
  getEmployee,
  updateEmployeeData,
  createEmployeeData,
} from "../../services/fetchApi";

const EmployeeForm = ({ employeeId = null, refetch }) => {
  const { hideFormEmployee } = useMysteryLunch();
  const [errors, setErrors] = useState();
  const [employee, setEmployee] = useState({
    id: null,
    full_name: "",
    email: "",
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
      setEmployee(dataEmployee);
    }
  }, [dataEmployee]);

  const handleChange = (event) => {
    setEmployee({ ...employee, [event.target.name]: event.target.value });
  };

  const handleEmployee = employeeId ? updateEmployeeData : createEmployeeData;
  const { mutateAsync } = useMutation(handleEmployee);

  const saveEmployee = async () => {
    const res = await mutateAsync(employee);
    if (res["errors"]) {
      setErrors(res["errors"]);
    } else {
      refetch();
      hideFormEmployee();
    }
  };

  if (isLoadingDepartments || isLoadingEmployee) return <Loading />;
  if (errorDepartments || errorEmployee) return <Error />;

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
          <Container>
            <Grid justify="center" alignItems="center">
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
              {errors && (
                <Alert sx={{ marginTop: 1 }} variant="filled" severity="error">
                  {errors}
                </Alert>
              )}
            </Grid>
          </Container>
        </DialogContent>
      </Box>
      <DialogActions>
        <Button onClick={hideFormEmployee}>Cancel</Button>
        <Button onClick={saveEmployee}>Save</Button>
      </DialogActions>
    </Dialog>
  );
};

export default EmployeeForm;
