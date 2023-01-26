import * as React from "react";
import { styled } from "@mui/material/styles";
import Box from "@mui/material/Box";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import ListItemText from "@mui/material/ListItemText";
import Avatar from "@mui/material/Avatar";
import IconButton from "@mui/material/IconButton";
import Typography from "@mui/material/Typography";
import EmojiEmotionsIcon from "@mui/icons-material/EmojiEmotions";

function generate(element) {
  return [0, 1].map((value) =>
    React.cloneElement(element, {
      key: value,
    })
  );
}

export default function MysteryLunchGroup({ mysteryLunch }) {
  return (
    <Box sx={{ maxWidth: 280 }}>
      <Typography variant="h6" component="div">
        Mystery Lunch <strong>#{mysteryLunch.id} 🧆</strong>
      </Typography>
      <List>
        {mysteryLunch.employees.map((employee) => (
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
          </ListItem>
        ))}
      </List>
    </Box>
  );
}
