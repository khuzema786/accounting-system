const express = require("express");
const bodyParser = require("body-parser");
const { v4: uuid } = require('uuid');
const app = express();

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

const Pool = require("pg").Pool;
const dbSchema = process.env["DB_SCHEMA"];
const pool = new Pool({
  user: process.env["DB_USER"],
  host: process.env["DB_HOST"],
  database: process.env["DB_NAME"],
  password: process.env["DB_PASSWORD"],
  port: process.env["DB_PORT"],
});
const company_id = '464c48c1-463c-425d-bdfa-85435524fcdc';

app.get("/currency/list", async (_, response) => {
  const { rows: currencies } = await pool.query(
    `SELECT * FROM ${dbSchema}.currency WHERE company_id = $1`,
    [company_id])

  response.status(200).json(currencies.map(currency => ({
    "id": currency.id,
    "name": currency.name,
    "shortName": currency.short_name,
  })));
})

app.get("/unit/list", async (_, response) => {
  const { rows: units } = await pool.query(
    `SELECT * FROM ${dbSchema}.unit WHERE company_id = $1`,
    [company_id])

  response.status(200).json(units.map(unit => ({
    "id": unit.id,
    "name": unit.name,
    "shortName": unit.short_name,
  })));
})

app.get("/location/list", async (_, response) => {
  const { rows: locations } = await pool.query(
    `SELECT * FROM ${dbSchema}.location WHERE company_id = $1`,
    [company_id])

  response.status(200).json(locations.map(location => ({
    "id": location.id,
    "name": location.name,
    "detail": location.detail,
  })));
})

app.get("/project/list", async (_, response) => {
  const { rows: projects } = await pool.query(
    `SELECT * FROM ${dbSchema}.project WHERE company_id = $1`,
    [company_id])

  response.status(200).json(projects.map(project => ({
    "id": project.id,
    "name": project.name,
    "type": project.type,
    "detail": project.detail,
  })));
})

app.get("/salesman/list", async (_, response) => {
  const { rows: salesmans } = await pool.query(
    `SELECT * FROM ${dbSchema}.salesman WHERE company_id = $1`,
    [company_id])

  response.status(200).json(salesmans.map(salesman => ({
    "id": salesman.id,
    "name": salesman.name,
    "commision_percentage": salesman.commision_percentage
  })));
})

app.get("/item/list", async (_, response) => {
  const { rows: items } = await pool.query(
    `SELECT * FROM ${dbSchema}.item WHERE company_id = $1`,
    [company_id])

  response.status(200).json(items.map(item => ({
    "id": item.id,
    "name": item.name,
    "type": item.type,
    "detail": item.type,
    "lastPurchasePrice": item.last_purchase_price,
    "lastSellingPrice": item.last_selling_price
  })));
})

const constructAccountTree = async (accounts, output) => {
  if(accounts.children_id.length == 0) return output;

  for (let i = 0; i < accounts.children_id.length; i++) {
    const { rows: accounts } = await pool.query(
      `SELECT * FROM ${dbSchema}.account WHERE company_id = $1 AND id = $2`,
      [company_id]);
      let output[]
      constructAccountTree(newAccounts, { ... output,  })
  }
}

app.get("/account/list", async (_, response) => {
  const { rows: accounts } = await pool.query(
    `SELECT * FROM ${dbSchema}.account WHERE company_id = $1 AND parent_id IS NULL ORDER BY id ASC`,
    [company_id])

  const output = 

  response.status(200).json(items.map(item => ({
    "id": item.id,
    "name": item.name,
    "type": item.type,
    "detail": item.type,
    "lastPurchasePrice": item.last_purchase_price,
    "lastSellingPrice": item.last_selling_price
  })));
})

app.post("/invoice/create", async (request, response) => {
  const { voucherType, date, projectId, voucherNo, currency, invoice, ref, narration, amount, accounts, items } = request.body;

  const transactionId = uuid();

  pool.query(
    `INSERT INTO ${dbSchema}.transaction (id, name, email) VALUES ($1, $2)`,
    [transactionId, email],
    (error, results) => {
      if (error) {
        throw error;
      }
      response.status(201).send(`User added with ID: ${results.insertId}`);
    }
  );

  response.json({ info: "Node.js, Express, and Postgres API" });
});

app.listen(process.env["APP_PORT"], () => {
  console.log(`App running on port ${process.env["APP_PORT"]}.`);
});
