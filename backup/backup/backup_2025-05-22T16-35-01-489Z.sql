--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
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
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_logs (
    log_id integer NOT NULL,
    user_id integer,
    action character varying(500) NOT NULL,
    detail text,
    ip_address character varying(45),
    "timestamp" timestamp with time zone DEFAULT now()
);


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_logs_log_id_seq OWNED BY public.activity_logs.log_id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: attendance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    employee_id integer,
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
    attendance_date date,
    attendance_status character varying(20),
    face_verified boolean
);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: lock_system; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lock_system (
    lock_id integer NOT NULL,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    reason text,
    role_id integer
);


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lock_system_lock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lock_system_lock_id_seq OWNED BY public.lock_system.lock_id;


--
-- Name: login_attempts; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."login_attempts_logAtt_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."login_attempts_logAtt_id_seq" OWNED BY public.login_attempts."logAtt_id";


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_permissions_id_seq OWNED BY public.permissions.permissions_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    roles_id integer NOT NULL,
    roles_name character varying(25)
);


--
-- Name: roles_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_roles_id_seq OWNED BY public.roles.roles_id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    user_id integer NOT NULL,
    employee_id integer,
    username character varying(100),
    email character varying(100),
    password character varying(500)
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    user_id integer NOT NULL,
    roles_id integer NOT NULL
);


--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;


--
-- Name: activity_logs log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs ALTER COLUMN log_id SET DEFAULT nextval('public.activity_logs_log_id_seq'::regclass);


--
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: lock_system lock_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lock_system ALTER COLUMN lock_id SET DEFAULT nextval('public.lock_system_lock_id_seq'::regclass);


--
-- Name: login_attempts logAtt_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts ALTER COLUMN "logAtt_id" SET DEFAULT nextval('public."login_attempts_logAtt_id_seq"'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: permissions permissions_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN permissions_id SET DEFAULT nextval('public.permissions_permissions_id_seq'::regclass);


--
-- Name: roles roles_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN roles_id SET DEFAULT nextval('public.roles_roles_id_seq'::regclass);


--
-- Name: user user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);


