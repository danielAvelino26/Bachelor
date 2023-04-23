import React, { useState, useEffect } from "react";
import { CardProduct } from "../components/CardProduct";
import "../App.css";
import { useQuery } from "react-query";
import { Search } from "../components/Search";

const fetchProducts = async () => {
  const productsUrl = "https://fakestoreapi.com/products";

  if (navigator.onLine) {
    try {
      const response = await fetch(productsUrl);
      if (!response.ok) {
        throw new Error("Erreur lors de la récupération des produits");
      }
      const data = await response.json();

      // Mise en cache des données récupérées
      const cache = await caches.open("products");
      cache.put(productsUrl, new Response(JSON.stringify(data)));

      return data;
    } catch (error) {
      console.error("Erreur lors de la récupération des produits:", error);
    }
  }

  // L'utilisateur est hors ligne, essayons de récupérer les données mises en cache
  const cache = await caches.open("products");
  const cachedResponse = await cache.match(productsUrl);
  if (cachedResponse) {
    const cachedData = await cachedResponse.json();
    return cachedData;
  } else {
    return []; // Renvoie un tableau vide en cas d'erreur et si aucune donnée n'est mise en cache
  }
};

export const Home = () => {
  const { isLoading, error, data } = useQuery("products", fetchProducts);
  const [filteredProducts, setFilteredProducts] = React.useState([]);
  console.log('render')

  React.useEffect(() => {
    if (data) {
      setFilteredProducts(data);
    }
  }, [data]);

  if (isLoading) {
    return <div>Loading...</div>;
  }
  if (error) return <div>Error: {error.message}</div>;

  const handleSearch = (search) => {
    const filtered = data.filter((product) => {
      return product.title.toLowerCase().includes(search.toLowerCase());
    });
  
    setFilteredProducts(filtered);
  };
  

  return (
    <>
      <Search handleSearch={handleSearch} />

      <div className="ProductContainer">
        {filteredProducts.map((product, index) => (
          <CardProduct key={product.id} product={{ ...product }} />
        ))}
      </div>
    </>
  );
};