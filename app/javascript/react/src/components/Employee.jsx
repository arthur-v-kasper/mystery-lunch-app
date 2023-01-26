import * as React from "react";
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
import FormHelperText from "@mui/material/FormHelperText";
import FormControl from "@mui/material/FormControl";

import { useQuery } from "react-query";

export default function Employees() {
  const getFacts = async () => {
    const response = await fetch("http://localhost:3000/employees");
    return response.json();
  };

  const { data, error, isLoading } = useQuery("employees", getFacts);

  if (isLoading) return <div>Loading...</div>;
  if (error)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <Box>
      <>
        <FormControl sx={{ m: 1, minWidth: 120 }} size="small">
          <InputLabel id="demo-simple-select-helper-label">
            Year Month
          </InputLabel>
          <Select
            labelId="demo-simple-select-helper-label"
            id="demo-simple-select-helper"
            label="Year Month"
            defaultValue={1}
          >
            <MenuItem value={1}>Engineering</MenuItem>
          </Select>
          <FormHelperText>
            <strong>Departments 👆:</strong>
          </FormHelperText>
        </FormControl>
      </>
      <List>
        {data.employees.map((employee) => (
          <ListItem
            secondaryAction={
              <>
                <IconButton
                  aria-label="Updapte Employee"
                  title="Updapte Employee"
                >
                  <BorderColorIcon />
                </IconButton>
                <IconButton
                  aria-label="Delete Employee"
                  title="Delete Employee"
                >
                  <DeleteIcon />
                </IconButton>
              </>
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
    </Box>
  );
}
