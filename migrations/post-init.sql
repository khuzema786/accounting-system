CREATE TABLE account_app.person (
    id uuid DEFAULT uuid_generate_v4(),
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    mobile_number text NOT NULL,
    companies text [] NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT person_id_pkey PRIMARY KEY (id)
);

INSERT INTO
    account_app.person (name, email, password, mobile_number, companies)
VALUES
    (
        'admin',
        'admin@gmail.com',
        'admin',
        '+91-123456789',
        '{464c48c1-463c-425d-bdfa-85435524fcdc}'
    );

CREATE TABLE account_app.company (
    id uuid DEFAULT uuid_generate_v4(),
    name text NOT NULL,
    start_year date NOT NULL,
    address text NOT NULL,
    email text NOT NULL,
    mobile_number text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT company_id_pkey PRIMARY KEY (id)
);

INSERT INTO
    account_app.company (
        id,
        name,
        start_year,
        address,
        email,
        mobile_number
    )
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Efco Food',
        '2023-01-01',
        'Dubai, UAE',
        'efcofood@gmail.com',
        '+971-557029455'
    );

CREATE TABLE account_app.project (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    type text NOT NULL,
    detail text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT project_id_pkey PRIMARY KEY (id),
    CONSTRAINT project_company_id_fkey FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

CREATE INDEX idx_project_company_id ON account_app.project USING btree (company_id);

INSERT INTO
    account_app.project (id, company_id, name, type, detail)
VALUES
    (
        'e5781ca9-775f-497f-8161-c626a9e5b7ea',
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Office',
        'Office',
        'Office'
    );

CREATE TABLE account_app.location (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    detail text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT location_id_pkey PRIMARY KEY (id),
    CONSTRAINT location_company_id_fkey FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

CREATE INDEX idx_location_company_id ON account_app.location USING btree (company_id);

INSERT INTO
    account_app.location (id, company_id, name, detail)
VALUES
    (
        '2b35475d-b887-45af-8459-46ca820ccbb8',
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Main',
        'Main'
    );

CREATE TABLE account_app.currency (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    short_name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT currency_id_pkey PRIMARY KEY (id),
    CONSTRAINT currency_company_id_fkey FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

CREATE INDEX idx_currency_company_id ON account_app.currency USING btree (company_id);

INSERT INTO
    account_app.currency (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Dirham',
        'AED'
    );

INSERT INTO
    account_app.currency (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Rupees',
        'Rs'
    );

INSERT INTO
    account_app.currency (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'USDollar',
        'USD'
    );

INSERT INTO
    account_app.currency (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'UKPound',
        'GBP'
    );

INSERT INTO
    account_app.currency (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Euro',
        'Eur'
    );

CREATE TABLE account_app.unit (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    short_name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

CREATE INDEX idx_unit_company_id ON account_app.unit USING btree (company_id);

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Numbers',
        'Nos'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Carton',
        'Ctn'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Boxes',
        'Box'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Kilogram',
        'Kg'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Feet',
        'Ft'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Inch',
        'In'
    );

INSERT INTO
    account_app.unit (company_id, name, short_name)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Centimeter',
        'CM'
    );

CREATE TABLE account_app.item (
    id uuid DEFAULT uuid_generate_v4(),
    name text NOT NULL,
    type text,
    detail text NOT NULL,
    last_purchase_price double precision NOT NULL,
    last_selling_price double precision NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO
    account_app.item (id, name, type, detail, lpp, lsp)
VALUES
    (
        '1e1661e2-1297-494f-8a95-d8574e7c3df0',
        'Buffalo',
        'Food',
        '250ml energy drink',
        5.00,
        10.00,
    );

CREATE TABLE account_app.account (
    id int NOT NULL,
    company_id uuid NOT NULL,
    parent_id int,
    children_id int [],
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
);

-- Assets
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        1,
        NULL,
        '{14, 15, 17, 18}',
        'Assets'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        14,
        1,
        '{141, 142}',
        'Current Asset'
    ),
    (
        141,
        14,
        NULL,
        'PDC Recievables'
    ),
    (142, 14, NULL, 'VAT (Input Purchases)');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        15,
        1,
        '{151, 152, 153}',
        'Cash & Bank'
    ),
    (
        151,
        15,
        NULL,
        'Cash'
    ),
    (152, 15, NULL, 'Axis'),
    (153, 15, NULL, 'HDFC');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        17,
        1,
        '{171, 172}',
        'Customer'
    ),
    (
        171,
        17,
        NULL,
        'Client 1'
    ),
    (172, 17, NULL, 'Client 2');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        18,
        1,
        '{181, 182}',
        'Customer'
    ),
    (
        181,
        18,
        NULL,
        'Ebrahim'
    ),
    (182, 18, NULL, 'Tajik');

