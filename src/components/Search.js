import React, { useState } from "react";
import { Input, InputGroup, InputLeftElement, Button } from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";

export const Search = ({ handleSearch }) => {
  const [searchTerm, setSearchTerm] = useState("");

  const handleReset = () => {
    setSearchTerm("");
    handleSearch("");
  };

  return (
    <InputGroup
      bg="white"
      borderRadius="full"
      boxShadow="md"
      maxW={{ base: "full", md: "sm" }}
      mx="auto"
      marginTop={4}
    >
      <InputLeftElement pointerEvents="none" children={<SearchIcon color="gray.500" />} />
      <Input
        type="text"
        placeholder="Rechercher"
        bg="white"
        focusBorderColor="gray.500"
        borderColor="transparent"
        borderRadius="full"
        size="md"
        _placeholder={{ color: "gray.500" }}
        value={searchTerm}
        onChange={(e) => {
          setSearchTerm(e.target.value);
          handleSearch(e.target.value);
        }}
      />
      {searchTerm && (
        <Button
          size="md"
          bg="transparent"
          color="gray.500"
          _hover={{ bg: "transparent", color: "teal.500" }}
          onClick={handleReset}
        >
          Réinitialiser
        </Button>
      )}
    </InputGroup>
  );
};
