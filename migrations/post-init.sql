CREATE TABLE account_app.users (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name text NOT NULL,
    email text NOT NULL
);

INSERT INTO account_app.users (name, email) VALUES ('test', 'test@gmail.com');