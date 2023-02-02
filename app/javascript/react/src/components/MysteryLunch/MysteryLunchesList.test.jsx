import React from "react";
import "@testing-library/jest-dom";
import { render, screen, waitFor } from "@testing-library/react";
import { getLastSixMonths } from "../../helpers/dateSelectData";
import { getMysteryLunches } from "../../services/fetchApi";
import { fakeLastSixMonths, fakeMysteryLunches } from "../../helpers/fakeData";
import MysteryLunchList from "./MysteryLunchesList";

jest.mock("../../helpers/dateSelectData", () => ({
  getLastSixMonths: jest.fn(),
}));

jest.mock("../../services/fetchApi", () => ({
  getMysteryLunches: jest.fn(),
}));

function customRender() {
  return waitFor(() => {
    render(<MysteryLunchList />);
  });
}

describe("MysteryLunchList", () => {
  beforeEach(() => {
    getLastSixMonths.mockReturnValue(fakeLastSixMonths);
    getMysteryLunches.mockReturnValue({
      data: fakeMysteryLunches,
      error: false,
      isLoading: false,
    });
  });

  test("Should render year months select", async () => {
    await customRender();
    expect(screen.getByTestId(/selectyearmonth/i)).toBeInTheDocument();
    expect(screen.getByText(/Mystery Lanches from 👆/i)).toBeInTheDocument();
  });

  test("Should render Mystery Lunches", async () => {
    await customRender();
    expect(screen.getByText(/#112 🧆/i)).toBeInTheDocument();
    expect(screen.getByText(/#113 🧆/i)).toBeInTheDocument();
  });
});
