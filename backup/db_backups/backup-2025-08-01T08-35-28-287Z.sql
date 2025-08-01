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
    face_encoding text,
    join_date date NOT NULL
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
    role_id integer
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
    password character varying(500),
    activity_date timestamp with time zone
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
261	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 02:14:57.552324+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
264	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 02:46:19.246378+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
265	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-05-27 03:22:56.011375+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
266	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 13:27:41.738776+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
279	\N	Viewed employee profile	Viewed profile of employee ID 1	\N	2025-05-27 20:48:18.077268+00	\N
280	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 20:52:54.477512+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
398	\N	Updated user	User Abid updated successfully	\N	2025-06-17 19:53:44.720908+00	\N
262	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:15:51.005696+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
259	\N	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:13:15.82267+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
260	\N	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:13:46.294212+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
263	\N	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 02:24:29.803687+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
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
305	\N	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-06-07 08:07:32.587835+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
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
481	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:10:22.751213+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
482	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:13:42.840945+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
483	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:48:30.001327+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
484	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:26:22.84112+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
485	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:44:20.85543+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
486	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 11:55:12.015786+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
488	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:02:50.110484+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
491	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:16:18.525766+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
492	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:17:12.516571+00	\N
496	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:23:58.111155+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
497	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:24:56.01575+00	\N
498	\N	Updated user	User admin_nisa updated successfully	\N	2025-06-19 12:25:16.375341+00	\N
501	\N	Deleted user	User 14 deleted successfully	\N	2025-06-19 12:30:38.974114+00	\N
480	\N	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 10:04:26.990793+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
487	\N	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:01:39.180609+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
489	\N	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:06:12.776083+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
490	\N	Login	User driveanisa4@gmail.com logged in successfully	127.0.0.1	2025-06-19 12:12:14.056188+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
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
673	\N	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-11 06:43:01.972816+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
706	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:32:26.09429+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
707	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:35:53.922186+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Mobile Safari/537.36
709	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:49:29.113503+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
708	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:44:35.367542+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
711	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:54:55.526703+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
712	\N	Viewed employee profile	Kyungsoo viewed profile of employee ID 4	127.0.0.1	2025-07-18 15:01:54.965034+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
714	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-18 15:25:57.689912+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
719	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-20 13:05:55.645144+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
720	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:29:57.54619+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
721	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:48:12.877297+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
722	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:55:59.194282+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
724	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-23 18:02:00.973452+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
725	4	Added employee	Employee Bilee Libasutaqwa added by SuperadminNab	127.0.0.1	2025-07-23 18:02:30.266698+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
726	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-24 07:32:02.179079+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
727	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:07:17.801051+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
728	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-24 09:11:47.949119+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
729	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:13:02.888979+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
730	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:16:05.293309+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
731	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:16:56.428742+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
732	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-24 09:17:17.221292+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
733	6	Added employee	Employee tania isabela added by yuyusdaily	127.0.0.1	2025-07-24 09:18:37.376394+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
734	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 4	127.0.0.1	2025-07-24 09:18:45.181384+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
735	4	Updated employee	Employee Nabilla updated by SuperadminNab	127.0.0.1	2025-07-24 09:18:56.411938+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
737	4	Added employee	Employee Bilee Libasutaqwa added by SuperadminNab	127.0.0.1	2025-07-24 09:25:01.344263+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
736	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:22:25.108625+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
738	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:32:15.849642+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
739	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 25	127.0.0.1	2025-07-24 09:32:37.408166+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
740	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 25	127.0.0.1	2025-07-24 09:32:39.121973+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
741	6	Added employee	Employee tania isabela added by yuyusdaily	127.0.0.1	2025-07-24 09:33:25.205882+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
742	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 25	127.0.0.1	2025-07-24 09:33:40.174584+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
744	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:37:58.324596+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
710	\N	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-18 14:54:26.437026+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
746	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:44:18.033146+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
747	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:47:41.869858+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
748	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:48:26.14445+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
749	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:48:55.601992+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
750	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:49:19.858682+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
751	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:49:24.305569+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
687	\N	Updated user	User NIS updated successfully	127.0.0.1	2025-07-11 07:09:43.097152+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
752	3	Added employee	Employee Tania Yusnita added by HR	127.0.0.1	2025-07-24 09:54:30.338498+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
754	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-24 10:06:54.199759+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
756	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-24 10:09:17.926472+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
757	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 14:22:22.274283+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
743	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:34:43.588682+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
745	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-24 09:41:23.996495+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
755	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-24 10:07:57.066222+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
758	6	Added employee	Employee Dame Un GRR added by yuyusdaily	127.0.0.1	2025-07-26 14:24:12.798272+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
759	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 14:25:12.543003+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
760	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-26 14:31:22.985661+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
761	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:01:46.748118+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
762	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:02:20.307883+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
763	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:35:40.944534+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
767	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:38:11.846444+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
764	\N	Updated user	User dame updated successfully	127.0.0.1	2025-07-26 15:35:58.493089+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
765	\N	Updated user	User dame updated successfully	127.0.0.1	2025-07-26 15:35:58.564287+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
766	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:36:23.698606+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
768	6	Added employee	Employee Dame Un GRR added by yuyusdaily	127.0.0.1	2025-07-26 15:39:37.551849+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
770	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:56:12.139118+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
771	6	Added employee	Employee Yunita isabela added by yuyusdaily	127.0.0.1	2025-07-26 15:57:04.698429+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
773	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 16:03:12.008761+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
775	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 16:39:06.275126+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
753	\N	Login	User anisa.n@student.president.ac.id logged in successfully	127.0.0.1	2025-07-24 09:58:25.10825+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
865	3	Viewed employee profile	HR viewed profile of employee ID 4	127.0.0.1	2025-07-28 08:38:22.597418+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
776	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 16:59:20.934514+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
777	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-26 17:00:16.873782+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
778	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 15	127.0.0.1	2025-07-26 17:00:21.907875+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
779	6	Add employee failed	400: Employee with this NRP ID already exists	127.0.0.1	2025-07-26 17:00:48.361721+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
780	6	Added employee	Employee a a added by yuyusdaily	127.0.0.1	2025-07-26 17:01:02.429932+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
781	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 31	127.0.0.1	2025-07-26 17:01:04.788092+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
782	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 29	127.0.0.1	2025-07-26 17:04:30.522353+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
785	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-27 05:47:28.782201+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
786	6	Updated user	User yuyusdaily updated successfully	127.0.0.1	2025-07-27 05:49:42.049819+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
787	6	Updated user	User yuyusdaily updated successfully	127.0.0.1	2025-07-27 05:49:44.679673+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
788	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-27 05:57:15.451269+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
789	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-27 06:02:13.353528+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
791	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-27 06:33:27.31469+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
769	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 15:41:14.005853+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
772	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 16:02:32.170887+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
774	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 16:32:34.443188+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
783	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 17:09:36.714111+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
784	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-26 17:15:26.659755+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
790	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-27 06:30:37.325303+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
792	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-27 06:38:57.782115+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
793	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-27 08:38:05.078575+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
794	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-27 08:57:24.96434+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
795	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-27 09:44:54.045244+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
797	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-27 10:24:17.443672+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
798	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 11:25:41.32571+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
799	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 11:37:00.230796+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
800	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 11:38:16.433775+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
801	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 11:59:47.176165+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
802	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-27 13:36:50.15567+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
803	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-27 13:37:54.813488+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
804	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 14:38:46.992324+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
805	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 1	127.0.0.1	2025-07-27 14:40:09.865679+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
806	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 25	127.0.0.1	2025-07-27 14:40:34.344343+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
807	4	Updated employee	Employee Bilee updated by SuperadminNab	127.0.0.1	2025-07-27 14:40:43.565259+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
808	4	Added employee	Employee Bilee Libasutaqwa added by SuperadminNab	127.0.0.1	2025-07-27 14:46:01.264337+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
809	4	Deleted employee	Employee 32, linked user, permission, and attendance data deleted successfully	127.0.0.1	2025-07-27 14:46:10.941788+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
810	4	Added employee	Employee Bilee Libasutaqwa added by SuperadminNab	127.0.0.1	2025-07-27 14:48:26.605997+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
811	4	Deleted employee	Employee 33, linked user, permission, and attendance data deleted successfully by SuperadminNab	127.0.0.1	2025-07-27 14:48:35.348041+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
812	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-27 14:53:37.279665+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
813	27	Added employee	Employee Dame Un GRR added by angelinemoore	127.0.0.1	2025-07-27 14:59:21.358802+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
816	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 16:05:37.58822+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
817	4	Created user	User nabs created successfully	127.0.0.1	2025-07-27 16:31:21.616371+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
818	4	Deleted user	User 47 deleted successfully by SuperadminNab	127.0.0.1	2025-07-27 16:33:07.724342+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
819	4	Updated user	User nblalb updated successfully by SuperadminNab	127.0.0.1	2025-07-27 16:33:46.313212+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
820	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 17:35:56.156195+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
821	4	Manage Role Lock	Role locked successfully for role: Admin by SuperadminNab	127.0.0.1	2025-07-27 17:47:20.110399+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
822	4	Manage Role Lock	Role unlocked successfully for role: Admin by SuperadminNab	127.0.0.1	2025-07-27 17:48:14.888873+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
823	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-27 17:50:57.158102+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
824	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-27 18:24:12.441255+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
825	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 18:25:58.253456+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
826	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-27 18:27:59.381981+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
827	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-27 18:32:14.14049+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
828	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-07-27 18:33:30.183233+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
829	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 06:16:27.232437+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
834	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:10:57.210443+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
835	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:12:39.175294+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
836	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:15:38.292549+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
837	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:16:23.795059+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
838	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:16:47.473459+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
839	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:17:22.564822+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
814	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-27 15:02:24.856218+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
815	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-27 15:15:01.795717+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
830	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 06:24:06.830741+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
831	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 06:31:49.988307+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
832	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 06:45:50.477503+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
833	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 06:46:54.708375+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
840	6	Deleted employee	Employee 34, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-07-28 07:17:46.077263+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
841	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-28 07:19:19.120693+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
842	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:19:27.309792+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
843	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:19:45.636498+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
844	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:20:04.206919+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
845	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:20:54.686421+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
846	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:20:58.168196+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
847	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:21:54.46214+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
796	\N	Login	User anisa.n@student.president.ac.id logged in successfully	127.0.0.1	2025-07-27 09:48:44.109537+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
848	3	Deleted user	User 38 deleted successfully by HR	127.0.0.1	2025-07-28 07:34:39.085468+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
849	3	Added employee	Employee Tania yunita added by HR	127.0.0.1	2025-07-28 07:43:42.649231+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
850	3	Created user	User tania created successfully by HR	127.0.0.1	2025-07-28 07:46:22.473029+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
851	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:54:57.422211+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
852	48	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:56:19.575702+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
853	48	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:58:51.522872+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
854	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-28 08:08:36.132342+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
855	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-28 08:26:34.583642+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
856	3	Manage Role Lock	Role locked successfully for role: Employee by HR	127.0.0.1	2025-07-28 08:30:56.674143+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
857	3	Manage Role Lock	Role locked successfully for role: Admin by HR	127.0.0.1	2025-07-28 08:31:10.72219+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
858	3	Manage Role Lock	Role unlocked successfully for role: Admin by HR	127.0.0.1	2025-07-28 08:31:24.722404+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
859	3	Manage Role Lock	Role unlocked successfully for role: Employee by HR	127.0.0.1	2025-07-28 08:31:28.161662+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
860	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-28 08:31:54.200997+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
861	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 08:32:02.866914+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
862	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-28 08:32:52.326845+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
863	27	Viewed employee profile	angelinemoore viewed profile of employee ID 15	127.0.0.1	2025-07-28 08:37:53.255764+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
864	27	Viewed employee profile	angelinemoore viewed profile of employee ID 15	127.0.0.1	2025-07-28 08:38:07.876941+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
866	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 08:55:59.290631+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
868	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-07-28 09:09:37.645788+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
867	48	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:01:45.490284+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
869	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:10:15.085262+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
870	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:10:42.694103+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
567	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:39:24.70232+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0
568	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-06-21 21:40:39.846254+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36
674	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-11 06:44:39.701599+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
704	\N	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-18 14:13:03.474922+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
705	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-18 14:14:05.508465+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
713	\N	Viewed employee profile	Kyungsoo viewed profile of employee ID 15	127.0.0.1	2025-07-18 15:05:41.22371+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
715	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 11:57:56.919715+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
716	\N	Updated user	User Kyungsoo updated successfully	127.0.0.1	2025-07-20 11:58:23.818771+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
717	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 11:58:58.726554+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
718	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-20 12:30:57.093004+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
723	\N	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-23 17:57:34.060619+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
871	3	Deleted user	User 30 deleted successfully by HR	127.0.0.1	2025-07-28 09:11:26.313064+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
872	3	Viewed employee profile	HR viewed profile of employee ID 20	127.0.0.1	2025-07-28 09:12:12.941673+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
873	3	Deleted employee	Employee 20, linked user, permission, and attendance data deleted successfully by HR	127.0.0.1	2025-07-28 09:12:20.694501+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
874	3	Added employee	Employee do kyungso added by HR	127.0.0.1	2025-07-28 09:13:12.328482+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
875	3	Created user	User ucooo created successfully by HR	127.0.0.1	2025-07-28 09:13:57.899522+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
876	49	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:14:42.187489+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
877	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:26:17.969511+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
878	48	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:30:13.724945+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
879	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-07-30 12:47:28.296435+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
880	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 13:44:19.945952+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
881	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 15	127.0.0.1	2025-07-30 13:45:11.190415+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
882	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 15	127.0.0.1	2025-07-30 13:45:14.332921+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
883	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 15	127.0.0.1	2025-07-30 13:56:49.495747+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
884	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 15	127.0.0.1	2025-07-30 13:56:54.096108+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
885	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 17	127.0.0.1	2025-07-30 13:57:22.512397+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
886	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 36	127.0.0.1	2025-07-30 13:57:25.049476+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
887	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-30 14:49:51.281379+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
888	27	Updated user	User Abid updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:51:16.953969+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
889	27	Updated user	User angelinemoore updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:51:56.987824+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
890	27	Updated user	User HR updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:52:12.098171+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
891	27	Updated user	User ucooo updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:52:21.160131+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
892	27	Updated user	User jumi updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:52:33.836109+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
893	27	Updated user	User penilai_nahdya@sidia.pglhk updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:52:45.671768+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
896	27	Updated user	User SuperadminNab updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:53:26.237051+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
900	27	Updated user	User yuyus updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:54:42.729219+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
894	27	Updated user	User nblalb updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:52:57.486174+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
895	27	Updated user	User admin_nabila updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:53:13.694088+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
897	27	Updated user	User hola updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:53:47.412067+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
898	27	Updated user	User tania updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:54:07.231759+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
899	27	Updated user	User udin updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:54:25.882015+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
901	27	Updated user	User yuyusdaily updated successfully by angelinemoore	127.0.0.1	2025-07-30 14:54:56.313743+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
902	27	Viewed employee profile	angelinemoore viewed profile of employee ID 15	127.0.0.1	2025-07-30 14:56:33.088351+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
903	27	Viewed employee profile	angelinemoore viewed profile of employee ID 15	127.0.0.1	2025-07-30 14:56:36.957425+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
904	27	Deleted employee	Employee 15, linked user, permission, and attendance data deleted successfully by angelinemoore	127.0.0.1	2025-07-30 14:56:46.745416+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
905	27	Viewed employee profile	angelinemoore viewed profile of employee ID 17	127.0.0.1	2025-07-30 14:56:49.115945+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
906	27	Viewed employee profile	angelinemoore viewed profile of employee ID 3	127.0.0.1	2025-07-30 14:56:52.561975+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
907	27	Viewed employee profile	angelinemoore viewed profile of employee ID 36	127.0.0.1	2025-07-30 14:56:55.481981+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
908	27	Viewed employee profile	angelinemoore viewed profile of employee ID 16	127.0.0.1	2025-07-30 14:56:58.536662+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
909	27	Deleted employee	Employee 16, linked user, permission, and attendance data deleted successfully by angelinemoore	127.0.0.1	2025-07-30 14:57:05.855253+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
910	27	Viewed employee profile	angelinemoore viewed profile of employee ID 5	127.0.0.1	2025-07-30 14:57:08.392345+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
911	27	Viewed employee profile	angelinemoore viewed profile of employee ID 1	127.0.0.1	2025-07-30 14:57:14.632495+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
912	27	Viewed employee profile	angelinemoore viewed profile of employee ID 14	127.0.0.1	2025-07-30 14:57:17.382485+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
913	27	Viewed employee profile	angelinemoore viewed profile of employee ID 35	127.0.0.1	2025-07-30 14:57:24.892998+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
914	27	Viewed employee profile	angelinemoore viewed profile of employee ID 27	127.0.0.1	2025-07-30 14:57:28.523347+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
915	27	Viewed employee profile	angelinemoore viewed profile of employee ID 22	127.0.0.1	2025-07-30 14:57:37.170269+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
916	27	Viewed employee profile	angelinemoore viewed profile of employee ID 2	127.0.0.1	2025-07-30 14:57:39.887389+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
917	27	Viewed employee profile	angelinemoore viewed profile of employee ID 12	127.0.0.1	2025-07-30 14:57:42.43648+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
918	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-30 15:30:47.238313+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
919	27	Viewed user data	angelinemoore viewed data of user ID 27	127.0.0.1	2025-07-30 15:30:56.147765+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
920	27	Viewed user data	angelinemoore viewed data of user ID 27	127.0.0.1	2025-07-30 15:31:17.866851+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
921	27	Viewed user data	angelinemoore viewed data of user ID 27	127.0.0.1	2025-07-30 15:31:30.922086+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
922	27	Updated user	User yuyusdaily updated successfully by angelinemoore	127.0.0.1	2025-07-30 15:48:17.998888+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
923	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 15:49:52.100367+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
924	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 15:55:27.884642+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
925	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:56:19.629081+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
926	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:56:30.629341+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
927	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:57:07.846401+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
928	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:57:12.710734+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
929	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:57:19.521784+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
930	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 15:57:25.542993+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
931	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-30 16:02:16.060797+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
932	27	Updated user	User yuyusdaily updated successfully by angelinemoore	127.0.0.1	2025-07-30 16:02:28.518094+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
933	27	Updated user	User yuyus updated successfully by angelinemoore	127.0.0.1	2025-07-30 16:02:41.85171+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
934	27	Deleted employee	Employee 5, linked user, permission, and attendance data deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:07:27.899348+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
935	27	Viewed employee profile	angelinemoore viewed profile of employee ID 14	127.0.0.1	2025-07-30 16:07:34.224897+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
936	27	Deleted employee	Employee 14, linked user, permission, and attendance data deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:07:39.272683+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
937	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 16:08:26.876987+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
938	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:08:39.960184+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
939	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:08:45.977507+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
940	6	Added employee	Employee a a added by yuyusdaily	127.0.0.1	2025-07-30 16:10:01.049453+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
941	6	Created user	User aaaa created successfully by yuyusdaily	127.0.0.1	2025-07-30 16:10:12.40875+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
942	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 16:16:00.024463+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
943	6	Updated user	User angelinemoore updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:16:12.066842+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
944	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:16:20.011113+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
945	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:16:27.1481+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
946	6	Updated user	User tania updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:16:36.416684+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
947	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:18:14.096365+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
948	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:24:11.23379+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
949	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:24:24.387578+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
950	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:24:25.389378+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
951	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:24:32.136744+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
952	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:25:46.538327+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
953	6	Updated user	User aaaa updated successfully by yuyusdaily	127.0.0.1	2025-07-30 16:31:52.591835+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
954	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-30 16:46:57.107446+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
955	27	Deleted user	User 50 deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:47:09.482581+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
956	27	Created user	User aa created successfully by angelinemoore	127.0.0.1	2025-07-30 16:47:33.906527+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
957	27	Deleted user	User 51 deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:49:02.018129+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
958	27	Created user	User yustinayunitayy@gmail.com created successfully by angelinemoore	127.0.0.1	2025-07-30 16:49:16.61594+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
959	27	Updated user	User yustinayunitayy@gmail.com updated successfully by angelinemoore	127.0.0.1	2025-07-30 16:49:53.581342+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
960	27	Deleted user	User 52 deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:50:01.924074+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
961	27	Created user	User yustinayunitayy@gmail.com created successfully by angelinemoore	127.0.0.1	2025-07-30 16:50:14.044189+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
962	27	Updated user	User yustinayunitayy@gmail.com updated successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:03.880729+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
963	27	Updated user	User yustinayunitayy@gmail.com updated successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:04.345909+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
964	27	Deleted user	User 53 deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:09.822053+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
965	27	Created user	User yustinayunitayy@gmail.com created successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:18.053147+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
966	27	Deleted user	User 54 deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:25.523173+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
967	27	Deleted employee	Employee 37, linked user, permission, and attendance data deleted successfully by angelinemoore	127.0.0.1	2025-07-30 16:55:31.951185+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
968	27	Viewed employee profile	angelinemoore viewed profile of employee ID 17	127.0.0.1	2025-07-30 16:58:35.827885+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
969	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-07-30 17:00:29.801779+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
970	6	Updated user	User admin_nabila updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:00:46.032675+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
971	6	Updated user	User SuperadminNab updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:00:56.858718+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
972	6	Updated user	User angelinemoore updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:02:18.427827+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
973	6	Updated user	User HR updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:02:33.232386+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
974	6	Updated user	User ucooo updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:02:43.311886+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
975	6	Updated user	User nblalb updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:02:55.591009+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
976	6	Updated user	User admin_nabila updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:05.981382+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
977	6	Updated user	User SuperadminNab updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:16.098773+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
978	6	Updated user	User tania updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:26.144535+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
979	6	Updated user	User udin updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:36.598881+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
980	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:43.935454+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
981	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:03:51.105074+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
982	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:14:31.198046+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
983	6	Created user	User yustinayunita86@gmail.com created successfully by yuyusdaily	127.0.0.1	2025-07-30 17:16:08.091266+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
984	6	Updated user	User yustinayunita86@gmail.com updated successfully by yuyusdaily	127.0.0.1	2025-07-30 17:16:29.743623+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
985	6	Deleted user	User 55 deleted successfully by yuyusdaily	127.0.0.1	2025-07-30 17:16:47.754792+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
986	6	Created user	User yustinayunita86@gmail.com created successfully by yuyusdaily	127.0.0.1	2025-07-30 17:16:59.994584+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
987	6	Deleted user	User 56 deleted successfully by yuyusdaily	127.0.0.1	2025-07-30 17:17:07.75936+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
988	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-07-31 14:12:16.71442+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.alembic_version (version_num) FROM stdin;
2f96a70abba6
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.attendance (attendance_id, employee_id, attendance_date, late, attendance_status, clock_in, clock_in_latitude, clock_in_longitude, clock_in_verified, clock_in_reason, clock_in_distance, clock_out, clock_out_latitude, clock_out_longitude, clock_out_verified, clock_out_reason, clock_out_distance, face_verified, working_hour, overtime) FROM stdin;
3	12	2025-06-02	0	Punch Out	07:30:54	-6.48021	106.865781	t	\N	0.4222500784865703	17:27:49	-6.458581	106.856179	t	Picked up family member after work\n\n	0.1439606057936991	t	35815	3415
27	12	2025-06-10	0	Punch Out	07:36:39	-6.48473	106.835542	t	\N	0.2510157726308077	17:33:23	-6.48473	106.835542	t	Traffic	0.2582760009895972	t	35804	3404
30	12	2025-06-11	0	Punch Out	07:43:07	-6.458581	106.856179	t	\N	0.2823114308002099	17:07:23	-6.48473	106.835542	t	External training	0.3819051654483383	t	33856	1456
87	12	2025-06-30	243	Punch Out	08:04:03	-6.458581	106.856179	t	GPS Error	0.3289156355495634	17:22:38	-6.48021	106.865781	t	Traffic	0.4158537361219516	t	33515	1115
102	12	2025-07-03	424	Punch Out	08:07:04	-6.48473	106.835542	t	Vehicle Breakdown	0.5873184993167568	16:39:48	-6.458581	106.856179	t	Felt unwell	0.3253960565900234	t	30764	0
186	12	2025-07-17	9	Punch Out	08:00:09	-6.48021	106.865781	t	Overslept	0.3421569055252175	17:40:21	-6.458581	106.856179	t	External training	0.2193031811576174	t	34812	2412
192	12	2025-07-18	0	Punch Out	07:38:11	-6.458581	106.856179	t	\N	0.1264859352668193	17:32:30	-6.458581	106.856179	t	External training	0.5451405561517504	t	35659	3259
180	12	2025-07-16	0	Punch Out	07:54:07	-6.48473	106.835542	t	\N	0.2212209066377993	17:19:32	-6.458581	106.856179	t	Client meeting	0.2470123227570862	t	33925	1525
24	12	2025-06-09	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
37	1	2025-06-14	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
39	12	2025-06-14	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
40	1	2025-06-15	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
42	12	2025-06-15	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
114	12	2025-07-05	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
118	1	2025-07-06	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
78	12	2025-06-27	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
79	1	2025-06-28	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
117	27	2025-07-05	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
82	1	2025-06-29	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
112	1	2025-07-05	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
159	27	2025-07-12	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
160	1	2025-07-13	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
162	12	2025-07-13	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
165	27	2025-07-13	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
166	1	2025-07-14	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
172	1	2025-07-15	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
150	12	2025-07-11	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
154	1	2025-07-12	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
207	27	2025-07-20	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
36	12	2025-06-13	0	Punch Out	07:39:30	-6.48473	106.835542	t	\N	0.3917414786432555	17:18:51	-6.458581	106.856179	t	External training	0.1920983344746093	t	34761	2361
48	12	2025-06-17	0	Punch Out	07:51:26	-6.48473	106.835542	t	\N	0.4470114875001813	17:57:37	-6.458581	106.856179	t	Client meeting outside	0.5056224197081575	t	36371	3971
33	12	2025-06-12	138	Punch Out	08:02:18	-6.458581	106.856179	t	Overslept	0.1685562812213936	17:05:56	-6.48021	106.865781	t	Client meeting outside	0.2638717773820157	t	32618	218
57	12	2025-06-20	0	Punch Out	07:50:05	-6.458581	106.856179	t	\N	0.53067402001119	17:53:23	-6.48473	106.835542	t	Client meeting	0.2610236695697169	t	36198	3798
54	12	2025-06-19	64	Punch Out	08:01:04	-6.48021	106.865781	t	GPS Error	0.3734998841840104	17:58:30	-6.48021	106.865781	t	Client meeting	0.1701483418730249	t	35846	3446
16	1	2025-06-07	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
18	12	2025-06-07	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
58	1	2025-06-21	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
19	1	2025-06-08	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
13	1	2025-06-06	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
15	12	2025-06-06	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
21	12	2025-06-08	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
22	1	2025-06-09	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
1	1	2025-06-02	0	Punch Out	07:43:06	-6.473104	106.851692	t	\N	0.2132892210013395	17:57:22	-6.472422	106.852744	t	\N	0.4236731400763928	t	36856	4456
4	1	2025-06-03	1165	Punch Out	08:19:25	-6.473104	106.851692	t	\N	0.5686231360844837	16:36:22	-6.472424	106.853749	t	\N	0.4367242746603711	t	29817	0
7	1	2025-06-04	663	Punch Out	08:11:03	-6.472424	106.853749	t	\N	0.3990305415095083	17:04:25	-6.473104	106.851692	t	\N	0.3973970683967649	t	32002	0
10	1	2025-06-05	108	Punch Out	08:01:48	-6.472424	106.853749	t	\N	0.3516679046275626	17:24:34	-6.473104	106.851692	t	\N	0.1393255319248735	t	33766	1366
12	12	2025-06-05	906	Punch Out	08:15:06	-6.48021	106.865781	t	Client Meeting	0.4248861002768055	16:39:05	-6.48021	106.865781	t	Felt unwell	0.1897417641978472	t	30239	0
25	1	2025-06-10	0	Punch Out	07:41:58	-6.473104	106.851692	t	\N	0.1939908069226278	17:49:36	-6.473104	106.851692	t	\N	0.5796413396336717	t	36458	4058
28	1	2025-06-11	0	Punch Out	07:45:51	-6.472424	106.853749	t	\N	0.4863485000201168	16:48:08	-6.472422	106.852744	t	\N	0.2601314280756029	t	32537	137
31	1	2025-06-12	567	Punch Out	08:09:27	-6.472422	106.852744	t	\N	0.3139517655261124	16:42:29	-6.472422	106.852744	t	\N	0.5385297174456738	t	30782	0
34	1	2025-06-13	0	Punch Out	07:56:17	-6.473104	106.851692	t	\N	0.3863964492280036	16:38:09	-6.472424	106.853749	t	\N	0.1414003655939923	t	31312	0
43	1	2025-06-16	1070	Punch Out	08:17:50	-6.472422	106.852744	t	\N	0.5090147352570173	17:47:29	-6.472422	106.852744	t	\N	0.4089118431748285	t	34179	1779
45	12	2025-06-16	0	Punch Out	07:34:20	-6.458581	106.856179	t	\N	0.5826378172109541	16:47:34	-6.48473	106.835542	t	Went home early	0.3566931600435734	t	33194	794
46	1	2025-06-17	488	Punch Out	08:08:08	-6.472424	106.853749	t	\N	0.1122591143381517	16:41:07	-6.472422	106.852744	t	\N	0.4747605185623074	t	30779	0
49	1	2025-06-18	435	Punch Out	08:07:15	-6.473104	106.851692	t	\N	0.1660594336723091	17:00:07	-6.473104	106.851692	t	\N	0.2626485395042676	t	31972	0
51	12	2025-06-18	1492	Punch Out	08:24:52	-6.458581	106.856179	t	Vehicle Breakdown	0.4302545748709121	17:11:47	-6.48021	106.865781	t	Family emergency	0.4844627442202213	t	31615	0
52	1	2025-06-19	0	Punch Out	07:39:54	-6.473104	106.851692	t	\N	0.1251988729554018	17:48:59	-6.472422	106.852744	t	\N	0.2508585058947881	t	36545	4145
55	1	2025-06-20	318	Punch Out	08:05:18	-6.473104	106.851692	t	\N	0.4720526191801201	16:58:17	-6.472424	106.853749	t	\N	0.5594754011311857	t	31979	0
64	1	2025-06-23	0	Punch Out	07:53:38	-6.473104	106.851692	t	\N	0.385838206815628	16:39:06	-6.473104	106.851692	t	\N	0.475957190142996	t	31528	0
66	12	2025-06-23	462	Punch Out	08:07:42	-6.48473	106.835542	t	GPS Error	0.5755240666936201	16:30:50	-6.48021	106.865781	t	Went home early	0.167485873395814	t	30188	0
67	1	2025-06-24	1531	Punch Out	08:25:31	-6.473104	106.851692	t	\N	0.1649174064538184	16:36:50	-6.472424	106.853749	t	\N	0.1119142634428125	t	29479	0
70	1	2025-06-25	0	Punch Out	07:52:35	-6.473104	106.851692	t	\N	0.2132161599715081	17:49:45	-6.473104	106.851692	t	\N	0.2260064724922437	t	35830	3430
72	12	2025-06-25	0	Punch Out	07:37:47	-6.48021	106.865781	t	\N	0.2394582913192711	16:45:42	-6.48473	106.835542	t	Went home early	0.5127129345157067	t	32875	475
73	1	2025-06-26	0	Punch Out	07:30:22	-6.472424	106.853749	t	\N	0.3370929242359798	17:20:46	-6.472424	106.853749	t	\N	0.4209345512975482	t	35424	3024
85	1	2025-06-30	108	Punch Out	08:01:48	-6.473104	106.851692	t	\N	0.4523691697955591	16:55:42	-6.472422	106.852744	t	\N	0.181894034670752	t	32034	0
88	1	2025-07-01	0	Punch Out	07:33:47	-6.473104	106.851692	t	\N	0.5783535574752102	16:36:39	-6.473104	106.851692	t	\N	0.105961302904352	t	32572	172
90	12	2025-07-01	0	Punch Out	07:45:41	-6.458581	106.856179	t	\N	0.5188151566230441	17:54:47	-6.48473	106.835542	t	Finished late	0.4122382784225684	t	36546	4146
93	27	2025-07-01	1319	Punch Out	08:21:59	-6.473104	106.851692	t	\N	0.1880926688010851	17:09:50	-6.472424	106.853749	t	\N	0.4827471602254044	t	31671	0
94	1	2025-07-02	0	Punch Out	07:49:38	-6.472422	106.852744	t	\N	0.5200238435947641	16:31:09	-6.472424	106.853749	t	\N	0.3472142099333847	t	31291	0
96	12	2025-07-02	0	Punch Out	07:37:43	-6.48473	106.835542	t	\N	0.3809984879901234	17:57:27	-6.48473	106.835542	t	Finished late	0.537947057600453	t	37184	4784
99	27	2025-07-02	0	Punch Out	07:50:03	-6.472424	106.853749	t	\N	0.3425835222747343	17:20:55	-6.473104	106.851692	t	\N	0.3769820690333703	t	34252	1852
100	1	2025-07-03	0	Punch Out	07:37:53	-6.472424	106.853749	t	\N	0.5452425232746203	17:48:07	-6.473104	106.851692	t	\N	0.5305854475840168	t	36614	4214
105	27	2025-07-03	131	Punch Out	08:02:11	-6.472422	106.852744	t	\N	0.1053883168534568	16:52:34	-6.472422	106.852744	t	\N	0.3157964041934155	t	31823	0
106	1	2025-07-04	0	Punch Out	07:52:19	-6.473104	106.851692	t	\N	0.5687409088467008	17:22:59	-6.472424	106.853749	t	\N	0.2718703126885045	t	34240	1840
111	27	2025-07-04	610	Punch Out	08:10:10	-6.473104	106.851692	t	\N	0.5761720969088029	17:09:04	-6.472422	106.852744	t	\N	0.5406000035934792	t	32334	0
108	12	2025-07-04	1197	Punch Out	08:19:57	-6.48021	106.865781	t	Heavy Traffic	0.2433473427495785	17:16:16	-6.458581	106.856179	t	Have a Doctor Appoinment	0.4458468306557256	t	32179	0
60	12	2025-06-21	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
61	1	2025-06-22	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
63	12	2025-06-22	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
76	1	2025-06-27	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
81	12	2025-06-28	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
84	12	2025-06-29	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
124	1	2025-07-07	676	Punch Out	08:11:16	-6.473104	106.851692	t	\N	0.5281226598245311	16:46:07	-6.472424	106.853749	t	\N	0.5376516422277063	t	30891	0
129	27	2025-07-07	1534	Punch Out	08:25:34	-6.472424	106.853749	t	\N	0.324307818616934	17:50:18	-6.472424	106.853749	t	\N	0.2123029430073192	t	33884	1484
130	1	2025-07-08	0	Punch Out	07:32:54	-6.473104	106.851692	t	\N	0.1472348814726012	17:02:49	-6.472422	106.852744	t	\N	0.5617173844980989	t	34195	1795
135	27	2025-07-08	0	Punch Out	07:39:22	-6.473104	106.851692	t	\N	0.3747496162208507	16:43:29	-6.472424	106.853749	t	\N	0.3179712574053531	t	32647	247
136	1	2025-07-09	0	Punch Out	07:49:54	-6.472422	106.852744	t	\N	0.55971539316378	16:40:41	-6.472422	106.852744	t	\N	0.5437640309664818	t	31847	0
138	12	2025-07-09	0	Punch Out	07:41:27	-6.48473	106.835542	t	\N	0.4509125109093783	17:04:08	-6.48021	106.865781	t	Felt unwell	0.3492249404491005	t	33761	1361
141	27	2025-07-09	945	Punch Out	08:15:45	-6.472424	106.853749	t	\N	0.3769343300819584	17:31:53	-6.472424	106.853749	t	\N	0.5469260127389399	t	33368	968
142	1	2025-07-10	0	Punch Out	07:50:53	-6.472424	106.853749	t	\N	0.5335811715689723	17:42:16	-6.472422	106.852744	t	\N	0.4951094721960346	t	35483	3083
147	27	2025-07-10	1582	Punch Out	08:26:22	-6.473104	106.851692	t	\N	0.5300432578855283	16:55:53	-6.473104	106.851692	t	\N	0.3801414797637092	t	30571	0
148	1	2025-07-11	721	Punch Out	08:12:01	-6.472424	106.853749	t	\N	0.2219247062932981	17:43:21	-6.472422	106.852744	t	\N	0.1230318992126737	t	34280	1880
153	27	2025-07-11	0	Punch Out	07:51:10	-6.472422	106.852744	t	\N	0.495664799711429	16:50:32	-6.472422	106.852744	t	\N	0.1556123874237276	t	32362	0
171	27	2025-07-14	0	Punch Out	07:41:57	-6.472422	106.852744	t	\N	0.3428588043225745	17:03:35	-6.472422	106.852744	t	\N	0.5299671846662017	t	33698	1298
177	27	2025-07-15	260	Punch Out	08:04:20	-6.472422	106.852744	t	\N	0.1281539479415487	17:21:43	-6.472424	106.853749	t	\N	0.2346423315254456	t	33443	1043
178	1	2025-07-16	918	Punch Out	08:15:18	-6.473104	106.851692	t	\N	0.1130023394113955	17:51:42	-6.472424	106.853749	t	\N	0.472256245648935	t	34584	2184
144	12	2025-07-10	1074	Punch Out	08:17:54	-6.458581	106.856179	t	Overslept	0.4292439935505095	16:33:27	-6.458581	106.856179	t	Felt unwell	0.1040591042186166	t	29733	0
168	12	2025-07-14	1372	Punch Out	08:22:52	-6.48021	106.865781	t	Client Meeting	0.3746008314329702	16:38:38	-6.48473	106.835542	t	Went Home Early	0.2022549535461525	t	29746	0
174	12	2025-07-15	0	Punch Out	07:36:10	-6.48021	106.865781	t	\N	0.3886568339820697	16:50:52	-6.48473	106.835542	t	Client meeting	0.4094541247392527	t	33282	882
120	12	2025-07-06	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
123	27	2025-07-06	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
156	12	2025-07-12	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
183	27	2025-07-16	1397	Punch Out	08:23:17	-6.472422	106.852744	t	\N	0.2634693294693885	17:35:45	-6.472422	106.852744	t	\N	0.5255700072267945	t	33148	748
184	1	2025-07-17	605	Punch Out	08:10:05	-6.472422	106.852744	t	\N	0.5875097809665365	16:34:54	-6.472422	106.852744	t	\N	0.1193272189565999	t	30289	0
189	27	2025-07-17	0	Punch Out	07:40:34	-6.473104	106.851692	t	\N	0.3293905528212681	16:31:11	-6.473104	106.851692	t	\N	0.5119547311857667	t	31837	0
190	1	2025-07-18	0	Punch Out	07:58:00	-6.473104	106.851692	t	\N	0.3354611546803096	17:39:24	-6.472422	106.852744	t	\N	0.1994021158598616	t	34884	2484
195	27	2025-07-18	1034	Punch Out	08:17:14	-6.472422	106.852744	t	\N	0.4907997009050501	16:45:00	-6.473104	106.851692	t	\N	0.518831784606477	t	30466	0
210	12	2025-07-21	468	Punch Out	08:07:48	-6.48473	106.835542	t	Vehicle Breakdown	0.5190100611249776	17:32:44	-6.458581	106.856179	t	Overtime	0.4236750333114092	t	33896	1496
213	27	2025-07-21	1363	Punch Out	08:22:43	-6.472424	106.853749	t	\N	0.3818622933949811	17:07:00	-6.472422	106.852744	t	\N	0.2033776247767116	t	31457	0
216	12	2025-07-22	1359	Punch Out	08:22:39	-6.48021	106.865781	t	Client Meeting	0.1348153662908209	16:39:00	-6.48473	106.835542	t	Had appointment	0.4893686077167323	t	29781	0
219	27	2025-07-22	0	Punch Out	07:36:31	-6.472424	106.853749	t	\N	0.3228712158203546	16:39:22	-6.472422	106.852744	t	\N	0.4387302826975809	t	32571	171
225	27	2025-07-23	1506	Punch Out	08:25:06	-6.473104	106.851692	t	\N	0.4526280227408143	16:38:55	-6.472422	106.852744	t	\N	0.5096647227948149	t	29629	0
226	1	2025-07-24	0	Punch Out	07:48:08	-6.472424	106.853749	t	\N	0.3248271178443993	17:58:17	-6.472424	106.853749	t	\N	0.5806576246259837	t	36609	4209
228	12	2025-07-24	0	Punch Out	07:55:35	-6.458581	106.856179	t	\N	0.5053744141670914	16:54:32	-6.458581	106.856179	t	Family emergency	0.5396031011144024	t	32337	0
231	27	2025-07-24	1423	Punch Out	08:23:43	-6.472424	106.853749	t	\N	0.3448994395915219	16:58:36	-6.473104	106.851692	t	\N	0.3828711459892616	t	30893	0
232	1	2025-07-25	1393	Punch Out	08:23:13	-6.472424	106.853749	t	\N	0.4589852431627047	16:58:23	-6.472422	106.852744	t	\N	0.1868872496523518	t	30910	0
222	12	2025-07-23	1380	Punch Out	08:23:00	-6.48021	106.865781	t	Overslept	0.3050127995444153	17:03:43	-6.48021	106.865781	t	Client Meeting	0.4548592703184627	t	31243	0
196	1	2025-07-19	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
198	12	2025-07-19	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
201	27	2025-07-19	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
202	1	2025-07-20	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
204	12	2025-07-20	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
208	1	2025-07-21	1574	Permit	08:26:14	-6.472422	106.852744	t	\N	0.3599288439641141	16:59:35	-6.472424	106.853749	t	\N	0.5386955672188145	t	30801	0
214	1	2025-07-22	0	Permit	07:58:15	-6.473104	106.851692	t	\N	0.5502804977816346	16:32:41	-6.472424	106.853749	t	\N	0.4049336377697828	t	30866	0
220	1	2025-07-23	0	Permit	07:37:07	-6.473104	106.851692	t	\N	0.5222472479755681	17:48:11	-6.473104	106.851692	t	\N	0.4504390988317978	t	36664	4264
234	12	2025-07-25	0	Punch Out	07:59:26	-6.48021	106.865781	t	\N	0.2238996898786937	16:34:26	-6.48021	106.865781	t	Went home early	0.4910329923751277	t	30900	0
6	12	2025-06-03	0	Punch Out	07:59:05	-6.48473	106.835542	t	\N	0.3896757934282169	17:48:23	-6.458581	106.856179	t	Traffic	0.4482350273039672	t	35358	2958
9	12	2025-06-04	0	Punch Out	07:53:09	-6.48021	106.865781	t	\N	0.3870562557055214	17:30:14	-6.48021	106.865781	t	Picked up family member after work\n\n	0.3247594222621019	t	34625	2225
69	12	2025-06-24	0	Punch Out	07:31:18	-6.458581	106.856179	t	\N	0.166939398689662	17:18:54	-6.48473	106.835542	t	Client meeting	0.5037418797426345	t	35256	2856
75	12	2025-06-26	1780	Punch Out	08:29:40	-6.458581	106.856179	t	Overslept	0.3957786998595337	17:21:46	-6.458581	106.856179	t	External training	0.4155518838491832	t	31926	0
132	12	2025-07-08	0	Punch Out	07:47:26	-6.48473	106.835542	t	\N	0.173915648495827	17:37:35	-6.48473	106.835542	t	Client meeting	0.1521946152512542	t	35409	3009
126	12	2025-07-07	485	Punch Out	08:08:05	-6.48021	106.865781	t	Client Meeting	0.1315965701420305	16:31:40	-6.458581	106.856179	t	Went home early	0.4012712852618954	t	30215	0
237	27	2025-07-25	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
382	1	2025-07-26	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
383	1	2025-07-27	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
391	12	2025-07-26	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
392	12	2025-07-27	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
393	12	2025-07-28	19045	Punch In	13:17:25.779596	-6.2855394	107.1705025	t		0.38427458285812566	\N	\N	\N	f	\N	\N	t	\N	\N
403	35	2025-07-29	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
404	35	2025-07-30	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
401	1	2025-07-28	23138	Punch Out	14:25:38.236823	-6.28471128207743	107.17083811853594	t		0.33949354224093364	16:28:12.874552	-6.2226432	106.8204032	t	aaa	0.31632754362727444	t	7354	0
405	12	2025-07-29	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.employees (employee_id, first_name, last_name, nrp_id, email, phone_number, "position", department, face_encoding, join_date) FROM stdin;
35	Tania	yunita	897324724	gwenrosevyn@gmail.com	08221478627	Web Design	web development	[-0.10515369474887848, 0.12102413177490234, 0.007206636480987072, -0.08250511437654495, -0.14248976111412048, -0.036403998732566833, -0.06081155315041542, -0.1573445349931717, 0.18462875485420227, -0.15169206261634827, 0.2418767511844635, -0.030277637764811516, -0.17465631663799286, -0.03781599551439285, -0.04131127893924713, 0.2120911329984665, -0.21098479628562927, -0.15352685749530792, -0.0633586123585701, -0.03658236563205719, 0.07175104320049286, -0.031457509845495224, 0.0406232625246048, 0.08454785495996475, -0.1343592405319214, -0.3241282105445862, -0.07199050486087799, -0.04246433824300766, -0.00015655718743801117, -0.048512715846300125, -0.0750967264175415, 0.06922850757837296, -0.2539134621620178, -0.07082343846559525, 0.009250721894204617, 0.1065405011177063, -0.04653998091816902, -0.09865506738424301, 0.18624205887317657, -0.07266099005937576, -0.254630446434021, 0.056495241820812225, 0.08221207559108734, 0.23922252655029297, 0.15573419630527496, 0.012297376990318298, -0.007453501224517822, -0.11864685267210007, 0.10870453715324402, -0.1790452003479004, 0.03064972534775734, 0.13745054602622986, 0.03906048834323883, 0.003561022225767374, 0.02198975905776024, -0.14600984752178192, 0.04505819082260132, 0.11283612251281738, -0.10636351257562637, -0.04301244765520096, 0.113278329372406, -0.061366572976112366, -0.040638457983732224, -0.16014553606510162, 0.2499476820230484, 0.1299530416727066, -0.10157322138547897, -0.13822659850120544, 0.1081167683005333, -0.09639745950698853, -0.049536798149347305, 0.03999624773859978, -0.15507394075393677, -0.21273477375507355, -0.2828190326690674, -0.027578668668866158, 0.3424385190010071, 0.1303369402885437, -0.18908889591693878, 0.05990130454301834, -0.004179954994469881, 0.027922004461288452, 0.15764421224594116, 0.14106671512126923, -0.012726660817861557, 0.05724513903260231, -0.11068858206272125, 0.07621403783559799, 0.23383653163909912, -0.04906002804636955, -0.02381257526576519, 0.25395798683166504, 0.01527024619281292, 0.027683570981025696, 0.010804219171404839, 0.025892576202750206, -0.08015403151512146, 0.03722676634788513, -0.1992020159959793, 0.045027315616607666, 0.06690646708011627, 0.013435096479952335, -0.059158023446798325, 0.13008570671081543, -0.14287406206130981, 0.06390837579965591, -0.005406229291111231, 0.05250898748636246, -0.0012818691320717335, -0.021474411711096764, -0.11295673996210098, -0.0844670906662941, 0.09379240870475769, -0.20421113073825836, 0.18064136803150177, 0.1627792865037918, 0.006104527041316032, 0.11086975783109665, 0.1285325437784195, 0.05018804222345352, 0.0005297213792800903, -0.028653252869844437, -0.27141085267066956, -0.014421189203858376, 0.15647445619106293, -0.07958628982305527, 0.11505164951086044, 0.018948649987578392]	2025-07-28
3	Anisa	Nirwana	133343224	nirwanaanisa1508@gmail.com	082214987219	Data Security	Cyber Security	[-0.10745113343000412, 0.06479183584451675, 0.03841818869113922, -0.07419481873512268, -0.09446264058351517, -0.03752533346414566, 0.0005902769044041634, -0.12211665511131287, 0.21591351926326752, -0.17293238639831543, 0.26916223764419556, -0.07804253697395325, -0.21133631467819214, -0.09860064089298248, 0.009385057725012302, 0.19761797785758972, -0.17414486408233643, -0.13627183437347412, -0.06367859244346619, 0.001685909926891327, 0.054232094436883926, -0.05612108111381531, 0.054845668375492096, 0.11643049865961075, -0.09619110822677612, -0.437546968460083, -0.09363581240177155, -0.052024345844984055, -0.06378484517335892, -0.042893484234809875, -0.07512733340263367, 0.1269986778497696, -0.2208126336336136, -0.1137506440281868, -0.05288901925086975, 0.1556069552898407, -0.06213591247797012, -0.06360242515802383, 0.1493958830833435, -0.035987090319395065, -0.25839105248451233, -0.05924650654196739, 0.043905291706323624, 0.23576849699020386, 0.13991595804691315, -0.017593640834093094, 0.028691517189145088, -0.0865224152803421, 0.07595359534025192, -0.2189370095729828, 0.03575323522090912, 0.112706758081913, 0.0446292869746685, 0.053642794489860535, 0.0026290896348655224, -0.11978019773960114, 0.006495899520814419, 0.14221717417240143, -0.13829924166202545, -0.05454059690237045, 0.0592513270676136, -0.10209975391626358, -0.05291147157549858, -0.11121028661727905, 0.24784503877162933, 0.18585355579853058, -0.078170046210289, -0.16279618442058563, 0.15717552602291107, -0.10458815097808838, -0.04208763316273689, 0.04490136355161667, -0.17050541937351227, -0.21318675577640533, -0.3112885057926178, 0.022013558074831963, 0.3361208736896515, 0.06767086684703827, -0.12074443697929382, 0.01670217327773571, -0.0897703692317009, -0.004880569409579039, 0.08870840072631836, 0.1477670669555664, 0.03332361578941345, 0.0742664635181427, -0.10334115475416183, 0.09656691551208496, 0.14913655817508698, -0.0733344778418541, -0.008518592454493046, 0.2307186722755432, -0.0033590374514460564, 0.05413768067955971, 0.041642606258392334, 0.056115809828042984, -0.06448857486248016, 0.11233486235141754, -0.22535854578018188, 0.06161462888121605, 0.05863276869058609, 0.0010617543011903763, -0.029182879254221916, 0.06716076284646988, -0.1392315775156021, 0.0819094106554985, 0.0209417212754488, 0.024644305929541588, 0.055981215089559555, -0.05498424544930458, -0.107485331594944, -0.13754069805145264, 0.11024875193834305, -0.21977248787879944, 0.11776702105998993, 0.17204159498214722, 0.029302291572093964, 0.17161093652248383, 0.07747355103492737, 0.09040781855583191, 0.008818788453936577, -0.08593098819255829, -0.27368438243865967, 0.0782378762960434, 0.15335705876350403, 0.0021260594949126244, -0.010376254096627235, 0.016320500522851944]	2025-05-26
2	Yustina	Yunita	188856789	yustinayunita86@gmail.com	08987654321	Data Scientist	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-05-26
4	Nabilla	Libasutaqwa	567890098	nabila.libasutaqwa@student.president.ac.id	081223456333	UI Designer	Web Programming	\N	2025-05-26
1	Nabilaa	Libasutaqwa	654323450	nabilalb2004@gmail.com	081234567890	Data Security	Cyber Security	[-0.11877931654453278, 0.048978134989738464, 0.04527463763952255, -0.053959839046001434, -0.11791834235191345, -0.04495662823319435, -0.02108035981655121, -0.12154902517795563, 0.14449924230575562, -0.13219228386878967, 0.2115778625011444, -0.059877026826143265, -0.2019445300102234, -0.055844079703092575, -0.031118731945753098, 0.23269718885421753, -0.22157025337219238, -0.15516698360443115, -0.06823483854532242, -0.011522598564624786, 0.0629851371049881, -0.039067551493644714, 0.08161631971597672, 0.037768762558698654, -0.1215372234582901, -0.34673014283180237, -0.07339158654212952, -0.04526490718126297, -0.05223672091960907, -0.0010802150936797261, -0.053868792951107025, 0.06410800665616989, -0.22088253498077393, -0.06292301416397095, 0.05741925910115242, 0.07921651005744934, -0.03555351868271828, -0.08645129948854446, 0.2093575894832611, -0.04646805673837662, -0.2735065817832947, 0.005639377981424332, 0.13623614609241486, 0.2107405811548233, 0.1236954852938652, 0.03615737706422806, 0.00791251566261053, -0.12571097910404205, 0.1281934380531311, -0.16802296042442322, 0.07628294825553894, 0.10171712189912796, 0.10188271850347519, 0.01609496958553791, 0.061359576880931854, -0.12568289041519165, 0.045133449137210846, 0.1394161432981491, -0.09774723649024963, -0.03284337744116783, 0.11771884560585022, -0.04846888780593872, -0.04083703085780144, -0.14710000157356262, 0.21173681318759918, 0.10060358047485352, -0.08506668359041214, -0.17493729293346405, 0.12550681829452515, -0.05969913303852081, -0.059123389422893524, 0.06671737879514694, -0.1499161422252655, -0.21463961899280548, -0.27530986070632935, -0.02323021925985813, 0.30915629863739014, 0.10314305871725082, -0.16695356369018555, 0.01426028087735176, 0.01552140899002552, 0.02114843763411045, 0.12716341018676758, 0.16630852222442627, -0.01382768526673317, 0.08116237819194794, -0.08654364943504333, 0.029460828751325607, 0.19440734386444092, -0.08323968201875687, -0.036607809364795685, 0.21330304443836212, 0.026845799759030342, 0.0015197917819023132, 0.00652182474732399, -0.011105605401098728, -0.06658308207988739, 0.07986483722925186, -0.22473746538162231, 0.011140072718262672, 0.05963897705078125, 0.03300333768129349, -0.028514988720417023, 0.07891437411308289, -0.13830700516700745, 0.01650134287774563, -0.02790762111544609, 0.004079924896359444, -0.016230043023824692, -0.030277667567133904, -0.11010953783988953, -0.0883723720908165, 0.044013429433107376, -0.21927028894424438, 0.13821639120578766, 0.16726413369178772, 0.016312438994646072, 0.11036698520183563, 0.10717912763357162, 0.06306461989879608, 0.0313158854842186, -0.008186950348317623, -0.23215122520923615, -0.008681267499923706, 0.18264751136302948, -0.01756097562611103, 0.09290212392807007, 0.009914634749293327]	2025-06-02
36	do	kyungso	678976543	anisa.nrwn15@gmail.com	08221478627	ASESOR	PGLH	[-0.05157141014933586, -0.015340054407715797, 0.006164755672216415, -0.11238393187522888, -0.06575120240449905, -0.023448413237929344, -0.017609769478440285, -0.054892268031835556, 0.22417640686035156, -0.06365969032049179, 0.2352403998374939, -0.027320636436343193, -0.23420362174510956, -0.06220533326268196, 0.046370089054107666, 0.17844276130199432, -0.15653946995735168, -0.12797267735004425, -0.060874126851558685, -0.019146813079714775, 0.05955960601568222, -0.03419243171811104, 0.11001072078943253, 0.0564366839826107, -0.17424140870571136, -0.40102705359458923, -0.07567134499549866, -0.03891858458518982, -0.01344236545264721, -0.03499472513794899, 0.022613514214754105, 0.1599922925233841, -0.1602093130350113, 0.00827218871563673, 0.04014817997813225, 0.12677568197250366, -0.05732869356870651, -0.12439676374197006, 0.24748657643795013, 0.012434347532689571, -0.2525255084037781, -0.04039997234940529, -0.017686959356069565, 0.23682555556297302, 0.16883766651153564, -0.025572150945663452, 0.07686057686805725, -0.03845022991299629, 0.06008000299334526, -0.363083153963089, 0.0991024300456047, 0.1736191362142563, -0.02352917194366455, 0.02270742505788803, 0.04567449539899826, -0.11050976812839508, -0.008575617335736752, 0.18411166965961456, -0.26067301630973816, 0.006814019754528999, 0.049189984798431396, -0.0633060410618782, -0.051477283239364624, -0.1301189512014389, 0.1771279275417328, 0.23957496881484985, -0.15989235043525696, -0.15618936717510223, 0.15921302139759064, -0.1081649586558342, -0.005890881642699242, 0.07507722824811935, -0.1847783625125885, -0.2846584916114807, -0.2743229568004608, 0.017592867836356163, 0.2981771230697632, 0.12994052469730377, -0.14817914366722107, -0.012162216007709503, -0.07677778601646423, 0.02625279873609543, 0.05691322311758995, 0.060701802372932434, 0.05342762917280197, -0.023186981678009033, -0.1164884939789772, 0.057008884847164154, 0.1856578290462494, -0.09264136850833893, -0.056762926280498505, 0.28377199172973633, 0.014038008637726307, -0.013779843226075172, -0.030126968398690224, 0.14679338037967682, -0.03898399695754051, 0.04466190189123154, -0.19837987422943115, 0.03604117035865784, 0.05122559517621994, 0.016936257481575012, 0.00790006760507822, 0.10518072545528412, -0.1457325518131256, 0.150264710187912, -0.005962526425719261, -0.03432643413543701, 0.012971252202987671, -0.05568387359380722, -0.09165560454130173, -0.1009681448340416, 0.11010021716356277, -0.258140504360199, 0.15423725545406342, 0.20792165398597717, 0.06613659858703613, 0.1658581644296646, 0.010074473917484283, 0.05702738091349602, 0.03710382431745529, -0.09548326581716537, -0.191237211227417, -0.005034856032580137, 0.008794036693871021, 0.08545134216547012, -0.06214195489883423, 0.057168856263160706]	2025-07-28
11	Nabilaaa	Libasutaqwa	543212323	nabilalb0109@gmail.com	081234567890	Full Stack Developer	Web Programming	\N	2025-05-26
17	Angeline	Moore	123546565	angelinemoore.notsafe@gmail.com	0891827392387	Back End Developer	Web Programming	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-05-26
22	Udin	Petot	789557846	annisanirwana94@yahoo.com	082214987219	CS	CSS	[-0.12919948995113373, 0.06666329503059387, 0.03344258666038513, -0.08404503762722015, -0.09008660167455673, -0.08720318973064423, -0.08245470374822617, -0.10234399884939194, 0.19635172188282013, -0.13135431706905365, 0.2677384316921234, -0.03503573685884476, -0.22508522868156433, -0.112706758081913, 0.03417070209980011, 0.19653455913066864, -0.2162640392780304, -0.1515597701072693, -0.023327000439167023, -0.004968846682459116, 0.0376853384077549, -0.06514094024896622, 0.08146794140338898, 0.07976383715867996, -0.10406520962715149, -0.45721232891082764, -0.10016806423664093, -0.05235406011343002, -0.04149402678012848, 0.0054552191868424416, -0.05616782233119011, 0.07495284825563431, -0.2324349284172058, -0.07747253775596619, 0.020301751792430878, 0.16606225073337555, -0.049775440245866776, -0.08939759433269501, 0.17369958758354187, -0.07171580195426941, -0.29493245482444763, -0.05096827819943428, 0.05974216386675835, 0.1934920996427536, 0.14177370071411133, 0.010161984711885452, 0.01671195775270462, -0.09920952469110489, 0.06554976105690002, -0.25490570068359375, 0.036633457988500595, 0.16162243485450745, 0.025041649118065834, 0.01508278213441372, 0.005302885547280312, -0.10272610187530518, 0.03740565478801727, 0.1506415456533432, -0.18771055340766907, -0.10580013692378998, 0.06068480387330055, -0.10924514383077621, -0.06539610028266907, -0.12561345100402832, 0.27128615975379944, 0.20287086069583893, -0.13297437131404877, -0.1762954741716385, 0.11034033447504044, -0.15277713537216187, -0.027844959869980812, 0.10175003111362457, -0.12501384317874908, -0.24999354779720306, -0.3338157832622528, 0.001971479505300522, 0.31238502264022827, 0.10100376605987549, -0.12357345223426819, 0.03959168493747711, -0.0815640240907669, -0.009729903191328049, 0.08266538381576538, 0.15124954283237457, 0.011230261996388435, 0.08069176226854324, -0.127456396818161, 0.044604912400245667, 0.19823633134365082, -0.07718481868505478, 0.011964729987084866, 0.24694783985614777, 0.012285180389881134, 0.10370013117790222, 0.01042763702571392, 0.07744865864515305, -0.047568030655384064, 0.02586311846971512, -0.20861658453941345, 0.04415066912770271, 0.05919310450553894, 0.039091210812330246, -0.04661335423588753, 0.07595592737197876, -0.1582529991865158, 0.036706939339637756, 0.008120217360556126, -0.026307284832000732, 0.045081302523612976, -0.0751051977276802, -0.04946199804544449, -0.17545470595359802, 0.07931462675333023, -0.2665981352329254, 0.1397392749786377, 0.20680955052375793, 0.05093002691864967, 0.18016910552978516, 0.08233986049890518, 0.03672053664922714, -0.021599942818284035, -0.13274571299552917, -0.24900546669960022, 0.04211864247918129, 0.10715876519680023, -0.018366381525993347, 0.012663201428949833, -0.01600147783756256]	2025-05-26
12	Yustina	Yunitaa	654327654	yustinayunitayy@gmail.com	08987654234	Data Analyst	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-06-02
27	Tania	Yusnita	678978904	anisa.n@student.president.ac.id	082214987219	Web Development	IT Department	[-0.13422827422618866, 0.06384623050689697, 0.03928602486848831, -0.11562179774045944, -0.15413635969161987, -0.07939504086971283, -0.08569162338972092, -0.15055957436561584, 0.15657877922058105, -0.1602618247270584, 0.2541095018386841, -0.09194441884756088, -0.18375042080879211, -0.00539966206997633, -0.051648497581481934, 0.20024152100086212, -0.14183735847473145, -0.1638937145471573, -0.04122006893157959, -0.06756722927093506, 0.0990431159734726, -0.05427738279104233, 0.011711452156305313, 0.035689353942871094, -0.1585787832736969, -0.2818366289138794, -0.1293620467185974, -0.014137485064566135, 0.013961239717900753, -0.02175743505358696, -0.02411597967147827, 0.010890188626945019, -0.22251424193382263, -0.026126574724912643, 0.029110074043273926, 0.13627135753631592, -0.05068274959921837, -0.1373993456363678, 0.16835670173168182, -0.07249511778354645, -0.2603032886981964, -0.015186932869255543, 0.11119453608989716, 0.1721913367509842, 0.1849723905324936, 0.022013455629348755, 0.010591017082333565, -0.17749635875225067, 0.06536408513784409, -0.2274724394083023, 0.06703260540962219, 0.11769302189350128, -0.03303483501076698, 0.07064597308635712, -0.012118630111217499, -0.12062054872512817, 0.059029337018728256, 0.1826375275850296, -0.14409197866916656, -0.03778136149048805, 0.14050433039665222, -0.100293830037117, -0.08197993040084839, -0.138575479388237, 0.2639751434326172, 0.20217213034629822, -0.12240195274353027, -0.19060878455638885, 0.15538163483142853, -0.17955954372882843, -0.07472167164087296, 0.0755893662571907, -0.11864658445119858, -0.1831994503736496, -0.32039201259613037, -0.008509615436196327, 0.4042833149433136, 0.1176236942410469, -0.14191530644893646, 0.0359543040394783, -0.024542853236198425, 0.057156238704919815, 0.17090657353401184, 0.10576465725898743, 0.003110824152827263, -0.013271193020045757, -0.11399143934249878, 0.002680489793419838, 0.30075159668922424, -0.09153932332992554, -0.004174745175987482, 0.20847190916538239, 0.030746154487133026, 0.03396414592862129, 0.0325433611869812, 0.1010255292057991, -0.07077586650848389, -0.015917714685201645, -0.16376341879367828, 0.006920783780515194, 0.019358664751052856, -0.01156129315495491, -0.05009544640779495, 0.12560056149959564, -0.14437980949878693, 0.0993204191327095, 0.002271470380946994, -0.021906575188040733, -0.014546847902238369, -0.054157957434654236, -0.04895005747675896, -0.10794353485107422, 0.10593356192111969, -0.2051326185464859, 0.15682370960712433, 0.1799098551273346, 0.07309908419847488, 0.15739476680755615, 0.13625529408454895, 0.12014104425907135, -0.011113584041595459, -0.045227743685245514, -0.2028268277645111, 0.006600527558475733, 0.042611125856637955, -0.019706454128026962, 0.06658954918384552, 0.035746898502111435]	2025-07-07
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
53	4	admin@ams.com	127.0.0.1	2025-05-05 09:17:51.910966	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
54	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 09:37:21.473838	f	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	1	\N
55	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 09:42:43.42061	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
56	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:44.17611	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
57	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:45.293023	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
58	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:46.045669	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
59	1	nabilalb@gmail.com	127.0.0.1	2025-05-05 11:08:47.91687	t	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 Edg/135.0.0.0	0	\N
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
199	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:08:40.797901	t	Edge 136.0.0	0	\N
200	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:08:53.295756	t	Edge 136.0.0	0	\N
201	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 08:32:18.071499	t	Edge 136.0.0	0	\N
172	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 02:57:02.963865	t	Edge 136.0.0	5	2025-05-14 03:06:30.604055
176	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-14 03:10:12.021334	t	Edge 136.0.0	0	\N
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
370	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 10:34:01.513992	t	Edge 136.0.0	0	\N
374	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 11:03:51.142385	t	Edge 136.0.0	0	\N
375	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 11:04:33.149977	t	Edge 136.0.0	0	\N
428	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:51:39.530436	f	Edge 136.0.0	1	\N
429	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:55:30.170103	t	Edge 136.0.0	1	\N
376	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 12:08:22.859285	t	Edge 136.0.0	5	2025-05-18 12:14:01.671293
377	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:39:46.477197	t	Edge 136.0.0	0	\N
379	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:44:18.680094	t	Edge 136.0.0	0	\N
381	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:52:10.188886	t	Edge 136.0.0	0	\N
383	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 13:54:40.385746	t	Edge 136.0.0	0	\N
388	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-18 14:19:30.735115	t	Opera 118.0.0	0	\N
390	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-18 14:31:32.290087	t	Opera 118.0.0	0	\N
423	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 19:59:03.626922	t	Edge 136.0.0	0	\N
425	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 20:00:49.539573	t	Edge 136.0.0	0	\N
431	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-18 21:21:15.380372	t	Edge 136.0.0	0	\N
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
498	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:36:08.333879	t	Edge 136.0.0	0	\N
500	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 05:41:30.601265	t	Edge 136.0.0	0	\N
501	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:36.156656	t	Opera 118.0.0	0	\N
502	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:37.462734	t	Opera 118.0.0	0	\N
503	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:55:38.458772	t	Opera 118.0.0	0	\N
504	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-20 05:56:00.015157	t	Opera 118.0.0	0	\N
505	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 08:19:55.895007	t	Edge 136.0.0	0	\N
506	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:24:09.527657	t	Opera 118.0.0	0	\N
507	17	adelaideufrasia@gmail.com	127.0.0.1	2025-05-20 08:48:57.03688	t	Opera 118.0.0	0	\N
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
528	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 12:56:34.300547	t	Edge 136.0.0	0	\N
529	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:06:03.61033	t	Edge 136.0.0	0	\N
530	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:11:27.090739	t	Edge 136.0.0	0	\N
531	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:37.392603	t	Edge 136.0.0	0	\N
532	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:37.85804	t	Edge 136.0.0	0	\N
533	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:44:45.181219	t	Edge 136.0.0	0	\N
534	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:45:27.569242	t	Edge 136.0.0	0	\N
535	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-20 13:48:40.95709	t	Edge 136.0.0	0	\N
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
562	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:06:11.569988	t	Edge 136.0.0	0	\N
564	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:27:43.747762	t	Edge 136.0.0	0	\N
565	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:29:33.243407	t	Edge 136.0.0	0	\N
566	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:34:03.413686	t	Edge 136.0.0	0	\N
567	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-21 15:41:15.543975	t	Edge 136.0.0	0	\N
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
618	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:25:56.414688	t	Opera 118.0.0	0	\N
619	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:28:40.562983	t	Opera 118.0.0	0	\N
622	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 07:35:17.483217	t	Opera 118.0.0	0	\N
625	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:08:21.071065	t	Opera 118.0.0	0	\N
626	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:12:54.549214	t	Opera 118.0.0	0	\N
627	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 08:20:34.390533	t	Opera 118.0.0	0	\N
628	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-23 08:33:10.844545	t	Opera 118.0.0	0	\N
637	\N	yuyus@gmail.com	127.0.0.1	2025-05-23 10:51:24.381794	f	Edge 136.0.0	2	\N
638	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:51:38.363652	t	Edge 136.0.0	0	\N
629	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 10:30:27.507701	f	Edge 136.0.0	5	2025-05-23 10:35:53.158504
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
649	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:17:39.367302	t	Chrome 136.0.0	0	\N
651	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:19:25.709286	t	Chrome 136.0.0	0	\N
655	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:32:31.062794	t	Chrome 136.0.0	0	\N
663	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:43:51.27831	t	Chrome 136.0.0	0	\N
664	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:45:50.925977	t	Edge 136.0.0	0	\N
665	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:47:28.579786	t	Chrome 136.0.0	0	\N
666	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:48:30.046106	t	Edge 136.0.0	0	\N
668	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 11:51:01.165474	t	Edge 136.0.0	0	\N
670	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:20:13.61503	t	Edge 136.0.0	0	\N
672	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:21:39.859166	t	Edge 136.0.0	0	\N
678	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 12:51:54.12274	t	Opera 118.0.0	0	\N
680	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 12:53:18.788207	t	Edge 136.0.0	0	\N
697	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:46:01.091363	t	Edge 136.0.0	0	\N
699	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:56:42.963222	t	Edge 136.0.0	0	\N
700	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:58:40.281529	t	Edge 136.0.0	0	\N
702	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 14:01:30.149378	t	Edge 136.0.0	0	\N
703	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 14:09:16.125282	t	Edge 136.0.0	0	\N
705	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 15:07:18.552638	t	Opera 118.0.0	0	\N
706	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 15:25:08.915663	t	Opera 118.0.0	0	\N
692	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:36:50.520263	f	Edge 136.0.0	6	2025-05-23 13:42:08.823226
693	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:42:56.326054	t	Edge 136.0.0	0	\N
694	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:44:18.790006	t	Chrome 136.0.0	0	\N
696	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 13:45:44.904513	t	Chrome 136.0.0	0	\N
708	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 15:43:21.41437	f	Edge 136.0.0	2	\N
709	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-23 15:59:08.620379	t	Opera 118.0.0	0	\N
714	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-23 16:07:42.847673	t	Opera 118.0.0	0	\N
715	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:16:10.852762	f	Edge 136.0.0	3	\N
716	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:18:23.975151	t	Edge 136.0.0	5	2025-05-23 16:23:57.657338
778	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:31:35.687232	t	Edge 136.0.0	0	\N
779	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:35:06.815082	t	Edge 136.0.0	0	\N
780	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-25 19:37:21.659255	t	Edge 136.0.0	0	\N
718	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:25:53.141023	t	Edge 136.0.0	0	\N
719	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:26:00.444741	t	Edge 136.0.0	0	\N
720	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:26:48.058952	t	Chrome 136.0.0	0	\N
722	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-23 16:29:25.621799	t	Edge 136.0.0	0	\N
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
758	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 13:48:14.416208	t	Opera 118.0.0	0	\N
762	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 15:41:35.963317	t	Opera 118.0.0	0	\N
763	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-24 15:42:39.889344	t	Opera 118.0.0	0	\N
764	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-24 15:52:57.616738	t	Opera 118.0.0	0	\N
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
798	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:07:18.015998	t	Edge 136.0.0	0	\N
799	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:22:24.312062	t	Edge 136.0.0	0	\N
802	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-26 17:33:01.483271	t	Edge 136.0.0	0	\N
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
835	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:14:39.907645	f	Edge 136.0.0	0	\N
836	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:14:57.076214	t	Edge 136.0.0	0	\N
842	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:45:59.942473	f	Edge 136.0.0	0	\N
843	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-27 02:46:18.668186	t	Edge 136.0.0	0	\N
844	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 03:22:32.328656	f	Edge 136.0.0	0	\N
845	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-27 03:22:55.68981	t	Edge 136.0.0	0	\N
855	\N	adelaideufrasia	127.0.0.1	2025-05-27 18:07:52.821944	f	Edge 136.0.0	2	\N
847	\N	abid@gmail.com	127.0.0.1	2025-05-27 11:49:40.012194	f	Edge 136.0.0	5	2025-05-27 11:54:52.326276
848	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-27 11:50:45.757627	f	Edge 136.0.0	1	\N
849	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-27 12:19:59.128278	t	Edge 136.0.0	0	\N
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
886	\N	nabila.libasutaqwa@student.ac.id	127.0.0.1	2025-05-28 02:07:50.056107	f	Edge 136.0.0	2	\N
887	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 02:09:12.948134	f	Edge 136.0.0	0	\N
888	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-05-28 02:09:26.881432	t	Edge 136.0.0	0	\N
889	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-28 03:10:44.038733	f	Opera 119.0.0	0	\N
890	6	yustinayunita86@gmail.com	127.0.0.1	2025-05-28 03:11:08.104932	t	Opera 119.0.0	0	\N
891	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-05-28 03:19:38.066355	f	Opera 119.0.0	0	\N
892	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-05-28 03:20:03.934513	t	Opera 119.0.0	0	\N
893	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-28 03:20:25.053532	f	Opera 119.0.0	0	\N
894	21	yustinayunitayy@gmail.com	127.0.0.1	2025-05-28 03:24:16.64775	t	Opera 119.0.0	0	\N
896	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-29 15:06:21.250954	t	Edge 136.0.0	0	\N
898	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-05-29 15:51:15.016097	t	Edge 136.0.0	0	\N
899	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:03:17.557134	f	Opera 119.0.0	0	\N
900	21	yustinayunitayy@gmail.com	127.0.0.1	2025-06-07 08:03:36.8388	t	Opera 119.0.0	0	\N
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
1254	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:09:56.75742	f	Edge 137.0.0	0	\N
1255	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:10:21.98567	t	Edge 137.0.0	0	\N
1256	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:13:25.73055	f	Edge 137.0.0	0	\N
1257	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:13:42.371166	t	Edge 137.0.0	0	\N
1278	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:16:15.840785	t	Edge 137.0.0	0	\N
1266	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:54:51.315519	f	Chrome 137.0.0	0	\N
1258	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:29:19.855529	f	Edge 137.0.0	5	2025-06-19 10:47:32.278873
1259	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 10:48:06.040229	f	Edge 137.0.0	0	\N
1267	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:55:07.270265	t	Chrome 137.0.0	0	\N
1264	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 11:44:04.249455	f	Edge 137.0.0	0	\N
1270	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:02:30.751219	f	Edge 137.0.0	0	\N
1271	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-19 12:02:45.80619	t	Edge 137.0.0	0	\N
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
1374	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:27:43.937877	f	Edge 137.0.0	0	\N
1375	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:27:59.512894	t	Edge 137.0.0	0	\N
1376	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:28:26.542401	f	Chrome 137.0.0	0	\N
1377	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:28:39.836019	t	Chrome 137.0.0	0	\N
1378	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:47:30.707327	f	Edge 137.0.0	0	\N
1379	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:01.79688	f	Edge 137.0.0	0	\N
1380	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:17.516803	t	Edge 137.0.0	0	\N
1381	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-06-21 20:57:54.816422	f	Chrome 137.0.0	0	\N
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
1628	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:31:29.070262	f	Opera 119.0.0	0	\N
1629	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:32:16.011742	t	Opera 119.0.0	0	\N
1630	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:35:35.151403	f	Opera 119.0.0	0	\N
1631	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-18 14:35:52.223593	t	Chrome Mobile 134.0.0	0	\N
1634	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:48:20.345977	f	Chrome 138.0.0	0	\N
1635	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 14:49:20.83185	t	Chrome 138.0.0	0	\N
1638	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 15:24:19.963326	f	Chrome 138.0.0	0	\N
1639	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-18 15:25:49.383829	t	Chrome 138.0.0	0	\N
1640	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-19 08:39:35.973934	f	Opera 119.0.0	1	\N
1647	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-20 13:05:35.51995	f	Opera 119.0.0	0	\N
1648	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-20 13:05:53.743459	t	Opera 119.0.0	0	\N
1649	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:29:36.63279	f	Edge 138.0.0	0	\N
1650	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:29:52.031518	t	Edge 138.0.0	0	\N
1651	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:47:57.237565	f	Edge 138.0.0	0	\N
1652	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-23 17:48:09.572947	t	Edge 138.0.0	0	\N
1653	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-23 17:55:33.210068	f	Chrome 138.0.0	0	\N
1654	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-23 17:55:55.436864	t	Chrome 138.0.0	0	\N
1657	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-23 18:01:41.441981	f	Edge 138.0.0	0	\N
1658	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-23 18:01:55.404489	t	Edge 138.0.0	0	\N
1659	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 07:31:17.422146	f	Opera 120.0.0	0	\N
1660	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 07:31:41.909794	t	Opera 120.0.0	0	\N
1661	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 09:05:34.78436	f	Opera 120.0.0	0	\N
1662	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 09:06:36.465234	t	Opera 120.0.0	0	\N
1663	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:06:42.043061	f	Edge 138.0.0	0	\N
1664	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:07:03.303703	t	Edge 138.0.0	0	\N
1665	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:11:20.758727	f	Edge 138.0.0	0	\N
1666	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:11:38.28105	t	Edge 138.0.0	0	\N
1667	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 09:12:21.495875	f	Edge 138.0.0	0	\N
1668	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 09:12:37.767743	t	Edge 138.0.0	0	\N
1669	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 09:15:13.73808	f	Opera 120.0.0	0	\N
1670	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-24 09:15:45.98308	t	Opera 120.0.0	0	\N
1671	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:16:10.419833	f	Opera 120.0.0	0	\N
1672	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:16:38.063274	t	Opera 120.0.0	0	\N
1673	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:16:48.795906	f	Edge 138.0.0	0	\N
1674	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-24 09:17:05.930919	t	Edge 138.0.0	0	\N
1676	\N	taniaisablea@gmail.com	127.0.0.1	2025-07-24 09:21:34.946164	f	Opera 120.0.0	1	\N
1688	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:42:47.792263	f	Chrome 138.0.0	0	\N
1680	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:31:38.712886	f	Opera 120.0.0	0	\N
1681	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:31:59.464311	t	Opera 120.0.0	0	\N
1684	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 09:37:11.182938	f	Opera 120.0.0	0	\N
1685	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 09:37:47.948563	t	Opera 120.0.0	0	\N
1689	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:43:09.398971	f	Chrome 138.0.0	0	\N
1690	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:43:37.357389	t	Chrome 138.0.0	0	\N
1691	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:46:10.374562	f	Opera 120.0.0	0	\N
1692	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-24 09:46:37.314498	f	Chrome 138.0.0	0	\N
1693	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-24 09:46:49.73115	t	Opera 120.0.0	0	\N
1694	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-24 09:47:49.404684	t	Chrome 138.0.0	0	\N
1695	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 09:47:54.789856	f	Opera 120.0.0	0	\N
1696	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 09:48:16.458374	t	Opera 120.0.0	0	\N
1697	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 09:48:08.397296	f	Edge 138.0.0	0	\N
1698	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-24 09:48:34.463571	f	Chrome 138.0.0	0	\N
1699	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-24 09:48:53.30054	f	Chrome 138.0.0	0	\N
1700	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 09:49:11.852146	t	Edge 138.0.0	0	\N
1701	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-24 09:49:17.220089	t	Chrome 138.0.0	0	\N
1705	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 10:05:20.651024	f	Edge 138.0.0	0	\N
1706	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 10:05:33.751252	f	Edge 138.0.0	0	\N
1707	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-24 10:06:20.084827	t	Edge 138.0.0	0	\N
1710	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 10:08:39.036157	f	Opera 120.0.0	0	\N
1711	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-24 10:09:13.187601	t	Opera 120.0.0	0	\N
1712	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 14:22:04.017582	f	Opera 120.0.0	0	\N
1713	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 14:22:20.394888	t	Opera 120.0.0	0	\N
1714	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 14:24:43.810152	f	Opera 120.0.0	0	\N
1715	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 14:25:09.140154	t	Opera 120.0.0	0	\N
1716	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 14:31:03.824921	f	Opera 120.0.0	0	\N
1717	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 14:31:20.40852	t	Opera 120.0.0	0	\N
1718	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 14:59:48.311044	f	Opera 120.0.0	0	\N
1719	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 15:01:19.908164	f	Opera 120.0.0	0	\N
1720	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 15:01:37.483807	t	Opera 120.0.0	0	\N
1721	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 15:01:51.682027	f	Opera 120.0.0	0	\N
1722	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-26 15:02:11.725601	t	Opera 120.0.0	0	\N
1764	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:55:33.051077	t	Opera 120.0.0	0	\N
1724	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:35:19.060944	f	Opera 120.0.0	0	\N
1725	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:35:36.160487	t	Opera 120.0.0	0	\N
1728	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:37:52.688182	f	Opera 120.0.0	0	\N
1729	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:38:09.233687	t	Opera 120.0.0	0	\N
1733	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:42:11.542276	f	Chrome Mobile 135.0.0	0	\N
1734	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:55:42.850512	f	Chrome Mobile 135.0.0	0	\N
1735	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 15:55:58.988807	t	Chrome Mobile 135.0.0	0	\N
1738	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:02:53.271752	f	Opera 120.0.0	0	\N
1739	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:03:09.718833	t	Opera 120.0.0	0	\N
1742	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:38:01.870251	f	Opera 120.0.0	0	\N
1743	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:39:04.314179	t	Opera 120.0.0	0	\N
1744	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:58:49.146414	f	Opera 120.0.0	0	\N
1745	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:58:57.809003	f	Opera 120.0.0	0	\N
1746	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:59:18.121542	t	Opera 120.0.0	0	\N
1747	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 16:59:58.015302	f	Opera 120.0.0	0	\N
1748	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 17:00:14.924808	t	Opera 120.0.0	0	\N
1749	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-26 17:07:43.764242	f	Opera 120.0.0	0	\N
1756	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-27 05:47:05.616695	f	Opera 120.0.0	0	\N
1757	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-27 05:47:22.532231	t	Opera 120.0.0	0	\N
1758	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:52:20.418803	f	Opera 120.0.0	0	\N
1759	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:52:36.32971	t	Opera 120.0.0	0	\N
1760	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:52:51.003043	f	Opera 120.0.0	0	\N
1761	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:53:02.093543	f	Opera 120.0.0	0	\N
1762	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:53:17.805746	t	Opera 120.0.0	0	\N
1763	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:55:16.646662	f	Opera 120.0.0	0	\N
1765	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:56:57.631618	f	Opera 120.0.0	0	\N
1766	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 05:57:14.678227	t	Opera 120.0.0	0	\N
1767	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 06:01:50.920951	f	Opera 120.0.0	0	\N
1768	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 06:02:08.514289	t	Opera 120.0.0	0	\N
1771	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 06:32:47.086687	f	Opera 120.0.0	0	\N
1772	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 06:33:21.63662	t	Opera 120.0.0	0	\N
1773	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 06:35:30.385441	f	Opera 120.0.0	0	\N
1774	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 06:38:33.669207	f	Opera 120.0.0	0	\N
1775	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 06:38:54.637568	t	Opera 120.0.0	0	\N
1776	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 08:37:45.326019	f	Opera 120.0.0	0	\N
1777	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 08:38:04.660533	t	Opera 120.0.0	0	\N
1778	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 08:57:04.721021	f	Opera 120.0.0	0	\N
1779	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 08:57:23.19036	t	Opera 120.0.0	0	\N
1781	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-27 09:44:20.79568	f	Edge 138.0.0	0	\N
1782	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-27 09:44:52.298928	t	Edge 138.0.0	0	\N
1785	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 10:23:52.411825	f	Opera 120.0.0	0	\N
1786	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-27 10:24:10.760498	t	Opera 120.0.0	0	\N
1787	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-27 11:25:13.644327	f	Edge 138.0.0	0	\N
1788	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:25:19.972439	f	Edge 138.0.0	0	\N
1789	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:25:38.77522	t	Edge 138.0.0	0	\N
1790	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:36:43.942941	f	Edge 138.0.0	0	\N
1791	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:36:58.671013	t	Edge 138.0.0	0	\N
1792	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:38:02.933627	f	Edge 138.0.0	0	\N
1793	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:38:15.223425	t	Edge 138.0.0	0	\N
1794	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:58:54.96408	f	Edge 138.0.0	0	\N
1795	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:00.241596	f	Edge 138.0.0	0	\N
1796	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:04.662305	f	Edge 138.0.0	0	\N
1797	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:10.10869	f	Edge 138.0.0	0	\N
1798	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:14.64399	f	Edge 138.0.0	0	\N
1799	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:19.164313	f	Edge 138.0.0	0	\N
1800	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 11:59:43.863933	t	Edge 138.0.0	0	\N
1801	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-27 13:36:31.257425	f	Opera 120.0.0	0	\N
1802	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-27 13:36:49.640832	t	Opera 120.0.0	0	\N
1803	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 13:37:21.524717	f	Opera 120.0.0	0	\N
1804	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 13:37:29.707775	f	Opera 120.0.0	0	\N
1805	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 13:37:49.539389	t	Opera 120.0.0	0	\N
1806	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 14:38:20.219506	f	Edge 138.0.0	0	\N
1807	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 14:38:26.95422	f	Edge 138.0.0	0	\N
1808	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 14:38:45.636192	t	Edge 138.0.0	0	\N
1809	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 14:53:18.425177	f	Opera 120.0.0	0	\N
1810	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-27 14:53:36.231878	t	Opera 120.0.0	0	\N
1816	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 16:05:21.649368	f	Edge 138.0.0	0	\N
1817	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 16:05:36.658567	t	Edge 138.0.0	0	\N
1818	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 17:35:38.07069	f	Edge 138.0.0	0	\N
1819	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 17:35:55.433083	t	Edge 138.0.0	0	\N
1820	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 17:50:32.537656	f	Edge 138.0.0	0	\N
1821	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 17:50:56.70387	t	Edge 138.0.0	0	\N
1822	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-27 18:23:52.514412	f	Edge 138.0.0	0	\N
1823	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-27 18:24:09.565459	t	Edge 138.0.0	0	\N
1824	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 18:25:42.237205	f	Edge 138.0.0	0	\N
1825	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-27 18:25:57.969155	t	Edge 138.0.0	0	\N
1826	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 18:27:34.41	f	Edge 138.0.0	0	\N
1827	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 18:27:59.083707	t	Edge 138.0.0	0	\N
1828	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-27 18:31:53.419495	f	Edge 138.0.0	0	\N
1829	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-27 18:32:12.328718	t	Edge 138.0.0	0	\N
1830	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 18:33:08.454028	f	Edge 138.0.0	0	\N
1831	17	nabilalb0109@gmail.com	127.0.0.1	2025-07-27 18:33:29.902212	t	Edge 138.0.0	0	\N
1832	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 06:16:03.193866	f	Opera 120.0.0	0	\N
1833	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 06:16:19.183815	t	Opera 120.0.0	0	\N
1845	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:10:07.187255	f	Opera 120.0.0	0	\N
1846	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:10:37.297008	t	Opera 120.0.0	0	\N
1847	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:12:10.229657	f	Opera 120.0.0	0	\N
1848	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:12:32.693804	t	Opera 120.0.0	0	\N
1849	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:15:17.81598	f	Opera 120.0.0	0	\N
1850	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:15:30.97909	t	Opera 120.0.0	0	\N
1851	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:15:45.745664	f	Edge 138.0.0	0	\N
1852	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-28 07:16:08.066464	f	Opera 120.0.0	0	\N
1853	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-28 07:16:22.962398	t	Opera 120.0.0	0	\N
1854	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:16:08.926496	f	Edge 138.0.0	0	\N
1855	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:16:33.465385	t	Edge 138.0.0	0	\N
1856	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:16:58.776947	f	Edge 138.0.0	0	\N
1857	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:17:14.524171	t	Edge 138.0.0	0	\N
1858	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:18:39.028162	f	Edge 138.0.0	0	\N
1859	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 07:18:43.403658	f	Edge 138.0.0	0	\N
1860	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:18:49.551915	f	Edge 138.0.0	0	\N
1861	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:18:59.841108	f	Opera 120.0.0	0	\N
1862	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:19:03.968311	f	Edge 138.0.0	0	\N
1863	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:19:12.536835	f	Edge 138.0.0	0	\N
1864	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 07:19:18.25654	t	Edge 138.0.0	0	\N
1865	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:19:18.562139	t	Opera 120.0.0	0	\N
1866	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:19:17.416925	f	Edge 138.0.0	0	\N
1868	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:19:41.26171	f	Opera 120.0.0	0	\N
1869	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:19:56.078113	t	Opera 120.0.0	0	\N
1870	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:20:29.266097	f	Edge 138.0.0	0	\N
1871	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:20:35.15969	f	Opera 120.0.0	0	\N
1872	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 07:20:44.297294	t	Edge 138.0.0	0	\N
1873	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 07:20:49.655725	t	Opera 120.0.0	0	\N
1874	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 07:21:33.353606	f	Opera 120.0.0	0	\N
1875	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 07:21:38.672225	f	Opera 120.0.0	0	\N
1876	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 07:21:52.759533	t	Opera 120.0.0	0	\N
1910	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-30 12:46:33.723322	f	Opera 120.0.0	0	\N
1877	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 07:47:49.415566	f	Edge 138.0.0	2	\N
1911	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-30 12:47:21.270348	t	Opera 120.0.0	0	\N
1912	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 13:43:59.326073	f	Opera 120.0.0	0	\N
1913	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 13:44:17.915348	t	Opera 120.0.0	0	\N
1867	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:19:44.90841	t	Edge 138.0.0	5	2025-07-28 07:54:26.131251
1878	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:54:30.115007	f	Edge 138.0.0	0	\N
1879	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:54:56.44089	t	Edge 138.0.0	0	\N
1880	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 07:55:23.081864	f	Edge 138.0.0	0	\N
1914	\N	angelinmoore.notsafe@gmail.com	127.0.0.1	2025-07-30 14:40:38.708368	f	Opera 120.0.0	2	\N
1881	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 07:56:17.481247	t	Edge 138.0.0	2	\N
1882	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 07:58:30.667481	f	Edge 138.0.0	0	\N
1883	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 07:58:49.867432	t	Edge 138.0.0	0	\N
1884	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 08:08:19.716448	f	Opera 120.0.0	0	\N
1885	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 08:08:35.387797	t	Opera 120.0.0	0	\N
1886	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 08:26:07.043997	f	Chrome 138.0.0	0	\N
1887	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 08:26:33.924739	t	Chrome 138.0.0	0	\N
1888	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 08:31:32.569903	f	Edge 138.0.0	0	\N
1889	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 08:31:36.200444	f	Opera 120.0.0	0	\N
1890	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-28 08:31:53.128269	t	Opera 120.0.0	0	\N
1891	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 08:31:53.992102	t	Edge 138.0.0	0	\N
1892	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 08:32:28.449984	f	Edge 138.0.0	0	\N
1893	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 08:32:51.616022	t	Edge 138.0.0	0	\N
1894	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 08:55:32.716223	f	Edge 138.0.0	0	\N
1896	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 09:01:01.979041	f	Edge 138.0.0	0	\N
1897	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 09:01:43.710025	t	Edge 138.0.0	0	\N
1898	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 09:09:17.602846	f	Edge 138.0.0	0	\N
1899	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-07-28 09:09:35.169876	t	Edge 138.0.0	0	\N
1900	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 09:09:34.106804	f	Edge 138.0.0	0	\N
1901	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 09:10:14.0103	t	Edge 138.0.0	0	\N
1902	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 09:10:13.121802	f	Opera 120.0.0	0	\N
1903	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-28 09:10:31.277989	t	Opera 120.0.0	0	\N
1904	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-28 09:14:22.13953	f	Chrome 138.0.0	0	\N
1905	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-07-28 09:14:41.115305	t	Chrome 138.0.0	0	\N
1895	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 08:55:53.286328	t	Edge 138.0.0	1	\N
1906	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 09:25:56.189757	f	Opera 120.0.0	0	\N
1907	1	nabilalb2004@gmail.com	127.0.0.1	2025-07-28 09:26:12.225178	t	Opera 120.0.0	0	\N
1908	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 09:30:00.701039	f	Opera 120.0.0	0	\N
1909	48	gwenrosevyn@gmail.com	127.0.0.1	2025-07-28 09:30:12.566453	t	Opera 120.0.0	0	\N
1915	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 14:49:26.386349	f	Opera 120.0.0	0	\N
1916	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 14:49:34.275817	f	Opera 120.0.0	0	\N
1917	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 14:49:49.941002	t	Opera 120.0.0	0	\N
1918	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 15:30:09.621255	f	Opera 120.0.0	1	\N
1919	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 15:30:30.567822	f	Opera 120.0.0	0	\N
1920	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 15:30:46.970467	t	Opera 120.0.0	0	\N
1921	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:49:22.329816	f	Opera 120.0.0	1	\N
1922	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:49:27.992809	f	Opera 120.0.0	0	\N
1923	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:49:35.941767	f	Opera 120.0.0	0	\N
1924	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:49:51.769003	t	Opera 120.0.0	1	\N
1925	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:55:12.11084	f	Opera 120.0.0	0	\N
1926	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 15:55:27.552647	t	Opera 120.0.0	4	\N
1927	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 16:01:57.561162	f	Opera 120.0.0	0	\N
1928	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 16:02:15.746818	t	Opera 120.0.0	0	\N
1929	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 16:08:06.533716	f	Opera 120.0.0	0	\N
1931	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-30 16:15:03.597557	f	Opera 120.0.0	0	\N
1930	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 16:08:26.61897	t	Opera 120.0.0	1	\N
1932	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 16:15:44.420207	f	Opera 120.0.0	0	\N
1933	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 16:15:59.70159	t	Opera 120.0.0	0	\N
1934	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 16:46:41.027154	f	Opera 120.0.0	0	\N
1935	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-30 16:46:56.85282	t	Opera 120.0.0	0	\N
1936	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 17:00:09.230486	f	Opera 120.0.0	0	\N
1937	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 17:00:29.205676	t	Opera 120.0.0	0	\N
1938	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-31 14:11:51.992266	f	Opera 120.0.0	0	\N
1939	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-07-31 14:12:11.433084	t	Opera 120.0.0	0	\N
1940	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 08:10:43.906616	f	Chrome 138.0.0	5	2025-08-01 08:36:25.437222
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.notifications (notification_id, user_id, title, message, notification_type, is_read, created_at, read_at) FROM stdin;
312	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:37:46.901852	2025-07-24 09:38:05.559391
324	17	New Permission Request	There is a new permission request from Tania Yusnita.	permission	f	2025-07-24 16:59:43.07486	\N
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
41	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 13:54:01.574037	\N
43	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:01:25.491155	\N
45	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:05:12.046273	\N
10	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-14 07:37:29.594588	2025-05-19 09:10:09.677018
36	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-18 04:11:14.686422	2025-05-19 09:10:14.692875
49	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 15:26:32.984996	2025-05-20 12:53:34.025552
47	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 14:52:29.895812	2025-05-20 09:20:24.194451
51	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 16:24:04.756409	2025-05-20 12:55:16.289724
313	17	New Permission Request	There is a new permission request from Angeline Moore.	permission	f	2025-07-24 16:38:44.892777	\N
57	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:11:53.940808	\N
315	32	New Permission Request	There is a new permission request from Angeline Moore.	permission	f	2025-07-24 16:38:53.35566	\N
314	27	New Permission Request	There is a new permission request from Angeline Moore.	permission	t	2025-07-24 16:38:48.947443	2025-07-24 09:49:20.617529
59	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:13:05.507031	2025-05-20 12:55:11.423328
69	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-19 09:08:22.767267	2025-05-19 09:10:12.217593
68	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-19 07:59:29.497646	2025-05-19 09:10:13.542084
84	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-20 00:33:08.671771	\N
90	4	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 05:27:26.774969	\N
91	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-20 08:57:53.259483	2025-05-20 08:59:28.155274
82	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:33:08.671771	2025-05-23 06:51:26.459513
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
106	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-23 08:33:08.711615	2025-05-23 08:33:12.400074
95	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-21 18:21:06.273696	2025-05-23 08:33:14.241717
107	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 10:30:53.4242	\N
109	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 10:35:59.312561	\N
110	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 10:39:46.767059	\N
111	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 10:52:05.004714	\N
112	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 10:55:18.362704	\N
326	32	New Permission Request	There is a new permission request from Tania Yusnita.	permission	f	2025-07-24 16:59:56.445302	\N
75	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:10:02.964473	2025-05-23 11:16:37.527812
316	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	t	2025-07-24 16:43:42.153764	2025-07-26 14:27:24.915103
119	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:17:27.776622	\N
355	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 15:36:25.	failed_login	f	2025-08-01 15:31:25.728011	\N
332	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-27 16:44:52.362248	\N
123	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:19:13.306465	\N
335	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:25:08.308746	\N
337	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:25:17.633469	\N
130	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:32:17.491531	\N
336	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-28 01:25:12.427531	2025-07-28 07:23:48.302609
346	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 14:54:26.	failed_login	f	2025-07-28 14:49:26.81259	\N
134	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
349	27	New Permission Request	There is a new permission request from Tania yunita.	permission	t	2025-07-28 15:09:09.851232	2025-07-28 08:33:09.986512
136	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
138	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:45:50.839621	\N
354	48	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-28 16:30:10.952891	2025-07-28 09:40:58.344481
140	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:48:29.963412	\N
328	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-26 23:03:09.32328	2025-07-30 13:56:07.677214
155	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 08:45:10.892826	\N
117	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 11:16:14.030697	2025-05-23 06:51:07.009727
116	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 11:12:15.988688	2025-05-23 06:51:09.282288
115	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 11:06:54.201328	2025-05-23 06:51:12.481624
114	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 11:00:17.064208	2025-05-23 06:51:15.084477
113	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 10:55:47.235116	2025-05-23 06:51:17.715633
139	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 06:47:28.522624	2025-05-23 06:51:21.763979
121	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:19:13.30538	2025-05-23 06:51:35.027621
141	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 07:21:30.627906	\N
143	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 07:21:30.628905	\N
157	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 08:45:10.892826	\N
128	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:32:17.491531	2025-05-23 13:49:49.397965
161	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 20:56:33.944735	\N
160	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 20:56:33.944735	2025-05-23 14:01:41.025673
159	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 20:46:00.517792	2025-05-23 14:01:44.448951
154	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 20:44:18.1129	2025-05-23 14:01:45.026013
153	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-23 20:37:09.035224	2025-05-23 14:09:21.349867
164	3	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
165	17	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
168	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 23:18:58.402583	\N
170	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 23:26:48.892906	\N
201	27	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	t	2025-06-13 23:35:08.726614	2025-07-24 09:49:23.908391
172	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 23:29:12.397259	\N
325	27	New Permission Request	There is a new permission request from Tania Yusnita.	permission	t	2025-07-24 16:59:49.555784	2025-07-24 10:01:51.804854
317	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:46:48.98016	2025-07-26 14:22:23.93986
175	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:29:26.236148	2025-05-23 16:29:37.727939
171	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 23:29:12.397259	2025-05-24 06:57:36.355537
339	17	New Permission Request	There is a new permission request from Nabilla Libasutaqwa.	permission	f	2025-07-28 01:26:37.186885	\N
341	32	New Permission Request	There is a new permission request from Nabilla Libasutaqwa.	permission	f	2025-07-28 01:26:44.701554	\N
176	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:49:49.82315	2025-05-24 15:42:56.152956
178	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-24 22:42:39.736659	2025-05-24 15:42:57.609281
340	27	New Permission Request	There is a new permission request from Nabilla Libasutaqwa.	permission	t	2025-07-28 01:26:41.168126	2025-07-28 07:23:46.143469
180	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.478087	\N
181	17	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.479232	\N
348	17	New Permission Request	There is a new permission request from Tania yunita.	permission	f	2025-07-28 15:09:05.038546	\N
184	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-27 00:42:28.616557	\N
185	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-27 06:06:19.056272	\N
350	32	New Permission Request	There is a new permission request from Tania yunita.	permission	f	2025-07-28 15:09:14.360846	\N
352	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-28 16:10:14.139027	\N
190	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:11:07.509518	2025-05-28 03:11:12.327956
187	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-27 09:03:25.366884	2025-05-28 03:11:13.213398
186	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-27 02:00:09.14251	2025-05-28 03:11:14.134038
191	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:24:15.973511	2025-06-07 08:06:20.298563
193	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-08 19:23:15.698131	\N
196	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	f	2025-06-10 19:09:27.799658	\N
194	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 134.0.0	new_device	t	2025-06-10 18:10:20.308135	2025-06-13 08:59:42.622189
195	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-06-10 18:18:04.628219	2025-06-13 08:59:44.982153
199	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-13 22:08:55.501595	\N
200	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-13 22:13:51.777851	\N
198	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-06-11 19:06:41.209838	2025-06-13 16:04:48.960248
197	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 134.0.0	new_device	t	2025-06-11 12:11:59.493298	2025-06-13 16:04:50.724536
203	17	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	f	2025-06-13 23:35:08.727205	\N
205	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-17 20:04:13.101533	\N
206	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 00:30:58.953032	\N
207	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 00:56:15.234582	\N
208	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 01:22:32.713198	\N
209	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 01:30:49.734329	\N
210	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	f	2025-06-19 02:35:29.304722	\N
211	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-19 02:40:11.227582	\N
213	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	t	2025-06-19 03:19:43.691157	2025-06-18 20:25:28.336089
212	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 137.0.0	new_device	t	2025-06-19 03:10:31.542393	2025-06-18 20:29:22.174073
223	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:36:55.	failed_login	t	2025-06-19 18:31:56.188061	2025-06-19 11:44:35.172791
214	3	Failed Login Attempt	5 failed login attempts detected. Your account has been temporarily locked.	failed_login	t	2025-06-19 03:41:26.052561	2025-06-21 19:31:36.119458
215	3	Failed Login Attempt	10 failed login attempts detected. Your account has been temporarily locked.	failed_login	t	2025-06-19 03:53:13.87709	2025-06-21 19:31:39.775395
219	3	Percobaan Login Gagal	Terdeteksi 10 kali percobaan login gagal. Akun Anda dikunci hingga pukul 10:47:32.	failed_login	t	2025-06-19 17:42:32.960806	2025-06-21 19:31:41.859542
222	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:24:34.	failed_login	t	2025-06-19 18:19:34.990696	2025-06-21 19:31:44.154423
234	27	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	t	2025-06-19 19:06:51.883537	2025-07-24 09:49:30.581244
225	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 19:41:44.	failed_login	t	2025-06-19 18:41:44.725558	2025-06-19 11:44:30.489968
224	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:42:04.	failed_login	t	2025-06-19 18:37:05.546239	2025-06-19 11:44:32.63451
229	27	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	t	2025-06-19 19:02:03.661204	2025-07-24 09:49:32.864344
238	27	New Permission Request	There is a new permission request from Abid Laqoo.	permission	t	2025-06-19 19:12:37.191976	2025-07-24 09:49:34.416173
243	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	t	2025-06-19 19:31:58.992759	2025-07-24 09:49:36.408927
250	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-06-21 17:29:17.410263	2025-07-24 09:49:39.040819
231	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:02:03.662368	\N
274	27	New Permission Request	There is a new permission request from Yustina Yunitaa.	permission	t	2025-07-10 20:02:36.168985	2025-07-24 09:49:41.499578
233	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 19:02:45.518765	\N
282	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:05:46.759423	2025-07-24 09:49:44.808056
236	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:06:57.869993	\N
318	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:49:45.777331	\N
240	17	New Permission Request	There is a new permission request from Abid Laqoo.	permission	f	2025-06-19 19:12:43.056867	\N
320	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:49:58.138613	\N
319	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-24 16:49:50.636523	2025-07-24 09:50:32.720642
244	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-19 19:48:39.314865	\N
245	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 20:07:35.300335	\N
246	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 137.0.0	new_device	f	2025-06-19 21:03:20.196529	\N
247	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 21:28:35.	failed_login	f	2025-06-19 21:23:36.184068	\N
248	3	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 22:29:41.	failed_login	f	2025-06-19 21:29:41.575959	\N
275	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-07-10 20:08:17.75505	2025-07-26 14:27:27.3485
329	17	New Permission Request	There is a new permission request from Dame Un GRR.	permission	f	2025-07-27 13:31:38.618921	\N
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
277	1	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-10 23:42:22.260648	\N
278	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-07-11 13:37:42.611829	\N
276	21	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 20:27:04.	failed_login	t	2025-07-10 20:22:04.657893	2025-07-11 07:02:40.869115
280	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:41.671027	\N
283	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:05:48.990646	\N
284	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:06:55.906739	\N
307	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:42:27.612972	2025-07-24 09:38:09.016583
287	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:07:02.925474	\N
288	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:32.483605	\N
303	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:07:34.931048	2025-07-24 09:38:11.208691
291	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:39.435791	\N
299	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:05:06.885702	2025-07-24 09:38:13.430319
292	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-07-18 21:35:49.364835	2025-07-18 14:35:54.770493
293	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:45.574618	\N
286	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:07:00.638655	2025-07-24 09:49:46.829689
296	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:56.094459	\N
297	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:04:59.392283	\N
290	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:09:37.17348	2025-07-24 09:49:48.923118
300	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:05:10.477919	\N
301	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:25.701324	\N
295	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 18:59:52.715012	2025-07-24 09:49:54.767463
304	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:38.341102	\N
305	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:21.134914	\N
321	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:50:35.894901	\N
308	32	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:30.577921	\N
323	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:51:01.791899	\N
310	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 14:31:42.360899	2025-07-24 09:07:28.069175
309	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-07-20 20:05:53.382275	2025-07-24 09:07:28.143132
322	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-24 16:50:50.530728	2025-07-24 10:01:49.915022
311	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:16:36.626425	2025-07-26 14:27:25.850864
327	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-07-26 22:55:58.667584	2025-07-26 15:56:18.763547
331	32	New Permission Request	There is a new permission request from Dame Un GRR.	permission	f	2025-07-27 13:31:55.057353	\N
330	27	New Permission Request	There is a new permission request from Dame Un GRR.	permission	t	2025-07-27 13:31:46.016646	2025-07-27 06:34:14.733849
343	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:32:47.403393	\N
345	32	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:32:55.100116	\N
344	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-28 01:32:51.587059	2025-07-28 07:23:43.655492
351	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-07-28 15:26:34.086045	\N
353	1	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	f	2025-07-28 16:26:10.667372	\N
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.permissions (permissions_id, employee_id, permission_type, request_date, start_date, end_date, reason, permission_status, approved_date, user_id) FROM stdin;
30	1	personal-business	2025-07-11	2025-07-21	2025-07-23	Meeting	Approved	2025-07-27	1
23	12	family-urgent	2025-06-13	2025-06-16	2025-06-18	Cousin's Wedding	Declined	2025-07-27	21
38	27	family-urgent	2025-07-24	2025-07-25	2025-07-25	Wedding	Approved	2025-07-24	\N
43	35	other	2025-07-28	2025-07-29	2025-07-30	meeting	Approved	2025-07-28	48
27	12	sick-leave	2025-07-10	2025-07-11	2025-07-11	I got fever and stomachache	Approved	2025-07-10	21
28	1	personal-business	2025-07-11	2025-07-14	2025-07-15	Meeting 	Approved	2025-07-18	1
29	1	other	2025-07-11	2025-07-14	2025-07-15	Meeting	Declined	2025-07-18	1
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

