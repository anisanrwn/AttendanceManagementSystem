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
37187f8c4845
\.


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attendance (attendance_id, employee_id, clock_in, clock_in_latitude, clock_in_longitude, clock_in_verified, clock_in_reason, clock_in_distance, clock_out, clock_out_latitude, clock_out_longitude, clock_out_verified, clock_out_reason, clock_out_distance, attendance_date, attendance_status, face_verified) FROM stdin;
1	2	16:38:30.727058	-6.4752909	106.8451365	t	hehe	0.4648282977199178	16:38:51.040772	-6.4752909	106.8451365	t	hehe	0.4502138623306672	2025-05-20	Punch Out	t
2	12	16:39:39.879565	-6.4752909	106.8451365	t	jalan jalan	0.4839334597933803	16:42:21.299762	-6.4733745	106.8514453	t	hehe	0.37135605428832275	2025-05-20	Punch Out	t
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.employees (employee_id, first_name, last_name, nrp_id, email, phone_number, "position", department, face_encoding) FROM stdin;
5	ROJAAH	AMIN	6775886	maureengabriella1m@gmail.com	082214987219	HMMM	HMM	\N
4	abcdefg	hijklmn	567890	lala@gmail.com	081223456333	UI Designer	Web Programming	\N
2	Yustina	Yunita	1888	yustinayunita86@gmail.com	08987654321	Data Scientist	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
1	Nabila	Libasutaqwa	1777	nabilalb@gmail.com	081234567890	Data Security	Cyber Security	[-0.11877931654453278, 0.048978134989738464, 0.04527463763952255, -0.053959839046001434, -0.11791834235191345, -0.04495662823319435, -0.02108035981655121, -0.12154902517795563, 0.14449924230575562, -0.13219228386878967, 0.2115778625011444, -0.059877026826143265, -0.2019445300102234, -0.055844079703092575, -0.031118731945753098, 0.23269718885421753, -0.22157025337219238, -0.15516698360443115, -0.06823483854532242, -0.011522598564624786, 0.0629851371049881, -0.039067551493644714, 0.08161631971597672, 0.037768762558698654, -0.1215372234582901, -0.34673014283180237, -0.07339158654212952, -0.04526490718126297, -0.05223672091960907, -0.0010802150936797261, -0.053868792951107025, 0.06410800665616989, -0.22088253498077393, -0.06292301416397095, 0.05741925910115242, 0.07921651005744934, -0.03555351868271828, -0.08645129948854446, 0.2093575894832611, -0.04646805673837662, -0.2735065817832947, 0.005639377981424332, 0.13623614609241486, 0.2107405811548233, 0.1236954852938652, 0.03615737706422806, 0.00791251566261053, -0.12571097910404205, 0.1281934380531311, -0.16802296042442322, 0.07628294825553894, 0.10171712189912796, 0.10188271850347519, 0.01609496958553791, 0.061359576880931854, -0.12568289041519165, 0.045133449137210846, 0.1394161432981491, -0.09774723649024963, -0.03284337744116783, 0.11771884560585022, -0.04846888780593872, -0.04083703085780144, -0.14710000157356262, 0.21173681318759918, 0.10060358047485352, -0.08506668359041214, -0.17493729293346405, 0.12550681829452515, -0.05969913303852081, -0.059123389422893524, 0.06671737879514694, -0.1499161422252655, -0.21463961899280548, -0.27530986070632935, -0.02323021925985813, 0.30915629863739014, 0.10314305871725082, -0.16695356369018555, 0.01426028087735176, 0.01552140899002552, 0.02114843763411045, 0.12716341018676758, 0.16630852222442627, -0.01382768526673317, 0.08116237819194794, -0.08654364943504333, 0.029460828751325607, 0.19440734386444092, -0.08323968201875687, -0.036607809364795685, 0.21330304443836212, 0.026845799759030342, 0.0015197917819023132, 0.00652182474732399, -0.011105605401098728, -0.06658308207988739, 0.07986483722925186, -0.22473746538162231, 0.011140072718262672, 0.05963897705078125, 0.03300333768129349, -0.028514988720417023, 0.07891437411308289, -0.13830700516700745, 0.01650134287774563, -0.02790762111544609, 0.004079924896359444, -0.016230043023824692, -0.030277667567133904, -0.11010953783988953, -0.0883723720908165, 0.044013429433107376, -0.21927028894424438, 0.13821639120578766, 0.16726413369178772, 0.016312438994646072, 0.11036698520183563, 0.10717912763357162, 0.06306461989879608, 0.0313158854842186, -0.008186950348317623, -0.23215122520923615, -0.008681267499923706, 0.18264751136302948, -0.01756097562611103, 0.09290212392807007, 0.009914634749293327]
3	Anisa	Nirwana	1333	nirwanaanisa1508@gmail.com	082214987219	Data Security	Cyber Security	[-0.10745113343000412, 0.06479183584451675, 0.03841818869113922, -0.07419481873512268, -0.09446264058351517, -0.03752533346414566, 0.0005902769044041634, -0.12211665511131287, 0.21591351926326752, -0.17293238639831543, 0.26916223764419556, -0.07804253697395325, -0.21133631467819214, -0.09860064089298248, 0.009385057725012302, 0.19761797785758972, -0.17414486408233643, -0.13627183437347412, -0.06367859244346619, 0.001685909926891327, 0.054232094436883926, -0.05612108111381531, 0.054845668375492096, 0.11643049865961075, -0.09619110822677612, -0.437546968460083, -0.09363581240177155, -0.052024345844984055, -0.06378484517335892, -0.042893484234809875, -0.07512733340263367, 0.1269986778497696, -0.2208126336336136, -0.1137506440281868, -0.05288901925086975, 0.1556069552898407, -0.06213591247797012, -0.06360242515802383, 0.1493958830833435, -0.035987090319395065, -0.25839105248451233, -0.05924650654196739, 0.043905291706323624, 0.23576849699020386, 0.13991595804691315, -0.017593640834093094, 0.028691517189145088, -0.0865224152803421, 0.07595359534025192, -0.2189370095729828, 0.03575323522090912, 0.112706758081913, 0.0446292869746685, 0.053642794489860535, 0.0026290896348655224, -0.11978019773960114, 0.006495899520814419, 0.14221717417240143, -0.13829924166202545, -0.05454059690237045, 0.0592513270676136, -0.10209975391626358, -0.05291147157549858, -0.11121028661727905, 0.24784503877162933, 0.18585355579853058, -0.078170046210289, -0.16279618442058563, 0.15717552602291107, -0.10458815097808838, -0.04208763316273689, 0.04490136355161667, -0.17050541937351227, -0.21318675577640533, -0.3112885057926178, 0.022013558074831963, 0.3361208736896515, 0.06767086684703827, -0.12074443697929382, 0.01670217327773571, -0.0897703692317009, -0.004880569409579039, 0.08870840072631836, 0.1477670669555664, 0.03332361578941345, 0.0742664635181427, -0.10334115475416183, 0.09656691551208496, 0.14913655817508698, -0.0733344778418541, -0.008518592454493046, 0.2307186722755432, -0.0033590374514460564, 0.05413768067955971, 0.041642606258392334, 0.056115809828042984, -0.06448857486248016, 0.11233486235141754, -0.22535854578018188, 0.06161462888121605, 0.05863276869058609, 0.0010617543011903763, -0.029182879254221916, 0.06716076284646988, -0.1392315775156021, 0.0819094106554985, 0.0209417212754488, 0.024644305929541588, 0.055981215089559555, -0.05498424544930458, -0.107485331594944, -0.13754069805145264, 0.11024875193834305, -0.21977248787879944, 0.11776702105998993, 0.17204159498214722, 0.029302291572093964, 0.17161093652248383, 0.07747355103492737, 0.09040781855583191, 0.008818788453936577, -0.08593098819255829, -0.27368438243865967, 0.0782378762960434, 0.15335705876350403, 0.0021260594949126244, -0.010376254096627235, 0.016320500522851944]
11	Nita	yun	5432123	adelaideufrasia@gmail.com	081234567890	Full Stack Developer	Web Programming	\N
12	yu	yus	65432	yuyus@gmail.com	08987654234	Data	Data	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
13	Yunita	Yustina	334455	yuyun@gmail.com	0812983648380	Data Security	Data Intelligence	[-0.12081847339868546, 0.038519058376550674, 0.01617797277867794, -0.11711333692073822, -0.1798979789018631, -0.09020186960697174, -0.08343029022216797, -0.11644374579191208, 0.14504992961883545, -0.20651744306087494, 0.26471689343452454, -0.08519832044839859, -0.2167043685913086, 0.014478392899036407, -0.1274823546409607, 0.24535933136940002, -0.14351284503936768, -0.1354047805070877, -0.016530517488718033, -0.05096457898616791, 0.08127860724925995, 0.025655200704932213, 0.06100502237677574, 0.08785732835531235, -0.08246975392103195, -0.3274708390235901, -0.13612331449985504, -0.030706165358424187, -0.05291849002242088, -0.014987347647547722, 0.01850481517612934, 0.061041995882987976, -0.19148553907871246, -0.023614443838596344, 0.05604158341884613, 0.14095266163349152, -0.03029518760740757, -0.12160660326480865, 0.17835865914821625, 0.002110738307237625, -0.24809561669826508, -0.022115252912044525, 0.1188221424818039, 0.23312923312187195, 0.10380479693412781, 0.01653021201491356, 0.04738154262304306, -0.191096231341362, 0.059532471001148224, -0.24096521735191345, 0.060559093952178955, 0.09311612695455551, 0.03054102137684822, 0.012061243876814842, 0.03946781903505325, -0.11079143732786179, 0.10112646967172623, 0.20197691023349762, -0.12143829464912415, 0.004151986446231604, 0.13035036623477936, -0.08705785870552063, -0.002701270394027233, -0.1368587166070938, 0.2985178232192993, 0.1288498193025589, -0.1383354514837265, -0.14450614154338837, 0.12208250910043716, -0.16815871000289917, -0.09256096929311752, 0.10865561664104462, -0.11663981527090073, -0.20802515745162964, -0.3321249783039093, -0.01939382404088974, 0.42114946246147156, 0.17391127347946167, -0.11147546768188477, 0.060409825295209885, -0.02171672135591507, 0.04094720631837845, 0.14692328870296478, 0.18827612698078156, 0.013831889256834984, -0.008111615665256977, -0.13498201966285706, 0.0005196882411837578, 0.2598588466644287, -0.08631325513124466, -0.044273246079683304, 0.22467535734176636, -0.0007641483098268509, 0.06848734617233276, 0.011925794184207916, 0.053894877433776855, -0.11671201884746552, -0.02115420438349247, -0.11701779067516327, 0.008025548420846462, -0.04275678098201752, -0.011377350427210331, -0.07139479368925095, 0.08291463553905487, -0.1427893042564392, 0.04708210378885269, -0.08601164072751999, -0.0622728131711483, -0.03447083383798599, -0.026589998975396156, -0.053609564900398254, -0.0772043988108635, 0.09081673622131348, -0.21906159818172455, 0.13878333568572998, 0.16576260328292847, 0.05053684860467911, 0.1921692043542862, 0.15153010189533234, 0.11393868923187256, -0.026383083313703537, -0.08832304924726486, -0.19168874621391296, -0.0186691265553236, 0.07096114009618759, -0.05210106447339058, 0.11873781681060791, -0.010129460133612156]
\.


