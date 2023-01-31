import * as React from "react";
import axios from "axios";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Grid from "@mui/material/Grid";
import MysteryLunchGroup from "./MysteryLunchGroup";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormHelperText from "@mui/material/FormHelperText";
import FormControl from "@mui/material/FormControl";
import styled from "styled-components";
import { useQuery } from "react-query";
import { getLastSixMonths } from "../helpers/dateSelectData";

const Header = styled.div`
  /* display: flex; */
`;

const MysteryLunchList = () => {
  const lastSixMonths = getLastSixMonths();
  const defaultValue = lastSixMonths[0];
  const [yearMonth, setYearMonth] = React.useState(defaultValue);
  const selectValue = yearMonth !== defaultValue ? yearMonth : defaultValue;

  const getMysteryLunches = async () => {
    const response = await fetch(
      `http://localhost:3000/mystery_lunches?year_month=${yearMonth}`
    );
    return response.json();
  };

  const { data, error, isLoading } = useQuery(yearMonth, getMysteryLunches);

  const handleChange = (event) => {
    setYearMonth(event.target.value);
  };

  if (isLoading) return <div>Loading...</div>;
  if (error)
    return <div>Oops... somenthing went wrong when fetch the data</div>;

  return (
    <>
      <Card sx={{ minWidth: 100 }}>
        <CardContent>
          <Header>
            <FormControl sx={{ m: 1, minWidth: 120 }} size="small">
              <InputLabel id="demo-simple-select-helper-label">
                Year Month
              </InputLabel>
              <Select
                labelId="demo-simple-select-helper-label"
                id="demo-simple-select-helper"
                label="Year Month"
                defaultValue={selectValue}
                onChange={handleChange}
              >
                {lastSixMonths.map((yearMonth) => (
                  <MenuItem key={yearMonth} value={yearMonth}>
                    {yearMonth}
                  </MenuItem>
                ))}
              </Select>
              <FormHelperText>
                <strong>Mystery Lanches from 👆</strong>
              </FormHelperText>
            </FormControl>
          </Header>
          <Grid container spacing={2}>
            {data.mystery_lunches.map((ml) => (
              <Grid item xs={6} md={4} key={ml.id}>
                <MysteryLunchGroup mysteryLunch={ml} key={ml.id} />
              </Grid>
            ))}
          </Grid>
        </CardContent>
      </Card>
    </>
  );
};

export default MysteryLunchList;
