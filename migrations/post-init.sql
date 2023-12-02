CREATE TABLE account_app.person (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    mobile_number text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT person_id_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_person_email_password ON account_app.person USING btree (email, password);

INSERT INTO
    account_app.person (company_id, name, email, password, mobile_number)
VALUES
    (
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'admin',
        'admin@gmail.com',
        'admin',
        '+91-123456789'        
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

CREATE TABLE account_app.salesman (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    name text NOT NULL,
    commision_percentage int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

INSERT INTO
    account_app.salesman (
        id,
        company_id,
        name,
        commision_percentage
    )
VALUES
    (
        '703997eb-6919-4857-8e04-2f968974c20e',
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        'Food Seller',
        0
    );

CREATE TABLE account_app.item (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    location_id uuid NOT NULL,
    name text NOT NULL,
    type text,
    detail text NOT NULL,
    last_purchase_price double precision NOT NULL,
    last_selling_price double precision NOT NULL,
    stock int NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id)
);

INSERT INTO
    account_app.item (id, company_id, location_id, name, type, detail, last_purchase_price, last_selling_price, stock)
VALUES
    (
        '1e1661e2-1297-494f-8a95-d8574e7c3df0',
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        '2b35475d-b887-45af-8459-46ca820ccbb8',
        'Buffalo',
        'Food',
        '250ml energy drink',
        3100.00,
        3100.00,
        100
    );

CREATE TABLE account_app.account (
    id int NOT NULL,
    company_id uuid NOT NULL,
    parent_id int,
    children_id int [],
    name text NOT NULL,
    balance double precision NOT NULL DEFAULT 0.00,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
);

-- Assets
INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        1,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        NULL,
        '{14, 12, 13, 14, 15, 16, 17, 18}',
        'Assets'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        11,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{111, 112, 113, 114, 115}',
        'Fixed Assets'
    ),
    (
        12,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{121, 122, 123}',
        'Investments'
    ),
    (
        13,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        NULL,
        'Closing Stock'
    ),
    (
        14,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{141, 142}',
        'Current Asset'
    ),
    (
        15,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{151, 152, 153}',
        'Cash & Bank'
    ),
    (
        16,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{161}',
        'Deposits'
    ),
    (
        17,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{171, 172}',
        'Customers'
    ),
    (
        18,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        '{181, 182}',
        'Loans & Advances Receivables'
    ),
    (
        19,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        1,
        NULL,
        'Prepaids'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        111,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        11,
        NULL,
        'Furnitures'
    ),
    (
        112,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        11,
        NULL,
        'Equipments'
    ),
    (
        113,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        11,
        NULL,
        'Computers'
    ),
    (
        114,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        11,
        NULL,
        'Vehicles'
    ),
    (
        115,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        11,
        NULL,
        'Less: Depreciation'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        121,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        12,
        NULL,
        'Fixed Deposits'
    ),
    (
        122,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        12,
        NULL,
        'Shares'
    ),
    (
        123,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        12,
        NULL,
        'Mutual Funds'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        131,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        13,
        NULL,
        'Closing Stock'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        141,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        14,
        NULL,
        'PDC Receivables'
    ),
    (142, '464c48c1-463c-425d-bdfa-85435524fcdc', 14, NULL, 'VAT (Input Purchases)');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        151,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        15,
        NULL,
        'Cash'
    ),
    (152, '464c48c1-463c-425d-bdfa-85435524fcdc', 15, NULL, 'HDFC'),
    (153, '464c48c1-463c-425d-bdfa-85435524fcdc', 15, NULL, 'AXIS');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        161,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        16,
        NULL,
        'DEWA'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        171,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        17,
        NULL,
        'Client 1'
    ),
    (172, '464c48c1-463c-425d-bdfa-85435524fcdc', 17, NULL, 'Client 2');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        181,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        18,
        NULL,
        'Ebrahim'
    ),
    (182, '464c48c1-463c-425d-bdfa-85435524fcdc', 18, NULL, 'Tajik');

-- Liabilities
INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        2,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        NULL,
        '{22, 23}',
        'Liabilities'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        21,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        '{211, 212}',
        'Capital'
    ),
    (
        22,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        '{221, 222, 223}',
        'Current Liabilities'
    ),
    (
        23,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        '{231, 232}',
        'Vendor'
    ),
    (
        24,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        NULL,
        'Vendor'
    ),
    (
        25,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        NULL,
        'Loan & Advances Payables'
    ),
    (
        26,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        2,
        NULL,
        'Accured Expenses'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        211,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        21,
        NULL,
        'Partners Capital'
    ),
    (
        212,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        21,
        NULL,
        'Add: Profit/Loss'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES    
    (
        221,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        22,
        NULL,
        'PDC Payables'
    ),
    (222, '464c48c1-463c-425d-bdfa-85435524fcdc', 22, NULL, 'VAT (Output Sales)'),
    (223, '464c48c1-463c-425d-bdfa-85435524fcdc', 22, NULL, 'FTA (VAT)');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        231,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        23,
        NULL,
        'Vendor 1'
    ),
    (232, '464c48c1-463c-425d-bdfa-85435524fcdc', 23, NULL, 'Vendor 2');

