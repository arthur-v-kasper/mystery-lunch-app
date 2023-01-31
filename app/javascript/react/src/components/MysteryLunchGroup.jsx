import * as React from "react";
import Box from "@mui/material/Box";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import ListItemText from "@mui/material/ListItemText";
import Avatar from "@mui/material/Avatar";
import Typography from "@mui/material/Typography";
import EmojiEmotionsIcon from "@mui/icons-material/EmojiEmotions";

export default function MysteryLunchGroup({ mysteryLunch }) {
  return (
    <Box sx={{ maxWidth: 300 }} key={mysteryLunch.id}>
      <Typography variant="h6" component="div" key={mysteryLunch.id}>
        Mystery Lunch <strong>#{mysteryLunch.id} 🧆</strong>
      </Typography>
      <List>
        {mysteryLunch.employees.map((employee) => (
          <ListItem key={employee.id}>
            <ListItemAvatar key={employee.id}>
              <Avatar key={employee.id}>
                {employee.picture ? (
                  employee.picture
                ) : (
                  <EmojiEmotionsIcon key={employee.id} />
                )}
              </Avatar>
            </ListItemAvatar>
            <ListItemText
              key={employee.id}
              primary={employee.full_name}
              secondary={employee.department}
            />
          </ListItem>
        ))}
      </List>
    </Box>
  );
}
