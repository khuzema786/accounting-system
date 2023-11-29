const express = require("express");
const bodyParser = require("body-parser");
const { v4: uuid } = require("uuid");
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
const companyId = "464c48c1-463c-425d-bdfa-85435524fcdc";

app.get("/currency/list", async (_, response) => {
  const { rows: currencies } = await pool.query(
    `SELECT * FROM ${dbSchema}.currency WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    currencies.map((currency) => ({
      id: currency.id,
      name: currency.name,
      shortName: currency.short_name,
    }))
  );
});

app.get("/unit/list", async (_, response) => {
  const { rows: units } = await pool.query(
    `SELECT * FROM ${dbSchema}.unit WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    units.map((unit) => ({
      id: unit.id,
      name: unit.name,
      shortName: unit.short_name,
    }))
  );
});

app.get("/location/list", async (_, response) => {
  const { rows: locations } = await pool.query(
    `SELECT * FROM ${dbSchema}.location WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    locations.map((location) => ({
      id: location.id,
      name: location.name,
      detail: location.detail,
    }))
  );
});

app.get("/project/list", async (_, response) => {
  const { rows: projects } = await pool.query(
    `SELECT * FROM ${dbSchema}.project WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    projects.map((project) => ({
      id: project.id,
      name: project.name,
      type: project.type,
      detail: project.detail,
    }))
  );
});

app.get("/salesman/list", async (_, response) => {
  const { rows: salesmans } = await pool.query(
    `SELECT * FROM ${dbSchema}.salesman WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    salesmans.map((salesman) => ({
      id: salesman.id,
      name: salesman.name,
      commision_percentage: salesman.commision_percentage,
    }))
  );
});

app.get("/item/list", async (_, response) => {
  const { rows: items } = await pool.query(
    `SELECT * FROM ${dbSchema}.item WHERE company_id = $1`,
    [companyId]
  );

  response.status(200).json(
    items.map((item) => ({
      id: item.id,
      name: item.name,
      type: item.type,
      detail: item.type,
      lastPurchasePrice: item.last_purchase_price,
      lastSellingPrice: item.last_selling_price,
    }))
  );
});

const constructAccountTree = async (account) => {
  let output = {};

  if (!account.children_id) {
    output[account.name] = {
      id: account.id,
    };
    return output;
  }

  console.log(company_id, account.children_id);

  const { rows: accounts } = await pool.query(
    `SELECT * FROM ${dbSchema}.account WHERE company_id = $1 AND id = ANY($2::int[])`,
    [companyId, account.children_id]
  );

  for (let i = 0; i < accounts.length; i++) {
    output[account.name] = {
      id: account.id,
      children: {
        ...(output[account.name]?.children || {}),
        ...(await constructAccountTree(accounts[i])),
      },
    };
  }
  return output;
};

app.get("/account/list", async (_, response) => {
  const { rows: accounts } = await pool.query(
    `SELECT * FROM ${dbSchema}.account WHERE company_id = $1 AND parent_id IS NULL ORDER BY id ASC`,
    [companyId]
  );

  let output = {};
  for (let i = 0; i < accounts.length; i++) {
    output = { ...output, ...(await constructAccountTree(accounts[i])) };
  }

  response.status(200).json(output);
});

app.post("/invoice/create", async (request, response) => {
  const {
    voucherType,
    date,
    projectId,
    voucherNo,
    currencyId,
    salesmanId,
    invoice,
    ref,
    narration,
    amount,
    bank,
    chequeNo,
    chequeDate,
    accounts,
    items,
  } = request.body;

  const transactionId = uuid();

  await pool.query(
    `INSERT INTO ${dbSchema}.transaction (id, company_id, date, voucher_type, voucher_no, currency_id, salesman_id, ref, invoice, narration, amount, bank, cheque_no, cheque_date) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)`,
    [
      transactionId,
      companyId,
      date,
      voucherType,
      voucherNo,
      currencyId,
      salesmanId,
      ref,
      invoice,
      narration,
      amount,
      bank,
      chequeNo,
      chequeDate,
    ]
  );

  accounts.forEach(async ({ id: accountId, dc, narration, amount }) => {
    await pool.query(
      `INSERT INTO ${dbSchema}.transaction_account (transaction_id, company_id, project_id, account_id, date, narration, amount, dc) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [
        transactionId,
        companyId,
        projectId,
        accountId,
        date,
        narration,
        amount,
        dc,
      ]
    );
  });

  items.forEach(
    async ({
      id: itemId,
      locationId,
      description,
      unit,
      qty,
      rate,
      amount,
      io,
    }) => {
      await pool.query(
        `INSERT INTO ${dbSchema}.transaction_item (transaction_id, company_id, date, item_id, description, unit, qty, rate, amount, io, location_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`,
        [
          transactionId,
          companyId,
          date,
          itemId,
          description,
          unit,
          qty,
          rate,
          amount,
          io,
          locationId,
        ]
      );
    }
  );

  response.json({ status: "SUCCESS" });
});

app.listen(process.env["APP_PORT"], () => {
  console.log(`App running on port ${process.env["APP_PORT"]}.`);
});
