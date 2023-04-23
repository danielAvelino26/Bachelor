import React, { useContext } from "react";
import {
  Card,
  CardBody,
  CardFooter,
  Image,
  Text,
  Button,
  Stack,
  Heading,
  Divider,
  ButtonGroup,
  Box,
  Badge,
} from "@chakra-ui/react";
import { CartContext } from "../context/CartContext";

export const CardProduct = ({ product }) => {
  const { dispatch } = useContext(CartContext); // Allow to access useContext for the dispatch method

  const addToCart = (product) => {
    // L'action à envoyer au reducer
    const action = {
      type: "ADD_TO_CART",
      payload: product,
    };

    // Envoyez l'action au reducer en utilisant dispatch
    dispatch(action);
  };

  return (
    <Card maxW="sm" m="5">
      <CardBody>
        <Image
          src={product.image}
          alt={product.title}
          h="200px"
          w="full"
          p="2"
          objectFit="contain"
        />
        <Box minHeight="230px">
          <Stack mt="6" spacing="3">
            <Heading size="md">{product.title}</Heading>
            <Text>{product.description.substring(0, 100)}</Text>
            <Text color="blue.600" fontSize="2xl">
              ${product.price}
            </Text>
          </Stack>
        </Box>

        <Box display="flex" alignproducts="baseline">
          <Badge borderRadius="full" px="2" colorScheme="teal" mb="2">
            Category
          </Badge>
        </Box>

        <Box
          color="gray.500"
          fontWeight="semibold"
          letterSpacing="wide"
          fontSize="xs"
          textTransform="uppercase"
          ml="2"
        >
          {product.category}
        </Box>
      </CardBody>
      <Divider />
      <CardFooter>
        <ButtonGroup spacing="2">
          <Button
            variant="solid"
            colorScheme="blue"
            onClick={() => addToCart(product)}
          >
            Ajouter au panier
          </Button>
        </ButtonGroup>
      </CardFooter>
    </Card>
  );
};
