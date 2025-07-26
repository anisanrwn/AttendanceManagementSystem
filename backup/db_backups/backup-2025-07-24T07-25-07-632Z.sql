--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.activity_logs (
    log_id integer NOT NULL,
    user_id integer,
    action character varying(500) NOT NULL,
    detail text,
    ip_address character varying(100),
    "timestamp" timestamp with time zone DEFAULT now(),
    device character varying(500)
);


ALTER TABLE public.activity_logs OWNER TO "Project_owner";

--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.activity_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_logs_log_id_seq OWNER TO "Project_owner";

--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.activity_logs_log_id_seq OWNED BY public.activity_logs.log_id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO "Project_owner";

--
-- Name: attendance; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    employee_id integer,
    attendance_date date,
    late integer NOT NULL,
    attendance_status character varying(20),
    clock_in time without time zone,
    clock_in_latitude double precision,
    clock_in_longitude double precision,
    clock_in_verified boolean,
    clock_in_reason text,
    clock_in_distance double precision,
    clock_out time without time zone,
    clock_out_latitude double precision,
    clock_out_longitude double precision,
    clock_out_verified boolean,
    clock_out_reason text,
    clock_out_distance double precision,
    face_verified boolean,
    working_hour integer,
    overtime integer
);


ALTER TABLE public.attendance OWNER TO "Project_owner";

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_attendance_id_seq OWNER TO "Project_owner";

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    nrp_id integer,
    email character varying(100),
    phone_number character varying(13),
    "position" character varying(100),
    department character varying(100),
    face_encoding text
);


ALTER TABLE public.employees OWNER TO "Project_owner";

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO "Project_owner";

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: lock_system; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.lock_system (
    lock_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.lock_system OWNER TO "Project_owner";

--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.lock_system_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lock_system_lock_id_seq OWNER TO "Project_owner";

--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.lock_system_lock_id_seq OWNED BY public.lock_system.lock_id;


--
-- Name: login_attempts; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.login_attempts (
    "logAtt_id" integer NOT NULL,
    user_id integer,
    email character varying(100) NOT NULL,
    ip_address character varying(45) NOT NULL,
    attempt_time timestamp without time zone NOT NULL,
    is_successful boolean,
    user_agent text,
    failed_attempts integer,
    lockout_until timestamp without time zone
);


ALTER TABLE public.login_attempts OWNER TO "Project_owner";

--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public."login_attempts_logAtt_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."login_attempts_logAtt_id_seq" OWNER TO "Project_owner";

--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public."login_attempts_logAtt_id_seq" OWNED BY public.login_attempts."logAtt_id";


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message character varying(1000) NOT NULL,
    notification_type character varying(50),
    is_read boolean,
    created_at timestamp without time zone,
    read_at timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO "Project_owner";

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO "Project_owner";

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.permissions (
    permissions_id integer NOT NULL,
    employee_id integer,
    permission_type character varying(50),
    request_date date,
    start_date date,
    end_date date,
    reason text,
    permission_status character varying(10),
    approved_date date,
    user_id integer
);


ALTER TABLE public.permissions OWNER TO "Project_owner";

--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.permissions_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_permissions_id_seq OWNER TO "Project_owner";

--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.permissions_permissions_id_seq OWNED BY public.permissions.permissions_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.roles (
    roles_id integer NOT NULL,
    roles_name character varying(25)
);


ALTER TABLE public.roles OWNER TO "Project_owner";

--
-- Name: roles_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.roles_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_roles_id_seq OWNER TO "Project_owner";

--
-- Name: roles_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.roles_roles_id_seq OWNED BY public.roles.roles_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    employee_id integer,
    username character varying(100),
    email character varying(100),
    password character varying(500)
);


