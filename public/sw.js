// import { registerRoute } from "./node_modules/workbox-routing/src/index.mjs";
// import { StaleWhileRevalidate } from "./node_modules/workbox-strategies/src/index.mjs";
// import { ExpirationPlugin } from "./node_modules/workbox-expiration/src/index.mjs";

// // Cache les produits de l'API
// registerRoute(
//   ({ url }) => url.href.startsWith("https://fakestoreapi.com/products"),
//   new StaleWhileRevalidate({
//     cacheName: "products",
//     plugins: [
//       new ExpirationPlugin({
//         maxEntries: 50,
//         maxAgeSeconds: 60 * 60 * 24, // 24 heures
//       }),
//     ],
//   })
// );
