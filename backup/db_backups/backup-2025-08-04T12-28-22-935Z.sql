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
-- Name: backup_schedule; Type: TABLE; Schema: public; Owner: Project_owner
--

CREATE TABLE public.backup_schedule (
    id integer NOT NULL,
    interval_minutes integer,
    start_time character varying(5),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.backup_schedule OWNER TO "Project_owner";

--
-- Name: backup_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: Project_owner
--

CREATE SEQUENCE public.backup_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.backup_schedule_id_seq OWNER TO "Project_owner";

--
-- Name: backup_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Project_owner
--

ALTER SEQUENCE public.backup_schedule_id_seq OWNED BY public.backup_schedule.id;


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
-- Name: backup_schedule id; Type: DEFAULT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.backup_schedule ALTER COLUMN id SET DEFAULT nextval('public.backup_schedule_id_seq'::regclass);


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
869	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:10:15.085262+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
867	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:01:45.490284+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
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
989	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-01 08:36:01.692703+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
990	6	Updated user	User HR updated successfully by yuyusdaily	127.0.0.1	2025-08-01 08:36:26.524542+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
991	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-01 08:37:29.093682+00	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0.1 Safari/605.1.15
992	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-01 09:12:32.318692+00	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.0.1 Safari/605.1.15
993	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-08-01 12:33:38.636497+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
994	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 12:52:24.184199+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
995	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 13:33:51.426354+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
996	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 14:08:53.718336+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
997	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 14:42:21.510457+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
998	27	Added employee	Employee Dame Novel added by angelinemoore	127.0.0.1	2025-08-01 15:06:02.726469+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
999	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 15:12:49.713815+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1000	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-08-01 15:23:21.11734+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1001	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-08-01 15:44:05.706464+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1002	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-01 17:59:18.83638+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1003	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-08-01 18:22:48.135432+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1004	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-08-01 18:25:50.322305+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1005	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-01 19:41:41.6515+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1006	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-01 20:12:15.826417+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1007	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-01 20:15:39.5943+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1008	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 22	127.0.0.1	2025-08-01 20:16:17.44738+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1009	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 3	127.0.0.1	2025-08-01 20:16:23.450626+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1010	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 38	127.0.0.1	2025-08-01 20:16:26.812712+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1011	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 36	127.0.0.1	2025-08-01 20:16:33.406364+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1012	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 1	127.0.0.1	2025-08-01 20:16:36.756912+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1013	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 36	127.0.0.1	2025-08-01 20:16:37.064894+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1014	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 36	127.0.0.1	2025-08-01 20:16:37.498779+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1015	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 36	127.0.0.1	2025-08-01 20:17:08.010153+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1016	4	Viewed employee profile	SuperadminNab viewed profile of employee ID 35	127.0.0.1	2025-08-01 20:17:17.455984+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1017	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-01 20:24:50.780499+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1018	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 04:31:48.017273+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1019	6	Created user	User yustinayunita86@gmail.com created successfully by yuyusdaily	127.0.0.1	2025-08-02 04:59:40.105115+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1020	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 05:03:19.807955+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1021	6	Deleted user	User 57 deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 05:03:32.299302+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1022	6	Created user	User yustinayunita86@gmail.com created successfully by yuyusdaily	127.0.0.1	2025-08-02 05:04:02.687055+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1023	6	Updated user	User yustinayunita86@gmail.com updated successfully by yuyusdaily	127.0.0.1	2025-08-02 05:04:17.534618+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1024	6	Updated user	User gwenrosevyn@gmail.com updated successfully by yuyusdaily	127.0.0.1	2025-08-02 05:04:32.151995+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1025	6	Deleted user	User 58 deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 05:05:00.638809+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1026	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 05:36:26.355761+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1027	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 05:36:52.26816+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1028	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 35	127.0.0.1	2025-08-02 05:37:14.795885+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1029	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 22	127.0.0.1	2025-08-02 05:37:18.188405+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1030	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 27	127.0.0.1	2025-08-02 05:37:21.253166+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1031	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 35	127.0.0.1	2025-08-02 05:37:25.78936+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1032	6	Deleted employee	Employee 35, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 05:37:33.651552+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
852	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:56:19.575702+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
853	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 07:58:51.522872+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
878	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-07-28 09:30:13.724945+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1033	6	Deleted employee	Employee 27, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 05:37:38.656627+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1034	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 06:08:08.702216+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1035	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 06:30:57.556707+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1036	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 07:02:51.18664+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1037	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 08:04:59.07269+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1038	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 08:32:52.011012+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1039	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 08:42:19.433889+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1040	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 08:44:04.698614+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1041	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 09:19:25.006459+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1042	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 09:31:56.439682+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1043	6	Added employee	Employee tania isabela added by yuyusdaily	127.0.0.1	2025-08-02 09:35:13.505423+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1044	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 39	127.0.0.1	2025-08-02 09:35:21.211772+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1045	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 39	127.0.0.1	2025-08-02 09:35:24.928679+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1046	6	Created user	User tania created successfully by yuyusdaily	127.0.0.1	2025-08-02 09:35:49.321534+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1049	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:12:58.424371+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1050	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:26:31.420165+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1052	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:32:00.721684+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1053	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 10:36:34.31655+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1054	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:38:11.369033+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1056	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 10:57:13.985044+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1057	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:58:02.582635+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1058	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 11:10:30.811335+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1060	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 12:47:20.953708+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1061	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 13:05:08.206845+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1062	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:06:39.976397+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1063	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 13:10:00.03222+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1064	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:16:41.940968+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1047	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 09:36:24.706546+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1048	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 09:48:47.503804+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1051	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:28:07.452734+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1055	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 10:38:27.293798+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1059	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 11:30:13.781631+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1065	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:17:56.515909+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1066	\N	Viewed employee profile	tania viewed profile of employee ID 39	127.0.0.1	2025-08-02 13:26:37.191638+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1068	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:29:07.877813+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1069	6	Added employee	Employee tania isabela added by yuyusdaily	127.0.0.1	2025-08-02 13:30:11.4435+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1070	6	Created user	User tania created successfully by yuyusdaily	127.0.0.1	2025-08-02 13:30:40.276607+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1071	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:31:20.831153+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1072	6	Updated user	User tania updated successfully by yuyusdaily	127.0.0.1	2025-08-02 13:31:32.190407+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1074	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:40:46.459276+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1073	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:31:57.861243+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1075	6	Deleted employee	Employee 40, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 13:41:02.794179+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1076	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 13:52:06.175516+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1077	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 13:59:44.694961+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1078	6	Deleted employee	Employee 38, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 14:00:00.829631+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1079	6	Added employee	Employee Dame Novel added by yuyusdaily	127.0.0.1	2025-08-02 14:01:25.909925+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1080	6	Created user	User Dame created successfully by yuyusdaily	127.0.0.1	2025-08-02 14:01:58.620311+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1082	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 14:40:00.587028+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1083	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 14:52:34.446852+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1084	6	Add employee failed	No face found in the image.	127.0.0.1	2025-08-02 14:53:25.432457+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1085	6	Added employee	Employee Dame Un GRR added by yuyusdaily	127.0.0.1	2025-08-02 14:54:19.799615+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1086	6	Deleted employee	Employee 42, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 14:54:40.491379+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1087	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-02 14:55:34.30035+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1088	6	Deleted employee	Employee 43, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 14:55:41.138888+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1090	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:12:10.237325+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1091	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:12:59.765402+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1092	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:14:22.963772+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1093	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 15:26:27.277232+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1094	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 15:31:13.322382+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1095	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:46:40.213612+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1096	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-02 15:47:45.60408+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1097	6	Deleted employee	Employee 44, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 15:52:43.566468+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1081	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-08-02 14:02:27.280982+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1089	\N	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:11:03.902823+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1098	6	Deleted employee	Employee 41, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 15:52:46.926265+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1099	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 15:55:05.786185+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1100	6	Added employee	Employee Damea isabela added by yuyusdaily	127.0.0.1	2025-08-02 15:55:44.948154+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1101	6	Deleted employee	Employee 45, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 16:15:19.561841+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1102	6	Added employee	Employee aaaaaaaaaaa aaaaaaaa added by yuyusdaily	127.0.0.1	2025-08-02 16:16:11.959741+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1103	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 16:17:54.379735+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1104	6	Created user	User aaaaaaaaaaaa created successfully by yuyusdaily	127.0.0.1	2025-08-02 16:18:20.280713+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1106	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 16:22:19.450718+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1107	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 16:24:12.4293+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1108	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 16:24:42.112693+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1109	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 16:24:45.262792+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1110	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 16:38:17.93925+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1111	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 16:52:32.672325+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1112	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-02 16:53:19.281178+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1113	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-02 17:01:26.041112+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1105	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-02 16:18:54.228326+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1114	6	Deleted employee	Employee 46, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 17:01:48.436016+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1115	6	Added employee	Employee a a added by yuyusdaily	127.0.0.1	2025-08-02 17:02:44.579808+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1116	6	Added employee	Employee a a added by yuyusdaily	127.0.0.1	2025-08-02 17:05:53.092574+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1117	6	Deleted employee	Employee 48, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 17:05:56.576547+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1118	6	Deleted employee	Employee 49, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-02 17:05:59.496223+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1119	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 18:43:12.964616+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1120	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 18:43:33.496109+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1121	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 18:49:05.99909+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1122	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 18:49:40.349593+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1123	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 18:53:24.093097+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1124	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 18:58:53.629827+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1125	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 18:59:26.286285+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1126	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-02 19:04:25.115661+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1127	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 19:06:22.823287+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1128	3	User update failed	type object 'User' has no attribute 'id'	127.0.0.1	2025-08-02 19:18:53.596033+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1129	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:24:43.698729+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1130	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 19:25:32.686271+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1131	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:26:18.461418+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1132	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:28:39.27284+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1133	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:32:44.463677+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1134	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:38:58.787412+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1135	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:53:51.973888+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1136	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 19:54:28.118965+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1137	3	Updated user	User HR updated successfully by HR	127.0.0.1	2025-08-02 19:56:16.738983+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1138	3	Updated user	User udin updated successfully by HR	127.0.0.1	2025-08-02 19:56:56.240267+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1139	3	Updated user	User ucooo updated successfully by HR	127.0.0.1	2025-08-02 19:57:24.368384+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1140	3	Updated user	User superadminisa updated successfully by superadminisa	127.0.0.1	2025-08-02 19:58:14.193231+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1141	3	Updated user	User superadminisa updated successfully by superadminisa	127.0.0.1	2025-08-02 19:58:36.121993+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1142	3	Updated user	User superadminisa updated successfully by superadminisa	127.0.0.1	2025-08-02 19:58:55.873946+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1143	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 20:09:18.472737+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1144	3	Updated user	User superadminisaa updated successfully by superadminisaa	127.0.0.1	2025-08-02 20:10:11.958116+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1145	3	Deleted user	User 32 deleted successfully by superadminisaa	127.0.0.1	2025-08-02 20:20:02.529134+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1146	3	Updated user	User superadminisaa updated successfully by superadminisaa	127.0.0.1	2025-08-02 20:34:19.899503+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1147	3	Updated user	User superadminisaaaaa updated successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:35:13.792642+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1148	3	Created user	User hm created successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:39:14.162407+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1149	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 20:40:26.169915+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1150	3	Deleted user	User 63 deleted successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:43:04.331918+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1151	3	Created user	User hmm created successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:43:38.793553+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1152	3	Updated user	User superadminisaaaaa updated successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:48:24.762916+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1153	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-02 20:49:13.235226+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1154	3	Deleted user	User 64 deleted successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:49:42.002013+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1155	3	Created user	User mm created successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:50:19.459901+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1156	3	User deletion failed	403: The password you entered is incorrect.	127.0.0.1	2025-08-02 20:57:18.167469+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1157	3	User deletion failed	name 'email' is not defined	127.0.0.1	2025-08-02 20:57:38.218779+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1158	3	Deleted user	User 65 deleted successfully by superadminisaaaaa	127.0.0.1	2025-08-02 20:59:17.442816+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1159	3	Created user	User hmm created successfully by superadminisaaaaa	127.0.0.1	2025-08-02 21:01:46.266022+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1160	3	Updated user	User ucooo updated successfully by superadminisaaaaa	127.0.0.1	2025-08-02 21:03:16.213182+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1161	49	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-08-02 21:04:11.063066+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1162	49	Deleted user	User 66 deleted successfully by ucooo	127.0.0.1	2025-08-02 21:04:34.435334+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1163	49	Updated user	User superadminisaaaaaa updated successfully by ucooo	127.0.0.1	2025-08-02 21:09:40.587249+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1164	49	Created user	User mmm created successfully by ucooo	127.0.0.1	2025-08-02 21:10:06.483998+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1165	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 04:42:58.871858+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1166	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 05:04:45.924608+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1167	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 47	127.0.0.1	2025-08-03 05:05:02.664239+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1168	6	Deleted employee	Employee 47, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 05:05:07.413177+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1169	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-03 05:06:08.637842+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1170	6	Created user	User yustinayunita86@gmail.com created successfully by yuyusdaily	127.0.0.1	2025-08-03 05:07:07.872506+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1172	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 05:08:35.460884+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1173	49	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-08-03 05:12:41.224721+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1174	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 05:14:01.450909+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1175	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 05:33:05.959152+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1176	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 50	127.0.0.1	2025-08-03 05:33:11.75577+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1177	6	Added employee	Employee tania isabela added by yuyusdaily	127.0.0.1	2025-08-03 05:34:01.310211+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1178	6	Created user	User tania created successfully by yuyusdaily	127.0.0.1	2025-08-03 05:34:18.915571+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1180	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 06:59:12.8025+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1181	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 07:37:19.880764+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1182	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:28:05.929795+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1183	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:28:44.572896+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1184	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:29:31.541071+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1185	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:30:19.61955+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1186	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:31:19.997786+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1187	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:33:45.629419+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1171	\N	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-08-03 05:07:42.502716+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1188	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:36:51.422312+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1179	\N	Login	User akunapaajabebasserahku@gmail.com logged in successfully	127.0.0.1	2025-08-03 05:34:46.100134+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1189	6	Deleted employee	Employee 51, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 08:37:30.969583+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1191	6	Updated user	User adel updated successfully by yuyusdaily	127.0.0.1	2025-08-03 08:38:06.913481+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1190	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 08:37:44.918737+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1192	1	Login	User nabilalb2004@gmail.com logged in successfully	127.0.0.1	2025-08-03 08:43:45.59238+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1193	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:09:59.514184+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1194	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 09:12:03.923703+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1195	6	Updated user	User superadminisaaaaaa updated successfully by yuyusdaily	127.0.0.1	2025-08-03 09:12:04.607803+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1196	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:20:39.041862+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1197	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:33:11.021299+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1198	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:38:19.523471+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1199	6	Deleted employee	Employee 50, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 09:38:28.637152+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1200	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-03 09:39:22.705474+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1201	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:45:54.120472+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1202	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 09:49:50.585107+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1203	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:54:08.347661+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1204	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-08-03 09:56:54.915651+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1205	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 10:16:50.175757+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1206	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 10:27:06.538708+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1207	6	Add employee failed	No face found in the image.	127.0.0.1	2025-08-03 10:28:56.978766+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1208	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-03 10:29:46.957745+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1209	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-03 10:31:24.016901+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1210	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 10:53:27.51156+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1211	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 11:02:12.943396+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1212	3	Updated user	User superadminisa updated successfully by superadminisa	127.0.0.1	2025-08-03 11:04:13.157025+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1213	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 11:11:19.470824+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1214	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 11:21:57.483276+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1215	6	Added employee	Employee aaaaaaaaaaa isabela added by yuyusdaily	127.0.0.1	2025-08-03 11:25:04.137287+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1216	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 11:58:06.38962+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1217	3	Added employee	Employee juminten lasmi added by superadminisa	127.0.0.1	2025-08-03 12:00:18.73697+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1218	3	Added employee	Employee abid laqo added by superadminisa	127.0.0.1	2025-08-03 12:02:18.186155+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1219	3	Viewed employee profile	superadminisa viewed profile of employee ID 57	127.0.0.1	2025-08-03 12:04:13.866731+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1220	3	Viewed employee profile	superadminisa viewed profile of employee ID 57	127.0.0.1	2025-08-03 12:05:13.32289+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1221	3	Updated employee	Employee abid updated by superadminisa	127.0.0.1	2025-08-03 12:05:18.959599+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1222	3	Created user	User arjuna created successfully by superadminisa	127.0.0.1	2025-08-03 12:06:18.788851+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1223	70	Login	User anisa.n@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 12:06:50.706253+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1224	70	Login	User anisa.n@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 12:18:50.258356+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1225	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 12:31:32.660529+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1226	4	Added employee	Employee Cinta Lala added by SuperadminNab	127.0.0.1	2025-08-03 12:32:09.318852+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1227	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 13:02:06.873483+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1228	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 55	127.0.0.1	2025-08-03 13:02:18.144953+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1229	6	Deleted employee	Employee 55, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 13:02:23.011711+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1230	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 52	127.0.0.1	2025-08-03 13:02:26.499352+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1231	6	Deleted employee	Employee 52, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 13:02:31.580646+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1232	6	Viewed employee profile	yuyusdaily viewed profile of employee ID 54	127.0.0.1	2025-08-03 13:02:34.233029+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1233	6	Deleted employee	Employee 54, linked user, permission, and attendance data deleted successfully by yuyusdaily	127.0.0.1	2025-08-03 13:02:39.06087+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1234	6	Added employee	Employee Dame isabela added by yuyusdaily	127.0.0.1	2025-08-03 13:03:21.27822+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1235	6	Created user	User dame created successfully by yuyusdaily	127.0.0.1	2025-08-03 13:03:47.184265+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1236	71	Login	User gwenrosevyn@gmail.com logged in successfully	127.0.0.1	2025-08-03 13:04:20.618364+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1237	70	Login	User anisa.n@student.president.ac.id logged in successfully	127.0.0.1	2025-08-03 13:04:38.546226+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1238	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-03 13:21:40.945733+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1239	6	Created user	User Nabila created successfully by yuyusdaily	127.0.0.1	2025-08-03 13:23:29.291278+00	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Mobile Safari/537.36
1240	72	Login	User dwiadinda438@gmail.com logged in successfully	127.0.0.1	2025-08-03 13:24:41.95357+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1241	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 19:14:25.268913+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1242	3	Updated user	User ucooo updated successfully by superadminisa	127.0.0.1	2025-08-03 19:15:02.297382+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1243	49	Login	User anisa.nrwn15@gmail.com logged in successfully	127.0.0.1	2025-08-03 19:15:42.799582+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1244	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 20:06:54.063739+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0
1245	3	Login	User nirwanaanisa1508@gmail.com logged in successfully	127.0.0.1	2025-08-03 20:17:35.451481+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36
1246	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-04 10:45:48.542282+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1247	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-04 11:17:46.725743+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1248	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-08-04 11:43:22.630213+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1249	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-08-04 11:58:30.477176+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1250	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-04 12:01:45.562499+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1251	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-08-04 12:02:12.960299+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1252	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-08-04 12:03:14.686727+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1253	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-08-04 12:07:45.650394+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1254	6	Updated user	User yuyusdaily updated successfully by yuyusdaily	127.0.0.1	2025-08-04 12:09:55.431021+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1255	6	Updated user	User yuyus updated successfully by yuyusdaily	127.0.0.1	2025-08-04 12:10:20.74162+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
1256	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-08-04 12:25:39.417266+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.alembic_version (version_num) FROM stdin;
020fe06cd293
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
406	12	2025-07-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
407	12	2025-07-31	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
78	12	2025-06-27	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
79	1	2025-06-28	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
82	1	2025-06-29	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
112	1	2025-07-05	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
408	1	2025-07-29	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
160	1	2025-07-13	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
162	12	2025-07-13	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
409	1	2025-07-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
410	1	2025-07-31	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
166	1	2025-07-14	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
172	1	2025-07-15	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
150	12	2025-07-11	0	Permit	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
411	1	2025-08-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
154	1	2025-07-12	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
447	1	2025-08-02	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
448	57	2025-08-03	40064	Punch In	19:07:44.76886	-6.296755002947567	106.89141498559405	t	hujan cok	0.18732126459704393	\N	\N	\N	f	\N	\N	t	\N	\N
449	59	2025-08-03	43478	Punch In	20:04:38.16933	-6.4732895	106.8513759	t	a	0.38291012154979526	\N	\N	\N	f	\N	\N	t	\N	\N
450	58	2025-07-28	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
451	58	2025-07-29	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
452	58	2025-07-30	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
453	58	2025-07-31	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
454	58	2025-08-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
455	58	2025-08-02	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
456	12	2025-08-01	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
457	12	2025-08-02	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
458	12	2025-08-03	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
36	12	2025-06-13	0	Punch Out	07:39:30	-6.48473	106.835542	t	\N	0.3917414786432555	17:18:51	-6.458581	106.856179	t	External training	0.1920983344746093	t	34761	2361
48	12	2025-06-17	0	Punch Out	07:51:26	-6.48473	106.835542	t	\N	0.4470114875001813	17:57:37	-6.458581	106.856179	t	Client meeting outside	0.5056224197081575	t	36371	3971
33	12	2025-06-12	138	Punch Out	08:02:18	-6.458581	106.856179	t	Overslept	0.1685562812213936	17:05:56	-6.48021	106.865781	t	Client meeting outside	0.2638717773820157	t	32618	218
57	12	2025-06-20	0	Punch Out	07:50:05	-6.458581	106.856179	t	\N	0.53067402001119	17:53:23	-6.48473	106.835542	t	Client meeting	0.2610236695697169	t	36198	3798
54	12	2025-06-19	64	Punch Out	08:01:04	-6.48021	106.865781	t	GPS Error	0.3734998841840104	17:58:30	-6.48021	106.865781	t	Client meeting	0.1701483418730249	t	35846	3446
412	1	2025-08-04	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
413	1	2025-08-05	0	Permit	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
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
94	1	2025-07-02	0	Punch Out	07:49:38	-6.472422	106.852744	t	\N	0.5200238435947641	16:31:09	-6.472424	106.853749	t	\N	0.3472142099333847	t	31291	0
96	12	2025-07-02	0	Punch Out	07:37:43	-6.48473	106.835542	t	\N	0.3809984879901234	17:57:27	-6.48473	106.835542	t	Finished late	0.537947057600453	t	37184	4784
100	1	2025-07-03	0	Punch Out	07:37:53	-6.472424	106.853749	t	\N	0.5452425232746203	17:48:07	-6.473104	106.851692	t	\N	0.5305854475840168	t	36614	4214
106	1	2025-07-04	0	Punch Out	07:52:19	-6.473104	106.851692	t	\N	0.5687409088467008	17:22:59	-6.472424	106.853749	t	\N	0.2718703126885045	t	34240	1840
108	12	2025-07-04	1197	Punch Out	08:19:57	-6.48021	106.865781	t	Heavy Traffic	0.2433473427495785	17:16:16	-6.458581	106.856179	t	Have a Doctor Appoinment	0.4458468306557256	t	32179	0
60	12	2025-06-21	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
61	1	2025-06-22	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
63	12	2025-06-22	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
76	1	2025-06-27	0	Holiday	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
81	12	2025-06-28	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
84	12	2025-06-29	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
124	1	2025-07-07	676	Punch Out	08:11:16	-6.473104	106.851692	t	\N	0.5281226598245311	16:46:07	-6.472424	106.853749	t	\N	0.5376516422277063	t	30891	0
130	1	2025-07-08	0	Punch Out	07:32:54	-6.473104	106.851692	t	\N	0.1472348814726012	17:02:49	-6.472422	106.852744	t	\N	0.5617173844980989	t	34195	1795
136	1	2025-07-09	0	Punch Out	07:49:54	-6.472422	106.852744	t	\N	0.55971539316378	16:40:41	-6.472422	106.852744	t	\N	0.5437640309664818	t	31847	0
138	12	2025-07-09	0	Punch Out	07:41:27	-6.48473	106.835542	t	\N	0.4509125109093783	17:04:08	-6.48021	106.865781	t	Felt unwell	0.3492249404491005	t	33761	1361
142	1	2025-07-10	0	Punch Out	07:50:53	-6.472424	106.853749	t	\N	0.5335811715689723	17:42:16	-6.472422	106.852744	t	\N	0.4951094721960346	t	35483	3083
148	1	2025-07-11	721	Punch Out	08:12:01	-6.472424	106.853749	t	\N	0.2219247062932981	17:43:21	-6.472422	106.852744	t	\N	0.1230318992126737	t	34280	1880
178	1	2025-07-16	918	Punch Out	08:15:18	-6.473104	106.851692	t	\N	0.1130023394113955	17:51:42	-6.472424	106.853749	t	\N	0.472256245648935	t	34584	2184
144	12	2025-07-10	1074	Punch Out	08:17:54	-6.458581	106.856179	t	Overslept	0.4292439935505095	16:33:27	-6.458581	106.856179	t	Felt unwell	0.1040591042186166	t	29733	0
168	12	2025-07-14	1372	Punch Out	08:22:52	-6.48021	106.865781	t	Client Meeting	0.3746008314329702	16:38:38	-6.48473	106.835542	t	Went Home Early	0.2022549535461525	t	29746	0
174	12	2025-07-15	0	Punch Out	07:36:10	-6.48021	106.865781	t	\N	0.3886568339820697	16:50:52	-6.48473	106.835542	t	Client meeting	0.4094541247392527	t	33282	882
120	12	2025-07-06	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
156	12	2025-07-12	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
184	1	2025-07-17	605	Punch Out	08:10:05	-6.472422	106.852744	t	\N	0.5875097809665365	16:34:54	-6.472422	106.852744	t	\N	0.1193272189565999	t	30289	0
190	1	2025-07-18	0	Punch Out	07:58:00	-6.473104	106.851692	t	\N	0.3354611546803096	17:39:24	-6.472422	106.852744	t	\N	0.1994021158598616	t	34884	2484
210	12	2025-07-21	468	Punch Out	08:07:48	-6.48473	106.835542	t	Vehicle Breakdown	0.5190100611249776	17:32:44	-6.458581	106.856179	t	Overtime	0.4236750333114092	t	33896	1496
216	12	2025-07-22	1359	Punch Out	08:22:39	-6.48021	106.865781	t	Client Meeting	0.1348153662908209	16:39:00	-6.48473	106.835542	t	Had appointment	0.4893686077167323	t	29781	0
226	1	2025-07-24	0	Punch Out	07:48:08	-6.472424	106.853749	t	\N	0.3248271178443993	17:58:17	-6.472424	106.853749	t	\N	0.5806576246259837	t	36609	4209
228	12	2025-07-24	0	Punch Out	07:55:35	-6.458581	106.856179	t	\N	0.5053744141670914	16:54:32	-6.458581	106.856179	t	Family emergency	0.5396031011144024	t	32337	0
232	1	2025-07-25	1393	Punch Out	08:23:13	-6.472424	106.853749	t	\N	0.4589852431627047	16:58:23	-6.472422	106.852744	t	\N	0.1868872496523518	t	30910	0
222	12	2025-07-23	1380	Punch Out	08:23:00	-6.48021	106.865781	t	Overslept	0.3050127995444153	17:03:43	-6.48021	106.865781	t	Client Meeting	0.4548592703184627	t	31243	0
196	1	2025-07-19	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
198	12	2025-07-19	0	Weekend	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	0	0
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
382	1	2025-07-26	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
383	1	2025-07-27	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
391	12	2025-07-26	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
392	12	2025-07-27	0	Weekend	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
393	12	2025-07-28	19045	Punch In	13:17:25.779596	-6.2855394	107.1705025	t		0.38427458285812566	\N	\N	\N	f	\N	\N	t	\N	\N
401	1	2025-07-28	23138	Punch Out	14:25:38.236823	-6.28471128207743	107.17083811853594	t		0.33949354224093364	16:28:12.874552	-6.2226432	106.8204032	t	aaa	0.31632754362727444	t	7354	0
405	12	2025-07-29	0	Absent	\N	\N	\N	f	\N	\N	\N	\N	\N	f	\N	\N	f	\N	\N
\.


--
-- Data for Name: backup_schedule; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.backup_schedule (id, interval_minutes, start_time, created_at, updated_at) FROM stdin;
1	20160	19:28	2025-08-02 07:03:02.75811	2025-08-04 12:28:14.069139
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.employees (employee_id, first_name, last_name, nrp_id, email, phone_number, "position", department, face_encoding, join_date) FROM stdin;
57	abid	laqo	212345675	anisa.n@student.president.ac.id	081371575885	CLEANING SERVICE KK	BAN	[[-0.09427933394908905, 0.03872782737016678, 0.05520331487059593, -0.07687605172395706, -0.04843256250023842, -0.047309841960668564, -0.046634890139102936, -0.1396673172712326, 0.2253974825143814, -0.11833392828702927, 0.26827457547187805, -0.08726604282855988, -0.21726922690868378, -0.11895435303449631, -0.005020842421799898, 0.18367215991020203, -0.13964858651161194, -0.1406848281621933, -0.005082564894109964, 0.005525503307580948, 0.03454218804836273, -0.030983200296759605, 0.09697312861680984, 0.06825635582208633, -0.15141898393630981, -0.45199862122535706, -0.1284203678369522, -0.0731123760342598, -0.042190320789813995, -0.01838376186788082, -0.05024760216474533, 0.14725540578365326, -0.2304939478635788, -0.06898393481969833, 0.009967979975044727, 0.17243437469005585, -0.037478968501091, -0.06277086585760117, 0.19548910856246948, -0.008419143036007881, -0.2750996947288513, -0.08167159557342529, 0.0232841894030571, 0.23029063642024994, 0.09601633995771408, 0.010865522548556328, 0.03706452623009682, -0.07502575218677521, 0.07437872886657715, -0.21701838076114655, 0.05132172629237175, 0.13610787689685822, 0.0402897410094738, -0.00572562962770462, -0.010279986076056957, -0.10705028474330902, 0.01874403841793537, 0.1141124963760376, -0.22611622512340546, -0.027226803824305534, 0.058565422892570496, -0.12908408045768738, -0.0901632308959961, -0.08476605266332626, 0.21098673343658447, 0.20725347101688385, -0.10086949914693832, -0.16577698290348053, 0.1548997163772583, -0.13570378720760345, 0.008592497557401657, 0.08386829495429993, -0.15902243554592133, -0.24268753826618195, -0.34865739941596985, -0.007615426555275917, 0.36403393745422363, 0.056089580059051514, -0.1173076331615448, 0.04380103200674057, -0.04020418971776962, 5.0134025514125824e-05, 0.07403264939785004, 0.1525343507528305, -0.011780906468629837, 0.12911386787891388, -0.10685928165912628, 0.07219255715608597, 0.1794518530368805, -0.08951766788959503, -0.02870963141322136, 0.2288193255662918, -0.0485549122095108, 0.10952366143465042, 0.019541148096323013, 0.07407844066619873, -0.043560244143009186, 0.04587368294596672, -0.18234816193580627, 0.04910324141383171, 0.08340104669332504, 0.017543261870741844, -0.007917610928416252, 0.08075445890426636, -0.15908271074295044, 0.07998568564653397, 0.017661646008491516, -0.03296016529202461, 0.04917936027050018, -0.04354240745306015, -0.0905812606215477, -0.15896891057491302, 0.1239560917019844, -0.2426731288433075, 0.1146414577960968, 0.1777697503566742, 0.018717657774686813, 0.17635586857795715, 0.08905025571584702, 0.06782414019107819, 0.003307139500975609, -0.08080580085515976, -0.23353123664855957, 0.01957426406443119, 0.1053030714392662, 0.002868855372071266, 0.022532116621732712, -0.0027209990657866], [-0.07082338631153107, 0.016386229544878006, 0.03879588469862938, -0.021084126085042953, -0.0781918540596962, 0.05530254915356636, -0.050394944846630096, -0.12714365124702454, 0.1557214856147766, -0.16708850860595703, 0.23552997410297394, 0.012645380571484566, -0.17517147958278656, -0.05833443999290466, -0.028352025896310806, 0.13484516739845276, -0.044560760259628296, -0.15169578790664673, -0.09907431155443192, -0.06601566821336746, -0.012263636104762554, 0.061400461941957474, 0.029564905911684036, -0.0414840504527092, -0.18333207070827484, -0.3225107789039612, -0.08391500264406204, -0.036330241709947586, 0.036327116191387177, 0.007230766117572784, -0.04656549170613289, 0.09193972498178482, -0.18033729493618011, -0.00710979662835598, 0.01594451442360878, 0.1644594520330429, -0.057639531791210175, 0.01708184741437435, 0.20469000935554504, 0.07225237041711807, -0.2062000036239624, 0.04153557866811752, 0.016307730227708817, 0.3131355941295624, 0.18028618395328522, 0.020107505843043327, 0.04858113452792168, -0.03336663171648979, 0.049020349979400635, -0.27665477991104126, 0.10081779956817627, 0.1094035655260086, 0.12663207948207855, 0.06159995123744011, 0.043173499405384064, -0.111609548330307, 0.02274767868220806, 0.1289222687482834, -0.16595099866390228, 0.04685484245419502, 0.0923522487282753, -0.049934692680835724, -0.008005301468074322, 0.006125658750534058, 0.24928690493106842, 0.15761664509773254, -0.08284740895032883, -0.11049240827560425, 0.2035214900970459, -0.16019468009471893, -0.04006358981132507, 0.0319003164768219, -0.1217278316617012, -0.17427033185958862, -0.29900574684143066, 0.06655099242925644, 0.4562174379825592, 0.1547679603099823, -0.15868912637233734, 0.03677044436335564, -0.024042459204792976, 0.026397230103611946, 0.15064138174057007, 0.029518848285079002, -0.05268789827823639, -0.012406245805323124, -0.08322250097990036, 0.014606486074626446, 0.25685545802116394, -0.023474298417568207, -0.04688116908073425, 0.20312617719173431, 0.06858964264392853, 0.0013374518603086472, 0.07967264205217361, 0.05328445881605148, -0.013836225494742393, -0.006859109736979008, -0.15174607932567596, 0.03406785801053047, -0.02900071069598198, -0.08497901260852814, 0.06192078813910484, 0.11889123916625977, -0.1697748303413391, 0.21714235842227936, -0.014034128747880459, -0.01318272016942501, 0.054438017308712006, 0.08688509464263916, -0.07591280341148376, -0.09277448803186417, 0.13214030861854553, -0.2514527142047882, 0.12571564316749573, 0.17309381067752838, 0.016601860523223877, 0.16691024601459503, 0.10055170208215714, 0.12433785200119019, 0.005218559876084328, 0.042566124349832535, -0.17927221953868866, -0.09913600981235504, -0.018285129219293594, -0.028570424765348434, 0.039802953600883484, 0.12718798220157623], [-0.05036184564232826, 0.008740361779928207, 0.019801508635282516, -0.09429619461297989, -0.08771765232086182, 0.03585274517536163, -0.012963850982487202, -0.11857254803180695, 0.21428029239177704, -0.12411221861839294, 0.2525462806224823, -0.0056677572429180145, -0.21926449239253998, -0.11123528331518173, 0.035852059721946716, 0.13450589776039124, -0.11070676892995834, -0.16953560709953308, 0.022826287895441055, -0.0018274402245879173, 0.007603935897350311, -0.01996443420648575, 0.07429854571819305, 0.019546695053577423, -0.13035854697227478, -0.43630462884902954, -0.0988156795501709, -0.04367318004369736, 0.05270851030945778, -0.06255443394184113, -0.06922837346792221, 0.14825314283370972, -0.20756930112838745, -0.020055163651704788, 0.04380861669778824, 0.17041227221488953, -0.06692413985729218, -0.08255135267972946, 0.23218496143817902, 0.061788205057382584, -0.23984776437282562, -0.06887184083461761, -0.006497644819319248, 0.2734031081199646, 0.12346057593822479, -0.007962205447256565, 0.03727066516876221, -0.04980633407831192, 0.060024939477443695, -0.23032358288764954, 0.08097083121538162, 0.16060350835323334, 0.02107139863073826, -0.029234251007437706, 0.020774152129888535, -0.1294940710067749, -0.014871431514620781, 0.07827196270227432, -0.2184847891330719, -0.005264909937977791, 0.04638626426458359, -0.06510147452354431, -0.09846160560846329, -0.10124094784259796, 0.21896032989025116, 0.18030855059623718, -0.10054303705692291, -0.15372635424137115, 0.16743788123130798, -0.13701190054416656, -0.034594617784023285, 0.026731763035058975, -0.179033100605011, -0.21397525072097778, -0.270891934633255, 0.006707228720188141, 0.34869566559791565, 0.09815747290849686, -0.14811402559280396, 0.06059498339891434, -0.011538212187588215, -0.019357793033123016, 0.11778194457292557, 0.13642755150794983, -0.017038099467754364, 0.10981081426143646, -0.07058713585138321, 0.04674277454614639, 0.18759505450725555, -0.0480310320854187, -0.057794682681560516, 0.20169678330421448, -0.040263108909130096, 0.07641851902008057, 0.06299694627523422, 0.047878678888082504, -0.01672166958451271, 0.00596795417368412, -0.23856176435947418, -0.030676795169711113, 0.0492173433303833, -0.04933800920844078, 0.003249985631555319, 0.15377216041088104, -0.20371446013450623, 0.110524483025074, 0.029038920998573303, -0.05241931974887848, 0.06468494981527328, -0.034924935549497604, -0.11007647216320038, -0.12549330294132233, 0.10934633016586304, -0.27436134219169617, 0.14604346454143524, 0.2057611346244812, 0.05016670748591423, 0.15425211191177368, 0.0996687263250351, 0.03478201478719711, 0.042500995099544525, -0.05033206194639206, -0.20609675347805023, -0.0234626904129982, 0.0374983549118042, 0.015845511108636856, 0.004642835818231106, 0.0011556795798242092], [-0.11292383819818497, 0.027469299733638763, 0.04383917525410652, -0.06629804521799088, -0.029288578778505325, -0.05617472156882286, -0.026759425178170204, -0.1489720195531845, 0.22011972963809967, -0.13990919291973114, 0.2646840810775757, -0.10535486042499542, -0.2197539359331131, -0.11871901899576187, -0.006466589868068695, 0.1940336525440216, -0.1555589735507965, -0.13088743388652802, -0.012138456106185913, 0.004742355085909367, 0.019219819456338882, -0.05218319222331047, 0.11266711354255676, 0.06077594682574272, -0.13353118300437927, -0.4461264908313751, -0.12310288101434708, -0.10024544596672058, -0.03574459254741669, -9.208568371832371e-05, -0.0656372457742691, 0.1303969770669937, -0.22281447052955627, -0.07155464589595795, -0.002477322705090046, 0.1589854508638382, -0.05259021371603012, -0.04319092258810997, 0.20823001861572266, -0.00474177859723568, -0.28267261385917664, -0.08296620845794678, 0.028323400765657425, 0.23305557668209076, 0.10915739834308624, 0.020456276834011078, 0.02254660055041313, -0.08679540455341339, 0.07327976822853088, -0.2187511920928955, 0.06272950023412704, 0.11878828704357147, 0.05740261450409889, -0.005575566552579403, -0.007771390490233898, -0.10364919900894165, 0.013318103738129139, 0.1295560896396637, -0.22277376055717468, -0.0061136893928050995, 0.08252043277025223, -0.12552109360694885, -0.07936552911996841, -0.07252098619937897, 0.24438415467739105, 0.21527262032032013, -0.11729131639003754, -0.13997285068035126, 0.1670074611902237, -0.12933850288391113, 0.02334999293088913, 0.08126920461654663, -0.1490098387002945, -0.25064775347709656, -0.33697277307510376, -0.006895130500197411, 0.34986650943756104, 0.05895376577973366, -0.09031248092651367, 0.02164231240749359, -0.0648077204823494, -0.0023192260414361954, 0.08902141451835632, 0.1672687530517578, -0.014244064688682556, 0.10016920417547226, -0.0883755087852478, 0.043173227459192276, 0.16505368053913116, -0.0909971073269844, -0.030129684135317802, 0.22251589596271515, -0.06557880342006683, 0.09079471975564957, -0.003550392109900713, 0.05871621146798134, -0.06361491233110428, 0.03978753089904785, -0.18564234673976898, 0.026360686868429184, 0.059321172535419464, -0.0020332960411906242, -0.003012124914675951, 0.07527700066566467, -0.1646278351545334, 0.06070704758167267, 0.010541378520429134, -0.026785967871546745, 0.06756937503814697, -0.04636254906654358, -0.07469930499792099, -0.15332715213298798, 0.1117083728313446, -0.24102899432182312, 0.12737363576889038, 0.17905265092849731, 0.032801441848278046, 0.17264999449253082, 0.09615828096866608, 0.062240347266197205, 0.004858301021158695, -0.07249995321035385, -0.25134456157684326, 0.0397963784635067, 0.11506938934326172, 0.008730944246053696, 0.03568891063332558, -0.0013002264313399792]]	2025-08-03
59	Dame	isabela	132121211	gwenrosevyn@gmail.com	081298364838	Front End Developer	Web Developer	[[-0.0982743501663208, 0.048519670963287354, 0.017876725643873215, -0.056537777185440063, -0.056792594492435455, -0.07005199044942856, -0.08230304718017578, -0.22235701978206635, 0.12501691281795502, -0.190151646733284, 0.24596242606639862, -0.11693435162305832, -0.21532489359378815, -0.07003801316022873, -0.08544012904167175, 0.16578131914138794, -0.13113774359226227, -0.1411464959383011, -0.05048995465040207, 0.0028790663927793503, 0.12133227288722992, -0.02463608793914318, 0.0482136607170105, 0.05247371643781662, -0.0993490070104599, -0.27934229373931885, -0.1465209573507309, -0.09608346968889236, 0.0037844665348529816, -0.04022699594497681, -0.017544934526085854, -0.017131926491856575, -0.2275456041097641, -0.016247302293777466, -0.00723020127043128, 0.0969863161444664, -0.043855708092451096, -0.045874886214733124, 0.18125733733177185, 0.00022222381085157394, -0.23622846603393555, -0.0020992537029087543, 0.000836612656712532, 0.18936873972415924, 0.1276564598083496, 0.08225147426128387, 0.008064029738307, -0.19652707874774933, 0.07342162728309631, -0.18397779762744904, 0.07276389747858047, 0.1074657067656517, 0.09268756210803986, 0.03726929426193237, -0.00042974576354026794, -0.15170393884181976, 0.06007727235555649, 0.13010121881961823, -0.1980534940958023, 0.07290059328079224, 0.13817280530929565, -0.07824242115020752, -0.034831129014492035, -0.06780308485031128, 0.27898284792900085, 0.13963763415813446, -0.16940250992774963, -0.11400692909955978, 0.1467869132757187, -0.1655065417289734, -0.031123057007789612, 0.10740437358617783, -0.10789859294891357, -0.23971720039844513, -0.2874387204647064, -0.006545368582010269, 0.4721408486366272, 0.12817032635211945, -0.17006118595600128, 0.00135906133800745, -0.04109715297818184, 0.01781361736357212, 0.16889940202236176, 0.15714731812477112, -0.023622486740350723, 0.047598958015441895, -0.07501212507486343, 0.011149559170007706, 0.20598575472831726, -0.07577977329492569, -0.05996944010257721, 0.23655687272548676, -0.05321376025676727, 0.10329410433769226, 0.002244149800390005, 0.00933105032891035, -0.05214565247297287, 0.00015593087300658226, -0.0919700339436531, 0.007403666153550148, -0.03063497506082058, -0.01753225550055504, -0.023447247222065926, 0.04812999814748764, -0.057032011449337006, 0.12270823866128922, -0.009635153226554394, -0.011144840158522129, -0.03712641820311546, -0.0261665191501379, -0.118792824447155, -0.05199485644698143, 0.12523752450942993, -0.25449398159980774, 0.2105429768562317, 0.14324359595775604, 0.08302868902683258, 0.1371091902256012, 0.13859756290912628, 0.11485962569713593, 0.00989276822656393, -0.03945675864815712, -0.23975570499897003, -0.009792822413146496, 0.11409618705511093, -0.04579269140958786, 0.16275401413440704, -0.018924733623862267], [-0.11118322610855103, 0.07581192255020142, -0.0009240717627108097, -0.06590335816144943, -0.089671790599823, -0.051104139536619186, -0.08415380865335464, -0.19311094284057617, 0.12646566331386566, -0.18145516514778137, 0.24506989121437073, -0.116468645632267, -0.2564028203487396, -0.035960178822278976, -0.11821430921554565, 0.204636812210083, -0.10606906563043594, -0.17056438326835632, -0.022342897951602936, 0.01339791715145111, 0.0930420458316803, -0.0421990230679512, 0.04387969151139259, 0.04384000971913338, -0.06449823826551437, -0.30359622836112976, -0.14353618025779724, -0.0268755741417408, -0.012015736661851406, -0.01890047825872898, -0.007513077929615974, 0.0037242723628878593, -0.24863295257091522, -0.0027048978954553604, 0.003161592409014702, 0.1286587119102478, -0.041025854647159576, -0.09732015430927277, 0.19824077188968658, -0.01265792828053236, -0.2556844651699066, -0.0065558673813939095, 0.04421263933181763, 0.2429560273885727, 0.10821934789419174, 0.055946093052625656, 0.006858102045953274, -0.16741271317005157, 0.04334002733230591, -0.19929833710193634, 0.07051803171634674, 0.09824743121862411, 0.09266795963048935, 0.015774155035614967, -0.04121018946170807, -0.17548741400241852, 0.09359603375196457, 0.1405625343322754, -0.1833794116973877, 0.015210438519716263, 0.1202344074845314, -0.0684484988451004, -0.041262418031692505, -0.08431567996740341, 0.2940654456615448, 0.1453961879014969, -0.148736372590065, -0.13028056919574738, 0.16445395350456238, -0.1691066026687622, -0.001805637963116169, 0.1063947007060051, -0.12512603402137756, -0.24670371413230896, -0.3138224482536316, -0.0067008379846811295, 0.44189387559890747, 0.14598168432712555, -0.15580801665782928, 0.015025376342236996, 0.007019922137260437, 0.05825838819146156, 0.1681337207555771, 0.16219380497932434, -0.032944079488515854, 0.04755903407931328, -0.1358994096517563, 0.007907800376415253, 0.2514845132827759, -0.08303360641002655, -0.09683132916688919, 0.2212807536125183, -0.00346460472792387, 0.06142154708504677, 0.009044554084539413, 0.04022371396422386, -0.021033862605690956, -0.023011891171336174, -0.15056441724300385, 0.009836670011281967, -0.019324813038110733, -0.022449512034654617, -0.0701698511838913, 0.09366550296545029, -0.10972811281681061, 0.08488725870847702, 0.00023321551270782948, -0.02883228287100792, -0.04327326640486717, -0.028305940330028534, -0.09826325625181198, -0.06836211681365967, 0.11310944706201553, -0.243171826004982, 0.16941602528095245, 0.17216600477695465, 0.0843699499964714, 0.15222235023975372, 0.15407179296016693, 0.10108757019042969, 0.016813326627016068, -0.07004127651453018, -0.23668362200260162, -0.04008999839425087, 0.09198439121246338, -0.03380216658115387, 0.1645573079586029, 0.013553308323025703], [-0.1381329745054245, 0.06967183947563171, 0.003007246647030115, -0.06736701726913452, -0.0681886374950409, -0.07707016915082932, -0.06892131268978119, -0.2451578676700592, 0.1308385729789734, -0.1688559353351593, 0.2479231208562851, -0.09044495970010757, -0.2343452423810959, -0.09216384589672089, -0.07141485065221786, 0.17252807319164276, -0.10617543011903763, -0.18335102498531342, -0.034888193011283875, -0.018803568556904793, 0.08822039514780045, -0.03288142755627632, 0.06661776453256607, 0.07465019822120667, -0.09962157160043716, -0.2930432856082916, -0.1427672952413559, -0.04761078581213951, -0.015319067984819412, -0.031910162419080734, -0.009999595582485199, -0.008765841834247112, -0.26288145780563354, 0.00761992484331131, 0.00580810010433197, 0.1326361894607544, -0.030697809532284737, -0.05682361125946045, 0.20820879936218262, 0.008685372769832611, -0.23863184452056885, -0.05650969594717026, 0.005418933928012848, 0.22141380608081818, 0.13354018330574036, 0.04938894882798195, 0.015741094946861267, -0.17664006352424622, 0.04779190942645073, -0.18033169209957123, 0.10861168056726456, 0.14381173253059387, 0.04870355501770973, 0.0036929165944457054, -0.00482057873159647, -0.1772153675556183, 0.04734184592962265, 0.13490571081638336, -0.17369681596755981, 0.015743643045425415, 0.11735568195581436, -0.05368347465991974, -0.06531583517789841, -0.08509211242198944, 0.28429776430130005, 0.1642259955406189, -0.14215247333049774, -0.15820632874965668, 0.18715384602546692, -0.18337255716323853, -0.026111841201782227, 0.11301266402006149, -0.1330920308828354, -0.2373991161584854, -0.3200536370277405, -0.008096395060420036, 0.41658321022987366, 0.12614165246486664, -0.17823225259780884, 0.0024028620682656765, -0.04004677012562752, 0.03895586356520653, 0.16288208961486816, 0.13400056958198547, -0.024930980056524277, 0.07808174192905426, -0.12198273092508316, 0.005781261250376701, 0.22800137102603912, -0.047303762286901474, -0.08097205311059952, 0.2438846379518509, -0.02516680583357811, 0.0435921885073185, 0.036212094128131866, 0.03280939906835556, -0.026796430349349976, -0.01842587999999523, -0.13943925499916077, -0.008869081735610962, -0.010905114933848381, -0.016748376190662384, -0.04444573074579239, 0.10491921752691269, -0.11882108449935913, 0.10639943182468414, -0.006080551538616419, -0.02688191644847393, -0.06828941404819489, -0.04889147728681564, -0.11861958354711533, -0.08239869028329849, 0.121736541390419, -0.25230786204338074, 0.19380952417850494, 0.1584799885749817, 0.06890794634819031, 0.14443184435367584, 0.11296091228723526, 0.1175035759806633, -0.0004199715331196785, -0.05944538861513138, -0.21476943790912628, -0.013117847964167595, 0.07819520682096481, -0.04419241100549698, 0.13574829697608948, 0.013473380357027054], [-0.10344729572534561, 0.03028631955385208, 0.015512809157371521, -0.045079827308654785, -0.08989111334085464, -0.047963958233594894, -0.06047263741493225, -0.18562132120132446, 0.12457990646362305, -0.17619240283966064, 0.23685398697853088, -0.0992639809846878, -0.2167149782180786, -0.04802664741873741, -0.07818770408630371, 0.1697208732366562, -0.1069759652018547, -0.12507517635822296, -0.04934477061033249, -0.009132733568549156, 0.10202616453170776, -0.005919343791902065, 0.03181353956460953, 0.05531568452715874, -0.1041502133011818, -0.28373003005981445, -0.14757181704044342, -0.10741011798381805, -0.022445091977715492, -0.06787003576755524, -0.006575595587491989, -0.01016779150813818, -0.21992945671081543, 0.006083318963646889, -0.005955260246992111, 0.06965036690235138, -0.028892692178487778, -0.06861692667007446, 0.1800190657377243, 0.012147285975515842, -0.2299727350473404, -0.02279963716864586, -0.00764751061797142, 0.18368664383888245, 0.08388993889093399, 0.08446773141622543, 0.03069514036178589, -0.16784130036830902, 0.0727330669760704, -0.17113205790519714, 0.07015009224414825, 0.09627300500869751, 0.07844136655330658, 0.012717045843601227, -0.01125745102763176, -0.17165403068065643, 0.05557578057050705, 0.07703091204166412, -0.18546588718891144, 0.07484669983386993, 0.11097505688667297, -0.0889388769865036, -0.03860922157764435, -0.05092763900756836, 0.3045039474964142, 0.14080189168453217, -0.15221013128757477, -0.12716685235500336, 0.1580854207277298, -0.16539055109024048, -0.023022929206490517, 0.09133314341306686, -0.12433965504169464, -0.23906223475933075, -0.2821354866027832, 0.023095209151506424, 0.4728088080883026, 0.11104191094636917, -0.1843850016593933, 0.014100917614996433, -0.058556899428367615, 0.0322420708835125, 0.15774080157279968, 0.1798783540725708, -0.013316609896719456, 0.05472756549715996, -0.08956514298915863, 0.008654065430164337, 0.23391801118850708, -0.10606301575899124, -0.07743922621011734, 0.22481325268745422, -0.05418890714645386, 0.0762823298573494, 0.0087065314874053, 0.0006952496478334069, -0.05344304069876671, -0.009070584550499916, -0.03873717412352562, 0.017626017332077026, 0.018655728548765182, -0.0277688167989254, -0.029494017362594604, 0.06516667455434799, -0.07224630564451218, 0.10563579201698303, -0.03534536063671112, -0.03905570134520531, -0.04238767549395561, -0.011039987206459045, -0.14414159953594208, -0.07650690525770187, 0.1256551593542099, -0.24986249208450317, 0.22893033921718597, 0.13074788451194763, 0.04688897728919983, 0.1572607308626175, 0.1220945492386818, 0.14789989590644836, 0.010130602866411209, -0.01480670366436243, -0.20248328149318695, -0.03520406782627106, 0.12216830253601074, -0.025361286476254463, 0.1501118689775467, -0.02008691616356373]]	2025-08-04
3	Anisa	Nirwana	133343224	nirwanaanisa1508@gmail.com	082214987219	Data Security	Cyber Security	[-0.10745113343000412, 0.06479183584451675, 0.03841818869113922, -0.07419481873512268, -0.09446264058351517, -0.03752533346414566, 0.0005902769044041634, -0.12211665511131287, 0.21591351926326752, -0.17293238639831543, 0.26916223764419556, -0.07804253697395325, -0.21133631467819214, -0.09860064089298248, 0.009385057725012302, 0.19761797785758972, -0.17414486408233643, -0.13627183437347412, -0.06367859244346619, 0.001685909926891327, 0.054232094436883926, -0.05612108111381531, 0.054845668375492096, 0.11643049865961075, -0.09619110822677612, -0.437546968460083, -0.09363581240177155, -0.052024345844984055, -0.06378484517335892, -0.042893484234809875, -0.07512733340263367, 0.1269986778497696, -0.2208126336336136, -0.1137506440281868, -0.05288901925086975, 0.1556069552898407, -0.06213591247797012, -0.06360242515802383, 0.1493958830833435, -0.035987090319395065, -0.25839105248451233, -0.05924650654196739, 0.043905291706323624, 0.23576849699020386, 0.13991595804691315, -0.017593640834093094, 0.028691517189145088, -0.0865224152803421, 0.07595359534025192, -0.2189370095729828, 0.03575323522090912, 0.112706758081913, 0.0446292869746685, 0.053642794489860535, 0.0026290896348655224, -0.11978019773960114, 0.006495899520814419, 0.14221717417240143, -0.13829924166202545, -0.05454059690237045, 0.0592513270676136, -0.10209975391626358, -0.05291147157549858, -0.11121028661727905, 0.24784503877162933, 0.18585355579853058, -0.078170046210289, -0.16279618442058563, 0.15717552602291107, -0.10458815097808838, -0.04208763316273689, 0.04490136355161667, -0.17050541937351227, -0.21318675577640533, -0.3112885057926178, 0.022013558074831963, 0.3361208736896515, 0.06767086684703827, -0.12074443697929382, 0.01670217327773571, -0.0897703692317009, -0.004880569409579039, 0.08870840072631836, 0.1477670669555664, 0.03332361578941345, 0.0742664635181427, -0.10334115475416183, 0.09656691551208496, 0.14913655817508698, -0.0733344778418541, -0.008518592454493046, 0.2307186722755432, -0.0033590374514460564, 0.05413768067955971, 0.041642606258392334, 0.056115809828042984, -0.06448857486248016, 0.11233486235141754, -0.22535854578018188, 0.06161462888121605, 0.05863276869058609, 0.0010617543011903763, -0.029182879254221916, 0.06716076284646988, -0.1392315775156021, 0.0819094106554985, 0.0209417212754488, 0.024644305929541588, 0.055981215089559555, -0.05498424544930458, -0.107485331594944, -0.13754069805145264, 0.11024875193834305, -0.21977248787879944, 0.11776702105998993, 0.17204159498214722, 0.029302291572093964, 0.17161093652248383, 0.07747355103492737, 0.09040781855583191, 0.008818788453936577, -0.08593098819255829, -0.27368438243865967, 0.0782378762960434, 0.15335705876350403, 0.0021260594949126244, -0.010376254096627235, 0.016320500522851944]	2025-05-26
2	Yustina	Yunita	188856789	yustinayunita86@gmail.com	08987654321	Data Scientist	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-05-26
4	Nabilla	Libasutaqwa	567890098	nabila.libasutaqwa@student.president.ac.id	081223456333	UI Designer	Web Programming	\N	2025-05-26
1	Nabilaa	Libasutaqwa	654323450	nabilalb2004@gmail.com	081234567890	Data Security	Cyber Security	[-0.11877931654453278, 0.048978134989738464, 0.04527463763952255, -0.053959839046001434, -0.11791834235191345, -0.04495662823319435, -0.02108035981655121, -0.12154902517795563, 0.14449924230575562, -0.13219228386878967, 0.2115778625011444, -0.059877026826143265, -0.2019445300102234, -0.055844079703092575, -0.031118731945753098, 0.23269718885421753, -0.22157025337219238, -0.15516698360443115, -0.06823483854532242, -0.011522598564624786, 0.0629851371049881, -0.039067551493644714, 0.08161631971597672, 0.037768762558698654, -0.1215372234582901, -0.34673014283180237, -0.07339158654212952, -0.04526490718126297, -0.05223672091960907, -0.0010802150936797261, -0.053868792951107025, 0.06410800665616989, -0.22088253498077393, -0.06292301416397095, 0.05741925910115242, 0.07921651005744934, -0.03555351868271828, -0.08645129948854446, 0.2093575894832611, -0.04646805673837662, -0.2735065817832947, 0.005639377981424332, 0.13623614609241486, 0.2107405811548233, 0.1236954852938652, 0.03615737706422806, 0.00791251566261053, -0.12571097910404205, 0.1281934380531311, -0.16802296042442322, 0.07628294825553894, 0.10171712189912796, 0.10188271850347519, 0.01609496958553791, 0.061359576880931854, -0.12568289041519165, 0.045133449137210846, 0.1394161432981491, -0.09774723649024963, -0.03284337744116783, 0.11771884560585022, -0.04846888780593872, -0.04083703085780144, -0.14710000157356262, 0.21173681318759918, 0.10060358047485352, -0.08506668359041214, -0.17493729293346405, 0.12550681829452515, -0.05969913303852081, -0.059123389422893524, 0.06671737879514694, -0.1499161422252655, -0.21463961899280548, -0.27530986070632935, -0.02323021925985813, 0.30915629863739014, 0.10314305871725082, -0.16695356369018555, 0.01426028087735176, 0.01552140899002552, 0.02114843763411045, 0.12716341018676758, 0.16630852222442627, -0.01382768526673317, 0.08116237819194794, -0.08654364943504333, 0.029460828751325607, 0.19440734386444092, -0.08323968201875687, -0.036607809364795685, 0.21330304443836212, 0.026845799759030342, 0.0015197917819023132, 0.00652182474732399, -0.011105605401098728, -0.06658308207988739, 0.07986483722925186, -0.22473746538162231, 0.011140072718262672, 0.05963897705078125, 0.03300333768129349, -0.028514988720417023, 0.07891437411308289, -0.13830700516700745, 0.01650134287774563, -0.02790762111544609, 0.004079924896359444, -0.016230043023824692, -0.030277667567133904, -0.11010953783988953, -0.0883723720908165, 0.044013429433107376, -0.21927028894424438, 0.13821639120578766, 0.16726413369178772, 0.016312438994646072, 0.11036698520183563, 0.10717912763357162, 0.06306461989879608, 0.0313158854842186, -0.008186950348317623, -0.23215122520923615, -0.008681267499923706, 0.18264751136302948, -0.01756097562611103, 0.09290212392807007, 0.009914634749293327]	2025-06-02
36	do	kyungso	678976543	anisa.nrwn15@gmail.com	08221478627	ASESOR	PGLH	[-0.05157141014933586, -0.015340054407715797, 0.006164755672216415, -0.11238393187522888, -0.06575120240449905, -0.023448413237929344, -0.017609769478440285, -0.054892268031835556, 0.22417640686035156, -0.06365969032049179, 0.2352403998374939, -0.027320636436343193, -0.23420362174510956, -0.06220533326268196, 0.046370089054107666, 0.17844276130199432, -0.15653946995735168, -0.12797267735004425, -0.060874126851558685, -0.019146813079714775, 0.05955960601568222, -0.03419243171811104, 0.11001072078943253, 0.0564366839826107, -0.17424140870571136, -0.40102705359458923, -0.07567134499549866, -0.03891858458518982, -0.01344236545264721, -0.03499472513794899, 0.022613514214754105, 0.1599922925233841, -0.1602093130350113, 0.00827218871563673, 0.04014817997813225, 0.12677568197250366, -0.05732869356870651, -0.12439676374197006, 0.24748657643795013, 0.012434347532689571, -0.2525255084037781, -0.04039997234940529, -0.017686959356069565, 0.23682555556297302, 0.16883766651153564, -0.025572150945663452, 0.07686057686805725, -0.03845022991299629, 0.06008000299334526, -0.363083153963089, 0.0991024300456047, 0.1736191362142563, -0.02352917194366455, 0.02270742505788803, 0.04567449539899826, -0.11050976812839508, -0.008575617335736752, 0.18411166965961456, -0.26067301630973816, 0.006814019754528999, 0.049189984798431396, -0.0633060410618782, -0.051477283239364624, -0.1301189512014389, 0.1771279275417328, 0.23957496881484985, -0.15989235043525696, -0.15618936717510223, 0.15921302139759064, -0.1081649586558342, -0.005890881642699242, 0.07507722824811935, -0.1847783625125885, -0.2846584916114807, -0.2743229568004608, 0.017592867836356163, 0.2981771230697632, 0.12994052469730377, -0.14817914366722107, -0.012162216007709503, -0.07677778601646423, 0.02625279873609543, 0.05691322311758995, 0.060701802372932434, 0.05342762917280197, -0.023186981678009033, -0.1164884939789772, 0.057008884847164154, 0.1856578290462494, -0.09264136850833893, -0.056762926280498505, 0.28377199172973633, 0.014038008637726307, -0.013779843226075172, -0.030126968398690224, 0.14679338037967682, -0.03898399695754051, 0.04466190189123154, -0.19837987422943115, 0.03604117035865784, 0.05122559517621994, 0.016936257481575012, 0.00790006760507822, 0.10518072545528412, -0.1457325518131256, 0.150264710187912, -0.005962526425719261, -0.03432643413543701, 0.012971252202987671, -0.05568387359380722, -0.09165560454130173, -0.1009681448340416, 0.11010021716356277, -0.258140504360199, 0.15423725545406342, 0.20792165398597717, 0.06613659858703613, 0.1658581644296646, 0.010074473917484283, 0.05702738091349602, 0.03710382431745529, -0.09548326581716537, -0.191237211227417, -0.005034856032580137, 0.008794036693871021, 0.08545134216547012, -0.06214195489883423, 0.057168856263160706]	2025-07-28
11	Nabilaaa	Libasutaqwa	543212323	nabilalb0109@gmail.com	081234567890	Full Stack Developer	Web Programming	\N	2025-05-26
56	juminten	lasmi	324567654	juminten@gmail.com	08221478627	CEO	BAN	[[-0.08759555220603943, 0.022590434178709984, 0.06571820378303528, -0.09281174093484879, -0.03564755991101265, -0.05771584063768387, -0.03166089951992035, -0.14490458369255066, 0.24151146411895752, -0.18381032347679138, 0.2467692345380783, -0.0811670646071434, -0.21732041239738464, -0.085734523832798, -0.014966377057135105, 0.17984367907047272, -0.16204138100147247, -0.11922124773263931, -0.013465995900332928, -0.0065407599322497845, 0.036090172827243805, -0.05485694110393524, 0.08222711831331253, 0.054941557347774506, -0.13397818803787231, -0.4331572651863098, -0.12427018582820892, -0.061617475003004074, -0.0535421296954155, 0.02227817103266716, -0.05337291955947876, 0.14471100270748138, -0.22934095561504364, -0.07612653821706772, -0.01780690625309944, 0.12994307279586792, -0.035846270620822906, -0.05373617261648178, 0.19027884304523468, -0.01248089037835598, -0.26385584473609924, -0.08998214453458786, 0.02060837298631668, 0.23174704611301422, 0.09594099968671799, -0.007081049028784037, 0.031581759452819824, -0.07122448831796646, 0.08177031576633453, -0.23908519744873047, 0.045502860099077225, 0.1044047623872757, 0.0409274697303772, 0.021408993750810623, -0.0024489443749189377, -0.12506601214408875, 0.033267199993133545, 0.12702776491641998, -0.1824316382408142, 0.0007112328894436359, 0.060627587139606476, -0.15024030208587646, -0.07445824146270752, -0.0627872422337532, 0.2461184561252594, 0.20883384346961975, -0.10582535713911057, -0.1424962878227234, 0.14389848709106445, -0.11195679754018784, 0.031015150249004364, 0.05996844545006752, -0.16328132152557373, -0.23081880807876587, -0.3284502327442169, -0.009793844074010849, 0.36001497507095337, 0.08592405915260315, -0.11440557986497879, 0.0309055894613266, -0.07719704508781433, 0.021331079304218292, 0.1247987374663353, 0.1791795939207077, 0.006932476535439491, 0.12172582745552063, -0.07172517478466034, 0.07944192737340927, 0.16061590611934662, -0.09114701300859451, -0.05670745670795441, 0.2475910782814026, -0.04603716731071472, 0.09829430282115936, -0.000623609870672226, 0.037425022572278976, -0.053537607192993164, 0.0401969775557518, -0.18753357231616974, 0.04732241481542587, 0.08665609359741211, 0.024751927703619003, -0.0012314841151237488, 0.08714709430932999, -0.16442187130451202, 0.07372001558542252, 0.011947405524551868, -0.0038300217129290104, 0.07857695966959, -0.037305474281311035, -0.0674833357334137, -0.15562503039836884, 0.09719925373792648, -0.23175564408302307, 0.11085808277130127, 0.18087860941886902, 0.01590637117624283, 0.19198954105377197, 0.073233462870121, 0.0516207292675972, 0.018690429627895355, -0.06993570178747177, -0.22475363314151764, 0.049971744418144226, 0.11643779277801514, 0.021381942555308342, 0.036814432591199875, -0.01074901781976223], [-0.06372546404600143, 0.047745320945978165, 0.07252862304449081, -0.11463309079408646, -0.07262512296438217, -0.007173897698521614, -0.08721546083688736, -0.1331203728914261, 0.20247399806976318, -0.15241998434066772, 0.2638545334339142, -0.015036428347229958, -0.224365234375, -0.012053028680384159, -0.04013347625732422, 0.1970859169960022, -0.09308323264122009, -0.17403480410575867, -0.04770604521036148, 0.017924904823303223, 0.020349673926830292, 0.041355207562446594, 0.035175763070583344, 0.02586653269827366, -0.1414649486541748, -0.34714460372924805, -0.11338645219802856, -0.0012746918946504593, -0.010778924450278282, -0.0014292409177869558, -0.04500873386859894, 0.10295183956623077, -0.20114341378211975, -0.001848958432674408, 0.050574108958244324, 0.13449813425540924, -0.0166629571467638, -0.07683179527521133, 0.18932956457138062, 0.039350494742393494, -0.30588439106941223, -0.02228604443371296, 0.07229534536600113, 0.2616799771785736, 0.1978747695684433, 0.014733226969838142, 0.02279193326830864, -0.0887874960899353, 0.03631345555186272, -0.2322143167257309, 0.06932996213436127, 0.09573284536600113, 0.07041382789611816, 0.022609829902648926, -0.008321026340126991, -0.171953022480011, 0.021231206133961678, 0.12220451980829239, -0.1984521746635437, -0.04498513415455818, 0.10470101982355118, -0.09050197154283524, -0.02639218419790268, -0.06871429830789566, 0.2995292842388153, 0.16329962015151978, -0.14786529541015625, -0.15974898636341095, 0.20866192877292633, -0.1418384313583374, -0.015828104689717293, 0.055106256157159805, -0.16615775227546692, -0.1663089245557785, -0.30060288310050964, -0.00967000238597393, 0.41925978660583496, 0.09012899547815323, -0.15103420615196228, 0.09413205087184906, -0.055610187351703644, 0.037092264741659164, 0.08115948736667633, 0.10683106631040573, -0.000452529639005661, 0.047216277569532394, -0.08130057156085968, -0.015780143439769745, 0.2702704668045044, -0.041567932814359665, -0.026763536036014557, 0.22210663557052612, 0.002119002863764763, 0.017577825114130974, 0.058365702629089355, 0.05913204327225685, -0.036255400627851486, -0.007798303849995136, -0.19562917947769165, 0.014580302871763706, -0.08478076010942459, -0.01157891284674406, 0.018112028017640114, 0.15208426117897034, -0.17640002071857452, 0.14969126880168915, 0.03714407980442047, -0.004549146629869938, 0.05635905638337135, 0.06512236595153809, -0.062498390674591064, -0.17672769725322723, 0.10824815928936005, -0.26234400272369385, 0.11843734979629517, 0.13119426369667053, 0.08554188162088394, 0.15139220654964447, 0.10570783168077469, 0.13936005532741547, 0.010363565757870674, 0.0025871386751532555, -0.20631706714630127, -0.02889823727309704, 0.044795840978622437, -0.047659505158662796, 0.09913413226604462, 0.09080922603607178], [-0.08202866464853287, 0.029227137565612793, 0.021246936172246933, -0.10132292658090591, -0.05798112973570824, -0.00665345648303628, -0.02924623340368271, -0.11004994064569473, 0.2539414167404175, -0.14849615097045898, 0.2692340612411499, -0.0065065897069871426, -0.23103925585746765, -0.12332873046398163, 0.03282509744167328, 0.18839304149150848, -0.12893475592136383, -0.14318187534809113, -0.007695695385336876, 0.028275519609451294, 0.038060642778873444, 0.0037451647222042084, 0.07220233231782913, 0.02084469050168991, -0.08683755993843079, -0.4444615840911865, -0.08510934561491013, -0.05009923130273819, 0.0028740623965859413, -0.037777841091156006, -0.06255839765071869, 0.13436290621757507, -0.20080992579460144, -0.053945936262607574, 0.021551048383116722, 0.1442456990480423, -0.07514799386262894, -0.05095748230814934, 0.25180503726005554, 0.06534898281097412, -0.2713291049003601, -0.08203816413879395, -0.004664653912186623, 0.24628901481628418, 0.12451101839542389, 0.00355102913454175, 0.031363099813461304, -0.0859590619802475, 0.06472668796777725, -0.23899103701114655, 0.04198136180639267, 0.13530902564525604, 0.046123988926410675, -0.004293401725590229, 0.056176044046878815, -0.12322193384170532, 0.019017208367586136, 0.08058075606822968, -0.21521742641925812, -0.04454303905367851, 0.04547381401062012, -0.07691393047571182, -0.08323262631893158, -0.06800564378499985, 0.25967368483543396, 0.15733610093593597, -0.09930279850959778, -0.1252812296152115, 0.1687345653772354, -0.10679558664560318, -0.04696536436676979, 0.06431995332241058, -0.1504199206829071, -0.21328654885292053, -0.31305280327796936, -0.020530903711915016, 0.35344624519348145, 0.06665255129337311, -0.16387952864170074, 0.0391886904835701, -0.021585943177342415, -0.03308328613638878, 0.14709585905075073, 0.1328352689743042, -0.017920993268489838, 0.08381336182355881, -0.06597676128149033, 0.011196816340088844, 0.17988742887973785, -0.04759027808904648, -0.04002540558576584, 0.2154698520898819, -0.004808641038835049, 0.0927535891532898, 0.047984570264816284, 0.05385853350162506, 0.009734434075653553, 0.0049095856957137585, -0.2166982889175415, -0.014995725825428963, 0.06716630607843399, -0.033241793513298035, -0.004641571547836065, 0.13592173159122467, -0.20484575629234314, 0.08135957270860672, 0.03549520671367645, -0.03956201300024986, 0.07271330058574677, -0.0065933652222156525, -0.09379640221595764, -0.13734634220600128, 0.08466882258653641, -0.2615499496459961, 0.14058060944080353, 0.19389945268630981, -0.0007576326606795192, 0.1430806815624237, 0.07284422218799591, 0.05514238774776459, -0.009623308666050434, -0.060304272919893265, -0.2236548513174057, -0.020862169563770294, 0.07504132390022278, 0.04209741950035095, 0.02397884428501129, 0.0013486826792359352], [-0.10876494646072388, 0.022345539182424545, 0.048126548528671265, -0.09682461619377136, -0.031299788504838943, -0.031412504613399506, -0.004362436011433601, -0.1422608494758606, 0.2322501242160797, -0.14856410026550293, 0.2802456021308899, -0.1140114963054657, -0.24749651551246643, -0.10814398527145386, -0.015175494365394115, 0.18235132098197937, -0.17343227565288544, -0.10704454034566879, -0.010251273401081562, -0.009453034959733486, 0.010925635695457458, -0.040443144738674164, 0.08203372359275818, 0.06223605200648308, -0.15217754244804382, -0.4480574429035187, -0.11554840952157974, -0.09631000459194183, -0.05221189558506012, 0.003872738452628255, -0.04858355224132538, 0.14166943728923798, -0.22431600093841553, -0.07436862587928772, -0.005777694284915924, 0.1482437252998352, -0.06328348070383072, -0.030633974820375443, 0.20544980466365814, 0.003401646390557289, -0.2571144998073578, -0.0872679129242897, 0.04186605289578438, 0.2444390058517456, 0.08135073632001877, 0.018699035048484802, 0.021361403167247772, -0.0759463757276535, 0.06520769000053406, -0.22628505527973175, 0.03808116167783737, 0.13659019768238068, 0.04295223206281662, -0.00011796224862337112, 0.0015986105427145958, -0.1006413921713829, 0.00536691676825285, 0.12803804874420166, -0.20912690460681915, 0.011759432964026928, 0.07476282864809036, -0.12404696643352509, -0.08643073588609695, -0.06870269775390625, 0.24628442525863647, 0.20668652653694153, -0.12273633480072021, -0.13825300335884094, 0.16142772138118744, -0.1290738582611084, 0.01174582727253437, 0.0789046511054039, -0.15269961953163147, -0.2431831955909729, -0.3224920928478241, -0.01419843826442957, 0.34546658396720886, 0.06587783247232437, -0.09569688886404037, 0.016632437705993652, -0.0736144632101059, -0.01278291642665863, 0.11132894456386566, 0.17824308574199677, 0.002294326201081276, 0.1101381853222847, -0.0670022964477539, 0.06836891174316406, 0.15500487387180328, -0.08226604759693146, -0.02543904446065426, 0.2429882287979126, -0.058324236422777176, 0.08699775487184525, -0.008678436279296875, 0.04000178351998329, -0.07733076810836792, 0.029144126921892166, -0.17772462964057922, 0.01967054046690464, 0.0875689834356308, 0.01309359259903431, 0.012708492577075958, 0.08986765891313553, -0.17115448415279388, 0.0798209086060524, 0.009019795805215836, -0.024232706055045128, 0.08470277488231659, -0.04437115788459778, -0.054497383534908295, -0.14330431818962097, 0.12354019284248352, -0.24370428919792175, 0.11942809820175171, 0.17213134467601776, 0.004973964765667915, 0.15599480271339417, 0.08429849147796631, 0.040639881044626236, 0.0035914937034249306, -0.06512127071619034, -0.2519313097000122, 0.032869357615709305, 0.09705246239900589, -0.010646960698068142, 0.044319476932287216, -0.03308984264731407]]	2025-08-03
58	Cinta	Lala	987651234	dwiadinda438@gmail.com	081234567888	UI UX	cyber	[[-0.11713255196809769, 0.12030104547739029, 0.03935357555747032, -0.07505591213703156, -0.09978197515010834, -0.04412129148840904, -0.007507491856813431, -0.10557194799184799, 0.16527925431728363, -0.15721236169338226, 0.311654657125473, -0.08704396337270737, -0.21806523203849792, -0.05109476298093796, -0.03160785883665085, 0.23460347950458527, -0.1914616823196411, -0.10797012597322464, -0.08283984661102295, -0.0010851426050066948, 0.08731984347105026, -0.018703116104006767, 0.04993632435798645, 0.04135877639055252, -0.0996161550283432, -0.3664341866970062, -0.07167986035346985, -0.05214441567659378, -0.06212836503982544, -0.02882835455238819, -0.0227682925760746, 0.0626172199845314, -0.19844475388526917, -0.08714817464351654, 0.024803534150123596, 0.05417151004076004, -0.05468469485640526, -0.036053821444511414, 0.2087646722793579, -0.04498041421175003, -0.22742924094200134, 0.012385537847876549, 0.0804678201675415, 0.27740001678466797, 0.12971772253513336, 0.0696934387087822, 0.026511600241065025, -0.1608397513628006, 0.09374399483203888, -0.16147173941135406, 0.05093668773770332, 0.08535218238830566, 0.10667569190263748, 0.02984633669257164, 0.04455995559692383, -0.12333296239376068, 0.06357339769601822, 0.1218886449933052, -0.12373097240924835, -0.04324227198958397, 0.11691039800643921, -0.0736139640212059, -0.018570464104413986, -0.1284438669681549, 0.3059738874435425, 0.06909220665693283, -0.11229263246059418, -0.13159231841564178, 0.12262406200170517, -0.03403926640748978, -0.06838053464889526, 0.0444091334939003, -0.1706341803073883, -0.19755756855010986, -0.3161317706108093, -0.018184952437877655, 0.354749858379364, 0.0920315831899643, -0.18492498993873596, 0.02808648906648159, -0.039884764701128006, 0.02525532990694046, 0.15168684720993042, 0.16163048148155212, -0.006241919472813606, 0.007923382334411144, -0.09532338380813599, 0.046262726187705994, 0.18256132304668427, -0.11276055872440338, -0.05986770987510681, 0.20423108339309692, 0.0026875250041484833, 0.01552622951567173, -0.01549911592155695, -0.016130715608596802, -0.09701229631900787, 0.08746473491191864, -0.1566784679889679, 0.014442047104239464, 0.05283211171627045, 0.03110416978597641, -0.024375976994633675, 0.10938870906829834, -0.17362183332443237, 0.07805611193180084, -0.025299062952399254, 0.04636147990822792, 0.017579393461346626, -0.014788029715418816, -0.0852360874414444, -0.08206883072853088, 0.060741208493709564, -0.23652677237987518, 0.15819846093654633, 0.1542270928621292, -0.0014879587106406689, 0.12910839915275574, 0.10735580325126648, 0.07109352946281433, 0.0025814371183514595, 0.01381649635732174, -0.28356924653053284, 0.005316141992807388, 0.171622171998024, 0.001022963784635067, 0.14215263724327087, 0.01567424088716507], [-0.15354560315608978, 0.13372397422790527, 0.03472549840807915, -0.06515470147132874, -0.10059816390275955, -0.009674650616943836, -0.03421948850154877, -0.1540457308292389, 0.1676274836063385, -0.1367333084344864, 0.29068613052368164, -0.09207199513912201, -0.24064010381698608, -0.06604218482971191, -0.029968515038490295, 0.2427491396665573, -0.17388036847114563, -0.14102719724178314, -0.10745888203382492, -0.02686174400150776, 0.05639367178082466, -0.04148372262716293, 0.04212729260325432, 0.04154089465737343, -0.08191249519586563, -0.3436361253261566, -0.0529620423913002, -0.05648268386721611, -0.0644906535744667, -0.05931145325303078, -0.0341418981552124, 0.03534022346138954, -0.2212654948234558, -0.0783950686454773, 0.016537006944417953, 0.06696542352437973, -0.050030939280986786, -0.05158068984746933, 0.21070519089698792, -0.09032925963401794, -0.23130008578300476, 0.018528174608945847, 0.10798227041959763, 0.236477792263031, 0.15540730953216553, 0.06279373914003372, -0.015713220462203026, -0.16636767983436584, 0.09707839787006378, -0.17642994225025177, 0.06826618313789368, 0.1121300607919693, 0.08589331805706024, 0.018019437789916992, 0.054279670119285583, -0.1558939516544342, 0.03333550691604614, 0.12024558335542679, -0.09582464396953583, -0.03952884301543236, 0.11078345775604248, -0.049911439418792725, -0.0546797476708889, -0.14346925914287567, 0.2774263620376587, 0.09941523522138596, -0.10818652808666229, -0.1295258104801178, 0.11680596321821213, -0.0356106236577034, -0.055038440972566605, 0.044419996440410614, -0.18155066668987274, -0.22402158379554749, -0.32987314462661743, -0.0008511506021022797, 0.36629748344421387, 0.09353029727935791, -0.21309585869312286, 0.015306874178349972, -0.007004618179053068, 0.026853324845433235, 0.1396174281835556, 0.13872972130775452, -0.029498226940631866, -0.006591852754354477, -0.08565734326839447, 0.040467169135808945, 0.193703755736351, -0.07598383724689484, -0.05639808252453804, 0.2111039161682129, -0.00045209378004074097, -0.006394520401954651, -0.01611022651195526, 0.007254317402839661, -0.06046313792467117, 0.038086410611867905, -0.2045394629240036, -0.016175445169210434, 0.062295280396938324, 0.033580951392650604, -0.03442596271634102, 0.11665807664394379, -0.17651154100894928, 0.04567968472838402, 0.0002916830126196146, 0.038817740976810455, 0.002285388298332691, -0.013810709118843079, -0.08884961903095245, -0.06782916933298111, 0.09465484321117401, -0.21353203058242798, 0.17095889151096344, 0.16332502663135529, 0.01804233528673649, 0.11473109573125839, 0.12384907156229019, 0.07763615250587463, 0.017720067873597145, 0.024948766455054283, -0.2581937909126282, -0.007149145007133484, 0.17077727615833282, 0.003034709021449089, 0.13290642201900482, 0.038077786564826965], [-0.15019166469573975, 0.0725172683596611, -0.015036904253065586, -0.04796532541513443, -0.1060914397239685, -0.008775238879024982, -0.022829029709100723, -0.11483573168516159, 0.1692388653755188, -0.1016668751835823, 0.2900197207927704, -0.059661414474248886, -0.19841741025447845, -0.11090392619371414, -0.011648249812424183, 0.20129752159118652, -0.16944073140621185, -0.11203281581401825, -0.06680802255868912, 0.021700000390410423, 0.06532227993011475, -0.039699241518974304, 0.054421715438365936, 0.043739065527915955, -0.0675598680973053, -0.38384363055229187, -0.07980678230524063, -0.046483270823955536, -0.019301071763038635, -0.07325556129217148, -0.04813585430383682, 0.035290710628032684, -0.22398293018341064, -0.09681343287229538, 0.000295453704893589, 0.06524213403463364, -0.024122120812535286, -0.045935358852148056, 0.21206888556480408, -0.0354255735874176, -0.24059638381004333, -0.013566628098487854, 0.0683407336473465, 0.25143733620643616, 0.13183149695396423, 0.08220713585615158, -0.012126663699746132, -0.13685689866542816, 0.0994502380490303, -0.13603557646274567, 0.08296133577823639, 0.09390804171562195, 0.0904637947678566, -0.025563444942235947, 0.01553933322429657, -0.10216864943504333, 0.02260880544781685, 0.12185325473546982, -0.11789154261350632, -0.03019803948700428, 0.08740919828414917, -0.03205643594264984, -0.036684103310108185, -0.12714920938014984, 0.26316744089126587, 0.08671725541353226, -0.07843498140573502, -0.1433749496936798, 0.11882907152175903, -0.061011310666799545, -0.062200263142585754, 0.050637610256671906, -0.16478288173675537, -0.2250598967075348, -0.34498101472854614, 0.010925175622105598, 0.39261671900749207, 0.0678202360868454, -0.1966056376695633, -0.002377851866185665, -0.007179649546742439, -0.021903764456510544, 0.1787356734275818, 0.15596240758895874, -0.014465292915701866, 0.006013931706547737, -0.10581932961940765, 0.014438087120652199, 0.22385883331298828, -0.055289775133132935, -0.06146930903196335, 0.19347836077213287, 0.013459035195410252, 0.026817921549081802, 0.002057155128568411, 0.01677427813410759, -0.024406667798757553, 0.0716702863574028, -0.1698887199163437, 0.0018358277156949043, 0.07010462880134583, 0.012120239436626434, -0.026005957275629044, 0.1309191882610321, -0.16309252381324768, 0.04048895463347435, 0.027570508420467377, 0.027797803282737732, 0.0472409725189209, -0.0057133762165904045, -0.10819154232740402, -0.12798170745372772, 0.07327073067426682, -0.21753954887390137, 0.14601565897464752, 0.16511842608451843, 0.040422722697257996, 0.1129913181066513, 0.09259232878684998, 0.09813068062067032, 0.010450685396790504, 0.024357106536626816, -0.258540540933609, 0.014189188368618488, 0.15140679478645325, -0.0012348415330052376, 0.11637121438980103, 0.026140999048948288], [-0.1331532895565033, 0.05995120853185654, 0.04108563810586929, -0.05555601790547371, -0.10526619851589203, -0.06452149897813797, -0.030328571796417236, -0.12340258061885834, 0.1429789811372757, -0.17035618424415588, 0.2865189015865326, -0.09209240972995758, -0.20502910017967224, -0.0805264562368393, -0.028253981843590736, 0.2421872615814209, -0.19792340695858002, -0.11920848488807678, -0.06410212814807892, 0.008501797914505005, 0.07314957678318024, -0.03652598708868027, 0.05729832500219345, 0.04514559358358383, -0.10172634571790695, -0.3669244647026062, -0.08212696015834808, -0.06544952839612961, -0.06847669184207916, -0.02408970519900322, -0.053484681993722916, 0.06211603805422783, -0.18235206604003906, -0.08298511058092117, 0.024252045899629593, 0.04740842431783676, -0.048029981553554535, -0.04179312288761139, 0.19437021017074585, -0.05216749757528305, -0.24530205130577087, -0.015228897333145142, 0.10674162954092026, 0.243882954120636, 0.1233249306678772, 0.09615787118673325, 0.023764874786138535, -0.1748618185520172, 0.09030241519212723, -0.1733386069536209, 0.03957894444465637, 0.08314705640077591, 0.09113748371601105, 0.0057469867169857025, 0.04439588263630867, -0.1291561722755432, 0.045034170150756836, 0.09798876941204071, -0.11979537457227707, -0.01929677277803421, 0.11441665142774582, -0.06249909847974777, -0.031924355775117874, -0.14861920475959778, 0.3071248531341553, 0.0843493863940239, -0.12761718034744263, -0.10705765336751938, 0.13310497999191284, -0.052623823285102844, -0.07025181502103806, 0.029519759118556976, -0.15354737639427185, -0.22613899409770966, -0.3186223804950714, -0.050801247358322144, 0.34621867537498474, 0.09362106770277023, -0.16695663332939148, 0.02251756750047207, -0.036467086523771286, 0.010950490832328796, 0.1402456909418106, 0.1793351173400879, -0.006150580942630768, 0.01714256778359413, -0.07843172550201416, 0.030190400779247284, 0.18026961386203766, -0.11347458511590958, -0.01765979640185833, 0.19232261180877686, -0.00040891673415899277, 0.02379591390490532, -0.02499714121222496, -0.002018314553424716, -0.09942418336868286, 0.08684975653886795, -0.16180643439292908, 0.01933155208826065, 0.05011524260044098, 0.026567941531538963, 0.0055507514625787735, 0.09323339909315109, -0.1484307199716568, 0.06037241965532303, -0.015068810433149338, 0.023520227521657944, 0.02735224738717079, -0.015954965725541115, -0.09372083842754364, -0.09567737579345703, 0.04858226701617241, -0.21719537675380707, 0.14844365417957306, 0.16364562511444092, 0.028540320694446564, 0.13876619935035706, 0.1117168739438057, 0.09033557772636414, -0.010004036128520966, 0.006666369736194611, -0.2744229733943939, 0.01296286378055811, 0.16179421544075012, -0.019368434324860573, 0.13071224093437195, 0.019011516124010086]]	2025-07-28
17	Angeline	Moore	123546565	angelinemoore.notsafe@gmail.com	0891827392387	Back End Developer	Web Programming	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-05-26
22	Udin	Petot	789557846	annisanirwana94@yahoo.com	082214987219	CS	CSS	[-0.12919948995113373, 0.06666329503059387, 0.03344258666038513, -0.08404503762722015, -0.09008660167455673, -0.08720318973064423, -0.08245470374822617, -0.10234399884939194, 0.19635172188282013, -0.13135431706905365, 0.2677384316921234, -0.03503573685884476, -0.22508522868156433, -0.112706758081913, 0.03417070209980011, 0.19653455913066864, -0.2162640392780304, -0.1515597701072693, -0.023327000439167023, -0.004968846682459116, 0.0376853384077549, -0.06514094024896622, 0.08146794140338898, 0.07976383715867996, -0.10406520962715149, -0.45721232891082764, -0.10016806423664093, -0.05235406011343002, -0.04149402678012848, 0.0054552191868424416, -0.05616782233119011, 0.07495284825563431, -0.2324349284172058, -0.07747253775596619, 0.020301751792430878, 0.16606225073337555, -0.049775440245866776, -0.08939759433269501, 0.17369958758354187, -0.07171580195426941, -0.29493245482444763, -0.05096827819943428, 0.05974216386675835, 0.1934920996427536, 0.14177370071411133, 0.010161984711885452, 0.01671195775270462, -0.09920952469110489, 0.06554976105690002, -0.25490570068359375, 0.036633457988500595, 0.16162243485450745, 0.025041649118065834, 0.01508278213441372, 0.005302885547280312, -0.10272610187530518, 0.03740565478801727, 0.1506415456533432, -0.18771055340766907, -0.10580013692378998, 0.06068480387330055, -0.10924514383077621, -0.06539610028266907, -0.12561345100402832, 0.27128615975379944, 0.20287086069583893, -0.13297437131404877, -0.1762954741716385, 0.11034033447504044, -0.15277713537216187, -0.027844959869980812, 0.10175003111362457, -0.12501384317874908, -0.24999354779720306, -0.3338157832622528, 0.001971479505300522, 0.31238502264022827, 0.10100376605987549, -0.12357345223426819, 0.03959168493747711, -0.0815640240907669, -0.009729903191328049, 0.08266538381576538, 0.15124954283237457, 0.011230261996388435, 0.08069176226854324, -0.127456396818161, 0.044604912400245667, 0.19823633134365082, -0.07718481868505478, 0.011964729987084866, 0.24694783985614777, 0.012285180389881134, 0.10370013117790222, 0.01042763702571392, 0.07744865864515305, -0.047568030655384064, 0.02586311846971512, -0.20861658453941345, 0.04415066912770271, 0.05919310450553894, 0.039091210812330246, -0.04661335423588753, 0.07595592737197876, -0.1582529991865158, 0.036706939339637756, 0.008120217360556126, -0.026307284832000732, 0.045081302523612976, -0.0751051977276802, -0.04946199804544449, -0.17545470595359802, 0.07931462675333023, -0.2665981352329254, 0.1397392749786377, 0.20680955052375793, 0.05093002691864967, 0.18016910552978516, 0.08233986049890518, 0.03672053664922714, -0.021599942818284035, -0.13274571299552917, -0.24900546669960022, 0.04211864247918129, 0.10715876519680023, -0.018366381525993347, 0.012663201428949833, -0.01600147783756256]	2025-05-26
12	Yustina	Yunitaa	654327654	yustinayunitayy@gmail.com	08987654234	Data Analyst	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]	2025-06-02
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
1911	21	yustinayunitayy@gmail.com	127.0.0.1	2025-07-30 12:47:21.270348	t	Opera 120.0.0	0	\N
1912	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 13:43:59.326073	f	Opera 120.0.0	0	\N
1913	6	yustinayunita86@gmail.com	127.0.0.1	2025-07-30 13:44:17.915348	t	Opera 120.0.0	0	\N
1867	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:19:44.90841	t	Edge 138.0.0	5	2025-07-28 07:54:26.131251
1878	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:54:30.115007	f	Edge 138.0.0	0	\N
1879	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-07-28 07:54:56.44089	t	Edge 138.0.0	0	\N
1914	\N	angelinmoore.notsafe@gmail.com	127.0.0.1	2025-07-30 14:40:38.708368	f	Opera 120.0.0	2	\N
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
1979	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:15:23.7828	f	Edge 138.0.0	0	\N
1980	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:15:39.12445	t	Edge 138.0.0	0	\N
1981	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:23:43.234142	f	Edge 138.0.0	0	\N
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
1982	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:24:43.115938	t	Edge 138.0.0	0	\N
1983	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 04:31:28.834778	f	Opera 120.0.0	0	\N
1984	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 04:31:47.173513	t	Opera 120.0.0	0	\N
1940	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 08:10:43.906616	f	Chrome 138.0.0	5	2025-08-01 08:36:25.437222
1941	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-01 08:35:45.37137	f	Opera 120.0.0	0	\N
1942	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-01 08:36:01.453829	t	Opera 120.0.0	0	\N
1943	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 08:37:04.483043	f	Safari 18.0.1	0	\N
1944	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 08:37:28.76763	t	Safari 18.0.1	0	\N
1945	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 09:12:07.354853	f	Safari 18.0.1	0	\N
1946	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-01 09:12:31.802047	t	Safari 18.0.1	0	\N
1947	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-01 12:31:08.118785	f	Opera 120.0.0	0	\N
1948	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-01 12:33:33.1329	t	Opera 120.0.0	0	\N
1949	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 12:52:00.497373	f	Opera 120.0.0	0	\N
1950	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 12:52:23.895556	t	Opera 120.0.0	0	\N
1951	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 13:33:05.760774	f	Opera 120.0.0	0	\N
1952	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 13:33:51.043683	t	Opera 120.0.0	0	\N
1953	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 14:08:11.761215	f	Opera 120.0.0	0	\N
1954	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 14:08:53.485242	t	Opera 120.0.0	0	\N
1955	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 14:42:00.155907	f	Opera 120.0.0	0	\N
1956	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 14:42:21.297737	t	Opera 120.0.0	0	\N
1957	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 15:12:32.833129	f	Opera 120.0.0	0	\N
1958	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 15:12:49.419863	t	Opera 120.0.0	0	\N
1959	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-01 15:23:01.342857	f	Opera 120.0.0	0	\N
1960	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-01 15:23:19.679018	t	Opera 120.0.0	0	\N
1961	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 15:43:49.569434	f	Opera 120.0.0	0	\N
1962	27	angelinemoore.notsafe@gmail.com	127.0.0.1	2025-08-01 15:44:05.502502	t	Opera 120.0.0	0	\N
1963	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-01 16:33:45.87035	f	Opera 120.0.0	0	\N
1964	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 17:58:49.888002	f	Edge 138.0.0	0	\N
1965	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 17:58:56.715833	f	Edge 138.0.0	0	\N
1966	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 17:59:17.718787	t	Edge 138.0.0	0	\N
1967	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:09:35.792806	f	Edge 138.0.0	0	\N
1968	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:11:06.949996	f	Edge 138.0.0	0	\N
1969	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:12:36.914111	f	Edge 138.0.0	0	\N
1970	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:14:07.928316	f	Edge 138.0.0	0	\N
1971	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:22:09.894989	f	Edge 138.0.0	0	\N
1972	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-01 18:22:44.606488	t	Edge 138.0.0	0	\N
1973	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-01 18:24:51.932478	f	Edge 138.0.0	0	\N
1974	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-01 18:25:49.990981	t	Edge 138.0.0	0	\N
1975	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 19:41:16.358559	f	Edge 138.0.0	0	\N
1976	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 19:41:40.881492	t	Edge 138.0.0	0	\N
1977	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:11:58.684361	f	Edge 138.0.0	0	\N
1978	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-01 20:12:15.302948	t	Edge 138.0.0	0	\N
1985	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 05:02:57.023607	f	Opera 120.0.0	0	\N
1986	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 05:03:14.483957	t	Opera 120.0.0	0	\N
1987	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 05:35:52.365211	f	Edge 138.0.0	0	\N
1988	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 05:36:20.997643	t	Edge 138.0.0	0	\N
1989	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 05:36:32.579756	f	Opera 120.0.0	0	\N
1990	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 05:36:51.88226	t	Opera 120.0.0	0	\N
1991	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 06:07:41.155852	f	Edge 138.0.0	0	\N
1992	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 06:08:08.429459	t	Edge 138.0.0	0	\N
1993	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 06:30:27.461015	f	Edge 138.0.0	0	\N
1994	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 06:30:57.246579	t	Edge 138.0.0	0	\N
1995	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 07:02:26.316073	f	Edge 138.0.0	0	\N
1996	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 07:02:50.882112	t	Edge 138.0.0	0	\N
1997	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:04:28.229594	f	Edge 138.0.0	0	\N
1998	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:04:31.22256	f	Edge 138.0.0	0	\N
1999	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:04:58.505944	t	Edge 138.0.0	0	\N
2000	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:32:12.538892	f	Edge 138.0.0	0	\N
2001	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:32:51.670061	t	Edge 138.0.0	0	\N
2002	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 08:42:00.619511	f	Opera 120.0.0	0	\N
2003	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 08:42:18.99949	t	Opera 120.0.0	0	\N
2004	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:43:41.77631	f	Edge 138.0.0	0	\N
2005	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 08:44:04.409078	t	Edge 138.0.0	0	\N
2006	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 09:18:56.054827	f	Edge 138.0.0	0	\N
2007	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 09:19:24.260931	t	Edge 138.0.0	0	\N
2008	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 09:31:32.339157	f	Opera 120.0.0	0	\N
2009	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 09:31:50.790472	t	Opera 120.0.0	0	\N
2012	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-02 09:48:14.650827	f	Opera 120.0.0	0	\N
2015	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:12:33.212018	f	Edge 138.0.0	0	\N
2016	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:12:58.057201	t	Edge 138.0.0	0	\N
2017	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 10:26:04.287455	f	Chrome Mobile 135.0.0	0	\N
2018	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 10:26:26.108147	t	Chrome Mobile 135.0.0	0	\N
2022	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 10:31:45.652949	f	Opera 120.0.0	0	\N
2023	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 10:32:00.181317	t	Opera 120.0.0	0	\N
2024	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 10:36:09.43731	f	Edge 138.0.0	0	\N
2025	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 10:36:28.690939	t	Edge 138.0.0	0	\N
2026	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:37:46.024078	f	Edge 138.0.0	0	\N
2027	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:38:11.057078	t	Edge 138.0.0	0	\N
2030	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:57:37.360186	f	Edge 138.0.0	0	\N
2031	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 10:58:02.058993	t	Edge 138.0.0	0	\N
2032	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 11:10:07.04273	f	Edge 138.0.0	0	\N
2033	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 11:10:30.522792	t	Edge 138.0.0	0	\N
2036	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 12:46:42.533907	f	Opera 120.0.0	0	\N
2037	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 12:46:54.237121	f	Opera 120.0.0	0	\N
2038	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 12:47:03.289448	f	Opera 120.0.0	0	\N
2039	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 12:47:20.113779	t	Opera 120.0.0	0	\N
2040	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:04:25.811236	f	Edge 138.0.0	0	\N
2041	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:05:07.29359	t	Edge 138.0.0	0	\N
2042	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-02 13:06:11.668253	f	Edge 138.0.0	0	\N
2043	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-02 13:06:39.118796	t	Edge 138.0.0	0	\N
2044	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:09:41.386238	f	Edge 138.0.0	0	\N
2045	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:09:59.266267	t	Edge 138.0.0	0	\N
2046	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:16:25.221324	f	Opera 120.0.0	0	\N
2047	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:16:41.577491	t	Opera 120.0.0	0	\N
2051	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:28:47.993299	f	Opera 120.0.0	0	\N
2052	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:29:07.628269	t	Opera 120.0.0	0	\N
2069	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 14:52:05.126171	f	Chrome Mobile 135.0.0	0	\N
2054	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:31:01.816289	f	Opera 120.0.0	0	\N
2055	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:31:20.602386	t	Opera 120.0.0	0	\N
2058	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:40:26.620352	f	Chrome Mobile 135.0.0	0	\N
2059	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:40:46.228491	t	Chrome Mobile 135.0.0	0	\N
2060	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:51:38.249846	f	Edge 138.0.0	0	\N
2061	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 13:52:05.275526	t	Edge 138.0.0	0	\N
2062	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:59:26.941162	f	Opera 120.0.0	0	\N
2063	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 13:59:44.321603	t	Opera 120.0.0	0	\N
2066	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 14:39:45.088965	f	Edge 138.0.0	0	\N
2067	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 14:39:59.888773	t	Edge 138.0.0	0	\N
2068	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 14:51:56.83044	f	Chrome Mobile 135.0.0	0	\N
2070	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 14:52:13.752417	f	Chrome Mobile 135.0.0	0	\N
2071	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 14:52:33.486005	t	Chrome Mobile 135.0.0	0	\N
2074	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:11:32.43266	f	Edge 138.0.0	0	\N
2075	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:12:09.824608	t	Edge 138.0.0	0	\N
2076	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:12:36.11799	f	Edge 138.0.0	0	\N
2077	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:12:59.485858	t	Edge 138.0.0	0	\N
2078	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:13:58.971196	f	Edge 138.0.0	0	\N
2079	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:14:22.280292	t	Edge 138.0.0	0	\N
2080	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 15:25:46.164113	f	Edge 138.0.0	0	\N
2081	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 15:26:26.369208	t	Edge 138.0.0	0	\N
2082	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 15:46:12.542883	f	Opera 120.0.0	0	\N
2083	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 15:46:39.914676	t	Opera 120.0.0	0	\N
2084	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:54:32.075744	f	Edge 138.0.0	0	\N
2085	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 15:55:05.005792	t	Edge 138.0.0	0	\N
2086	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 16:17:25.948827	f	Chrome Mobile 135.0.0	0	\N
2087	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 16:17:54.084194	t	Chrome Mobile 135.0.0	0	\N
2090	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 16:23:34.249218	f	Edge 138.0.0	0	\N
2091	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 16:24:12.121646	t	Edge 138.0.0	0	\N
2092	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 16:37:57.979853	f	Edge 138.0.0	0	\N
2093	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 16:38:16.800393	t	Edge 138.0.0	0	\N
2094	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 16:52:02.36111	f	Chrome Mobile 135.0.0	0	\N
2095	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 16:52:32.427132	t	Chrome Mobile 135.0.0	0	\N
2096	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 17:01:06.572819	f	Edge 138.0.0	0	\N
2097	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-02 17:01:25.768075	t	Edge 138.0.0	0	\N
2098	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 18:42:14.427181	f	Edge 138.0.0	0	\N
2099	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 18:43:12.678627	t	Edge 138.0.0	0	\N
2100	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 18:58:37.607779	f	Edge 138.0.0	0	\N
2101	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 18:58:53.283532	t	Edge 138.0.0	0	\N
2102	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 18:59:18.597278	f	Edge 138.0.0	0	\N
2103	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:00:14.482684	f	Edge 138.0.0	0	\N
2104	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:01:19.539446	f	Edge 138.0.0	0	\N
2105	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:02:33.445093	f	Edge 138.0.0	0	\N
2106	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:04:08.992503	f	Edge 138.0.0	0	\N
2107	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:04:24.424822	t	Edge 138.0.0	0	\N
2108	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 19:05:43.887664	f	Edge 138.0.0	0	\N
2109	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 19:25:04.590955	f	Edge 138.0.0	0	\N
2110	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 19:25:32.423417	t	Edge 138.0.0	0	\N
2111	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 19:54:10.29748	f	Edge 138.0.0	0	\N
2112	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 19:54:27.824132	t	Edge 138.0.0	0	\N
2113	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 20:07:14.318878	f	Edge 138.0.0	0	\N
2114	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:09:02.340749	f	Edge 138.0.0	0	\N
2115	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:09:18.128163	t	Edge 138.0.0	0	\N
2116	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-02 20:17:00.604797	f	Edge 138.0.0	0	\N
2117	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:40:01.59182	f	Edge 138.0.0	0	\N
2118	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:40:25.878272	t	Edge 138.0.0	0	\N
2119	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:48:56.227944	f	Edge 138.0.0	0	\N
2120	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-02 20:49:12.915309	t	Edge 138.0.0	0	\N
2121	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-02 21:03:41.337119	f	Edge 138.0.0	0	\N
2122	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-02 21:04:10.718808	t	Edge 138.0.0	0	\N
2123	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 04:42:09.212236	f	Edge 138.0.0	0	\N
2124	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 04:42:57.980578	t	Edge 138.0.0	0	\N
2125	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 05:03:46.772126	f	Opera 120.0.0	0	\N
2126	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 05:04:23.484073	f	Opera 120.0.0	0	\N
2127	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 05:04:40.548524	t	Opera 120.0.0	0	\N
2137	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 05:14:00.818158	t	Edge 138.0.0	0	\N
2129	\N	anisa	127.0.0.1	2025-08-03 05:07:14.50006	f	Edge 138.0.0	1	\N
2128	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 05:06:28.441035	f	Edge 138.0.0	3	\N
2132	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 05:08:07.066855	f	Edge 138.0.0	0	\N
2133	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 05:08:34.8365	t	Edge 138.0.0	0	\N
2134	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 05:09:30.965835	f	Edge 138.0.0	0	\N
2135	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 05:12:40.830751	t	Edge 138.0.0	0	\N
2136	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 05:13:43.172155	f	Edge 138.0.0	0	\N
2138	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 05:32:48.007127	f	Opera 120.0.0	0	\N
2139	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 05:33:04.630704	t	Opera 120.0.0	0	\N
2142	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 06:58:56.121713	f	Edge 138.0.0	0	\N
2143	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 06:59:12.203612	t	Edge 138.0.0	0	\N
2144	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 07:37:02.00226	f	Edge 138.0.0	0	\N
2145	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 07:37:19.41119	t	Edge 138.0.0	0	\N
2146	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:27:41.586403	f	Edge 138.0.0	0	\N
2147	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:28:05.586472	t	Edge 138.0.0	0	\N
2148	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:28:28.480534	f	Edge 138.0.0	0	\N
2149	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:28:44.114915	t	Edge 138.0.0	0	\N
2150	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:29:16.790093	f	Edge 138.0.0	0	\N
2151	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:29:31.223134	t	Edge 138.0.0	0	\N
2152	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:30:00.952317	f	Edge 138.0.0	0	\N
2153	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:30:19.365538	t	Edge 138.0.0	0	\N
2154	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:31:03.011969	f	Edge 138.0.0	0	\N
2155	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:31:19.542498	t	Edge 138.0.0	0	\N
2156	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:33:18.59604	f	Edge 138.0.0	0	\N
2157	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:33:45.197328	t	Edge 138.0.0	0	\N
2158	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 08:36:33.468012	f	Opera 120.0.0	0	\N
2159	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 08:36:51.086348	t	Opera 120.0.0	0	\N
2160	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 08:37:13.273441	f	Edge 138.0.0	0	\N
2161	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 08:37:44.64073	t	Edge 138.0.0	0	\N
2162	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-03 08:43:16.258415	f	Edge 138.0.0	0	\N
2163	1	nabilalb2004@gmail.com	127.0.0.1	2025-08-03 08:43:43.21806	t	Edge 138.0.0	0	\N
2203	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:10:59.256841	f	Edge 138.0.0	0	\N
2204	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:11:14.001714	t	Edge 138.0.0	0	\N
2205	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 11:21:12.668035	f	Opera 120.0.0	0	\N
2165	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 08:54:13.14987	f	Edge 138.0.0	1	\N
2166	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 08:54:22.774965	f	Edge 138.0.0	0	\N
2167	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 08:57:20.462739	f	Edge 138.0.0	0	\N
2168	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 09:02:24.17601	f	Edge 138.0.0	1	\N
2164	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 08:51:29.368802	f	Edge 138.0.0	4	\N
2169	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:03:17.224844	f	Edge 138.0.0	0	\N
2170	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 09:09:39.028038	f	Opera 120.0.0	0	\N
2171	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 09:09:59.181533	t	Opera 120.0.0	0	\N
2172	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 09:10:03.557684	f	Edge 138.0.0	0	\N
2174	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 09:12:03.465608	t	Edge 138.0.0	0	\N
2173	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:11:41.80147	f	Edge 138.0.0	1	\N
2175	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:13:42.698748	f	Edge 138.0.0	0	\N
2176	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:16:39.816373	f	Edge 138.0.0	0	\N
2177	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:17:45.755125	f	Opera 120.0.0	0	\N
2178	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:20:38.738271	t	Chrome Mobile 135.0.0	0	\N
2179	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:25:03.570138	f	Edge 138.0.0	0	\N
2180	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:26:07.222211	f	Chrome 138.0.0	0	\N
2181	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:30:37.135168	f	Edge 138.0.0	0	\N
2182	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:32:47.269472	f	Edge 138.0.0	0	\N
2183	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:33:10.625938	t	Edge 138.0.0	0	\N
2184	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 09:38:02.404242	f	Opera 120.0.0	0	\N
2185	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 09:38:19.301851	t	Opera 120.0.0	0	\N
2186	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:45:27.929059	f	Edge 138.0.0	0	\N
2187	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:45:53.770659	t	Edge 138.0.0	0	\N
2188	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 09:49:35.311743	f	Edge 138.0.0	0	\N
2189	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 09:49:50.091464	t	Edge 138.0.0	0	\N
2190	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:53:52.663763	f	Edge 138.0.0	0	\N
2191	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 09:54:07.93922	t	Edge 138.0.0	0	\N
2192	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-03 09:56:19.372927	f	Edge 138.0.0	0	\N
2193	17	nabilalb0109@gmail.com	127.0.0.1	2025-08-03 09:56:54.440458	t	Edge 138.0.0	0	\N
2194	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 10:16:34.937682	f	Edge 138.0.0	0	\N
2195	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 10:16:49.719756	t	Edge 138.0.0	0	\N
2196	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 10:26:47.570621	f	Opera 120.0.0	0	\N
2197	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 10:27:06.272667	t	Opera 120.0.0	0	\N
2198	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 10:53:12.45103	f	Edge 138.0.0	0	\N
2199	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 10:53:27.189661	t	Edge 138.0.0	0	\N
2200	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:01:53.026167	f	Edge 138.0.0	0	\N
2201	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:02:12.666122	t	Edge 138.0.0	0	\N
2202	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:09:01.47042	f	Edge 138.0.0	0	\N
2206	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 11:21:57.199375	t	Opera 120.0.0	0	\N
2207	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:56:01.300624	f	Edge 138.0.0	0	\N
2208	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:56:41.786167	f	Edge 138.0.0	0	\N
2209	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:57:45.775054	f	Edge 138.0.0	0	\N
2210	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 11:58:06.013431	t	Edge 138.0.0	0	\N
2211	\N	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 12:05:44.154526	f	Edge 138.0.0	1	\N
2212	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 12:06:36.51709	f	Edge 138.0.0	0	\N
2213	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 12:06:50.246671	t	Edge 138.0.0	1	\N
2214	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 12:17:22.779254	f	Opera 120.0.0	0	\N
2215	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 12:18:47.065855	t	Opera 120.0.0	0	\N
2216	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 12:31:15.563482	f	Edge 138.0.0	0	\N
2217	4	nabila.libasutaqwa@student.president.ac.id	127.0.0.1	2025-08-03 12:31:32.071679	t	Edge 138.0.0	0	\N
2218	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 13:01:34.353547	f	Chrome Mobile 135.0.0	0	\N
2219	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 13:01:42.418059	f	Chrome Mobile 135.0.0	0	\N
2220	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 13:02:05.152179	t	Chrome Mobile 135.0.0	0	\N
2221	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 13:02:54.458556	f	Edge 138.0.0	0	\N
2222	71	gwenrosevyn@gmail.com	127.0.0.1	2025-08-03 13:04:04.08525	f	Opera 120.0.0	0	\N
2223	71	gwenrosevyn@gmail.com	127.0.0.1	2025-08-03 13:04:20.283088	t	Opera 120.0.0	0	\N
2224	70	anisa.n@student.president.ac.id	127.0.0.1	2025-08-03 13:04:36.915964	t	Edge 138.0.0	0	\N
2225	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 13:21:20.289065	f	Chrome Mobile 135.0.0	0	\N
2226	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-03 13:21:40.573719	t	Chrome Mobile 135.0.0	0	\N
2227	72	dwiadinda438@gmail.com	127.0.0.1	2025-08-03 13:23:57.021748	f	Opera 120.0.0	1	\N
2228	72	dwiadinda438@gmail.com	127.0.0.1	2025-08-03 13:24:01.747209	f	Opera 120.0.0	0	\N
2229	72	dwiadinda438@gmail.com	127.0.0.1	2025-08-03 13:24:40.93802	t	Opera 120.0.0	0	\N
2247	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 20:06:30.30935	f	Microsoft Edge	0	\N
2248	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 20:06:53.675105	t	Edge 138.0.0	0	\N
2249	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 20:17:19.753192	f	Chrome	0	\N
2230	\N	juminten@gmail.com	127.0.0.1	2025-08-03 14:29:42.786012	f	Edge 138.0.0	5	2025-08-03 14:34:50.407069
2250	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 20:17:35.035902	t	Chrome 138.0.0	0	\N
2258	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-04 11:43:20.905952	t	Opera 120.0.0	0	\N
2259	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-04 11:58:01.030431	f	Opera	0	\N
2251	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 10:43:14.210921	f	Opera	0	\N
2252	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 10:45:40.408572	f	Opera	0	\N
2253	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 10:45:48.233981	t	Opera 120.0.0	0	\N
2254	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 11:17:29.437345	f	Opera	0	\N
2255	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 11:17:46.404301	t	Opera 120.0.0	0	\N
2236	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 16:10:02.088154	f	Edge 138.0.0	0	\N
2237	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 18:59:02.655588	f	Edge 138.0.0	0	\N
2238	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 19:12:54.290279	f	Edge 138.0.0	0	\N
2240	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 19:14:06.254233	f	Edge 138.0.0	0	\N
2241	3	nirwanaanisa1508@gmail.com	127.0.0.1	2025-08-03 19:14:24.907061	t	Edge 138.0.0	0	\N
2239	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:13:27.786652	f	Edge 138.0.0	0	\N
2242	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:15:23.035207	f	Edge 138.0.0	0	\N
2260	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-04 11:58:20.157969	t	Opera 120.0.0	0	\N
2261	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 12:00:31.78654	f	Opera	0	\N
2262	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 12:01:11.691853	f	Opera	0	\N
2244	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:22:13.231029	f	Edge 138.0.0	6	2025-08-03 19:50:43.340231
2263	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 12:01:45.026602	t	Opera 120.0.0	0	\N
2256	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-04 11:40:53.20206	f	Opera	0	\N
2257	21	yustinayunitayy@gmail.com	127.0.0.1	2025-08-04 11:43:11.846909	f	Opera	0	\N
2264	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 12:25:21.546654	f	Opera	0	\N
2265	6	yustinayunita86@gmail.com	127.0.0.1	2025-08-04 12:25:38.14225	t	Opera 120.0.0	0	\N
2243	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:15:42.537977	t	Edge 138.0.0	1	\N
2245	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:52:15.766536	f	Edge 138.0.0	0	\N
2246	49	anisa.nrwn15@gmail.com	127.0.0.1	2025-08-03 19:57:06.044699	f	Edge 138.0.0	0	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.notifications (notification_id, user_id, title, message, notification_type, is_read, created_at, read_at) FROM stdin;
373	49	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-08-03 04:04:10.525101	\N
312	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:37:46.901852	2025-07-24 09:38:05.559391
324	17	New Permission Request	There is a new permission request from Tania Yusnita.	permission	f	2025-07-24 16:59:43.07486	\N
375	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	f	2025-08-03 16:20:37.596628	\N
377	70	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	f	2025-08-03 19:18:47.432261	\N
380	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 21:35:55.	failed_login	f	2025-08-03 21:30:56.194831	\N
390	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 22:34:39.	failed_login	f	2025-08-03 22:33:40.052	\N
393	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 02:18:12.	failed_login	f	2025-08-04 02:17:13.341308	\N
11	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 135.0.0	new_device	f	2025-05-14 17:43:05.797696	\N
12	1	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 135.0.0	new_device	f	2025-05-14 18:01:19.93972	\N
374	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-08-03 12:04:40.660213	2025-08-04 10:45:57.5787
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
376	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-08-03 16:33:09.812309	\N
379	70	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-08-03 20:04:40.52646	\N
57	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:11:53.940808	\N
381	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 21:38:48.	failed_login	f	2025-08-03 21:36:48.662424	\N
391	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 23:11:08.	failed_login	f	2025-08-03 23:10:08.858618	\N
314	27	New Permission Request	There is a new permission request from Angeline Moore.	permission	t	2025-07-24 16:38:48.947443	2025-07-24 09:49:20.617529
394	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 02:20:16.	failed_login	f	2025-08-04 02:19:16.826403	\N
378	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-08-03 20:02:05.087247	2025-08-04 10:45:56.079901
404	21	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:52:26.	failed_login	f	2025-08-04 18:51:27.216017	\N
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
382	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 21:49:30.	failed_login	f	2025-08-03 21:47:31.458738	\N
392	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 23:18:14.	failed_login	f	2025-08-03 23:17:15.013871	\N
395	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 02:30:02.	failed_login	f	2025-08-04 02:29:02.92433	\N
396	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 02:31:23.	failed_login	f	2025-08-04 02:30:24.434325	\N
372	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	t	2025-08-03 00:01:24.762973	2025-08-04 10:45:58.724576
75	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:10:02.964473	2025-05-23 11:16:37.527812
316	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	t	2025-07-24 16:43:42.153764	2025-07-26 14:27:24.915103
119	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:17:27.776622	\N
371	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-08-02 23:17:53.281636	2025-08-04 10:46:00.12455
368	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-08-02 21:52:33.207963	2025-08-04 10:46:05.287841
332	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-27 16:44:52.362248	\N
123	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:19:13.306465	\N
335	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:25:08.308746	\N
130	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 11:32:17.491531	\N
336	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-28 01:25:12.427531	2025-07-28 07:23:48.302609
346	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 14:54:26.	failed_login	f	2025-07-28 14:49:26.81259	\N
134	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
349	27	New Permission Request	There is a new permission request from Tania yunita.	permission	t	2025-07-28 15:09:09.851232	2025-07-28 08:33:09.986512
136	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 06:43:18.663744	\N
138	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-23 06:45:50.839621	\N
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
357	1	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-08-02 01:22:44.79528	\N
361	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-08-02 12:36:21.06266	\N
157	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 08:45:10.892826	\N
128	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 11:32:17.491531	2025-05-23 13:49:49.397965
362	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-08-02 17:26:24.441474	2025-08-02 10:34:00.513737
161	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 20:56:33.944735	\N
160	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 20:56:33.944735	2025-05-23 14:01:41.025673
159	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 20:46:00.517792	2025-05-23 14:01:44.448951
154	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	t	2025-05-23 20:44:18.1129	2025-05-23 14:01:45.026013
153	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-23 20:37:09.035224	2025-05-23 14:09:21.349867
164	3	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
165	17	Permintaan Izin Baru	Ada permintaan izin baru dari yu yus.	permission	f	2025-05-23 22:59:30.826331	\N
356	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Safari 18.0.1	new_device	t	2025-08-01 15:37:28.869234	2025-08-02 19:23:52.128954
355	3	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 15:36:25.	failed_login	t	2025-08-01 15:31:25.728011	2025-08-02 19:23:53.684879
383	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 21:54:33.	failed_login	f	2025-08-03 21:53:34.074335	\N
168	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-23 23:18:58.402583	\N
384	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 21:55:45.	failed_login	f	2025-08-03 21:54:46.621019	\N
170	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-23 23:26:48.892906	\N
201	27	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunitaa.	permission	t	2025-06-13 23:35:08.726614	2025-07-24 09:49:23.908391
172	17	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	f	2025-05-23 23:29:12.397259	\N
325	27	New Permission Request	There is a new permission request from Tania Yusnita.	permission	t	2025-07-24 16:59:49.555784	2025-07-24 10:01:51.804854
317	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:46:48.98016	2025-07-26 14:22:23.93986
397	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 02:50:43.	failed_login	f	2025-08-04 02:49:43.995092	\N
175	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:29:26.236148	2025-05-23 16:29:37.727939
398	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 02:53:30.	failed_login	f	2025-08-04 02:52:30.822706	\N
171	3	Permintaan Izin Baru	Ada permintaan izin baru dari Maureen Gabriella.	permission	t	2025-05-23 23:29:12.397259	2025-05-24 06:57:36.355537
339	17	New Permission Request	There is a new permission request from Nabilla Libasutaqwa.	permission	f	2025-07-28 01:26:37.186885	\N
176	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-23 23:49:49.82315	2025-05-24 15:42:56.152956
178	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-24 22:42:39.736659	2025-05-24 15:42:57.609281
340	27	New Permission Request	There is a new permission request from Nabilla Libasutaqwa.	permission	t	2025-07-28 01:26:41.168126	2025-07-28 07:23:46.143469
180	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.478087	\N
181	17	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-26 04:06:59.479232	\N
348	17	New Permission Request	There is a new permission request from Tania yunita.	permission	f	2025-07-28 15:09:05.038546	\N
184	3	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-27 00:42:28.616557	\N
185	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-27 06:06:19.056272	\N
352	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 138.0.0	new_device	f	2025-07-28 16:10:14.139027	\N
358	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-08-02 01:23:26.323666	\N
359	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-08-02 01:23:31.123334	\N
190	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:11:07.509518	2025-05-28 03:11:12.327956
187	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-27 09:03:25.366884	2025-05-28 03:11:13.213398
186	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-27 02:00:09.14251	2025-05-28 03:11:14.134038
191	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	t	2025-05-28 10:24:15.973511	2025-06-07 08:06:20.298563
193	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 137.0.0	new_device	f	2025-06-08 19:23:15.698131	\N
363	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-08-02 17:31:58.4848	2025-08-02 10:32:25.076127
196	4	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 119.0.0	new_device	f	2025-06-10 19:09:27.799658	\N
366	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-08-02 20:40:46.198643	2025-08-02 13:41:20.441373
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
385	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 22:04:00.	failed_login	f	2025-08-03 22:03:01.512916	\N
250	27	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-06-21 17:29:17.410263	2025-07-24 09:49:39.040819
231	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:02:03.662368	\N
274	27	New Permission Request	There is a new permission request from Yustina Yunitaa.	permission	t	2025-07-10 20:02:36.168985	2025-07-24 09:49:41.499578
233	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Edge 137.0.0	new_device	f	2025-06-19 19:02:45.518765	\N
386	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 22:07:50.	failed_login	f	2025-08-03 22:06:51.332357	\N
282	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:05:46.759423	2025-07-24 09:49:44.808056
236	17	Permintaan Izin Baru	Ada permintaan izin baru dari Abid Laqoo.	permission	f	2025-06-19 19:06:57.869993	\N
318	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:49:45.777331	\N
399	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 02:56:00.	failed_login	f	2025-08-04 02:55:01.602668	\N
240	17	New Permission Request	There is a new permission request from Abid Laqoo.	permission	f	2025-06-19 19:12:43.056867	\N
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
284	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:06:55.906739	\N
307	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:42:27.612972	2025-07-24 09:38:09.016583
387	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 22:17:09.	failed_login	f	2025-08-03 22:16:09.914002	\N
388	49	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 22:20:06.	failed_login	f	2025-08-03 22:19:07.544141	\N
288	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-11 20:09:32.483605	\N
303	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:07:34.931048	2025-07-24 09:38:11.208691
389	49	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 22:27:03.	failed_login	f	2025-08-03 22:26:04.642476	\N
400	3	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome 138.0.0	new_device	f	2025-08-04 03:17:35.058225	\N
299	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 19:05:06.885702	2025-07-24 09:38:13.430319
292	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 134.0.0	new_device	t	2025-07-18 21:35:49.364835	2025-07-18 14:35:54.770493
293	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 18:59:45.574618	\N
286	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:07:00.638655	2025-07-24 09:49:46.829689
297	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:04:59.392283	\N
290	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-11 20:09:37.17348	2025-07-24 09:49:48.923118
401	6	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 17:44:34.	failed_login	t	2025-08-04 17:43:35.254402	2025-08-04 10:45:55.304436
301	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:07:25.701324	\N
295	27	New Permission Request	There is a new permission request from do kyungso.	permission	t	2025-07-20 18:59:52.715012	2025-07-24 09:49:54.767463
370	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-08-02 22:46:39.278939	2025-08-04 10:46:04.262584
367	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-08-02 20:59:44.232057	2025-08-04 10:46:07.285395
305	17	New Permission Request	There is a new permission request from do kyungso.	permission	f	2025-07-20 19:42:21.134914	\N
321	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-24 16:50:35.894901	\N
402	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-08-04 17:45:48.18535	2025-08-04 10:46:09.689923
403	21	Failed Login Attempt	Detected 5 failed login attempts. Your account has been locked until 18:42:05.	failed_login	f	2025-08-04 18:41:06.155111	\N
405	21	Failed Login Attempt	Detected 10 failed login attempts. Your account has been locked until 18:55:36.	failed_login	f	2025-08-04 18:53:37.359172	\N
310	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 14:31:42.360899	2025-07-24 09:07:28.069175
309	21	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 119.0.0	new_device	t	2025-07-20 20:05:53.382275	2025-07-24 09:07:28.143132
322	27	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	t	2025-07-24 16:50:50.530728	2025-07-24 10:01:49.915022
311	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Opera 120.0.0	new_device	t	2025-07-24 16:16:36.626425	2025-07-26 14:27:25.850864
327	6	Login from New Device	Login detected from IP: 127.0.0.1, Device: Chrome Mobile 135.0.0	new_device	t	2025-07-26 22:55:58.667584	2025-07-26 15:56:18.763547
330	27	New Permission Request	There is a new permission request from Dame Un GRR.	permission	t	2025-07-27 13:31:46.016646	2025-07-27 06:34:14.733849
343	17	New Permission Request	There is a new permission request from Nabilaa Libasutaqwa.	permission	f	2025-07-28 01:32:47.403393	\N
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
44	1	other	2025-08-01	2025-08-04	2025-08-05	Meetings	Approved	2025-08-01	1
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
49	36	ucooo	anisa.nrwn15@gmail.com	$2b$12$7HT/kXNESxbkE85zC1feouRMusI8SSexissYLTKHPJzsoQeguYEHS	2025-08-03 19:15:02.115376+00
6	2	yuyusdaily	yustinayunita86@gmail.com	$2b$12$arup/TewG7bgNCTRMd3jrOBXUDSycLkUeQfhkx6bBQs5Wj2QLowDu	2025-08-04 12:09:54.842762+00
21	12	yuyus	yustinayunitayy@gmail.com	$2b$12$AYxie4AyaojhZoQV1X6SPOehdmAkhU9PoTxgkpWQL5aLzSjhH4Vm.	2025-08-04 12:10:20.378907+00
27	17	angelinemoore	angelinemoore.notsafe@gmail.com	$2b$12$lP/uOO8ijTIhx/Nr7I1BBe99/FbY2GJu7VQEaGJrYEvhrs0sWyy6a	2025-07-30 17:02:17.539927+00
1	1	nblalb	nabilalb2004@gmail.com	$2b$12$KGpL.bYtXbRclxx.91GVqerU8I9EXrYk77KparUCDsjpmW/86KQOW	2025-07-30 17:02:55.372064+00
17	11	admin_nabila	nabilalb0109@gmail.com	$2b$12$mgGvRNU7003XLan5tjLice2r96RLOKpf/14ID39uTNllPYcP7cG12	2025-07-30 17:03:05.839286+00
4	4	SuperadminNab	nabila.libasutaqwa@student.president.ac.id	$2b$12$xIrAjHZdiy4OvX85aQPgDO60zttLywUOg/1agBVzw8Ah2EiBwesvC	2025-07-30 17:03:15.95621+00
67	22	mmm	annisanirwana94@yahoo.com	$2b$12$SXk0hbYDHARZF49JNRG8CeNZLBF3bk4hBiTQmlk4XGcabbqpe5C.u	2025-08-02 21:10:06.27479+00
3	3	superadminisa	nirwanaanisa1508@gmail.com	$2b$12$KPy2ygxJc/L9PvxE6uoaiuGIU.Pvr1b4D8jleGuM9CPdWSUBbcN3S	2025-08-03 09:12:04.471328+00
70	57	arjuna	anisa.n@student.president.ac.id	$2b$12$zfjmO09hWtElXIIahruiW.yJfucaR2FAdd/1d7MRAR.Vy/kXbZXt6	2025-08-03 12:06:18.54458+00
71	59	dame	gwenrosevyn@gmail.com	$2b$12$yncILRpmxmD/qUDLkhXtpuRU4kfal01Lj7QHbe1HqaJvZPJk74zfC	2025-08-03 13:03:46.982548+00
72	58	Nabila	dwiadinda438@gmail.com	$2b$12$0oQCE1Nk4p9iA4vz65WzQ.fayQtqoPvKe6rLig72RXlUKHiPa.IVC	2025-08-03 13:23:28.145721+00
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.user_roles (user_id, roles_id) FROM stdin;
27	2
3	1
70	3
1	3
17	2
4	1
71	3
72	3
49	2
6	1
21	3
67	3
\.


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.activity_logs_log_id_seq', 1256, true);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 458, true);


--
-- Name: backup_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.backup_schedule_id_seq', 1, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 59, true);


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.lock_system_lock_id_seq', 51, true);


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public."login_attempts_logAtt_id_seq"', 2265, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 405, true);


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.permissions_permissions_id_seq', 44, true);


--
-- Name: roles_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.roles_roles_id_seq', 1, false);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: Project_owner
--

SELECT pg_catalog.setval('public.user_user_id_seq', 72, true);


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
-- Name: backup_schedule backup_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: Project_owner
--

ALTER TABLE ONLY public.backup_schedule
    ADD CONSTRAINT backup_schedule_pkey PRIMARY KEY (id);


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
-- Name: ix_backup_schedule_id; Type: INDEX; Schema: public; Owner: Project_owner
--

CREATE INDEX ix_backup_schedule_id ON public.backup_schedule USING btree (id);


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

