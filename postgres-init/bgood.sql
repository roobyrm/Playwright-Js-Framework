
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


ALTER TABLE public.users OWNER TO rpuser;

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.users_id_seq OWNER TO rpuser;

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;

INSERT INTO public.users VALUES (2, 'default', '$2a$10$WS7BhDl4caORMzBQz7y9zeF.iwLr87OipoubI5oo0D7OQ1qIZN8Jm', 'defaultemail@domain.com', 'dXNlcnMvZGVmYXVsdA', 'dXNlcnMvdGh1bWJuYWlsLWRlZmF1bHQ', 'USER', 'INTERNAL', false, 'tester', '{"metadata": {"last_login": 0, "attachmentContentType": "image/png"}}') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (1, 'superadmin', '$2a$10$vhlxLsj.HcuQVrbRTmOu6OOjTYK/ZeiLTKEA2Sf5JOaxZ98/KHGem', 'superadminemail@domain.com', 'dXNlcnMvc3VwZXJhZG1pbg', 'dXNlcnMvdGh1bWJuYWlsLXN1cGVyYWRtaW4', 'ADMINISTRATOR', 'INTERNAL', false, 'tester', '{"metadata": {"last_login": 1711812159009, "attachmentContentType": "image/jpeg"}}') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (6, 'wdio.user', '$2a$10$50OSj4ssJr6RKzMp9s.J8e4WRZ6nZeJE2sjUTSl/IYA7xGIJk/Z0a', 'wdio@test.com', NULL, NULL, 'USER', 'INTERNAL', false, 'wdio user', '{"metadata": {"last_login": 1711812609259}}') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (3, 'python.pytest', '$2a$10$Rvdaez7LALxoKcGNXyWhre.lEijbrpSOvNrclK9ulhPbO2F/LTo/K', 'python@pytest.com', NULL, NULL, 'USER', 'INTERNAL', false, 'python pytest user', '{"metadata": {"last_login": 1711812650433}}') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (4, 'python.robot', '$2a$10$47xTK5OhPJduE7UiNthMNutjPIQIoasTQ.QXaQDXNkcMhaciCZ9S.', 'python@robot.com', NULL, NULL, 'USER', 'INTERNAL', false, 'python robot user', '{"metadata": {"last_login": 1711812687462}}') ON CONFLICT DO NOTHING;
INSERT INTO public.users VALUES (5, 'selenium.spring', '$2a$10$OmhmoPsMSuZ3ZpzhOiGDpeVMKwaVNG4JcYTvI9Wo.AjLjPz.A37xm', 'selenium@spring.com', NULL, NULL, 'USER', 'INTERNAL', false, 'selenium spring ', '{"metadata": {"last_login": 1711812727632}}') ON CONFLICT DO NOTHING;


ALTER TABLE public.api_keys OWNER TO rpuser;

CREATE SEQUENCE public.api_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.issue_type_project OWNER TO rpuser;

ALTER SEQUENCE public.api_keys_id_seq OWNER TO rpuser;


ALTER SEQUENCE public.api_keys_id_seq OWNED BY public.api_keys.id;



ALTER TABLE public.project OWNER TO rpuser;



ALTER TABLE public.project_attribute OWNER TO rpuser;

CREATE SEQUENCE public.project_attribute_attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_attribute_attribute_id_seq OWNER TO rpuser;

ALTER SEQUENCE public.project_attribute_attribute_id_seq OWNED BY public.project_attribute.attribute_id;

CREATE SEQUENCE public.project_attribute_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_attribute_project_id_seq OWNER TO rpuser;

ALTER SEQUENCE public.project_attribute_project_id_seq OWNED BY public.project_attribute.project_id;

CREATE SEQUENCE public.project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.project_id_seq OWNER TO rpuser;


ALTER SEQUENCE public.project_id_seq OWNED BY public.project.id;

ALTER TABLE public.project_user OWNER TO rpuser;



ALTER TABLE ONLY public.api_keys ALTER COLUMN id SET DEFAULT nextval('public.api_keys_id_seq'::regclass);

ALTER TABLE ONLY public.project ALTER COLUMN id SET DEFAULT nextval('public.project_id_seq'::regclass);

