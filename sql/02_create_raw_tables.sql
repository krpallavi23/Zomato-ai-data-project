-- 02_create_raw_tables.sql
-- Redshift translation of the Snowflake tutorial RAW tables -> raaw schema.
-- Type mapping used:
--   Snowflake STRING       -> Redshift VARCHAR
--   Snowflake NUMBER       -> Redshift BIGINT / NUMERIC / INTEGER (contextual)
--   Snowflake TIMESTAMP_NTZ -> Redshift TIMESTAMP
--   Snowflake DATE         -> Redshift DATE
--
-- Note: Redshift does not support CREATE OR REPLACE TABLE for regular
-- tables, so we use CREATE TABLE IF NOT EXISTS (safe to re-run).

CREATE TABLE IF NOT EXISTS raaw.restaurants (
  _idx          VARCHAR(64),                     -- leading index column in the CSV (ignored downstream)
  id            VARCHAR(64),
  name          VARCHAR(256),
  city          VARCHAR(128),
  rating        VARCHAR(16),
  rating_count  VARCHAR(32),
  cost          VARCHAR(32),
  cuisine       VARCHAR(256),
  lic_no        VARCHAR(128),
  link          VARCHAR(2048),
  address       VARCHAR(1024),
  menu          VARCHAR(4096)
);

CREATE TABLE IF NOT EXISTS raaw.users (
  _idx           VARCHAR(64),                    -- leading index column in the CSV
  user_id        VARCHAR(64),
  name           VARCHAR(256),
  email          VARCHAR(256),
  password       VARCHAR(256),
  age            VARCHAR(16),
  gender         VARCHAR(16),
  marital_status VARCHAR(32),
  occupation     VARCHAR(128),
  monthly_income VARCHAR(64),
  education      VARCHAR(128),
  family_size    VARCHAR(16)
);

CREATE TABLE IF NOT EXISTS raaw.food (
  _idx          VARCHAR(64),                     -- leading index column in the CSV
  f_id          VARCHAR(64),
  item          VARCHAR(256),
  veg_or_non_veg VARCHAR(16)
);

CREATE TABLE IF NOT EXISTS raaw.menu (
  _idx     VARCHAR(64),                          -- leading index column in the CSV
  menu_id  VARCHAR(64),
  r_id     VARCHAR(64),
  f_id     VARCHAR(64),
  cuisine  VARCHAR(128),
  price    VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS raaw.orders (
  order_id          BIGINT,
  order_timestamp   TIMESTAMP,
  order_date        DATE,
  user_id           BIGINT,
  r_id              BIGINT,
  restaurant_city   VARCHAR(128),
  cuisine           VARCHAR(128),
  items_count       INTEGER,
  sales_qty         INTEGER,
  subtotal          NUMERIC(12,2),
  discount          NUMERIC(12,2),
  delivery_fee      NUMERIC(12,2),
  gst               NUMERIC(12,2),
  sales_amount      NUMERIC(12,2),
  currency          VARCHAR(8),
  payment_method    VARCHAR(32),
  order_status      VARCHAR(32),
  customer_rating   NUMERIC(3,1),
  delivery_time_min INTEGER
);

CREATE TABLE IF NOT EXISTS raaw.order_items (
  order_item_id BIGINT,
  order_id      BIGINT,
  r_id          BIGINT,
  f_id          VARCHAR(64),
  price         NUMERIC(12,2),
  quantity      INTEGER,
  line_amount   NUMERIC(12,2)
);

CREATE TABLE IF NOT EXISTS raaw.reviews (
  review_id     BIGINT,
  order_id      BIGINT,
  user_id       BIGINT,
  restaurant_id BIGINT,
  rating        NUMERIC(3,1),
  comment       VARCHAR(max),                    -- free text for the AI layer
  review_date   DATE
);