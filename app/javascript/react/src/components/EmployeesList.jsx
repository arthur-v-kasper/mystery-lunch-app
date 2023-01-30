import React, { useState, useEffect } from "react";
import Box from "@mui/material/Box";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import ListItemText from "@mui/material/ListItemText";
import Avatar from "@mui/material/Avatar";
import EmojiEmotionsIcon from "@mui/icons-material/EmojiEmotions";
import DeleteIcon from "@mui/icons-material/Delete";
import BorderColorIcon from "@mui/icons-material/BorderColor";
import IconButton from "@mui/material/IconButton";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormControl from "@mui/material/FormControl";
import Tooltip from "@mui/material/Tooltip";
import Button from "@mui/material/Button";
import EmployeeForm from "./EmployeeForm";
import { useMysteryLunch } from "../context/MysteryLunchContext";
import { getDepartments, getEmployeesByDepartment } from "../services/fetchApi";

export default function EmployeesList() {
  const [department, setDepartment] = useState(null);
  const [employee, setEmployee] = useState(null);

  const { authToken, showFormEmployee, setCurrentEmployee, formEmployee } =
    useMysteryLunch();
  const disableButton = authToken ? false : true;
  const enableTooltip = authToken ? "" : "Only admin users can interact";

  const {
    data: dataDepartments,
    error: errorDepartments,
    isLoading: isLoadingDepartments,
  } = getDepartments("departments");

  const {
    data: dataEmployees,
    error: errorEmployees,
    isLoading: isLoadingEmployees,
  } = getEmployeesByDepartment(`employeesfrom${department}`, department);

  const handleEditEmployee = (id) => {
    setEmployee(id);
    showFormEmployee();
  };

  const handleCreateEmployee = () => {
    showFormEmployee();
  };

  const handleChange = (event) => setDepartment(event.target.value);

  useEffect(() => {
    if (dataDepartments) setDepartment(dataDepartments[0]?.id);
  }, [dataDepartments]);

  if (isLoadingEmployees || isLoadingDepartments) return <div>Loading...</div>;
  if (errorEmployees || errorDepartments)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <Box>
      {department && (
        <FormControl
          sx={{ m: 1, minWidth: 120, flexDirection: "row" }}
          size="small"
        >
          <InputLabel id="dep-label">Departments</InputLabel>
          <Select
            labelId="dep-label"
            id="dep"
            label="Departments"
            onChange={handleChange}
            defaultValue={department}
          >
            {dataDepartments.map((department) => (
              <MenuItem key={department.id} value={department.id}>
                {department.name}
              </MenuItem>
            ))}
          </Select>
          <Tooltip title={enableTooltip}>
            <Button
              disabled={disableButton}
              variant="contained"
              onClick={handleCreateEmployee}
              sx={{ marginLeft: 1 }}
            >
              Add Employee
            </Button>
          </Tooltip>
        </FormControl>
      )}
      <List>
        {dataEmployees.employees.map((employee) => (
          <ListItem
            secondaryAction={
              <Tooltip title={enableTooltip}>
                <div>
                  <IconButton
                    disabled={disableButton}
                    aria-label="Updapte Employee"
                    title="Updapte Employee"
                    onClick={() => handleEditEmployee(employee.id)}
                  >
                    <BorderColorIcon />
                  </IconButton>

                  <IconButton
                    disabled={disableButton}
                    aria-label="Delete Employee"
                    title="Delete Employee"
                  >
                    <DeleteIcon />
                  </IconButton>
                </div>
              </Tooltip>
            }
          >
            <ListItemAvatar>
              <Avatar>
                {employee.picture ? employee.picture : <EmojiEmotionsIcon />}
              </Avatar>
            </ListItemAvatar>
            <ListItemText
              primary={employee.full_name}
              secondary={employee.department}
            />
            <ListItemText secondary={employee.email} />
          </ListItem>
        ))}
      </List>
      {formEmployee && <EmployeeForm employeeId={employee} />}
    </Box>
  );
}
