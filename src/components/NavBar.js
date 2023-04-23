import { FaShoppingCart } from "react-icons/fa";
import React, { useContext, useState } from "react";
import { NavLink } from "react-router-dom";
import {
  Box,
  Button,
  Container,
  Flex,
  HStack,
  Popover,
  PopoverArrow,
  PopoverBody,
  PopoverContent,
  PopoverTrigger,
  Text,
  VStack,
} from "@chakra-ui/react";
import { CartContext } from "../context/CartContext";

export const NavBar = () => {
  const { state } = useContext(CartContext);
  const [isOpen, setIsOpen] = useState(false);
  console.log(isOpen)

  const countNbItems = () => {
    let nbItems = 0;
    state.cart.forEach((item) => {
      nbItems += item.quantity;
    });
    return nbItems;
  };

  const renderCartPreview = () => {
    return (
      <VStack spacing={4} alignItems="stretch">
        {state.cart.slice(0, 3).map((product) => (
          <HStack key={product.id} spacing={4}>
            <Text fontSize="sm" fontWeight="bold">
              {product.title}
            </Text>
            <Text fontSize="sm">{product.quantity}x</Text>
          </HStack>
        ))}
        {state.cart.length > 3 && (
          <Text fontSize="sm" fontWeight="bold">
            {state.cart.length - 3} autres articles...
          </Text>
        )}
        <Button as={NavLink} to="/panier" size="sm" mt={2} onClick={() => setIsOpen(!isOpen)}>
          Voir le panier
        </Button>
      </VStack>
    );
  };

  return (
    <Container
      maxW="full"
      pos="sticky"
      top={0}
      zIndex={1}
      boxShadow="md"
      bg="white"
      p="3"
    >
      <Flex justifyContent="space-between">
        <HStack spacing="24px" flex="1">
          <NavLink to="/" display="flex" alignItems="center">
            <Box
              fontSize="xl"
              fontWeight="bold"
              color="blue.500"
              transition="color 0.2s"
              _hover={{ color: "blue.700" }}
            >
              Accueil
            </Box>
          </NavLink>
          <NavLink to="/panier" display="flex" alignItems="center">
            <Box
              fontSize="xl"
              fontWeight="bold"
              color="blue.500"
              transition="color 0.2s"
              _hover={{ color: "blue.700" }}
            >
              Panier
            </Box>
          </NavLink>
        </HStack>

        <Popover isOpen={isOpen} onClose={() => setIsOpen(false)}>
          <PopoverTrigger>
            <HStack onClick={() => setIsOpen(!isOpen)}>
              <Box fontSize="xl" fontWeight="bold" color="blue.500">
                <FaShoppingCart size={20} />
              </Box>
              <Box fontSize="xl" fontWeight="bold" color="blue.500">
                <Text>{countNbItems()}</Text>
              </Box>
            </HStack>
          </PopoverTrigger>
          {state.cart.length > 0 && (
            <PopoverContent>
              <PopoverArrow />
              <PopoverBody>{renderCartPreview()}</PopoverBody>
                          </PopoverContent>
          )}
        </Popover>
      </Flex>
    </Container>
  );
};

