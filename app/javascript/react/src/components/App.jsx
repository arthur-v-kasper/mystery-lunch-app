import * as React from "react";
import { QueryClient, QueryClientProvider } from "react-query";
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

const queryClient = new QueryClient();

const App = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <GlobalStyle />
      <Navbar />
      <Body />
    </QueryClientProvider>
  );
};

export default App;