--
-- Data for Name: lock_system; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lock_system (lock_id, start_date, end_date, reason, role_id) FROM stdin;
15	2025-05-21 12:57:00	2025-05-21 12:59:00	ABID	3
\.


--
-- Data for Name: login_attempts; Type: TABLE DATA; Schema: public; Owner: -
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
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (notification_id, user_id, title, message, notification_type, is_read, created_at, read_at) FROM stdin;
5	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome 136.0.0	new_device	f	2025-05-12 14:15:51.347809	\N
7	15	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-14 02:58:04.711079	\N
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
46	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 14:52:29.895812	\N
48	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 15:26:32.984996	\N
50	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-18 16:24:04.756409	\N
52	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 19:58:16.520535	\N
10	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-14 07:37:29.594588	2025-05-19 09:10:09.677018
36	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-18 04:11:14.686422	2025-05-19 09:10:14.692875
49	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 15:26:32.984996	2025-05-20 12:53:34.025552
47	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 14:52:29.895812	2025-05-20 09:20:24.194451
51	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-18 16:24:04.756409	2025-05-20 12:55:16.289724
54	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:00:24.284593	\N
56	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:11:53.940808	\N
57	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:11:53.940808	\N
58	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:13:05.507031	\N
60	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:14:10.537946	\N
62	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 20:43:45.82043	\N
64	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	f	2025-05-18 21:09:25.449617	\N
59	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:13:05.507031	2025-05-20 12:55:11.423328
65	7	Percobaan Login Gagal	Terdeteksi 5 kali percobaan login gagal. Akun Anda dikunci sementara.	failed_login	t	2025-05-18 21:16:41.074356	2025-05-18 21:24:22.66082
66	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-18 21:38:15.016478	\N
70	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	f	2025-05-19 09:08:33.417309	\N
72	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	f	2025-05-19 09:09:50.983611	\N
74	19	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	f	2025-05-19 09:10:02.964473	\N
69	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-19 09:08:22.767267	2025-05-19 09:10:12.217593
68	6	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-19 07:59:29.497646	2025-05-19 09:10:13.542084
77	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-20 00:17:36.083012	\N
81	19	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-20 00:33:08.670742	\N
84	4	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	f	2025-05-20 00:33:08.671771	\N
87	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 05:27:26.774969	\N
90	4	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 05:27:26.774969	\N
91	17	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Chrome Mobile 133.0.0	new_device	t	2025-05-20 08:57:53.259483	2025-05-20 08:59:28.155274
75	3	Permintaan Izin Baru	Ada permintaan izin baru dari Yustina Yunita.	permission	t	2025-05-19 09:10:02.964473	2025-05-20 09:18:09.538941
55	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 20:00:24.284593	2025-05-20 12:55:13.28395
53	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-18 19:58:16.520535	2025-05-20 12:55:18.091954
93	19	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	f	2025-05-20 12:56:24.616752	\N
88	3	Permintaan Izin Baru	Ada permintaan izin baru dari ROJAAH AMIN.	permission	t	2025-05-20 05:27:26.774969	2025-05-20 12:54:44.302642
86	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	t	2025-05-20 05:26:33.126384	2025-05-20 12:54:45.811616
85	3	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Opera 118.0.0	new_device	t	2025-05-20 05:17:15.199951	2025-05-20 12:54:47.271414
82	3	Permintaan Izin Baru	Ada permintaan izin baru dari Nabila Libasutaqwa.	permission	t	2025-05-20 00:33:08.671771	2025-05-20 12:54:49.694744
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
95	21	Login dari Perangkat Baru	Login terdeteksi dari IP: 127.0.0.1, Perangkat: Edge 136.0.0	new_device	f	2025-05-21 18:21:06.273696	\N
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.permissions (permissions_id, employee_id, permission_type, request_date, start_date, end_date, reason, permission_status, approved_date, user_id) FROM stdin;
1	2	family-urgent	2025-05-19	2025-05-19	2025-05-21	asdf	Pending	\N	6
2	2	personal-business	2025-05-19	2025-05-21	2025-05-24	aqwsdf	Pending	\N	6
3	1	sick-leave	2025-05-20	2025-05-20	2025-05-21	tes	Pending	\N	1
4	1	family-urgent	2025-05-20	2025-05-20	2025-05-20	tess	Pending	\N	1
5	5	family-urgent	2025-05-20	2025-05-02	2025-05-10	eek dulu	Pending	\N	7
6	5	sick-leave	2025-05-20	2025-05-01	2025-05-03	rr	Pending	\N	7
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (roles_id, roles_name) FROM stdin;
1	Super Admin
2	Admin
3	Employee
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (user_id, employee_id, username, email, password) FROM stdin;
7	5	penilai_nahdya@sidia.pglhk	maureengabriella1m@gmail.com	$2b$12$HhZnBLLmyhfRsS2wiH9N0O4h8L05yczDHUsRr/N/YIFc9Yvae.OG2
19	\N	admin3	admin3@gmail.com	$2b$12$C66lm6F7lmSa4ekuwPzSzu/ylX8ETOr6kGlOKMNNh8UMoNce2aTxG
3	3	HR	nirwanaanisa1508@gmail.com	$2b$12$V5XqrJ75alWOUkkxT.yi2us/fRoV70yL5jxLEzCkuFbIzEHLOVBNK
15	\N	admin	admin@gmail.com	$2b$12$wnKKXEHoZa05yojTai9yj.LnqUjC2haQ3Qt32JOM88baqVIdFU6ky
17	11	nita	adelaideufrasia@gmail.com	$2b$12$ACImV/CiGtmlSqU4fvhThuZB1lpM43swkJcpwW0P2BZWZmqKgYEFm
22	13	yunita	yuyun@gmail.com	$2b$12$ZfV3CVNKreq5DWEd8b6X2e853Bfp7gaHCqgzfnkaV9dqb8f2Or5Tm
21	12	yuyus	yuyus@gmail.com	$2b$12$eknm5cV46J50TZ1neEq1eO0gJXK9CBR5HBACIEL0OPP4qhWxfp.t.
6	2	yuyusdaily	yustinayunita86@gmail.com	$2b$12$ctoXEA8acnl3r/0keW5ZkeTxeJGRL1Ph0umOFUfG/17ojvP4RGg76
14	\N	admin2	admin2@gmail.com	$2b$12$jBWDyhGP/q73T6QXGUywbulAZmlyU22mfZ1yoNKZu4ZvXhHYn37ky
1	1	nblalb	nabilalb2004@gmail.com	$2b$12$edNUCmV/B16tJb5wSutyn.WxlrBcESj/o0yaHbIdHm7wuNZD4PexO
4	4	69832002	nabila.libasutaqwa@student.president.ac.id	$2b$12$Cr90IfSOKcCPm3jv/GhfB.2zxWEIY/KEBdB2v29RtTDC.jFy8OJaK
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_roles (user_id, roles_id) FROM stdin;
14	1
1	3
17	1
7	3
19	2
15	1
6	3
4	2
3	1
22	3
21	3
\.


