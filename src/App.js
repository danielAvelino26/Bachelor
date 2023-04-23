import React from "react";
import "./App.css";
import { Home } from "./pages/Home";
import { Routes, Route } from "react-router-dom";
import { NavBar } from "./components/NavBar";
import { Cart } from "./pages/Cart";

function App() {
  return (
    <div className="App">
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/panier" element={<Cart />} />
      </Routes>
    </div>
  );
}

export default App;
