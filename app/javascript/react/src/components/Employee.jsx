import * as React from "react";
import Box from "@mui/material/Box";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import ListItemText from "@mui/material/ListItemText";
import Avatar from "@mui/material/Avatar";
import EmojiEmotionsIcon from "@mui/icons-material/EmojiEmotions";
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
      <List>
        {data.employees.map((employee) => (
          <ListItem>
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
