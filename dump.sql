--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categories (
    name text NOT NULL,
    description text,
    owner text
);


ALTER TABLE categories OWNER TO postgres;

--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (name, description, owner) FROM stdin;
\.


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (name);


--
-- Name: categories_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_owner_fkey FOREIGN KEY (owner) REFERENCES account(name);


--
-- PostgreSQL database dump complete
--