-- Inventory
INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        3,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        NULL,
        '{31}',
        'Inventory'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        31,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        3,
        NULL,
        'Stock in Hand'
    );

-- Income
INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        4,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        NULL,
        '{41, 42, 43, 44, 45, 46}',
        'Income'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        41,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        '{411, 412}',
        'Sales'
    ),
    (
        42,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        NULL,
        'Closing Stock'
    ),
    (
        43,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        NULL,
        'Rents'
    ),
    (
        44,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        NULL,
        'Interest/Dividends'
    ),
    (
        45,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        NULL,
        'Commisions'
    ),
    (
        46,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        4,
        '{461}',
        'Other Incomes'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (411, '464c48c1-463c-425d-bdfa-85435524fcdc', 41, NULL, 'Sales'),
    (412, '464c48c1-463c-425d-bdfa-85435524fcdc', 41, NULL, 'Less: Sales Return');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (461, '464c48c1-463c-425d-bdfa-85435524fcdc', 46, NULL, 'Discount on Purchases');

-- Expenses
INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        5,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        NULL,
        '{51, 52, 53, 54, 55, 56, 57, 58, 59}',
        'Expenses'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (
        51,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        '{511, 512}',
        'Purchase'
    ),
    (
        52,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        '{521}',
        'Cost of Sales'
    ),
    (
        53,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'Direct Expense'
    ),
    (
        54,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'Custom'
    ),
    (
        55,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'Freight'
    ),
    (
        56,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'Indirect Expense'
    ),
    (
        57,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        '{571, 572, 573, 574}',
        'Administration'
    ),
    (
        58,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'VAT'
    ),
    (
        59,
        '464c48c1-463c-425d-bdfa-85435524fcdc',
        5,
        NULL,
        'Bad Debts'
    );

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (511, '464c48c1-463c-425d-bdfa-85435524fcdc', 51, NULL, 'Purchases'),
    (512, '464c48c1-463c-425d-bdfa-85435524fcdc', 51, NULL, 'Less: Purchase Return');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (521, '464c48c1-463c-425d-bdfa-85435524fcdc', 52, NULL, 'Discount on Sales');

INSERT INTO
    account_app.account (id, company_id, parent_id, children_id, name)
VALUES
    (571, '464c48c1-463c-425d-bdfa-85435524fcdc', 54, NULL, 'Salary'),
    (572, '464c48c1-463c-425d-bdfa-85435524fcdc', 54, NULL, 'Interest'),
    (573, '464c48c1-463c-425d-bdfa-85435524fcdc', 54, NULL, 'Visa'),
    (574, '464c48c1-463c-425d-bdfa-85435524fcdc', 54, NULL, ' Advertisement');

CREATE TABLE account_app.transaction (
    id uuid DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    date date NOT NULL,
    voucher_type text NOT NULL,
    -- voucher_type = SALES (SA) | PURCHASE (PU) | RECIEPT (RV) | PAYMENTS (PV) | JOURNAL (JV)
    voucher_no text NOT NULL,
    currency_id uuid NOT NULL,
    salesman_id uuid,
    ref text,
    invoice text,
    narration text,
    amount double precision NOT NULL,
    bank text,
    cheque_no text,
    cheque_date text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id),
    FOREIGN KEY (salesman_id) REFERENCES account_app.salesman(id)
);

CREATE TABLE account_app.transaction_account (
    id uuid DEFAULT uuid_generate_v4(),
    transaction_id uuid NOT NULL,
    company_id uuid NOT NULL,
    project_id uuid NOT NULL,
    account_id int NOT NULL,
    date date NOT NULL,
    narration text,
    amount double precision NOT NULL,
    dc char(1) NOT NULL,
    -- DEBIT (D) | CREDIT (C)
    balance double precision NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (transaction_id) REFERENCES account_app.transaction(id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id),
    FOREIGN KEY (project_id) REFERENCES account_app.project(id),
    FOREIGN KEY (account_id) REFERENCES account_app.account(id)
);

CREATE TABLE account_app.transaction_item (
    id uuid DEFAULT uuid_generate_v4(),
    transaction_id uuid NOT NULL,
    company_id uuid NOT NULL,
    date date NOT NULL,
    item_id uuid NOT NULL,
    description text NOT NULL,
    unit text NOT NULL,
    qty double precision NOT NULL,
    rate double precision NOT NULL,
    amount double precision NOT NULL,
    movement text NOT NULL,
    -- IN | OUT
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (transaction_id) REFERENCES account_app.transaction(id),
    FOREIGN KEY (company_id) REFERENCES account_app.company(id),
    FOREIGN KEY (item_id) REFERENCES account_app.item(id)
);