-- Liabilities
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        2,
        NULL,
        '{22}',
        'Liabilities'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        22,
        2,
        '{221, 222, 223}',
        'Current Liabilities'
    ),
    (
        221,
        22,
        NULL,
        'PDC Payables'
    ),
    (222, 22, NULL, 'VAT (Output Sales)'),
    (223, 22, NULL, 'FTA (VAT)');

-- Vendor
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        23,
        2,
        '{231, 232}',
        'Vendor'
    ),
    (
        231,
        23,
        NULL,
        'Vendor 1'
    ),
    (232, 23, NULL, 'Vendor 2');

-- Inventory
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        3,
        NULL,
        '{31}',
        'Inventory'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        31,
        3,
        NULL,
        'Stock in Hand'
    );

-- Income
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        4,
        NULL,
        '{41}',
        'Income'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        41,
        4,
        '{411}',
        'Sales'
    ),
    (411, 41, NULL, 'Sales');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        46,
        4,
        '{461}',
        'Other Incomes'
    ),
    (461, 46, NULL, 'Discounts');

-- Expenses
INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        5,
        NULL,
        '{51, 52}',
        'Expenses'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        51,
        5,
        '{511}',
        'Purchase'
    ),
    (511, 51, NULL, 'Purchase');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        52,
        5,
        '{521, 522, 523, 524}',
        'Cost of Sales'
    ),
    (521, 52, NULL, 'Discounts'),
    (522, 52, NULL, 'Customs'),
    (523, 52, NULL, 'Freight'),
    (524, 52, NULL, ' Transport');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        53,
        5,
        NULL,
        'Direct Expense'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        54,
        5,
        '{541, 542, 543, 544}',
        'Administration'
    ),
    (541, 54, NULL, 'Salary'),
    (542, 54, NULL, 'Interest'),
    (543, 54, NULL, 'Visa'),
    (544, 54, NULL, ' Advertisement');

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        55,
        5,
        NULL,
        'VAT'
    );

INSERT INTO
    account_app.account (id, parent_id, children_id, name)
VALUES
    (
        56,
        5,
        NULL,
        'Bad Debts'
    );

CREATE TABLE account_app.journal_voucher (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    project_id uuid NOT NULL,
    ref text NOT NULL,
    narration text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id)
);

CREATE TABLE account_app.sales_voucher (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    project_id uuid NOT NULL,
    invoice text NOT NULL,
    ref text NOT NULL,
    narration text NOT NULL,
    amount double precision NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id)
);

CREATE TABLE account_app.purchase_voucher (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    voucher_no INT AUTOINCREMENT NOT NULL,
    project_id uuid NOT NULL,
    invoice text NOT NULL,
    ref text NOT NULL,
    narration text NOT NULL,
    discount_amt double precision NOT NULL,
    vat_amt double precision NOT NULL,
    amount double precision NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id)
);

CREATE TABLE account_app.reciept_voucher (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    project_id uuid NOT NULL,
    invoice text NOT NULL,
    ref text NOT NULL,
    narration text NOT NULL,
    bank text NOT NULL,
    cheque text NOT NULL,
    cheque_date date NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id)
);

CREATE TABLE account_app.salesman (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    commision_percentage int NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE account_app.transaction_item (
    id uuid DEFAULT uuid_generate_v4(),
    voucher_id uuid NOT NULL,
    company_id uuid NOT NULL,
    description text NOT NULL,
    unit text NOT NULL,
    qty double precision NOT NULL,
    rate double precision NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id)
);

CREATE TABLE account_app.transaction (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    voucher_id uuid DEFAULT uuid_generate_v4(),
    voucher_type text NOT NULL,
    date date NOT NULL,
    currency text NOT NULL,
    salesman_id uuid NOT NULL,
    -- voucher_type = SALES (SA) | PURCHASE (PU) | RECIEPT (RV) | PAYMENTS (PV) | JOURNAL (JV)    
    account_id uuid NOT NULL,
    narration text NOT NULL,
    amount double precision NOT NULL,
    dc text NOT NULL,
    -- dc = DEBIT (D) | CREDIT (C)
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (account_id) REFERENCES account_app.account(id),
    FOREIGN KEY (voucher_id) REFERENCES account_app.journal_voucher(id),
    FOREIGN KEY (voucher_id) REFERENCES account_app.sales_voucher(id),
    FOREIGN KEY (voucher_id) REFERENCES account_app.purchase_voucher(id),
    FOREIGN KEY (voucher_id) REFERENCES account_app.reciept_voucher(id),
    FOREIGN KEY (salesman_id) REFERENCES account_app.salesman(id),
);