--
-- PostgreSQL database dump
--

\restrict Y2fliDHmlWZDNQzmGv224izHzGQYuZYGCxgbiPoAAMk9tf8qaD39LtN6bQbSpbz

-- Dumped from database version 16.13 (Ubuntu 16.13-1.pgdg25.10+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-1.pgdg25.10+1)

-- Started on 2026-03-11 12:49:30 MSK

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

DROP DATABASE "SQLB10_Isolation levels";
--
-- TOC entry 3511 (class 1262 OID 17771)
-- Name: SQLB10_Isolation levels; Type: DATABASE; Schema: -; Owner: milka
--

CREATE DATABASE "SQLB10_Isolation levels" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE "SQLB10_Isolation levels" OWNER TO milka;

\unrestrict Y2fliDHmlWZDNQzmGv224izHzGQYuZYGCxgbiPoAAMk9tf8qaD39LtN6bQbSpbz
\encoding SQL_ASCII
\connect -reuse-previous=on "dbname='SQLB10_Isolation levels'"
\restrict Y2fliDHmlWZDNQzmGv224izHzGQYuZYGCxgbiPoAAMk9tf8qaD39LtN6bQbSpbz

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 17863)
-- Name: menu; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.menu (
    id bigint NOT NULL,
    pizzeria_id bigint NOT NULL,
    pizza_name character varying NOT NULL,
    price numeric DEFAULT 1 NOT NULL
);


ALTER TABLE public.menu OWNER TO milka;

--
-- TOC entry 217 (class 1259 OID 17869)
-- Name: person; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.person (
    id bigint NOT NULL,
    name character varying NOT NULL,
    age integer DEFAULT 10 NOT NULL,
    gender character varying DEFAULT 'female'::character varying NOT NULL,
    address character varying,
    CONSTRAINT ch_gender CHECK (((gender)::text = ANY (ARRAY[('female'::character varying)::text, ('male'::character varying)::text])))
);


ALTER TABLE public.person OWNER TO milka;

--
-- TOC entry 218 (class 1259 OID 17877)
-- Name: person_discounts; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.person_discounts (
    id bigint NOT NULL,
    person_id bigint,
    pizzeria_id bigint,
    discount numeric DEFAULT 0,
    CONSTRAINT ch_nn_discount CHECK ((discount IS NOT NULL)),
    CONSTRAINT ch_nn_person_id CHECK ((person_id IS NOT NULL)),
    CONSTRAINT ch_nn_pizzeria_id CHECK ((pizzeria_id IS NOT NULL)),
    CONSTRAINT ch_range_discount CHECK (((discount >= (0)::numeric) AND (discount <= (100)::numeric)))
);


ALTER TABLE public.person_discounts OWNER TO milka;

--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE person_discounts; Type: COMMENT; Schema: public; Owner: milka
--

COMMENT ON TABLE public.person_discounts IS 'Хранит персональные скидки клиентов в конкретных пиццериях. Скидка рассчитывается на основе количества заказов клиента в данной пиццерии.';


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN person_discounts.id; Type: COMMENT; Schema: public; Owner: milka
--

COMMENT ON COLUMN public.person_discounts.id IS 'Уникальный идентификатор записи о скидке (первичный ключ).';


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN person_discounts.person_id; Type: COMMENT; Schema: public; Owner: milka
--

COMMENT ON COLUMN public.person_discounts.person_id IS 'Идентификатор клиента (внешний ключ к таблице person).';


--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN person_discounts.pizzeria_id; Type: COMMENT; Schema: public; Owner: milka
--

COMMENT ON COLUMN public.person_discounts.pizzeria_id IS 'Идентификатор пиццерии (внешний ключ к таблице pizzeria).';


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN person_discounts.discount; Type: COMMENT; Schema: public; Owner: milka
--

COMMENT ON COLUMN public.person_discounts.discount IS 'Размер персональной скидки в процентах (от 0 до 100). Рассчитывается автоматически: 10.5% за 1 заказ, 22% за 2 заказа, 30% за 3 и более заказов.';


