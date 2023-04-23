import React, { useContext } from "react";
import { CartContext } from "../context/CartContext";
import {
  Box,
  Button,
  Flex,
  Image,
  Stack,
  Text,
  VStack,
} from "@chakra-ui/react";

export const Cart = () => {
  const { state, dispatch } = useContext(CartContext);

  const removeFromCart = (product) => {
    // remove only one product even if there are multiple of the same product
    const action = {
      type: "REMOVE_FROM_CART",
      payload: product.id,
    };

    dispatch(action);
  };

  const addToCart = (product) => {
    const action = {
      type: "ADD_TO_CART",
      payload: product,
    };

    dispatch(action);
  };

  const totalAmountOfCart = () => {
    return state.cart.reduce((acc, product) => {
      // round to 2 decimals
      return Math.round((acc + product.price * product.quantity) * 100) / 100;
    }, 0);
  };

  const renderProducts = () => {
    return state.cart.map((product) => {
      const totalPrice =
        Math.round(product.price * product.quantity * 100) / 100;

      return (
        <Flex
          key={product.id}
          direction={{ base: "column", sm: "row" }}
          align="center"
          justify="space-between"
          borderBottom="1px solid #e2e8f0"
          py={4}
          px={{ base: "0", sm: "8" }}
          borderRadius="md"
          boxShadow="sm"
          bg="white"
          mb={4}
        >
          <Image
            boxSize={{ base: "100px", sm: "200px" }}
            objectFit="cover"
            src={product.image}
            alt={product.title}
            borderRadius="md"
            mr={{ base: "0", sm: "4" }}
          />

          <VStack flex="1" alignItems="flex-start" spacing={4} mr={{ base: "0", sm: "4" }}>
            <Text fontSize="lg" fontWeight="bold">
              {product.title}
            </Text>
            <Stack direction="row" align="center" spacing={4}>
              <Button
                onClick={() => removeFromCart(product)}
                size="sm"
                colorScheme="red"
              >
                -
              </Button>
              <Text fontSize="lg">{product.quantity}</Text>
              <Button
                onClick={() => addToCart(product)}
                size="sm"
                colorScheme="green"
              >
                +
              </Button>
            </Stack>
          </VStack>

          <Text fontSize="lg" fontWeight="bold">
            {totalPrice}.-
          </Text>
        </Flex>
      );
    });
  };

  return (
    <Box height="100vh">
      {state.cart.length === 0 ? (
        <Text fontSize="2xl" fontWeight="bold" mb={4}>
          Le panier est vide
        </Text>
      ) : (
        <>
          <Box>{renderProducts()}</Box>
          <Box mt={4}>
            <Text fontSize="2xl" fontWeight="bold">
              Total: {totalAmountOfCart()}.-
            </Text>
          </Box>
        </>
      )}
    </Box>
  );
};