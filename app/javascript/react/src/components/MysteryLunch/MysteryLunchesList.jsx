import React, { useState } from "react";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Grid from "@mui/material/Grid";
import MysteryLunchGroup from "./MysteryLunchGroup";
import Select from "@mui/material/Select";
import InputLabel from "@mui/material/InputLabel";
import MenuItem from "@mui/material/MenuItem";
import FormHelperText from "@mui/material/FormHelperText";
import FormControl from "@mui/material/FormControl";
import Loading from "../States/Loading";
import Error from "../States/Error";
import { getLastSixMonths } from "../../helpers/dateSelectData";
import { getMysteryLunches } from "../../services/fetchApi";

const MysteryLunchList = () => {
  const lastSixMonths = getLastSixMonths();
  const defaultValue = lastSixMonths[0];
  const [yearMonth, setYearMonth] = useState(defaultValue);
  const selectValue = yearMonth !== defaultValue ? yearMonth : defaultValue;

  const { data, error, isLoading } = getMysteryLunches(yearMonth);

  const handleChange = (event) => {
    setYearMonth(event.target.value);
  };

  if (isLoading) return <Loading />;
  if (error) return <Error />;

  return (
    <>
      <Card sx={{ minWidth: 100 }}>
        <CardContent>
          <div>
            <FormControl sx={{ m: 1, minWidth: 120 }} size="small">
              <InputLabel id="select-yearmonth">Year Month</InputLabel>
              <Select
                labelId="selectyearmonth"
                id="selectyearmonth"
                label="Year Month"
                defaultValue={selectValue}
                onChange={handleChange}
                SelectDisplayProps={{ "data-testid": "selectyearmonth" }}
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
          </div>
          {data?.mystery_lunches.length != 0 ? (
            <Grid container spacing={2}>
              {data?.mystery_lunches.map((ml) => (
                <Grid item xs={6} md={4} key={ml.id}>
                  <MysteryLunchGroup mysteryLunch={ml} key={ml.id} />
                </Grid>
              ))}
            </Grid>
          ) : (
            <InputLabel>No data for this period</InputLabel>
          )}
        </CardContent>
      </Card>
    </>
  );
};

export default MysteryLunchList;
