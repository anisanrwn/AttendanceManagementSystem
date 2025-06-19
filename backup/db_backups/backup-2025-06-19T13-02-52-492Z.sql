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
