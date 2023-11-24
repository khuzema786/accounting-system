-- auxiliary settings
CREATE USER dev_rw WITH PASSWORD 'root';

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA account_app;
ALTER SCHEMA account_app OWNER TO dev_rw;
GRANT ALL ON SCHEMA account_app TO dev_rw;
GRANT ALL ON ALL TABLES IN SCHEMA account_app TO dev_rw;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA account_app TO dev_rw;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA account_app TO dev_rw; 