ALTER TABLE public."user" OWNER TO "Project_owner";

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.user_roles (
    user_id integer NOT NULL,
    roles_id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO "Project_owner";

--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_user_id_seq OWNER TO "Project_owner";

--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- Name: activity_logs log_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN log_id SET DEFAULT nextval('public.activity_logs_log_id_seq'::regclass);


--
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: lock_system lock_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.lock_system ALTER COLUMN lock_id SET DEFAULT nextval('public.lock_system_lock_id_seq'::regclass);


--
-- Name: login_attempts logAtt_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.login_attempts ALTER COLUMN "logAtt_id" SET DEFAULT nextval('public."login_attempts_logAtt_id_seq"'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: permissions permissions_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permissions_id SET DEFAULT nextval('public.permissions_permissions_id_seq'::regclass);


--
-- Name: roles roles_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.roles ALTER COLUMN roles_id SET DEFAULT nextval('public.roles_roles_id_seq'::regclass);


--
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.activity_logs (log_id, user_id, action, detail, ip_address, "timestamp", device) FROM stdin;
241	\N	Updated user	User SuperadminNab updated successfully	\N	2025-05-25 21:21:25.048293+00	\N
242	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-05-26 17:12:04.592744+00	\N
243	\N	Viewed employee profile	Viewed profile of employee ID 5	\N	2025-05-26 17:12:13.888908+00	\N
244	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-26 17:12:38.960165+00	\N
245	\N	Added employee	Employee juminten lasmi added successfully	\N	2025-05-26 17:33:52.099303+00	\N
246	\N	Created user	User jumi created successfully	\N	2025-05-26 17:35:45.585545+00	\N
247	\N	Updated user	User nblaalb updated successfully	\N	2025-05-26 19:35:31.519084+00	\N
248	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-26 20:08:52.708088+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
249	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-26 23:00:48.815842+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
250	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-26 23:06:19.458289+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
251	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-05-26 23:07:53.449618+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
252	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-26 23:08:18.239257+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
253	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-27 00:42:51.873027+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
254	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-27 01:33:31.593232+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
255	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-05-27 01:42:23.648111+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
256	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 01:43:38.743714+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
257	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:02:26.444879+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
258	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:03:25.289592+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
259	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:13:15.82267+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
260	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:13:46.294212+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
261	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 02:14:57.552324+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
262	15	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:15:51.005696+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
263	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:24:29.803687+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
264	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 02:46:19.246378+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
265	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-05-27 03:22:56.011375+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
266	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 13:27:41.738776+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
279	\N	Viewed employee profile	Viewed profile of employee ID 1	\N	2025-05-27 20:48:18.077268+00	\N
280	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 20:52:54.477512+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
398	\N	Updated user	User Abid updated successfully	\N	2025-06-17 19:53:44.720908+00	\N
281	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 21:24:59.797956+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
282	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-05-27 21:43:14.086363+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
283	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-27 21:47:16.980208+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
284	\N	Viewed employee profile	Viewed profile of employee ID 14	\N	2025-05-27 23:28:21.285229+00	\N
285	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-27 23:28:34.740898+00	\N
286	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 23:29:43.242628+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
287	\N	Updated user	User HR updated successfully	\N	2025-05-27 23:30:17.268295+00	\N
288	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-05-28 01:52:37.468383+00	\N
303	\N	Updated user	User admin_nisa updated successfully	\N	2025-05-29 15:07:21.060998+00	\N
304	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:03:37.059242+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
305	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:07:32.587835+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
306	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:08:27.924735+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
307	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:09:02.678233+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
308	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:11:30.96679+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
309	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:12:36.745441+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
310	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:34:35.248059+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
311	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:36:54.720947+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
312	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:37:50.486262+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
313	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 12:44:13.820643+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
314	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-07 15:34:38.50252+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
315	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 15:35:41.526533+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
316	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 15:43:19.857729+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
317	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-07 15:43:29.009634+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
318	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 15:44:38.723554+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
319	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-07 16:04:21.10268+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
320	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-08 12:23:15.847913+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
321	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-08 12:27:05.186666+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
322	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 10:58:53.926459+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
323	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:03:18.64651+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
324	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:07:33.473622+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
325	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:08:32.084972+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
326	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:09:02.379921+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
327	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:10:21.19137+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
328	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:16:22.850538+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
329	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:17:29.383867+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
330	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:18:05.499811+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
331	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:19:39.103786+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
332	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:21:30.898499+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
333	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:23:35.245297+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
334	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 11:26:03.188223+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
335	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:05:23.437376+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
336	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:06:49.207977+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
338	4	Login	User yustina.yunita@student.president.ac.id logged in successfully	127.0.0.1	2025-06-10 12:09:28.969362+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
339	\N	Updated user	User SuperadminNab updated successfully	\N	2025-06-10 12:10:41.165667+00	\N
340	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:22:00.410611+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
341	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:25:04.006007+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
342	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:29:07.456491+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
343	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-10 12:54:40.425484+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
344	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-10 13:08:58.218684+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
345	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-11 02:54:01.348109+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
346	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-11 04:48:00.324663+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
347	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-11 04:48:19.927619+00	\N
348	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-11 04:59:29.27201+00	\N
349	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-06-11 04:59:32.850875+00	\N
350	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 05:12:00.648701+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
351	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 12:06:41.705374+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
352	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-11 12:16:40.781449+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
353	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 12:41:48.773947+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
354	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 12:45:31.016135+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
355	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 13:17:52.505631+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
356	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 13:44:37.778437+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
357	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-11 14:20:06.322569+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
358	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-11 15:15:25.766618+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
359	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-11 15:25:10.90912+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
360	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-11 15:37:36.202561+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
361	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-13 08:52:59.110841+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
362	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-06-13 15:08:55.584052+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
363	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-06-13 15:09:53.117639+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
364	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-13 15:10:16.37654+00	\N
365	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-13 15:10:26.198508+00	\N
366	\N	Updated employee	Employee 15 updated successfully	\N	2025-06-13 15:10:42.665072+00	\N
367	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-13 15:13:51.842476+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
368	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-13 15:14:15.371642+00	\N
369	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-06-13 15:14:21.37083+00	\N
370	\N	Updated employee	Employee 17 updated successfully	\N	2025-06-13 15:14:29.319577+00	\N
371	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-06-13 15:14:47.66053+00	\N
372	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-06-13 15:14:52.312492+00	\N
373	\N	Updated employee	Employee 17 updated successfully	\N	2025-06-13 15:14:59.356996+00	\N
374	\N	Created user	User Abid created successfully	\N	2025-06-13 15:16:52.43973+00	\N
375	\N	Updated user	User nblalb updated successfully	\N	2025-06-13 15:17:15.124115+00	\N
376	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-13 16:01:21.703989+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
377	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-13 16:34:51.510519+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
378	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-14 16:15:52.342029+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
379	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-14 16:18:37.064895+00	\N
380	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-14 16:30:31.254662+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
381	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-14 17:02:17.505719+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
382	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-14 17:03:39.963072+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
383	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-17 07:30:34.027148+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
384	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-17 07:31:36.041373+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
385	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-17 07:33:01.125128+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
386	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-17 12:59:48.368268+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
387	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 13:04:15.850674+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
388	\N	Updated user	User Abid updated successfully	\N	2025-06-17 13:05:37.696105+00	\N
389	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:01:33.04601+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
390	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:03:46.216451+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
391	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:16:15.33489+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
392	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:36:36.700817+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
393	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:38:21.362339+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
394	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 14:51:05.890925+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
395	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 15:00:20.532761+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
396	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 19:50:23.965036+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
397	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 19:52:05.740428+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
399	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:04:08.555043+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
400	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:18:17.767375+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
401	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:21:52.45039+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
402	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:25:46.46205+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
403	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:41:57.025633+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
404	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:47:37.854727+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
405	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:52:03.420447+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
406	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 20:57:10.007984+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
407	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:01:26.807304+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
408	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:15:36.106589+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
409	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:20:02.24586+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
410	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:24:06.235833+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
411	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:25:34.385274+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
412	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:27:57.980795+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
413	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:30:23.935805+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
414	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:34:14.563672+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
415	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:37:06.50072+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
416	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:38:30.430401+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
417	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:40:10.235943+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
418	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:47:13.620061+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
419	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 21:50:17.98495+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
420	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:00:25.029687+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
421	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:02:55.056192+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
422	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:10:51.477571+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
423	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:16:14.980879+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
424	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:21:52.125937+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
425	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:22:52.266071+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
426	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-17 22:26:59.030244+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
427	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:27:56.890138+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
428	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:29:24.50615+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
429	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:33:19.646307+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
430	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:37:54.856093+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
431	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:41:01.254444+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
502	\N	Updated user	User angelinemoore updated successfully	\N	2025-06-19 12:31:24.7703+00	\N
432	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 14:48:05.412896+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
433	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:22:25.535487+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
434	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:28:57.533841+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
435	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:33:26.844974+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
436	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:35:03.087757+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
437	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:40:38.813752+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
438	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:54:19.562159+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
439	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 15:56:47.397806+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
440	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:01:44.904597+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
441	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:04:54.503703+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
442	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:08:16.203928+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
443	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:13:41.676843+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
444	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:35:01.63475+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
445	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:38:01.495471+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
446	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:42:29.552121+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
447	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:49:51.884585+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
448	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 16:52:33.525638+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
449	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:03:08.616556+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
450	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:09:30.204605+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
451	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:13:58.801867+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
452	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:15:50.050819+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
453	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:30:59.478266+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
454	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 17:56:17.724942+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
455	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:00:28.450951+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
456	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:03:49.689016+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
457	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:07:15.987018+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
458	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:11:12.780767+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
459	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:12:53.776176+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
460	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:20:55.59119+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
461	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:22:34.956291+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
462	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:30:52.120263+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
463	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:45:37.785648+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
464	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 18:50:09.721037+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
465	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:15:03.916428+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
466	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:16:27.167116+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
467	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:18:36.777805+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
468	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:29:50.656135+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
469	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:34:58.870868+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
470	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:35:31.693853+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
471	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:40:13.566064+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
472	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:44:20.146003+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
473	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:47:31.271026+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
474	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 19:52:58.11273+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
475	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 20:02:52.870095+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
476	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 20:09:47.003455+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
477	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 20:10:33.850671+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
478	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 20:19:46.021212+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
479	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-18 20:25:14.761245+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
480	28	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:04:26.990793+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
481	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:10:22.751213+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
482	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:13:42.840945+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
483	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:48:30.001327+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
484	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:26:22.84112+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
485	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:44:20.85543+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
486	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:55:12.015786+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
487	28	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:01:39.180609+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
488	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:02:50.110484+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
489	28	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:06:12.776083+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
490	28	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:12:14.056188+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
491	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:16:18.525766+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
492	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:17:12.516571+00	\N
496	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:23:58.111155+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
497	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:24:56.01575+00	\N
498	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:25:16.375341+00	\N
501	\N	Deleted user	User 14 deleted successfully	\N	2025-06-19 12:30:38.974114+00	\N
500	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:29:54.125529+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
493	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:18:08.215673+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
494	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:19:05.420724+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
495	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:21:37.435756+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
499	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:26:27.721551+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
503	27	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:32:02.886185+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
504	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:48:01.106258+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
505	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:48:44.236317+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
506	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 13:07:39.330503+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
507	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 13:23:07.791818+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
508	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 14:03:24.870955+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
509	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 14:46:39.166155+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
510	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 15:07:30.490765+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
511	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-20 12:27:26.460165+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
512	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:31:15.967462+00	\N
513	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:31:58.366718+00	\N
514	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:32:12.195911+00	\N
515	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:33:35.712571+00	\N
516	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:34:47.982393+00	\N
517	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:35:56.612171+00	\N
518	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:36:19.942735+00	\N
519	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-06-20 12:36:51.370675+00	\N
520	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-20 12:56:24.933847+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
522	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-20 13:06:03.152444+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
523	\N	Added employee	Employee a a added successfully	\N	2025-06-20 13:06:46.555149+00	\N
524	\N	Deleted employee	Employee 18 deleted successfully	\N	2025-06-20 13:06:49.89013+00	\N
525	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-20 13:12:05.388271+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
526	\N	Added employee	Employee binti nurhayati added successfully	\N	2025-06-20 13:12:27.61463+00	\N
527	\N	Created user	User mama created successfully	\N	2025-06-20 13:15:13.579932+00	\N
529	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-20 13:30:45.336694+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
530	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 04:35:18.61437+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
531	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 04:47:43.484244+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
532	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 04:49:02.332893+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
533	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 05:08:51.946519+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
528	\N	Login	User bintinurhayati041@gmail.com logged in successfully	127.0.0.1	2025-06-20 13:17:01.386405+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
534	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 05:11:09.247026+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
535	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-21 05:15:19.654205+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
536	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-21 10:03:39.62391+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
537	\N	Updated user	User angelinemoore updated successfully	\N	2025-06-21 10:28:54.786581+00	\N
538	\N	Updated user	User angelinemoore updated successfully	\N	2025-06-21 10:28:55.424381+00	\N
539	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-21 10:29:29.825784+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
540	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-06-21 11:13:04.376731+00	\N
541	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-21 13:20:14.486186+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
542	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-06-21 13:20:21.692559+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
543	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-21 13:26:55.332868+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
544	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-06-21 13:28:34.097403+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
545	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 19:04:21.352048+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
546	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-06-21 19:05:39.404714+00	\N
547	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-06-21 19:05:54.600724+00	\N
548	\N	Viewed employee profile	Viewed profile of employee ID 14	\N	2025-06-21 19:06:02.156321+00	\N
549	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 19:27:31.312267+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
550	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 19:30:08.480992+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
551	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 19:56:38.664659+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
552	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 19:57:39.115002+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
553	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:02:29.294514+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
554	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:15:02.21378+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
555	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:18:39.191806+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
556	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:26:07.593772+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
557	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:28:01.711934+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
558	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:28:45.116473+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
559	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:57:19.851555+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
560	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 20:58:11.181967+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
561	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:17:59.704983+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
562	\N	Deleted user	User 29 deleted successfully	\N	2025-06-21 21:18:45.931292+00	\N
563	\N	Deleted employee	Employee 19 deleted successfully	\N	2025-06-21 21:18:57.323343+00	\N
564	\N	Added employee	Employee do kyungso added successfully	\N	2025-06-21 21:32:58.658185+00	\N
565	\N	Created user	User Kyungsoo created successfully	\N	2025-06-21 21:33:59.960088+00	\N
566	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:38:02.871921+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
567	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:39:24.70232+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
568	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:40:39.846254+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
569	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:47:38.531995+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
570	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-23 12:53:13.821291+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
571	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-06-23 13:02:58.623299+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
572	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-29 13:25:32.367194+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
573	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-29 13:57:40.26314+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
574	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-29 14:28:53.235375+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
575	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-06-29 15:05:25.03826+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
576	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-02 03:27:35.849883+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
577	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-04 13:31:04.606189+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
578	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-04 13:37:30.378191+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
579	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-04 14:45:24.100299+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
580	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-04 15:16:15.923406+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
581	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-04 15:25:41.234943+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
582	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-06 10:11:26.349016+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
583	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 19:05:43.661901+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
584	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 19:19:12.958881+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
585	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 19:24:46.373905+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
586	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 19:29:48.38012+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
587	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 19:59:37.169548+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
588	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 20:03:14.140001+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
589	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 20:25:51.070556+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
590	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 20:47:05.714973+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
591	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 20:49:11.308371+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
592	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 20:51:36.3701+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
593	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-06 20:55:34.644097+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
594	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-06 21:00:52.043476+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
595	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-06 21:02:11.255422+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
596	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 21:05:25.329908+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
597	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 21:12:31.626381+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
598	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 21:16:14.110591+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
599	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 21:18:21.225095+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
600	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 21:31:27.368837+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
601	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	\N	2025-07-06 21:35:53.835211+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
602	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 22:04:27.139917+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
704	30	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-18 14:13:03.474922+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
705	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:14:05.508465+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
607	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-06 22:07:54.531975+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
608	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-07 05:46:13.879208+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
609	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-07 07:39:59.537884+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
610	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-10 07:52:37.629768+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
611	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 08:05:07.114582+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
612	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-10 08:10:30.040052+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
613	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-10 08:48:18.704+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
614	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-10 12:52:03.645235+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
615	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-10 12:58:17.689907+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
616	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:08:22.006034+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
617	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:15:56.400651+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
618	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:18:33.024985+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
619	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:38:13.392637+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
620	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:38:50.891194+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
621	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-10 13:51:56.878287+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
622	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 14:25:19.263184+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
623	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 14:34:09.930395+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
624	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 15:31:37.192399+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
625	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 16:28:22.420865+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
626	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 16:33:42.94426+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
627	\N	Updated employee	Employee 1 updated successfully	127.0.0.1	2025-07-10 16:39:57.676314+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
628	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-10 16:42:23.794008+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
629	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-10 16:51:14.073242+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
630	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 16:58:16.642149+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
631	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 17:11:18.855593+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
632	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 17:27:10.683105+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
633	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 17:41:44.945983+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
634	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 17:45:15.110737+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
635	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 17:46:59.981082+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
636	\N	Updated employee	Employee 4 updated successfully	127.0.0.1	2025-07-10 17:47:14.256508+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
637	1	Updated user	User nblalbb updated successfully	127.0.0.1	2025-07-10 17:51:41.890376+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
638	1	Updated user	User nblalbb updated successfully	127.0.0.1	2025-07-10 17:57:27.168635+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
639	1	Updated user	User nblalbb updated successfully	127.0.0.1	2025-07-10 17:57:53.756721+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
640	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 18:06:54.479515+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
641	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 18:22:33.830445+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
642	4	Updated employee	Employee Nabila updated by SuperadminNab	127.0.0.1	2025-07-10 18:34:49.614663+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
643	4	Updated employee	Employee Nabilaa1 updated by SuperadminNab	127.0.0.1	2025-07-10 18:36:09.851726+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
644	4	Updated employee	Employee Nabilaa updated by SuperadminNab	127.0.0.1	2025-07-10 18:36:39.138481+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
645	4	Updated employee	Employee Nabila updated by SuperadminNab	127.0.0.1	2025-07-10 18:44:15.938199+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
646	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 18:50:54.504908+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
647	4	Update employee failed	'User' object has no attribute 'first_name'	127.0.0.1	2025-07-10 18:51:12.305755+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
648	4	Updated employee	Employee juminten updated by SuperadminNab	127.0.0.1	2025-07-10 18:53:03.837777+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
649	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 19:10:48.002035+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
650	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-10 19:18:11.962175+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
651	17	Updated employee	Employee Maureenn updated by admin_nabila	127.0.0.1	2025-07-10 19:20:31.205023+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
652	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 19:21:06.828261+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
653	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 19:45:37.003333+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
654	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 17	127.0.0.1	2025-07-10 19:49:51.52431+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
655	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 4	127.0.0.1	2025-07-10 19:50:12.763105+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
656	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-10 19:53:51.097159+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
657	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 19:54:11.044018+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
658	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 19:55:26.673797+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
659	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 19:57:32.695952+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
660	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 4	127.0.0.1	2025-07-10 20:02:22.775924+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
661	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 20:03:17.248725+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
662	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 20:17:15.129616+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
663	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 20:19:20.607313+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
664	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-10 20:19:26.383978+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
665	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 5	127.0.0.1	2025-07-10 20:19:33.063089+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
666	4	Updated employee	Employee Maureen updated by SuperadminNab	127.0.0.1	2025-07-10 20:19:39.112262+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
667	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 06:07:53.286426+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
668	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 15	127.0.0.1	2025-07-11 06:09:03.436762+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
669	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:37:49.359981+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
670	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 06:41:51.026129+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
671	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 21	127.0.0.1	2025-07-11 06:42:12.236056+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
672	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 21	127.0.0.1	2025-07-11 06:42:15.251506+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
673	30	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-11 06:43:01.972816+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
674	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:44:39.701599+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
675	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 06:50:24.321254+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
676	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 06:51:58.841667+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
677	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:52:39.60815+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
678	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:55:39.306248+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
679	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 06:56:24.824737+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
680	3	Added employee	Employee Udin Petot added by HR	127.0.0.1	2025-07-11 06:57:13.59214+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
681	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:57:44.715649+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
682	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 07:01:31.862296+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
683	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-11 07:02:35.080113+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
684	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-11 07:03:06.700696+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
685	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-11 07:03:07.335776+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
686	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-11 07:03:43.688957+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
687	31	Updated user	User NIS updated successfully	127.0.0.1	2025-07-11 07:09:43.097152+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
688	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-11 07:12:25.518678+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
689	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 07:15:25.045223+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
690	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 14	127.0.0.1	2025-07-11 07:18:15.920335+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
691	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 22	127.0.0.1	2025-07-11 07:18:20.328128+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
692	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 3	127.0.0.1	2025-07-11 07:18:24.530988+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
693	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 17	127.0.0.1	2025-07-11 07:18:27.65336+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
694	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 2	127.0.0.1	2025-07-11 07:18:34.985059+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
695	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-11 10:15:43.234269+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
696	17	Viewed employee profile	admin_nabila viewed profile of employee ID 15	127.0.0.1	2025-07-11 10:17:16.653266+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
697	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 12:54:42.174985+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
698	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-11 12:55:31.280775+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
699	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-11 13:04:02.735313+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
700	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-11 13:46:15.328965+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
701	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-15 11:41:03.951225+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
702	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:03:25.166938+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
703	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:11:13.025527+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
706	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:32:26.09429+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
707	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:35:53.922186+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
708	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:44:35.367542+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
709	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:49:29.113503+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
711	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:54:55.526703+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
712	30	Viewed employee profile	Kyungsoo viewed profile of employee ID 4	127.0.0.1	2025-07-18 15:01:54.965034+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
710	30	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-18 14:54:26.437026+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
713	30	Viewed employee profile	Kyungsoo viewed profile of employee ID 15	127.0.0.1	2025-07-18 15:05:41.22371+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
714	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 15:25:57.689912+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
715	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 11:57:56.919715+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
716	30	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-20 11:58:23.818771+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
717	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 11:58:58.726554+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
718	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 12:30:57.093004+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
719	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-20 13:05:55.645144+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
720	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:29:57.54619+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
721	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:48:12.877297+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
722	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:55:59.194282+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
723	30	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:57:34.060619+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
724	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-23 18:02:00.973452+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
725	4	Added employee	Employee Bilee Libasutaqwa added by SuperadminNab	127.0.0.1	2025-07-23 18:02:30.266698+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.alembic_version (version_num) FROM stdin;
7cc42934dbcd
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.attendance (attendance_id, employee_id, attendance_date, late, attendance_status, clock_in, clock_in_latitude, clock_in_longitude, clock_in_verified, clock_in_reason, clock_in_distance, clock_out, clock_out_latitude, clock_out_longitude, clock_out_verified, clock_out_reason, clock_out_distance, face_verified, working_hour, overtime) FROM stdin;
1	12	2025-05-26	1200	Punch Out	08:20:00	-6.490243	106.833958	f	Overslept	0.5123	17:00:00	-6.473288657065961	106.85135874708021	t	\N	0.4152	t	31200	900
44	16	2025-06-09	0	Punch Out	07:50:00	-6.473288657065961	106.85135874708021	t	\N	0.45	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.47	t	32100	0
55	12	2025-06-12	0	Punch Out	08:00:00	-6.473536	106.851962	t	\N	0.46	17:00:00	-6.473536	106.851962	t	\N	0.47	t	32400	900
56	16	2025-06-12	0	Punch Out	07:55:00	-6.473536	106.851962	t	\N	0.465	16:50:00	-6.473536	106.851962	t	\N	0.475	t	32100	300
58	12	2025-06-13	55620	Punch Out	23:27:19.033604	-6.4733157	106.851401	t		0.4800718470570105	23:30:22.649454	-6.4732795	106.8513833	t		0.5021939094215163	t	180	24300
2	5	2025-05-26	0	Punch Out	07:50:00	-6.473288657065961	106.85135874708021	t	\N	0.4235	16:35:00	-6.47928	106.844498	f	Clock out button did not register	0.5821	t	31500	0
3	1	2025-05-26	0	Punch Out	07:55:00	-6.473288657065961	106.85135874708021	t	\N	0.3924	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.5789	t	31800	0
4	16	2025-05-26	600	Punch Out	08:10:00	-6.473288657065961	106.85135874708021	t	\N	0.5332	17:10:00	-6.473288657065961	106.85135874708021	t	\N	0.4177	t	32400	1500
5	5	2025-05-27	0	Punch Out	08:00:00	-6.47184	106.853081	t	\N	0.4841	17:05:00	-6.473288657065961	106.85135874708021	t	\N	0.5199	t	32700	1200
6	16	2025-05-27	1800	Punch Out	08:30:00	-6.43597	106.852912	f	Traffic jam	0.3563	17:15:00	-6.473288657065961	106.85135874708021	t	\N	0.5532	t	31500	1800
7	1	2025-05-27	300	Punch Out	08:05:00	-6.47184	106.853081	t	\N	0.5912	16:55:00	-6.473288657065961	106.85135874708021	t	\N	0.5532	t	31800	600
8	12	2025-05-27	0	Punch Out	07:50:00	-6.47184	106.853081	t	\N	0.5251	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.4422	t	32100	0
9	1	2025-05-28	900	Punch Out	08:15:00	-6.46727	106.877975	f	Missed the bus	0.4991	17:25:00	-6.473288657065961	106.85135874708021	t	\N	0.5843	t	31800	2400
10	12	2025-05-28	0	Punch Out	07:55:00	-6.473536	106.851962	t	\N	0.3542	16:40:00	-6.47928	106.844498	f	Clock out button did not register	0.5123	t	31500	0
11	5	2025-05-28	300	Punch Out	08:05:00	-6.473536	106.851962	t	\N	0.5199	17:10:00	-6.473536	106.851962	t	\N	0.5888	t	32700	1500
12	16	2025-05-28	0	Punch Out	07:50:00	-6.473536	106.851962	t	\N	0.4789	16:45:00	-6.473536	106.851962	t	\N	0.5772	t	32100	0
17	12	2025-05-30	1200	Punch Out	08:20:00	-6.47184	106.853081	t	\N	0.4841	17:05:00	-6.473288657065961	106.85135874708021	t	\N	0.5199	t	32700	1200
18	5	2025-05-30	0	Punch Out	07:50:00	-6.473288657065961	106.85135874708021	t	\N	0.4235	16:35:00	-6.47928	106.844498	f	Clock out button did not register	0.5821	t	31500	0
19	1	2025-05-30	0	Punch Out	07:55:00	-6.473288657065961	106.85135874708021	t	\N	0.3924	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.5789	t	31800	0
20	16	2025-05-30	600	Punch Out	08:10:00	-6.473288657065961	106.85135874708021	t	\N	0.5332	17:10:00	-6.473288657065961	106.85135874708021	t	\N	0.4177	t	32400	1500
21	1	2025-06-02	900	Punch Out	08:15:00	-6.46727	106.877975	f	Missed the bus	0.4991	17:25:00	-6.473288657065961	106.85135874708021	t	\N	0.5843	t	31800	2400
22	12	2025-06-02	0	Punch Out	07:55:00	-6.473536	106.851962	t	\N	0.3542	16:40:00	-6.47928	106.844498	f	Clock out button did not register	0.5123	t	31500	0
23	5	2025-06-02	300	Punch Out	08:05:00	-6.473536	106.851962	t	\N	0.5199	17:10:00	-6.473536	106.851962	t	\N	0.5888	t	32700	1500
24	16	2025-06-02	0	Punch Out	07:50:00	-6.473536	106.851962	t	\N	0.4789	16:45:00	-6.473536	106.851962	t	\N	0.5772	t	32100	0
25	5	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
26	12	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
27	1	2025-06-03	0	Punch Out	07:55:00	-6.473288657065961	106.85135874708021	t	\N	0.3924	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.5789	t	31800	0
28	16	2025-06-03	600	Punch Out	08:10:00	-6.473288657065961	106.85135874708021	t	\N	0.5332	17:10:00	-6.473288657065961	106.85135874708021	t	\N	0.4177	t	32400	1500
29	5	2025-06-04	0	Punch Out	08:00:00	-6.47184	106.853081	t	\N	0.4841	17:05:00	-6.473288657065961	106.85135874708021	t	\N	0.5199	t	32700	1200
30	16	2025-06-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
31	1	2025-06-04	300	Punch Out	08:05:00	-6.47184	106.853081	t	\N	0.5912	16:55:00	-6.473288657065961	106.85135874708021	t	\N	0.5532	t	31800	600
32	12	2025-06-04	0	Punch Out	07:50:00	-6.47184	106.853081	t	\N	0.5251	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.4422	t	32100	0
34	5	2025-06-05	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
40	16	2025-06-06	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
47	12	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
53	1	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
33	1	2025-06-05	0	Punch Out	08:00:00	-6.473288657065961	106.85135874708021	t	\N	0.4123	16:45:00	-6.473288657065961	106.85135874708021	t	\N	0.4789	t	31500	0
35	12	2025-06-05	600	Punch Out	08:10:00	-6.47184	106.853081	t	\N	0.4998	17:00:00	-6.473288657065961	106.85135874708021	t	\N	0.5122	t	31800	900
36	16	2025-06-05	300	Punch Out	08:05:00	-6.473536	106.851962	t	\N	0.4981	17:10:00	-6.473536	106.851962	t	\N	0.5231	t	32100	1200
37	1	2025-06-06	0	Punch Out	07:55:00	-6.473536	106.851962	t	\N	0.4152	16:50:00	-6.473536	106.851962	t	\N	0.495	t	32100	300
38	5	2025-06-06	0	Punch Out	08:00:00	-6.47184	106.853081	t	\N	0.4771	17:00:00	-6.47184	106.853081	t	\N	0.49	t	32400	900
39	12	2025-06-06	0	Punch Out	07:50:00	-6.47184	106.853081	t	\N	0.42	16:40:00	-6.47184	106.853081	t	\N	0.435	t	31800	0
59	12	2025-06-14	56160	Punch Out	23:35:37.227306	-6.4778661	106.8495619	t	testing	0.4995754217895619	23:35:50.930522	-6.4778661	106.8495619	t	testing	0.4844543984331193	t	0	24660
41	1	2025-06-09	600	Punch Out	08:10:00	-6.46727	106.877975	f	Late train	0.482	17:20:00	-6.473288657065961	106.85135874708021	t	\N	0.51	t	31800	1800
42	5	2025-06-09	0	Punch Out	08:00:00	-6.47184	106.853081	t	\N	0.4702	17:05:00	-6.473288657065961	106.85135874708021	t	\N	0.515	t	32700	1200
43	12	2025-06-09	0	Punch Out	07:55:00	-6.473288657065961	106.85135874708021	t	\N	0.438	16:50:00	-6.473288657065961	106.85135874708021	t	\N	0.4881	t	32100	300
45	1	2025-06-10	300	Punch Out	08:05:00	-6.47184	106.853081	t	\N	0.4101	16:55:00	-6.473288657065961	106.85135874708021	t	\N	0.4803	t	31800	600
46	5	2025-06-10	0	Punch Out	08:00:00	-6.473536	106.851962	t	\N	0.45	17:00:00	-6.473536	106.851962	t	\N	0.5	t	32400	900
48	16	2025-06-10	0	Punch Out	07:50:00	-6.473536	106.851962	t	\N	0.46	16:45:00	-6.473536	106.851962	t	\N	0.485	t	32100	0
49	1	2025-06-11	0	Punch Out	08:00:00	-6.473288657065961	106.85135874708021	t	\N	0.4702	17:00:00	-6.473288657065961	106.85135874708021	t	\N	0.485	t	32400	900
50	5	2025-06-11	0	Punch Out	08:00:00	-6.47184	106.853081	t	\N	0.4602	17:00:00	-6.47184	106.853081	t	\N	0.472	t	32400	900
51	12	2025-06-11	0	Punch Out	07:55:00	-6.47184	106.853081	t	\N	0.4521	16:50:00	-6.47184	106.853081	t	\N	0.46	t	32100	300
52	16	2025-06-11	300	Punch Out	08:05:00	-6.47184	106.853081	t	\N	0.48	17:05:00	-6.47184	106.853081	t	\N	0.492	t	32400	1200
54	5	2025-06-12	600	Punch Out	08:10:00	-6.473536	106.851962	t	\N	0.47	17:20:00	-6.473536	106.851962	t	\N	0.5001	t	33000	1800
67	\N	2025-06-20	44263	Punch Out	20:17:43.664553	-0.5281930814609369	101.56439129433298	t	KEPO	0.3946596710527004	20:18:27.995699	-0.5281930814609369	101.56439129433298	t	HMM	0.39066993565664276	t	44	12807
65	12	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
66	12	2025-06-17	49410	Punch Out	21:43:30.641242	-6.4790485	106.8466116	t	test	0.5618370114987319	21:44:05.356321	-6.4790485	106.8466116	t	testing	0.46418344244657966	t	34	17945
68	12	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
69	12	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
70	12	2025-06-20	46511	Punch Out	20:55:11.58232	-6.473291	106.8513825	t		0.477972025254232	20:55:34.631764	-6.4733582	106.851444	t		0.5284248705519706	t	23	15034
71	12	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
72	12	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
73	12	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
74	12	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
75	12	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
76	12	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
77	2	2025-05-22	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
78	2	2025-05-23	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
79	2	2025-05-24	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
80	2	2025-05-25	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
81	2	2025-05-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
82	2	2025-05-27	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
83	2	2025-05-28	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
84	2	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
85	2	2025-05-30	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
86	2	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
87	2	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
88	2	2025-06-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
89	2	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
90	2	2025-06-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
91	2	2025-06-05	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
92	2	2025-06-06	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
93	2	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
94	2	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
95	2	2025-06-09	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
96	2	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
97	2	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
98	2	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
99	2	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
100	2	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
101	2	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
102	2	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
103	2	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
104	2	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
105	2	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
106	2	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
107	3	2025-05-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
108	3	2025-05-24	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
109	3	2025-05-25	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
110	3	2025-05-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
111	3	2025-05-27	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
112	3	2025-05-28	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
113	3	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
114	3	2025-05-30	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
115	3	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
116	3	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
117	3	2025-06-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
118	3	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
119	3	2025-06-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
120	3	2025-06-05	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
121	3	2025-06-06	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
122	3	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
123	3	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
124	3	2025-06-09	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
125	3	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
126	3	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
127	3	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
128	3	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
129	3	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
130	3	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
131	3	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
132	3	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
133	3	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
134	3	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
135	3	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
136	3	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
137	20	2025-05-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
138	20	2025-05-24	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
139	20	2025-05-25	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
140	20	2025-05-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
141	20	2025-05-27	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
142	20	2025-05-28	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
143	20	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
144	20	2025-05-30	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
145	20	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
146	20	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
147	20	2025-06-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
148	20	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
149	20	2025-06-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
150	20	2025-06-05	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
151	20	2025-06-06	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
152	20	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
153	20	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
154	20	2025-06-09	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
155	20	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
156	20	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
157	20	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
158	20	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
159	20	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
160	20	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
161	20	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
162	20	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
163	20	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
164	20	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
165	20	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
166	20	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
167	4	2025-05-24	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
168	4	2025-05-25	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
169	4	2025-05-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
170	4	2025-05-27	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
171	4	2025-05-28	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
172	4	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
173	4	2025-05-30	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
174	4	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
175	4	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
176	4	2025-06-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
177	4	2025-06-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
178	4	2025-06-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
179	4	2025-06-05	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
180	4	2025-06-06	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
181	4	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
182	4	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
183	4	2025-06-09	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
184	4	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
185	4	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
186	4	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
187	4	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
188	4	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
189	4	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
190	4	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
191	4	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
192	4	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
193	4	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
194	4	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
195	4	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
196	4	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
197	12	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
198	12	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
199	12	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
200	12	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
201	12	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
202	12	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
203	12	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
204	12	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
207	12	2025-06-29	50784	Punch Out	22:06:24.262432	-6.4732903	106.851387	t		0.5288155923058133	22:06:47.38876	-6.4732903	106.851387	t		0.49113233642629206	t	23	19307
208	12	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
209	12	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
210	12	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
211	12	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
212	2	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
213	2	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
214	2	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
215	2	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
216	2	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
217	2	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
218	2	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
219	2	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
220	2	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
221	2	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
222	2	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
223	2	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
224	2	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
225	12	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
226	12	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
227	4	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
228	4	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
229	4	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
230	4	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
231	4	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
232	4	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
233	4	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
234	4	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
235	4	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
236	4	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
237	4	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
238	4	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
239	4	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
240	4	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
241	11	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
242	11	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
243	11	2025-06-09	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
244	11	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
245	11	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
246	11	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
247	11	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
248	11	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
249	11	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
250	11	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
251	11	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
252	11	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
253	11	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
254	11	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
255	11	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
256	11	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
257	11	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
258	11	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
259	11	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
260	11	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
261	11	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
262	11	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
263	11	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
264	11	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
265	11	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
266	11	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
267	11	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
268	11	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
269	11	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
270	11	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
271	3	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
272	3	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
273	3	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
274	3	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
275	3	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
276	3	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
277	3	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
278	3	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
279	3	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
280	3	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
281	3	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
282	3	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
283	3	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
284	3	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
285	3	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
286	3	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
287	3	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
288	3	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
289	4	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
290	4	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
291	4	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
292	11	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
293	11	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
294	11	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
295	15	2025-07-10	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
296	15	2025-07-11	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
297	15	2025-07-12	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
298	12	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
299	12	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
300	12	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
301	12	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
303	2	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
304	2	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
305	2	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
306	2	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
307	2	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
308	2	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
309	17	2025-06-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
310	17	2025-06-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
311	17	2025-06-12	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
312	17	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
313	17	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
314	17	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
315	17	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
316	17	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
317	17	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
318	17	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
319	17	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
320	17	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
321	17	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
322	17	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
323	17	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
324	17	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
325	17	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
326	17	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
327	17	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
328	17	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
329	17	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
330	17	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
331	17	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
332	17	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
333	17	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
334	17	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
335	17	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
336	17	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
337	17	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
338	17	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
302	12	2025-07-10	42878	Punch Out	19:54:38.998205	-6.4733359	106.8514375	t		0.483025884341968	20:18:59.178084	-6.4733767	106.8514629	t		0.5578173385383797	t	1460	12839
339	1	2025-05-29	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
340	1	2025-05-31	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
341	1	2025-06-01	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
342	1	2025-06-07	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
343	1	2025-06-08	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
344	1	2025-06-13	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
345	1	2025-06-14	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
346	1	2025-06-15	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
347	1	2025-06-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
348	1	2025-06-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
349	1	2025-06-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
350	1	2025-06-19	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
351	1	2025-06-20	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
352	1	2025-06-21	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
353	1	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
354	1	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
355	1	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
356	1	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
357	1	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
358	1	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
359	1	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
360	1	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
361	1	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
362	1	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
363	1	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
364	1	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
365	1	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
366	1	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
367	1	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
368	1	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
369	1	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
370	1	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
371	4	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
372	11	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
373	3	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
374	20	2025-06-22	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
375	20	2025-06-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
376	20	2025-06-24	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
377	20	2025-06-25	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
378	20	2025-06-26	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
379	20	2025-06-27	0	Holiday	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
380	20	2025-06-28	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
381	20	2025-06-29	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
382	20	2025-06-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
383	20	2025-07-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
384	20	2025-07-02	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
385	20	2025-07-03	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
386	20	2025-07-04	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
387	20	2025-07-05	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
388	20	2025-07-06	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
389	20	2025-07-07	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
390	20	2025-07-08	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
391	20	2025-07-09	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
392	20	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
393	1	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
394	2	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
395	17	2025-07-10	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
396	12	2025-07-11	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
397	12	2025-07-12	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
398	12	2025-07-13	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
399	12	2025-07-14	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
400	12	2025-07-15	38553	Punch Out	18:42:33.855555	-6.4791989	106.8480867	t	work from home	0.42499526040010926	18:49:14.313584	-6.4791989	106.8480867	t	work from home	0.4154049543629387	t	400	7454
401	3	2025-07-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
402	3	2025-07-12	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
403	3	2025-07-13	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
404	3	2025-07-14	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
405	3	2025-07-15	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
406	3	2025-07-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
407	3	2025-07-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
408	20	2025-07-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
409	20	2025-07-12	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
410	20	2025-07-13	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
411	20	2025-07-14	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
412	20	2025-07-15	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
413	20	2025-07-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
414	20	2025-07-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
415	12	2025-07-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
416	12	2025-07-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
417	12	2025-07-18	49924	Punch Out	21:52:04.743058	-6.4733672	106.8514821	t		0.49131542653630916	21:53:19.739512	-6.4733672	106.8514821	t		0.3974379463725653	t	74	18499
418	1	2025-07-14	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
419	1	2025-07-15	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
420	1	2025-07-14	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
421	20	2025-07-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
422	20	2025-07-19	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
423	12	2025-07-19	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
424	1	2025-07-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
425	1	2025-07-12	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
426	1	2025-07-13	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
427	1	2025-07-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
428	1	2025-07-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
429	1	2025-07-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
430	1	2025-07-19	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
431	1	2025-07-20	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
432	1	2025-07-21	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
433	1	2025-07-22	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
434	1	2025-07-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
435	3	2025-07-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
436	3	2025-07-19	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
437	3	2025-07-20	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
438	3	2025-07-21	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
439	3	2025-07-22	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
440	3	2025-07-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
441	20	2025-07-20	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
442	20	2025-07-21	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
443	20	2025-07-22	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
444	20	2025-07-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
445	1	2025-07-24	0	Punch In	00:58:02.586468	-6.238412870424949	106.75229415601972	t	meeting	0.31370346046270847	\N	\N	\N	f	\N	\N	t	\N	\N
446	4	2025-07-11	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
447	4	2025-07-12	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
448	4	2025-07-13	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
449	4	2025-07-14	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
450	4	2025-07-15	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
451	4	2025-07-16	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
452	4	2025-07-17	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
453	4	2025-07-18	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
454	4	2025-07-19	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
455	4	2025-07-20	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
456	4	2025-07-21	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
457	4	2025-07-22	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
458	4	2025-07-23	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.employees (employee_id, first_name, last_name, nrp_id, email, phone_number, "position", department, face_encoding) FROM stdin;
3	Anisa	Nirwana	133343224	nirwanaanisa1508@gmail.com	082214987219	Data Security	Cyber Security	[-0.10745113343000412, 0.06479183584451675, 0.03841818869113922, -0.07419481873512268, -0.09446264058351517, -0.03752533346414566, 0.0005902769044041634, -0.12211665511131287, 0.21591351926326752, -0.17293238639831543, 0.26916223764419556, -0.07804253697395325, -0.21133631467819214, -0.09860064089298248, 0.009385057725012302, 0.19761797785758972, -0.17414486408233643, -0.13627183437347412, -0.06367859244346619, 0.001685909926891327, 0.054232094436883926, -0.05612108111381531, 0.054845668375492096, 0.11643049865961075, -0.09619110822677612, -0.437546968460083, -0.09363581240177155, -0.052024345844984055, -0.06378484517335892, -0.042893484234809875, -0.07512733340263367, 0.1269986778497696, -0.2208126336336136, -0.1137506440281868, -0.05288901925086975, 0.1556069552898407, -0.06213591247797012, -0.06360242515802383, 0.1493958830833435, -0.035987090319395065, -0.25839105248451233, -0.05924650654196739, 0.043905291706323624, 0.23576849699020386, 0.13991595804691315, -0.017593640834093094, 0.028691517189145088, -0.0865224152803421, 0.07595359534025192, -0.2189370095729828, 0.03575323522090912, 0.112706758081913, 0.0446292869746685, 0.053642794489860535, 0.0026290896348655224, -0.11978019773960114, 0.006495899520814419, 0.14221717417240143, -0.13829924166202545, -0.05454059690237045, 0.0592513270676136, -0.10209975391626358, -0.05291147157549858, -0.11121028661727905, 0.24784503877162933, 0.18585355579853058, -0.078170046210289, -0.16279618442058563, 0.15717552602291107, -0.10458815097808838, -0.04208763316273689, 0.04490136355161667, -0.17050541937351227, -0.21318675577640533, -0.3112885057926178, 0.022013558074831963, 0.3361208736896515, 0.06767086684703827, -0.12074443697929382, 0.01670217327773571, -0.0897703692317009, -0.004880569409579039, 0.08870840072631836, 0.1477670669555664, 0.03332361578941345, 0.0742664635181427, -0.10334115475416183, 0.09656691551208496, 0.14913655817508698, -0.0733344778418541, -0.008518592454493046, 0.2307186722755432, -0.0033590374514460564, 0.05413768067955971, 0.041642606258392334, 0.056115809828042984, -0.06448857486248016, 0.11233486235141754, -0.22535854578018188, 0.06161462888121605, 0.05863276869058609, 0.0010617543011903763, -0.029182879254221916, 0.06716076284646988, -0.1392315775156021, 0.0819094106554985, 0.0209417212754488, 0.024644305929541588, 0.055981215089559555, -0.05498424544930458, -0.107485331594944, -0.13754069805145264, 0.11024875193834305, -0.21977248787879944, 0.11776702105998993, 0.17204159498214722, 0.029302291572093964, 0.17161093652248383, 0.07747355103492737, 0.09040781855583191, 0.008818788453936577, -0.08593098819255829, -0.27368438243865967, 0.0782378762960434, 0.15335705876350403, 0.0021260594949126244, -0.010376254096627235, 0.016320500522851944]
2	Yustina	Yunita	188856789	yustinayunita86@gmail.com	08987654321	Data Scientist	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
1	Nabilaa	Libasutaqwa	654323450	nabilalb2004@gmail.com	081234567890	Data Security	Cyber Security	[-0.11877931654453278, 0.048978134989738464, 0.04527463763952255, -0.053959839046001434, -0.11791834235191345, -0.04495662823319435, -0.02108035981655121, -0.12154902517795563, 0.14449924230575562, -0.13219228386878967, 0.2115778625011444, -0.059877026826143265, -0.2019445300102234, -0.055844079703092575, -0.031118731945753098, 0.23269718885421753, -0.22157025337219238, -0.15516698360443115, -0.06823483854532242, -0.011522598564624786, 0.0629851371049881, -0.039067551493644714, 0.08161631971597672, 0.037768762558698654, -0.1215372234582901, -0.34673014283180237, -0.07339158654212952, -0.04526490718126297, -0.05223672091960907, -0.0010802150936797261, -0.053868792951107025, 0.06410800665616989, -0.22088253498077393, -0.06292301416397095, 0.05741925910115242, 0.07921651005744934, -0.03555351868271828, -0.08645129948854446, 0.2093575894832611, -0.04646805673837662, -0.2735065817832947, 0.005639377981424332, 0.13623614609241486, 0.2107405811548233, 0.1236954852938652, 0.03615737706422806, 0.00791251566261053, -0.12571097910404205, 0.1281934380531311, -0.16802296042442322, 0.07628294825553894, 0.10171712189912796, 0.10188271850347519, 0.01609496958553791, 0.061359576880931854, -0.12568289041519165, 0.045133449137210846, 0.1394161432981491, -0.09774723649024963, -0.03284337744116783, 0.11771884560585022, -0.04846888780593872, -0.04083703085780144, -0.14710000157356262, 0.21173681318759918, 0.10060358047485352, -0.08506668359041214, -0.17493729293346405, 0.12550681829452515, -0.05969913303852081, -0.059123389422893524, 0.06671737879514694, -0.1499161422252655, -0.21463961899280548, -0.27530986070632935, -0.02323021925985813, 0.30915629863739014, 0.10314305871725082, -0.16695356369018555, 0.01426028087735176, 0.01552140899002552, 0.02114843763411045, 0.12716341018676758, 0.16630852222442627, -0.01382768526673317, 0.08116237819194794, -0.08654364943504333, 0.029460828751325607, 0.19440734386444092, -0.08323968201875687, -0.036607809364795685, 0.21330304443836212, 0.026845799759030342, 0.0015197917819023132, 0.00652182474732399, -0.011105605401098728, -0.06658308207988739, 0.07986483722925186, -0.22473746538162231, 0.011140072718262672, 0.05963897705078125, 0.03300333768129349, -0.028514988720417023, 0.07891437411308289, -0.13830700516700745, 0.01650134287774563, -0.02790762111544609, 0.004079924896359444, -0.016230043023824692, -0.030277667567133904, -0.11010953783988953, -0.0883723720908165, 0.044013429433107376, -0.21927028894424438, 0.13821639120578766, 0.16726413369178772, 0.016312438994646072, 0.11036698520183563, 0.10717912763357162, 0.06306461989879608, 0.0313158854842186, -0.008186950348317623, -0.23215122520923615, -0.008681267499923706, 0.18264751136302948, -0.01756097562611103, 0.09290212392807007, 0.009914634749293327]
4	Nabila	Libasutaqwa	567890098	nabila.libasutaqwa@student.president.ac.id	081223456333	UI Designer	Web Programming	\N
5	Maureen	Gabriella	677588643	maureengabriella1m@gmail.com	082214987219	Front End Developer	Web Programming	\N
12	Yustina	Yunitaa	654327654	yustinayunitayy@gmail.com	08987654234	Data Analyst	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
11	Nabilaaa	Libasutaqwa	543212323	nabilalb0109@gmail.com	081234567890	Full Stack Developer	Web Programming	\N
14	Nirwana	Anisa	232434456	aku@gmail.com	08221478627	IT Support	General Affair	[-0.08705262839794159, 0.028314677998423576, -0.02192343771457672, -0.10766909271478653, -0.0378359854221344, -0.0771767869591713, -0.012423904612660408, -0.10465358197689056, 0.20991367101669312, -0.12996770441532135, 0.2618424594402313, -0.09420463442802429, -0.16922058165073395, -0.13514386117458344, -0.023006854578852654, 0.2143956869840622, -0.21800462901592255, -0.14555948972702026, -0.07178234308958054, 0.019305124878883362, 0.0611899271607399, -0.022431794553995132, 0.09242147207260132, 0.11043264716863632, -0.12326689064502716, -0.452635794878006, -0.10606089234352112, -0.07770831882953644, -0.04612206667661667, -0.01406253781169653, -0.022774379700422287, 0.15566261112689972, -0.24659276008605957, -0.09170137345790863, 0.03443208336830139, 0.16285422444343567, -0.005589225795120001, -0.06087765097618103, 0.19783011078834534, 0.0338364839553833, -0.26129186153411865, -0.04324609786272049, 0.04748415946960449, 0.2872742712497711, 0.12920653820037842, 0.007613310124725103, 0.02499564178287983, -0.0844765305519104, 0.06059001758694649, -0.25167974829673767, 0.03028874099254608, 0.1258591115474701, 0.032361652702093124, 0.007122025825083256, -0.03239835426211357, -0.08833154290914536, 0.02946528047323227, 0.138524129986763, -0.1973840445280075, -0.02251201868057251, 0.07179447263479233, -0.1270015686750412, -0.10023333132266998, -0.11575260013341904, 0.24565406143665314, 0.1841726452112198, -0.11953563243150711, -0.17247894406318665, 0.18022409081459045, -0.1067696064710617, -0.020057566463947296, 0.03702744096517563, -0.15482297539710999, -0.23280133306980133, -0.2956756353378296, -0.0213584266602993, 0.35210227966308594, 0.0816737711429596, -0.12993137538433075, 0.061271414160728455, -0.11381693929433823, 0.012884706258773804, 0.07352393865585327, 0.1552637219429016, 0.0380743145942688, 0.1021994799375534, -0.09148217737674713, 0.10116030275821686, 0.18677978217601776, -0.08925523608922958, -0.010435952804982662, 0.2613350450992584, -0.04561629891395569, 0.07503945380449295, 0.0041400776244699955, 0.00238929595798254, -0.03760264813899994, 0.10474572330713272, -0.21155020594596863, 0.06214817240834236, 0.06774457544088364, 0.020565593615174294, -0.0022452964913100004, 0.07133220881223679, -0.15793690085411072, 0.07148707658052444, 0.02279788814485073, -0.015991784632205963, 0.08306196331977844, -0.041770532727241516, -0.10044970363378525, -0.1508372724056244, 0.11841989308595657, -0.22482070326805115, 0.160581573843956, 0.20859745144844055, 0.07659950852394104, 0.16944147646427155, 0.10935617238283157, 0.07057564705610275, 0.040968891233205795, -0.08640743792057037, -0.3014596402645111, 0.05896034464240074, 0.1225651353597641, 0.005609716754406691, 0.003914719447493553, -0.0031596901826560497]
15	Abid	Laqoo	224353431	abid@gmail.com	08221478627	IT Support	General Affair	[-0.12919948995113373, 0.06666329503059387, 0.03344258666038513, -0.08404503762722015, -0.09008660167455673, -0.08720318973064423, -0.08245470374822617, -0.10234399884939194, 0.19635172188282013, -0.13135431706905365, 0.2677384316921234, -0.03503573685884476, -0.22508522868156433, -0.112706758081913, 0.03417070209980011, 0.19653455913066864, -0.2162640392780304, -0.1515597701072693, -0.023327000439167023, -0.004968846682459116, 0.0376853384077549, -0.06514094024896622, 0.08146794140338898, 0.07976383715867996, -0.10406520962715149, -0.45721232891082764, -0.10016806423664093, -0.05235406011343002, -0.04149402678012848, 0.0054552191868424416, -0.05616782233119011, 0.07495284825563431, -0.2324349284172058, -0.07747253775596619, 0.020301751792430878, 0.16606225073337555, -0.049775440245866776, -0.08939759433269501, 0.17369958758354187, -0.07171580195426941, -0.29493245482444763, -0.05096827819943428, 0.05974216386675835, 0.1934920996427536, 0.14177370071411133, 0.010161984711885452, 0.01671195775270462, -0.09920952469110489, 0.06554976105690002, -0.25490570068359375, 0.036633457988500595, 0.16162243485450745, 0.025041649118065834, 0.01508278213441372, 0.005302885547280312, -0.10272610187530518, 0.03740565478801727, 0.1506415456533432, -0.18771055340766907, -0.10580013692378998, 0.06068480387330055, -0.10924514383077621, -0.06539610028266907, -0.12561345100402832, 0.27128615975379944, 0.20287086069583893, -0.13297437131404877, -0.1762954741716385, 0.11034033447504044, -0.15277713537216187, -0.027844959869980812, 0.10175003111362457, -0.12501384317874908, -0.24999354779720306, -0.3338157832622528, 0.001971479505300522, 0.31238502264022827, 0.10100376605987549, -0.12357345223426819, 0.03959168493747711, -0.0815640240907669, -0.009729903191328049, 0.08266538381576538, 0.15124954283237457, 0.011230261996388435, 0.08069176226854324, -0.127456396818161, 0.044604912400245667, 0.19823633134365082, -0.07718481868505478, 0.011964729987084866, 0.24694783985614777, 0.012285180389881134, 0.10370013117790222, 0.01042763702571392, 0.07744865864515305, -0.047568030655384064, 0.02586311846971512, -0.20861658453941345, 0.04415066912770271, 0.05919310450553894, 0.039091210812330246, -0.04661335423588753, 0.07595592737197876, -0.1582529991865158, 0.036706939339637756, 0.008120217360556126, -0.026307284832000732, 0.045081302523612976, -0.0751051977276802, -0.04946199804544449, -0.17545470595359802, 0.07931462675333023, -0.2665981352329254, 0.1397392749786377, 0.20680955052375793, 0.05093002691864967, 0.18016910552978516, 0.08233986049890518, 0.03672053664922714, -0.021599942818284035, -0.13274571299552917, -0.24900546669960022, 0.04211864247918129, 0.10715876519680023, -0.018366381525993347, 0.012663201428949833, -0.01600147783756256]
17	Angeline	Moore	123546565	angelinemoore.notsafe@gmail.com	0891827392387	Back End Developer	Web Programming	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
20	do	kyungso	678790873	anisa.nrwn15@gmail.com	08221478627	CEO	UCO	[-0.07937885820865631, 0.05433671176433563, 0.03426268696784973, -0.09492199122905731, -0.09727062284946442, -0.036458659917116165, -0.046943727880716324, -0.0999530479311943, 0.2459191530942917, -0.19544826447963715, 0.2481934130191803, -0.08305905014276505, -0.20827363431453705, -0.13952171802520752, 0.0027770940214395523, 0.24264900386333466, -0.19843804836273193, -0.1986384093761444, -0.035869892686605453, 0.02310420572757721, 0.06135400012135506, -0.05767902359366417, 0.0985165387392044, 0.08105117082595825, -0.16170412302017212, -0.49142715334892273, -0.09689102321863174, -0.014192553237080574, -0.07514133304357529, -0.03547562658786774, -0.04812657833099365, 0.16063404083251953, -0.23265336453914642, -0.07113718241453171, 0.004837433807551861, 0.1816360056400299, -0.04660087451338768, -0.09193529933691025, 0.1862126886844635, -0.015584178268909454, -0.29571565985679626, -0.06377722322940826, 0.061035096645355225, 0.23993565142154694, 0.12889344990253448, -0.04186832159757614, 0.04752567782998085, -0.06248937547206879, 0.05992567539215088, -0.2716343104839325, 0.019584426656365395, 0.13113339245319366, 0.048540979623794556, 0.03197329491376877, -0.001515088602900505, -0.1291104406118393, 0.03330612927675247, 0.16207493841648102, -0.18196041882038116, -0.03299921378493309, 0.055741071701049805, -0.1586737036705017, -0.050771426409482956, -0.1039036363363266, 0.21983732283115387, 0.18671779334545135, -0.0943789854645729, -0.2251175045967102, 0.1273590326309204, -0.1161305233836174, -0.007783310487866402, 0.04775603488087654, -0.15629243850708008, -0.2519349455833435, -0.348398357629776, -0.035064343363046646, 0.3308085501194, 0.1067114770412445, -0.10929177701473236, 0.06136798486113548, -0.05713982507586479, -0.0060956720262765884, 0.024077972397208214, 0.15949806571006775, 0.016339590772986412, 0.10298486799001694, -0.13263173401355743, 0.10088010877370834, 0.18041719496250153, -0.08748679608106613, -0.021388821303844452, 0.24159637093544006, -0.022491291165351868, 0.08832745254039764, 0.003957570996135473, 0.013675995171070099, -0.07353216409683228, 0.12121402472257614, -0.20393458008766174, 0.08162958920001984, 0.006209724582731724, -0.017128679901361465, -0.012366274371743202, 0.05755702406167984, -0.15064206719398499, 0.09083399176597595, -0.005402958951890469, -0.009643392637372017, 0.016355596482753754, -0.019140245392918587, -0.1286143809556961, -0.13935256004333496, 0.1001749038696289, -0.24811193346977234, 0.12372562289237976, 0.23557546734809875, 0.09785636514425278, 0.2127576470375061, 0.13179871439933777, 0.07015064358711243, 0.03978126868605614, -0.06295114010572433, -0.2414284497499466, 0.06256103515625, 0.08457519859075546, -0.01768987812101841, 0.02013232931494713, 0.04308174550533295]
16	juminten	lasmi12	656575535	juminten@gmail.com	08221478627	Web Design	Web Programming	[-0.12919948995113373, 0.06666329503059387, 0.03344258666038513, -0.08404503762722015, -0.09008660167455673, -0.08720318973064423, -0.08245470374822617, -0.10234399884939194, 0.19635172188282013, -0.13135431706905365, 0.2677384316921234, -0.03503573685884476, -0.22508522868156433, -0.112706758081913, 0.03417070209980011, 0.19653455913066864, -0.2162640392780304, -0.1515597701072693, -0.023327000439167023, -0.004968846682459116, 0.0376853384077549, -0.06514094024896622, 0.08146794140338898, 0.07976383715867996, -0.10406520962715149, -0.45721232891082764, -0.10016806423664093, -0.05235406011343002, -0.04149402678012848, 0.0054552191868424416, -0.05616782233119011, 0.07495284825563431, -0.2324349284172058, -0.07747253775596619, 0.020301751792430878, 0.16606225073337555, -0.049775440245866776, -0.08939759433269501, 0.17369958758354187, -0.07171580195426941, -0.29493245482444763, -0.05096827819943428, 0.05974216386675835, 0.1934920996427536, 0.14177370071411133, 0.010161984711885452, 0.01671195775270462, -0.09920952469110489, 0.06554976105690002, -0.25490570068359375, 0.036633457988500595, 0.16162243485450745, 0.025041649118065834, 0.01508278213441372, 0.005302885547280312, -0.10272610187530518, 0.03740565478801727, 0.1506415456533432, -0.18771055340766907, -0.10580013692378998, 0.06068480387330055, -0.10924514383077621, -0.06539610028266907, -0.12561345100402832, 0.27128615975379944, 0.20287086069583893, -0.13297437131404877, -0.1762954741716385, 0.11034033447504044, -0.15277713537216187, -0.027844959869980812, 0.10175003111362457, -0.12501384317874908, -0.24999354779720306, -0.3338157832622528, 0.001971479505300522, 0.31238502264022827, 0.10100376605987549, -0.12357345223426819, 0.03959168493747711, -0.0815640240907669, -0.009729903191328049, 0.08266538381576538, 0.15124954283237457, 0.011230261996388435, 0.08069176226854324, -0.127456396818161, 0.044604912400245667, 0.19823633134365082, -0.07718481868505478, 0.011964729987084866, 0.24694783985614777, 0.012285180389881134, 0.10370013117790222, 0.01042763702571392, 0.07744865864515305, -0.047568030655384064, 0.02586311846971512, -0.20861658453941345, 0.04415066912770271, 0.05919310450553894, 0.039091210812330246, -0.04661335423588753, 0.07595592737197876, -0.1582529991865158, 0.036706939339637756, 0.008120217360556126, -0.026307284832000732, 0.045081302523612976, -0.0751051977276802, -0.04946199804544449, -0.17545470595359802, 0.07931462675333023, -0.2665981352329254, 0.1397392749786377, 0.20680955052375793, 0.05093002691864967, 0.18016910552978516, 0.08233986049890518, 0.03672053664922714, -0.021599942818284035, -0.13274571299552917, -0.24900546669960022, 0.04211864247918129, 0.10715876519680023, -0.018366381525993347, 0.012663201428949833, -0.01600147783756256]
22	Udin	Petot	789557846	annisanirwana94@yahoo.com	082214987219	CS	CSS	[-0.12919948995113373, 0.06666329503059387, 0.03344258666038513, -0.08404503762722015, -0.09008660167455673, -0.08720318973064423, -0.08245470374822617, -0.10234399884939194, 0.19635172188282013, -0.13135431706905365, 0.2677384316921234, -0.03503573685884476, -0.22508522868156433, -0.112706758081913, 0.03417070209980011, 0.19653455913066864, -0.2162640392780304, -0.1515597701072693, -0.023327000439167023, -0.004968846682459116, 0.0376853384077549, -0.06514094024896622, 0.08146794140338898, 0.07976383715867996, -0.10406520962715149, -0.45721232891082764, -0.10016806423664093, -0.05235406011343002, -0.04149402678012848, 0.0054552191868424416, -0.05616782233119011, 0.07495284825563431, -0.2324349284172058, -0.07747253775596619, 0.020301751792430878, 0.16606225073337555, -0.049775440245866776, -0.08939759433269501, 0.17369958758354187, -0.07171580195426941, -0.29493245482444763, -0.05096827819943428, 0.05974216386675835, 0.1934920996427536, 0.14177370071411133, 0.010161984711885452, 0.01671195775270462, -0.09920952469110489, 0.06554976105690002, -0.25490570068359375, 0.036633457988500595, 0.16162243485450745, 0.025041649118065834, 0.01508278213441372, 0.005302885547280312, -0.10272610187530518, 0.03740565478801727, 0.1506415456533432, -0.18771055340766907, -0.10580013692378998, 0.06068480387330055, -0.10924514383077621, -0.06539610028266907, -0.12561345100402832, 0.27128615975379944, 0.20287086069583893, -0.13297437131404877, -0.1762954741716385, 0.11034033447504044, -0.15277713537216187, -0.027844959869980812, 0.10175003111362457, -0.12501384317874908, -0.24999354779720306, -0.3338157832622528, 0.001971479505300522, 0.31238502264022827, 0.10100376605987549, -0.12357345223426819, 0.03959168493747711, -0.0815640240907669, -0.009729903191328049, 0.08266538381576538, 0.15124954283237457, 0.011230261996388435, 0.08069176226854324, -0.127456396818161, 0.044604912400245667, 0.19823633134365082, -0.07718481868505478, 0.011964729987084866, 0.24694783985614777, 0.012285180389881134, 0.10370013117790222, 0.01042763702571392, 0.07744865864515305, -0.047568030655384064, 0.02586311846971512, -0.20861658453941345, 0.04415066912770271, 0.05919310450553894, 0.039091210812330246, -0.04661335423588753, 0.07595592737197876, -0.1582529991865158, 0.036706939339637756, 0.008120217360556126, -0.026307284832000732, 0.045081302523612976, -0.0751051977276802, -0.04946199804544449, -0.17545470595359802, 0.07931462675333023, -0.2665981352329254, 0.1397392749786377, 0.20680955052375793, 0.05093002691864967, 0.18016910552978516, 0.08233986049890518, 0.03672053664922714, -0.021599942818284035, -0.13274571299552917, -0.24900546669960022, 0.04211864247918129, 0.10715876519680023, -0.018366381525993347, 0.012663201428949833, -0.01600147783756256]
23	Bilee	Libasutaqwa	127836189	nabilalb1234@gmail.com	081234567890	Data Security	Cyber Security	[-0.10515369474887848, 0.12102413177490234, 0.007206636480987072, -0.08250511437654495, -0.14248976111412048, -0.036403998732566833, -0.06081155315041542, -0.1573445349931717, 0.18462875485420227, -0.15169206261634827, 0.2418767511844635, -0.030277637764811516, -0.17465631663799286, -0.03781599551439285, -0.04131127893924713, 0.2120911329984665, -0.21098479628562927, -0.15352685749530792, -0.0633586123585701, -0.03658236563205719, 0.07175104320049286, -0.031457509845495224, 0.0406232625246048, 0.08454785495996475, -0.1343592405319214, -0.3241282105445862, -0.07199050486087799, -0.04246433824300766, -0.00015655718743801117, -0.048512715846300125, -0.0750967264175415, 0.06922850757837296, -0.2539134621620178, -0.07082343846559525, 0.009250721894204617, 0.1065405011177063, -0.04653998091816902, -0.09865506738424301, 0.18624205887317657, -0.07266099005937576, -0.254630446434021, 0.056495241820812225, 0.08221207559108734, 0.23922252655029297, 0.15573419630527496, 0.012297376990318298, -0.007453501224517822, -0.11864685267210007, 0.10870453715324402, -0.1790452003479004, 0.03064972534775734, 0.13745054602622986, 0.03906048834323883, 0.003561022225767374, 0.02198975905776024, -0.14600984752178192, 0.04505819082260132, 0.11283612251281738, -0.10636351257562637, -0.04301244765520096, 0.113278329372406, -0.061366572976112366, -0.040638457983732224, -0.16014553606510162, 0.2499476820230484, 0.1299530416727066, -0.10157322138547897, -0.13822659850120544, 0.1081167683005333, -0.09639745950698853, -0.049536798149347305, 0.03999624773859978, -0.15507394075393677, -0.21273477375507355, -0.2828190326690674, -0.027578668668866158, 0.3424385190010071, 0.1303369402885437, -0.18908889591693878, 0.05990130454301834, -0.004179954994469881, 0.027922004461288452, 0.15764421224594116, 0.14106671512126923, -0.012726660817861557, 0.05724513903260231, -0.11068858206272125, 0.07621403783559799, 0.23383653163909912, -0.04906002804636955, -0.02381257526576519, 0.25395798683166504, 0.01527024619281292, 0.027683570981025696, 0.010804219171404839, 0.025892576202750206, -0.08015403151512146, 0.03722676634788513, -0.1992020159959793, 0.045027315616607666, 0.06690646708011627, 0.013435096479952335, -0.059158023446798325, 0.13008570671081543, -0.14287406206130981, 0.06390837579965591, -0.005406229291111231, 0.05250898748636246, -0.0012818691320717335, -0.021474411711096764, -0.11295673996210098, -0.0844670906662941, 0.09379240870475769, -0.20421113073825836, 0.18064136803150177, 0.1627792865037918, 0.006104527041316032, 0.11086975783109665, 0.1285325437784195, 0.05018804222345352, 0.0005297213792800903, -0.028653252869844437, -0.27141085267066956, -0.014421189203858376, 0.15647445619106293, -0.07958628982305527, 0.11505164951086044, 0.018948649987578392]
\.


--
-- Data for Name: lock_system; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.lock_system (lock_id, role_id) FROM stdin;
\.


--
-- Data for Name: login_attempts; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.login_attempts ("logAtt_id", user_id, email, ip_address, attempt_time, is_successful, user_agent, failed_attempts, lockout_until) FROM stdin;
1	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-04 13:22:06.377694	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
2	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-04 13:22:07.002826	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
29	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:33.417745	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
30	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:34.222684	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
31	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:54:02.363038	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
32	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:54:04.600617	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
3	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-04 13:22:07.402069	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	5	2025-05-04 13:27:39.713537
4	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-04 13:26:45.43377	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
5	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-04 13:28:31.789221	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	1	\N
6	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:15:59.909466	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
7	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:16:01.94376	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
8	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:16:03.378935	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
9	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:16:05.17587	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
10	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:20:26.588225	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
11	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:29:19.725174	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
12	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 14:29:20.853317	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
13	4	admin@ams.com	127.0.0.1	2025-05-04 14:54:33.490016	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
14	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:39.555741	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
15	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:40.866876	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
16	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:41.62311	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
17	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:42.487614	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
18	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:43.630089	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
19	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:44.588633	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
20	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:02:46.407914	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
21	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:08:40.798128	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
22	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:10:49.632831	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
23	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:13:23.20506	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
24	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:44:00.934771	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
25	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:28.974889	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
26	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:30.500297	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
27	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:31.841995	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
28	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 15:52:32.54315	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
33	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:01:27.294387	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
34	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:01:28.430781	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	1	\N
35	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:08:41.561377	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
36	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:10:55.827783	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
37	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:11:23.896818	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
38	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:16:27.244365	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
39	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:18:08.408159	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
40	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:25:54.779717	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
41	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:04.928358	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
42	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:08.503196	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
43	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:09.350696	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
44	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:11.276177	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
45	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:12.408143	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
46	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:26:14.664534	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
47	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:31:42.658806	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
48	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 16:50:01.617459	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
49	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 17:40:16.832693	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	2	\N
50	1	nabilalb@gmail.com	127.0.0.1	2025-05-04 17:40:23.507075	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
51	4	admin@ams.com	127.0.0.1	2025-05-04 17:41:12.0368	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
52	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-04 17:42:00.067026	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
53	4	admin@ams.com	127.0.0.1	2025-05-05 09:17:51.910966	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
54	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 09:37:21.473838	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	1	\N
55	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 09:42:43.42061	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
56	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:44.17611	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
57	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:45.293023	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
58	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:46.045669	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
59	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:47.91687	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
65	15	admin@gmail.com	127.0.0.1	2025-05-07 07:01:43.451711	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2	\N
66	15	admin@gmail.com	127.0.0.1	2025-05-07 07:01:53.469609	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
67	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-07 11:22:14.635749	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
60	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-06 02:16:17.498755	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	5	2025-05-06 02:21:51.420291
61	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-06 03:06:49.494376	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
62	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-06 03:33:00.898737	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
63	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-06 03:33:27.072062	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	0	\N
64	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-07 07:00:16.777195	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2	\N
68	4	admin@ams.com	127.0.0.1	2025-05-07 11:32:06.982905	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
69	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-07 11:37:54.417827	t	Chrome 136.0.0	0	\N
70	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-07 11:39:11.836872	t	Edge 136.0.0	0	\N
71	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 02:31:04.080343	t	Chrome 136.0.0	0	\N
72	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 02:31:47.467508	t	Edge 136.0.0	0	\N
73	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 02:31:52.818718	t	Edge 136.0.0	0	\N
74	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 02:31:57.721341	t	Edge 136.0.0	0	\N
75	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 03:10:34.820601	t	Chrome 136.0.0	5	2025-05-08 03:16:31.445359
76	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 04:20:34.652785	t	Chrome 136.0.0	0	\N
77	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 05:44:04.714877	t	Chrome 136.0.0	5	2025-05-08 05:49:28.840713
78	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-08 05:49:34.098435	t	Chrome 136.0.0	0	\N
142	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:31.064323	t	Edge 136.0.0	0	\N
79	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-08 08:43:29.370456	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
80	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 08:10:10.898334	t	Chrome 136.0.0	0	\N
97	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 14:56:00.535966	t	Chrome 136.0.0	5	2025-05-09 15:01:38.738453
98	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 15:01:44.730676	t	Chrome 136.0.0	0	\N
99	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 15:27:57.032981	t	Chrome 136.0.0	0	\N
100	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 15:28:34.836715	t	Chrome 136.0.0	0	\N
101	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:23.844963	t	Chrome 136.0.0	0	\N
102	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:29.094748	t	Chrome 136.0.0	0	\N
103	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:31.833303	t	Chrome 136.0.0	0	\N
81	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 08:56:59.899683	f	Chrome 136.0.0	5	2025-05-09 09:06:25.549341
104	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:33.363226	t	Chrome 136.0.0	0	\N
105	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:36.42521	t	Chrome 136.0.0	0	\N
106	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:40.514773	t	Chrome 136.0.0	0	\N
107	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:09:55.942321	t	Chrome 136.0.0	0	\N
82	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 09:08:57.639463	t	Chrome 136.0.0	5	2025-05-09 09:19:05.912735
83	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 09:19:45.16538	t	Chrome 136.0.0	0	\N
108	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:06.176849	t	Chrome 136.0.0	0	\N
109	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:14.554735	t	Chrome 136.0.0	0	\N
110	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:15.947518	t	Chrome 136.0.0	0	\N
84	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 10:11:19.22307	f	Chrome 136.0.0	5	2025-05-09 10:16:36.809389
85	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 10:23:14.206728	t	Chrome 136.0.0	0	\N
111	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:38.59255	t	Chrome 136.0.0	0	\N
112	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:42.967088	t	Chrome 136.0.0	0	\N
113	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:10:44.533759	t	Chrome 136.0.0	0	\N
86	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:21:27.349023	f	Chrome 136.0.0	5	2025-05-09 11:26:45.484123
87	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:27:35.451503	t	Chrome 136.0.0	0	\N
114	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:11:41.516056	t	Chrome 136.0.0	0	\N
115	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:12:12.903278	t	Chrome 136.0.0	0	\N
116	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 16:12:57.215746	t	Chrome 136.0.0	0	\N
88	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:29:09.767887	t	Chrome 136.0.0	5	2025-05-09 11:36:41.820822
89	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:37:44.29322	t	Chrome 136.0.0	0	\N
132	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-11 09:45:09.892936	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
133	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-11 09:45:11.119653	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
134	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 14:00:19.141632	t	Chrome 136.0.0	0	\N
135	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 14:10:16.034785	t	Chrome 136.0.0	0	\N
90	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:49:28.162205	t	Chrome 136.0.0	5	2025-05-09 11:55:01.577409
91	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:56:29.901247	t	Chrome 136.0.0	0	\N
117	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 17:09:23.201279	t	Chrome 136.0.0	5	2025-05-09 17:15:27.927135
118	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 17:15:42.448516	t	Chrome 136.0.0	0	\N
119	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 17:21:49.251469	t	Chrome 136.0.0	0	\N
120	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 18:08:03.137548	t	Chrome 136.0.0	0	\N
92	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 11:56:30.602529	t	Chrome 136.0.0	5	2025-05-09 12:19:29.733027
93	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 12:21:13.688744	t	Chrome 136.0.0	0	\N
121	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 18:51:17.846168	t	Chrome 136.0.0	0	\N
122	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 18:51:18.709007	t	Chrome 136.0.0	0	\N
123	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 18:51:20.797722	t	Chrome 136.0.0	0	\N
94	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 12:59:29.632427	f	Chrome 136.0.0	5	2025-05-09 13:04:57.089793
95	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 13:05:15.041546	t	Chrome 136.0.0	0	\N
96	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 13:12:24.592456	t	Chrome 136.0.0	0	\N
124	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 18:56:27.498759	t	Chrome 136.0.0	0	\N
125	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 19:02:05.565282	t	Chrome 136.0.0	0	\N
126	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 19:11:18.862318	t	Chrome 136.0.0	0	\N
136	15	admin@gmail.com	127.0.0.1	2025-05-12 14:15:51.0317	t	Chrome 136.0.0	0	\N
127	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-09 19:29:54.839231	t	Chrome 136.0.0	0	\N
128	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-10 09:11:16.661027	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
129	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-10 13:11:27.164933	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
130	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-11 08:04:21.689615	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
131	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-11 08:04:22.922611	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
137	17	nita@gmail.com	127.0.0.1	2025-05-12 14:16:27.287621	f	Chrome 136.0.0	1	\N
138	17	nita@gmail.com	127.0.0.1	2025-05-12 14:16:42.912585	t	Chrome 136.0.0	0	\N
139	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 15:15:51.084899	t	Edge 136.0.0	0	\N
140	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 15:15:51.809603	t	Edge 136.0.0	0	\N
141	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 15:29:22.855762	t	Edge 136.0.0	0	\N
143	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:32.165582	t	Edge 136.0.0	0	\N
144	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:33.199457	t	Edge 136.0.0	0	\N
145	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:34.430823	t	Edge 136.0.0	0	\N
146	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:35.757575	t	Edge 136.0.0	0	\N
147	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:37.150565	t	Edge 136.0.0	0	\N
148	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:38.24195	t	Edge 136.0.0	0	\N
149	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 16:55:53.465993	t	Edge 136.0.0	0	\N
150	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 17:54:39.276495	t	Edge 136.0.0	0	\N
151	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 17:55:03.961837	t	Edge 136.0.0	0	\N
152	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 17:55:13.934316	t	Edge 136.0.0	0	\N
153	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 17:57:06.486593	t	Edge 136.0.0	0	\N
154	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 17:58:08.344178	t	Edge 136.0.0	0	\N
155	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 18:04:18.564921	t	Edge 136.0.0	0	\N
156	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 18:21:29.321733	t	Edge 136.0.0	0	\N
157	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 18:28:23.583416	t	Edge 136.0.0	0	\N
158	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 18:56:13.828292	t	Edge 136.0.0	0	\N
159	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 19:22:37.823725	t	Edge 136.0.0	0	\N
160	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 19:56:14.895548	t	Edge 136.0.0	0	\N
161	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 19:57:05.12448	t	Edge 136.0.0	0	\N
162	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 20:04:57.248071	t	Edge 136.0.0	0	\N
163	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-12 20:06:00.043051	t	Edge 136.0.0	0	\N
164	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-13 07:36:28.163032	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	0	\N
165	\N	nabilalb@gmail.com	127.0.0.1	2025-05-13 12:26:12.072063	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	1	\N
166	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-13 12:26:20.436846	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	1	\N
167	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:37:20.015909	t	Edge 136.0.0	0	\N
168	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:39:44.542942	t	Edge 136.0.0	0	\N
169	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:39:47.181069	t	Edge 136.0.0	0	\N
170	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:48:09.149115	t	Edge 136.0.0	0	\N
171	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:57:00.038211	t	Edge 136.0.0	0	\N
173	15	admin@gmail.com	127.0.0.1	2025-05-14 02:58:03.601414	t	Edge 136.0.0	0	\N
174	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-14 02:58:46.434762	t	Edge 136.0.0	0	\N
199	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:08:40.797901	t	Edge 136.0.0	0	\N
200	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:08:53.295756	t	Edge 136.0.0	0	\N
201	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:32:18.071499	t	Edge 136.0.0	0	\N
202	15	admin@gmail.com	127.0.0.1	2025-05-14 08:33:34.698678	t	Edge 136.0.0	0	\N
172	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:57:02.963865	t	Edge 136.0.0	5	2025-05-14 03:06:30.604055
175	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-14 03:01:50.889404	t	Edge 136.0.0	0	\N
176	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 03:10:12.021334	t	Edge 136.0.0	0	\N
177	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-14 03:31:38.105133	t	Edge 136.0.0	0	\N
178	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 03:31:57.670639	t	Edge 136.0.0	0	\N
179	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 03:40:30.367318	t	Edge 136.0.0	0	\N
180	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 04:15:10.280792	t	Edge 136.0.0	0	\N
181	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 04:33:37.374263	t	Edge 136.0.0	0	\N
182	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:04:11.752419	t	Edge 136.0.0	0	\N
183	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:41:28.34252	t	Edge 136.0.0	0	\N
184	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:45:48.100679	t	Edge 136.0.0	0	\N
185	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:08.666139	t	Edge 136.0.0	0	\N
186	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:09.787771	t	Edge 136.0.0	0	\N
187	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:10.735359	t	Edge 136.0.0	0	\N
188	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:11.88195	t	Edge 136.0.0	0	\N
189	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:13.013761	t	Edge 136.0.0	0	\N
190	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:14.201903	t	Edge 136.0.0	0	\N
191	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:55:15.193055	t	Edge 136.0.0	0	\N
192	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 06:56:56.566953	t	Edge 136.0.0	0	\N
193	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 07:35:45.03622	t	Edge 136.0.0	0	\N
194	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-14 07:37:30.095358	t	Opera 118.0.0	0	\N
195	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-14 07:37:30.73139	t	Opera 118.0.0	0	\N
196	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 07:53:10.490188	t	Edge 136.0.0	0	\N
197	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:06:11.294815	t	Edge 136.0.0	0	\N
198	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:06:15.219118	t	Edge 136.0.0	0	\N
203	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-14 08:34:34.987873	t	Edge 136.0.0	0	\N
204	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:36:05.209182	t	Edge 136.0.0	0	\N
205	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:43:03.300886	t	Edge 136.0.0	0	\N
206	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:55:35.795819	t	Edge 136.0.0	0	\N
296	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:42:50.842491	t	Edge 136.0.0	0	\N
297	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:42:58.783003	t	Edge 136.0.0	0	\N
298	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:44:33.244528	t	Edge 136.0.0	0	\N
207	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 10:55:33.248468	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	3	\N
208	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 11:24:34.243866	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
209	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 11:24:51.218354	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
210	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 11:58:39.895345	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
211	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 11:58:46.744868	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
212	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 11:58:51.098952	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
213	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 11:59:06.638322	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
214	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-14 12:04:16.507942	t	Opera 118.0.0	0	\N
215	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 12:22:01.552556	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
216	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 12:22:08.746204	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
217	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 12:22:27.859173	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
218	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 12:22:52.269399	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
219	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 12:23:09.989418	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
220	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 12:31:05.817677	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
221	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 12:31:22.629942	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
222	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-14 12:31:41.260522	t	Opera 118.0.0	0	\N
223	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:13:07.168336	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
224	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:13:13.648545	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
225	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:13:28.13833	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
226	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:42:52.576409	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
227	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:42:57.964374	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
228	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:43:02.223764	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
229	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:43:29.130707	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
230	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:47:46.199971	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
231	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 13:48:02.538351	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
232	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:57:30.399746	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
233	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:57:36.299343	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
234	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:57:42.633625	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
235	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:57:52.310127	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
236	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:57:57.87928	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
237	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:58:02.780556	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
238	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:58:08.01031	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
239	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:58:43.739126	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
240	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 14:59:09.050057	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
299	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:45:11.87753	t	Edge 136.0.0	0	\N
795	\N	aku@gmail.com	127.0.0.1	2025-05-26 13:36:32.00057	f	Edge 136.0.0	2	\N
241	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 15:58:23.059958	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
242	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:06:54.096785	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
243	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:07:00.329067	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
244	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:07:06.80218	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
245	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:10:04.541903	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
246	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:10:10.569147	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
247	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:10:16.741925	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
248	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:12:42.570962	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
249	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 16:29:42.299977	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
250	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:13:16.926572	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
251	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:13:37.673619	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
252	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:34:41.315103	f	Edge 135.0.0	0	\N
253	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:43:05.217968	t	Edge 135.0.0	0	\N
254	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:59:22.657833	f	Edge 135.0.0	0	\N
255	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-14 17:59:47.482625	t	Edge 135.0.0	0	\N
256	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 18:00:59.024243	f	Edge 135.0.0	0	\N
257	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 18:01:20.004449	t	Edge 135.0.0	0	\N
258	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 18:48:06.352666	f	Edge 135.0.0	0	\N
259	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-14 18:48:26.319925	t	Edge 135.0.0	0	\N
260	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-15 02:47:48.59387	f	Edge 135.0.0	0	\N
261	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-15 02:48:45.125986	t	Edge 135.0.0	0	\N
262	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 02:58:52.654136	f	Edge 135.0.0	0	\N
263	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 02:59:14.361347	t	Edge 135.0.0	0	\N
264	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 03:01:32.544965	t	Edge 135.0.0	0	\N
265	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-15 03:07:12.032233	t	Edge 136.0.0	0	\N
266	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-15 08:22:55.023193	f	Opera 118.0.0	0	\N
267	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-15 08:23:30.052369	f	Opera 118.0.0	0	\N
268	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-15 08:24:35.89202	t	Opera 118.0.0	0	\N
269	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 08:44:23.601589	f	Edge 135.0.0	0	\N
270	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 08:44:28.826147	f	Edge 135.0.0	0	\N
271	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-15 08:44:54.227442	t	Edge 135.0.0	0	\N
272	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 09:33:38.035709	t	Edge 136.0.0	0	\N
273	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 09:34:37.267248	t	Edge 136.0.0	0	\N
274	17	nita@gmail.com	127.0.0.1	2025-05-16 09:58:14.063402	t	Edge 136.0.0	0	\N
275	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 10:10:26.20745	t	Edge 136.0.0	0	\N
276	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 10:52:25.076437	f	Edge 135.0.0	0	\N
277	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 10:52:32.327185	f	Edge 135.0.0	0	\N
278	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 10:53:35.721532	t	Edge 135.0.0	0	\N
279	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 11:00:14.201506	t	Edge 136.0.0	0	\N
280	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 11:11:03.539714	t	Edge 135.0.0	0	\N
281	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 11:11:04.493323	t	Edge 135.0.0	0	\N
282	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 11:14:15.656868	t	Edge 135.0.0	0	\N
283	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 11:14:16.681174	t	Edge 135.0.0	0	\N
284	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 13:59:55.019292	f	Opera 118.0.0	0	\N
285	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 14:01:27.949379	t	Opera 118.0.0	0	\N
286	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 14:14:11.698321	t	Opera 118.0.0	0	\N
287	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:02:30.932652	t	Chrome Mobile 133.0.0	0	\N
288	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:10:47.089581	t	Edge 136.0.0	0	\N
289	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:10:48.162668	t	Edge 136.0.0	0	\N
290	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:20:38.55426	f	Edge 135.0.0	0	\N
291	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:20:44.114262	f	Edge 135.0.0	0	\N
292	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:21:07.10166	t	Edge 135.0.0	0	\N
293	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:41:41.364765	f	Edge 135.0.0	0	\N
294	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:41:46.281555	f	Edge 135.0.0	0	\N
295	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-16 15:42:08.271753	t	Edge 135.0.0	0	\N
300	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:48:38.713889	t	Edge 136.0.0	0	\N
301	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:48:39.793916	t	Edge 136.0.0	0	\N
302	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:48:43.790692	t	Edge 136.0.0	0	\N
303	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:49:53.665215	t	Edge 136.0.0	0	\N
304	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:51:32.435001	t	Edge 136.0.0	0	\N
305	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:58:00.947191	t	Edge 136.0.0	0	\N
306	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 15:58:38.955197	t	Edge 136.0.0	0	\N
307	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:04:04.454547	t	Edge 136.0.0	0	\N
308	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:05:40.878291	t	Edge 136.0.0	0	\N
309	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:09:08.640336	t	Edge 136.0.0	0	\N
310	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:23:52.931906	t	Edge 136.0.0	0	\N
311	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:26:00.436472	t	Opera 118.0.0	0	\N
312	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:26:15.606108	t	Edge 136.0.0	0	\N
313	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:29:28.374035	t	Edge 136.0.0	0	\N
314	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:35:20.892887	t	Opera 118.0.0	0	\N
315	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:42:26.091138	t	Edge 136.0.0	0	\N
316	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:48:26.646236	f	Opera 118.0.0	0	\N
317	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:49:16.341826	f	Chrome Mobile 133.0.0	0	\N
318	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:50:41.098983	f	Chrome Mobile 133.0.0	0	\N
319	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-16 16:56:52.247687	f	Chrome Mobile 133.0.0	0	\N
320	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 16:59:52.807241	t	Edge 136.0.0	0	\N
321	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-16 16:59:59.534483	f	Chrome Mobile 133.0.0	0	\N
322	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-16 17:00:25.109074	t	Chrome Mobile 133.0.0	0	\N
323	17	nita@gmail.com	127.0.0.1	2025-05-16 17:00:37.304724	t	Edge 136.0.0	0	\N
324	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 17:01:50.697589	f	Opera 118.0.0	0	\N
325	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-16 17:02:49.465293	t	Opera 118.0.0	0	\N
326	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 05:38:54.182909	t	Opera 118.0.0	0	\N
327	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 05:41:21.310495	f	Opera 118.0.0	0	\N
328	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 05:41:37.069286	t	Opera 118.0.0	0	\N
329	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-17 06:13:50.038013	f	Edge 136.0.0	0	\N
330	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-17 06:14:06.544014	t	Edge 136.0.0	0	\N
331	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:16:32.18842	f	Opera 118.0.0	0	\N
332	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:16:48.8629	t	Opera 118.0.0	0	\N
333	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-17 06:19:22.374594	f	Edge 136.0.0	0	\N
334	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-17 06:19:41.434183	t	Edge 136.0.0	0	\N
335	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:19:54.079013	f	Chrome Mobile 133.0.0	0	\N
336	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:20:10.460434	t	Chrome Mobile 133.0.0	0	\N
337	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 06:22:48.565877	f	Opera 118.0.0	0	\N
338	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 06:23:05.690495	t	Opera 118.0.0	0	\N
339	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:27:57.786053	f	Opera 118.0.0	0	\N
340	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:28:18.295588	t	Opera 118.0.0	0	\N
341	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:30:38.135383	t	Opera 118.0.0	0	\N
342	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:32:00.818418	f	Opera 118.0.0	0	\N
343	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:32:16.628254	t	Opera 118.0.0	0	\N
344	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-17 06:35:21.609199	f	Edge 136.0.0	0	\N
345	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-17 06:35:38.086332	t	Edge 136.0.0	0	\N
346	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-17 06:35:54.906613	f	Edge 136.0.0	0	\N
347	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-17 06:36:11.10922	t	Edge 136.0.0	0	\N
348	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:36:59.152604	f	Opera 118.0.0	0	\N
349	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:37:15.160427	t	Opera 118.0.0	0	\N
350	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:37:32.531188	f	Opera 118.0.0	0	\N
351	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-17 06:37:48.612558	t	Opera 118.0.0	0	\N
352	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 08:26:23.396356	t	Opera 118.0.0	0	\N
353	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 08:26:49.928982	t	Opera 118.0.0	0	\N
354	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 10:43:55.516894	t	Edge 136.0.0	0	\N
355	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 11:03:51.968135	t	Opera 118.0.0	0	\N
356	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 14:39:23.180904	t	Chrome Mobile 133.0.0	0	\N
357	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 14:40:12.830745	t	Opera 118.0.0	0	\N
358	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-17 14:40:48.322696	t	Edge 136.0.0	0	\N
359	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-18 04:11:13.907595	t	Opera 118.0.0	0	\N
360	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 08:10:48.260532	t	Edge 136.0.0	0	\N
361	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-18 08:27:05.370294	t	Edge 136.0.0	0	\N
362	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-18 08:29:31.873748	t	Edge 136.0.0	0	\N
363	\N	nita@gmail.com	127.0.0.1	2025-05-18 09:17:15.814051	f	Edge 136.0.0	2	\N
364	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 09:17:28.092486	t	Edge 136.0.0	0	\N
365	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 09:17:59.978795	t	Edge 136.0.0	0	\N
366	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 10:18:21.74464	t	Edge 136.0.0	0	\N
367	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 10:19:41.883785	t	Edge 136.0.0	0	\N
368	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 10:27:31.024152	t	Edge 136.0.0	0	\N
369	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 10:32:14.149217	t	Edge 136.0.0	0	\N
370	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 10:34:01.513992	t	Edge 136.0.0	0	\N
371	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 10:42:55.404321	t	Edge 136.0.0	0	\N
372	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 11:03:41.922065	t	Edge 136.0.0	0	\N
373	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 11:03:42.439414	t	Edge 136.0.0	0	\N
374	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 11:03:51.142385	t	Edge 136.0.0	0	\N
375	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 11:04:33.149977	t	Edge 136.0.0	0	\N
428	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:51:39.530436	f	Edge 136.0.0	1	\N
429	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:55:30.170103	t	Edge 136.0.0	1	\N
376	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 12:08:22.859285	t	Edge 136.0.0	5	2025-05-18 12:14:01.671293
377	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:39:46.477197	t	Edge 136.0.0	0	\N
378	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 13:40:01.613823	t	Edge 136.0.0	0	\N
379	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:44:18.680094	t	Edge 136.0.0	0	\N
380	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 13:51:04.874267	t	Edge 136.0.0	0	\N
381	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:52:10.188886	t	Edge 136.0.0	0	\N
382	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 13:53:45.443588	t	Edge 136.0.0	0	\N
383	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:54:40.385746	t	Edge 136.0.0	0	\N
384	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:01:04.77295	t	Edge 136.0.0	0	\N
385	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:04:52.24382	t	Edge 136.0.0	0	\N
386	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:12:08.942736	t	Edge 136.0.0	0	\N
387	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:16:16.563329	t	Edge 136.0.0	0	\N
388	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-18 14:19:30.735115	t	Opera 118.0.0	0	\N
389	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:24:26.490154	t	Edge 136.0.0	0	\N
390	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-18 14:31:32.290087	t	Opera 118.0.0	0	\N
391	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:31:40.588222	t	Edge 136.0.0	0	\N
392	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:52:03.429189	t	Edge 136.0.0	0	\N
393	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:57:08.703695	t	Edge 136.0.0	0	\N
394	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 14:58:46.883432	t	Edge 136.0.0	0	\N
395	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 15:00:56.08158	t	Edge 136.0.0	0	\N
396	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 15:05:05.978232	t	Edge 136.0.0	0	\N
397	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 15:26:17.000969	t	Edge 136.0.0	0	\N
398	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 15:39:41.098012	t	Edge 136.0.0	0	\N
399	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 15:43:51.657269	t	Edge 136.0.0	0	\N
400	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:08:44.275078	t	Edge 136.0.0	0	\N
401	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:11:37.029372	t	Edge 136.0.0	0	\N
402	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:19:41.268382	t	Edge 136.0.0	0	\N
403	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:21:28.94331	t	Edge 136.0.0	0	\N
404	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:23:49.427592	t	Edge 136.0.0	0	\N
405	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:28:28.269335	t	Edge 136.0.0	0	\N
406	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:31:42.957522	t	Edge 136.0.0	0	\N
407	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:38:16.493509	t	Edge 136.0.0	0	\N
408	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:42:17.652562	t	Edge 136.0.0	0	\N
409	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:47:10.884522	t	Edge 136.0.0	0	\N
410	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:47:12.376627	t	Edge 136.0.0	0	\N
411	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:47:20.082074	t	Edge 136.0.0	0	\N
412	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:49:17.247315	t	Edge 136.0.0	0	\N
413	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:52:19.702458	t	Edge 136.0.0	0	\N
414	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 16:53:45.858546	t	Edge 136.0.0	0	\N
415	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 17:12:40.504206	t	Edge 136.0.0	0	\N
416	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 17:22:44.462353	t	Edge 136.0.0	0	\N
417	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 17:38:20.238984	t	Edge 136.0.0	0	\N
418	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 17:58:21.940651	t	Edge 136.0.0	0	\N
419	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 19:28:19.046599	t	Edge 136.0.0	0	\N
420	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 19:34:58.242024	t	Edge 136.0.0	0	\N
421	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 19:40:50.488788	t	Edge 136.0.0	0	\N
422	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 19:58:03.360171	t	Edge 136.0.0	0	\N
423	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 19:59:03.626922	t	Edge 136.0.0	0	\N
424	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 20:00:11.46299	t	Edge 136.0.0	0	\N
425	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:00:49.539573	t	Edge 136.0.0	0	\N
426	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 20:11:40.396533	t	Edge 136.0.0	0	\N
431	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 21:21:15.380372	t	Edge 136.0.0	0	\N
432	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 21:24:11.825629	t	Edge 136.0.0	0	\N
427	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 20:43:19.774744	t	Edge 136.0.0	5	2025-05-18 21:14:24.716475
430	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 21:16:17.772575	f	Edge 136.0.0	5	2025-05-18 21:21:40.288985
433	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-18 21:37:55.70997	t	Edge 136.0.0	0	\N
434	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-18 21:46:55.401432	t	Edge 136.0.0	0	\N
435	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-18 21:53:19.359122	t	Edge 136.0.0	0	\N
436	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 07:14:50.845129	t	Opera 118.0.0	0	\N
437	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 07:59:29.375022	t	Chrome Mobile 133.0.0	0	\N
438	\N	adelaideufrasia@gmail.com1	127.0.0.1	2025-05-19 08:58:17.448141	f	Opera 118.0.0	1	\N
439	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-19 08:58:25.082759	t	Opera 118.0.0	0	\N
440	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 09:08:22.979503	t	Opera 118.0.0	0	\N
441	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-19 09:15:16.797883	t	Opera 118.0.0	0	\N
443	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 09:34:26.571306	t	Opera 118.0.0	0	\N
445	\N	adelaideufrasia@gmail.com1	127.0.0.1	2025-05-19 09:47:28.453632	f	Opera 118.0.0	2	\N
446	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-19 09:47:35.508977	t	Opera 118.0.0	0	\N
447	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-19 10:17:18.836642	t	Opera 118.0.0	0	\N
448	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 10:27:10.593375	t	Opera 118.0.0	0	\N
451	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 15:53:52.176984	t	Opera 118.0.0	0	\N
452	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-19 16:41:19.087852	t	Opera 118.0.0	0	\N
453	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 00:17:03.620555	t	Edge 136.0.0	0	\N
454	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 00:17:49.596295	t	Edge 136.0.0	0	\N
455	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 00:19:48.61781	t	Edge 136.0.0	0	\N
456	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 00:30:50.027862	t	Edge 136.0.0	0	\N
457	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 00:32:46.963285	t	Edge 136.0.0	0	\N
458	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 00:33:28.763691	t	Edge 136.0.0	0	\N
459	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 00:34:32.317758	t	Edge 136.0.0	0	\N
460	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 01:53:45.137438	t	Edge 136.0.0	0	\N
461	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 01:53:45.962761	t	Edge 136.0.0	0	\N
462	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 01:57:11.606807	t	Edge 136.0.0	0	\N
463	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 02:08:56.772179	t	Edge 136.0.0	0	\N
464	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:02:35.105705	t	Edge 136.0.0	0	\N
465	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:36:59.163572	t	Edge 136.0.0	0	\N
466	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:46:51.667203	t	Edge 136.0.0	0	\N
467	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:46:54.363774	t	Edge 136.0.0	0	\N
468	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:46:55.913235	t	Edge 136.0.0	0	\N
469	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:41.24512	t	Edge 136.0.0	0	\N
470	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:50.026818	t	Edge 136.0.0	0	\N
471	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:55.021686	t	Edge 136.0.0	0	\N
472	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:57.199088	t	Edge 136.0.0	0	\N
473	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:58.155838	t	Edge 136.0.0	0	\N
474	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:47:59.826804	t	Edge 136.0.0	0	\N
475	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:48:23.139716	t	Edge 136.0.0	0	\N
476	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 03:49:20.97025	t	Edge 136.0.0	0	\N
477	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 04:53:54.655141	t	Edge 136.0.0	0	\N
478	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 04:54:07.665739	t	Edge 136.0.0	0	\N
479	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-20 04:55:00.465047	t	Edge 136.0.0	0	\N
480	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 04:56:23.611544	t	Edge 136.0.0	0	\N
481	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 04:56:32.184854	t	Edge 136.0.0	0	\N
482	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 04:57:12.562889	t	Edge 136.0.0	0	\N
483	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 04:58:58.536483	t	Edge 136.0.0	0	\N
484	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:01:16.365315	t	Edge 136.0.0	0	\N
485	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 05:03:04.969228	t	Edge 136.0.0	0	\N
486	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-20 05:03:28.679716	t	Edge 136.0.0	0	\N
487	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:10:06.684564	t	Edge 136.0.0	0	\N
488	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:10:14.689342	t	Edge 136.0.0	0	\N
489	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:11:26.890628	t	Edge 136.0.0	0	\N
490	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:14:18.842366	t	Edge 136.0.0	0	\N
491	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:16:42.696761	t	Opera 118.0.0	0	\N
492	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:16:43.714616	t	Opera 118.0.0	0	\N
493	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 05:16:53.903127	t	Opera 118.0.0	0	\N
494	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:17:13.717567	t	Opera 118.0.0	0	\N
495	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:17:49.120477	t	Opera 118.0.0	0	\N
496	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:26:32.773707	t	Edge 136.0.0	0	\N
497	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-20 05:27:09.168383	t	Edge 136.0.0	0	\N
498	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:36:08.333879	t	Edge 136.0.0	0	\N
499	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-20 05:37:02.447547	t	Edge 136.0.0	0	\N
500	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:41:30.601265	t	Edge 136.0.0	0	\N
501	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:36.156656	t	Opera 118.0.0	0	\N
502	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:37.462734	t	Opera 118.0.0	0	\N
503	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:38.458772	t	Opera 118.0.0	0	\N
504	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:56:00.015157	t	Opera 118.0.0	0	\N
505	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 08:19:55.895007	t	Edge 136.0.0	0	\N
506	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:24:09.527657	t	Opera 118.0.0	0	\N
507	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:48:57.03688	t	Opera 118.0.0	0	\N
569	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-21 15:42:28.964819	t	Edge 136.0.0	0	\N
508	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-20 08:49:12.172215	f	Opera 118.0.0	3	\N
510	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:51:05.666032	t	Opera 118.0.0	0	\N
511	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:57:53.397949	t	Chrome Mobile 133.0.0	0	\N
512	21	yuyus@gmail.com	127.0.0.1	2025-05-20 09:05:02.486009	f	Opera 118.0.0	1	\N
514	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 09:06:20.116037	t	Opera 118.0.0	0	\N
515	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 09:17:57.33852	t	Edge 136.0.0	0	\N
516	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 09:20:08.388541	t	Edge 136.0.0	0	\N
517	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 09:26:09.089271	t	Opera 118.0.0	0	\N
518	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 09:30:00.309694	t	Opera 118.0.0	0	\N
513	21	yuyus@gmail.com	127.0.0.1	2025-05-20 09:05:06.861734	t	Opera 118.0.0	1	\N
519	21	yuyus@gmail.com	127.0.0.1	2025-05-20 09:32:18.463539	t	Opera 118.0.0	0	\N
520	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 09:32:49.93909	t	Opera 118.0.0	0	\N
521	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 09:36:06.442593	t	Opera 118.0.0	0	\N
522	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 09:36:31.90576	t	Opera 118.0.0	0	\N
523	21	yuyus@gmail.com	127.0.0.1	2025-05-20 09:37:18.84853	t	Opera 118.0.0	0	\N
524	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 09:37:51.442419	t	Opera 118.0.0	0	\N
525	21	yuyus@gmail.com	127.0.0.1	2025-05-20 09:39:08.430947	t	Opera 118.0.0	0	\N
526	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 12:53:28.004185	t	Edge 136.0.0	0	\N
527	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-20 12:56:12.190404	t	Edge 136.0.0	0	\N
528	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 12:56:34.300547	t	Edge 136.0.0	0	\N
529	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:06:03.61033	t	Edge 136.0.0	0	\N
530	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:11:27.090739	t	Edge 136.0.0	0	\N
531	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:37.392603	t	Edge 136.0.0	0	\N
532	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:37.85804	t	Edge 136.0.0	0	\N
533	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:45.181219	t	Edge 136.0.0	0	\N
534	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:45:27.569242	t	Edge 136.0.0	0	\N
535	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:48:40.95709	t	Edge 136.0.0	0	\N
536	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-20 13:50:10.200513	t	Edge 136.0.0	0	\N
537	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 14:53:05.260632	t	Edge 136.0.0	0	\N
538	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 14:53:18.531544	t	Edge 136.0.0	0	\N
539	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 15:07:23.523144	t	Edge 136.0.0	0	\N
540	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 15:10:04.60218	t	Edge 136.0.0	0	\N
541	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 15:13:27.46226	t	Edge 136.0.0	0	\N
542	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 16:10:57.825514	t	Edge 136.0.0	0	\N
543	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-21 12:40:58.996525	t	Opera 118.0.0	0	\N
544	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 12:42:02.782938	t	Edge 136.0.0	0	\N
545	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-21 12:45:13.915909	t	Opera 118.0.0	0	\N
546	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:05:07.567163	t	Edge 136.0.0	0	\N
547	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:25:44.131095	t	Edge 136.0.0	0	\N
548	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:27:10.12834	t	Edge 136.0.0	0	\N
549	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:45:37.580077	t	Edge 136.0.0	0	\N
550	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:49:20.736577	t	Edge 136.0.0	0	\N
551	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:50:49.908914	t	Edge 136.0.0	0	\N
552	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 13:51:34.740678	t	Edge 136.0.0	0	\N
553	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:18:29.820501	t	Edge 136.0.0	0	\N
554	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:23:25.142827	t	Edge 136.0.0	0	\N
555	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:25:42.462978	t	Edge 136.0.0	0	\N
556	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:32:03.722293	t	Edge 136.0.0	0	\N
557	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:42:23.605246	t	Edge 136.0.0	0	\N
558	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:46:42.944273	t	Edge 136.0.0	0	\N
559	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:52:18.267507	t	Edge 136.0.0	0	\N
560	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 14:58:44.870969	t	Edge 136.0.0	0	\N
561	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-21 14:59:50.072601	t	Edge 136.0.0	0	\N
562	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:06:11.569988	t	Edge 136.0.0	0	\N
563	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-21 15:06:25.058841	t	Edge 136.0.0	0	\N
564	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:27:43.747762	t	Edge 136.0.0	0	\N
565	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:29:33.243407	t	Edge 136.0.0	0	\N
566	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:34:03.413686	t	Edge 136.0.0	0	\N
567	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:41:15.543975	t	Edge 136.0.0	0	\N
568	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-21 15:42:18.094525	t	Edge 136.0.0	0	\N
570	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:43:09.757697	t	Edge 136.0.0	0	\N
571	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:43:45.543782	t	Edge 136.0.0	0	\N
572	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:44:21.581168	t	Edge 136.0.0	0	\N
573	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:54:32.804997	t	Edge 136.0.0	0	\N
574	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:13:11.891488	t	Edge 136.0.0	0	\N
575	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:20:38.214417	t	Edge 136.0.0	0	\N
576	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:32:27.888181	t	Edge 136.0.0	0	\N
577	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:33:54.08234	t	Edge 136.0.0	0	\N
578	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:34:32.650381	t	Edge 136.0.0	0	\N
579	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 16:36:57.371304	t	Edge 136.0.0	0	\N
580	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:19:19.943903	t	Edge 136.0.0	0	\N
581	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:25:46.798487	t	Edge 136.0.0	0	\N
582	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:26:32.628381	t	Edge 136.0.0	0	\N
583	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:26:48.477152	t	Edge 136.0.0	0	\N
584	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:27:26.806995	t	Edge 136.0.0	0	\N
585	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:28:44.232552	t	Edge 136.0.0	0	\N
586	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:29:19.878878	t	Edge 136.0.0	0	\N
587	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:37:40.258224	t	Edge 136.0.0	0	\N
588	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:41:02.466692	t	Edge 136.0.0	0	\N
589	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:45:32.394396	t	Edge 136.0.0	0	\N
590	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:47:03.098478	t	Edge 136.0.0	0	\N
591	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:48:40.683374	t	Edge 136.0.0	0	\N
592	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 17:56:03.460551	t	Edge 136.0.0	0	\N
593	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:05:26.360454	t	Edge 136.0.0	0	\N
594	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:09:17.057596	t	Edge 136.0.0	0	\N
595	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:14:16.33136	t	Edge 136.0.0	0	\N
596	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:18:25.942269	t	Edge 136.0.0	0	\N
597	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:20:33.766064	t	Edge 136.0.0	0	\N
598	21	yuyus@gmail.com	127.0.0.1	2025-05-21 18:21:06.012308	t	Edge 136.0.0	0	\N
599	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 18:33:47.351555	t	Edge 136.0.0	0	\N
600	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 11:51:00.242285	t	Edge 136.0.0	0	\N
601	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 16:15:01.055633	t	Edge 136.0.0	0	\N
602	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 16:16:59.521568	t	Edge 136.0.0	0	\N
603	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-22 17:39:16.286135	t	Edge 136.0.0	0	\N
604	21	yuyus@gmail.com	127.0.0.1	2025-05-22 17:39:56.498987	t	Edge 136.0.0	0	\N
605	21	yuyus@gmail.com	127.0.0.1	2025-05-22 17:49:08.051216	t	Edge 136.0.0	0	\N
606	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 20:54:35.061425	t	Edge 136.0.0	0	\N
607	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 20:55:30.346613	t	Edge 136.0.0	0	\N
608	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 21:04:35.970125	t	Edge 136.0.0	0	\N
609	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 21:19:47.388874	t	Edge 136.0.0	0	\N
610	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 21:20:19.117405	t	Edge 136.0.0	0	\N
611	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 22:03:30.659238	t	Edge 136.0.0	0	\N
612	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 22:03:43.540465	t	Edge 136.0.0	0	\N
613	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 22:09:58.196524	t	Edge 136.0.0	0	\N
614	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-22 22:10:12.861012	t	Edge 136.0.0	0	\N
615	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-22 22:10:43.539198	t	Edge 136.0.0	0	\N
616	\N	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 06:51:57.478757	f	Opera 118.0.0	1	\N
636	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 10:47:47.865474	t	Chrome 136.0.0	0	\N
617	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 07:25:14.046658	f	Opera 118.0.0	3	\N
618	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:25:56.414688	t	Opera 118.0.0	0	\N
619	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:28:40.562983	t	Opera 118.0.0	0	\N
620	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-23 07:31:25.468702	t	Opera 118.0.0	0	\N
621	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 07:33:38.126571	t	Opera 118.0.0	0	\N
622	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:35:17.483217	t	Opera 118.0.0	0	\N
623	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 07:56:48.259554	t	Opera 118.0.0	0	\N
624	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 08:07:59.126201	t	Opera 118.0.0	0	\N
625	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:08:21.071065	t	Opera 118.0.0	0	\N
626	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:12:54.549214	t	Opera 118.0.0	0	\N
627	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:20:34.390533	t	Opera 118.0.0	0	\N
628	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-23 08:33:10.844545	t	Opera 118.0.0	0	\N
637	\N	yuyus@gmail.com	127.0.0.1	2025-05-23 10:51:24.381794	f	Edge 136.0.0	2	\N
638	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:51:38.363652	t	Edge 136.0.0	0	\N
629	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:30:27.507701	f	Edge 136.0.0	5	2025-05-23 10:35:53.158504
630	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 10:31:27.136595	t	Chrome 136.0.0	0	\N
631	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:35:59.889201	t	Chrome 136.0.0	0	\N
632	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:39:47.329061	t	Edge 136.0.0	0	\N
633	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:40:37.965096	t	Edge 136.0.0	0	\N
634	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:44:24.762037	t	Edge 136.0.0	0	\N
635	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:46:41.117435	t	Edge 136.0.0	0	\N
639	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:52:05.584535	t	Chrome 136.0.0	0	\N
640	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:55:18.941214	t	Edge 136.0.0	0	\N
641	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:55:47.815169	t	Chrome 136.0.0	0	\N
642	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:00:17.63766	t	Edge 136.0.0	0	\N
643	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:06:15.533358	t	Edge 136.0.0	0	\N
644	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:06:54.733261	t	Chrome 136.0.0	0	\N
645	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:12:16.028687	t	Edge 136.0.0	0	\N
646	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:15:41.387979	t	Edge 136.0.0	0	\N
647	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:16:14.120105	t	Chrome 136.0.0	0	\N
648	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:17:02.908076	t	Chrome 136.0.0	0	\N
649	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:17:39.367302	t	Chrome 136.0.0	0	\N
650	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:18:59.107738	t	Chrome 136.0.0	0	\N
651	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:19:25.709286	t	Chrome 136.0.0	0	\N
652	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:30:39.697751	t	Edge 136.0.0	0	\N
653	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:31:02.41007	t	Chrome 136.0.0	0	\N
654	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:31:57.699808	t	Edge 136.0.0	0	\N
655	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:32:31.062794	t	Chrome 136.0.0	0	\N
656	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:38:29.497034	t	Chrome 136.0.0	0	\N
657	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:38:30.341271	t	Chrome 136.0.0	0	\N
658	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:38:31.058401	t	Chrome 136.0.0	0	\N
659	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:38:31.903983	t	Chrome 136.0.0	0	\N
660	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:39:15.046757	t	Edge 136.0.0	0	\N
661	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:41:22.452881	t	Edge 136.0.0	0	\N
662	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:43:03.447146	t	Edge 136.0.0	0	\N
663	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:43:51.27831	t	Chrome 136.0.0	0	\N
664	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:45:50.925977	t	Edge 136.0.0	0	\N
665	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:47:28.579786	t	Chrome 136.0.0	0	\N
666	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:48:30.046106	t	Edge 136.0.0	0	\N
667	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 11:49:29.466736	t	Edge 136.0.0	0	\N
668	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:51:01.165474	t	Edge 136.0.0	0	\N
669	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:11:19.808592	t	Edge 136.0.0	0	\N
670	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:20:13.61503	t	Edge 136.0.0	0	\N
671	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:20:39.270164	t	Edge 136.0.0	0	\N
672	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:21:39.859166	t	Edge 136.0.0	0	\N
673	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:22:48.820418	t	Chrome 136.0.0	0	\N
674	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:26:24.700168	t	Edge 136.0.0	0	\N
675	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:27:24.354843	t	Chrome 136.0.0	0	\N
676	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:45:55.486389	t	Edge 136.0.0	0	\N
677	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:50:54.201645	t	Edge 136.0.0	0	\N
678	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 12:51:54.12274	t	Opera 118.0.0	0	\N
679	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 12:52:09.528779	t	Opera 118.0.0	0	\N
680	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:53:18.788207	t	Edge 136.0.0	0	\N
681	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:55:03.733932	t	Edge 136.0.0	0	\N
682	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:55:52.358747	t	Chrome 136.0.0	0	\N
683	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:55:53.922203	t	Chrome 136.0.0	0	\N
684	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:58:12.926403	t	Edge 136.0.0	0	\N
685	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 12:59:30.587071	t	Edge 136.0.0	0	\N
686	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:02:04.03328	t	Edge 136.0.0	0	\N
687	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:06:34.482546	t	Edge 136.0.0	0	\N
688	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:17:01.362778	t	Edge 136.0.0	0	\N
697	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:46:01.091363	t	Edge 136.0.0	0	\N
698	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:55:53.985712	t	Edge 136.0.0	0	\N
699	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:56:42.963222	t	Edge 136.0.0	0	\N
700	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:58:40.281529	t	Edge 136.0.0	0	\N
689	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:19:08.622385	t	Edge 136.0.0	5	2025-05-23 08:24:54.327272
701	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 14:00:59.550416	t	Edge 136.0.0	0	\N
702	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 14:01:30.149378	t	Edge 136.0.0	0	\N
703	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 14:09:16.125282	t	Edge 136.0.0	0	\N
704	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 15:07:14.750789	t	Edge 136.0.0	0	\N
690	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:27:19.232396	t	Edge 136.0.0	5	2025-05-23 13:34:01.912401
691	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:36:21.559966	t	Edge 136.0.0	0	\N
705	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 15:07:18.552638	t	Opera 118.0.0	0	\N
706	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 15:25:08.915663	t	Opera 118.0.0	0	\N
707	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 15:34:24.691297	t	Opera 118.0.0	0	\N
692	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:36:50.520263	f	Edge 136.0.0	6	2025-05-23 13:42:08.823226
693	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:42:56.326054	t	Edge 136.0.0	0	\N
694	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:44:18.790006	t	Chrome 136.0.0	0	\N
695	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 13:44:55.667454	t	Edge 136.0.0	0	\N
696	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:45:44.904513	t	Chrome 136.0.0	0	\N
708	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 15:43:21.41437	f	Edge 136.0.0	2	\N
709	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-23 15:59:08.620379	t	Opera 118.0.0	0	\N
710	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 15:59:38.17017	t	Opera 118.0.0	0	\N
711	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-23 15:59:56.977783	f	Opera 118.0.0	1	\N
712	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-23 16:00:03.148436	t	Opera 118.0.0	0	\N
713	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-23 16:07:31.387163	t	Opera 118.0.0	0	\N
714	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 16:07:42.847673	t	Opera 118.0.0	0	\N
715	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:16:10.852762	f	Edge 136.0.0	3	\N
716	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:18:23.975151	t	Edge 136.0.0	5	2025-05-23 16:23:57.657338
778	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:31:35.687232	t	Edge 136.0.0	0	\N
779	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:35:06.815082	t	Edge 136.0.0	0	\N
780	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:37:21.659255	t	Edge 136.0.0	0	\N
717	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 16:22:38.408792	t	Edge 136.0.0	5	2025-05-23 16:28:06.155077
718	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:25:53.141023	t	Edge 136.0.0	0	\N
719	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:26:00.444741	t	Edge 136.0.0	0	\N
720	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:26:48.058952	t	Chrome 136.0.0	0	\N
721	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 16:28:47.848756	t	Edge 136.0.0	0	\N
722	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:29:25.621799	t	Edge 136.0.0	0	\N
723	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-23 16:48:41.223834	t	Edge 136.0.0	0	\N
724	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:49:17.461576	t	Edge 136.0.0	0	\N
725	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-23 16:49:49.147567	t	Edge 136.0.0	0	\N
726	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 17:21:35.392127	t	Edge 136.0.0	0	\N
727	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 17:22:16.897633	t	Edge 136.0.0	0	\N
728	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 17:35:46.798019	t	Edge 136.0.0	0	\N
730	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 17:51:54.983072	t	Edge 136.0.0	0	\N
735	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 20:03:22.600146	t	Edge 136.0.0	0	\N
738	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 20:09:28.144092	t	Edge 136.0.0	0	\N
740	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 20:31:17.672632	t	Edge 136.0.0	0	\N
741	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 03:41:44.724007	f	Edge 136.0.0	1	\N
742	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 03:42:00.359444	t	Edge 136.0.0	0	\N
743	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-24 03:43:45.8816	t	Edge 136.0.0	0	\N
744	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 04:04:10.971918	t	Edge 136.0.0	0	\N
745	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 04:04:11.95476	t	Edge 136.0.0	0	\N
746	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 04:04:13.624825	t	Edge 136.0.0	0	\N
747	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 04:04:15.116385	t	Edge 136.0.0	0	\N
748	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 05:00:09.446724	t	Edge 136.0.0	0	\N
749	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-24 05:07:48.619449	t	Edge 136.0.0	0	\N
751	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-24 06:57:31.705883	t	Edge 136.0.0	0	\N
752	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-24 07:41:22.238636	t	Edge 136.0.0	0	\N
753	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-24 08:17:03.310381	t	Edge 136.0.0	0	\N
756	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 13:09:08.823268	t	Opera 118.0.0	0	\N
757	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-24 13:27:22.53529	t	Opera 118.0.0	0	\N
758	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 13:48:14.416208	t	Opera 118.0.0	0	\N
759	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-24 13:48:37.676031	t	Opera 118.0.0	0	\N
760	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-24 14:23:23.643375	t	Opera 118.0.0	0	\N
761	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-24 15:40:40.438422	t	Opera 118.0.0	0	\N
762	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 15:41:35.963317	t	Opera 118.0.0	0	\N
763	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-24 15:42:39.889344	t	Opera 118.0.0	0	\N
764	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 15:52:57.616738	t	Opera 118.0.0	0	\N
766	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-24 15:57:24.68412	t	Opera 118.0.0	0	\N
767	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 17:17:41.553474	t	Opera 118.0.0	0	\N
768	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-24 23:03:13.301139	t	Edge 136.0.0	0	\N
769	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-24 23:04:38.027274	t	Edge 136.0.0	0	\N
770	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 03:22:41.104392	t	Edge 136.0.0	0	\N
771	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 03:22:43.880474	t	Edge 136.0.0	0	\N
772	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 03:22:45.949158	t	Edge 136.0.0	0	\N
773	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 03:22:47.067313	t	Edge 136.0.0	0	\N
774	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 03:22:49.352282	t	Edge 136.0.0	0	\N
775	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 18:08:45.907176	t	Edge 136.0.0	0	\N
776	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:20:15.634468	t	Edge 136.0.0	0	\N
777	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:31:34.872595	t	Edge 136.0.0	0	\N
781	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:44:52.508696	t	Edge 136.0.0	0	\N
782	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:44:53.363142	t	Edge 136.0.0	0	\N
783	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 20:21:44.509351	t	Edge 136.0.0	0	\N
784	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 20:41:48.428441	t	Edge 136.0.0	0	\N
785	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 20:52:24.252479	t	Edge 136.0.0	0	\N
786	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 20:56:02.403406	t	Edge 136.0.0	0	\N
787	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 21:05:06.932708	t	Edge 136.0.0	0	\N
788	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-25 21:06:33.990727	t	Edge 136.0.0	0	\N
789	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 21:07:44.025531	t	Edge 136.0.0	0	\N
790	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 21:13:35.381854	t	Edge 136.0.0	0	\N
791	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 21:21:11.193767	t	Edge 136.0.0	0	\N
792	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 13:26:56.237228	t	Edge 136.0.0	0	\N
793	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 13:26:58.637017	t	Edge 136.0.0	0	\N
794	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 13:28:57.628563	t	Edge 136.0.0	0	\N
796	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 13:37:00.926869	t	Edge 136.0.0	0	\N
797	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-26 13:38:19.72355	t	Edge 136.0.0	0	\N
798	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:07:18.015998	t	Edge 136.0.0	0	\N
799	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:22:24.312062	t	Edge 136.0.0	0	\N
800	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-26 17:24:56.243182	f	Edge 136.0.0	1	\N
801	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-26 17:25:33.772051	t	Edge 136.0.0	0	\N
802	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:33:01.483271	t	Edge 136.0.0	0	\N
803	26	juminten@gmail.com	127.0.0.1	2025-05-26 17:39:14.807175	t	Edge 136.0.0	1	\N
804	26	juminten@gmail.com	127.0.0.1	2025-05-26 17:41:22.107856	t	Edge 136.0.0	0	\N
850	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-27 12:20:24.922114	t	Edge 136.0.0	0	\N
851	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-27 13:03:02.233685	t	Edge 136.0.0	0	\N
852	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 13:27:15.405216	f	Edge 136.0.0	0	\N
853	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 13:27:41.551666	t	Edge 136.0.0	0	\N
805	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:41:52.473426	t	Edge 136.0.0	5	2025-05-26 17:47:28.404062
806	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 19:34:35.687014	t	Edge 136.0.0	0	\N
807	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 19:34:40.025223	t	Edge 136.0.0	0	\N
808	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 19:43:08.228577	t	Edge 136.0.0	0	\N
809	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 20:03:19.172351	t	Edge 136.0.0	0	\N
810	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 20:04:03.008814	t	Edge 136.0.0	0	\N
811	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 20:08:52.070678	t	Edge 136.0.0	0	\N
812	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-26 23:00:47.686361	t	Edge 136.0.0	0	\N
813	\N	nabilalb0109	127.0.0.1	2025-05-26 23:06:13.757171	f	Edge 136.0.0	1	\N
814	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-26 23:06:18.334471	t	Edge 136.0.0	0	\N
815	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-26 23:07:52.390886	t	Edge 136.0.0	0	\N
816	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-26 23:08:17.034493	t	Edge 136.0.0	0	\N
817	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 00:42:26.470338	f	Edge 136.0.0	0	\N
818	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 00:42:51.412744	t	Edge 136.0.0	0	\N
819	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 01:32:55.128287	f	Edge 136.0.0	0	\N
820	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 01:33:31.026835	t	Edge 136.0.0	0	\N
821	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-27 01:42:02.791295	f	Edge 136.0.0	0	\N
822	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-27 01:42:23.081616	t	Edge 136.0.0	0	\N
823	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 01:43:13.683127	f	Edge 136.0.0	0	\N
824	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 01:43:37.667	t	Edge 136.0.0	0	\N
825	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 01:59:46.726431	f	Opera 119.0.0	0	\N
826	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 02:00:08.616124	t	Opera 119.0.0	0	\N
827	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 02:02:09.192137	f	Opera 119.0.0	0	\N
828	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 02:02:26.16425	t	Opera 119.0.0	0	\N
829	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 02:03:08.763806	f	Edge 136.0.0	0	\N
830	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 02:03:24.827173	t	Edge 136.0.0	0	\N
831	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:12:41.825594	f	Edge 136.0.0	0	\N
832	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:13:15.609827	t	Edge 136.0.0	0	\N
833	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:13:28.37483	f	Edge 136.0.0	0	\N
834	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:13:46.104375	t	Edge 136.0.0	0	\N
835	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:14:39.907645	f	Edge 136.0.0	0	\N
836	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:14:57.076214	t	Edge 136.0.0	0	\N
837	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-27 02:15:16.653563	f	Edge 136.0.0	0	\N
838	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-27 02:15:24.282005	f	Edge 136.0.0	0	\N
839	15	gwenrosevyn@gmail.com	127.0.0.1	2025-05-27 02:15:50.793774	t	Edge 136.0.0	0	\N
840	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:24:13.695674	f	Edge 136.0.0	0	\N
841	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 02:24:29.605856	t	Edge 136.0.0	0	\N
842	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:45:59.942473	f	Edge 136.0.0	0	\N
843	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:46:18.668186	t	Edge 136.0.0	0	\N
844	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 03:22:32.328656	f	Edge 136.0.0	0	\N
845	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 03:22:55.68981	t	Edge 136.0.0	0	\N
846	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-27 11:27:46.143983	t	Edge 136.0.0	0	\N
854	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 18:05:43.930565	f	Edge 136.0.0	0	\N
855	\N	adelaideufrasia	127.0.0.1	2025-05-27 18:07:52.821944	f	Edge 136.0.0	2	\N
847	\N	abid@gmail.com	127.0.0.1	2025-05-27 11:49:40.012194	f	Edge 136.0.0	5	2025-05-27 11:54:52.326276
848	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-27 11:50:45.757627	f	Edge 136.0.0	1	\N
849	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-27 12:19:59.128278	t	Edge 136.0.0	0	\N
856	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 18:08:21.271941	f	Edge 136.0.0	0	\N
857	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-27 18:08:49.600359	t	Edge 136.0.0	0	\N
858	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 18:14:14.584038	f	Edge 136.0.0	0	\N
859	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 18:14:29.912831	t	Edge 136.0.0	0	\N
860	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:05:52.427152	f	Edge 136.0.0	0	\N
861	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:06:06.380659	t	Edge 136.0.0	0	\N
862	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:10:13.856262	f	Edge 136.0.0	0	\N
863	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:10:51.547788	t	Edge 136.0.0	0	\N
864	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 20:13:35.243637	f	Edge 136.0.0	0	\N
865	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 20:13:54.649519	t	Edge 136.0.0	0	\N
866	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 20:34:18.534245	f	Edge 136.0.0	0	\N
867	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 20:34:42.645601	t	Edge 136.0.0	0	\N
868	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:41:13.101509	f	Edge 136.0.0	0	\N
869	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:41:31.898424	t	Edge 136.0.0	0	\N
870	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:52:40.932997	f	Edge 136.0.0	0	\N
871	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 20:52:54.24996	t	Edge 136.0.0	0	\N
872	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 21:24:43.442728	f	Edge 136.0.0	0	\N
873	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 21:24:59.547551	t	Edge 136.0.0	0	\N
874	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-27 21:42:30.48	f	Edge 136.0.0	0	\N
875	1	nabilalb2004@gmail.com	127.0.0.1	2025-05-27 21:43:13.845633	t	Edge 136.0.0	0	\N
876	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 21:46:46.671143	f	Edge 136.0.0	0	\N
877	17	nabilalb0109@gmail.com	127.0.0.1	2025-05-27 21:47:16.726906	t	Edge 136.0.0	0	\N
878	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 23:29:28.81662	f	Edge 136.0.0	0	\N
879	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 23:29:42.963191	t	Edge 136.0.0	0	\N
880	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 01:54:28.743756	f	Edge 136.0.0	0	\N
881	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 01:55:21.00325	t	Edge 136.0.0	0	\N
882	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 01:57:06.02174	f	Edge 136.0.0	0	\N
883	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 01:57:23.197978	t	Edge 136.0.0	0	\N
884	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-28 02:04:37.794907	f	Edge 136.0.0	0	\N
885	19	adelaideufrasia@gmail.com	127.0.0.1	2025-05-28 02:05:12.994327	t	Edge 136.0.0	0	\N
886	\N	nabila.libasutaqwa@student.ac.id	127.0.0.1	2025-05-28 02:07:50.056107	f	Edge 136.0.0	2	\N
887	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 02:09:12.948134	f	Edge 136.0.0	0	\N
888	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 02:09:26.881432	t	Edge 136.0.0	0	\N
889	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-28 03:10:44.038733	f	Opera 119.0.0	0	\N
890	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-28 03:11:08.104932	t	Opera 119.0.0	0	\N
891	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-05-28 03:19:38.066355	f	Opera 119.0.0	0	\N
892	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-05-28 03:20:03.934513	t	Opera 119.0.0	0	\N
893	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-28 03:20:25.053532	f	Opera 119.0.0	0	\N
894	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-28 03:24:16.64775	t	Opera 119.0.0	0	\N
895	7	maureengabriella1m@gmail.com	127.0.0.1	2025-05-29 14:12:19.371825	t	Edge 136.0.0	0	\N
896	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-29 15:06:21.250954	t	Edge 136.0.0	0	\N
898	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-29 15:51:15.016097	t	Edge 136.0.0	0	\N
899	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:03:17.557134	f	Opera 119.0.0	0	\N
900	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:03:36.8388	t	Opera 119.0.0	0	\N
901	19	adelaideufrasia@gmail.com	127.0.0.1	2025-06-07 08:07:15.390857	f	Opera 119.0.0	0	\N
902	19	adelaideufrasia@gmail.com	127.0.0.1	2025-06-07 08:07:32.362801	t	Opera 119.0.0	0	\N
903	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:08:11.263868	f	Opera 119.0.0	0	\N
904	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:08:27.729971	t	Opera 119.0.0	0	\N
905	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 08:08:45.147649	f	Opera 119.0.0	0	\N
906	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 08:09:02.484656	t	Opera 119.0.0	0	\N
907	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:11:14.054834	f	Opera 119.0.0	0	\N
908	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:11:30.77531	t	Opera 119.0.0	0	\N
909	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-07 08:12:10.100434	f	Opera 119.0.0	0	\N
910	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-07 08:12:36.541663	t	Opera 119.0.0	0	\N
911	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:34:10.384877	f	Opera 119.0.0	0	\N
912	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:34:35.014639	t	Opera 119.0.0	0	\N
913	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:36:27.788643	f	Opera 119.0.0	0	\N
914	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:36:37.413588	f	Opera 119.0.0	0	\N
915	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:36:54.52802	t	Opera 119.0.0	0	\N
916	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:37:34.311557	f	Opera 119.0.0	0	\N
917	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:37:50.296805	t	Opera 119.0.0	0	\N
918	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 12:43:53.238043	f	Opera 119.0.0	0	\N
919	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 12:44:13.527814	t	Opera 119.0.0	0	\N
920	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 15:34:19.9368	f	Opera 119.0.0	0	\N
921	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 15:34:38.25315	t	Opera 119.0.0	0	\N
922	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:35:23.172499	f	Opera 119.0.0	0	\N
923	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:35:40.441868	t	Opera 119.0.0	0	\N
924	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:42:54.608285	f	Opera 119.0.0	0	\N
925	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 15:43:03.426735	f	Opera 119.0.0	0	\N
926	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:43:19.567206	t	Opera 119.0.0	0	\N
927	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-07 15:43:28.790476	t	Opera 119.0.0	0	\N
928	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:44:14.83308	f	Opera 119.0.0	0	\N
929	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 15:44:38.498272	t	Opera 119.0.0	0	\N
930	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 16:04:03.756369	f	Opera 119.0.0	0	\N
931	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 16:04:20.883822	t	Opera 119.0.0	0	\N
932	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-08 12:22:53.180392	f	Edge 137.0.0	0	\N
933	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-08 12:23:15.654415	t	Edge 137.0.0	0	\N
934	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-08 12:26:34.479427	f	Edge 137.0.0	0	\N
935	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-08 12:26:40.821646	f	Edge 137.0.0	0	\N
936	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-08 12:27:04.996125	t	Edge 137.0.0	0	\N
937	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 10:58:37.561939	f	Opera 119.0.0	0	\N
938	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 10:58:53.71649	t	Opera 119.0.0	0	\N
939	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:02:51.110471	f	Opera 119.0.0	0	\N
940	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:03:02.697066	f	Opera 119.0.0	0	\N
941	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:03:18.459354	t	Opera 119.0.0	0	\N
942	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:07:06.776224	f	Opera 119.0.0	0	\N
943	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:07:33.281345	t	Opera 119.0.0	0	\N
944	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:08:06.978432	f	Opera 119.0.0	0	\N
945	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:08:14.577015	f	Opera 119.0.0	0	\N
946	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:08:31.855883	t	Opera 119.0.0	0	\N
947	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:08:46.558521	f	Opera 119.0.0	0	\N
948	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:09:02.185969	t	Opera 119.0.0	0	\N
949	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:10:01.407403	f	Chrome Mobile 134.0.0	0	\N
950	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:10:20.937055	t	Chrome Mobile 134.0.0	0	\N
951	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:16:06.375232	f	Opera 119.0.0	0	\N
952	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:16:22.668582	t	Opera 119.0.0	0	\N
953	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:17:01.008469	f	Opera 119.0.0	0	\N
954	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:17:08.588665	f	Opera 119.0.0	0	\N
955	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:17:29.194866	t	Opera 119.0.0	0	\N
956	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:18:05.292307	t	Opera 119.0.0	0	\N
957	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:19:23.996477	f	Opera 119.0.0	0	\N
958	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:19:38.921295	t	Opera 119.0.0	0	\N
959	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:21:11.171391	f	Opera 119.0.0	0	\N
960	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 11:21:30.705433	t	Opera 119.0.0	0	\N
961	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:23:16.830297	f	Opera 119.0.0	0	\N
962	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:23:35.050509	t	Opera 119.0.0	0	\N
963	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:25:46.605493	f	Opera 119.0.0	0	\N
964	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 11:26:03.005171	t	Opera 119.0.0	0	\N
965	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:02:39.81041	f	Opera 119.0.0	0	\N
966	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:05:03.698704	f	Opera 119.0.0	0	\N
967	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:05:23.211124	t	Opera 119.0.0	0	\N
968	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:06:32.62103	f	Opera 119.0.0	0	\N
969	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:06:48.959616	t	Opera 119.0.0	0	\N
970	4	yustina.yunita@student.president.ac.id	127.0.0.1	2025-06-10 12:09:09.73474	f	Opera 119.0.0	0	\N
971	4	yustina.yunita@student.president.ac.id	127.0.0.1	2025-06-10 12:09:28.716873	t	Opera 119.0.0	0	\N
972	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:21:43.428992	f	Opera 119.0.0	0	\N
973	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:22:00.124815	t	Opera 119.0.0	0	\N
974	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:24:46.548056	f	Opera 119.0.0	0	\N
975	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:25:03.716934	t	Opera 119.0.0	0	\N
976	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:28:51.675045	f	Opera 119.0.0	0	\N
977	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:29:07.227393	t	Opera 119.0.0	0	\N
978	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:54:06.151487	f	Opera 119.0.0	0	\N
979	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 12:54:13.929422	f	Opera 119.0.0	0	\N
980	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 12:54:22.061926	f	Opera 119.0.0	0	\N
981	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-10 12:54:40.165503	t	Opera 119.0.0	0	\N
982	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 13:01:24.481067	f	Opera 119.0.0	0	\N
983	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-10 13:08:57.608476	t	Opera 119.0.0	0	\N
984	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 02:52:20.452282	f	Opera 119.0.0	0	\N
985	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 02:54:01.065445	t	Opera 119.0.0	0	\N
986	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 04:47:35.412702	f	Opera 119.0.0	0	\N
987	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 04:47:59.947221	t	Opera 119.0.0	0	\N
988	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 05:11:42.458272	f	Chrome Mobile 134.0.0	0	\N
989	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 05:12:00.413799	t	Chrome Mobile 134.0.0	0	\N
990	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:06:22.347593	f	Opera 119.0.0	0	\N
991	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:06:41.30491	t	Opera 119.0.0	0	\N
992	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-11 12:16:25.33484	f	Opera 119.0.0	0	\N
993	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-11 12:16:40.509358	t	Opera 119.0.0	0	\N
994	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:41:30.897051	f	Opera 119.0.0	0	\N
995	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:41:48.37802	t	Opera 119.0.0	0	\N
996	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:45:03.82586	f	Opera 119.0.0	0	\N
997	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:45:11.798538	f	Opera 119.0.0	0	\N
998	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 12:45:30.677294	t	Opera 119.0.0	0	\N
999	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 13:08:31.371192	f	Opera 119.0.0	0	\N
1000	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 13:17:34.882113	f	Opera 119.0.0	0	\N
1001	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 13:17:52.228595	t	Opera 119.0.0	0	\N
1002	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 13:44:10.091862	f	Opera 119.0.0	0	\N
1003	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 13:44:37.52945	t	Opera 119.0.0	0	\N
1004	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 14:19:34.71288	f	Opera 119.0.0	0	\N
1005	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 14:20:06.092512	t	Opera 119.0.0	0	\N
1006	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 15:15:07.734318	f	Opera 119.0.0	0	\N
1007	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-11 15:15:25.181153	t	Opera 119.0.0	0	\N
1008	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 15:24:04.439962	f	Opera 119.0.0	0	\N
1009	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-11 15:25:10.679893	t	Opera 119.0.0	0	\N
1010	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-11 15:37:19.620237	f	Opera 119.0.0	0	\N
1011	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-11 15:37:35.992543	t	Opera 119.0.0	0	\N
1012	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 08:52:08.448687	f	Opera 119.0.0	0	\N
1013	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 08:52:58.765721	t	Opera 119.0.0	0	\N
1014	17	nabilalb0109@gmail.com	127.0.0.1	2025-06-13 15:08:28.583874	f	Edge 137.0.0	0	\N
1015	17	nabilalb0109@gmail.com	127.0.0.1	2025-06-13 15:08:55.389995	t	Edge 137.0.0	0	\N
1016	17	nabilalb0109@gmail.com	127.0.0.1	2025-06-13 15:09:30.194551	f	Edge 137.0.0	0	\N
1017	17	nabilalb0109@gmail.com	127.0.0.1	2025-06-13 15:09:52.996136	t	Edge 137.0.0	0	\N
1018	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-13 15:13:33.307358	f	Edge 137.0.0	0	\N
1019	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-13 15:13:51.702552	t	Edge 137.0.0	0	\N
1020	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 16:01:00.490523	f	Opera 119.0.0	0	\N
1021	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 16:01:21.464003	t	Opera 119.0.0	0	\N
1022	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 16:33:37.09789	f	Opera 119.0.0	0	\N
1023	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 16:34:35.930536	f	Opera 119.0.0	0	\N
1024	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-13 16:34:51.11512	t	Opera 119.0.0	0	\N
1025	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-14 16:15:35.697871	f	Opera 119.0.0	0	\N
1026	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-14 16:15:51.591136	t	Opera 119.0.0	0	\N
1027	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-14 16:30:12.72484	f	Opera 119.0.0	0	\N
1028	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-14 16:30:31.047323	t	Opera 119.0.0	0	\N
1029	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-14 17:00:32.714716	f	Opera 119.0.0	0	\N
1030	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-14 17:02:01.492258	f	Opera 119.0.0	0	\N
1031	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-14 17:02:17.301612	t	Opera 119.0.0	0	\N
1032	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-14 17:02:28.217084	f	Opera 119.0.0	0	\N
1033	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-14 17:03:04.66997	f	Opera 119.0.0	0	\N
1034	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-14 17:03:13.389241	f	Opera 119.0.0	0	\N
1035	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-14 17:03:39.736131	t	Opera 119.0.0	0	\N
1036	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-17 07:30:17.358557	f	Opera 119.0.0	0	\N
1037	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-17 07:30:33.775242	t	Opera 119.0.0	0	\N
1038	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-17 07:31:20.644209	f	Opera 119.0.0	0	\N
1039	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-17 07:31:35.848755	t	Opera 119.0.0	0	\N
1040	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 07:32:44.738329	f	Opera 119.0.0	0	\N
1041	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 07:33:00.865121	t	Opera 119.0.0	0	\N
1042	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 12:59:22.270387	f	Opera 119.0.0	0	\N
1043	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 12:59:48.152194	t	Opera 119.0.0	0	\N
1044	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:00:08.329877	f	Edge 137.0.0	1	\N
1045	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:00:21.071874	f	Edge 137.0.0	0	\N
1046	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:00:29.515822	f	Edge 137.0.0	0	\N
1047	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:00:37.49772	f	Edge 137.0.0	0	\N
1048	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:02:10.29093	f	Edge 137.0.0	0	\N
1049	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:03:46.788439	f	Edge 137.0.0	0	\N
1050	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 13:04:15.035945	t	Edge 137.0.0	0	\N
1051	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:00:24.645901	f	Edge 137.0.0	0	\N
1052	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:01:29.755348	t	Edge 137.0.0	0	\N
1053	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:03:13.410192	f	Edge 137.0.0	0	\N
1054	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:03:45.181858	t	Edge 137.0.0	0	\N
1055	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 14:15:52.75957	f	Opera 119.0.0	0	\N
1056	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-17 14:16:15.094082	t	Opera 119.0.0	0	\N
1057	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:35:41.112576	f	Edge 137.0.0	0	\N
1058	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:35:51.279983	f	Edge 137.0.0	0	\N
1059	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:36:32.651062	t	Edge 137.0.0	0	\N
1060	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:37:53.281319	f	Edge 137.0.0	0	\N
1061	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:38:20.780855	t	Edge 137.0.0	0	\N
1062	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:50:33.091448	f	Edge 137.0.0	0	\N
1063	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:51:05.190922	t	Edge 137.0.0	0	\N
1064	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 14:59:51.691662	f	Edge 137.0.0	0	\N
1065	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 15:00:19.385788	t	Edge 137.0.0	0	\N
1066	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 19:49:45.566323	f	Edge 137.0.0	0	\N
1067	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 19:50:23.400754	t	Edge 137.0.0	0	\N
1068	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 19:51:30.216081	f	Edge 137.0.0	0	\N
1069	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 19:52:05.255055	t	Edge 137.0.0	0	\N
1070	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:03:43.150756	f	Edge 137.0.0	0	\N
1071	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:04:08.130368	t	Edge 137.0.0	0	\N
1072	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:17:57.942713	f	Edge 137.0.0	0	\N
1073	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:18:17.235447	t	Edge 137.0.0	0	\N
1074	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:21:30.330698	f	Edge 137.0.0	0	\N
1075	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:21:51.82118	t	Edge 137.0.0	0	\N
1076	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:25:13.297445	f	Edge 137.0.0	0	\N
1077	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:25:20.71516	f	Edge 137.0.0	0	\N
1078	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:25:45.870732	t	Edge 137.0.0	0	\N
1079	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:41:36.82981	f	Edge 137.0.0	0	\N
1080	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:41:56.50689	t	Edge 137.0.0	0	\N
1081	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:47:14.035405	f	Edge 137.0.0	0	\N
1082	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:47:37.435638	t	Edge 137.0.0	0	\N
1083	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:51:39.615188	f	Edge 137.0.0	0	\N
1084	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:52:02.950638	t	Edge 137.0.0	0	\N
1085	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:56:53.914692	f	Edge 137.0.0	0	\N
1086	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 20:57:09.455437	t	Edge 137.0.0	0	\N
1087	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:01:09.41707	f	Edge 137.0.0	0	\N
1088	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:01:26.237735	t	Edge 137.0.0	0	\N
1089	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:15:15.387371	f	Edge 137.0.0	0	\N
1090	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:15:35.504863	t	Edge 137.0.0	0	\N
1091	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:19:43.570878	f	Edge 137.0.0	0	\N
1092	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:20:01.675707	t	Edge 137.0.0	0	\N
1093	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:23:46.74058	f	Edge 137.0.0	0	\N
1094	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:24:05.750859	t	Edge 137.0.0	0	\N
1095	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:25:16.529668	f	Edge 137.0.0	0	\N
1096	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:25:33.926256	t	Edge 137.0.0	0	\N
1097	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:27:37.235096	f	Edge 137.0.0	0	\N
1098	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:27:57.540628	t	Edge 137.0.0	0	\N
1099	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:30:08.206049	f	Edge 137.0.0	0	\N
1100	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:30:23.482645	t	Edge 137.0.0	0	\N
1101	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:34:01.627516	f	Edge 137.0.0	0	\N
1102	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:34:14.161832	t	Edge 137.0.0	0	\N
1103	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:36:43.217357	f	Edge 137.0.0	0	\N
1104	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:36:47.366119	f	Edge 137.0.0	0	\N
1105	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:37:05.596225	t	Edge 137.0.0	0	\N
1106	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:38:14.295352	f	Edge 137.0.0	0	\N
1107	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:38:29.985463	t	Edge 137.0.0	0	\N
1108	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:39:48.482325	f	Edge 137.0.0	0	\N
1109	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:40:09.80594	t	Edge 137.0.0	0	\N
1110	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:46:53.930664	f	Edge 137.0.0	0	\N
1111	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:47:13.142051	t	Edge 137.0.0	0	\N
1112	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:49:59.076212	f	Edge 137.0.0	0	\N
1113	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 21:50:17.541848	t	Edge 137.0.0	0	\N
1114	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:00:08.864848	f	Edge 137.0.0	0	\N
1115	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:00:24.629575	t	Edge 137.0.0	0	\N
1116	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:02:38.726494	f	Edge 137.0.0	0	\N
1117	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:02:54.620829	t	Edge 137.0.0	0	\N
1118	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:10:31.265362	f	Edge 137.0.0	0	\N
1119	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:10:50.482246	t	Edge 137.0.0	0	\N
1120	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:15:53.945344	f	Edge 137.0.0	0	\N
1121	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:16:14.16008	t	Edge 137.0.0	0	\N
1122	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:21:33.956025	f	Edge 137.0.0	0	\N
1123	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:21:51.591185	t	Edge 137.0.0	0	\N
1124	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:22:35.355795	f	Edge 137.0.0	0	\N
1125	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:22:51.747059	t	Edge 137.0.0	0	\N
1126	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:26:41.33615	f	Edge 137.0.0	0	\N
1127	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-17 22:26:58.513378	t	Edge 137.0.0	0	\N
1128	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:27:33.146215	f	Edge 137.0.0	0	\N
1129	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:27:56.379658	t	Edge 137.0.0	0	\N
1130	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:29:07.661917	f	Edge 137.0.0	0	\N
1131	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:29:23.972883	t	Edge 137.0.0	0	\N
1132	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:33:00.567873	f	Edge 137.0.0	0	\N
1133	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:33:19.163077	t	Edge 137.0.0	0	\N
1134	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:37:38.603004	f	Edge 137.0.0	0	\N
1135	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:37:54.347703	t	Edge 137.0.0	0	\N
1136	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:40:43.748454	f	Edge 137.0.0	0	\N
1137	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:41:00.757295	t	Edge 137.0.0	0	\N
1138	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:47:43.777129	f	Edge 137.0.0	0	\N
1139	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 14:48:04.944948	t	Edge 137.0.0	0	\N
1140	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:21:53.43286	f	Edge 137.0.0	0	\N
1141	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:22:25.031869	t	Edge 137.0.0	0	\N
1142	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:28:39.086964	f	Edge 137.0.0	0	\N
1143	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:28:57.005407	t	Edge 137.0.0	0	\N
1144	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:33:07.404975	f	Edge 137.0.0	0	\N
1145	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:33:26.347958	t	Edge 137.0.0	0	\N
1146	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:34:47.475146	f	Edge 137.0.0	0	\N
1147	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:35:02.662858	t	Edge 137.0.0	0	\N
1148	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:40:22.672162	f	Edge 137.0.0	0	\N
1149	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:40:38.365051	t	Edge 137.0.0	0	\N
1150	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:53:58.459474	f	Edge 137.0.0	0	\N
1151	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:54:19.129784	t	Edge 137.0.0	0	\N
1152	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:56:30.419615	f	Edge 137.0.0	0	\N
1153	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 15:56:46.856712	t	Edge 137.0.0	0	\N
1154	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:01:24.92168	f	Edge 137.0.0	0	\N
1155	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:01:44.523853	t	Edge 137.0.0	0	\N
1156	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:04:36.864483	f	Edge 137.0.0	0	\N
1157	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:04:54.052659	t	Edge 137.0.0	0	\N
1158	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:07:28.902859	f	Edge 137.0.0	0	\N
1159	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:08:15.763142	t	Edge 137.0.0	0	\N
1160	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:13:22.146489	f	Edge 137.0.0	0	\N
1161	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:13:41.19447	t	Edge 137.0.0	0	\N
1162	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:34:36.144259	f	Edge 137.0.0	0	\N
1163	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:35:01.19442	t	Edge 137.0.0	0	\N
1164	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:37:41.285309	f	Edge 137.0.0	0	\N
1165	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:38:00.82322	t	Edge 137.0.0	0	\N
1166	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:42:10.725071	f	Edge 137.0.0	0	\N
1167	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:42:28.845016	t	Edge 137.0.0	0	\N
1168	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:49:35.486335	f	Edge 137.0.0	0	\N
1169	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:49:51.385154	t	Edge 137.0.0	0	\N
1170	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:52:19.186115	f	Edge 137.0.0	0	\N
1171	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 16:52:33.098111	t	Edge 137.0.0	0	\N
1172	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:02:53.2568	f	Edge 137.0.0	0	\N
1173	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:03:08.137152	t	Edge 137.0.0	0	\N
1174	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:09:03.694839	f	Edge 137.0.0	0	\N
1175	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:09:29.694342	t	Edge 137.0.0	0	\N
1176	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:13:43.57776	f	Edge 137.0.0	0	\N
1177	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:13:58.314341	t	Edge 137.0.0	0	\N
1178	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:15:35.087563	f	Edge 137.0.0	0	\N
1179	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:15:49.513021	t	Edge 137.0.0	0	\N
1180	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:30:45.49009	f	Chrome 137.0.0	0	\N
1181	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:30:59.053764	t	Chrome 137.0.0	0	\N
1182	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:55:59.907898	f	Edge 137.0.0	0	\N
1183	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 17:56:17.07407	t	Edge 137.0.0	0	\N
1184	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:00:06.911827	f	Edge 137.0.0	0	\N
1185	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:00:28.016004	t	Edge 137.0.0	0	\N
1186	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:03:25.870921	f	Edge 137.0.0	0	\N
1187	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:03:49.290635	t	Edge 137.0.0	0	\N
1188	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:06:59.329715	f	Edge 137.0.0	0	\N
1189	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:07:15.578871	t	Edge 137.0.0	0	\N
1190	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:11:00.741087	f	Edge 137.0.0	0	\N
1191	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:11:12.400636	t	Edge 137.0.0	0	\N
1192	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:12:35.646082	f	Edge 137.0.0	0	\N
1193	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:12:53.385853	t	Edge 137.0.0	0	\N
1194	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:20:30.075845	f	Edge 137.0.0	0	\N
1195	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:20:55.158504	t	Edge 137.0.0	0	\N
1196	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:22:21.995621	f	Chrome 137.0.0	0	\N
1197	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:22:34.506175	t	Chrome 137.0.0	0	\N
1198	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:30:36.448724	f	Edge 137.0.0	0	\N
1199	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:30:51.58168	t	Edge 137.0.0	0	\N
1200	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:45:19.460667	f	Edge 137.0.0	0	\N
1201	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:45:37.345314	t	Edge 137.0.0	0	\N
1202	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:49:46.075507	f	Edge 137.0.0	0	\N
1203	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 18:50:09.326078	t	Edge 137.0.0	0	\N
1204	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:14:47.541557	f	Edge 137.0.0	0	\N
1205	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:15:03.492152	t	Edge 137.0.0	0	\N
1206	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:16:04.760845	f	Edge 137.0.0	0	\N
1207	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:16:26.697529	t	Edge 137.0.0	0	\N
1208	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:18:14.832119	f	Edge 137.0.0	0	\N
1209	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:18:36.350102	t	Edge 137.0.0	0	\N
1210	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:29:27.265966	f	Edge 137.0.0	0	\N
1211	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:29:50.245724	t	Edge 137.0.0	0	\N
1212	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:34:39.138002	f	Edge 137.0.0	0	\N
1213	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:34:58.429948	t	Edge 137.0.0	0	\N
1214	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:35:17.235782	f	Chrome 137.0.0	0	\N
1215	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:35:31.155947	t	Chrome 137.0.0	0	\N
1216	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:39:25.366469	f	Edge 137.0.0	0	\N
1217	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:40:13.076187	t	Edge 137.0.0	0	\N
1218	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:43:58.127068	f	Edge 137.0.0	0	\N
1219	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:44:19.750951	t	Edge 137.0.0	0	\N
1220	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:47:13.646174	f	Edge 137.0.0	0	\N
1221	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:47:30.838136	t	Edge 137.0.0	0	\N
1222	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:52:39.075681	f	Edge 137.0.0	0	\N
1223	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:52:57.707567	t	Edge 137.0.0	0	\N
1224	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 19:59:50.490873	f	Edge 137.0.0	0	\N
1225	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:02:27.604988	f	Edge 137.0.0	0	\N
1226	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:02:52.471316	t	Edge 137.0.0	0	\N
1227	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:09:30.537972	f	Edge 137.0.0	0	\N
1228	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:09:46.582723	t	Edge 137.0.0	0	\N
1229	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:10:20.092701	f	Chrome 137.0.0	0	\N
1230	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:10:33.400409	t	Chrome 137.0.0	0	\N
1231	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:19:27.81106	f	Edge 137.0.0	0	\N
1232	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:19:45.561417	t	Edge 137.0.0	0	\N
1233	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-18 20:24:52.810916	f	Edge 137.0.0	0	\N
1251	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:51.26118	f	Edge 137.0.0	1	\N
1252	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 10:04:04.730954	f	Edge 137.0.0	0	\N
1253	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 10:04:26.510868	t	Edge 137.0.0	0	\N
1254	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:09:56.75742	f	Edge 137.0.0	0	\N
1255	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:10:21.98567	t	Edge 137.0.0	0	\N
1256	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:13:25.73055	f	Edge 137.0.0	0	\N
1257	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:13:42.371166	t	Edge 137.0.0	0	\N
1278	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:16:15.840785	t	Edge 137.0.0	0	\N
1266	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:54:51.315519	f	Chrome 137.0.0	0	\N
1258	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:29:19.855529	f	Edge 137.0.0	5	2025-06-19 10:47:32.278873
1259	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:48:06.040229	f	Edge 137.0.0	0	\N
1235	7	maureengabriella1m@gmail.com	127.0.0.1	2025-06-18 21:00:44.010313	f	Chrome 137.0.0	10	2025-06-18 22:12:07.834047
1267	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:55:07.270265	t	Chrome 137.0.0	0	\N
1268	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:00:43.780962	f	Edge 137.0.0	0	\N
1269	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:01:38.486867	t	Edge 137.0.0	0	\N
1264	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:44:04.249455	f	Edge 137.0.0	0	\N
1236	28	driveanisa4@gmail.com	127.0.0.1	2025-06-18 21:24:56.645598	f	Edge 137.0.0	6	2025-06-18 21:30:21.287894
1237	28	driveanisa4@gmail.com	127.0.0.1	2025-06-18 21:33:30.445363	f	Edge 137.0.0	1	\N
1238	28	driveanisa4@gmail.com	127.0.0.1	2025-06-18 21:34:02.274896	f	Edge 137.0.0	0	\N
1239	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:47:15.336148	f	Edge 137.0.0	1	\N
1240	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:47:55.391228	f	Edge 137.0.0	1	\N
1241	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:47:59.649906	f	Edge 137.0.0	1	\N
1242	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:03.819351	f	Edge 137.0.0	1	\N
1243	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:08.899498	f	Edge 137.0.0	1	\N
1244	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:13.784035	f	Edge 137.0.0	1	\N
1245	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:19.810859	f	Edge 137.0.0	1	\N
1246	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:27.712997	f	Edge 137.0.0	1	\N
1247	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:32.58062	f	Edge 137.0.0	1	\N
1248	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:37.263965	f	Edge 137.0.0	1	\N
1249	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:41.620154	f	Edge 137.0.0	1	\N
1250	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 08:48:46.142111	f	Edge 137.0.0	1	\N
1270	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:02:30.751219	f	Edge 137.0.0	0	\N
1271	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:02:45.80619	t	Edge 137.0.0	0	\N
1272	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:05:46.5657	f	Edge 137.0.0	0	\N
1273	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:06:09.712387	t	Edge 137.0.0	0	\N
1274	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:11:54.350393	f	Edge 137.0.0	0	\N
1275	28	driveanisa4@gmail.com	127.0.0.1	2025-06-19 12:12:13.260787	t	Edge 137.0.0	0	\N
1277	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:15:51.450357	f	Edge 137.0.0	0	\N
1285	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:23:38.945138	f	Edge 137.0.0	0	\N
1286	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:23:57.405304	t	Edge 137.0.0	0	\N
1292	27	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-19 12:31:59.540566	t	Edge 137.0.0	0	\N
1290	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:29:53.59095	t	Edge 137.0.0	0	\N
1289	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:29:33.090158	f	Edge 137.0.0	0	\N
1291	27	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-19 12:31:44.545236	f	Edge 137.0.0	0	\N
1293	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:47:41.441415	f	Edge 137.0.0	0	\N
1294	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:48:00.465648	t	Edge 137.0.0	0	\N
1295	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:48:25.906458	f	Chrome 137.0.0	0	\N
1296	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:48:39.841005	t	Chrome 137.0.0	0	\N
1297	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:07:22.710643	f	Edge 137.0.0	0	\N
1298	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:07:35.834114	t	Edge 137.0.0	0	\N
1299	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:11:53.860552	f	Edge 137.0.0	0	\N
1300	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:12:05.115489	f	Edge 137.0.0	0	\N
1301	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:22:43.1152	f	Edge 137.0.0	0	\N
1302	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:23:06.710962	t	Edge 137.0.0	0	\N
1303	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:30:45.116442	f	Edge 137.0.0	0	\N
1304	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 13:32:22.186282	f	Edge 137.0.0	0	\N
1305	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 14:03:04.811288	f	Chrome 137.0.0	0	\N
1337	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:10:51.687663	f	Edge 137.0.0	0	\N
1338	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:11:08.882089	t	Edge 137.0.0	0	\N
1339	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:15:03.124886	f	Edge 137.0.0	0	\N
1340	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:15:19.304372	t	Edge 137.0.0	0	\N
1341	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-21 10:03:18.50522	f	Opera 119.0.0	0	\N
1342	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-21 10:03:39.310813	t	Opera 119.0.0	0	\N
1343	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-21 10:28:36.29698	f	Opera 119.0.0	1	\N
1344	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-21 10:28:59.380202	f	Opera 119.0.0	0	\N
1345	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-21 10:29:17.233956	t	Opera 119.0.0	0	\N
1346	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-21 13:19:53.56578	f	Opera 119.0.0	0	\N
1307	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 14:46:20.646219	f	Edge 137.0.0	0	\N
1308	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 14:46:38.491311	t	Edge 137.0.0	1	\N
1309	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 15:07:09.470499	f	Edge 137.0.0	0	\N
1347	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-21 13:20:03.220193	f	Opera 119.0.0	0	\N
1348	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-21 13:20:12.842431	t	Opera 119.0.0	0	\N
1349	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-06-21 13:20:21.102863	t	Opera 119.0.0	0	\N
1350	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-21 13:26:14.706338	f	Opera 119.0.0	0	\N
1310	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 15:07:29.760667	t	Edge 137.0.0	5	2025-06-19 15:13:30.909453
1311	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 12:27:05.418029	f	Edge 137.0.0	0	\N
1312	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 12:27:25.940858	t	Edge 137.0.0	0	\N
1313	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 12:55:56.66433	f	Edge 137.0.0	0	\N
1314	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 12:56:24.49705	t	Edge 137.0.0	0	\N
1315	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-20 13:05:44.500843	f	Opera 119.0.0	0	\N
1316	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-20 13:06:02.877936	t	Opera 119.0.0	0	\N
1317	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 13:11:51.876281	f	Edge 137.0.0	0	\N
1318	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-20 13:12:04.945755	t	Edge 137.0.0	0	\N
1321	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-20 13:30:03.729406	f	Opera 119.0.0	0	\N
1322	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-20 13:30:26.138495	f	Opera 119.0.0	0	\N
1323	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-20 13:30:44.930021	t	Opera 119.0.0	0	\N
1324	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:26:26.845299	f	Edge 137.0.0	0	\N
1325	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:27:18.698257	f	Edge 137.0.0	0	\N
1326	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:27:24.301937	f	Edge 137.0.0	0	\N
1327	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:29:29.304412	f	Edge 137.0.0	0	\N
1328	1	nabilalb2004@gmail.com	127.0.0.1	2025-06-21 04:31:37.881167	f	Edge 137.0.0	0	\N
1329	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:35:01.316642	f	Edge 137.0.0	0	\N
1330	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:35:18.1001	t	Edge 137.0.0	0	\N
1331	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:47:23.400665	f	Edge 137.0.0	0	\N
1332	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:47:43.094231	t	Edge 137.0.0	0	\N
1333	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:48:44.010211	f	Edge 137.0.0	0	\N
1334	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 04:49:01.959142	t	Edge 137.0.0	0	\N
1335	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:08:34.687132	f	Edge 137.0.0	0	\N
1336	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-21 05:08:51.666581	t	Edge 137.0.0	0	\N
1351	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-21 13:26:38.471458	t	Chrome Mobile 134.0.0	0	\N
1352	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-21 13:27:49.975265	f	Opera 119.0.0	0	\N
1353	6	yustinayunita86@gmail.com	127.0.0.1	2025-06-21 13:28:23.873812	t	Opera 119.0.0	0	\N
1354	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-21 16:00:06.10655	f	Opera 119.0.0	0	\N
1355	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:03:53.352596	f	Edge 137.0.0	0	\N
1356	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:04:17.747054	t	Edge 137.0.0	0	\N
1357	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:27:00.492991	f	Chrome 137.0.0	0	\N
1358	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:27:26.417005	t	Chrome 137.0.0	0	\N
1359	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:29:39.170871	f	Edge 137.0.0	0	\N
1360	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:30:02.916984	t	Edge 137.0.0	0	\N
1361	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:56:18.409628	f	Edge 137.0.0	0	\N
1362	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:56:36.371839	t	Edge 137.0.0	0	\N
1363	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:57:18.801904	f	Chrome 137.0.0	0	\N
1364	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 19:57:31.999919	t	Chrome 137.0.0	0	\N
1365	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:02:05.511596	f	Edge 137.0.0	0	\N
1366	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:02:26.756405	t	Edge 137.0.0	0	\N
1367	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:14:46.542541	f	Edge 137.0.0	0	\N
1368	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:14:59.702232	t	Edge 137.0.0	0	\N
1369	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:18:14.712023	f	Edge 137.0.0	0	\N
1370	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:18:36.876951	t	Edge 137.0.0	0	\N
1371	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:25:50.31671	f	Edge 137.0.0	0	\N
1372	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:26:05.340735	t	Edge 137.0.0	0	\N
1406	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 15:05:06.336724	f	Chrome Mobile 134.0.0	0	\N
1407	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 15:05:23.699212	t	Chrome Mobile 134.0.0	0	\N
1408	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-02 03:27:16.048174	f	Opera 119.0.0	0	\N
1409	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-02 03:27:34.559657	t	Opera 119.0.0	0	\N
1410	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-04 13:30:41.990056	f	Opera 119.0.0	0	\N
1373	7	maureengabriella1m@gmail.com	127.0.0.1	2025-06-21 20:26:26.116422	f	Edge 137.0.0	7	\N
1374	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:27:43.937877	f	Edge 137.0.0	0	\N
1375	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:27:59.512894	t	Edge 137.0.0	0	\N
1376	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:28:26.542401	f	Chrome 137.0.0	0	\N
1377	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:28:39.836019	t	Chrome 137.0.0	0	\N
1378	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:47:30.707327	f	Edge 137.0.0	0	\N
1379	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:01.79688	f	Edge 137.0.0	0	\N
1380	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:17.516803	t	Edge 137.0.0	0	\N
1381	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:54.816422	f	Chrome 137.0.0	0	\N
1383	7	maureengabriella1m@gmail.com	127.0.0.1	2025-06-21 20:58:36.036108	f	Chrome 137.0.0	1	\N
1411	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-04 13:31:03.281559	t	Opera 119.0.0	0	\N
1412	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 13:37:07.076785	f	Opera 119.0.0	1	\N
1413	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 13:37:12.113352	f	Opera 119.0.0	0	\N
1414	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 13:37:28.945826	t	Opera 119.0.0	0	\N
1415	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 14:45:05.668006	f	Opera 119.0.0	0	\N
1416	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 14:45:22.352326	t	Opera 119.0.0	0	\N
1417	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 15:15:40.54515	f	Chrome Mobile 134.0.0	0	\N
1418	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-04 15:16:14.560304	t	Chrome Mobile 134.0.0	0	\N
1419	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-04 15:24:39.590237	f	Opera 119.0.0	0	\N
1420	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-04 15:25:40.006088	t	Opera 119.0.0	0	\N
1384	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:17:32.744402	f	Edge 137.0.0	0	\N
1385	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:17:57.311894	t	Edge 137.0.0	0	\N
1386	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:37:47.511699	f	Edge 137.0.0	0	\N
1387	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:38:00.604005	t	Edge 137.0.0	0	\N
1388	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-21 21:38:55.514051	f	Edge 137.0.0	0	\N
1389	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-21 21:39:16.797299	t	Edge 137.0.0	0	\N
1390	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-21 21:40:20.109573	f	Chrome 137.0.0	0	\N
1391	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-06-21 21:40:37.632022	t	Chrome 137.0.0	0	\N
1392	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:47:20.844127	f	Chrome 137.0.0	0	\N
1393	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 21:47:35.763087	t	Chrome 137.0.0	0	\N
1394	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-23 12:52:50.309864	f	Edge 137.0.0	0	\N
1395	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-23 12:53:07.87236	t	Edge 137.0.0	0	\N
1396	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-23 13:02:37.465949	f	Edge 137.0.0	0	\N
1397	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-06-23 13:02:56.808185	t	Edge 137.0.0	0	\N
1398	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 13:25:12.482789	f	Opera 119.0.0	0	\N
1399	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 13:25:30.950263	t	Opera 119.0.0	0	\N
1400	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 13:57:16.510852	f	Opera 119.0.0	0	\N
1401	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 13:57:38.874153	t	Opera 119.0.0	0	\N
1402	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 14:28:13.066628	f	Chrome Mobile 134.0.0	0	\N
1403	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 14:28:21.092376	f	Chrome Mobile 134.0.0	0	\N
1404	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 14:28:46.957739	t	Chrome Mobile 134.0.0	0	\N
1405	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-29 15:04:58.076005	f	Chrome Mobile 134.0.0	0	\N
1421	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-06 10:11:04.496478	f	Opera 119.0.0	0	\N
1422	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-06 10:11:24.937038	t	Opera 119.0.0	0	\N
1423	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:03:20.923967	f	Chrome 137.0.0	1	\N
1424	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:04:58.445962	f	Chrome 137.0.0	0	\N
1425	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:05:32.414298	t	Chrome 137.0.0	0	\N
1426	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:18:47.954488	f	Chrome 137.0.0	0	\N
1427	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:19:09.440315	t	Chrome 137.0.0	0	\N
1428	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:24:03.547794	f	Chrome 137.0.0	0	\N
1429	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:24:43.396122	t	Chrome 137.0.0	0	\N
1430	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:28:50.893062	f	Chrome 137.0.0	0	\N
1431	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:29:45.388155	t	Chrome 137.0.0	0	\N
1432	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:59:16.583982	f	Chrome 137.0.0	0	\N
1433	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 19:59:35.840326	t	Chrome 137.0.0	0	\N
1434	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:02:59.051664	f	Edge 138.0.0	0	\N
1435	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:03:12.656214	t	Edge 138.0.0	0	\N
1436	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:25:28.066185	f	Edge 138.0.0	0	\N
1437	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:25:49.285446	t	Edge 138.0.0	0	\N
1438	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:46:31.677698	f	Edge 138.0.0	0	\N
1439	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:47:04.000277	t	Edge 138.0.0	0	\N
1440	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:48:56.295207	f	Edge 138.0.0	0	\N
1441	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:49:09.793583	t	Edge 138.0.0	0	\N
1442	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:51:21.865149	f	Edge 138.0.0	0	\N
1443	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 20:51:34.958243	t	Edge 138.0.0	0	\N
1444	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 20:54:47.067746	f	Edge 138.0.0	0	\N
1445	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 20:55:32.924137	t	Edge 138.0.0	0	\N
1446	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 21:00:25.320956	f	Edge 138.0.0	0	\N
1447	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 21:00:50.933965	t	Edge 138.0.0	0	\N
1448	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 21:01:52.124779	f	Edge 138.0.0	0	\N
1449	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-06 21:02:10.145523	t	Edge 138.0.0	0	\N
1450	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:05:00.338527	f	Edge 138.0.0	0	\N
1451	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:05:23.93243	t	Edge 138.0.0	0	\N
1452	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:12:17.293357	f	Edge 138.0.0	0	\N
1453	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:12:30.197287	t	Edge 138.0.0	0	\N
1454	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:15:58.20838	f	Edge 138.0.0	0	\N
1455	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:16:12.719045	t	Edge 138.0.0	0	\N
1456	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:18:06.103739	f	Edge 138.0.0	0	\N
1457	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:18:19.859708	t	Edge 138.0.0	0	\N
1458	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:31:12.580964	f	Edge 138.0.0	0	\N
1459	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:31:25.954239	t	Edge 138.0.0	0	\N
1460	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:35:34.785571	f	Edge 138.0.0	0	\N
1461	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 21:35:52.303299	t	Edge 138.0.0	0	\N
1462	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 22:04:06.174893	f	Edge 138.0.0	0	\N
1463	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 22:04:25.749446	t	Edge 138.0.0	0	\N
1464	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 22:07:36.787951	f	Edge 138.0.0	0	\N
1465	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-06 22:07:53.120104	t	Edge 138.0.0	0	\N
1466	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-07 05:45:37.607299	f	Edge 138.0.0	0	\N
1467	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-07 05:45:49.333954	f	Edge 138.0.0	0	\N
1468	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-07 05:46:12.379107	t	Edge 138.0.0	0	\N
1469	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-07 07:39:36.341172	f	Edge 138.0.0	0	\N
1470	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-07 07:39:57.779526	t	Edge 138.0.0	0	\N
1471	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:47:52.599541	f	Edge 138.0.0	0	\N
1472	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:50:32.402258	f	Chrome 138.0.0	0	\N
1473	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:50:42.373393	f	Chrome 138.0.0	0	\N
1474	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:52:02.088373	f	Chrome 138.0.0	0	\N
1475	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:52:18.037489	t	Chrome 138.0.0	0	\N
1476	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:54:34.82837	f	Edge 138.0.0	0	\N
1477	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:54:53.083509	t	Edge 138.0.0	0	\N
1478	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-10 07:59:30.626567	f	Chrome 138.0.0	0	\N
1479	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 08:04:17.817448	f	Edge 138.0.0	0	\N
1480	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 08:05:05.16452	t	Edge 138.0.0	0	\N
1481	\N	nabilalb2004@gmail.com	127.0.0.1	2025-07-10 08:07:37.448417	f	Edge 138.0.0	1	\N
1482	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 08:07:44.989388	f	Edge 138.0.0	0	\N
1483	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 08:10:28.656039	t	Edge 138.0.0	0	\N
1484	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 08:47:35.371458	f	Edge 138.0.0	0	\N
1485	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 08:48:14.164346	t	Edge 138.0.0	0	\N
1486	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 10:07:35.545577	f	Opera 119.0.0	0	\N
1487	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 12:51:42.307474	f	Opera 119.0.0	0	\N
1488	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 12:52:00.616591	t	Opera 119.0.0	0	\N
1489	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 12:56:17.562246	f	Opera 119.0.0	0	\N
1490	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 12:58:16.143905	t	Opera 119.0.0	1	\N
1491	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-10 13:08:04.89395	f	Opera 119.0.0	0	\N
1492	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-10 13:08:19.810376	t	Opera 119.0.0	0	\N
1493	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-10 13:15:38.761535	f	Opera 119.0.0	0	\N
1494	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-10 13:15:54.837985	t	Opera 119.0.0	0	\N
1497	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 13:21:29.621759	f	Opera 119.0.0	5	2025-07-10 13:27:04.427493
1495	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 13:18:14.333656	f	Opera 119.0.0	0	\N
1496	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 13:18:31.553315	t	Opera 119.0.0	0	\N
1498	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-10 13:37:50.869718	f	Opera 119.0.0	0	\N
1499	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-10 13:38:11.371675	t	Opera 119.0.0	0	\N
1500	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-10 13:38:28.899032	f	Opera 119.0.0	0	\N
1501	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-10 13:38:49.662603	t	Opera 119.0.0	0	\N
1502	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 13:51:39.869329	f	Opera 119.0.0	0	\N
1503	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-10 13:51:55.281083	t	Opera 119.0.0	0	\N
1504	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 14:24:56.798297	f	Edge 138.0.0	0	\N
1505	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 14:25:17.263645	t	Edge 138.0.0	0	\N
1506	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 14:33:19.956628	f	Edge 138.0.0	0	\N
1507	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 14:34:07.96104	t	Edge 138.0.0	0	\N
1508	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 15:31:14.978378	f	Edge 138.0.0	0	\N
1509	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 15:31:35.318594	t	Edge 138.0.0	0	\N
1510	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:28:04.092737	f	Edge 138.0.0	0	\N
1511	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:28:20.908382	t	Edge 138.0.0	0	\N
1512	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:33:19.890778	f	Edge 138.0.0	0	\N
1513	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:33:41.507462	t	Edge 138.0.0	0	\N
1514	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-10 16:42:02.556121	f	Edge 138.0.0	0	\N
1515	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-10 16:42:21.989696	t	Edge 138.0.0	0	\N
1516	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-10 16:50:53.75059	f	Edge 138.0.0	0	\N
1517	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-10 16:51:12.675438	t	Edge 138.0.0	0	\N
1518	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:57:59.081457	f	Edge 138.0.0	0	\N
1519	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 16:58:15.259643	t	Edge 138.0.0	0	\N
1520	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:11:04.56442	f	Edge 138.0.0	0	\N
1521	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:11:17.19976	t	Edge 138.0.0	0	\N
1522	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:26:49.939114	f	Edge 138.0.0	0	\N
1523	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:27:09.114865	t	Edge 138.0.0	0	\N
1524	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:41:28.468596	f	Edge 138.0.0	0	\N
1525	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:41:43.432365	t	Edge 138.0.0	0	\N
1526	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:44:51.849659	f	Edge 138.0.0	0	\N
1527	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:45:13.59475	t	Edge 138.0.0	0	\N
1528	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:46:41.624902	f	Edge 138.0.0	0	\N
1529	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 17:46:58.40107	t	Edge 138.0.0	0	\N
1530	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:06:30.267149	f	Edge 138.0.0	0	\N
1531	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:06:52.590368	t	Edge 138.0.0	0	\N
1532	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:22:14.675999	f	Edge 138.0.0	0	\N
1533	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:22:32.287636	t	Edge 138.0.0	0	\N
1534	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:50:36.462969	f	Edge 138.0.0	0	\N
1535	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 18:50:52.983382	t	Edge 138.0.0	0	\N
1536	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:10:07.315639	f	Edge 138.0.0	0	\N
1537	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:10:25.365	t	Edge 138.0.0	0	\N
1538	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 19:17:42.036817	f	Edge 138.0.0	0	\N
1539	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-10 19:18:10.820646	t	Edge 138.0.0	0	\N
1540	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:20:45.849942	f	Edge 138.0.0	0	\N
1541	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:21:05.502533	t	Edge 138.0.0	0	\N
1542	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:52:22.398725	f	Edge 138.0.0	0	\N
1543	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:53:17.118065	f	Edge 138.0.0	0	\N
1544	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-10 19:53:49.692219	t	Edge 138.0.0	0	\N
1545	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:07:36.69455	f	Edge 138.0.0	0	\N
1546	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:07:51.431816	t	Edge 138.0.0	0	\N
1547	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:37:24.799631	f	Chrome 138.0.0	0	\N
1548	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:37:43.406766	t	Chrome 138.0.0	0	\N
1549	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:41:35.016013	f	Edge 138.0.0	0	\N
1550	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:41:49.378309	t	Edge 138.0.0	0	\N
1551	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-11 06:44:13.128876	f	Chrome 138.0.0	0	\N
1552	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-11 06:44:31.994376	t	Chrome 138.0.0	0	\N
1553	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:49:54.071172	f	Edge 138.0.0	0	\N
1554	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:50:22.659871	t	Edge 138.0.0	0	\N
1555	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:51:42.078279	f	Edge 138.0.0	0	\N
1556	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:51:57.415098	t	Edge 138.0.0	0	\N
1557	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:52:17.647465	f	Chrome 138.0.0	0	\N
1558	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:52:32.591269	t	Chrome 138.0.0	0	\N
1559	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:55:06.536022	f	Chrome 138.0.0	0	\N
1560	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:55:15.656007	f	Chrome 138.0.0	0	\N
1561	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 06:55:33.845858	t	Chrome 138.0.0	0	\N
1562	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:56:08.633845	f	Edge 138.0.0	0	\N
1563	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 06:56:23.329244	t	Edge 138.0.0	0	\N
1564	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-11 06:57:20.107497	f	Edge 138.0.0	0	\N
1565	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-11 06:57:38.311178	t	Edge 138.0.0	0	\N
1566	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 07:00:53.722792	f	Edge 138.0.0	0	\N
1567	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 07:01:30.352549	t	Edge 138.0.0	0	\N
1568	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-11 07:02:15.174493	f	Opera 119.0.0	0	\N
1569	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-11 07:02:33.473956	t	Opera 119.0.0	0	\N
1570	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 07:02:36.70196	f	Chrome 138.0.0	0	\N
1571	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-11 07:02:47.683378	f	Opera 119.0.0	0	\N
1572	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-11 07:03:00.840867	t	Chrome 138.0.0	0	\N
1573	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-11 07:03:05.733891	t	Opera 119.0.0	0	\N
1574	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-11 07:03:23.671808	f	Opera 119.0.0	0	\N
1575	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-11 07:03:42.443015	t	Opera 119.0.0	0	\N
1576	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 07:11:33.947402	f	Edge 138.0.0	0	\N
1577	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 07:12:24.309947	t	Edge 138.0.0	0	\N
1578	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 07:15:11.177051	f	Edge 138.0.0	0	\N
1579	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 07:15:23.551134	t	Edge 138.0.0	0	\N
1580	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 10:15:08.369378	f	Edge 138.0.0	0	\N
1581	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 10:15:41.352998	t	Edge 138.0.0	0	\N
1582	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:42.20237	f	Edge 138.0.0	0	\N
1583	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:45.638587	f	Edge 138.0.0	0	\N
1584	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:48.896423	f	Edge 138.0.0	0	\N
1585	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:51.975535	f	Edge 138.0.0	0	\N
1586	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:55.315559	f	Edge 138.0.0	0	\N
1587	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:44:59.314915	f	Edge 138.0.0	0	\N
1588	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:02.894032	f	Edge 138.0.0	0	\N
1589	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:05.810319	f	Edge 138.0.0	0	\N
1590	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:08.766703	f	Edge 138.0.0	0	\N
1591	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:11.621816	f	Edge 138.0.0	0	\N
1592	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:14.279824	f	Edge 138.0.0	0	\N
1593	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:17.396893	f	Edge 138.0.0	0	\N
1594	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:20.254472	f	Edge 138.0.0	0	\N
1595	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:23.331806	f	Edge 138.0.0	0	\N
1596	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:26.033902	f	Edge 138.0.0	0	\N
1597	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:28.806918	f	Edge 138.0.0	0	\N
1598	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:31.816784	f	Edge 138.0.0	0	\N
1599	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:34.574902	f	Edge 138.0.0	0	\N
1600	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:37.268748	f	Edge 138.0.0	0	\N
1601	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:45:40.096992	f	Edge 138.0.0	0	\N
1602	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:54:24.003461	f	Edge 138.0.0	0	\N
1603	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 12:54:38.100872	t	Edge 138.0.0	0	\N
1604	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 12:55:14.057879	f	Edge 138.0.0	0	\N
1605	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-11 12:55:30.20192	t	Edge 138.0.0	0	\N
1606	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-11 13:03:38.992722	f	Edge 138.0.0	0	\N
1607	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-11 13:04:01.351899	t	Edge 138.0.0	0	\N
1608	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 13:45:49.04961	f	Edge 138.0.0	0	\N
1609	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-11 13:46:08.776274	t	Edge 138.0.0	0	\N
1610	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-15 11:40:41.628351	f	Opera 119.0.0	0	\N
1611	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-15 11:41:00.25186	t	Opera 119.0.0	0	\N
1612	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:01:05.104081	f	Edge 138.0.0	0	\N
1613	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:01:32.436953	f	Edge 138.0.0	0	\N
1614	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:01:57.578157	f	Edge 138.0.0	0	\N
1615	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:02:21.946035	f	Edge 138.0.0	0	\N
1616	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:02:46.762995	f	Edge 138.0.0	0	\N
1617	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:02:50.456922	f	Edge 138.0.0	0	\N
1618	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:02:53.998713	f	Edge 138.0.0	0	\N
1619	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:02:57.496964	f	Edge 138.0.0	0	\N
1620	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:03:01.096896	f	Chrome 138.0.0	0	\N
1621	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:03:04.487594	f	Chrome 138.0.0	0	\N
1622	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:03:19.520001	t	Chrome 138.0.0	0	\N
1623	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:10:38.914689	f	Chrome 138.0.0	0	\N
1624	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:10:43.733543	f	Chrome 138.0.0	0	\N
1625	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:11:05.575533	t	Chrome 138.0.0	0	\N
1626	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:13:40.959959	f	Chrome 138.0.0	0	\N
1627	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:13:56.207876	t	Chrome 138.0.0	0	\N
1628	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:31:29.070262	f	Opera 119.0.0	0	\N
1629	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:32:16.011742	t	Opera 119.0.0	0	\N
1630	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:35:35.151403	f	Opera 119.0.0	0	\N
1631	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:35:52.223593	t	Chrome Mobile 134.0.0	0	\N
1632	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:44:04.013437	f	Chrome 138.0.0	0	\N
1633	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:44:27.773227	t	Chrome 138.0.0	0	\N
1634	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:48:20.345977	f	Chrome 138.0.0	0	\N
1635	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:49:20.83185	t	Chrome 138.0.0	0	\N
1636	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:54:32.919948	f	Chrome 138.0.0	0	\N
1637	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-18 14:54:48.154412	t	Chrome 138.0.0	0	\N
1638	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 15:24:19.963326	f	Chrome 138.0.0	0	\N
1639	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 15:25:49.383829	t	Chrome 138.0.0	0	\N
1640	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-19 08:39:35.973934	f	Opera 119.0.0	1	\N
1641	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 11:57:35.546723	f	Chrome 138.0.0	0	\N
1642	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 11:57:50.987187	t	Chrome 138.0.0	0	\N
1643	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 11:58:35.109736	f	Chrome 138.0.0	0	\N
1644	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 11:58:52.668361	t	Chrome 138.0.0	0	\N
1645	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 12:30:22.210432	f	Chrome 138.0.0	0	\N
1646	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-20 12:30:49.399704	t	Chrome 138.0.0	0	\N
1647	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-20 13:05:35.51995	f	Opera 119.0.0	0	\N
1648	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-20 13:05:53.743459	t	Opera 119.0.0	0	\N
1649	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:29:36.63279	f	Edge 138.0.0	0	\N
1650	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:29:52.031518	t	Edge 138.0.0	0	\N
1651	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:47:57.237565	f	Edge 138.0.0	0	\N
1652	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:48:09.572947	t	Edge 138.0.0	0	\N
1653	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-23 17:55:33.210068	f	Chrome 138.0.0	0	\N
1654	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-23 17:55:55.436864	t	Chrome 138.0.0	0	\N
1655	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-23 17:57:13.199184	f	Chrome 138.0.0	0	\N
1656	30	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-23 17:57:31.922871	t	Chrome 138.0.0	0	\N
1657	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-23 18:01:41.441981	f	Edge 138.0.0	0	\N
1658	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-23 18:01:55.404489	t	Edge 138.0.0	0	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.notifications (notification_id, user_id, title, message, notification_type, is_read, created_at, read_at) FROM stdin;
146	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 07:26:24.594422	\N
8	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-14 02:58:47.217426	\N
11	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 135.0.0	new_device	f	2025-05-14 17:43:05.797696	\N
12	1	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 135.0.0	new_device	f	2025-05-14 18:01:19.93972	\N
14	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-15 03:07:12.903677	2025-05-16 09:39:53.444971
9	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-14 03:01:31.297653	2025-05-16 09:39:57.587622
1	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-09 12:14:29.977603	2025-05-16 09:40:09.090225
13	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 135.0.0	new_device	t	2025-05-15 02:48:45.246632	2025-05-16 15:07:08.546563
6	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-12 15:15:51.460335	2025-05-16 15:14:47.849621
4	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-09 17:10:28.187143	2025-05-16 15:14:49.166501
3	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-09 14:56:38.985101	2025-05-16 15:14:50.440408
2	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-09 12:59:57.744879	2025-05-16 15:14:51.870901
17	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-16 15:02:31.249922	2025-05-16 15:14:56.149632
16	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-16 14:01:27.961821	2025-05-16 15:14:57.366283
20	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-16 16:26:16.391916	2025-05-16 16:31:12.527194
19	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-16 16:26:01.393267	2025-05-16 16:31:14.629512
18	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-16 15:10:47.866834	2025-05-16 16:31:16.725424
21	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	f	2025-05-16 16:35:21.759176	\N
33	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-17 14:39:21.288788	2025-05-17 14:40:53.832806
25	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-17 05:38:54.578092	2025-05-17 05:43:32.632377
15	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-16 09:58:14.806049	2025-05-17 05:44:40.9904
26	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-17 06:14:08.636581	\N
27	1	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-17 06:19:43.474247	\N
28	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-17 06:20:10.243384	2025-05-17 06:34:01.334971
30	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-17 06:28:18.037723	2025-05-17 06:34:03.271082
23	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-16 17:00:24.922862	2025-05-17 08:26:30.132501
35	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-17 14:40:46.227597	2025-05-17 14:40:48.971629
34	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-17 14:40:10.735607	2025-05-17 14:40:50.075959
32	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-17 11:03:51.307917	2025-05-17 14:40:55.563387
29	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-17 06:23:05.443624	2025-05-17 14:40:57.353602
31	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-17 10:43:54.60142	2025-05-17 14:40:58.744048
37	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-18 08:10:48.634376	2025-05-18 08:10:53.20049
24	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-16 17:02:49.261778	2025-05-18 08:10:54.752463
22	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-16 16:42:26.921177	2025-05-18 08:10:56.891579
38	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-18 12:09:01.883485	\N
39	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 13:51:23.374027	\N
40	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 13:54:01.57313	\N
41	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 13:54:01.574037	\N
42	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:01:25.491155	\N
43	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:01:25.491155	\N
44	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:05:12.046273	\N
45	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:05:12.046273	\N
10	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-14 07:37:29.594588	2025-05-19 09:10:09.677018
36	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-18 04:11:14.686422	2025-05-19 09:10:14.692875
49	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 15:26:32.984996	2025-05-20 12:53:34.025552
47	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 14:52:29.895812	2025-05-20 09:20:24.194451
51	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 16:24:04.756409	2025-05-20 12:55:16.289724
7	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-14 02:58:04.711079	2025-05-23 07:31:31.298007
5	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-12 14:15:51.347809	2025-05-23 07:31:32.508308
46	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 14:52:29.895812	2025-05-23 07:34:23.683471
50	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 16:24:04.756409	2025-05-23 07:34:27.156648
52	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 19:58:16.520535	2025-05-23 07:34:28.163724
147	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 07:27:24.135354	2025-05-23 07:55:07.590632
149	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 07:55:52.468436	\N
57	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:11:53.940808	\N
64	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-18 21:09:25.449617	\N
59	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:13:05.507031	2025-05-20 12:55:11.423328
65	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-18 21:16:41.074356	2025-05-18 21:24:22.66082
69	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-19 09:08:22.767267	2025-05-19 09:10:12.217593
68	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-19 07:59:29.497646	2025-05-19 09:10:13.542084
84	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-20 00:33:08.671771	\N
90	4	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 05:27:26.774969	\N
91	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-20 08:57:53.259483	2025-05-20 08:59:28.155274
82	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:33:08.671771	2025-05-23 06:51:26.459513
104	15	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-23 07:29:54.688585	2025-05-23 07:31:26.933087
55	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:00:24.284593	2025-05-20 12:55:13.28395
53	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 19:58:16.520535	2025-05-20 12:55:18.091954
88	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-20 05:27:26.774969	2025-05-20 12:54:44.302642
86	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-20 05:26:33.126384	2025-05-20 12:54:45.811616
85	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-20 05:17:15.199951	2025-05-20 12:54:47.271414
80	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-20 00:30:51.152493	2025-05-20 12:54:52.000714
78	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:17:36.084042	2025-05-20 12:54:55.036671
76	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-19 10:17:18.324367	2025-05-20 12:54:57.467793
73	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:09:50.983611	2025-05-20 12:54:59.808967
71	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:08:33.417309	2025-05-20 12:55:01.943661
67	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 21:38:15.016478	2025-05-20 12:55:04.659039
63	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:43:45.821415	2025-05-20 12:55:06.515053
61	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:14:10.537946	2025-05-20 12:55:08.956709
94	4	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 12:56:24.616752	\N
92	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-20 09:06:20.277327	2025-05-21 12:44:42.65418
97	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-22 20:55:14.800656	\N
99	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-22 21:20:09.117635	\N
101	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-22 22:10:34.953657	\N
103	17	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	f	2025-05-23 07:29:54.687584	\N
105	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-23 07:31:22.895701	2025-05-23 07:31:30.127004
56	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:11:53.940808	2025-05-23 07:33:52.163336
74	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:10:02.964473	2025-05-23 07:34:02.319373
87	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-20 05:27:26.774969	2025-05-23 07:34:18.396796
96	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-22 20:55:14.799656	2025-05-23 07:34:14.786818
98	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-22 21:20:09.116139	2025-05-23 07:34:12.79561
93	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-20 12:56:24.616752	2025-05-23 07:34:16.431557
81	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:33:08.670742	2025-05-23 07:34:19.655639
77	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:17:36.083012	2025-05-23 07:34:20.807734
48	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 15:26:32.984996	2025-05-23 07:34:25.332475
54	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:00:24.284593	2025-05-23 07:34:29.745525
60	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:14:10.537946	2025-05-23 07:34:33.380672
58	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:13:05.507031	2025-05-23 07:34:32.419704
62	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:43:45.82043	2025-05-23 07:34:35.831267
66	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 21:38:15.016478	2025-05-23 07:34:36.083015
70	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:08:33.417309	2025-05-23 07:34:37.388157
72	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:09:50.983611	2025-05-23 07:34:38.58494
106	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-23 08:33:08.711615	2025-05-23 08:33:12.400074
95	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-21 18:21:06.273696	2025-05-23 08:33:14.241717
107	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 10:30:53.4242	\N
109	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 10:35:59.312561	\N
110	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 10:39:46.767059	\N
111	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 10:52:05.004714	\N
112	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 10:55:18.362704	\N
125	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 06:30:39.603716	2025-05-23 07:46:16.504221
148	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 07:45:55.325716	2025-05-23 07:51:12.417578
75	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:10:02.964473	2025-05-23 11:16:37.527812
119	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:17:27.776622	\N
108	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 10:31:26.56799	2025-05-23 08:06:41.304396
123	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:19:13.306465	\N
126	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 06:31:02.329012	\N
127	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:31:57.586868	\N
130	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:32:17.491531	\N
133	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:39:15.037517	\N
134	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
136	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
138	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:45:50.839621	\N
140	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:48:29.963412	\N
155	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 08:45:10.892826	\N
117	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 11:16:14.030697	2025-05-23 06:51:07.009727
116	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 11:12:15.988688	2025-05-23 06:51:09.282288
115	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 11:06:54.201328	2025-05-23 06:51:12.481624
114	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 11:00:17.064208	2025-05-23 06:51:15.084477
113	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 10:55:47.235116	2025-05-23 06:51:17.715633
139	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 06:47:28.522624	2025-05-23 06:51:21.763979
121	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:19:13.30538	2025-05-23 06:51:35.027621
132	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 06:38:29.16872	2025-05-23 07:20:53.403952
141	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 07:21:30.627906	\N
143	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 07:21:30.628905	\N
145	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 07:22:48.610168	\N
157	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 08:45:10.892826	\N
128	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:32:17.491531	2025-05-23 13:49:49.397965
161	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 20:56:33.944735	\N
151	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-23 20:19:54.570098	2025-05-23 14:01:09.787906
152	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-23 13:29:02.179497	2025-05-23 14:01:12.183595
160	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 20:56:33.944735	2025-05-23 14:01:41.025673
159	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 20:46:00.517792	2025-05-23 14:01:44.448951
154	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 20:44:18.1129	2025-05-23 14:01:45.026013
153	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-23 20:37:09.035224	2025-05-23 14:09:21.349867
150	7	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 07:58:13.049609	2025-05-23 15:07:21.933435
100	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-22 22:10:34.952655	2025-05-23 15:58:49.762773
164	3	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
165	17	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
137	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 06:43:18.664796	2025-05-23 16:00:13.236929
120	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:17:27.776622	2025-05-23 16:00:15.989327
158	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 08:45:10.892826	2025-05-23 16:00:17.343419
124	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:19:13.306465	2025-05-23 16:00:18.501834
131	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:32:17.491531	2025-05-23 16:00:20.05698
162	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 20:56:33.944735	2025-05-23 16:00:21.226758
166	15	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	t	2025-05-23 22:59:30.826331	2025-05-23 16:00:22.287184
144	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 07:21:30.628905	2025-05-23 16:00:08.717323
168	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 23:18:58.402583	\N
169	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 23:23:06.901052	\N
170	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 23:26:48.892906	\N
172	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 23:29:12.397259	\N
173	15	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 23:29:12.398312	\N
175	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:29:26.236148	2025-05-23 16:29:37.727939
171	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 23:29:12.397259	2025-05-24 06:57:36.355537
176	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:49:49.82315	2025-05-24 15:42:56.152956
178	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-24 22:42:39.736659	2025-05-24 15:42:57.609281
180	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.478087	\N
181	17	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.479232	\N
182	15	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.479232	\N
184	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-27 00:42:28.616557	\N
185	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-27 06:06:19.056272	\N
188	19	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-27 09:13:16.009771	\N
189	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-27 09:15:51.16069	\N
190	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:11:07.509518	2025-05-28 03:11:12.327956
187	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-27 09:03:25.366884	2025-05-28 03:11:13.213398
186	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-27 02:00:09.14251	2025-05-28 03:11:14.134038
191	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:24:15.973511	2025-06-07 08:06:20.298563
192	19	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	f	2025-06-07 15:07:33.629144	\N
193	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-08 19:23:15.698131	\N
196	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	f	2025-06-10 19:09:27.799658	\N
194	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 134.0.0	new_device	t	2025-06-10 18:10:20.308135	2025-06-13 08:59:42.622189
195	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-06-10 18:18:04.628219	2025-06-13 08:59:44.982153
199	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-13 22:08:55.501595	\N
200	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-13 22:13:51.777851	\N
198	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-06-11 19:06:41.209838	2025-06-13 16:04:48.960248
197	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 134.0.0	new_device	t	2025-06-11 12:11:59.493298	2025-06-13 16:04:50.724536
201	27	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	f	2025-06-13 23:35:08.726614	\N
203	17	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	f	2025-06-13 23:35:08.727205	\N
204	15	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	f	2025-06-13 23:35:08.727205	\N
205	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-17 20:04:13.101533	\N
206	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 00:30:58.953032	\N
207	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 00:56:15.234582	\N
208	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 01:22:32.713198	\N
209	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 01:30:49.734329	\N
210	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 02:35:29.304722	\N
211	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 02:40:11.227582	\N
213	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	t	2025-06-19 03:19:43.691157	2025-06-18 20:25:28.336089
212	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	t	2025-06-19 03:10:31.542393	2025-06-18 20:29:22.174073
216	7	Failed Login Attempt	5 failed login attempts detected. Your account has been temporarily locked.	failed_login	f	2025-06-19 04:01:05.276701	\N
217	7	Failed Login Attempt	10 failed login attempts detected. Your account has been temporarily locked.	failed_login	f	2025-06-19 04:12:07.834047	\N
218	28	Failed Login Attempt	5 failed login attempts detected. Your account has been temporarily locked.	failed_login	f	2025-06-19 04:25:21.314494	\N
223	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:36:55.	failed_login	t	2025-06-19 18:31:56.188061	2025-06-19 11:44:35.172791
214	3	Failed Login Attempt	5 failed login attempts detected. Your account has been temporarily locked.	failed_login	t	2025-06-19 03:41:26.052561	2025-06-21 19:31:36.119458
215	3	Failed Login Attempt	10 failed login attempts detected. Your account has been temporarily locked.	failed_login	t	2025-06-19 03:53:13.87709	2025-06-21 19:31:39.775395
219	3	Percobaan Login Gagal	Terdeteksi 10 kali percobaan login gagal. Akun Anda dikunci hingga pukul 10:47:32.	failed_login	t	2025-06-19 17:42:32.960806	2025-06-21 19:31:41.859542
222	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:24:34.	failed_login	t	2025-06-19 18:19:34.990696	2025-06-21 19:31:44.154423
225	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 19:41:44.	failed_login	t	2025-06-19 18:41:44.725558	2025-06-19 11:44:30.489968
224	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:42:04.	failed_login	t	2025-06-19 18:37:05.546239	2025-06-19 11:44:32.63451
229	27	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:02:03.661204	\N
231	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:02:03.662368	\N
232	15	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:02:03.663448	\N
233	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 19:02:45.518765	\N
234	27	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:06:51.883537	\N
236	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:06:57.869993	\N
237	15	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:07:00.930201	\N
238	27	New Permission Request	There is a new permission request from Abid Laqoo.	permission	f	2025-06-19 19:12:37.191976	\N
240	17	New Permission Request	There is a new permission request from Abid Laqoo.	permission	f	2025-06-19 19:12:43.056867	\N
241	15	New Permission Request	There is a new permission request from Abid Laqoo.	permission	f	2025-06-19 19:12:45.938728	\N
243	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 19:31:58.992759	\N
244	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-19 19:48:39.314865	\N
245	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 20:07:35.300335	\N
246	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-19 21:03:20.196529	\N
247	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 21:28:35.	failed_login	f	2025-06-19 21:23:36.184068	\N
248	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 22:29:41.	failed_login	f	2025-06-19 21:29:41.575959	\N
250	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	f	2025-06-21 17:29:17.410263	\N
253	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-22 02:30:03.132291	\N
249	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 22:13:30.	failed_login	t	2025-06-19 22:08:31.607626	2025-06-21 19:31:28.107371
252	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	t	2025-06-22 02:27:26.612479	2025-06-21 19:31:31.399342
227	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 19:51:32.	failed_login	t	2025-06-19 18:51:33.577738	2025-06-21 19:31:47.094407
226	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:50:03.	failed_login	t	2025-06-19 18:45:04.65232	2025-06-21 19:31:49.075898
228	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	t	2025-06-19 18:55:06.887418	2025-06-21 19:31:51.425268
254	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-22 02:57:32.173981	\N
255	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-22 03:02:26.93269	\N
256	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-22 03:28:40.002956	\N
257	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-22 03:57:17.690339	\N
258	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-22 03:58:09.163193	\N
259	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 04:04:03.	failed_login	f	2025-06-22 03:59:03.804423	\N
260	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 05:05:33.	failed_login	f	2025-06-22 04:05:34.57524	\N
261	30	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-22 04:40:37.767827	\N
262	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-22 04:47:35.920435	\N
251	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-06-21 20:26:37.789667	2025-06-29 13:26:17.903237
263	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-06-29 20:25:30.78887	2025-06-29 13:26:19.237925
264	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-06-29 21:28:46.467068	2025-06-29 14:28:58.330777
266	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-07-04 22:16:13.439473	2025-07-04 15:20:24.271445
265	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-07-02 10:27:34.430973	2025-07-04 15:26:37.579986
267	4	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-07-07 02:05:33.895228	\N
268	4	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-07 03:03:12.701518	\N
269	17	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-07 03:55:32.913846	\N
270	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-07-10 14:52:18.926865	\N
271	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-10 14:54:54.236271	\N
272	17	New Permission Request	There is a new permission request from Yustina Yunitaa.	permission	f	2025-07-10 20:02:21.190932	\N
273	15	New Permission Request	There is a new permission request from Yustina Yunitaa.	permission	f	2025-07-10 20:02:28.688374	\N
274	27	New Permission Request	There is a new permission request from Yustina Yunitaa.	permission	f	2025-07-10 20:02:36.168985	\N
275	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	f	2025-07-10 20:08:17.75505	\N
277	1	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-10 23:42:22.260648	\N
278	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-07-11 13:37:42.611829	\N
279	30	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-07-11 13:44:31.096113	\N
276	21	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 20:27:04.	failed_login	t	2025-07-10 20:22:04.657893	2025-07-11 07:02:40.869115
280	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:41.671027	\N
281	15	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:44.370404	\N
282	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:46.759423	\N
283	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:48.990646	\N
284	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:06:55.906739	\N
285	15	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:06:58.254837	\N
286	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:07:00.638655	\N
287	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:07:02.925474	\N
288	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:32.483605	\N
289	15	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:34.96533	\N
290	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:37.17348	\N
291	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:39.435791	\N
292	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-07-18 21:35:49.364835	2025-07-18 14:35:54.770493
293	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:45.574618	\N
294	15	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:49.335253	\N
295	27	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:52.715012	\N
296	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:56.094459	\N
297	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:04:59.392283	\N
298	15	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:05:03.500205	\N
299	27	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:05:06.885702	\N
300	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:05:10.477919	\N
301	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:25.701324	\N
302	15	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:31.293201	\N
303	27	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:34.931048	\N
304	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:38.341102	\N
305	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:21.134914	\N
306	15	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:24.33692	\N
307	27	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:27.612972	\N
308	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:30.577921	\N
309	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	f	2025-07-20 20:05:53.382275	\N
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.permissions (permissions_id, employee_id, permission_type, request_date, start_date, end_date, reason, permission_status, approved_date, user_id) FROM stdin;
10	2	sick-leave	2025-05-23	2025-05-23	2025-05-23	i got fever	Approved	2025-05-23	6
1	2	family-urgent	2025-05-19	2025-05-19	2025-05-21	Go to hospital	Approved	2025-05-22	6
4	1	family-urgent	2025-05-20	2025-05-20	2025-05-20	Cousin's wedding	Declined	2025-05-22	1
11	5	sick-leave	2025-05-23	2025-05-02	2025-05-10	My allergy flares up	Approved	2025-05-25	7
12	5	family-urgent	2025-05-23	2025-05-08	2025-05-17	Kid's sick	Approved	2025-05-25	7
13	5	personal-business	2025-05-23	2025-05-01	2025-05-02	Business Trip	Approved	2025-05-26	7
15	5	family-urgent	2025-05-23	2025-05-02	2025-05-10	Cousin's wedding	Approved	2025-05-26	7
16	5	personal-business	2025-05-23	2025-05-09	2025-05-17	Business Trip	Declined	2025-05-26	7
7	1	personal-business	2025-05-22	2025-05-23	2025-05-24	Business Trip	Approved	2025-05-22	1
3	1	sick-leave	2025-05-20	2025-05-20	2025-05-21	Headache	Approved	2025-05-22	1
22	1	sick-leave	2025-05-25	2025-05-20	2025-05-26	Headache	Approved	2025-05-25	1
14	5	family-urgent	2025-05-23	2025-05-10	2025-05-23	Cousin's wedding	Declined	2025-05-26	7
19	5	family-urgent	2025-05-23	2025-05-03	2025-05-10	Go to hospital	Pending	\N	7
21	5	family-urgent	2025-05-23	2025-05-03	2025-05-10	Go to hospital	Pending	\N	7
8	1	family-urgent	2025-05-22	2025-05-23	2025-05-24	Urgent Leave	Declined	2025-05-22	1
5	5	family-urgent	2025-05-20	2025-05-02	2025-05-10	Urgent Leave	Approved	2025-05-22	7
9	1	family-urgent	2025-05-22	2025-05-24	2025-05-25	Urgent Leave	Approved	2025-05-22	1
6	5	sick-leave	2025-05-20	2025-05-01	2025-05-03	GERD	Pending	\N	7
18	5	sick-leave	2025-05-23	2025-05-03	2025-05-10	Headache	Approved	2025-05-27	7
17	5	family-urgent	2025-05-23	2025-05-22	2025-06-03	Go to hospital	Declined	2025-05-27	7
20	12	personal-business	2025-05-23	2025-05-24	2025-05-24	Go to hospital	Approved	2025-05-27	21
23	12	family-urgent	2025-06-13	2025-06-16	2025-06-18	Cousin's Wedding	Pending	\N	21
25	15	personal-business	2025-06-19	2025-06-19	2025-08-02	mmm	Pending	\N	28
26	15	sick-leave	2025-06-19	2025-06-19	2025-09-27	mm	Pending	\N	28
24	15	sick-leave	2025-06-19	2025-07-10	2025-07-12	dedede	Approved	2025-07-10	28
27	12	sick-leave	2025-07-10	2025-07-11	2025-07-11	I got fever and stomachache	Approved	2025-07-10	21
30	1	personal-business	2025-07-11	2025-07-21	2025-07-23	Meeting	Pending	\N	1
28	1	personal-business	2025-07-11	2025-07-14	2025-07-15	Meeting 	Approved	2025-07-18	1
29	1	other	2025-07-11	2025-07-14	2025-07-15	Meeting	Declined	2025-07-18	1
31	20	family-urgent	2025-07-20	2025-07-01	2025-07-12	m	Pending	\N	30
32	20	sick-leave	2025-07-20	2025-07-05	2025-08-09	m	Pending	\N	30
33	20	sick-leave	2025-07-20	2025-07-16	2025-08-08	yy	Pending	\N	30
34	20	family-urgent	2025-07-20	2025-07-01	2025-07-18	kwkwkw	Pending	\N	30
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.roles (roles_id, roles_name) FROM stdin;
1	Super Admin
2	Admin
3	Employee
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public."user" (user_id, employee_id, username, email, password) FROM stdin;
7	5	penilai_nahdya@sidia.pglhk	maureengabriella1m@gmail.com	$2b$12$HhZnBLLmyhfRsS2wiH9N0O4h8L05yczDHUsRr/N/YIFc9Yvae.OG2
3	3	HR	nirwanaanisa1508@gmail.com	$2b$12$V5XqrJ75alWOUkkxT.yi2us/fRoV70yL5jxLEzCkuFbIzEHLOVBNK
4	4	SuperadminNab	nabila.libasutaqwa@student.president.ac.id	$2b$12$PaKgoLTSs5BP/JEF40n11ukzIxa04Umi65gyplrPX7uHGkaOAQP/.
26	16	jumi	juminten@gmail.com	$2b$12$RFItqDzM14PoZ4ATk8pZZO8rmv6ab/F/ua1aUiqqJKrN8SUQQeHl2
28	15	Abid	abid@gmail.com	$2b$12$I1.a5ptZKTMvhhwfimYZ0O1En0CJgYkCOkQmXDVHfvKc.JMgpPDIa
17	11	admin_nabila	nabilalb0109@gmail.com	$2b$12$vY6bp2xsUbSj3WrsbfAPt.Z6NTgzbOa97zYSFhhekVDaC8XJgMzo.
15	\N	admin_yuyus	gwenrosevyn@gmail.com	$2b$12$n6BJe5tRoj7WuGWc8i9D8OdFzZZyGLAuf7GhuQJP2YXcBOo0lohAe
21	12	yuyus	yustinayunitayy@gmail.com	$2b$12$oUIIzyyVooIUhSbT06hLzuqSPrR8uTbVT3yuPOGQhdv96daaQp5MC
6	2	yuyusdaily	yustinayunita86@gmail.com	$2b$12$JiauegZlw836RvjlRD0Gq.i3rhIvI.X7/cK.1Ya62C1rPs8XjZMRC
19	\N	superadmin	adelaideufrasia@gmail.com	$2b$12$9jeN9OEYKCN2rUJol0cUyOR3SoaRHUD/KfMISbt7DH/.EDSOu5A1u
27	17	angelinemoore	angelinemoore.notsafe@gmail.com	$2b$12$z7iCEhRyI0pk761QExmnfOEBCjoFkqQqzbICTXmTlCKXiaPjxOAo6
1	1	nblalbb	nabilalb2004@gmail.com	$2b$12$JnBtsYTTsnhcD5tkNlT1Geo.vttLhfjPMY.Cw5IKyRxHE3bsDFDRG
32	22	udin	annisanirwana94@yahoo.com	$2b$12$uP8iQ85Rl6qZ1HYkJYwnieozcOldvC3sEa7zDtoGoFwOzFHq1Ur/K
31	\N	NIS	anisa.n@student.president.ac.id	$2b$12$27sO1DKbfgiQPysnaBmPe.FsMfp0ylni7ruA/T9LxPzMkgVlAzFrG
30	20	Kyungsoo	anisa.nrwn15@gmail.com	$2b$12$svunw.4Pn3IS.8dCKYidYeUjXDL.ML2tmxAK/l/7l8pEhy23rGwf.
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.user_roles (user_id, roles_id) FROM stdin;
7	3
17	2
15	2
21	3
19	1
26	3
3	1
6	1
4	1
28	3
27	2
1	3
32	2
31	3
30	3
\.


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.activity_logs_log_id_seq', 725, true);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 458, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 23, true);


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.lock_system_lock_id_seq', 46, true);


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public."login_attempts_logAtt_id_seq"', 1658, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 309, true);


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.permissions_permissions_id_seq', 34, true);


--
-- Name: roles_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.roles_roles_id_seq', 1, false);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.user_user_id_seq', 33, true);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (log_id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- Name: employees employees_nrp_id_key; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_nrp_id_key UNIQUE (nrp_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: lock_system lock_system_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.lock_system
    ADD CONSTRAINT lock_system_pkey PRIMARY KEY (lock_id);


--
-- Name: login_attempts login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_pkey PRIMARY KEY ("logAtt_id");


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permissions_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (roles_id);


--
-- Name: roles roles_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_roles_name_key UNIQUE (roles_name);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, roles_id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: ix_activity_logs_log_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_activity_logs_log_id ON public.activity_logs USING btree (log_id);


--
-- Name: ix_attendance_attendance_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_attendance_attendance_id ON public.attendance USING btree (attendance_id);


--
-- Name: ix_employees_employee_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_employees_employee_id ON public.employees USING btree (employee_id);


--
-- Name: ix_login_attempts_email; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_login_attempts_email ON public.login_attempts USING btree (email);


--
-- Name: ix_login_attempts_logAtt_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX "ix_login_attempts_logAtt_id" ON public.login_attempts USING btree ("logAtt_id");


--
-- Name: ix_notifications_created_at; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_created_at ON public.notifications USING btree (created_at);


--
-- Name: ix_notifications_is_read; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_is_read ON public.notifications USING btree (is_read);


--
-- Name: ix_notifications_notification_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_notification_id ON public.notifications USING btree (notification_id);


--
-- Name: ix_notifications_notification_type; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_notification_type ON public.notifications USING btree (notification_type);


--
-- Name: ix_notifications_user_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_user_id ON public.notifications USING btree (user_id);


--
-- Name: ix_notifications_user_read; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_notifications_user_read ON public.notifications USING btree (user_id, is_read);


--
-- Name: ix_permissions_permissions_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_permissions_permissions_id ON public.permissions USING btree (permissions_id);


--
-- Name: ix_roles_roles_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_roles_roles_id ON public.roles USING btree (roles_id);


--
-- Name: ix_user_employee_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_user_employee_id ON public."user" USING btree (employee_id);


--
-- Name: ix_user_user_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_user_user_id ON public."user" USING btree (user_id);


--
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: attendance attendance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: lock_system lock_system_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.lock_system
    ADD CONSTRAINT lock_system_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(roles_id);


--
-- Name: login_attempts login_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: permissions permissions_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: permissions permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: user user_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: user_roles user_roles_roles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_roles_id_fkey FOREIGN KEY (roles_id) REFERENCES public.roles(roles_id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