--
-- TOC entry 219 (class 1259 OID 17887)
-- Name: person_order; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.person_order (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    menu_id bigint NOT NULL,
    order_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.person_order OWNER TO milka;

--
-- TOC entry 220 (class 1259 OID 17891)
-- Name: person_visits; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.person_visits (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    pizzeria_id bigint NOT NULL,
    visit_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.person_visits OWNER TO milka;

--
-- TOC entry 221 (class 1259 OID 17895)
-- Name: pizzeria; Type: TABLE; Schema: public; Owner: milka
--

CREATE TABLE public.pizzeria (
    id bigint NOT NULL,
    name character varying NOT NULL,
    rating numeric DEFAULT 0 NOT NULL,
    CONSTRAINT ch_rating CHECK (((rating >= (0)::numeric) AND (rating <= (5)::numeric)))
);


ALTER TABLE public.pizzeria OWNER TO milka;

--
-- TOC entry 215 (class 1259 OID 17811)
-- Name: seq_person_discounts; Type: SEQUENCE; Schema: public; Owner: milka
--

CREATE SEQUENCE public.seq_person_discounts
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_person_discounts OWNER TO milka;

--
-- TOC entry 3500 (class 0 OID 17863)
-- Dependencies: 216
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.menu VALUES (1, 1, 'cheese pizza', 900);
INSERT INTO public.menu VALUES (2, 1, 'pepperoni pizza', 1200);
INSERT INTO public.menu VALUES (3, 1, 'sausage pizza', 1200);
INSERT INTO public.menu VALUES (4, 1, 'supreme pizza', 1200);
INSERT INTO public.menu VALUES (5, 6, 'cheese pizza', 950);
INSERT INTO public.menu VALUES (6, 6, 'pepperoni pizza', 800);
INSERT INTO public.menu VALUES (7, 6, 'sausage pizza', 1000);
INSERT INTO public.menu VALUES (8, 2, 'cheese pizza', 800);
INSERT INTO public.menu VALUES (9, 2, 'mushroom pizza', 1100);
INSERT INTO public.menu VALUES (10, 3, 'cheese pizza', 780);
INSERT INTO public.menu VALUES (11, 3, 'supreme pizza', 850);
INSERT INTO public.menu VALUES (12, 4, 'cheese pizza', 700);
INSERT INTO public.menu VALUES (13, 4, 'mushroom pizza', 950);
INSERT INTO public.menu VALUES (14, 4, 'pepperoni pizza', 1000);
INSERT INTO public.menu VALUES (15, 4, 'sausage pizza', 950);
INSERT INTO public.menu VALUES (16, 5, 'cheese pizza', 700);
INSERT INTO public.menu VALUES (17, 5, 'pepperoni pizza', 800);
INSERT INTO public.menu VALUES (18, 5, 'supreme pizza', 850);
INSERT INTO public.menu VALUES (20, 2, 'sicilian pizza', 900);


--
-- TOC entry 3501 (class 0 OID 17869)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.person VALUES (1, 'Anna', 16, 'female', 'Moscow');
INSERT INTO public.person VALUES (2, 'Andrey', 21, 'male', 'Moscow');
INSERT INTO public.person VALUES (3, 'Kate', 33, 'female', 'Kazan');
INSERT INTO public.person VALUES (4, 'Denis', 13, 'male', 'Kazan');
INSERT INTO public.person VALUES (5, 'Elvira', 45, 'female', 'Kazan');
INSERT INTO public.person VALUES (6, 'Irina', 21, 'female', 'Saint-Petersburg');
INSERT INTO public.person VALUES (7, 'Peter', 24, 'male', 'Saint-Petersburg');
INSERT INTO public.person VALUES (8, 'Nataly', 30, 'female', 'Novosibirsk');
INSERT INTO public.person VALUES (9, 'Dmitriy', 18, 'male', 'Samara');


--
-- TOC entry 3502 (class 0 OID 17877)
-- Dependencies: 218
-- Data for Name: person_discounts; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.person_discounts VALUES (1, 4, 5, 30);
INSERT INTO public.person_discounts VALUES (2, 3, 5, 10.5);
INSERT INTO public.person_discounts VALUES (3, 1, 1, 22);
INSERT INTO public.person_discounts VALUES (4, 7, 2, 10.5);
INSERT INTO public.person_discounts VALUES (5, 6, 2, 10.5);
INSERT INTO public.person_discounts VALUES (6, 6, 4, 10.5);
INSERT INTO public.person_discounts VALUES (7, 7, 1, 22);
INSERT INTO public.person_discounts VALUES (8, 4, 2, 10.5);
INSERT INTO public.person_discounts VALUES (9, 8, 2, 10.5);
INSERT INTO public.person_discounts VALUES (10, 2, 2, 22);
INSERT INTO public.person_discounts VALUES (11, 5, 6, 22);
INSERT INTO public.person_discounts VALUES (12, 9, 6, 10.5);
INSERT INTO public.person_discounts VALUES (13, 9, 5, 10.5);
INSERT INTO public.person_discounts VALUES (14, 8, 4, 10.5);
INSERT INTO public.person_discounts VALUES (15, 4, 6, 22);


--
-- TOC entry 3503 (class 0 OID 17887)
-- Dependencies: 219
-- Data for Name: person_order; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.person_order VALUES (1, 1, 1, '2022-01-01');
INSERT INTO public.person_order VALUES (2, 1, 2, '2022-01-01');
INSERT INTO public.person_order VALUES (3, 2, 8, '2022-01-01');
INSERT INTO public.person_order VALUES (4, 2, 9, '2022-01-01');
INSERT INTO public.person_order VALUES (5, 3, 16, '2022-01-04');
INSERT INTO public.person_order VALUES (6, 4, 16, '2022-01-07');
INSERT INTO public.person_order VALUES (7, 4, 17, '2022-01-07');
INSERT INTO public.person_order VALUES (8, 4, 18, '2022-01-07');
INSERT INTO public.person_order VALUES (9, 4, 6, '2022-01-08');
INSERT INTO public.person_order VALUES (10, 4, 7, '2022-01-08');
INSERT INTO public.person_order VALUES (11, 5, 6, '2022-01-09');
INSERT INTO public.person_order VALUES (12, 5, 7, '2022-01-09');
INSERT INTO public.person_order VALUES (13, 6, 13, '2022-01-01');
INSERT INTO public.person_order VALUES (14, 7, 3, '2022-01-03');
INSERT INTO public.person_order VALUES (15, 7, 9, '2022-01-05');
INSERT INTO public.person_order VALUES (16, 7, 4, '2022-01-05');
INSERT INTO public.person_order VALUES (17, 8, 8, '2022-01-06');
INSERT INTO public.person_order VALUES (18, 8, 14, '2022-01-07');
INSERT INTO public.person_order VALUES (19, 9, 18, '2022-01-09');
INSERT INTO public.person_order VALUES (20, 9, 6, '2022-01-10');
INSERT INTO public.person_order VALUES (21, 4, 20, '2022-02-24');
INSERT INTO public.person_order VALUES (22, 6, 20, '2022-02-24');


--
-- TOC entry 3504 (class 0 OID 17891)
-- Dependencies: 220
-- Data for Name: person_visits; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.person_visits VALUES (1, 1, 1, '2022-01-01');
INSERT INTO public.person_visits VALUES (2, 2, 2, '2022-01-01');
INSERT INTO public.person_visits VALUES (3, 2, 1, '2022-01-02');
INSERT INTO public.person_visits VALUES (4, 3, 5, '2022-01-03');
INSERT INTO public.person_visits VALUES (5, 3, 6, '2022-01-04');
INSERT INTO public.person_visits VALUES (6, 4, 5, '2022-01-07');
INSERT INTO public.person_visits VALUES (7, 4, 6, '2022-01-08');
INSERT INTO public.person_visits VALUES (8, 5, 2, '2022-01-08');
INSERT INTO public.person_visits VALUES (9, 5, 6, '2022-01-09');
INSERT INTO public.person_visits VALUES (10, 6, 2, '2022-01-09');
INSERT INTO public.person_visits VALUES (11, 6, 4, '2022-01-01');
INSERT INTO public.person_visits VALUES (12, 7, 1, '2022-01-03');
INSERT INTO public.person_visits VALUES (13, 7, 2, '2022-01-05');
INSERT INTO public.person_visits VALUES (14, 8, 1, '2022-01-05');
INSERT INTO public.person_visits VALUES (15, 8, 2, '2022-01-06');
INSERT INTO public.person_visits VALUES (16, 8, 4, '2022-01-07');
INSERT INTO public.person_visits VALUES (17, 9, 4, '2022-01-08');
INSERT INTO public.person_visits VALUES (18, 9, 5, '2022-01-09');
INSERT INTO public.person_visits VALUES (19, 9, 6, '2022-01-10');
INSERT INTO public.person_visits VALUES (20, 4, 2, '2022-02-24');
INSERT INTO public.person_visits VALUES (21, 6, 2, '2022-02-24');
INSERT INTO public.person_visits VALUES (22, 9, 3, '2022-01-08');


--
-- TOC entry 3505 (class 0 OID 17895)
-- Dependencies: 221
-- Data for Name: pizzeria; Type: TABLE DATA; Schema: public; Owner: milka
--

INSERT INTO public.pizzeria VALUES (3, 'DoDo Pizza', 3.2);
INSERT INTO public.pizzeria VALUES (4, 'Papa Johns', 4.9);
INSERT INTO public.pizzeria VALUES (5, 'Best Pizza', 2.3);
INSERT INTO public.pizzeria VALUES (6, 'DinoPizza', 4.2);
INSERT INTO public.pizzeria VALUES (10, 'Kazan Pizza', 5);
INSERT INTO public.pizzeria VALUES (11, 'Kazan Pizza 2', 4);
INSERT INTO public.pizzeria VALUES (1, 'Pizza Hut', 2);
INSERT INTO public.pizzeria VALUES (2, 'Dominos', 3);


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_person_discounts; Type: SEQUENCE SET; Schema: public; Owner: milka
--

SELECT pg_catalog.setval('public.seq_person_discounts', 16, true);


--
-- TOC entry 3335 (class 2606 OID 17903)
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- TOC entry 3340 (class 2606 OID 17905)
-- Name: person_discounts person_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_discounts
    ADD CONSTRAINT person_discounts_pkey PRIMARY KEY (id);


--
-- TOC entry 3342 (class 2606 OID 17907)
-- Name: person_order person_order_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_order
    ADD CONSTRAINT person_order_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 17909)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 3344 (class 2606 OID 17911)
-- Name: person_visits person_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_visits
    ADD CONSTRAINT person_visits_pkey PRIMARY KEY (id);


--
-- TOC entry 3348 (class 2606 OID 17913)
-- Name: pizzeria pizzeria_pkey; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.pizzeria
    ADD CONSTRAINT pizzeria_pkey PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 17915)
