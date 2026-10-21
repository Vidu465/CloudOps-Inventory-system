
const { test } = require("node:test");
const assert = require("node:assert/strict");
const request = require("supertest");
const app = require("./app");

test("GET /health returns healthy status", async () => {
  const response = await request(app).get("/health");

  assert.equal(response.status, 200);
  assert.equal(response.body.status, "healthy");
  assert.equal(response.body.service, "inventory-api");
});

test("GET /api/items returns inventory items", async () => {
  const response = await request(app).get("/api/items");

  assert.equal(response.status, 200);
  assert.equal(response.body.length, 2);
  assert.equal(response.body[0].name, "Laptop");
});