--
-- Name: activity_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.activity_logs_log_id_seq', 164, true);


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 2, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 13, true);


--
-- Name: lock_system_lock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lock_system_lock_id_seq', 20, true);


--
-- Name: login_attempts_logAtt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."login_attempts_logAtt_id_seq"', 602, true);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 95, true);


--
-- Name: permissions_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permissions_permissions_id_seq', 6, true);


--
-- Name: roles_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_roles_id_seq', 1, false);


--
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_user_id_seq', 22, true);


--
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (log_id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- Name: employees employees_nrp_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_nrp_id_key UNIQUE (nrp_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: lock_system lock_system_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lock_system
    ADD CONSTRAINT lock_system_pkey PRIMARY KEY (lock_id);


--
-- Name: login_attempts login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_pkey PRIMARY KEY ("logAtt_id");


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permissions_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (roles_id);


--
-- Name: roles roles_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_roles_name_key UNIQUE (roles_name);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, roles_id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: ix_activity_logs_log_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_activity_logs_log_id ON public.activity_logs USING btree (log_id);


--
-- Name: ix_attendance_attendance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_attendance_attendance_id ON public.attendance USING btree (attendance_id);


--
-- Name: ix_employees_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_employees_employee_id ON public.employees USING btree (employee_id);


--
-- Name: ix_lock_system_lock_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_lock_system_lock_id ON public.lock_system USING btree (lock_id);


--
-- Name: ix_login_attempts_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_login_attempts_email ON public.login_attempts USING btree (email);


--
-- Name: ix_login_attempts_logAtt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ix_login_attempts_logAtt_id" ON public.login_attempts USING btree ("logAtt_id");


--
-- Name: ix_notifications_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_created_at ON public.notifications USING btree (created_at);


--
-- Name: ix_notifications_is_read; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_is_read ON public.notifications USING btree (is_read);


--
-- Name: ix_notifications_notification_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_notification_id ON public.notifications USING btree (notification_id);


--
-- Name: ix_notifications_notification_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_notification_type ON public.notifications USING btree (notification_type);


--
-- Name: ix_notifications_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_user_id ON public.notifications USING btree (user_id);


--
-- Name: ix_notifications_user_read; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_notifications_user_read ON public.notifications USING btree (user_id, is_read);


--
-- Name: ix_permissions_permissions_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_permissions_permissions_id ON public.permissions USING btree (permissions_id);


--
-- Name: ix_roles_roles_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_roles_roles_id ON public.roles USING btree (roles_id);


--
-- Name: ix_user_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_user_employee_id ON public."user" USING btree (employee_id);


--
-- Name: ix_user_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_user_user_id ON public."user" USING btree (user_id);


--
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: attendance attendance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: lock_system lock_system_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lock_system
    ADD CONSTRAINT lock_system_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(roles_id);


--
-- Name: login_attempts login_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: permissions permissions_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: permissions permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: user user_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: user_roles user_roles_roles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_roles_id_fkey FOREIGN KEY (roles_id) REFERENCES public.roles(roles_id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- PostgreSQL database dump complete
--