--
-- Data for Name: activity_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.activity_logs (log_id, user_id, action, detail, ip_address, "timestamp") FROM stdin;
1	\N	Added employee	Employee yu yus added successfully	\N	2025-05-03 13:29:04.865887+00
2	\N	Created user	User yuyusday created successfully	\N	2025-05-03 13:29:28.781417+00
3	\N	Deleted user	User 10 deleted successfully	\N	2025-05-03 13:31:29.601692+00
4	\N	Created user	User nyanya created successfully	\N	2025-05-03 13:31:47.668781+00
5	\N	Deleted user	User 12 deleted successfully	\N	2025-05-03 13:32:22.76874+00
6	\N	Created user	User nyanya created successfully	\N	2025-05-03 13:37:53.062551+00
7	\N	Deleted user	User 13 deleted successfully	\N	2025-05-03 13:38:27.455108+00
8	\N	Created user	User nyanya created successfully	\N	2025-05-03 13:38:38.062319+00
9	\N	Created user	User admin created successfully	\N	2025-05-03 14:08:09.752788+00
10	\N	Updated user	User nblalb updated successfully	\N	2025-05-04 07:35:40.517367+00
11	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-04 08:00:09.612111+00
12	\N	Updated user	User 69832002 updated successfully	\N	2025-05-04 09:16:50.670892+00
13	\N	Updated user	User 69832002 updated successfully	\N	2025-05-04 09:17:49.359355+00
14	\N	Viewed employee profile	Viewed profile of employee ID 9	\N	2025-05-04 10:02:40.851431+00
15	\N	Viewed employee profile	Viewed profile of employee ID 9	\N	2025-05-04 10:02:44.18576+00
16	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-04 10:02:54.542349+00
17	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-04 13:12:18.122606+00
18	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-04 13:26:38.477705+00
19	\N	Updated user	User penilai_nahdya@sidia.pglhk updated successfully	\N	2025-05-04 17:41:38.266957+00
20	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-06 03:08:27.434152+00
21	\N	Updated user	User nblalb updated successfully	\N	2025-05-07 04:43:01.848428+00
22	\N	Add employee failed	OpenCV(4.11.0) D:\\a\\opencv-python\\opencv-python\\opencv\\modules\\imgcodecs\\src\\loadsave.cpp:993: error: (-215:Assertion failed) !buf.empty() in function 'cv::imdecode_'\n	\N	2025-05-07 09:34:35.274698+00
23	\N	Added employee	Employee Nita yun added successfully	\N	2025-05-07 09:36:02.689635+00
24	\N	Viewed employee profile	Viewed profile of employee ID 9	\N	2025-05-07 09:36:07.674852+00
25	\N	Viewed employee profile	Viewed profile of employee ID 11	\N	2025-05-07 09:36:11.080696+00
26	\N	Deleted employee	Employee 9 deleted successfully	\N	2025-05-07 09:36:44.633817+00
27	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 09:36:46.795768+00
28	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 09:39:44.418637+00
29	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 09:40:56.006666+00
30	\N	Updated employee	Employee 4 updated successfully	\N	2025-05-07 09:41:29.703512+00
31	\N	Updated user	User nyanya updated successfully	\N	2025-05-07 11:06:46.473892+00
32	\N	Updated user	User 69832002 updated successfully	\N	2025-05-07 11:06:56.24227+00
33	\N	Updated user	User 69832002 updated successfully	\N	2025-05-07 11:06:57.396234+00
34	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-07 11:07:25.763445+00
35	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-07 11:07:29.74448+00
36	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 11:09:04.3799+00
37	\N	Created user	User nitanyan created successfully	\N	2025-05-07 11:20:02.26011+00
38	\N	Updated user	User nitanyan updated successfully	\N	2025-05-07 11:20:25.50247+00
39	\N	Deleted user	User 16 deleted successfully	\N	2025-05-07 11:20:31.210336+00
40	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-07 11:22:04.788421+00
41	\N	User update failed	(psycopg2.errors.UniqueViolation) duplicate key value violates unique constraint "user_email_key"\nDETAIL:  Key (email)=(admin@gmail.com) already exists.\n\n[SQL: UPDATE "user" SET email=%(email)s, password=%(password)s WHERE "user".user_id = %(user_user_id)s]\n[parameters: {'email': 'admin@gmail.com', 'password': '$2b$12$x1vayzbGXFeJAHsCifZ3HeJxU0LYQ9f0zj.xXRf8uUrOwtGbZGZGe', 'user_user_id': 14}]\n(Background on this error at: https://sqlalche.me/e/20/gkpj)	\N	2025-05-07 11:31:43.564878+00
42	\N	User update failed	(psycopg2.errors.UniqueViolation) duplicate key value violates unique constraint "user_email_key"\nDETAIL:  Key (email)=(admin@gmail.com) already exists.\n\n[SQL: UPDATE "user" SET email=%(email)s, password=%(password)s WHERE "user".user_id = %(user_user_id)s]\n[parameters: {'email': 'admin@gmail.com', 'password': '$2b$12$ORIIaJCo8i8MVUUemNPqQeXgTHVETL8FRJxElapCzlwogQJw6ctSK', 'user_user_id': 14}]\n(Background on this error at: https://sqlalche.me/e/20/gkpj)	\N	2025-05-07 11:31:45.997274+00
43	\N	User update failed	(psycopg2.errors.UniqueViolation) duplicate key value violates unique constraint "user_email_key"\nDETAIL:  Key (email)=(admin@gmail.com) already exists.\n\n[SQL: UPDATE "user" SET email=%(email)s WHERE "user".user_id = %(user_user_id)s]\n[parameters: {'email': 'admin@gmail.com', 'user_user_id': 14}]\n(Background on this error at: https://sqlalche.me/e/20/gkpj)	\N	2025-05-07 11:32:17.340314+00
44	\N	Updated user	User nyanya updated successfully	\N	2025-05-07 11:33:28.641005+00
45	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:29:17.533703+00
46	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:29:19.954563+00
47	\N	Updated employee	Employee 4 updated successfully	\N	2025-05-07 12:29:26.355971+00
48	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:29:36.138613+00
49	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:29:42.160349+00
50	\N	Update employee failed	(psycopg2.errors.UniqueViolation) duplicate key value violates unique constraint "employees_email_key"\nDETAIL:  Key (email)=(yustinayunita86@gmail.com) already exists.\n\n[SQL: UPDATE employees SET email=%(email)s WHERE employees.employee_id = %(employees_employee_id)s]\n[parameters: {'email': 'yustinayunita86@gmail.com', 'employees_employee_id': 4}]\n(Background on this error at: https://sqlalche.me/e/20/gkpj)	\N	2025-05-07 12:29:52.995191+00
51	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:32:05.822722+00
52	\N	Updated employee	Employee 4 updated successfully	\N	2025-05-07 12:32:17.066034+00
53	\N	Updated user	User 69832002 updated successfully	\N	2025-05-07 12:34:43.338745+00
54	\N	Updated user	User lili updated successfully	\N	2025-05-07 12:52:45.710905+00
55	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:54:29.314355+00
56	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-07 12:54:32.290091+00
57	\N	Viewed employee profile	Viewed profile of employee ID 1	\N	2025-05-07 12:54:34.013938+00
58	\N	Viewed employee profile	Viewed profile of employee ID 11	\N	2025-05-07 12:54:35.551978+00
59	\N	Viewed employee profile	Viewed profile of employee ID 5	\N	2025-05-07 12:54:37.135714+00
60	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-07 12:54:38.686929+00
61	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-07 12:54:40.232954+00
62	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:55:07.200322+00
63	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-07 12:55:09.959759+00
64	\N	Updated user	User admin updated successfully	\N	2025-05-07 12:55:36.618374+00
65	\N	Created user	User nita created successfully	\N	2025-05-07 13:05:35.930861+00
66	\N	Created user	User asdds created successfully	\N	2025-05-07 13:06:16.470653+00
67	\N	Deleted user	User 18 deleted successfully	\N	2025-05-07 13:06:24.8625+00
68	\N	Created user	User admin3 created successfully	\N	2025-05-07 13:07:13.819591+00
69	\N	Updated user	User admin2 updated successfully	\N	2025-05-07 13:12:38.779381+00
70	\N	Updated user	User admin2 updated successfully	\N	2025-05-07 13:15:55.181985+00
71	\N	Updated user	User admin updated successfully	\N	2025-05-07 13:17:53.321948+00
72	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-09 16:14:43.96436+00
73	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-09 16:15:31.828518+00
74	\N	Updated user	User admin updated successfully	\N	2025-05-12 14:14:35.966431+00
75	\N	Updated user	User nita updated successfully	\N	2025-05-12 14:16:37.00229+00
76	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-12 16:49:29.757728+00
77	\N	Updated user	User nblalb updated successfully	\N	2025-05-13 12:21:58.334035+00
78	\N	Updated user	User admin3 updated successfully	\N	2025-05-14 02:57:30.857074+00
79	\N	Updated user	User admin updated successfully	\N	2025-05-14 02:57:47.539348+00
80	\N	Updated user	User penilai_nahdya@sidia.pglhk updated successfully	\N	2025-05-14 02:58:34.564955+00
81	\N	Updated user	User 69832002 updated successfully	\N	2025-05-14 11:58:29.137108+00
82	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-14 13:23:22.612419+00
83	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-14 13:23:26.303329+00
84	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-15 02:47:10.469272+00
85	\N	Updated user	User 69832002 updated successfully	\N	2025-05-15 02:58:21.994582+00
86	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-16 09:34:24.364633+00
87	\N	Updated user	User nita updated successfully	\N	2025-05-16 09:57:57.309236+00
88	\N	Updated user	User nita updated successfully	\N	2025-05-16 09:58:06.280562+00
89	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-16 15:49:47.105082+00
90	\N	Updated user	User nita updated successfully	\N	2025-05-17 05:38:31.55114+00
91	\N	Updated user	User nita updated successfully	\N	2025-05-17 06:22:36.061701+00
92	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-17 06:22:41.154692+00
93	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-17 08:26:42.104996+00
94	\N	Updated user	User penilai_nahdya@sidia.pglhk updated successfully	\N	2025-05-18 09:17:51.766041+00
95	\N	Updated user	User admin3 updated successfully	\N	2025-05-18 10:40:36.873387+00
96	\N	Updated user	User anisa.nrwn updated successfully	\N	2025-05-18 11:04:22.733329+00
97	\N	Add employee failed	Unsupported image type, must be 8bit gray or RGB image.	\N	2025-05-18 11:06:15.129986+00
98	\N	Add employee failed	Unsupported image type, must be 8bit gray or RGB image.	\N	2025-05-18 11:06:29.462541+00
99	\N	Add employee failed	Unsupported image type, must be 8bit gray or RGB image.	\N	2025-05-18 11:06:59.346595+00
100	\N	Updated user	User HR updated successfully	\N	2025-05-18 13:44:51.682879+00
101	\N	Updated user	User admin3 updated successfully	\N	2025-05-18 13:53:22.810172+00
102	\N	Updated user	User admin updated successfully	\N	2025-05-18 20:02:53.236611+00
103	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 08:58:53.088897+00
104	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 08:59:22.747699+00
105	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-19 08:59:25.28856+00
106	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 08:59:27.515773+00
107	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:00:31.597399+00
108	\N	Update employee failed	Unsupported image type, must be 8bit gray or RGB image.	\N	2025-05-19 09:00:40.846777+00
109	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:04:21.347943+00
110	\N	Updated employee	Employee 2 updated successfully	\N	2025-05-19 09:04:31.639569+00
111	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:04:34.943098+00
112	\N	Update employee failed	OpenCV(4.11.0) D:\\a\\opencv-python\\opencv-python\\opencv\\modules\\imgcodecs\\src\\loadsave.cpp:993: error: (-215:Assertion failed) !buf.empty() in function 'cv::imdecode_'\n	\N	2025-05-19 09:04:38.62419+00
113	\N	Viewed employee profile	Viewed profile of employee ID 3	\N	2025-05-19 09:05:37.329744+00
114	\N	Updated employee	Employee 3 updated successfully	\N	2025-05-19 09:05:48.454268+00
115	\N	Viewed employee profile	Viewed profile of employee ID 1	\N	2025-05-19 09:05:51.522467+00
116	\N	Updated employee	Employee 1 updated successfully	\N	2025-05-19 09:06:02.380113+00
117	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:06:05.441688+00
118	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-19 09:06:30.803727+00
119	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-19 09:15:58.224091+00
120	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:21:42.007145+00
121	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:23:30.352753+00
122	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:23:52.880246+00
123	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:25:42.666842+00
124	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:26:57.405263+00
125	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:28:01.519342+00
126	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:30:58.345404+00
127	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:31:20.875346+00
128	\N	Viewed employee profile	Viewed profile of employee ID 2	\N	2025-05-19 09:32:25.323404+00
129	\N	Updated employee	Employee 2 updated successfully	\N	2025-05-19 09:32:27.003277+00
130	\N	Updated user	User yuyusdaily updated successfully	\N	2025-05-19 09:32:41.233153+00
131	\N	Updated user	User yuyusday updated successfully	\N	2025-05-19 09:32:57.193618+00
132	\N	Updated user	User 69832002 updated successfully	\N	2025-05-20 00:32:32.577974+00
133	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-20 01:53:54.687962+00
134	\N	Viewed employee profile	Viewed profile of employee ID 5	\N	2025-05-20 01:54:09.248378+00
135	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-20 01:55:14.155217+00
136	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-20 01:55:15.52899+00
137	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-20 01:55:20.263514+00
138	\N	Created user	User lalaa created successfully	\N	2025-05-20 08:49:45.710201+00
139	\N	Deleted user	User 20 deleted successfully	\N	2025-05-20 08:51:20.097809+00
140	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-20 08:55:01.333552+00
141	\N	Updated employee	Employee 10 updated successfully	\N	2025-05-20 08:55:07.151075+00
142	\N	Viewed employee profile	Viewed profile of employee ID 11	\N	2025-05-20 08:55:10.085958+00
143	\N	Updated employee	Employee 11 updated successfully	\N	2025-05-20 08:55:14.856836+00
144	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-20 09:02:52.289578+00
145	\N	Viewed employee profile	Viewed profile of employee ID 11	\N	2025-05-20 09:02:56.202411+00
146	\N	Updated employee	Employee 11 updated successfully	\N	2025-05-20 09:03:01.418862+00
147	\N	Updated user	User yuyusday updated successfully	\N	2025-05-20 09:03:19.661482+00
148	\N	Deleted user	User 11 deleted successfully	\N	2025-05-20 09:03:27.328945+00
149	\N	Viewed employee profile	Viewed profile of employee ID 10	\N	2025-05-20 09:04:00.914379+00
150	\N	Deleted employee	Employee 10 deleted successfully	\N	2025-05-20 09:04:05.76545+00
151	\N	Added employee	Employee yu yus added successfully	\N	2025-05-20 09:04:39.912601+00
152	\N	Created user	User yuyus created successfully	\N	2025-05-20 09:04:53.11152+00
153	\N	Updated user	User HR updated successfully	\N	2025-05-20 12:55:58.873469+00
154	\N	Added employee	Employee Yunita Yustina added successfully	\N	2025-05-21 12:43:11.681919+00
155	\N	Viewed employee profile	Viewed profile of employee ID 4	\N	2025-05-21 12:43:14.376282+00
156	\N	Viewed employee profile	Viewed profile of employee ID 13	\N	2025-05-21 12:43:17.376736+00
157	\N	Viewed employee profile	Viewed profile of employee ID 13	\N	2025-05-21 12:43:20.398764+00
158	\N	Updated employee	Employee 13 updated successfully	\N	2025-05-21 12:43:22.586065+00
159	\N	Viewed employee profile	Viewed profile of employee ID 13	\N	2025-05-21 12:43:24.882547+00
160	\N	Updated employee	Employee 13 updated successfully	\N	2025-05-21 12:43:29.217769+00
161	\N	Created user	User yunita created successfully	\N	2025-05-21 12:44:37.304616+00
162	\N	Updated user	User yunita updated successfully	\N	2025-05-21 12:44:59.537729+00
163	\N	Updated user	User yunita updated successfully	\N	2025-05-21 17:27:59.231484+00
164	\N	Updated user	User yuyus updated successfully	\N	2025-05-21 17:28:19.554222+00
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alembic_version (version_num) FROM stdin;