ALTER TABLE ONLY public.project_attribute ALTER COLUMN attribute_id SET DEFAULT nextval('public.project_attribute_attribute_id_seq'::regclass);

ALTER TABLE ONLY public.project_attribute ALTER COLUMN project_id SET DEFAULT nextval('public.project_attribute_project_id_seq'::regclass);

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);

INSERT INTO public.api_keys VALUES (1, 'wdio', 'CF5A9A671556CCAE1AA803D99CBB2683D1FDEAD5176E346218BA79CDD678FCE1', '2024-03-30 15:30:20.668322', 6, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.api_keys VALUES (2, 'pytest', '8E664C1D4A864375310807B62B6E81610A126D78B940C1D2118330740FEF5770', '2024-03-30 15:31:02.621267', 3, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.api_keys VALUES (3, 'robot', '804DA1EACA56B7923FE626FF3CEAA03DFD218035F6FE65D655AF7088E9B786AF', '2024-03-30 15:31:37.616124', 4, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.api_keys VALUES (4, 'spring', 'E0F2D8CDB82E33425B81D9301EA63F754FDA46DD50A8CBBA0201FB3C6125A225', '2024-03-30 15:32:23.800705', 5, NULL) ON CONFLICT DO NOTHING;


INSERT INTO public.project VALUES (1, 'superadmin_personal', 'PERSONAL', NULL, '2024-03-30 15:21:02.727574', '{"metadata": {"additional_info": ""}}', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (2, 'default_personal', 'PERSONAL', NULL, '2024-03-30 15:21:02.727574', '{"metadata": {"additional_info": ""}}', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (3, 'python_pytest_project', 'INTERNAL', NULL, '2024-03-30 15:23:10.948', NULL, 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (6, 'selenium_spring_project', 'INTERNAL', NULL, '2024-03-30 15:26:22.02', NULL, 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (4, 'python_pytest_personal', 'PERSONAL', NULL, '2024-03-30 15:23:55.231', '{"metadata": {"additional_info": "Personal project of python pytest user"}}', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (5, 'python_robot_project', 'INTERNAL', NULL, '2024-03-30 15:26:07.22', NULL, 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (7, 'webdriverio_automation_framework', 'INTERNAL', NULL, '2024-03-30 15:26:38.869', NULL, 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (8, 'python_robot_personal', 'PERSONAL', NULL, '2024-03-30 15:28:44.662', '{"metadata": {"additional_info": "Personal project of python robot user"}}', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (9, 'selenium_spring_personal', 'PERSONAL', NULL, '2024-03-30 15:29:08.186', '{"metadata": {"additional_info": "Personal project of selenium spring "}}', 0) ON CONFLICT DO NOTHING;
INSERT INTO public.project VALUES (10, 'wdio_user_personal', 'PERSONAL', NULL, '2024-03-30 15:29:32.613', '{"metadata": {"additional_info": "Personal project of wdio user"}}', 0) ON CONFLICT DO NOTHING;


INSERT INTO public.project_attribute VALUES (7, '80', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '80', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '2', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '2', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'false', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'false', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'LAUNCH_NAME', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'LAUNCH_NAME', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (14, 'reportportal@example.com', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (14, 'reportportal@example.com', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '1209600', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '1209600', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 4) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 7) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 9) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (19, 'true', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (12, 'CURRENT_AND_THE_SAME_NAME', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (8, '-1', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (16, 'false', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (3, '7776000', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (18, 'true', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (17, '95', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (10, 'false', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (7, '95', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (2, '7776000', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (1, '86400', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (4, '1209600', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (9, 'false', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (13, 'false', 10) ON CONFLICT DO NOTHING;
INSERT INTO public.project_attribute VALUES (11, 'true', 10) ON CONFLICT DO NOTHING;

INSERT INTO public.project_user VALUES (1, 1, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (2, 2, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (1, 3, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (3, 3, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (3, 4, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (1, 5, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (1, 6, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (1, 7, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (4, 5, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (4, 8, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (5, 6, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (5, 9, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (6, 7, 'MEMBER') ON CONFLICT DO NOTHING;
INSERT INTO public.project_user VALUES (6, 10, 'PROJECT_MANAGER') ON CONFLICT DO NOTHING;


INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (1, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (1, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (1, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (1, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (1, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (2, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (2, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (2, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (2, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (2, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (3, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (3, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (3, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (3, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (3, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (4, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (4, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (4, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (4, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (4, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (5, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (5, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (5, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (5, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (5, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (6, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (6, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (6, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (6, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (6, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (7, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (7, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (7, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (7, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (7, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (8, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (8, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (8, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (8, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (8, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (9, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (9, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (9, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (9, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (9, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (10, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (10, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (10, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (10, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.issue_type_project (project_id, issue_type_id) VALUES (10, 5) ON CONFLICT DO NOTHING;






SELECT pg_catalog.setval('public.api_keys_id_seq', 4, true);


SELECT pg_catalog.setval('public.project_attribute_attribute_id_seq', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 231
-- Name: project_attribute_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rpuser
--

SELECT pg_catalog.setval('public.project_attribute_project_id_seq', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 209
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rpuser
--

SELECT pg_catalog.setval('public.project_id_seq', 10, true);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 213
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rpuser
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- TOC entry 3427 (class 2606 OID 18380)
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- TOC entry 3413 (class 2606 OID 16875)
-- Name: project project_name_key; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_name_key UNIQUE (name);


--
-- TOC entry 3415 (class 2606 OID 16873)
-- Name: project project_pk; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pk PRIMARY KEY (id);


ALTER TABLE ONLY public.issue_type_project
    ADD CONSTRAINT issue_type_project_issue_type_id_fkey FOREIGN KEY (issue_type_id) REFERENCES public.issue_type(id) ON DELETE CASCADE;


--
-- TOC entry 3838 (class 2606 OID 17672)
-- Name: issue_type_project issue_type_project_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.issue_type_project
    ADD CONSTRAINT issue_type_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;
--
-- TOC entry 3425 (class 2606 OID 17064)
-- Name: project_attribute unique_attribute_per_project; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_attribute
    ADD CONSTRAINT unique_attribute_per_project PRIMARY KEY (attribute_id, project_id);


--
-- TOC entry 3430 (class 2606 OID 18382)
-- Name: api_keys users_api_keys_unique; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT users_api_keys_unique UNIQUE (name, user_id);


--
-- TOC entry 3417 (class 2606 OID 16916)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3419 (class 2606 OID 16914)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 3421 (class 2606 OID 16912)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 3423 (class 2606 OID 16921)
-- Name: project_user users_project_pk; Type: CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_user
    ADD CONSTRAINT users_project_pk PRIMARY KEY (user_id, project_id);


--
-- TOC entry 3428 (class 1259 OID 18388)
-- Name: hash_api_keys_idx; Type: INDEX; Schema: public; Owner: rpuser
--

CREATE INDEX hash_api_keys_idx ON public.api_keys USING btree (hash);


--
-- TOC entry 3436 (class 2620 OID 18421)
-- Name: users update_owner_name_on_user_delete; Type: TRIGGER; Schema: public; Owner: rpuser
--

CREATE TRIGGER update_owner_name_on_user_delete AFTER DELETE ON public.users FOR EACH ROW EXECUTE FUNCTION public.change_user_name_on_delete();


--
-- TOC entry 3435 (class 2606 OID 18383)
-- Name: api_keys api_keys_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3433 (class 2606 OID 17065)
-- Name: project_attribute project_attribute_attribute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_attribute
    ADD CONSTRAINT project_attribute_attribute_id_fkey FOREIGN KEY (attribute_id) REFERENCES public.attribute(id) ON DELETE CASCADE;


--
-- TOC entry 3434 (class 2606 OID 17070)
-- Name: project_attribute project_attribute_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_attribute
    ADD CONSTRAINT project_attribute_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- TOC entry 3431 (class 2606 OID 16927)
-- Name: project_user project_user_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_user
    ADD CONSTRAINT project_user_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;


--
-- TOC entry 3432 (class 2606 OID 16922)
-- Name: project_user project_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: rpuser
--

ALTER TABLE ONLY public.project_user
    ADD CONSTRAINT project_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2024-03-30 17:40:02

--
-- PostgreSQL database dump complete
--