-- Name: person_visits uk_person_visits; Type: CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_visits
    ADD CONSTRAINT uk_person_visits UNIQUE (person_id, pizzeria_id, visit_date);


--
-- TOC entry 3338 (class 1259 OID 17916)
-- Name: idx_person_discounts_unique; Type: INDEX; Schema: public; Owner: milka
--

CREATE UNIQUE INDEX idx_person_discounts_unique ON public.person_discounts USING btree (person_id, pizzeria_id);


--
-- TOC entry 3349 (class 2606 OID 17917)
-- Name: menu fk_menu_pizzeria_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT fk_menu_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES public.pizzeria(id);


--
-- TOC entry 3352 (class 2606 OID 17922)
-- Name: person_order fk_order_menu_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_order
    ADD CONSTRAINT fk_order_menu_id FOREIGN KEY (menu_id) REFERENCES public.menu(id);


--
-- TOC entry 3353 (class 2606 OID 17927)
-- Name: person_order fk_order_person_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_order
    ADD CONSTRAINT fk_order_person_id FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 3350 (class 2606 OID 17932)
-- Name: person_discounts fk_person_discounts_person_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_discounts
    ADD CONSTRAINT fk_person_discounts_person_id FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 3351 (class 2606 OID 17937)
-- Name: person_discounts fk_person_discounts_pizzeria_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_discounts
    ADD CONSTRAINT fk_person_discounts_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES public.pizzeria(id);


--
-- TOC entry 3354 (class 2606 OID 17942)
-- Name: person_visits fk_person_visits_person_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_visits
    ADD CONSTRAINT fk_person_visits_person_id FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 3355 (class 2606 OID 17947)
-- Name: person_visits fk_person_visits_pizzeria_id; Type: FK CONSTRAINT; Schema: public; Owner: milka
--

ALTER TABLE ONLY public.person_visits
    ADD CONSTRAINT fk_person_visits_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES public.pizzeria(id);


-- Completed on 2026-03-11 12:49:30 MSK

--
-- PostgreSQL database dump complete
--

\unrestrict Y2fliDHmlWZDNQzmGv224izHzGQYuZYGCxgbiPoAAMk9tf8qaD39LtN6bQbSpbz

