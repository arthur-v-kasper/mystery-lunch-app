import * as React from "react";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Grid from "@mui/material/Grid";
import MysteryLunchGroup from "./MysteryLunchGroup";
import MysteryLunchGroupTrio from "./MysteryLunchGroupTrio";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import styled from "styled-components";
import FormHelperText from "@mui/material/FormHelperText";
import FormControl from "@mui/material/FormControl";

const Header = styled.div`
  display: flex;
`;

const MysteryLunchList = () => {
  return (
    <Card sx={{ minWidth: 100 }}>
      <CardContent>
        <Header>
          <FormControl sx={{ m: 1, minWidth: 120 }}>
            <InputLabel id="demo-simple-select-helper-label">Month</InputLabel>
            <Select
              labelId="demo-simple-select-helper-label"
              id="demo-simple-select-helper"
              label="Month"
            >
              <MenuItem value={0}>Zero</MenuItem>
              <MenuItem value={10}>Ten</MenuItem>
              <MenuItem value={20}>Twenty</MenuItem>
              <MenuItem value={30}>Thirty</MenuItem>
            </Select>
            <FormHelperText>Mystery Lanches from:</FormHelperText>
          </FormControl>
        </Header>
        <Grid container spacing={2}>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroupTrio />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
          <Grid item xs={6} md={4}>
            <MysteryLunchGroup />
          </Grid>
        </Grid>
      </CardContent>
    </Card>
  );
};

export default MysteryLunchList;
