import React, { useState } from "react";
import Box from "@mui/material/Box";
import Tab from "@mui/material/Tab";
import TabContext from "@mui/lab/TabContext";
import TabList from "@mui/lab/TabList";
import TabPanel from "@mui/lab/TabPanel";
import MysteryLunchList from "./MysteryLunchesList";
import EmployeesList from "./EmployeesList";

const TAB_ITEM = {
  ML: "mystery_lunches",
  EMP: "employees",
};

const TabMenu = () => {
  const [value, setValue] = useState(TAB_ITEM.ML);

  const handleChange = (e, newValue) => {
    setValue(newValue);
  };

  return (
    <TabContext value={value}>
      <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
        <TabList onChange={handleChange}>
          <Tab label="Mystery Lunches" value={TAB_ITEM.ML} />
          <Tab label="Employees" value={TAB_ITEM.EMP} />
        </TabList>
      </Box>
      <TabPanel value={TAB_ITEM.ML}>
        <MysteryLunchList />
      </TabPanel>
      <TabPanel value={TAB_ITEM.EMP}>
        <EmployeesList />
      </TabPanel>
    </TabContext>
  );
};

export default TabMenu;
