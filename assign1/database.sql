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
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cart (
    id integer NOT NULL,
    uid text,
    pid integer,
    quantity integer NOT NULL,
    price integer NOT NULL
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
-- Name: purchasehistory; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE purchasehistory (
    id integer NOT NULL,
    uid text,
    pid integer,
    date text NOT NULL,
    quantity integer NOT NULL,
    price integer NOT NULL
);


ALTER TABLE purchasehistory OWNER TO postgres;

--
-- Name: purchasehistory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE purchasehistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasehistory_id_seq OWNER TO postgres;

--
-- Name: purchasehistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE purchasehistory_id_seq OWNED BY purchasehistory.id;


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
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY purchasehistory ALTER COLUMN id SET DEFAULT nextval('purchasehistory_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account (name, role, age, state) FROM stdin;
zhou	Owner	12	AL
zhang	Owner	1	CA
qwe	Customer	123	AK
customer	Customer	12	AL
skjehruih	Owner	123	AL
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cart (id, uid, pid, quantity, price) FROM stdin;
\.


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cart_id_seq', 14, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (id, name, description) FROM stdin;
4	vegie	fresh!
1	fruits	fresh!
6	meat	Fresh!
8	drink	tasty!!
9	desserts	delicious~
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categories_id_seq', 9, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (id, cid, name, sku, price) FROM stdin;
2	4	carrot	1234567890	1
3	4	tomato	asdmlakwej	2
9	1	banana	asaskjht	2
10	1	grape	asdrewnm	3
12	1	watermelon	asrenr	5
13	4	potato	askntramwenr	1
14	4	onion	ERASF	2
16	1	peach	aermn	1
18	1	pear	aneaueh	1
19	1	avacado	qrnjebrh	1
20	1	red apple	awejhhu	1
21	1	green apple	gaernjnu	1
25	1	small apple	asenrjun	1
31	1	MANGO	WERNKENI	2
32	8	coffee	isjroihe	1
1	1	apple	asdeasd	2
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 32, true);


--
-- Data for Name: purchasehistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY purchasehistory (id, uid, pid, date, quantity, price) FROM stdin;
1	zhou	2	05/05/2015	2	1
2	zhou	1	05/05/2015	1	10
3	zhou	1	05/05/2015	1	10
4	zhou	10	05/05/2015	2	3
5	zhou	10	05/05/2015	3	3
6	zhou	10	05/05/2015	3	3
7	zhou	13	05/05/2015	2	1
8	zhou	14	05/05/2015	0	2
9	zhou	3	05/05/2015	0	2
10	zhou	10	05/05/2015	1	3
11	zhou	1	05/06/2015	1	10
12	zhou	1	05/06/2015	1	10
13	zhou	1	05/06/2015	2	2
\.


--
-- Name: purchasehistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('purchasehistory_id_seq', 13, true);


--
-- Name: account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (name);


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
-- Name: purchasehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchasehistory
    ADD CONSTRAINT purchasehistory_pkey PRIMARY KEY (id);


--
-- Name: cart_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart
    ADD CONSTRAINT cart_pid_fkey FOREIGN KEY (pid) REFERENCES products(id);


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
-- Name: purchasehistory_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY purchasehistory
    ADD CONSTRAINT purchasehistory_pid_fkey FOREIGN KEY (pid) REFERENCES products(id);


--
-- Name: purchasehistory_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY purchasehistory
    ADD CONSTRAINT purchasehistory_uid_fkey FOREIGN KEY (uid) REFERENCES account(name);


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

