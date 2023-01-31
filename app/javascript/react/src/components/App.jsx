import * as React from "react";
import { QueryClient, QueryClientProvider } from "react-query";
import { createGlobalStyle } from "styled-components";
import Navbar from "./Navegation/Navbar";
import Body from "./Navegation/Body";
import Login from "./Login/Login";
import { MysteryLunchProvider } from "../context/MysteryLunchContext";

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

const queryClient = new QueryClient();

const App = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <MysteryLunchProvider>
        <GlobalStyle />
        <Navbar />
        <Body />
        <Login />
      </MysteryLunchProvider>
    </QueryClientProvider>
  );
};

export default App;
