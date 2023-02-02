import React from "react";
import "@testing-library/jest-dom";
import { render, screen, waitFor, fireEvent } from "@testing-library/react";
import { useMysteryLunch } from "../../context/MysteryLunchContext";
import Navbar from "./Navbar";

jest.mock("../../context/MysteryLunchContext", () => ({
  useMysteryLunch: jest.fn(),
}));

describe("Navbar", () => {
  test("Render logout button", async () => {
    useMysteryLunch.mockReturnValue({ authToken: "auth123" });
    await waitFor(() => {
      render(<Navbar />);
    });
    expect(screen.getByText(/Logout/i)).toBeInTheDocument();
  });

  test("Render login button", async () => {
    useMysteryLunch.mockReturnValue({ authToken: "" });
    await waitFor(() => {
      render(<Navbar />);
    });
    expect(screen.getByText(/Login/i)).toBeInTheDocument();
  });
});
