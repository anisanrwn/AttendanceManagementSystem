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
    role_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    reason text
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
267	\N	Viewed employee profile	Viewed profile of employee ID 15	\N	2025-05-27 13:27:51.692004+00	\N
268	\N	Viewed employee profile	Viewed profile of employee ID 5	\N	2025-05-27 13:27:59.524427+00	\N
269	\N	Viewed employee profile	Viewed profile of employee ID 5	\N	2025-05-27 13:30:22.209017+00	\N
270	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-27 18:08:49.966335+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
271	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 18:14:30.665093+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
272	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 20:06:06.628125+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
273	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 20:10:51.806151+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
274	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-27 20:13:54.909637+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
275	17	Login	User nabilalb0109@gmail.com logged in successfully	127.0.0.1	2025-05-27 20:34:42.904699+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
276	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-27 20:41:32.116859+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
277	\N	Viewed employee profile	Viewed profile of employee ID 16	\N	2025-05-27 20:41:49.02171+00	\N
278	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-27 20:47:11.333607+00	\N
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
289	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-28 01:55:21.286635+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
290	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-28 01:57:23.562468+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
291	19	Login	User adelaideufrasia@gmail.com logged in successfully	127.0.0.1	2025-05-28 02:05:13.285981+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
292	4	Login	User nabila.libasutaqwa@student.president.ac.id logged in successfully	127.0.0.1	2025-05-28 02:09:27.204663+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0
293	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-28 03:03:42.100914+00	\N
294	6	Login	User yustinayunita86@gmail.com logged in successfully	127.0.0.1	2025-05-28 03:11:08.355636+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
295	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-05-28 03:14:12.195381+00	\N
296	\N	Add employee failed	'image_filename' is an invalid keyword argument for Employee	\N	2025-05-28 03:15:39.482672+00	\N
297	\N	Added employee	Employee Angeline Moore added successfully	\N	2025-05-28 03:17:49.470278+00	\N
298	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-05-28 03:18:51.827946+00	\N
299	\N	Viewed employee profile	Viewed profile of employee ID 17	\N	2025-05-28 03:18:54.234911+00	\N
300	\N	Created user	User angelinemoore created successfully	\N	2025-05-28 03:19:14.758506+00	\N
301	27	Login	User angelinemoore.notsafe@gmail.com logged in successfully	127.0.0.1	2025-05-28 03:20:04.126587+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
302	21	Login	User yustinayunitayy@gmail.com logged in successfully	127.0.0.1	2025-05-28 03:24:17.024742+00	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 OPR/119.0.0.0
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
337	\N	Updated user	User SuperadminNab updated successfully	\N	2025-06-10 12:08:42.925528+00	\N
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
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: Project_owner
--

COPY public.alembic_version (version_num) FROM stdin;
