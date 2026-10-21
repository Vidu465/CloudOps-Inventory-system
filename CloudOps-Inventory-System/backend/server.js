const express = require("express");

const app = express();

const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get("/health", (req, res) => {
  res.json({
    status: "healthy",
    service: "inventory-api"
  });
});

app.get("/api/items", (req, res) => {
  res.json([
    {
      id: 1,
      name: "Laptop",
      quantity: 10
    },
    {
      id: 2,
      name: "Keyboard",
      quantity: 25
    }
  ]);
});

app.listen(PORT, () => {
  console.log(`Inventory API running on port ${PORT}`);
});