COPY public."user" (user_id, employee_id, username, email, password, activity_date) FROM stdin;
27	17	angelinemoore	angelinemoore.notsafe@gmail.com	$2b$12$lP/uOO8ijTIhx/Nr7I1BBe99/FbY2GJu7VQEaGJrYEvhrs0sWyy6a	2025-07-30 17:02:17.539927+00
3	3	HR	nirwanaanisa1508@gmail.com	$2b$12$T4DFHbUtaKMxzFK1NyeAe.8bRQzFnuefZZR11Ei/kVP9kpGmAsuvq	2025-07-30 17:02:33.058701+00
49	36	ucooo	anisa.nrwn15@gmail.com	$2b$12$PKiSrlxtiobu0Kz54H5G2OAWksuRa1sg2EeTGLX.qX5B/3s7OHU2S	2025-07-30 17:02:43.157843+00
1	1	nblalb	nabilalb2004@gmail.com	$2b$12$KGpL.bYtXbRclxx.91GVqerU8I9EXrYk77KparUCDsjpmW/86KQOW	2025-07-30 17:02:55.372064+00
17	11	admin_nabila	nabilalb0109@gmail.com	$2b$12$mgGvRNU7003XLan5tjLice2r96RLOKpf/14ID39uTNllPYcP7cG12	2025-07-30 17:03:05.839286+00
4	4	SuperadminNab	nabila.libasutaqwa@student.president.ac.id	$2b$12$xIrAjHZdiy4OvX85aQPgDO60zttLywUOg/1agBVzw8Ah2EiBwesvC	2025-07-30 17:03:15.95621+00
48	35	tania	gwenrosevyn@gmail.com	$2b$12$0CxdWAnYZA8cyNT7Ju6Po.t8ulZ69W51vUXoh0lU/N7x6.UkIi9Lm	2025-07-30 17:03:25.992471+00
32	22	udin	annisanirwana94@yahoo.com	$2b$12$Q5Q.WbXkKwkalFl8rrhmLuSLL7VYGYdOH5apT1aql.OSdd3bGyLLm	2025-07-30 17:03:36.467025+00
21	12	yuyus	yustinayunitayy@gmail.com	$2b$12$d.dEzuYcgKD4iUh9ERlqwu3ZaZayY01OS9cyYqxL5pKrRcaZJTqhK	2025-07-30 17:03:50.969447+00
6	2	yuyusdaily	yustinayunita86@gmail.com	$2b$12$4//uWMT9q3S9SKTJigezV.4AFtlFO.WKF2135Pssq3GQJn.KID2J2	2025-07-30 17:14:31.052105+00
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.user_roles (user_id, roles_id) FROM stdin;
27	2
3	1
49	3
1	3
17	2
4	1
48	3
32	2
21	3
6	1
\.


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.activity_logs_log_id_seq', 988, true);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 405, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 37, true);


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.lock_system_lock_id_seq', 51, true);


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public."login_attempts_logAtt_id_seq"', 1940, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 355, true);


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.permissions_permissions_id_seq', 43, true);


--
-- Name: roles_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.roles_roles_id_seq', 1, false);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.user_user_id_seq', 56, true);


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
-- Name: ix_lock_system_lock_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_lock_system_lock_id ON public.lock_system USING btree (lock_id);


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

