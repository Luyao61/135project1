--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE account (
    name text NOT NULL,
    role text NOT NULL,
    age integer NOT NULL,
    state text NOT NULL
);


ALTER TABLE account OWNER TO postgres;

--
-- Name: boughtcart; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE boughtcart (
    id integer NOT NULL,
    pid integer NOT NULL,
    uid character(20) NOT NULL,
    date character(40) NOT NULL,
    price integer NOT NULL,
    quanity integer NOT NULL
);


ALTER TABLE boughtcart OWNER TO postgres;

--
-- Name: boughtcart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE boughtcart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE boughtcart_id_seq OWNER TO postgres;

--
-- Name: boughtcart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE boughtcart_id_seq OWNED BY boughtcart.id;


--
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cart (
    id integer NOT NULL,
    uid character(20) NOT NULL,
    pid integer NOT NULL,
    price integer NOT NULL,
    quanity integer NOT NULL
);


ALTER TABLE cart OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cart_id_seq OWNER TO postgres;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cart_id_seq OWNED BY cart.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    cid integer,
    name text NOT NULL,
    sku text NOT NULL,
    price integer NOT NULL
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boughtcart ALTER COLUMN id SET DEFAULT nextval('boughtcart_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart ALTER COLUMN id SET DEFAULT nextval('cart_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO account VALUES ('zhou', 'Owner', 12, 'AL');
INSERT INTO account VALUES ('zhang', 'Owner', 1, 'CA');
INSERT INTO account VALUES ('qwe', 'Customer', 123, 'AK');
INSERT INTO account VALUES ('customer', 'Customer', 12, 'AL');
INSERT INTO account VALUES ('ccc', 'Customer', 3, 'AL');
INSERT INTO account VALUES ('ddd', 'Customer', 34, 'AL');


--
-- Data for Name: boughtcart; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO boughtcart VALUES (1, 1, 'zhang               ', '05/05/2015                              ', 111, 3);
INSERT INTO boughtcart VALUES (2, 1, 'zhang               ', '05/05/2015                              ', 111, 4);
INSERT INTO boughtcart VALUES (3, 2, 'zhang               ', '05/05/2015                              ', 1, 5);
INSERT INTO boughtcart VALUES (4, 2, 'zhang               ', '05/05/2015                              ', 1, 5);
INSERT INTO boughtcart VALUES (5, 1, 'zhang               ', '05/05/2015                              ', 111, 3);
INSERT INTO boughtcart VALUES (6, 1, 'zhang               ', '05/05/2015                              ', 111, 3);
INSERT INTO boughtcart VALUES (7, 1, 'zhang               ', '05/05/2015                              ', 111, 4);
INSERT INTO boughtcart VALUES (8, 1, 'zhang               ', '05/05/2015                              ', 111, 5);
INSERT INTO boughtcart VALUES (9, 9, 'zhang               ', '05/05/2015                              ', 2, 333);
INSERT INTO boughtcart VALUES (10, 9, 'zhang               ', '05/05/2015                              ', 2, 4);
INSERT INTO boughtcart VALUES (11, 9, 'zhang               ', '05/05/2015                              ', 2, 5);


--
-- Name: boughtcart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('boughtcart_id_seq', 11, true);


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cart_id_seq', 14, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO categories VALUES (1, 'fruit', 'fresh!');
INSERT INTO categories VALUES (4, 'vegie', 'fresh!');


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categories_id_seq', 4, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO products VALUES (3, 4, 'tomato', 'asdmlakwej', 2);
INSERT INTO products VALUES (9, 1, 'banana', 'asaskjht', 2);
INSERT INTO products VALUES (10, 1, 'grape', 'asdrewnm', 3);
INSERT INTO products VALUES (12, 1, 'watermelon', 'asrenr', 5);
INSERT INTO products VALUES (13, 4, 'potato', 'askntramwenr', 1);
INSERT INTO products VALUES (14, 4, 'onion', 'ERASF', 2);
INSERT INTO products VALUES (16, 1, 'peach', 'aermn', 1);
INSERT INTO products VALUES (18, 1, 'pear', 'aneaueh', 1);
INSERT INTO products VALUES (19, 1, 'avacado', 'qrnjebrh', 1);
INSERT INTO products VALUES (20, 1, 'red apple', 'awejhhu', 1);
INSERT INTO products VALUES (21, 1, 'green apple', 'gaernjnu', 1);
INSERT INTO products VALUES (25, 1, 'small apple', 'asenrjun', 1);
INSERT INTO products VALUES (31, 1, 'MANGO', 'WERNKENI', 2);
INSERT INTO products VALUES (1, 1, 'apple', 'awerfedd', 111);
INSERT INTO products VALUES (2, 4, 'carrot', '1234567890s', 1);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 31, true);


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (name);


--
-- Name: boughtcart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY boughtcart
    ADD CONSTRAINT boughtcart_pkey PRIMARY KEY (id);


--
-- Name: cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: boughtcart_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boughtcart
    ADD CONSTRAINT boughtcart_pid_fkey FOREIGN KEY (pid) REFERENCES products(id);


--
-- Name: cart_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart
    ADD CONSTRAINT cart_pid_fkey FOREIGN KEY (pid) REFERENCES products(id);


--
-- Name: cart_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY boughtcart
    ADD CONSTRAINT cart_uid_fkey FOREIGN KEY (uid) REFERENCES account(name);


--
-- Name: cart_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart
    ADD CONSTRAINT cart_uid_fkey FOREIGN KEY (uid) REFERENCES account(name);


--
-- Name: products_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_cid_fkey FOREIGN KEY (cid) REFERENCES categories(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

