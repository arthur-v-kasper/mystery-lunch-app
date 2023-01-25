import * as React from "react";
import Container from "@mui/material/Container";
import styled from "styled-components";
import TabMenu from "./TabMenu";

const CustomContainer = styled(Container)``;

const Body = () => {
  return (
    <CustomContainer>
      <TabMenu />
    </CustomContainer>
  );
};

export default Body;
