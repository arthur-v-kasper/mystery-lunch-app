import * as React from "react";
import axios from "axios";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Grid from "@mui/material/Grid";
import MysteryLunchGroup from "./MysteryLunchGroup";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import styled from "styled-components";
import FormHelperText from "@mui/material/FormHelperText";
import FormControl from "@mui/material/FormControl";
import { useQuery } from "react-query";
import { getLastSixMonths } from "../helpers/dateSelectData";

const Header = styled.div`
  /* display: flex; */
`;

const MysteryLunchList = () => {
  const lastSixMonths = getLastSixMonths();
  const defaultValue = lastSixMonths[0];

  const getFacts = async () => {
    const response = await fetch("http://localhost:3000/mystery_lunches");
    return response.json();
  };

  const { data, error, isLoading } = useQuery("mysteryLunches", getFacts);

  // React.useEffect(() => {
  //   async function bla() {
  //     if (data) console.log("data xx", data);
  //   }
  //   bla();
  // }, [data]);

  if (isLoading) return <div>Loading...</div>;
  if (error)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <>
      <Card sx={{ minWidth: 100 }}>
        <CardContent>
          <Header>
            <FormControl sx={{ m: 1, minWidth: 120 }}>
              <InputLabel id="demo-simple-select-helper-label">
                Year Month
              </InputLabel>
              <Select
                labelId="demo-simple-select-helper-label"
                id="demo-simple-select-helper"
                label="Year Month"
                defaultValue={defaultValue}
              >
                {lastSixMonths.map((yearMonth) => (
                  <MenuItem key={yearMonth} value={yearMonth}>
                    {yearMonth}
                  </MenuItem>
                ))}
              </Select>
              <FormHelperText>
                <strong>Mystery Lanches from 👆:</strong>
              </FormHelperText>
            </FormControl>
          </Header>
          <Grid container spacing={2}>
            {data.mystery_lunches.map((ml) => (
              <Grid item xs={6} md={4}>
                <MysteryLunchGroup mysteryLunch={ml} />
              </Grid>
            ))}
          </Grid>
        </CardContent>
      </Card>
    </>
  );
};

export default MysteryLunchList;
