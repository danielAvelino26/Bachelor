import React, { createContext, useReducer } from "react";

// Context for cart state
export const CartContext = createContext();

const initialState = {
  cart: [],
};

const CartReducer = (state, action) => {
  switch (action.type) {
    case "ADD_TO_CART":
      const existingProductIndex = state.cart.findIndex(
        (item) => item.id === action.payload.id
      );

      if (existingProductIndex !== -1) {
        const updatedCart = [...state.cart];
        updatedCart[existingProductIndex].quantity += 1;
        return { ...state, cart: updatedCart };
      } else {
        return {
          ...state,
          cart: [...state.cart, { ...action.payload, quantity: 1 }],
        };
      }
    case "REMOVE_FROM_CART":
      const productIndex = state.cart.findIndex(
        (item) => item.id === action.payload
      );

      if (productIndex !== -1) {
        const updatedCart = [...state.cart];
        updatedCart[productIndex].quantity -= 1;

        if (updatedCart[productIndex].quantity === 0) {
          updatedCart.splice(productIndex, 1);
        }

        return { ...state, cart: updatedCart };
      } else {
        return state;
      }
    case "CLEAR_CART":
      return {
        ...state,
        cart: [],
      };
    default:
      return state;
  }
};

export const CartProvider = ({ children }) => {
  const [state, dispatch] = useReducer(CartReducer, initialState);

  // Pass the state and dispatch to the value of CartContext.Provider
  return (
    <CartContext.Provider value={{ state, dispatch }}>
      {children}
    </CartContext.Provider>
  );
};
