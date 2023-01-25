import * as React from "react";
import { createGlobalStyle } from "styled-components";
import Navbar from "./Navbar";
import Body from "./Body";

const GlobalStyle = createGlobalStyle`

  html{    
    box-sizing: border-box;
  }

  *,*:before, *:after {
    box-sizing: inherit;
  }

  body {
    margin: 0;
  }
`;

const App = () => {
  return (
    <>
      <GlobalStyle />
      <Navbar />
      <Body />
    </>
  );
};

export default App;
