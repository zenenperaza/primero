--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.6

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: primero
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO primero;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: primero
--

COMMENT ON SCHEMA public IS '';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO primero;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO primero;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    service_name character varying NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO primero;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO primero;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO primero;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO primero;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: agencies; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.agencies (
    id integer NOT NULL,
    unique_id character varying,
    agency_code character varying NOT NULL,
    "order" integer DEFAULT 0,
    name_i18n jsonb,
    description_i18n jsonb,
    telephone character varying,
    services character varying[] DEFAULT '{}'::character varying[],
    logo_enabled boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    pdf_logo_option boolean DEFAULT false NOT NULL,
    exclude_agency_from_lookups boolean DEFAULT false NOT NULL,
    terms_of_use_enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.agencies OWNER TO primero;

--
-- Name: agencies_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.agencies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agencies_id_seq OWNER TO primero;

--
-- Name: agencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.agencies_id_seq OWNED BY public.agencies.id;


--
-- Name: agencies_user_groups; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.agencies_user_groups (
    id integer NOT NULL,
    agency_id integer,
    user_group_id integer
);


ALTER TABLE public.agencies_user_groups OWNER TO primero;

--
-- Name: agencies_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.agencies_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.agencies_user_groups_id_seq OWNER TO primero;

--
-- Name: agencies_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.agencies_user_groups_id_seq OWNED BY public.agencies_user_groups.id;


--
-- Name: alerts; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.alerts (
    id integer NOT NULL,
    type character varying,
    alert_for text,
    date date,
    form_sidebar_id character varying,
    unique_id character varying,
    user_id integer,
    agency_id integer,
    record_type character varying,
    record_id uuid,
    send_email boolean DEFAULT false
);


ALTER TABLE public.alerts OWNER TO primero;

--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alerts_id_seq OWNER TO primero;

--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.alerts_id_seq OWNED BY public.alerts.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO primero;

--
-- Name: attachments; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.attachments (
    id bigint NOT NULL,
    attachment_type character varying,
    record_type character varying,
    record_id uuid,
    field_name character varying,
    description character varying,
    date date,
    comments character varying,
    is_current boolean DEFAULT false NOT NULL,
    metadata jsonb
);


ALTER TABLE public.attachments OWNER TO primero;

--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attachments_id_seq OWNER TO primero;

--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.attachments_id_seq OWNED BY public.attachments.id;


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    record_type character varying,
    record_id character varying,
    user_id integer,
    action character varying,
    resource_url character varying,
    "timestamp" timestamp without time zone,
    metadata jsonb
);


ALTER TABLE public.audit_logs OWNER TO primero;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_id_seq OWNER TO primero;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: bulk_exports; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.bulk_exports (
    id integer NOT NULL,
    status character varying,
    owned_by character varying,
    started_on timestamp without time zone,
    completed_on timestamp without time zone,
    format character varying,
    record_type character varying,
    model_range character varying,
    filters jsonb,
    "order" jsonb,
    query character varying,
    match_criteria character varying,
    custom_export_params jsonb,
    file_name character varying,
    password_ciphertext character varying,
    type character varying
);


ALTER TABLE public.bulk_exports OWNER TO primero;

--
-- Name: bulk_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.bulk_exports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bulk_exports_id_seq OWNER TO primero;

--
-- Name: bulk_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.bulk_exports_id_seq OWNED BY public.bulk_exports.id;


--
-- Name: case_relationships; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.case_relationships (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    from_case_id uuid,
    to_case_id uuid,
    relationship_type character varying,
    disabled boolean DEFAULT false NOT NULL,
    "primary" boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.case_relationships OWNER TO primero;

--
-- Name: cases; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.cases (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    matched_tracing_request_id uuid,
    matched_trace_id character varying,
    duplicate_case_id uuid,
    registry_record_id uuid,
    family_id uuid,
    phonetic_data jsonb,
    srch_age integer,
    srch_created_at timestamp without time zone,
    srch_registration_date timestamp without time zone,
    srch_name character varying,
    srch_module_id character varying,
    srch_location_current character varying,
    srch_client_code character varying,
    srch_date_closure timestamp without time zone,
    srch_owned_by character varying,
    srch_owned_by_agency_id character varying,
    srch_owned_by_location character varying,
    srch_last_updated_by character varying,
    srch_record_state boolean DEFAULT false,
    srch_consent_reporting boolean DEFAULT false,
    srch_status character varying,
    srch_risk_level character varying,
    srch_workflow character varying,
    srch_not_edited_by_owner boolean DEFAULT false,
    srch_flagged boolean DEFAULT false,
    srch_approval_status_assessment character varying,
    srch_approval_status_case_plan character varying,
    srch_approval_status_closure character varying,
    srch_approval_status_action_plan character varying,
    srch_approval_status_gbv_closure character varying,
    srch_reassigned_transferred_on timestamp without time zone,
    srch_referred_users_present boolean DEFAULT false,
    srch_has_incidents boolean DEFAULT false,
    srch_transfer_status character varying,
    srch_gender character varying,
    srch_psychsocial_assessment_score_initial integer,
    srch_psychsocial_assessment_score_most_recent integer,
    srch_client_summary_worries_severity_int integer,
    srch_closure_problems_severity_int integer,
    srch_begin_safety_plan_prompt boolean DEFAULT false,
    srch_disability_status_yes_no character varying,
    srch_owned_by_groups character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_agencies character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_transferred_to_users character varying[] DEFAULT '{}'::character varying[],
    srch_transferred_to_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_referred_users character varying[] DEFAULT '{}'::character varying[],
    srch_current_alert_types character varying[] DEFAULT '{}'::character varying[],
    srch_case_plan_due_dates timestamp without time zone[] DEFAULT '{}'::timestamp without time zone[],
    srch_service_due_dates timestamp without time zone[] DEFAULT '{}'::timestamp without time zone[],
    srch_assessment_due_dates timestamp without time zone[] DEFAULT '{}'::timestamp without time zone[],
    srch_followup_due_dates timestamp without time zone[] DEFAULT '{}'::timestamp without time zone[],
    srch_protection_concerns character varying[] DEFAULT '{}'::character varying[],
    srch_protection_risks character varying[] DEFAULT '{}'::character varying[],
    srch_next_steps character varying[] DEFAULT '{}'::character varying[],
    srch_assigned_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_sex character varying,
    srch_identified_by character varying,
    srch_identified_by_full_name character varying,
    srch_identified_at timestamp without time zone
);


ALTER TABLE public.cases OWNER TO primero;

--
-- Name: codes_of_conduct; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.codes_of_conduct (
    id bigint NOT NULL,
    created_on timestamp without time zone,
    created_by character varying,
    title character varying,
    content text
);


ALTER TABLE public.codes_of_conduct OWNER TO primero;

--
-- Name: codes_of_conduct_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.codes_of_conduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.codes_of_conduct_id_seq OWNER TO primero;

--
-- Name: codes_of_conduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.codes_of_conduct_id_seq OWNED BY public.codes_of_conduct.id;


--
-- Name: contact_informations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.contact_informations (
    id integer NOT NULL,
    name character varying,
    organization character varying,
    phone character varying,
    location character varying,
    other_information text,
    support_forum character varying,
    email character varying,
    "position" character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.contact_informations OWNER TO primero;

--
-- Name: contact_informations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.contact_informations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_informations_id_seq OWNER TO primero;

--
-- Name: contact_informations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.contact_informations_id_seq OWNED BY public.contact_informations.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.delayed_jobs (
    id bigint NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying,
    queue character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.delayed_jobs OWNER TO primero;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delayed_jobs_id_seq OWNER TO primero;

--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.delayed_jobs_id_seq OWNED BY public.delayed_jobs.id;


--
-- Name: export_configurations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.export_configurations (
    id integer NOT NULL,
    unique_id character varying,
    export_id character varying,
    name_i18n jsonb,
    property_keys character varying[] DEFAULT '{}'::character varying[],
    record_type character varying DEFAULT 'Child'::character varying,
    opt_out_field character varying,
    property_keys_opt_out character varying[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.export_configurations OWNER TO primero;

--
-- Name: export_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.export_configurations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.export_configurations_id_seq OWNER TO primero;

--
-- Name: export_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.export_configurations_id_seq OWNED BY public.export_configurations.id;


--
-- Name: families; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.families (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    phonetic_data jsonb,
    srch_created_at timestamp without time zone,
    srch_family_registration_date timestamp without time zone,
    srch_status character varying,
    srch_record_state boolean DEFAULT false,
    srch_flagged boolean DEFAULT false,
    srch_not_edited_by_owner boolean DEFAULT false,
    srch_family_location_current character varying,
    srch_owned_by_groups character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_agencies character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_owned_by character varying,
    srch_owned_by_agency_id character varying,
    srch_assigned_user_names character varying[] DEFAULT '{}'::character varying[]
);


ALTER TABLE public.families OWNER TO primero;

--
-- Name: fields; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.fields (
    id integer NOT NULL,
    name character varying,
    type character varying,
    multi_select boolean DEFAULT false NOT NULL,
    form_section_id integer,
    visible boolean DEFAULT true NOT NULL,
    mobile_visible boolean DEFAULT true NOT NULL,
    hide_on_view_page boolean DEFAULT false NOT NULL,
    show_on_minify_form boolean DEFAULT false NOT NULL,
    editable boolean DEFAULT true NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    display_name_i18n jsonb,
    help_text_i18n jsonb,
    guiding_questions_i18n jsonb,
    tally_i18n jsonb,
    tick_box_label_i18n jsonb,
    option_strings_text_i18n jsonb,
    option_strings_source character varying,
    "order" integer,
    hidden_text_field boolean DEFAULT false NOT NULL,
    subform_section_id integer,
    collapsed_field_for_subform_section_id integer,
    autosum_total boolean DEFAULT false NOT NULL,
    autosum_group character varying,
    selected_value character varying,
    link_to_path text,
    link_to_path_external boolean DEFAULT true NOT NULL,
    field_tags character varying[] DEFAULT '{}'::character varying[],
    custom_template character varying,
    expose_unique_id boolean DEFAULT false NOT NULL,
    required boolean DEFAULT false NOT NULL,
    date_validation character varying DEFAULT 'default_date_validation'::character varying,
    date_include_time boolean DEFAULT false NOT NULL,
    matchable boolean DEFAULT false NOT NULL,
    subform_section_configuration jsonb,
    mandatory_for_completion boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    display_conditions_record jsonb,
    display_conditions_subform jsonb,
    collapse character varying,
    option_strings_condition jsonb,
    calculation jsonb,
    subform_summary jsonb
);


ALTER TABLE public.fields OWNER TO primero;

--
-- Name: fields_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fields_id_seq OWNER TO primero;

--
-- Name: fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.fields_id_seq OWNED BY public.fields.id;


--
-- Name: flags; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.flags (
    id integer NOT NULL,
    record_id character varying,
    record_type character varying,
    date date,
    message text,
    flagged_by character varying,
    removed boolean DEFAULT false NOT NULL,
    unflag_message text,
    created_at timestamp without time zone,
    system_generated_followup boolean DEFAULT false NOT NULL,
    unflagged_by character varying,
    unflagged_date date,
    record_uuid uuid
);


ALTER TABLE public.flags OWNER TO primero;

--
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flags_id_seq OWNER TO primero;

--
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.flags_id_seq OWNED BY public.flags.id;


--
-- Name: form_sections; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.form_sections (
    id integer NOT NULL,
    unique_id character varying,
    name_i18n jsonb,
    help_text_i18n jsonb,
    description_i18n jsonb,
    parent_form character varying,
    visible boolean DEFAULT true NOT NULL,
    "order" integer,
    order_form_group integer,
    order_subform integer,
    form_group_keyed boolean DEFAULT false NOT NULL,
    form_group_id character varying,
    editable boolean DEFAULT true NOT NULL,
    core_form boolean DEFAULT false NOT NULL,
    is_nested boolean DEFAULT false NOT NULL,
    is_first_tab boolean DEFAULT false NOT NULL,
    initial_subforms integer,
    subform_prevent_item_removal boolean DEFAULT false NOT NULL,
    subform_append_only boolean DEFAULT false NOT NULL,
    subform_header_links character varying[] DEFAULT '{}'::character varying[],
    display_help_text_view boolean DEFAULT false NOT NULL,
    shared_subform character varying,
    shared_subform_group character varying,
    is_summary_section boolean DEFAULT false NOT NULL,
    hide_subform_placeholder boolean DEFAULT false NOT NULL,
    mobile_form boolean DEFAULT false NOT NULL,
    header_message_link text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    display_conditions jsonb
);


ALTER TABLE public.form_sections OWNER TO primero;

--
-- Name: form_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.form_sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_sections_id_seq OWNER TO primero;

--
-- Name: form_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.form_sections_id_seq OWNED BY public.form_sections.id;


--
-- Name: form_sections_primero_modules; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.form_sections_primero_modules (
    primero_module_id integer,
    form_section_id integer
);


ALTER TABLE public.form_sections_primero_modules OWNER TO primero;

--
-- Name: form_sections_roles; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.form_sections_roles (
    id bigint NOT NULL,
    role_id integer,
    form_section_id integer,
    permission character varying DEFAULT 'rw'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.form_sections_roles OWNER TO primero;

--
-- Name: form_sections_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.form_sections_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.form_sections_roles_id_seq OWNER TO primero;

--
-- Name: form_sections_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.form_sections_roles_id_seq OWNED BY public.form_sections_roles.id;


--
-- Name: group_victims; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.group_victims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.group_victims OWNER TO primero;

--
-- Name: group_victims_violations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.group_victims_violations (
    id bigint NOT NULL,
    violation_id uuid,
    group_victim_id uuid
);


ALTER TABLE public.group_victims_violations OWNER TO primero;

--
-- Name: group_victims_violations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.group_victims_violations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_victims_violations_id_seq OWNER TO primero;

--
-- Name: group_victims_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.group_victims_violations_id_seq OWNED BY public.group_victims_violations.id;


--
-- Name: identity_providers; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.identity_providers (
    id integer NOT NULL,
    name character varying,
    unique_id character varying,
    provider_type character varying,
    configuration jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.identity_providers OWNER TO primero;

--
-- Name: identity_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.identity_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identity_providers_id_seq OWNER TO primero;

--
-- Name: identity_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.identity_providers_id_seq OWNED BY public.identity_providers.id;


--
-- Name: incidents; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.incidents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    incident_case_id uuid,
    phonetic_data jsonb,
    srch_created_at timestamp without time zone,
    srch_incident_date timestamp without time zone,
    srch_incident_location character varying,
    srch_module_id character varying,
    srch_owned_by character varying,
    srch_owned_by_agency_id character varying,
    srch_record_state boolean DEFAULT false,
    srch_flagged boolean DEFAULT false,
    srch_not_edited_by_owner boolean DEFAULT false,
    srch_status character varying,
    srch_age integer,
    srch_owned_by_groups character varying[] DEFAULT '{}'::character varying[],
    srch_transferred_to_users character varying[] DEFAULT '{}'::character varying[],
    srch_transferred_to_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_agencies character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_armed_force_group_party_names character varying[] DEFAULT '{}'::character varying[],
    srch_violation_with_verification_status character varying[] DEFAULT '{}'::character varying[],
    srch_assigned_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_incident_date_derived timestamp without time zone,
    srch_gbv_sexual_violence_type character varying,
    srch_cp_sexual_violence_type character varying,
    srch_owned_by_agency_office character varying,
    srch_unaccompanied_separated_status character varying
);


ALTER TABLE public.incidents OWNER TO primero;

--
-- Name: individual_victims; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.individual_victims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.individual_victims OWNER TO primero;

--
-- Name: individual_victims_violations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.individual_victims_violations (
    id bigint NOT NULL,
    violation_id uuid,
    individual_victim_id uuid
);


ALTER TABLE public.individual_victims_violations OWNER TO primero;

--
-- Name: individual_victims_violations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.individual_victims_violations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.individual_victims_violations_id_seq OWNER TO primero;

--
-- Name: individual_victims_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.individual_victims_violations_id_seq OWNED BY public.individual_victims_violations.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name_i18n jsonb,
    placename_i18n jsonb,
    location_code character varying NOT NULL,
    admin_level integer,
    type character varying,
    disabled boolean DEFAULT false NOT NULL,
    hierarchy_path public.ltree DEFAULT ''::public.ltree NOT NULL
);


ALTER TABLE public.locations OWNER TO primero;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO primero;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: lookups; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.lookups (
    id integer NOT NULL,
    unique_id character varying,
    name_i18n jsonb,
    lookup_values_i18n jsonb,
    locked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.lookups OWNER TO primero;

--
-- Name: lookups_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.lookups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lookups_id_seq OWNER TO primero;

--
-- Name: lookups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.lookups_id_seq OWNED BY public.lookups.id;


--
-- Name: perpetrators; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.perpetrators (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.perpetrators OWNER TO primero;

--
-- Name: perpetrators_violations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.perpetrators_violations (
    id bigint NOT NULL,
    violation_id uuid,
    perpetrator_id uuid
);


ALTER TABLE public.perpetrators_violations OWNER TO primero;

--
-- Name: perpetrators_violations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.perpetrators_violations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perpetrators_violations_id_seq OWNER TO primero;

--
-- Name: perpetrators_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.perpetrators_violations_id_seq OWNED BY public.perpetrators_violations.id;


--
-- Name: primero_configurations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.primero_configurations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying,
    description character varying,
    version character varying,
    created_by character varying,
    created_on timestamp without time zone,
    applied_by character varying,
    applied_on timestamp without time zone,
    data jsonb DEFAULT '{}'::jsonb,
    primero_version character varying
);


ALTER TABLE public.primero_configurations OWNER TO primero;

--
-- Name: primero_modules; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.primero_modules (
    id integer NOT NULL,
    unique_id character varying,
    primero_program_id integer,
    name jsonb DEFAULT '{}'::jsonb,
    description jsonb DEFAULT '{}'::jsonb,
    associated_record_types character varying[],
    core_resource boolean DEFAULT true,
    field_map jsonb,
    module_options jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.primero_modules OWNER TO primero;

--
-- Name: primero_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.primero_modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.primero_modules_id_seq OWNER TO primero;

--
-- Name: primero_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.primero_modules_id_seq OWNED BY public.primero_modules.id;


--
-- Name: primero_modules_roles; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.primero_modules_roles (
    role_id integer,
    primero_module_id integer
);


ALTER TABLE public.primero_modules_roles OWNER TO primero;

--
-- Name: primero_modules_saved_searches; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.primero_modules_saved_searches (
    id integer NOT NULL,
    primero_module_id integer,
    saved_search_id integer
);


ALTER TABLE public.primero_modules_saved_searches OWNER TO primero;

--
-- Name: primero_modules_saved_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.primero_modules_saved_searches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.primero_modules_saved_searches_id_seq OWNER TO primero;

--
-- Name: primero_modules_saved_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.primero_modules_saved_searches_id_seq OWNED BY public.primero_modules_saved_searches.id;


--
-- Name: primero_programs; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.primero_programs (
    id integer NOT NULL,
    unique_id character varying,
    name_i18n jsonb,
    description_i18n jsonb,
    start_date date,
    end_date date,
    core_resource boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.primero_programs OWNER TO primero;

--
-- Name: primero_programs_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.primero_programs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.primero_programs_id_seq OWNER TO primero;

--
-- Name: primero_programs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.primero_programs_id_seq OWNED BY public.primero_programs.id;


--
-- Name: record_histories; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.record_histories (
    id integer NOT NULL,
    record_id character varying,
    record_type character varying,
    datetime timestamp without time zone,
    user_name character varying,
    action character varying,
    record_changes jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.record_histories OWNER TO primero;

--
-- Name: record_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.record_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.record_histories_id_seq OWNER TO primero;

--
-- Name: record_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.record_histories_id_seq OWNED BY public.record_histories.id;


--
-- Name: registry_records; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.registry_records (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    phonetic_data jsonb,
    srch_created_at timestamp without time zone,
    srch_registration_date timestamp without time zone,
    srch_status character varying,
    srch_record_state boolean DEFAULT false,
    srch_location_current character varying,
    srch_not_edited_by_owner boolean DEFAULT false,
    srch_owned_by_groups character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_agencies character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_owned_by character varying,
    srch_owned_by_agency_id character varying,
    srch_assigned_user_names character varying[] DEFAULT '{}'::character varying[]
);


ALTER TABLE public.registry_records OWNER TO primero;

--
-- Name: reports; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    name_i18n jsonb,
    description_i18n jsonb,
    module_id character varying,
    record_type character varying,
    aggregate_by character varying[] DEFAULT '{}'::character varying[],
    disaggregate_by character varying[] DEFAULT '{}'::character varying[],
    aggregate_counts_from character varying,
    filters jsonb[] DEFAULT '{}'::jsonb[],
    group_ages boolean DEFAULT false NOT NULL,
    group_dates_by character varying DEFAULT 'date'::character varying,
    is_graph boolean DEFAULT false NOT NULL,
    editable boolean DEFAULT true,
    unique_id character varying,
    disabled boolean DEFAULT false NOT NULL,
    exclude_empty_rows boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reports OWNER TO primero;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reports_id_seq OWNER TO primero;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: responses; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.responses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    violation_id uuid
);


ALTER TABLE public.responses OWNER TO primero;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    unique_id character varying,
    name character varying,
    description character varying,
    permissions jsonb,
    group_permission character varying DEFAULT 'self'::character varying,
    referral boolean DEFAULT false NOT NULL,
    transfer boolean DEFAULT false NOT NULL,
    is_manager boolean DEFAULT false NOT NULL,
    reporting_location_level integer,
    disabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    referral_authorization boolean DEFAULT false NOT NULL,
    user_category character varying
);


ALTER TABLE public.roles OWNER TO primero;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO primero;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: saved_searches; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.saved_searches (
    id integer NOT NULL,
    name character varying,
    record_type character varying,
    user_id integer,
    filters jsonb
);


ALTER TABLE public.saved_searches OWNER TO primero;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.saved_searches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saved_searches_id_seq OWNER TO primero;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.saved_searches_id_seq OWNED BY public.saved_searches.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO primero;

--
-- Name: searchable_identifiers; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.searchable_identifiers (
    id bigint NOT NULL,
    record_type character varying,
    record_id uuid,
    field_name character varying,
    value character varying
);


ALTER TABLE public.searchable_identifiers OWNER TO primero;

--
-- Name: searchable_identifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.searchable_identifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.searchable_identifiers_id_seq OWNER TO primero;

--
-- Name: searchable_identifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.searchable_identifiers_id_seq OWNED BY public.searchable_identifiers.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    session_id character varying NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    expired boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO primero;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO primero;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.sources (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.sources OWNER TO primero;

--
-- Name: sources_violations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.sources_violations (
    id bigint NOT NULL,
    violation_id uuid,
    source_id uuid
);


ALTER TABLE public.sources_violations OWNER TO primero;

--
-- Name: sources_violations_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.sources_violations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sources_violations_id_seq OWNER TO primero;

--
-- Name: sources_violations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.sources_violations_id_seq OWNED BY public.sources_violations.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.system_settings (
    id integer NOT NULL,
    default_locale character varying DEFAULT 'en'::character varying,
    locales character varying[] DEFAULT '{en}'::character varying[],
    base_language character varying DEFAULT 'en'::character varying,
    case_code_format character varying[] DEFAULT '{}'::character varying[],
    case_code_separator character varying,
    auto_populate_list jsonb[] DEFAULT '{}'::jsonb[],
    unhcr_needs_codes_mapping jsonb,
    reporting_location_config jsonb,
    age_ranges jsonb,
    welcome_email_text_i18n jsonb,
    primary_age_range character varying,
    location_limit_for_api character varying,
    approval_forms_to_alert jsonb,
    changes_field_to_form jsonb,
    export_config_id jsonb,
    duplicate_export_field character varying,
    primero_version character varying,
    system_options jsonb,
    approvals_labels_i18n jsonb,
    config_update_lock boolean DEFAULT false NOT NULL,
    configuration_file_version character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    incident_reporting_location_config jsonb
);


ALTER TABLE public.system_settings OWNER TO primero;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.system_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.system_settings_id_seq OWNER TO primero;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: themes; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.themes (
    id bigint NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    disabled boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.themes OWNER TO primero;

--
-- Name: themes_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.themes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_id_seq OWNER TO primero;

--
-- Name: themes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.themes_id_seq OWNED BY public.themes.id;


--
-- Name: traces; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.traces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    tracing_request_id uuid,
    matched_case_id uuid
);


ALTER TABLE public.traces OWNER TO primero;

--
-- Name: tracing_requests; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.tracing_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    phonetic_data jsonb,
    srch_created_at timestamp without time zone,
    srch_inquiry_date timestamp without time zone,
    srch_status character varying,
    srch_record_state boolean DEFAULT false,
    srch_flagged boolean DEFAULT false,
    srch_not_edited_by_owner boolean DEFAULT false,
    srch_owned_by_groups character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_agencies character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_names character varying[] DEFAULT '{}'::character varying[],
    srch_associated_user_groups character varying[] DEFAULT '{}'::character varying[],
    srch_owned_by character varying,
    srch_owned_by_agency_id character varying,
    srch_assigned_user_names character varying[] DEFAULT '{}'::character varying[]
);


ALTER TABLE public.tracing_requests OWNER TO primero;

--
-- Name: transitions; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.transitions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying,
    status character varying,
    record_id character varying,
    record_type character varying,
    transitioned_to character varying,
    transitioned_to_remote character varying,
    transitioned_to_agency character varying,
    rejected_reason character varying,
    notes text,
    transitioned_by character varying,
    service character varying,
    service_record_id character varying,
    remote boolean DEFAULT false NOT NULL,
    type_of_export character varying,
    consent_overridden boolean DEFAULT false NOT NULL,
    consent_individual_transfer boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    responded_at timestamp without time zone,
    rejection_note text,
    record_owned_by character varying,
    record_owned_by_agency character varying,
    record_owned_by_groups character varying[],
    transitioned_by_user_agency character varying,
    transitioned_by_user_groups character varying[],
    transitioned_to_user_agency character varying,
    transitioned_to_user_groups character varying[],
    authorized_role_unique_id character varying,
    allow_case_creation boolean DEFAULT false NOT NULL
);


ALTER TABLE public.transitions OWNER TO primero;

--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.user_groups (
    id integer NOT NULL,
    unique_id character varying,
    name character varying,
    description character varying,
    core_resource boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_groups OWNER TO primero;

--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_groups_id_seq OWNER TO primero;

--
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.user_groups_id_seq OWNED BY public.user_groups.id;


--
-- Name: user_groups_users; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.user_groups_users (
    id integer NOT NULL,
    user_id integer,
    user_group_id integer
);


ALTER TABLE public.user_groups_users OWNER TO primero;

--
-- Name: user_groups_users_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.user_groups_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_groups_users_id_seq OWNER TO primero;

--
-- Name: user_groups_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.user_groups_users_id_seq OWNED BY public.user_groups_users.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying,
    user_name character varying,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    code character varying,
    phone character varying,
    email character varying,
    agency_id integer,
    "position" character varying,
    location character varying,
    reporting_location_code character varying,
    role_id integer,
    time_zone character varying DEFAULT 'UTC'::character varying,
    locale character varying,
    send_mail boolean DEFAULT true,
    disabled boolean DEFAULT false,
    services character varying[],
    agency_office character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    identity_provider_id integer,
    identity_provider_sync jsonb,
    failed_attempts integer DEFAULT 0,
    unlock_token character varying,
    locked_at timestamp without time zone,
    service_account boolean DEFAULT false NOT NULL,
    code_of_conduct_accepted_on timestamp without time zone,
    code_of_conduct_id bigint,
    receive_webpush boolean,
    settings jsonb,
    unverified boolean DEFAULT false,
    registration_stream character varying,
    data_processing_consent_provided_on timestamp without time zone,
    self_registered boolean DEFAULT false,
    duplicate boolean DEFAULT false
);


ALTER TABLE public.users OWNER TO primero;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO primero;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: violations; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.violations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    data jsonb DEFAULT '{}'::jsonb,
    incident_id uuid,
    source_id uuid
);


ALTER TABLE public.violations OWNER TO primero;

--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.webhooks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    events jsonb DEFAULT '[]'::jsonb,
    url character varying,
    auth_type character varying,
    auth_secret_encrypted character varying,
    role_unique_id character varying,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.webhooks OWNER TO primero;

--
-- Name: webpush_subscriptions; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.webpush_subscriptions (
    id bigint NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    notification_url character varying NOT NULL,
    auth character varying NOT NULL,
    p256dh character varying NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.webpush_subscriptions OWNER TO primero;

--
-- Name: webpush_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.webpush_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webpush_subscriptions_id_seq OWNER TO primero;

--
-- Name: webpush_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.webpush_subscriptions_id_seq OWNED BY public.webpush_subscriptions.id;


--
-- Name: whitelisted_jwts; Type: TABLE; Schema: public; Owner: primero
--

CREATE TABLE public.whitelisted_jwts (
    id bigint NOT NULL,
    jti character varying NOT NULL,
    aud character varying,
    exp timestamp without time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.whitelisted_jwts OWNER TO primero;

--
-- Name: whitelisted_jwts_id_seq; Type: SEQUENCE; Schema: public; Owner: primero
--

CREATE SEQUENCE public.whitelisted_jwts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whitelisted_jwts_id_seq OWNER TO primero;

--
-- Name: whitelisted_jwts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: primero
--

ALTER SEQUENCE public.whitelisted_jwts_id_seq OWNED BY public.whitelisted_jwts.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: agencies id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies ALTER COLUMN id SET DEFAULT nextval('public.agencies_id_seq'::regclass);


--
-- Name: agencies_user_groups id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies_user_groups ALTER COLUMN id SET DEFAULT nextval('public.agencies_user_groups_id_seq'::regclass);


--
-- Name: alerts id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.alerts ALTER COLUMN id SET DEFAULT nextval('public.alerts_id_seq'::regclass);


--
-- Name: attachments id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.attachments ALTER COLUMN id SET DEFAULT nextval('public.attachments_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: bulk_exports id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.bulk_exports ALTER COLUMN id SET DEFAULT nextval('public.bulk_exports_id_seq'::regclass);


--
-- Name: codes_of_conduct id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.codes_of_conduct ALTER COLUMN id SET DEFAULT nextval('public.codes_of_conduct_id_seq'::regclass);


--
-- Name: contact_informations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.contact_informations ALTER COLUMN id SET DEFAULT nextval('public.contact_informations_id_seq'::regclass);


--
-- Name: delayed_jobs id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.delayed_jobs ALTER COLUMN id SET DEFAULT nextval('public.delayed_jobs_id_seq'::regclass);


--
-- Name: export_configurations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.export_configurations ALTER COLUMN id SET DEFAULT nextval('public.export_configurations_id_seq'::regclass);


--
-- Name: fields id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);


--
-- Name: flags id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.flags ALTER COLUMN id SET DEFAULT nextval('public.flags_id_seq'::regclass);


--
-- Name: form_sections id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections ALTER COLUMN id SET DEFAULT nextval('public.form_sections_id_seq'::regclass);


--
-- Name: form_sections_roles id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_roles ALTER COLUMN id SET DEFAULT nextval('public.form_sections_roles_id_seq'::regclass);


--
-- Name: group_victims_violations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.group_victims_violations ALTER COLUMN id SET DEFAULT nextval('public.group_victims_violations_id_seq'::regclass);


--
-- Name: identity_providers id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.identity_providers ALTER COLUMN id SET DEFAULT nextval('public.identity_providers_id_seq'::regclass);


--
-- Name: individual_victims_violations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.individual_victims_violations ALTER COLUMN id SET DEFAULT nextval('public.individual_victims_violations_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: lookups id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.lookups ALTER COLUMN id SET DEFAULT nextval('public.lookups_id_seq'::regclass);


--
-- Name: perpetrators_violations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.perpetrators_violations ALTER COLUMN id SET DEFAULT nextval('public.perpetrators_violations_id_seq'::regclass);


--
-- Name: primero_modules id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules ALTER COLUMN id SET DEFAULT nextval('public.primero_modules_id_seq'::regclass);


--
-- Name: primero_modules_saved_searches id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_saved_searches ALTER COLUMN id SET DEFAULT nextval('public.primero_modules_saved_searches_id_seq'::regclass);


--
-- Name: primero_programs id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_programs ALTER COLUMN id SET DEFAULT nextval('public.primero_programs_id_seq'::regclass);


--
-- Name: record_histories id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.record_histories ALTER COLUMN id SET DEFAULT nextval('public.record_histories_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: saved_searches id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.saved_searches ALTER COLUMN id SET DEFAULT nextval('public.saved_searches_id_seq'::regclass);


--
-- Name: searchable_identifiers id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.searchable_identifiers ALTER COLUMN id SET DEFAULT nextval('public.searchable_identifiers_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: sources_violations id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sources_violations ALTER COLUMN id SET DEFAULT nextval('public.sources_violations_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: themes id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.themes ALTER COLUMN id SET DEFAULT nextval('public.themes_id_seq'::regclass);


--
-- Name: user_groups id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups ALTER COLUMN id SET DEFAULT nextval('public.user_groups_id_seq'::regclass);


--
-- Name: user_groups_users id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups_users ALTER COLUMN id SET DEFAULT nextval('public.user_groups_users_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: webpush_subscriptions id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.webpush_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.webpush_subscriptions_id_seq'::regclass);


--
-- Name: whitelisted_jwts id; Type: DEFAULT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.whitelisted_jwts ALTER COLUMN id SET DEFAULT nextval('public.whitelisted_jwts_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
19	file	Attachment	1	19	2026-06-03 20:42:51.619112
21	location_file	SystemSettings	1	21	2026-06-05 13:08:14.522541
22	logo_full	Agency	2	22	2026-06-05 13:14:36.292628
23	logo_icon	Agency	2	23	2026-06-05 13:14:36.319982
24	terms_of_use	Agency	2	24	2026-06-05 13:20:36.018046
25	logo_full	Agency	1	25	2026-06-05 13:25:06.518789
26	logo_icon	Agency	1	26	2026-06-05 13:25:06.545943
31	unused_fields_report_file	SystemSettings	1	31	2026-06-09 20:11:38.836986
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, byte_size, checksum, created_at, service_name) FROM stdin;
2	d5nanvapjit2zt1mbzq3qh5onwfi	unicef-full.png	image/png	{"identified":true,"width":366,"height":75,"analyzed":true}	8552	7WLK7ZmUhn3mrMgDO2qsWw==	2026-04-22 19:33:52.187534	local
3	gm6s2ng9ts39nj85qk5y93cpju6l	unicef-icon.png	image/png	{"identified":true,"width":88,"height":73,"analyzed":true}	5879	9RpbjDwFJdWQsPJ+fzrk4w==	2026-04-22 19:33:52.209671	local
4	wkpnvc5pz4ui8gb80nikg5eaadpr	Captura de pantalla 2026-04-21 165030.png	image/png	{"identified":true,"width":600,"height":274,"analyzed":true}	126728	P48FAxFyvxVn8ucYtjzI1w==	2026-04-22 19:39:07.987009	local
5	kntp7m02rcjtvdchnyudbz39sr41	Captura de pantalla 2026-04-21 165030.png	image/png	{"identified":true,"width":600,"height":274,"analyzed":true}	126728	P48FAxFyvxVn8ucYtjzI1w==	2026-04-22 19:39:07.9917	local
19	n5m3sny2dv2y4eph1589ytnosxzn	Captura de pantalla 2026-06-03 160301.png	image/png	{"identified":true,"width":1903,"height":967,"analyzed":true}	164103	Zw9P4fLaZDkgftnntC3mww==	2026-06-03 20:42:51.615691	local
8	hy30rupfxvcvkg5rr1b1nz4pk1sp	unicef-full.png	image/png	{"identified":true,"width":366,"height":75,"analyzed":true}	8552	7WLK7ZmUhn3mrMgDO2qsWw==	2026-05-26 12:56:59.150777	local
9	w7o1vcvmwpspn0qghz0y6hrbg4xc	unicef-icon.png	image/png	{"identified":true,"width":88,"height":73,"analyzed":true}	5879	9RpbjDwFJdWQsPJ+fzrk4w==	2026-05-26 12:56:59.17541	local
12	fhs9zlw07t1wm47ylao57ysmxbpj	unicef-icon.png	image/png	{"identified":true,"width":88,"height":73,"analyzed":true}	5879	9RpbjDwFJdWQsPJ+fzrk4w==	2026-06-01 20:20:36.334483	local
11	gpfqh3anfw8ogbggdcl3tr3c6dh4	unicef-full.png	image/png	{"identified":true,"width":366,"height":75,"analyzed":true}	8552	7WLK7ZmUhn3mrMgDO2qsWw==	2026-06-01 20:20:36.316019	local
13	tedm7w17pvqm4a1mgtmaef9sapdw	locations.json	application/json	{"identified":true,"analyzed":true}	60679	3QFWCPLFMc3yqmk+bJiqoA==	2026-06-01 20:20:37.761974	local
16	4a36vyyukeujqvgi0i2qz4g89jlp	@ASONACOPVENEZUELA (1) - copia.png	image/png	{"identified":true,"width":150,"height":150,"analyzed":true}	17380	YYeuUdKYC/CkcAsE09yfRA==	2026-06-02 20:24:39.175669	local
17	i10bz8a72ubjw5pialciyv5k95en	asonacop - copia.png	image/png	{"identified":true,"width":150,"height":89,"analyzed":true}	12323	pMSPnXfl+ixwHZ1hzhJarw==	2026-06-02 20:24:39.184243	local
21	cl6q1trn3fpd35yzro6u3af3a5se	locations.json	application/json	{"identified":true,"analyzed":true}	60703	TdzEmDaP0CPlnlZAM5EUzA==	2026-06-05 13:08:14.519155	local
22	qh1uxv0imnwf5e2z6coih174vrue	@ASONACOPVENEZUELA (1) - copia.png	image/png	{"identified":true,"width":150,"height":150,"analyzed":true}	17380	YYeuUdKYC/CkcAsE09yfRA==	2026-06-05 13:14:36.290027	local
23	ziy2j269n1rrhnpz6sre8iibdtfc	asonacop logo.png	image/png	{"identified":true,"width":600,"height":356,"analyzed":true}	86952	tZFxRCiezIrAjDeUNkSimg==	2026-06-05 13:14:36.317872	local
24	zpaj8h3ph97b4cm3rc7wr0idl0jy	TÉRMINOS DE USO DEL SISTEMA PRIMERO V2.pdf	application/pdf	{"identified":true,"analyzed":true}	70351	mdwGpL6rs715VHlgujUM/w==	2026-06-05 13:20:36.014827	local
25	4mpuzdv3p9v00o81jcls7p6ala3n	unicef-full.png	image/png	{"identified":true,"width":366,"height":75,"analyzed":true}	14988	RKhqIjOd1tSLeuylFMDlSg==	2026-06-05 13:25:06.516427	local
26	lw4s363buz5z0728ts28autrfmlt	unicef-icon.png	image/png	{"identified":true,"width":88,"height":73,"analyzed":true}	8333	DhXWJOMBHOCzcVa77HVUcw==	2026-06-05 13:25:06.543829	local
31	r18ir1otnir2ruc6peo3gvasdvxc	unused_fields_report_20260609.113811794.xlsx	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	{"identified":true,"analyzed":true}	9319	SAJ/3QUxElWkNnvRGDLhNw==	2026-06-09 20:11:38.828936	local
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: agencies; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.agencies (id, unique_id, agency_code, "order", name_i18n, description_i18n, telephone, services, logo_enabled, disabled, pdf_logo_option, exclude_agency_from_lookups, terms_of_use_enabled, created_at, updated_at) FROM stdin;
2	LRF	LRF	0	{"en": "ASONACOP", "es": "ASONACOP"}	{"en": "Programa de Localización y Reunificación Familiar", "es": "Programa de Localización y Reunificación Familiar"}	\N	{family_seunification_service}	t	f	t	f	t	2026-06-02 20:09:05.195106	2026-06-05 13:20:36.020974
1	UNICEF	UNICEF	0	{"en": "UNICEF", "es": "UNICEF"}	{"ar": "", "en": "UNICEF es el Fondo de las Naciones Unidas para la Infancia. Su trabajo se rige por la Convención sobre los Derechos del Niño, y tiene como objetivo que los derechos de niños, niñas y adolescentes sean una realidad en Venezuela y el mundo. ", "es": "", "fr": ""}	\N	{safehouse_service,family_seunification_service}	t	f	f	f	f	2026-04-22 19:33:52.14671	2026-06-05 13:25:29.477879
\.


--
-- Data for Name: agencies_user_groups; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.agencies_user_groups (id, agency_id, user_group_id) FROM stdin;
1	1	3
3	2	2
21	2	21
24	2	24
28	2	28
\.


--
-- Data for Name: alerts; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.alerts (id, type, alert_for, date, form_sidebar_id, unique_id, user_id, agency_id, record_type, record_id, send_email) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2026-04-22 19:33:45.072685	2026-04-22 19:33:45.072685
schema_sha1	e695f64f4c49cf1dca785b8ac0c2e2161a3d648e	2026-04-22 19:33:45.081342	2026-04-22 19:33:45.081342
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.attachments (id, attachment_type, record_type, record_id, field_name, description, date, comments, is_current, metadata) FROM stdin;
1	document	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	ftr_documents	cedula	2026-06-03	cedula	t	\N
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.audit_logs (id, record_type, record_id, user_id, action, resource_url, "timestamp", metadata) FROM stdin;
1	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-04-22 19:34:15.44468	{"remote_ip": "172.18.0.1", "user_name": "admin"}
2	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-04-22 19:34:20.473877	{"remote_ip": "172.18.0.1", "user_name": "admin"}
3	User	12	12	login	https://localhost/api/v2/tokens	2026-04-22 19:35:30.566267	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
4	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-04-22 19:35:30.590353	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
5	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-04-22 19:35:30.610991	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
6	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-04-22 19:35:30.631895	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
7	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-04-22 19:35:30.651145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
8	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-04-22 19:35:30.671074	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
9	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-04-22 19:35:30.686806	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
10	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-04-22 19:35:30.70145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
11	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-04-22 19:35:30.71486	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
12	User	12	12	show	https://localhost/api/v2/users/12	2026-04-22 19:35:40.733076	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
13	Role	\N	12	list	https://localhost/api/v2/roles	2026-04-22 19:35:40.749544	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
14	Incident	\N	12	index	https://localhost/api/v2/incidents?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-04-22 19:35:40.765293	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
15	Family	\N	12	index	https://localhost/api/v2/families?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-04-22 19:35:45.793424	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
16	BulkExport	\N	12	index	https://localhost/api/v2/exports?page=1&per=20	2026-04-22 19:35:45.816475	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
17	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-22 19:35:45.834084	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
18	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:35:45.849102	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
19	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-04-22 19:35:45.865883	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
20	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-04-22 19:35:50.890786	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
21	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-22 19:36:00.928561	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
22	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:36:00.949354	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
23	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-04-22 19:36:00.966607	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
24	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-04-22 19:36:05.99401	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
25	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:36:06.013163	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
26	Role	\N	12	list	https://localhost/api/v2/roles	2026-04-22 19:36:06.031659	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
27	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-04-22 19:37:41.137974	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
28	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-04-22 19:37:46.169749	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
29	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-04-22 19:38:46.228547	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
30	Agency	1	12	update	https://localhost/api/v2/agencies/1	2026-04-22 19:39:11.418119	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "PATCH"}
31	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-04-22 19:39:11.434804	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
32	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-04-22 19:39:16.462895	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
33	UserGroup	1	12	show	https://localhost/api/v2/user_groups/1	2026-04-22 19:39:16.48421	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
34	UserGroup	1	12	show	https://localhost/api/v2/user_groups/1	2026-04-22 19:39:21.504176	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
35	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-04-22 19:39:26.529572	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
36	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&total=1&per=20&page=1&locale=es&managed=true	2026-04-22 19:39:31.560308	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
37	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&total=1&per=20&page=1&locale=es&managed=true	2026-04-22 19:39:31.581095	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
38	Agency	\N	12	index	https://localhost/api/v2/agencies?total=1&per=20&page=1&locale=es&managed=true	2026-04-22 19:39:41.612126	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
39	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-04-22 19:39:41.636961	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
40	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-04-22 19:39:56.668526	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
41	Lookup	\N	12	index	https://localhost/api/v2/lookups?locale=es&page=1&per=20	2026-04-22 19:40:11.702382	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
42	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-04-22 19:40:11.724999	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
43	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&total=4&per=20&page=1&hierarchy=true	2026-04-22 19:40:11.746428	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
44	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=4&per=20&page=1&locale=es&hierarchy=true	2026-04-22 19:40:21.773078	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
45	Location	\N	12	index	https://localhost/api/v2/locations?total=4&per=20&page=1&locale=es&hierarchy=true	2026-04-22 19:40:21.790869	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
46	PrimeroConfiguration	\N	12	index	https://localhost/api/v2/configurations?page=1&per=20	2026-04-22 19:40:31.823048	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
47	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-04-22 19:40:36.848781	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
48	Role	1	12	show	https://localhost/api/v2/roles/1	2026-04-22 19:40:41.877717	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
49	Role	\N	12	list	https://localhost/api/v2/roles	2026-04-22 19:40:41.897886	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
50	Role	1	12	show	https://localhost/api/v2/roles/1	2026-04-22 19:40:51.928621	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
51	Role	\N	12	list	https://localhost/api/v2/roles	2026-04-22 19:40:51.947216	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
52	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=12&per=20&page=1&managed=true	2026-04-22 19:41:06.97273	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
53	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-22 19:41:06.990644	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
54	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:41:07.008829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
55	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=12&per=20&page=1&total_enabled=12	2026-04-22 19:41:07.030546	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
56	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-04-22 19:41:22.066601	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
57	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:41:22.088128	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
58	Role	\N	12	list	https://localhost/api/v2/roles	2026-04-22 19:41:22.105576	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
59	Family	\N	12	index	https://localhost/api/v2/families?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-04-22 19:43:27.223651	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
60	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-04-22 19:43:57.283555	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
61	Report	\N	12	list	https://localhost/api/v2/reports	2026-04-22 19:44:02.306759	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
62	Report	1	12	show	https://localhost/api/v2/reports/1	2026-04-22 19:44:02.329166	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
63	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-04-22 19:44:07.348031	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
64	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-04-22 19:44:07.36369	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
65	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-22 19:44:12.385741	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
66	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 19:44:12.406847	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
67	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=12&per=20&page=1&total_enabled=12	2026-04-22 19:44:12.425744	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
68	PrimeroConfiguration	\N	12	index	https://localhost/api/v2/configurations?total=0&per=20&page=1	2026-04-22 19:44:22.465949	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
69	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-04-22 19:44:27.492445	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
70	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-04-22 19:44:27.50893	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
71	User	12	12	login	https://localhost/api/v2/tokens	2026-04-22 20:03:03.758418	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
72	Family	\N	12	index	https://localhost/api/v2/families?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-04-22 20:03:08.788566	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
73	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-22 20:03:23.82659	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
74	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-22 20:03:23.843633	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
75	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-04-22 20:03:23.861757	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
76	User	12	12	login	https://localhost/api/v2/tokens	2026-04-22 20:05:29.042905	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
77	User	12	12	login	https://localhost/api/v2/tokens	2026-04-23 12:27:20.951092	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
78	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-04-23 12:27:21.014938	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
79	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-04-23 12:27:21.042884	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
80	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-04-23 12:27:21.069108	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
81	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-04-23 12:27:21.103731	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
82	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-04-23 12:27:21.14264	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
83	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-04-23 12:27:21.169654	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
84	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-04-23 12:27:21.196289	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
85	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-04-23 12:27:21.227386	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
86	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-04-23 12:27:31.267549	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
87	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-04-23 12:27:31.296362	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
88	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-04-23 12:27:31.328099	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
89	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-04-23 12:27:36.463848	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
90	Location	\N	12	index	https://localhost/api/v2/locations?locale=es&page=1&hierarchy=true	2026-04-23 12:27:41.510258	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
91	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-04-23 12:52:33.285492	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
92	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:26:44.460076	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
93	User	13	13	show	https://localhost/api/v2/users/13?extended=true	2026-06-01 20:26:44.490569	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": ["13"], "http_method": "GET"}
94	SystemSettings	\N	13	index	https://localhost/api/v2/system_settings?extended=true	2026-06-01 20:26:44.509487	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
95	Lookup	\N	13	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:26:44.52633	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
96	Permission	\N	13	list	https://localhost/api/v2/permissions	2026-06-01 20:26:44.545369	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
97	FormSection	\N	13	list	https://localhost/api/v2/forms	2026-06-01 20:26:44.563283	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
98	Alert	\N	13	bulk_index	https://localhost/api/v2/alerts	2026-06-01 20:26:44.580261	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
99	User	12	12	login	https://localhost/api/v2/tokens	2026-06-01 20:27:09.618948	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
100	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-01 20:27:09.636191	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
101	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-01 20:27:09.66107	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
102	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-01 20:27:09.677167	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
103	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:27:09.700393	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
104	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-01 20:27:09.715621	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
105	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:27:09.730523	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
106	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-01 20:27:09.744835	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
107	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-01 20:27:09.760602	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
108	User	12	12	show	https://localhost/api/v2/users/12	2026-06-01 20:27:14.783173	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
109	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-01 20:27:14.79903	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
110	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-01 20:27:19.828084	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
111	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-01 20:27:19.857963	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
112	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-01 20:27:19.882661	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
113	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-01 20:27:29.923753	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
114	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-01 20:27:34.948429	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
115	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:28:35.750304	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
116	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:29:10.802167	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
117	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:29:30.833899	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
118	TracingRequest	\N	13	index	https://localhost/api/v2/tracing_requests?per=1&page=1	2026-06-01 20:29:30.852027	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
119	User	12	12	login	https://localhost/api/v2/tokens	2026-06-01 20:31:00.937407	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
120	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-01 20:31:00.958858	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
232	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 14:47:53.889563	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
121	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-01 20:31:00.988813	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
122	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-01 20:31:01.008665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
123	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:31:01.029516	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
124	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:31:01.046052	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
125	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-01 20:31:01.065826	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
126	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-01 20:31:01.083431	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
127	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-01 20:31:01.103884	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
128	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-01 20:31:06.125838	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
129	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-01 20:31:06.177534	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
130	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-01 20:31:06.196567	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
131	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-01 20:39:51.930479	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
132	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-01 20:39:51.996333	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
133	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-01 20:39:52.034554	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
134	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-01 20:39:57.08208	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
135	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-01 20:40:07.122874	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
136	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:40:12.15839	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
137	TracingRequest	\N	13	index	https://localhost/api/v2/tracing_requests?per=1&page=1	2026-06-01 20:40:12.182538	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
138	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-01 20:44:17.479315	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
139	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-01 20:44:42.528061	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
140	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-01 20:44:42.607554	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
141	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-01 20:44:42.64557	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
142	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:44:47.682872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
143	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:44:57.747672	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
144	FormSection	32	12	show	https://localhost/api/v2/forms/32	2026-06-01 20:44:57.776787	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["32"], "http_method": "GET"}
145	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:44:57.804991	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
146	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:46:33.019316	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
147	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-01 20:46:33.06858	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
148	User	12	12	failed_login	https://localhost/api/v2/tokens	2026-06-01 20:47:43.81273	{"remote_ip": "172.18.0.1", "user_name": "admin"}
149	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:48:08.88007	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
150	FormSection	\N	13	list	https://localhost/api/v2/forms	2026-06-01 20:48:08.901706	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
151	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-01 20:48:49.002273	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
152	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-01 20:49:29.074595	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
153	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-01 20:49:29.093383	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
154	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-01 20:49:29.130108	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
155	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-06-01 20:49:34.172048	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
156	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-06-01 20:49:34.189413	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
157	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-01 20:50:24.278677	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
158	User	13	13	login	https://localhost/api/v2/tokens	2026-06-01 20:53:29.570574	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "POST"}
159	FormSection	\N	13	list	https://localhost/api/v2/forms	2026-06-01 20:53:29.613233	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
160	Lookup	\N	13	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:53:34.668987	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "primero_ftr", "record_ids": [], "http_method": "GET"}
161	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-01 20:54:29.776754	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
162	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-01 20:54:29.812955	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
163	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-01 20:54:29.845455	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
164	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-01 20:54:29.87998	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
165	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-01 20:54:29.910412	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
166	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-01 20:54:29.932476	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
167	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-01 20:54:39.973253	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
168	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&page=1&per=20&managed=true	2026-06-01 20:54:45.022937	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
169	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-01 20:54:45.046097	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
191	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-06-02 13:00:03.007676	{"remote_ip": "172.18.0.1", "user_name": "zenenperaza"}
192	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 13:00:13.047845	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
193	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 13:00:13.069212	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
194	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 13:00:13.087835	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
195	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 13:00:13.107071	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
196	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 13:00:13.125033	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
197	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 13:00:13.142627	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
198	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 13:00:13.160382	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
199	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 13:00:13.179555	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
200	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 13:00:13.201321	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
201	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 13:00:28.296178	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
202	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 13:06:31.770043	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
203	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 13:29:22.832637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
204	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 13:29:22.868589	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
205	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 13:29:22.890776	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
206	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 13:30:12.963004	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
207	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 14:38:07.711524	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
208	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 14:38:12.766042	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
209	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 14:38:12.798499	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
210	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 14:38:12.925568	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
211	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 14:38:12.949743	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
212	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 14:38:12.976621	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
213	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 14:38:12.999391	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
214	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 14:38:13.027781	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
215	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 14:38:13.050129	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
216	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 14:38:13.070713	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
217	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 14:38:18.104736	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
218	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 14:38:18.131833	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
219	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 14:38:18.157368	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
220	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 14:38:28.203198	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
221	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 14:38:58.252904	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
222	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 14:38:58.276442	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
223	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 14:39:48.32924	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
224	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 14:39:48.352807	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
225	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 14:39:48.374447	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
226	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 14:39:58.415406	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
227	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 14:39:58.43854	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
228	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 14:39:58.457441	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
229	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 14:40:23.499746	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
230	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 14:40:28.533697	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
231	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 14:47:53.869919	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
233	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=14&per=20&page=1&total_enabled=14	2026-06-02 14:47:53.914872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
234	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 14:51:29.137542	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
235	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-06-02 14:51:29.158444	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
236	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 15:10:25.82973	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
237	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 15:10:25.864559	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
238	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 15:10:25.885719	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
239	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 15:10:25.909121	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
240	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 15:10:25.932712	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
241	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 15:10:25.955957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
242	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 15:10:25.984465	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
243	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 15:10:26.003484	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
244	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 15:19:46.474209	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
245	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 15:27:57.100644	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
246	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 15:27:57.12676	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
247	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 15:27:57.154458	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
248	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 15:27:57.187584	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
249	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 15:27:57.211098	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
250	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 15:27:57.235415	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
251	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 15:27:57.265267	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
252	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 15:28:02.413068	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
253	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 15:28:02.434702	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
254	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 15:28:02.465663	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
255	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 15:28:07.490405	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
256	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 15:30:47.67566	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
257	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 15:51:04.866239	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
258	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 15:53:20.143254	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
259	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 15:53:20.180753	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
260	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 15:53:20.206558	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
261	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 15:53:20.23612	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
262	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 15:53:20.258167	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
263	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 15:53:20.283793	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
264	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 15:53:20.310511	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
265	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 15:53:20.334954	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
266	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 15:53:20.35814	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
267	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 15:53:25.3889	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
268	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 16:17:57.122293	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
269	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:07:04.615541	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
270	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:07:04.652221	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
271	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:07:04.680938	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
272	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:07:04.708816	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
273	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:07:09.742319	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
274	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:07:09.768909	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
275	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:07:09.808536	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
276	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:07:09.848067	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
277	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:07:09.906251	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
278	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:07:09.971492	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
279	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:07:30.019804	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
280	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:07:30.097702	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
281	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:07:30.119965	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
282	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:07:30.148276	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
283	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 17:11:25.300659	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
284	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 17:31:31.36329	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
285	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:31:46.422398	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
286	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:31:46.444192	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
287	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:31:46.474797	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
288	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:31:51.517065	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
289	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 17:32:31.586564	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
290	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:35:31.761789	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
291	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:35:36.795439	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
292	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:35:36.81512	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
293	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:35:36.834165	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
294	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:35:36.855106	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
295	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:35:36.875556	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
296	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:35:36.891619	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
297	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:35:36.912547	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
298	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:35:36.937413	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
299	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:35:36.957949	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
300	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:35:41.984963	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
301	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:35:42.003512	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
302	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:35:42.029216	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
303	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:35:42.0508	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
304	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:35:47.082455	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
305	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:36:12.127613	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
306	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:36:37.170098	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
307	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:36:47.210431	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
308	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:36:47.232862	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
309	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:36:47.253335	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
310	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:36:47.272759	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
311	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:36:47.292975	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
312	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:36:47.316964	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
313	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:36:47.337648	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
314	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:36:47.35943	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
315	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:36:47.383145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
316	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:36:52.417333	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
317	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:40:22.613962	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
318	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:40:22.64834	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
319	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:40:22.696525	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
320	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:40:27.73176	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
321	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:40:27.75719	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
322	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:40:27.783898	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
323	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:40:27.805144	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
324	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:40:32.836703	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
325	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:40:32.858206	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
326	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:40:32.882637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
327	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:40:32.90808	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
328	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:40:32.933463	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
329	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:40:32.955097	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
330	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:40:32.976407	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
331	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:40:38.008063	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
332	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:40:38.032839	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
333	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:40:38.052843	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
334	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:40:38.07648	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
335	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:40:38.09774	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
336	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:40:38.134281	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
337	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:40:38.19888	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
338	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:40:38.215688	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
339	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:40:38.244506	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
340	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:40:38.263946	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
341	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:40:43.296063	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
342	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:40:43.327725	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
343	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:40:43.345476	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
344	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:40:43.369842	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
345	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:40:53.410946	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
346	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:41:08.445667	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
347	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:41:55.30663	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
348	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:41:55.338527	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
349	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:41:55.35794	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
350	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:41:55.377507	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
351	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:41:55.395049	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
352	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:41:55.415677	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
353	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:41:55.434533	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
354	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:41:55.454266	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
355	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:41:55.472889	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
356	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:42:00.500637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
357	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:42:10.53424	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
358	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:42:10.553469	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
359	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:42:10.570843	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
360	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:42:15.5968	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
361	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:42:15.617014	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
362	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:42:15.631297	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
363	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:45:25.784423	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
364	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:45:30.812335	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
365	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:45:30.830126	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
366	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:45:30.844985	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
367	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:45:30.861803	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
368	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:45:30.877152	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
369	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:45:30.90791	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
370	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:45:30.925638	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
371	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es	2026-06-02 17:45:30.942792	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
372	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-06-02 17:45:31.080044	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
373	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-06-02 17:45:36.101668	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
374	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-06-02 17:45:41.122021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
375	Agency	1	12	update	https://localhost/api/v2/agencies/1	2026-06-02 17:45:46.14652	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "PATCH"}
376	Agency	1	12	show	https://localhost/api/v2/agencies/1	2026-06-02 17:45:46.164697	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
377	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:45:56.195522	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
378	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:45:56.210948	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
379	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:45:56.224824	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
380	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:45:56.24066	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
381	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:45:56.254036	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
382	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:45:56.270195	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
383	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:45:56.28831	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
384	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:45:56.303509	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
385	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:45:56.320161	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
386	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 17:46:16.352679	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
387	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 17:46:16.367975	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
388	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:46:16.383555	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
389	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 17:46:21.402785	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
390	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:46:21.420142	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
391	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 17:47:06.475474	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
392	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 17:47:11.499933	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
393	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 17:47:11.521549	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
394	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 17:47:16.553297	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
395	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=3&per=20&page=1&managed=true	2026-06-02 17:48:01.632584	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
396	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 17:48:06.673652	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
397	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:48:11.695697	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
398	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:48:11.713514	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
399	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:48:11.732501	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
400	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:48:21.757683	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
401	User	13	12	show	https://localhost/api/v2/users/13?activity_stats=true	2026-06-02 17:48:21.784859	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
402	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:48:21.802008	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
403	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:48:21.819243	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
404	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:48:26.85371	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
405	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:48:26.874314	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
406	User	13	12	show	https://localhost/api/v2/users/13?activity_stats=true	2026-06-02 17:48:26.892301	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
407	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:48:26.912618	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
408	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:48:46.946978	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
409	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:48:46.965021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
410	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=14&per=20&page=1&total_enabled=14	2026-06-02 17:48:46.986153	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
411	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:48:52.013081	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
412	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:48:52.029237	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
413	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 17:48:52.046488	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
414	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 17:50:07.197535	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
415	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=3&per=20&page=1&managed=true	2026-06-02 17:50:12.218664	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
416	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=1&per=20&page=1&managed=true	2026-06-02 17:50:17.244405	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
417	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:50:22.265664	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
418	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:50:37.317877	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
419	FormSection	1	12	show	https://localhost/api/v2/forms/1	2026-06-02 17:50:37.339359	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
420	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:50:37.362109	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
421	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:54:47.731578	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
422	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:54:52.770882	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
423	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:54:52.794579	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
424	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:54:52.817147	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
425	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:54:52.834962	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
426	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:54:52.851358	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
427	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:54:52.865958	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
428	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:54:52.87538	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
429	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:54:52.884429	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
430	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:54:52.89866	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
431	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:54:57.924164	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
432	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 17:55:07.95222	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
433	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:55:07.971754	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
434	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:55:07.988971	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
435	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:55:08.008144	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
436	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:55:13.030676	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
437	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 17:55:28.061195	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
438	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 17:55:28.077967	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
439	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 17:55:28.095176	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
440	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 17:56:58.208727	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
441	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 17:57:03.245046	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
442	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 17:57:03.264333	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
443	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 17:57:03.280134	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
444	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 17:57:03.297077	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
445	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 17:57:03.314565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
446	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 17:57:03.334104	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
447	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 17:57:03.354883	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
448	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 17:57:03.372253	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
449	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 17:57:03.394031	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
450	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 17:57:08.42278	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
451	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 17:58:23.561616	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
452	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 18:12:29.381084	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
453	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 18:12:29.411957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
454	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 18:12:29.431443	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
455	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 18:12:39.463327	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
456	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 18:12:39.483585	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
457	User	13	12	show	https://localhost/api/v2/users/13?activity_stats=true	2026-06-02 18:12:39.501569	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
458	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 18:12:39.519637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
459	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 18:14:29.648572	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
460	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 18:27:00.52289	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
461	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 18:32:15.795678	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
462	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 18:32:15.823524	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
463	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=14&per=20&page=1&total_enabled=14	2026-06-02 18:32:15.854517	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
464	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 18:46:26.488942	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
465	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 18:47:38.738516	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
466	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 18:47:38.763989	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
467	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 18:47:38.779562	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
468	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 18:47:38.794606	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
469	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 18:47:38.809468	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
470	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 18:47:38.827991	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
471	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&managed=true	2026-06-02 18:47:38.842167	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
472	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 18:47:43.879666	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
473	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 18:47:43.900167	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
474	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 18:47:43.919332	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
475	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 19:06:00.759539	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
476	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:15:51.424937	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
477	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:16:21.487638	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
478	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:16:21.506798	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
479	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:16:26.539318	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
480	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:16:31.570806	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
481	FormSection	32	12	show	https://localhost/api/v2/forms/32	2026-06-02 19:16:31.59763	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["32"], "http_method": "GET"}
482	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:16:31.616371	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
483	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 19:17:26.700576	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
484	User	12	12	show	https://localhost/api/v2/users/12	2026-06-02 19:33:07.91395	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
485	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 19:33:07.932193	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
486	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 19:33:37.991925	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
487	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 19:33:38.01467	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
488	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 19:33:38.074429	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
489	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 19:35:58.240122	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
490	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 19:36:18.282687	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
491	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:36:18.308484	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
492	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 19:36:18.329857	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
493	User	\N	12	create	https://localhost/api/v2/users	2026-06-02 19:37:29.287397	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
494	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:37:29.306083	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
495	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-02 19:37:29.326263	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
496	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 19:37:29.346738	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
497	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 19:37:29.366117	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
498	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 19:37:34.392208	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
499	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 19:37:34.412525	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
500	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=14&per=20&page=1&total_enabled=15	2026-06-02 19:37:34.433038	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
501	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:40:04.647752	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
502	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 19:40:09.675457	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
503	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 19:40:09.695102	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
504	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:40:14.721004	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
505	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 19:42:49.886782	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
506	User	15	15	login	https://localhost/api/v2/tokens	2026-06-02 19:42:49.909378	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
507	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-02 19:42:49.927445	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
508	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:42:49.948202	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
509	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-02 19:42:49.965468	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
510	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:42:49.993665	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
511	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-02 19:42:50.024693	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
512	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-02 19:42:50.048227	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
513	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:42:55.081191	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
514	User	15	15	show	https://localhost/api/v2/users/15	2026-06-02 19:44:00.150803	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
515	Role	\N	15	list	https://localhost/api/v2/roles	2026-06-02 19:44:00.168416	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
516	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 19:44:05.193012	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
517	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 19:44:15.216306	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
518	User	15	15	show	https://localhost/api/v2/users/15	2026-06-02 19:44:20.24345	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
519	Role	\N	15	list	https://localhost/api/v2/roles	2026-06-02 19:44:20.260797	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
520	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:46:00.352892	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
521	User	15	15	login	https://localhost/api/v2/tokens	2026-06-02 19:47:25.433047	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
522	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 19:48:05.49462	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
523	Child	\N	15	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:48:10.522282	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
524	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:48:20.556387	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
525	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-02 19:48:30.588531	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
526	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 19:48:30.609633	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
527	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 19:48:35.636019	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
528	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 19:48:35.654994	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
529	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 19:48:35.674528	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
530	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:48:35.691725	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
531	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:48:35.709305	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
562	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 20:14:25.216526	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
532	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:48:35.726616	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
533	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 19:48:35.746107	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
534	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 19:48:35.762523	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
535	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 19:48:35.78189	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
536	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 19:53:51.110806	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
537	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 19:53:51.136181	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
538	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 19:53:51.159034	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
539	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 19:54:01.360047	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
540	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:56:31.514661	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
541	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-02 19:56:41.543438	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
542	User	15	15	login	https://localhost/api/v2/tokens	2026-06-02 19:56:46.595207	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
543	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-02 19:56:46.613305	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
544	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:56:46.642309	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
545	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-02 19:56:46.660618	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
546	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-02 19:56:46.689605	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
547	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:56:46.707606	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
548	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-02 19:56:46.734321	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
549	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 19:56:46.75462	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
550	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-02 19:59:11.892393	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
551	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 19:59:16.933986	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
552	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-02 19:59:16.951362	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
553	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-02 19:59:16.972814	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
554	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 19:59:16.99072	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
555	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-02 19:59:17.010883	{"role_id": 13, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
556	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-02 20:14:09.969835	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
557	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-02 20:14:09.993926	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
558	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-02 20:14:15.073636	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
559	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:14:15.115634	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
560	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 20:14:15.142426	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
561	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-02 20:14:15.16744	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
563	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 20:14:25.237465	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
564	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-02 20:14:25.277803	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
565	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-02 20:14:25.304896	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
566	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:14:30.377094	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
567	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-02 20:14:30.39528	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
568	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 20:14:30.413827	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
569	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-02 20:14:30.43095	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
570	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-02 20:14:30.449738	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
571	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-02 20:14:30.467398	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
572	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:19:05.731662	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
573	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:19:05.776611	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
574	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 20:19:05.823646	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
575	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:19:10.859245	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
576	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:19:25.89084	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
577	Role	3	12	show	https://localhost/api/v2/roles/3	2026-06-02 20:19:55.940289	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["3"], "http_method": "GET"}
578	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:19:55.959253	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
579	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:21:56.077981	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
580	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:21:56.09862	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
581	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 20:22:36.154346	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
582	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 20:22:36.177911	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
583	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=27&per=20&page=1&managed=true	2026-06-02 20:22:46.50443	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
584	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&page=1&per=20&managed=true	2026-06-02 20:22:51.6604	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
585	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:22:51.705447	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
586	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:22:56.773182	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
587	Agency	2	12	update	https://localhost/api/v2/agencies/2	2026-06-02 20:24:42.448646	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "PATCH"}
588	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:24:42.465614	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
589	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 20:24:52.496566	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
590	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:25:12.537451	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
591	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:25:22.568292	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
622	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:27:58.326006	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
592	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:26:02.619249	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
593	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-02 20:26:07.6425	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
594	PrimeroConfiguration	\N	12	index	https://localhost/api/v2/configurations?page=1&per=20	2026-06-02 20:26:27.671824	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
595	User	\N	12	index	https://localhost/api/v2/users?per=999	2026-06-02 20:26:27.69513	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
596	User	\N	12	index	https://localhost/api/v2/users?per=999	2026-06-02 20:26:32.719518	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
597	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 20:26:37.743473	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
598	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:26:37.770774	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
599	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:26:42.798437	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
600	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:26:42.820015	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
601	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:26:42.842615	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
602	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:26:52.874766	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
603	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:26:52.893629	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
604	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-02 20:26:52.910722	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
605	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:26:52.927984	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
606	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-02 20:26:52.944458	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
607	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:26:52.970103	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
608	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:26:52.987604	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
609	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:26:58.012604	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
610	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:27:08.037573	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
611	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:27:08.058614	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
612	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:27:33.091662	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
613	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:27:33.110359	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
614	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:27:33.130096	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
615	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-02 20:27:33.147625	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
616	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:27:38.172716	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
617	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:27:38.196379	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
618	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-02 20:27:38.221993	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
619	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:27:38.249017	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
620	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:27:58.285463	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
621	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:27:58.308442	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
623	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:28:08.35061	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
624	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:28:08.373174	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
625	Role	13	12	update	https://localhost/api/v2/roles/13	2026-06-02 20:28:28.409182	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "PATCH"}
626	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:28:28.425966	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
627	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:28:28.444804	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
628	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:28:28.461565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
629	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-02 20:28:33.48738	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
630	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:28:33.513466	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
631	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-02 20:28:43.541166	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
632	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:28:43.558136	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
633	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:28:53.584842	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
634	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:29:03.61294	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
635	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-02 20:29:03.636616	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
636	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:29:03.657048	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
637	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:29:08.686016	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
638	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 20:29:13.713605	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
639	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:29:23.742423	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
640	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:29:23.76144	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
641	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-02 20:29:23.783752	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
642	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:29:28.807669	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
643	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:29:28.828784	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
644	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:29:28.847637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
645	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:29:48.886102	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
646	Role	8	12	show	https://localhost/api/v2/roles/8	2026-06-02 20:29:48.905681	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["8"], "http_method": "GET"}
647	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:29:48.929673	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
648	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 20:31:29.091867	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
649	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:31:34.11444	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
650	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:31:34.138784	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
651	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-02 20:31:34.161722	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
652	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-02 20:31:44.186386	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
653	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:31:44.206794	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
654	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-02 20:31:44.225268	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
655	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:31:44.243371	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
656	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:31:49.265456	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
657	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=27&per=20&page=1&managed=true	2026-06-02 20:31:54.289567	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
658	UserGroup	1	12	show	https://localhost/api/v2/user_groups/1	2026-06-02 20:31:59.311319	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
659	UserGroup	1	12	show	https://localhost/api/v2/user_groups/1	2026-06-02 20:31:59.329683	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
660	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:32:04.356646	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
661	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:32:04.375477	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
662	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-02 20:32:09.401376	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
663	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:32:54.456776	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
664	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:32:59.480644	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
665	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:32:59.497063	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
666	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-02 20:33:04.522062	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
667	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:33:04.54829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
668	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:33:59.613272	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
669	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-02 20:34:04.638179	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
670	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=27&per=20&page=1&managed=true	2026-06-02 20:38:54.839025	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
671	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:39:04.877422	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
672	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-02 20:39:09.903002	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
673	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:39:14.937204	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
674	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-02 20:39:20.29709	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
675	User	12	12	login	https://localhost/api/v2/tokens	2026-06-02 20:44:25.607003	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
676	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-02 20:47:00.75573	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
677	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-02 20:47:00.826023	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
678	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-02 20:47:00.958649	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
679	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-02 20:47:06.021643	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
680	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:47:11.053511	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
681	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-02 20:51:01.22314	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
682	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-02 20:51:01.253843	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
683	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 13:58:02.261465	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
684	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 13:58:02.353346	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
685	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 13:58:02.376703	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
686	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 13:58:02.39852	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
687	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 13:58:02.421759	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
688	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 13:58:02.445869	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
689	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 13:58:02.467156	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
690	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 13:58:02.488416	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
691	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 13:58:02.511151	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
692	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 13:58:52.583084	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
693	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 13:59:42.629661	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
694	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 13:59:42.647089	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
695	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 13:59:42.664349	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
696	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 13:59:47.692254	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
697	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 13:59:47.713753	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
698	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 13:59:47.731123	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
699	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 13:59:47.749254	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
700	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:00:07.782176	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
701	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:00:07.800538	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
702	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 14:00:07.817615	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
703	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:00:12.843416	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
704	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:00:12.860638	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
705	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:00:12.876505	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
706	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 14:01:32.945311	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
707	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:01:57.98333	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
708	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:01:58.000691	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
709	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:03:23.08138	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
710	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:03:23.100754	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
711	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 14:03:23.127656	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
712	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 14:03:28.153307	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
713	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-03 14:04:13.207148	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
714	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:04:13.22973	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
715	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:04:13.24606	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
716	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:04:33.280291	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
717	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:04:33.296151	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
718	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 14:04:33.309995	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
719	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:04:33.324112	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
720	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:04:33.338039	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
721	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:04:33.354669	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
722	User	\N	12	create	https://localhost/api/v2/users	2026-06-03 14:07:04.088336	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
723	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:07:04.106254	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
724	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:07:04.127835	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
725	User	16	12	show	https://localhost/api/v2/users/16?activity_stats=true	2026-06-03 14:07:04.143015	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
726	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:07:04.159306	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
727	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:07:09.187406	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
728	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:07:09.21124	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
729	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=16	2026-06-03 14:07:09.231812	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
730	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:08:09.305454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
731	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:08:09.325317	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
732	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 14:08:09.345197	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
733	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:08:09.363866	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
734	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:08:14.389585	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
735	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:08:14.406439	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
736	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=16&per=20&page=1&total_enabled=16	2026-06-03 14:08:14.422905	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
737	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:08:34.455965	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
738	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 14:08:34.475613	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
739	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:08:34.49215	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
740	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:08:34.509307	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
741	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:08:34.525825	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
742	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:08:34.543977	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
743	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 14:08:34.560574	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
744	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:08:34.575796	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
745	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:08:44.602004	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
746	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:08:44.619242	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
747	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=16&per=20&page=1&total_enabled=16	2026-06-03 14:08:44.636197	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
748	User	16	12	show	https://localhost/api/v2/users/16?activity_stats=true	2026-06-03 14:09:29.691455	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
749	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:09:29.712935	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
750	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:09:29.729677	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
751	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:09:29.746101	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
752	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:09:39.77118	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
753	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:09:39.786372	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
754	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=16&per=20&page=1&total_enabled=16	2026-06-03 14:09:39.802348	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
755	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:09:44.828101	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
756	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:09:44.845079	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
757	User	16	12	show	https://localhost/api/v2/users/16?activity_stats=true	2026-06-03 14:09:44.861724	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
758	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:09:44.880427	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
759	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:09:49.904143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
760	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:09:49.922936	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
761	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=16&per=20&page=1&total_enabled=16	2026-06-03 14:09:49.939952	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
762	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:09:54.961193	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
763	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:09:54.980743	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
764	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:09:54.99822	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
765	User	\N	12	create	https://localhost/api/v2/users	2026-06-03 14:12:25.133308	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
766	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:12:25.152218	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
767	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:12:25.170337	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
768	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:12:25.187535	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
769	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:12:25.205893	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
770	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 14:38:41.091678	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
771	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 14:38:41.119583	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1364	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:19:06.496771	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
772	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:38:41.135962	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
773	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 14:38:41.156919	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
774	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 14:38:41.173063	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
775	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 14:38:41.187891	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
776	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 14:38:41.203716	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
777	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 14:38:41.225187	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
778	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:38:41.243989	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
779	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:38:41.263174	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
780	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 14:38:41.279107	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
781	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:38:46.314671	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
782	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:38:46.338166	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
783	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:38:46.354487	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
784	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:38:46.371565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
785	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:38:46.386385	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
786	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:38:46.403936	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
787	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:38:46.421452	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
788	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:38:46.437537	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
789	User	17	12	update	https://localhost/api/v2/users/17	2026-06-03 14:39:01.463454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "PATCH"}
790	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:39:01.483159	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
791	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:39:01.503612	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
792	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:39:01.525849	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
793	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:39:01.544108	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
794	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:39:16.579401	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
795	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:39:16.602453	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
796	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=17&per=20&page=1&total_enabled=17	2026-06-03 14:39:16.625356	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
797	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:39:32.02102	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
798	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:39:32.03959	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
799	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:39:32.059018	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
800	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:39:32.076218	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
801	User	\N	12	user_password_reset_request	https://localhost/api/v2/users/17/password-reset-request	2026-06-03 14:39:42.099827	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
802	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:39:47.132144	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
803	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:39:47.162412	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
804	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=17&per=20&page=1&total_enabled=17	2026-06-03 14:39:47.214324	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
805	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:40:22.300022	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
806	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:40:22.321952	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
807	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:40:22.346854	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
808	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:40:22.36936	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
809	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:40:27.398088	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
810	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:40:27.415091	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
811	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:40:27.434339	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
812	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:40:27.450499	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
813	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:41:02.497944	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
814	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=17&per=20&page=1&total_enabled=17	2026-06-03 14:41:02.518585	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
815	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:41:02.536874	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
816	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:41:32.579002	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
817	User	17	12	show	https://localhost/api/v2/users/17?activity_stats=true	2026-06-03 14:41:32.597075	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
818	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:41:32.61123	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
819	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:41:32.626582	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
820	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:41:47.656147	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
821	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:41:47.673898	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
822	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=17&per=20&page=1&total_enabled=17	2026-06-03 14:41:47.692351	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
823	User	\N	12	index	https://localhost/api/v2/users?total=17&total_enabled=17&page=1&locale=es&per=20	2026-06-03 14:42:02.726055	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
824	User	\N	12	index	https://localhost/api/v2/users?total=17&agency=2&total_enabled=17&page=1&locale=es&disabled%5B0%5D=false&per=20	2026-06-03 14:42:27.774233	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
825	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:42:37.806861	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
826	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:42:37.82597	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
827	User	16	12	show	https://localhost/api/v2/users/16?activity_stats=true	2026-06-03 14:42:37.889108	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
828	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:42:37.916525	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
829	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:42:47.946307	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
830	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:42:47.993531	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
831	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=5&per=20&page=1&total_enabled=17	2026-06-03 14:42:48.017742	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
832	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 14:42:53.040007	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
833	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:42:53.067916	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
834	User	16	12	show	https://localhost/api/v2/users/16?activity_stats=true	2026-06-03 14:42:53.08965	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
835	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:42:53.113513	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
836	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:44:23.194829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
837	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:44:23.225349	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
838	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=17&per=20&page=1&total_enabled=17	2026-06-03 14:44:23.262497	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
839	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 14:47:53.485639	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
840	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 14:47:53.509833	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
841	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 14:47:53.531106	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
842	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 14:47:53.548311	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
843	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 14:48:48.61181	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
844	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:48:53.635671	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
845	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:48:53.652426	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
846	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-03 14:49:08.688443	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
847	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:49:28.72813	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
848	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:49:28.750749	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
849	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:50:08.80518	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
850	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:50:08.82451	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
851	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 14:50:18.855149	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
852	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:50:18.87541	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
853	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:50:18.900415	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
854	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:50:33.933112	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
855	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:50:33.960394	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
856	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 14:52:39.146561	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
857	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:52:44.17964	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
858	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:52:44.198942	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
859	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-03 14:52:44.216815	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
860	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:52:54.245776	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
861	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:52:54.27005	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
862	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:53:09.31186	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
863	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:53:09.336174	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
864	Role	13	12	update	https://localhost/api/v2/roles/13	2026-06-03 14:55:24.452975	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "PATCH"}
865	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 14:55:24.4728	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
866	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:55:24.491071	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
867	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-03 14:55:29.517412	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
868	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:55:34.541456	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
869	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:55:34.561947	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
870	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:55:39.591724	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
871	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:55:39.611857	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
872	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 14:55:54.644065	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
873	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 14:55:54.666225	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
874	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 14:55:54.76794	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
875	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=14&per=20&page=1&managed=true	2026-06-03 14:55:59.792375	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
876	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 15:08:40.50231	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
877	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:21:21.258052	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
878	PrimeroConfiguration	\N	12	index	https://localhost/api/v2/configurations?page=1&per=20	2026-06-03 15:32:47.593161	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
879	CodeOfConduct	\N	12	create	https://localhost/api/v2/codes_of_conduct	2026-06-03 15:33:37.681868	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
880	CodeOfConduct	\N	12	list	https://localhost/api/v2/codes_of_conduct	2026-06-03 15:33:37.704991	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
881	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 15:34:02.757767	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
882	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 15:34:02.781655	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
883	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 15:34:02.802182	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
884	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:34:07.838518	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
885	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:34:17.87353	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
886	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 15:37:38.082179	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
887	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 15:37:38.108315	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
888	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 15:37:38.128842	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
889	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 15:37:38.149085	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
890	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 15:37:38.166009	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
891	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 15:37:38.18382	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
892	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&managed=true	2026-06-03 15:37:38.215011	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
893	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:37:58.250896	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
894	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 15:38:03.287305	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
895	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:38:03.309018	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
896	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 15:38:18.358265	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
897	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:38:18.388906	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
898	Role	15	12	update	https://localhost/api/v2/roles/15	2026-06-03 15:40:08.497435	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
899	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 15:40:08.532951	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
900	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:40:08.557679	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
901	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 15:40:48.635308	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
902	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 15:40:48.665078	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
903	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:40:48.688017	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
904	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 15:40:58.734202	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
905	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:40:58.768197	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
906	Role	16	12	update	https://localhost/api/v2/roles/16	2026-06-03 15:41:33.877758	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "PATCH"}
907	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 15:41:38.92397	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
908	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:41:38.943642	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
909	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 15:41:43.985529	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
910	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 15:42:09.045113	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
911	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:42:09.071451	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
912	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 15:42:14.101368	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
913	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:42:14.123256	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
914	Role	13	12	update	https://localhost/api/v2/roles/13	2026-06-03 15:43:04.206455	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "PATCH"}
915	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 15:43:04.236744	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
916	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:43:04.258979	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
917	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 15:44:04.37879	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
918	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 15:44:04.413321	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
919	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:44:04.548905	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
920	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 15:44:14.595612	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
921	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:44:14.614513	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
922	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 15:44:49.676399	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
923	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 15:44:49.696775	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1467	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:40:34.714577	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
924	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:44:49.721495	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
925	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 15:44:49.738775	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
926	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 15:44:54.771273	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
927	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:44:54.795946	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
928	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 15:44:59.828161	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
929	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:44:59.845578	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
930	Role	17	12	update	https://localhost/api/v2/roles/17	2026-06-03 15:45:59.921885	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "PATCH"}
931	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 15:45:59.9447	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
932	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 15:45:59.969938	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
933	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 15:46:04.99597	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
934	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:47:15.075097	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
935	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=27&per=20&page=2&managed=true	2026-06-03 15:49:25.202198	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
936	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 15:50:30.269575	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
937	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 15:51:00.314609	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
938	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 16:07:36.319788	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
939	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 16:12:06.726781	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
940	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 17:12:59.842095	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
941	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 17:12:59.862554	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
942	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 17:12:59.884876	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
943	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 17:12:59.906454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
944	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 17:12:59.943426	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
945	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 17:12:59.962949	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
946	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:12:59.983823	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
947	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 17:13:00.004117	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
948	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 17:13:00.025167	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
949	Child	\N	12	index	https://localhost/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 17:13:05.05708	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
950	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 17:13:30.101147	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
951	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 17:13:35.128851	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
952	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:13:35.149642	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
953	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 17:13:35.172495	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
954	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 17:13:35.193145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
955	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 17:13:45.225684	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
956	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 17:14:00.258977	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
957	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:14:00.277563	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
958	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 17:14:00.299969	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
959	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 17:14:05.328335	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
960	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 17:14:05.348863	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
961	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 17:14:10.378257	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
962	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 17:14:10.398014	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
963	PrimeroConfiguration	\N	12	index	https://localhost/api/v2/configurations?page=1&per=20	2026-06-03 17:14:20.434435	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
964	User	\N	12	index	https://localhost/api/v2/users?per=999	2026-06-03 17:14:40.475961	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
965	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:15:45.543235	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
966	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 17:15:45.567148	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
967	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 17:15:45.58912	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
968	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:16:10.622767	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
969	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:16:10.644989	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
970	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 17:16:10.667427	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
971	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 17:16:10.689819	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
972	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:16:10.713268	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
973	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:16:10.734322	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
974	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 17:16:10.754116	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
975	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 17:16:10.781672	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
976	User	15	12	update	https://localhost/api/v2/users/15	2026-06-03 17:17:31.304359	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
977	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:17:31.328616	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
978	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:17:31.356592	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
979	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 17:17:31.372574	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
980	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 17:17:31.390527	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
981	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 17:18:21.449318	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
982	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 17:18:21.467637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
983	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 17:18:31.492946	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
984	Agency	2	12	update	https://localhost/api/v2/agencies/2	2026-06-03 17:18:46.528142	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "PATCH"}
985	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 17:18:46.549559	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
986	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 17:18:51.577055	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
987	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 17:18:56.599883	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
988	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 17:18:56.620644	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
989	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:18:56.642326	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
990	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 17:18:56.670915	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
991	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 17:18:56.68915	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
992	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 17:18:56.709787	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
993	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 17:18:56.727223	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
994	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 17:18:56.752858	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
995	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 17:18:56.767917	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
996	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 17:19:01.791111	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
997	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 17:19:01.81026	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
998	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 17:19:01.857564	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
999	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 17:19:01.876941	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1000	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 17:19:01.896681	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1001	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 17:19:01.913344	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1002	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 17:19:01.933389	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1003	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 17:19:01.952384	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1004	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 17:19:06.982906	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1005	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 17:19:12.006779	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1006	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 17:19:12.029673	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1007	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 17:19:12.0575	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1008	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 17:19:12.077523	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1009	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-03 17:26:22.410869	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1010	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&hierarchy=true	2026-06-03 17:26:27.434949	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1011	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=3&locale=es&hierarchy=true	2026-06-03 17:26:32.46475	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1012	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=4&locale=es&hierarchy=true	2026-06-03 17:26:37.491047	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1042	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:24:57.343121	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1013	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=5&locale=es&hierarchy=true	2026-06-03 17:27:02.531282	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1014	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=4&locale=es&hierarchy=true	2026-06-03 17:28:07.607135	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1015	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=3&locale=es&hierarchy=true	2026-06-03 17:28:12.629888	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1016	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-03 17:28:17.653203	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1017	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 17:49:07.77874	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1018	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 17:56:43.60903	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1019	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 18:08:24.59021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1020	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 18:08:24.619103	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1021	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 18:08:24.63968	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1022	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 18:08:24.663044	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1023	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:08:24.686785	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1024	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 18:08:24.707143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1025	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 18:08:24.731306	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1026	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 18:08:24.7495	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1027	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 18:08:24.772129	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1028	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:08:29.800857	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1029	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:08:29.837578	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1030	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 18:08:29.874588	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1031	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&total=360&per=20&page=1&hierarchy=true	2026-06-03 18:08:30.005032	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1032	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 18:22:05.952576	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1033	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 18:22:06.029806	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1034	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 18:24:57.135718	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1035	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 18:24:57.164381	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1036	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:24:57.191185	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1037	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 18:24:57.213804	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1038	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 18:24:57.24696	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1039	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 18:24:57.276896	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1040	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 18:24:57.300166	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1041	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 18:24:57.323628	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1043	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:24:57.368143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1044	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 18:24:57.40555	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1045	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-03 18:25:02.429284	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1046	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&hierarchy=true	2026-06-03 18:25:47.484666	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1047	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=3&locale=es&hierarchy=true	2026-06-03 18:25:57.520857	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1048	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=4&locale=es&hierarchy=true	2026-06-03 18:26:02.545652	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1049	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=5&locale=es&hierarchy=true	2026-06-03 18:26:12.578579	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1050	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=6&locale=es&hierarchy=true	2026-06-03 18:26:22.611928	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1051	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=7&locale=es&hierarchy=true	2026-06-03 18:26:27.638013	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1052	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=6&locale=es&hierarchy=true	2026-06-03 18:26:32.668457	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1053	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-03 18:26:42.695473	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1054	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&hierarchy=true	2026-06-03 18:26:52.720149	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1055	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=3&locale=es&hierarchy=true	2026-06-03 18:26:57.74665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1056	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=4&locale=es&hierarchy=true	2026-06-03 18:27:02.772722	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1057	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 18:27:17.809468	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1058	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-03 18:32:48.102432	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1059	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 18:32:53.249957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1060	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 18:32:58.302738	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1061	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 18:32:58.322371	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1062	Agency	2	12	update	https://localhost/api/v2/agencies/2	2026-06-03 18:33:13.359128	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "PATCH"}
1063	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 18:33:13.381297	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1064	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:33:28.414087	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1065	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 18:33:28.431862	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1066	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 18:33:33.463711	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1067	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:33:38.495638	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1068	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 18:33:38.516164	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1069	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:33:43.548412	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1070	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 18:33:48.574605	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1071	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 18:33:53.609529	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1072	UserGroup	24	12	update	https://localhost/api/v2/user_groups/24	2026-06-03 18:33:58.638411	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "PATCH"}
1073	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 18:33:58.657678	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1074	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 18:34:03.686859	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1075	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 18:34:03.7044	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1076	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:34:08.730444	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1077	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 18:34:08.749275	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1078	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 18:34:13.77583	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1079	UserGroup	21	12	update	https://localhost/api/v2/user_groups/21	2026-06-03 18:34:23.803958	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "PATCH"}
1080	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 18:34:23.822357	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1081	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:34:28.849418	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1082	UserGroup	3	12	show	https://localhost/api/v2/user_groups/3	2026-06-03 18:34:33.878933	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["3"], "http_method": "GET"}
1083	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:34:38.903503	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1084	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:34:38.920688	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1085	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 18:34:43.947541	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1086	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:34:43.968233	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1087	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 18:34:53.99145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1088	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:34:54.007931	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1089	Role	15	12	update	https://localhost/api/v2/roles/15	2026-06-03 18:35:04.030349	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
1090	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 18:35:04.048	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1091	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:04.062932	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1092	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:35:09.081128	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1093	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 18:35:09.097227	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1094	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:09.114627	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1095	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 18:35:14.141898	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1096	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:14.160149	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1097	Role	16	12	update	https://localhost/api/v2/roles/16	2026-06-03 18:35:24.187515	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "PATCH"}
1098	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 18:35:24.207014	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1099	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:24.224143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1100	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:35:29.247117	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1101	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 18:35:29.262476	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1102	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:29.279394	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1103	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 18:35:34.30262	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1104	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:34.319319	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1105	Role	17	12	update	https://localhost/api/v2/roles/17	2026-06-03 18:35:39.33936	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "PATCH"}
1106	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 18:35:39.35548	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1107	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:39.372573	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1108	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:35:44.396082	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1109	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 18:35:44.417954	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1110	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:44.440179	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1111	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:35:54.466893	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1112	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 18:35:59.493805	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1113	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:35:59.513165	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1114	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 18:36:09.543791	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1115	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:36:09.566098	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1116	Role	13	12	update	https://localhost/api/v2/roles/13	2026-06-03 18:36:29.599186	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "PATCH"}
1117	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 18:36:29.619394	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1118	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:36:29.636506	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1119	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:36:34.661975	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1120	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 18:36:34.69627	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1121	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:36:34.720227	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1122	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 18:36:39.742359	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1123	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:36:39.760017	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1124	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 18:36:54.784905	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
1125	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 18:36:59.809115	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1126	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:36:59.831439	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1127	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 18:37:09.862665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1128	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:37:09.881868	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1129	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 18:37:14.917617	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
1130	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 18:37:14.935545	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1131	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:37:14.969395	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1132	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:45:45.450919	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1133	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:45:45.478807	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1134	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 18:45:45.503223	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1135	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:45:45.523109	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1136	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:45:45.545143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1137	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:45:45.562263	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1138	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:45:45.581391	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1139	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:45:50.601043	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1140	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:45:50.62089	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1141	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:45:50.640169	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1142	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:45:50.657528	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1143	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 18:47:05.726787	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1144	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 18:47:05.753111	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1145	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 18:47:05.771665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1146	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 18:47:05.799899	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1147	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:47:10.829588	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1148	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 18:47:10.849733	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1149	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 18:47:10.868044	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1150	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 18:47:10.895811	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1151	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 18:47:10.922021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1152	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 18:47:10.950818	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1153	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:47:15.975775	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1154	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 18:47:15.99433	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1155	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:47:16.008369	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1156	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:47:21.047449	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1157	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:47:21.0876	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1158	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:47:21.110575	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1159	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:47:21.203212	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1160	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:47:26.247136	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1161	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:47:26.26426	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1162	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:47:26.280466	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1163	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:47:26.298489	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1164	User	15	12	update	https://localhost/api/v2/users/15	2026-06-03 18:47:51.613202	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
1165	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:47:51.630829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1166	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:47:51.649164	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1167	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:47:51.666511	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1168	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:47:51.683743	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1169	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:48:26.727007	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1170	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:48:26.747233	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1171	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:48:26.773841	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1172	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:48:26.794767	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1173	User	15	12	update	https://localhost/api/v2/users/15	2026-06-03 18:49:46.967136	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
1174	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:49:46.985182	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1175	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:49:47.005542	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1176	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 18:49:47.085583	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1177	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:49:47.10519	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1178	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:50:17.149457	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1179	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 18:50:17.16933	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1180	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:50:17.186688	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1181	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 18:50:42.229214	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1182	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:50:57.268129	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1183	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 18:51:22.313564	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1184	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 18:51:27.344548	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1185	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:51:32.37198	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1186	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:51:32.393393	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1187	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 18:51:32.412044	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1188	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:56:47.749846	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1189	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 18:56:52.779716	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1190	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:56:52.801561	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1191	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:57:02.824984	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1192	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:57:07.851817	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1193	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:57:12.877645	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1194	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 18:57:12.896881	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1195	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:57:12.921213	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1196	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:57:12.940696	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1197	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 18:57:12.961158	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1198	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:57:33.018503	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1199	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:57:33.039472	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1200	User	14	12	show	https://localhost/api/v2/users/14?activity_stats=true	2026-06-03 18:57:33.085491	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1201	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:57:33.104516	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1202	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 18:57:38.138293	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1203	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:57:38.155016	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1204	User	14	12	show	https://localhost/api/v2/users/14?activity_stats=true	2026-06-03 18:57:38.172392	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1205	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 18:57:38.188738	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1206	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 18:57:53.215315	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1207	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 18:57:53.235528	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1208	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 18:57:53.25521	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1209	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&total=360&per=20&page=1&hierarchy=true	2026-06-03 18:58:03.280341	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1210	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 19:02:18.509146	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1211	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 19:02:18.533747	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1212	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:02:48.595726	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1213	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:02:48.617773	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1214	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:02:48.638381	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1215	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 19:03:03.794829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1216	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:05:08.923236	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1217	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:05:08.945974	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1218	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:05:08.96892	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1219	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:05:08.986913	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1220	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:05:09.003805	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1221	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:05:09.025453	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1222	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 19:05:09.043465	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1223	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:06:39.142233	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1224	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:06:39.162566	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1225	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 19:06:39.185834	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1226	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&total=360&per=20&page=1&hierarchy=true	2026-06-03 19:07:59.271263	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1227	Lookup	\N	12	index	https://localhost/api/v2/lookups?locale=es&page=1&per=20	2026-06-03 19:08:04.302101	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1228	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&locale=es&total=360&per=20&page=1&hierarchy=true	2026-06-03 19:08:34.342055	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1229	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:11:34.529258	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1230	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=desc&order_by=name&hierarchy=true	2026-06-03 19:11:34.552163	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1231	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=asc&order_by=admin_level&hierarchy=true	2026-06-03 19:11:39.585604	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1232	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=asc&order_by=hierarchy&hierarchy=true	2026-06-03 19:11:54.629753	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1233	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=desc&order_by=hierarchy&hierarchy=true	2026-06-03 19:11:54.644899	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1234	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=asc&order_by=hierarchy&hierarchy=true	2026-06-03 19:11:59.67735	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1235	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:11:59.697141	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1236	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=1&locale=es&order=desc&order_by=name&hierarchy=true	2026-06-03 19:12:04.723474	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1237	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=desc&order_by=name&hierarchy=true	2026-06-03 19:12:19.764718	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1238	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=asc&order_by=code&hierarchy=true	2026-06-03 19:12:29.791277	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1239	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=desc&order_by=code&hierarchy=true	2026-06-03 19:12:29.814207	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1240	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=asc&order_by=code&hierarchy=true	2026-06-03 19:12:29.832122	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1241	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=asc&order_by=admin_level&hierarchy=true	2026-06-03 19:12:44.871736	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1242	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=desc&order_by=admin_level&hierarchy=true	2026-06-03 19:12:54.895643	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1243	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=2&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:04.919309	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1244	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=3&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:09.946042	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1245	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=4&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:14.978522	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1246	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=5&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:20.005701	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1247	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=6&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:25.034512	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1248	Location	\N	12	index	https://localhost/api/v2/locations?disabled%5B0%5D=false&total=360&per=20&page=7&locale=es&order=asc&order_by=name&hierarchy=true	2026-06-03 19:13:35.067849	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1249	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:14:20.13143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1250	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:14:20.152578	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1251	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:14:20.172181	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1252	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 19:17:10.388276	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1253	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:18:15.499587	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1254	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 19:18:15.538249	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1255	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 19:18:15.876481	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1256	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:18:20.946872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1257	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 19:18:30.975509	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1258	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 19:18:36.016192	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1259	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:18:46.076182	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1260	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:19:11.139571	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1261	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:19:11.169049	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1262	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:19:11.187366	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1263	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:24:41.672987	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1264	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:25:26.744295	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1265	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:25:26.76316	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1266	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:25:26.784038	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1267	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:25:46.837494	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1268	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 19:25:46.857733	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1269	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:25:46.878874	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1270	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:25:46.899181	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1271	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 19:36:21.827241	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1272	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 19:36:21.853052	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1273	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 19:36:21.869338	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1274	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:36:21.884134	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1275	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 19:36:21.898614	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1276	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 19:36:21.914684	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1277	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:36:21.933022	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1278	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 19:36:21.949931	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1279	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:36:21.967078	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1280	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:36:21.982955	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1281	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:39:52.142938	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1282	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:39:57.168149	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1283	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 19:39:57.198917	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1284	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 19:40:07.232095	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1285	UserGroup	\N	12	create	https://localhost/api/v2/user_groups	2026-06-03 19:40:47.282962	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1286	UserGroup	28	12	show	https://localhost/api/v2/user_groups/28	2026-06-03 19:40:47.303028	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "GET"}
1287	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=5&per=20&page=1&managed=true	2026-06-03 19:40:47.32135	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1288	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 19:40:52.346816	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1289	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=6&per=20&page=1&managed=true	2026-06-03 19:40:57.371788	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1290	UserGroup	28	12	show	https://localhost/api/v2/user_groups/28	2026-06-03 19:40:57.390579	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "GET"}
1291	UserGroup	28	12	show	https://localhost/api/v2/user_groups/28	2026-06-03 19:41:02.412554	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "GET"}
1292	UserGroup	28	12	update	https://localhost/api/v2/user_groups/28	2026-06-03 19:41:12.439518	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "PATCH"}
1293	UserGroup	28	12	show	https://localhost/api/v2/user_groups/28	2026-06-03 19:41:12.458877	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "GET"}
1294	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=6&per=20&page=1&managed=true	2026-06-03 19:41:12.473128	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1295	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:41:42.50843	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1296	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:41:42.528637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1297	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:41:42.551363	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1298	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:41:42.570594	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1299	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:41:42.588732	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1300	User	15	12	show	https://localhost/api/v2/users/15?activity_stats=true	2026-06-03 19:41:42.609854	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1301	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:41:42.633546	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1302	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:50:08.013454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1303	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:50:08.036784	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1363	Flag	\N	15	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:18:46.431748	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1304	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=15	2026-06-03 19:50:08.063104	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1305	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:50:13.09079	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1306	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:50:13.262103	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1307	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:50:13.291158	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1308	User	\N	12	create	https://localhost/api/v2/users	2026-06-03 19:55:06.841205	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1309	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:55:06.859318	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1310	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:55:06.876492	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1311	User	18	12	show	https://localhost/api/v2/users/18?activity_stats=true	2026-06-03 19:55:06.89341	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["18"], "http_method": "GET"}
1312	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:55:06.910051	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1313	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:55:26.937589	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1314	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:55:26.954805	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1315	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=15&per=20&page=1&total_enabled=16	2026-06-03 19:55:26.973605	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1316	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 19:55:37.003627	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1317	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 19:56:42.054021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1318	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:56:42.072659	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1319	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:56:52.101758	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1320	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:56:52.118129	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1321	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 19:56:52.138823	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1322	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:56:57.160642	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1323	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:56:57.17904	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1324	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:56:57.199314	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1325	User	\N	12	create	https://localhost/api/v2/users	2026-06-03 19:59:43.845502	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1326	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 19:59:43.863045	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1327	User	19	12	show	https://localhost/api/v2/users/19?activity_stats=true	2026-06-03 19:59:43.878726	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["19"], "http_method": "GET"}
1328	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:59:43.893879	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1329	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 19:59:43.910598	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1330	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 19:59:53.934581	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1331	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 19:59:53.952594	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1332	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&total=16&per=20&page=1&total_enabled=17	2026-06-03 19:59:53.968998	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1333	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 19:59:58.995385	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1334	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 20:00:29.034581	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1335	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 20:00:29.051242	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1336	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:01:49.123964	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1337	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:02:29.166591	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1338	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 20:02:44.194731	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1339	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 20:02:44.211598	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1340	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 20:02:44.226839	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1341	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:05:04.33761	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1342	UserGroup	28	12	show	https://localhost/api/v2/user_groups/28	2026-06-03 20:05:54.443151	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["28"], "http_method": "GET"}
1343	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=6&per=20&page=1&managed=true	2026-06-03 20:05:59.478418	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1344	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 20:06:19.524872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1345	Agency	\N	12	index	https://localhost/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-03 20:06:49.568651	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1346	Agency	2	12	show	https://localhost/api/v2/agencies/2	2026-06-03 20:06:49.591276	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1347	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:07:34.644515	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1348	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:08:29.708724	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1349	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 20:17:50.811145	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1350	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 20:17:50.836477	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1351	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 20:17:50.857455	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1352	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 20:18:35.90565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1353	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:18:40.966488	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1354	User	15	15	login	https://localhost/api/v2/tokens	2026-06-03 20:18:46.051252	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
1355	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-03 20:18:46.121605	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
1356	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-03 20:18:46.164839	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1357	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:18:46.214949	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1358	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:18:46.257763	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1359	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-03 20:18:46.304278	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1360	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:18:46.331108	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1361	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:18:46.367245	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1362	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:18:46.399627	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1365	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 20:19:11.554229	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1366	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 20:19:11.59527	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1367	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 20:19:11.622562	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1368	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:19:11.642247	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1369	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 20:19:11.663435	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1370	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:19:11.680872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1371	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:19:11.697856	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1372	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 20:19:11.715197	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1373	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:19:11.733801	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1374	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 20:19:16.759473	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1375	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 20:19:16.777157	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1376	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 20:19:16.794836	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1377	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:19:21.819525	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1378	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 20:19:21.837454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1379	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:19:21.854352	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1380	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 20:19:31.885144	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1381	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:19:31.903021	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1382	Role	13	12	update	https://localhost/api/v2/roles/13	2026-06-03 20:19:36.926535	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "PATCH"}
1383	Role	13	12	show	https://localhost/api/v2/roles/13	2026-06-03 20:19:36.946176	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["13"], "http_method": "GET"}
1384	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:19:36.965754	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1385	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-03 20:19:47.00093	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1386	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 20:19:52.022233	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1387	UserGroup	21	12	show	https://localhost/api/v2/user_groups/21	2026-06-03 20:19:57.044612	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["21"], "http_method": "GET"}
1388	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 20:20:02.068215	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1389	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 20:20:02.082293	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1390	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:20:02.100893	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1391	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 20:20:07.124414	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1392	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:20:07.143244	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1393	Role	14	12	update	https://localhost/api/v2/roles/14	2026-06-03 20:20:17.173728	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "PATCH"}
1394	Role	14	12	show	https://localhost/api/v2/roles/14	2026-06-03 20:20:17.195641	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["14"], "http_method": "GET"}
1395	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:20:17.215957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1396	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=6&per=20&page=1&managed=true	2026-06-03 20:20:42.251015	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1397	UserGroup	24	12	show	https://localhost/api/v2/user_groups/24	2026-06-03 20:20:42.266687	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["24"], "http_method": "GET"}
1398	UserGroup	\N	12	index	https://localhost/api/v2/user_groups?disabled%5B0%5D=false&total=6&per=20&page=1&managed=true	2026-06-03 20:20:52.297377	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1399	UserGroup	2	12	show	https://localhost/api/v2/user_groups/2	2026-06-03 20:20:57.327397	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1400	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 20:21:02.348833	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1401	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 20:21:02.368368	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1402	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:02.388452	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1403	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 20:21:07.409103	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1404	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:07.427111	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1405	Role	15	12	update	https://localhost/api/v2/roles/15	2026-06-03 20:21:12.451366	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "PATCH"}
1406	Role	15	12	show	https://localhost/api/v2/roles/15	2026-06-03 20:21:17.474446	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["15"], "http_method": "GET"}
1407	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:17.491841	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1408	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 20:21:27.516109	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1409	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 20:21:27.533463	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1410	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:27.555644	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1411	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 20:21:32.590699	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1412	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:32.608331	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1413	Role	17	12	update	https://localhost/api/v2/roles/17	2026-06-03 20:21:47.635274	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "PATCH"}
1414	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 20:21:47.653893	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1415	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:47.675628	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1416	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 20:21:57.706726	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1417	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:21:57.723338	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1418	Role	17	12	update	https://localhost/api/v2/roles/17	2026-06-03 20:22:02.744793	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "PATCH"}
1419	Role	17	12	show	https://localhost/api/v2/roles/17	2026-06-03 20:22:07.78113	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["17"], "http_method": "GET"}
1420	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:22:07.801111	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1421	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 20:22:37.840943	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1422	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 20:22:47.871437	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1423	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:22:47.893776	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1424	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 20:22:52.920874	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1425	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:22:52.942829	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1426	Role	16	12	update	https://localhost/api/v2/roles/16	2026-06-03 20:22:57.973489	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "PATCH"}
1427	Role	16	12	show	https://localhost/api/v2/roles/16	2026-06-03 20:22:57.996202	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["16"], "http_method": "GET"}
1428	Role	\N	12	list	https://localhost/api/v2/roles	2026-06-03 20:22:58.011953	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1429	Role	\N	12	index	https://localhost/api/v2/roles?disabled%5B0%5D=false&total=17&per=20&page=1&managed=true	2026-06-03 20:23:13.042519	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1430	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:23:23.070191	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1431	User	15	15	login	https://localhost/api/v2/tokens	2026-06-03 20:23:28.09844	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
1432	User	15	15	show	https://localhost/api/v2/users/15?extended=true	2026-06-03 20:23:28.118386	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
1433	Permission	\N	15	list	https://localhost/api/v2/permissions	2026-06-03 20:23:28.136692	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1434	SystemSettings	\N	15	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:23:28.150781	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1435	FormSection	\N	15	list	https://localhost/api/v2/forms	2026-06-03 20:23:28.165883	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1436	Lookup	\N	15	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:23:28.182614	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1437	Alert	\N	15	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:23:28.198911	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1438	Flag	\N	15	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:23:28.219753	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1439	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:23:28.23731	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1440	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:23:28.253883	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1441	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 20:23:33.277915	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1442	TracingRequest	\N	15	create	https://localhost/api/v2/tracing_requests	2026-06-03 20:38:14.044155	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "POST"}
1443	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	15	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:38:14.067983	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1444	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	15	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-03 20:38:14.091374	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1445	TracingRequest	\N	15	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:38:14.116331	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1446	TracingRequest	\N	15	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=0&per=20&page=1	2026-06-03 20:38:19.145371	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1447	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	15	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:38:24.176325	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1448	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	15	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-03 20:38:24.195843	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1449	TracingRequest	\N	15	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:38:24.220865	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1450	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:38:39.251471	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1451	Dashboard	\N	15	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:38:39.280427	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1452	Flag	\N	15	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:38:39.300071	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1453	User	15	15	show	https://localhost/api/v2/users/15	2026-06-03 20:38:39.328435	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": ["15"], "http_method": "GET"}
1454	Role	\N	15	list	https://localhost/api/v2/roles	2026-06-03 20:38:39.35353	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "zenenperaza", "record_ids": [], "http_method": "GET"}
1455	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:39:24.408028	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1456	User	18	18	login	https://localhost/api/v2/tokens	2026-06-03 20:39:29.430741	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "POST"}
1457	User	18	18	show	https://localhost/api/v2/users/18?extended=true	2026-06-03 20:39:29.453329	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": ["18"], "http_method": "GET"}
1458	SystemSettings	\N	18	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:39:29.470617	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1459	Permission	\N	18	list	https://localhost/api/v2/permissions	2026-06-03 20:39:29.491183	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1460	Lookup	\N	18	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:39:29.510508	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1461	FormSection	\N	18	list	https://localhost/api/v2/forms	2026-06-03 20:39:29.530546	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1462	Dashboard	\N	18	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:39:29.55104	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1463	Flag	\N	18	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:39:29.575843	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1464	Dashboard	\N	18	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:39:29.599298	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1465	Alert	\N	18	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:39:29.621335	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1466	TracingRequest	\N	18	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 20:39:34.646922	{"role_id": 13, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "dannyprimera", "record_ids": [], "http_method": "GET"}
1468	User	19	19	login	https://localhost/api/v2/tokens	2026-06-03 20:40:39.740592	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "POST"}
1469	User	19	19	show	https://localhost/api/v2/users/19?extended=true	2026-06-03 20:40:39.780146	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": ["19"], "http_method": "GET"}
1470	Permission	\N	19	list	https://localhost/api/v2/permissions	2026-06-03 20:40:44.809053	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1471	SystemSettings	\N	19	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:40:44.82625	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1472	Lookup	\N	19	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:40:44.842717	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1473	FormSection	\N	19	list	https://localhost/api/v2/forms	2026-06-03 20:40:44.85659	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1474	Alert	\N	19	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:40:44.871734	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1475	Dashboard	\N	19	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:40:44.888904	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1476	Flag	\N	19	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:40:44.903714	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1477	Dashboard	\N	19	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:40:44.918668	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1478	TracingRequest	\N	19	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 20:40:44.935395	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1479	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	19	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-03 20:40:49.964003	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1480	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	19	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:40:49.982702	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1481	TracingRequest	\N	19	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:40:49.997978	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1482	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	19	update	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:41:55.083712	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "PATCH"}
1483	TracingRequest	\N	19	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:41:55.101397	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1484	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	19	update	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:42:55.497392	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "PATCH"}
1485	TracingRequest	\N	19	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:42:55.516447	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1486	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	19	attach	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/attachments	2026-06-03 20:42:55.533969	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "POST"}
1487	Dashboard	\N	19	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_group_overview	2026-06-03 20:44:30.619847	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1488	Dashboard	\N	19	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:44:30.638971	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1489	Flag	\N	19	index	https://localhost/api/v2/flags?active_only=true&record_type=cases&per=10	2026-06-03 20:44:30.656052	{"role_id": 14, "agency_id": 2, "remote_ip": "172.18.0.1", "user_name": "marymelendez", "record_ids": [], "http_method": "GET"}
1490	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-03 20:44:30.672051	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1491	User	12	12	login	https://localhost/api/v2/tokens	2026-06-03 20:44:45.707654	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1492	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-03 20:44:45.726235	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1493	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-03 20:44:45.745668	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1494	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-03 20:44:45.760607	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1495	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-03 20:44:45.778707	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1496	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 20:44:45.796106	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1497	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-03 20:44:45.813984	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1498	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-03 20:44:45.831414	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1499	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-03 20:44:45.845473	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1500	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 20:44:50.88187	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1501	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 20:44:50.905595	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1502	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 20:44:50.920443	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1503	CodeOfConduct	\N	12	list	https://localhost/api/v2/codes_of_conduct	2026-06-03 20:46:20.989146	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1504	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-03 20:46:26.007292	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1505	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-03 20:46:26.023643	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1506	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-03 20:46:26.039802	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1507	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-03 20:48:36.141887	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1508	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-03 20:48:36.158806	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1509	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-03 20:48:41.179957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1510	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:48:41.197228	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1511	TracingRequest	\N	12	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:48:41.215569	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1512	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&total=1&per=20&page=1	2026-06-03 20:51:11.336099	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1513	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-03 20:51:31.367415	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1514	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-03 20:51:31.387982	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1515	TracingRequest	\N	12	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-03 20:51:31.406202	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1516	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 12:53:52.471981	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1517	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 12:53:52.500577	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1518	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 12:53:52.517404	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1519	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 12:53:52.535579	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1520	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 12:53:52.552385	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1521	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 12:53:52.571225	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1522	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-04 12:53:52.586927	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1523	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-04 12:53:52.603061	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1524	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 12:53:52.61963	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1525	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-04 12:58:27.816064	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1526	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-04 12:58:27.84308	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1527	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-04 12:58:27.864665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1528	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-04 12:58:42.89943	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1529	BulkExport	\N	12	index	https://localhost/api/v2/exports?page=1&per=20	2026-06-04 12:58:42.926446	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1530	Report	\N	12	list	https://localhost/api/v2/reports	2026-06-04 12:58:47.949655	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1531	Report	27	12	show	https://localhost/api/v2/reports/27	2026-06-04 12:59:02.977857	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["27"], "http_method": "GET"}
1532	Report	\N	12	list	https://localhost/api/v2/reports	2026-06-04 12:59:08.005558	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1533	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-04 13:00:08.066611	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1534	Report	\N	12	list	https://localhost/api/v2/reports	2026-06-04 13:11:23.761381	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1535	Report	27	12	show	https://localhost/api/v2/reports/27	2026-06-04 13:15:48.97993	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["27"], "http_method": "GET"}
1536	Report	\N	12	list	https://localhost/api/v2/reports	2026-06-04 13:15:59.009754	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1537	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 13:23:49.874805	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1538	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-04 13:36:10.428772	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1539	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 14:04:57.099563	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1540	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 14:05:02.13622	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1541	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 14:05:02.182101	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1542	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 14:05:02.207924	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1543	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:05:02.225957	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1544	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:05:02.249561	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1545	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 14:05:02.283541	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1546	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-04 14:05:02.303294	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1547	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-04 14:05:02.319211	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1548	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-04 14:05:02.335307	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1549	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-04 14:18:17.922684	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1550	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-04 14:18:17.944703	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1551	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-04 14:18:17.964882	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1552	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:18:22.995152	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1553	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:18:48.036453	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1554	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:18:48.059758	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1555	FormSection	62	12	show	https://localhost/api/v2/forms/62	2026-06-04 14:18:48.077669	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["62"], "http_method": "GET"}
1556	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:19:03.11536	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1557	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:19:38.157905	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1558	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:19:38.173192	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1559	FormSection	62	12	show	https://localhost/api/v2/forms/62	2026-06-04 14:19:38.189755	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["62"], "http_method": "GET"}
1560	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:19:58.22425	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1561	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:20:08.25049	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1562	FormSection	22	12	show	https://localhost/api/v2/forms/22	2026-06-04 14:20:08.269872	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["22"], "http_method": "GET"}
1563	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:20:13.301517	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1564	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:20:58.348391	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1565	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:21:28.399363	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1566	FormSection	59	12	show	https://localhost/api/v2/forms/59	2026-06-04 14:21:28.420472	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["59"], "http_method": "GET"}
1567	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:21:28.438578	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1568	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:22:13.517241	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1569	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:22:28.588291	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1570	FormSection	10	12	show	https://localhost/api/v2/forms/10	2026-06-04 14:22:28.708379	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["10"], "http_method": "GET"}
1571	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:22:28.728803	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1572	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:22:38.763171	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1573	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 14:28:44.058051	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1574	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 14:28:44.082282	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1575	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 14:28:44.102864	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1576	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:28:44.1261	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1577	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:28:44.147606	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1578	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 14:28:44.165997	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1579	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:28:44.186888	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1580	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 14:29:14.242582	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1581	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 14:29:14.28448	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1582	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:29:14.308932	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1583	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 14:29:14.33472	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1584	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:29:14.385817	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1585	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 14:29:14.409496	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1586	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:29:19.445638	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1587	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-04 14:29:24.471303	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1588	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 14:32:32.977435	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1589	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 14:32:32.999984	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1590	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 14:32:33.015105	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1591	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 14:32:33.031123	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1592	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:32:33.047481	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1593	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:32:33.063795	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1594	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 14:32:33.081457	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1595	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-04 14:32:33.097515	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1596	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-04 14:32:33.113196	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1597	TracingRequest	\N	12	index	https://localhost/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-04 14:32:33.128628	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1598	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show_alerts	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-04 14:32:38.151396	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1599	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-04 14:32:38.169732	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1600	TracingRequest	\N	12	traces	https://localhost/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-04 14:32:38.187035	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1601	Agency	\N	12	index	https://localhost/api/v2/agencies?managed=true	2026-06-04 14:33:08.225018	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1602	UserGroup	\N	12	list	https://localhost/api/v2/user_groups	2026-06-04 14:33:08.241693	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1603	User	\N	12	index	https://localhost/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-04 14:33:08.259812	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1604	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:33:13.28175	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1605	User	12	12	show	https://localhost/api/v2/users/12?extended=true	2026-06-04 14:33:18.309953	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1606	SystemSettings	\N	12	index	https://localhost/api/v2/system_settings?extended=true	2026-06-04 14:33:18.327038	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1607	Permission	\N	12	list	https://localhost/api/v2/permissions	2026-06-04 14:33:18.343952	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1608	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:33:18.360681	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1609	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:33:18.376836	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1610	Alert	\N	12	bulk_index	https://localhost/api/v2/alerts	2026-06-04 14:33:18.393554	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1611	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:33:18.41015	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1612	Lookup	\N	12	index	https://localhost/api/v2/lookups?per=999&page=1	2026-06-04 14:57:10.038756	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1613	FormSection	62	12	show	https://localhost/api/v2/forms/62	2026-06-04 14:57:10.060148	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": ["62"], "http_method": "GET"}
1614	FormSection	\N	12	list	https://localhost/api/v2/forms	2026-06-04 14:57:10.082749	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1615	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 15:03:15.382005	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1616	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 15:13:30.945369	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1617	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-04 15:19:16.214794	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1618	Dashboard	\N	12	index	https://localhost/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-04 15:19:16.234849	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1619	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 15:33:17.44214	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1620	User	12	12	login	https://localhost/api/v2/tokens	2026-06-04 15:43:33.322396	{"role_id": 12, "agency_id": 1, "remote_ip": "172.18.0.1", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1621	User	\N	\N	logout	https://localhost/api/v2/tokens	2026-06-04 15:47:48.669907	{"role_id": null, "agency_id": null, "remote_ip": "172.18.0.1", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1622	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-06-04 16:03:15.099482	{"remote_ip": "172.18.0.1", "user_name": null}
1623	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-06-04 16:33:16.51043	{"remote_ip": "172.18.0.1", "user_name": null}
1624	User	\N	\N	failed_login	https://localhost/api/v2/tokens	2026-06-04 17:03:17.92318	{"remote_ip": "172.18.0.1", "user_name": null}
1625	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-04 20:50:35.892735	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1626	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-04 20:50:35.91902	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.153", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1627	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-04 20:50:35.937157	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1628	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-04 20:50:35.95336	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1629	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-04 20:50:35.969287	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1630	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-04 20:50:35.986501	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1631	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-04 20:50:36.002284	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1632	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-04 20:50:36.018138	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.153", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1633	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-04 20:50:36.034389	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.153", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1634	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-04 20:50:41.061614	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.153", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1635	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-04 20:50:41.084212	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1636	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-04 20:50:41.106735	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1637	Location	\N	12	index	https://sistema.today/api/v2/locations?disabled%5B0%5D=false&locale=es&page=1&per=20&hierarchy=true	2026-06-04 20:50:46.137386	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.245.152", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1638	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-04 20:52:01.227253	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1639	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-04 20:52:01.247819	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1640	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-04 20:52:01.268542	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1641	Role	\N	12	index	https://sistema.today/api/v2/roles?disabled%5B0%5D=false&page=1&per=20&managed=true	2026-06-04 20:52:21.310129	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1642	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-04 20:52:26.338626	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1643	Location	\N	12	index	https://sistema.today/api/v2/locations?disabled%5B0%5D=false&locale=es&total=360&per=20&page=1&hierarchy=true	2026-06-04 20:52:31.362743	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.194.232", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1644	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-05 12:57:40.806053	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1645	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 12:57:40.845961	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1646	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 12:57:40.864665	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1647	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 12:57:40.883934	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.26", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1648	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 12:57:40.90341	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1649	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 12:57:40.921659	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1650	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 12:57:40.940553	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.26", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1651	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 12:57:40.958378	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1652	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 12:57:40.974987	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.26", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1653	User	\N	\N	logout	https://sistema.today/api/v2/tokens	2026-06-05 13:03:31.411494	{"role_id": null, "agency_id": null, "remote_ip": "104.23.248.100", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1654	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-05 13:08:26.955868	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1655	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:08:26.975606	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1656	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:08:26.995072	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1657	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:08:27.014767	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1658	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:08:27.034422	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1659	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:08:27.054778	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1660	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:08:27.073622	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1661	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:08:27.093732	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1662	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:08:27.113522	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1663	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:09:47.77752	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1664	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:09:47.800808	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1665	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:09:47.817547	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.26", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1666	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:09:47.834797	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1667	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:09:47.850143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1668	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:09:47.866341	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.26", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1669	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:09:47.88326	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1670	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:09:47.901987	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.12.27", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1671	User	\N	\N	logout	https://sistema.today/api/v2/tokens	2026-06-05 13:09:52.927359	{"role_id": null, "agency_id": null, "remote_ip": "172.68.12.26", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1672	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-05 13:13:53.172929	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1673	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:13:53.191799	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1674	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:13:53.207043	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1675	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:13:53.223542	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1676	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:13:53.239162	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1677	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:13:53.255831	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1678	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:13:53.272188	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1679	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:13:53.287637	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1680	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:13:53.306452	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1681	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:14:03.336332	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1682	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:14:03.353075	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1683	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:14:03.369523	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1684	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:14:03.38618	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1685	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:14:08.410454	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1686	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:14:13.436105	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1687	Agency	2	12	update	https://sistema.today/api/v2/agencies/2	2026-06-05 13:14:38.750438	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["2"], "http_method": "PATCH"}
1688	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:14:38.768299	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1689	User	\N	\N	logout	https://sistema.today/api/v2/tokens	2026-06-05 13:14:43.794204	{"role_id": null, "agency_id": null, "remote_ip": "172.71.156.202", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1690	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-05 13:14:53.828805	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1691	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:14:53.847189	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1692	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:14:53.862036	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1693	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:14:53.879319	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1694	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:14:53.896149	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1695	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:14:53.914218	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1696	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:14:53.930333	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1697	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:14:53.948431	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1698	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:14:53.964186	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1699	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:15:03.991142	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1700	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:15:04.007275	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1701	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:15:04.02396	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1702	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:15:04.040726	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1703	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:15:04.056992	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1704	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:15:09.079877	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.100", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1705	Agency	2	12	update	https://sistema.today/api/v2/agencies/2	2026-06-05 13:20:39.408058	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": ["2"], "http_method": "PATCH"}
1706	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:20:39.428125	{"role_id": 12, "agency_id": 1, "remote_ip": "104.23.248.101", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1707	Agency	2	12	show	https://sistema.today/api/v2/agencies/2	2026-06-05 13:22:09.536287	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["2"], "http_method": "GET"}
1708	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:22:09.555331	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1709	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:22:14.583787	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1710	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:22:14.605875	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1711	Agency	1	12	update	https://sistema.today/api/v2/agencies/1	2026-06-05 13:23:49.722088	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "PATCH"}
1712	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:23:49.738959	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1713	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:23:54.765081	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1714	Agency	1	12	update	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:10.041435	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "PATCH"}
1715	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:10.070981	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1716	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:25:15.114333	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1717	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:25.153147	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1718	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:25.176545	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1719	Agency	1	12	update	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:30.208127	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "PATCH"}
1720	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:25:30.234751	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1721	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:25:35.280343	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1722	User	\N	\N	logout	https://sistema.today/api/v2/tokens	2026-06-05 13:26:10.373538	{"role_id": null, "agency_id": null, "remote_ip": "172.68.7.207", "user_name": null, "record_ids": [], "http_method": "DELETE"}
1723	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-05 13:26:20.437805	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1724	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:26:20.488931	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1725	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:26:20.550597	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1726	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:26:20.595594	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1727	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:26:25.659885	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1728	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:26:25.680313	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1729	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:26:25.70477	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1730	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:26:25.724677	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1731	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:26:25.746442	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1732	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:26:35.781537	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1733	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:26:35.799298	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1734	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:26:35.817759	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1735	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:26:35.835565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1736	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&page=1&per=20&managed=true	2026-06-05 13:26:50.872153	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1737	Agency	1	12	show	https://sistema.today/api/v2/agencies/1	2026-06-05 13:27:10.916413	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": ["1"], "http_method": "GET"}
1738	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 13:27:10.934851	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1739	Report	\N	12	list	https://sistema.today/api/v2/reports	2026-06-05 13:28:31.090421	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1740	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:48:47.304325	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1741	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:48:47.334753	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1742	Child	\N	12	index	https://sistema.today/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:48:52.367132	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1743	Incident	\N	12	index	https://sistema.today/api/v2/incidents?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:48:52.392108	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1744	TracingRequest	\N	12	index	https://sistema.today/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:48:52.413483	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1745	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show	https://sistema.today/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-05 13:48:57.445585	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "GET"}
1746	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	show_alerts	https://sistema.today/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/alerts	2026-06-05 13:48:57.465933	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1747	TracingRequest	\N	12	traces	https://sistema.today/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-05 13:49:02.561534	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1748	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	12	update	https://sistema.today/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f	2026-06-05 13:50:52.859608	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": ["f9ea6df8-951a-4551-b8dc-e4552272df9f"], "http_method": "PATCH"}
1749	TracingRequest	\N	12	traces	https://sistema.today/api/v2/tracing_requests/f9ea6df8-951a-4551-b8dc-e4552272df9f/traces	2026-06-05 13:50:52.879413	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1750	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:51:02.910418	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1751	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:51:02.927331	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1752	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:51:02.944587	{"role_id": 12, "agency_id": 1, "remote_ip": "172.71.156.202", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1753	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 13:52:43.066715	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1754	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 13:52:43.092081	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1755	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 13:52:43.123968	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1756	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 13:52:43.147595	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1757	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 13:52:43.166487	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1758	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 13:52:43.188085	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1759	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 13:52:43.207619	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1760	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 13:52:43.228948	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1761	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:52:43.247528	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1762	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:52:43.26629	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1763	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:52:43.285974	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1764	CodeOfConduct	\N	12	list	https://sistema.today/api/v2/codes_of_conduct	2026-06-05 13:52:53.319481	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1765	PrimeroConfiguration	\N	12	index	https://sistema.today/api/v2/configurations?page=1&per=20	2026-06-05 13:58:58.679844	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1766	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 13:59:03.708212	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1767	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 13:59:03.724877	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1768	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 13:59:03.741162	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1769	Child	\N	12	index	https://sistema.today/api/v2/cases?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:59:08.766574	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1770	Incident	\N	12	index	https://sistema.today/api/v2/incidents?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:59:08.782657	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1771	TracingRequest	\N	12	index	https://sistema.today/api/v2/tracing_requests?fields=short&status%5B0%5D=open&record_state%5B0%5D=true&page=1&per=20	2026-06-05 13:59:08.800488	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1772	User	12	12	show	https://sistema.today/api/v2/users/12	2026-06-05 13:59:13.826581	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1773	Role	\N	12	list	https://sistema.today/api/v2/roles	2026-06-05 13:59:13.847469	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1774	User	12	12	show	https://sistema.today/api/v2/users/12	2026-06-05 13:59:23.881153	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1775	Role	\N	12	list	https://sistema.today/api/v2/roles	2026-06-05 13:59:23.898111	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1776	User	12	12	update	https://sistema.today/api/v2/users/12	2026-06-05 14:00:03.956174	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": ["12"], "http_method": "PATCH"}
1777	User	12	12	show	https://sistema.today/api/v2/users/12	2026-06-05 14:00:03.977016	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1778	Role	\N	12	list	https://sistema.today/api/v2/roles	2026-06-05 14:00:03.99847	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1779	User	12	12	show	https://sistema.today/api/v2/users/12	2026-06-05 14:00:09.030224	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1780	Role	\N	12	list	https://sistema.today/api/v2/roles	2026-06-05 14:00:09.047582	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1781	User	12	12	update	https://sistema.today/api/v2/users/12	2026-06-05 14:00:14.074419	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": ["12"], "http_method": "PATCH"}
1782	User	12	12	show	https://sistema.today/api/v2/users/12	2026-06-05 14:00:14.094759	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1783	Role	\N	12	list	https://sistema.today/api/v2/roles	2026-06-05 14:00:14.113758	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1784	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 14:00:19.14266	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1785	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 14:00:19.16329	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1786	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 14:02:04.31939	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.83.122", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1787	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 14:02:04.337288	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.82.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1788	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 14:02:04.3593	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.83.122", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1789	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&total=2&per=20&page=1&managed=true	2026-06-05 14:02:04.378214	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.83.121", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1790	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 14:08:59.803121	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1791	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 14:08:59.827427	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1792	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 14:08:59.848623	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1793	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 14:08:59.872226	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1794	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 14:08:59.892682	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1795	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 14:08:59.91735	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1796	Agency	\N	12	index	https://sistema.today/api/v2/agencies?disabled%5B0%5D=false&locale=es&managed=true	2026-06-05 14:08:59.942322	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1797	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-05 14:10:50.069417	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1798	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-05 14:10:50.091397	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1799	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 14:10:50.112595	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1800	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-05 14:10:50.133283	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1801	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 14:10:50.153052	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1802	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-05 14:10:50.174442	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1803	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-05 14:10:50.196963	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1804	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-05 14:10:50.219838	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1805	UserGroup	\N	12	list	https://sistema.today/api/v2/user_groups	2026-06-05 14:10:55.251541	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1806	User	\N	12	index	https://sistema.today/api/v2/users?disabled%5B0%5D=false&locale=es&page=1&per=20	2026-06-05 14:10:55.271614	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1807	Agency	\N	12	index	https://sistema.today/api/v2/agencies?managed=true	2026-06-05 14:10:55.291931	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1808	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 14:11:00.320368	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1809	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-05 14:11:05.349407	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1810	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 14:11:05.368565	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1811	FormSection	32	12	show	https://sistema.today/api/v2/forms/32	2026-06-05 14:11:05.385996	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.207", "user_name": "admin", "record_ids": ["32"], "http_method": "GET"}
1812	FormSection	32	12	update	https://sistema.today/api/v2/forms/32	2026-06-05 14:11:30.428334	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": ["32"], "http_method": "PATCH"}
1813	FormSection	32	12	show	https://sistema.today/api/v2/forms/32	2026-06-05 14:11:30.447471	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": ["32"], "http_method": "GET"}
1814	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-05 14:12:05.499099	{"role_id": 12, "agency_id": 1, "remote_ip": "172.68.7.206", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1815	User	12	12	login	https://sistema.today/api/v2/tokens	2026-06-08 13:12:12.767143	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "POST"}
1816	User	12	12	show	https://sistema.today/api/v2/users/12?extended=true	2026-06-08 13:12:12.803765	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": ["12"], "http_method": "GET"}
1817	Permission	\N	12	list	https://sistema.today/api/v2/permissions	2026-06-08 13:12:12.823056	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1818	SystemSettings	\N	12	index	https://sistema.today/api/v2/system_settings?extended=true	2026-06-08 13:12:12.841513	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1819	Lookup	\N	12	index	https://sistema.today/api/v2/lookups?per=999&page=1	2026-06-08 13:12:12.859877	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1820	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=dash_protection_concerns	2026-06-08 13:12:12.880073	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1821	FormSection	\N	12	list	https://sistema.today/api/v2/forms	2026-06-08 13:12:12.899285	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1822	Alert	\N	12	bulk_index	https://sistema.today/api/v2/alerts	2026-06-08 13:12:12.935848	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.32", "user_name": "admin", "record_ids": [], "http_method": "GET"}
1823	Dashboard	\N	12	index	https://sistema.today/api/v2/dashboards?names%5B0%5D=reporting_location	2026-06-08 13:12:12.95436	{"role_id": 12, "agency_id": 1, "remote_ip": "172.70.54.33", "user_name": "admin", "record_ids": [], "http_method": "GET"}
\.


--
-- Data for Name: bulk_exports; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.bulk_exports (id, status, owned_by, started_on, completed_on, format, record_type, model_range, filters, "order", query, match_criteria, custom_export_params, file_name, password_ciphertext, type) FROM stdin;
\.


--
-- Data for Name: case_relationships; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.case_relationships (id, from_case_id, to_case_id, relationship_type, disabled, "primary", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.cases (id, data, matched_tracing_request_id, matched_trace_id, duplicate_case_id, registry_record_id, family_id, phonetic_data, srch_age, srch_created_at, srch_registration_date, srch_name, srch_module_id, srch_location_current, srch_client_code, srch_date_closure, srch_owned_by, srch_owned_by_agency_id, srch_owned_by_location, srch_last_updated_by, srch_record_state, srch_consent_reporting, srch_status, srch_risk_level, srch_workflow, srch_not_edited_by_owner, srch_flagged, srch_approval_status_assessment, srch_approval_status_case_plan, srch_approval_status_closure, srch_approval_status_action_plan, srch_approval_status_gbv_closure, srch_reassigned_transferred_on, srch_referred_users_present, srch_has_incidents, srch_transfer_status, srch_gender, srch_psychsocial_assessment_score_initial, srch_psychsocial_assessment_score_most_recent, srch_client_summary_worries_severity_int, srch_closure_problems_severity_int, srch_begin_safety_plan_prompt, srch_disability_status_yes_no, srch_owned_by_groups, srch_associated_user_agencies, srch_associated_user_names, srch_associated_user_groups, srch_transferred_to_users, srch_transferred_to_user_groups, srch_referred_users, srch_current_alert_types, srch_case_plan_due_dates, srch_service_due_dates, srch_assessment_due_dates, srch_followup_due_dates, srch_protection_concerns, srch_protection_risks, srch_next_steps, srch_assigned_user_names, srch_sex, srch_identified_by, srch_identified_by_full_name, srch_identified_at) FROM stdin;
\.


--
-- Data for Name: codes_of_conduct; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.codes_of_conduct (id, created_on, created_by, title, content) FROM stdin;
1	2026-06-03 15:33:35.380553	admin	# CÓDIGO DE CONDUCTA DEL PERSONAL	## Programa de Localización y Reunificación Familiar (LRF)\n\n### ASONACOP\n\n**Versión 1.0**\n\n---\n\n# 1. PROPÓSITO\n\nEl presente Código de Conducta establece los principios éticos, normas de comportamiento y responsabilidades que deben cumplir todas las personas que participen en el Programa de Localización y Reunificación Familiar (LRF) de ASONACOP, independientemente de su cargo, modalidad de contratación o nivel de responsabilidad.\n\nSu objetivo es garantizar la protección, dignidad, seguridad y bienestar de las personas atendidas, especialmente niñas, niños y adolescentes, así como promover un ambiente laboral respetuoso, profesional y transparente.\n\n---\n\n# 2. ALCANCE\n\nEste Código aplica a:\n\n* Empleados.\n* Consultores.\n* Voluntarios.\n* Pasantes.\n* Contratistas.\n* Personal temporal.\n* Socios implementadores.\n* Cualquier persona autorizada para acceder al Sistema LRF o manejar información relacionada con los casos.\n\n---\n\n# 3. PRINCIPIOS FUNDAMENTALES\n\nTodo el personal deberá actuar conforme a los siguientes principios:\n\n### 3.1 Humanidad\n\nRespetar la dignidad humana y actuar en beneficio de las personas afectadas.\n\n### 3.2 Imparcialidad\n\nBrindar atención sin discriminación por:\n\n* Nacionalidad.\n* Género.\n* Edad.\n* Etnia.\n* Religión.\n* Orientación sexual.\n* Condición social.\n* Situación migratoria.\n* Discapacidad.\n\n### 3.3 Neutralidad\n\nNo utilizar el programa para favorecer intereses políticos, religiosos o personales.\n\n### 3.4 Independencia\n\nTomar decisiones basadas únicamente en criterios técnicos y humanitarios.\n\n### 3.5 Confidencialidad\n\nProteger toda la información obtenida durante el ejercicio de sus funciones.\n\n---\n\n# 4. COMPORTAMIENTO ESPERADO\n\nTodo trabajador deberá:\n\n### 4.1\n\nTratar a las personas atendidas con:\n\n* Respeto.\n* Cortesía.\n* Empatía.\n* Profesionalismo.\n\n### 4.2\n\nMantener una conducta ética dentro y fuera de las instalaciones cuando represente a ASONACOP.\n\n### 4.3\n\nCumplir las leyes nacionales aplicables y las políticas internas de la organización.\n\n### 4.4\n\nReportar inmediatamente cualquier situación que pueda poner en riesgo a las personas atendidas.\n\n### 4.5\n\nUtilizar adecuadamente los recursos institucionales.\n\n### 4.6\n\nPromover ambientes libres de violencia, discriminación y acoso.\n\n---\n\n# 5. PROTECCIÓN DE NIÑAS, NIÑOS Y ADOLESCENTES\n\nTodo el personal deberá:\n\n### 5.1\n\nVelar por el interés superior del niño.\n\n### 5.2\n\nEvitar cualquier conducta que pueda generar daño físico, psicológico o emocional.\n\n### 5.3\n\nMantener límites profesionales adecuados.\n\n### 5.4\n\nInformar inmediatamente cualquier sospecha de:\n\n* Abuso.\n* Explotación.\n* Negligencia.\n* Violencia.\n\n### 5.5\n\nNunca utilizar lenguaje ofensivo, humillante o intimidatorio.\n\n---\n\n# 6. PROHIBICIONES\n\nEstá estrictamente prohibido:\n\n### 6.1\n\nSolicitar o aceptar:\n\n* Sobornos.\n* Comisiones.\n* Favores.\n* Beneficios personales.\n\n### 6.2\n\nUtilizar información de los casos para fines personales.\n\n### 6.3\n\nDivulgar información confidencial sin autorización.\n\n### 6.4\n\nTomar fotografías, grabaciones o capturas de pantalla de casos sin autorización institucional.\n\n### 6.5\n\nRealizar discriminación por cualquier motivo.\n\n### 6.6\n\nManipular o alterar registros del sistema.\n\n### 6.7\n\nCompartir usuarios o contraseñas de acceso.\n\n### 6.8\n\nAcceder a casos para los cuales no posea autorización.\n\n### 6.9\n\nUtilizar equipos institucionales para actividades ilícitas o ajenas al trabajo.\n\n---\n\n# 7. USO DEL SISTEMA DE LOCALIZACIÓN Y REUNIFICACIÓN FAMILIAR\n\nTodo usuario autorizado deberá:\n\n### 7.1\n\nMantener la confidencialidad de sus credenciales.\n\n### 7.2\n\nCerrar sesión al finalizar sus actividades.\n\n### 7.3\n\nRegistrar información veraz y verificable.\n\n### 7.4\n\nActualizar oportunamente los expedientes asignados.\n\n### 7.5\n\nNo eliminar, modificar o alterar registros sin autorización.\n\n### 7.6\n\nReportar incidentes de seguridad informática de forma inmediata.\n\n---\n\n# 8. CONFIDENCIALIDAD Y PROTECCIÓN DE DATOS\n\nToda la información contenida en el sistema LRF será considerada confidencial.\n\nEl personal deberá:\n\n* Proteger expedientes físicos y digitales.\n* Limitar el acceso únicamente a personal autorizado.\n* No divulgar información en redes sociales.\n* No compartir bases de datos mediante medios no autorizados.\n* Cumplir las políticas de protección de datos de ASONACOP y de los organismos cooperantes.\n\nLa obligación de confidencialidad permanecerá vigente incluso después de finalizar la relación laboral.\n\n---\n\n# 9. PREVENCIÓN DE EXPLOTACIÓN Y ABUSO SEXUAL (PEAS)\n\nASONACOP mantiene una política de tolerancia cero frente a:\n\n* Explotación sexual.\n* Abuso sexual.\n* Acoso sexual.\n* Relaciones abusivas con personas beneficiarias.\n\nTodo trabajador deberá reportar cualquier sospecha o denuncia relacionada con estas conductas.\n\n---\n\n# 10. CONFLICTO DE INTERÉS\n\nLos trabajadores deberán evitar situaciones en las cuales sus intereses personales puedan influir en sus decisiones profesionales.\n\nTodo conflicto de interés real o potencial deberá ser declarado a la coordinación del programa.\n\n---\n\n# 11. DENUNCIAS\n\nToda persona podrá reportar:\n\n* Incumplimientos del presente Código.\n* Actos de corrupción.\n* Violaciones de protección infantil.\n* Violaciones de confidencialidad.\n* Conductas indebidas.\n\nLas denuncias serán tratadas de forma confidencial y sin represalias.\n\n---\n\n# 12. MEDIDAS DISCIPLINARIAS\n\nEl incumplimiento de este Código podrá generar:\n\n* Amonestación verbal.\n* Amonestación escrita.\n* Suspensión temporal.\n* Revocación de accesos al sistema.\n* Terminación de la relación contractual.\n* Notificación a las autoridades competentes cuando corresponda.\n\n---\n\n# 13. DECLARACIÓN DE COMPROMISO\n\nYo, _____________________________________________, declaro haber leído, comprendido y aceptado cumplir el presente Código de Conducta del Programa de Localización y Reunificación Familiar (LRF) de ASONACOP.\n\nAsimismo, me comprometo a actuar de manera ética, profesional y responsable, respetando los principios de protección, confidencialidad y dignidad de las personas atendidas.\n\n**Nombre:** ___________________________________\n\n**Cargo:** _____________________________________\n\n**Firma:** _____________________________________\n\n**Fecha:** _____________________________________\n\n---\n\n**ASONACOP – Programa de Localización y Reunificación Familiar (LRF)**\n**Versión Institucional para Personal, Consultores y Voluntarios**.\n
\.


--
-- Data for Name: contact_informations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.contact_informations (id, name, organization, phone, location, other_information, support_forum, email, "position", created_at, updated_at) FROM stdin;
1	administrator	\N	\N	\N	\N	\N	\N	\N	2026-04-22 19:33:53.686054	2026-04-22 19:33:53.686054
\.


--
-- Data for Name: delayed_jobs; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.delayed_jobs (id, priority, attempts, handler, last_error, run_at, locked_at, failed_at, locked_by, queue, created_at, updated_at) FROM stdin;
2049	0	0	--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: SessionCleanup\n  job_id: 9b547fee-a7cf-440d-9111-9b053f142416\n  provider_job_id:\n  queue_name: long_running_process\n  priority:\n  arguments: []\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2026-06-09T20:34:00Z'\n	\N	2026-06-09 21:34:00.323361	\N	\N	\N	long_running_process	2026-06-09 20:34:00.329581	2026-06-09 20:34:00.329581
2045	0	0	--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ArchiveBulkExports\n  job_id: 6341748d-68c2-458a-bd3f-c1231608436e\n  provider_job_id:\n  queue_name: long_running_process\n  priority:\n  arguments: []\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2026-06-09T20:11:38Z'\n	\N	2026-06-10 20:11:38.380612	\N	\N	\N	long_running_process	2026-06-09 20:11:38.393791	2026-06-09 20:11:38.393791
2046	0	0	--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: RecalculateAge\n  job_id: c8f55845-ded3-4885-bc63-9a14d557b220\n  provider_job_id:\n  queue_name: long_running_process\n  priority:\n  arguments: []\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2026-06-09T20:11:38Z'\n	\N	2026-06-10 20:11:38.446324	\N	\N	\N	long_running_process	2026-06-09 20:11:38.449199	2026-06-09 20:11:38.449199
2047	0	0	--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: GenerateUnusedFieldsReport\n  job_id: 482484e4-910f-4209-bdfb-2800690712f3\n  provider_job_id:\n  queue_name: long_running_process\n  priority:\n  arguments: []\n  executions: 0\n  exception_executions: {}\n  locale: en\n  timezone: UTC\n  enqueued_at: '2026-06-09T20:11:38Z'\n	\N	2026-06-10 20:11:38.527684	\N	\N	\N	long_running_process	2026-06-09 20:11:38.530123	2026-06-09 20:11:38.530123
\.


--
-- Data for Name: export_configurations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.export_configurations (id, unique_id, export_id, name_i18n, property_keys, record_type, opt_out_field, property_keys_opt_out, created_at, updated_at) FROM stdin;
1	export-unhcr-csv	unhcr_csv	{"en": "UNHCR CSV Export"}	{individual_progress_id,cpims_code,date_of_identification,primary_protection_concerns,secondary_protection_concerns,governorate_country,sex,date_of_birth,age,causes_of_separation,country_of_origin,current_care_arrangement,reunification_status,case_status}	Child	unhcr_export_opt_out	{cpims_code}	2026-04-22 19:33:46.941974	2026-04-22 19:33:46.941974
2	export-unhcr-csv-jo	unhcr_csv	{"en": "UNHCR CSV Export Jordan"}	{individual_progress_id,cpims_code,date_of_identification,primary_protection_concerns,secondary_protection_concerns,governorate_country,sex,date_of_birth,age,causes_of_separation,country_of_origin,current_care_arrangement,reunification_status,case_status}	Child	unhcr_export_opt_out	{cpims_code}	2026-04-22 19:33:46.949365	2026-04-22 19:33:46.949365
3	export-duplicate-id-csv	duplicate_id_csv	{"en": "Duplicate ID CSV Export"}	{national_id_no,child_name_last_first,progress_id,age,sex,family_size,case_id}	Child	\N	{}	2026-04-22 19:33:46.956572	2026-04-22 19:33:46.956572
\.


--
-- Data for Name: families; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.families (id, data, phonetic_data, srch_created_at, srch_family_registration_date, srch_status, srch_record_state, srch_flagged, srch_not_edited_by_owner, srch_family_location_current, srch_owned_by_groups, srch_associated_user_agencies, srch_associated_user_names, srch_associated_user_groups, srch_owned_by, srch_owned_by_agency_id, srch_assigned_user_names) FROM stdin;
\.


--
-- Data for Name: fields; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.fields (id, name, type, multi_select, form_section_id, visible, mobile_visible, hide_on_view_page, show_on_minify_form, editable, disabled, display_name_i18n, help_text_i18n, guiding_questions_i18n, tally_i18n, tick_box_label_i18n, option_strings_text_i18n, option_strings_source, "order", hidden_text_field, subform_section_id, collapsed_field_for_subform_section_id, autosum_total, autosum_group, selected_value, link_to_path, link_to_path_external, field_tags, custom_template, expose_unique_id, required, date_validation, date_include_time, matchable, subform_section_configuration, mandatory_for_completion, created_at, updated_at, display_conditions_record, display_conditions_subform, collapse, option_strings_condition, calculation, subform_summary) FROM stdin;
1107	cp_incident_perpetrator_national_id_no	text_field	f	21	t	t	f	f	t	f	{"en": "National ID Number", "es": "Número de identificación nacional"}	\N	\N	\N	\N	\N	\N	17	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.239821	2026-06-01 20:47:08.010874	\N	\N	\N	\N	\N	\N
953	assessment_approved	tick_box	f	2	t	t	f	f	f	t	{"en": "Approved by Manager", "es": "Aprobado por el responsable"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.63279	2026-06-01 20:47:06.917899	\N	\N	\N	\N	\N	\N
954	assessment_approved_date	date_field	f	2	t	t	f	f	f	t	{"en": "Date", "es": "Fecha"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.68621	2026-06-01 20:47:06.925791	\N	\N	\N	\N	\N	\N
955	assessment_approved_comments	textarea	f	2	t	t	f	f	f	t	{"en": "Manager Comments", "es": "Comentarios del responsable"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.691805	2026-06-01 20:47:06.933828	\N	\N	\N	\N	\N	\N
956	approval_status_assessment	select_box	f	2	t	t	f	f	f	t	{"en": "Approval Status", "es": "Estado de aprobación"}	\N	\N	\N	\N	\N	lookup lookup-approval-status	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.696818	2026-06-01 20:47:06.941449	\N	\N	\N	\N	\N	\N
1005	name_caregiver_separator	separator	f	5	t	t	f	f	t	f	{"en": "If not with parents, main person caring for the child.", "es": "Si no está con sus padres, persona principal a cargo del niño"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.104574	2026-06-01 20:50:16.724483	\N	\N	\N	\N	\N	\N
1108	cp_incident_perpetrator_other_id_type	text_field	f	21	t	t	f	f	t	f	{"en": "Type of Other ID Document", "es": "Tipo de otro documento de identidad"}	\N	\N	\N	\N	\N	\N	18	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.245248	2026-06-01 20:47:08.017528	\N	\N	\N	\N	\N	\N
1003	care_arrangements_type_notes	textarea	f	5	f	t	f	f	t	f	{"en": "Care Arrangement Notes"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.091708	2026-06-01 20:20:30.170317	\N	\N	\N	\N	\N	\N
1004	care_agency_name	text_field	f	5	f	t	f	f	t	f	{"en": "Name of Agency Providing Care Arrangements"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.098159	2026-06-01 20:20:30.171226	\N	\N	\N	\N	\N	\N
957	assessment_requested_on	date_field	f	2	t	t	f	f	f	f	{"en": "Assessment started on", "es": "Evaluación iniciada el"}	{"en": "This field is used for the Workflow status.", "es": "Este campo se utiliza para el estado del flujo de trabajo."}	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.701881	2026-06-01 20:47:06.955985	\N	\N	\N	\N	\N	\N
958	case_plan_due_date	date_field	f	2	t	t	f	f	f	f	{"en": "Date Case Plan Due", "es": "Fecha límite del plan del caso"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.70716	2026-06-01 20:47:06.963941	\N	\N	\N	\N	\N	\N
959	case_id	text_field	f	3	f	f	f	f	f	t	{"en": "Long ID", "es": "ID largo"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.74087	2026-06-01 20:47:06.987212	\N	\N	\N	\N	\N	\N
960	short_id	text_field	f	3	f	f	f	f	f	t	{"en": "Short ID", "es": "ID corto"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.746093	2026-06-01 20:47:06.99473	\N	\N	\N	\N	\N	\N
961	case_id_display	text_field	f	3	t	t	f	f	f	t	{"en": "Case ID", "es": "ID del caso"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.750923	2026-06-01 20:47:07.003	\N	\N	\N	\N	\N	\N
1010	relationship_caregiver	select_box	f	5	t	t	f	f	t	f	{"en": "Relationship to child", "es": "Relación con el niño"}	\N	\N	\N	\N	\N	lookup lookup-family-relationship	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.135126	2026-06-01 20:50:16.766867	\N	\N	\N	\N	\N	\N
962	cpims_id	text_field	f	3	t	t	f	f	t	f	{"en": "CPIMS ID", "es": "ID de CPIMS"}	{"en": "Legacy CPIMS (or other system) ID", "es": "ID del CPIMS anterior u otro sistema"}	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.756095	2026-06-01 20:47:07.017643	\N	\N	\N	\N	\N	\N
1019	wishes_preference_relocated	select_box	f	8	t	t	f	f	t	f	{"en": "Preference of the child to be relocated with this person", "es": "Preferencia del niño de ser reubicado con esta persona"}	\N	\N	\N	\N	[{"id": "first_choice", "display_text": {"en": "First choice"}}, {"id": "second_choice", "display_text": {"en": "Second choice"}}, {"id": "third_choice", "display_text": {"en": "Third choice"}}]	\N	1	f	\N	8	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.295861	2026-06-01 20:50:16.870321	\N	\N	\N	\N	\N	\N
963	marked_for_mobile	tick_box	f	3	f	f	f	f	f	t	{"en": "Marked for offline?", "es": "¿Marcado para uso sin conexión?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.761	2026-06-01 20:47:07.036209	\N	\N	\N	\N	\N	\N
964	status	select_box	f	3	t	t	f	f	f	t	{"en": "Case Status", "es": "Estado del caso"}	\N	\N	\N	\N	\N	lookup lookup-case-status	5	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.766433	2026-06-01 20:47:07.043414	\N	\N	\N	\N	\N	\N
1020	wishes_relationship	select_box	f	8	t	t	f	f	t	f	{"en": "What is this person's relationship to the child?", "es": "¿Cuál es la relación de esta persona con el niño?"}	\N	\N	\N	\N	\N	lookup lookup-family-relationship	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.302128	2026-06-01 20:50:16.877139	\N	\N	\N	\N	\N	\N
1074	relation_telephone	text_field	f	14	t	t	f	f	t	f	{"en": "Telephone", "es": "Teléfono"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.868442	2026-06-01 20:50:17.178892	\N	\N	\N	\N	\N	\N
1075	relation_other_family	text_field	f	14	t	t	f	f	t	f	{"en": "Other persons well known to the child", "es": "Otras personas conocidas por el niño"}	\N	\N	\N	\N	\N	\N	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.880464	2026-06-01 20:50:17.185004	\N	\N	\N	\N	\N	\N
1072	relation_address_current	textarea	f	14	t	t	f	f	t	f	{"en": "Current Address", "es": "Dirección actual"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.850453	2026-06-01 20:47:07.806523	\N	\N	\N	\N	\N	\N
997	upload_bid_document	document_upload_box	f	4	t	t	f	f	f	t	{"en": "BID Document", "es": "Documento BID"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.034416	2026-06-01 20:50:16.675695	\N	\N	\N	\N	\N	\N
965	case_status_reopened	tick_box	f	3	t	t	f	f	f	t	{"en": "Case Reopened?", "es": "¿Caso reabierto?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.771398	2026-06-01 20:47:07.058513	\N	\N	\N	\N	\N	\N
966	name	text_field	f	3	t	t	f	t	t	t	{"en": "Full Name", "es": "Nombre completo"}	\N	\N	\N	\N	\N	\N	7	t	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.776198	2026-06-01 20:47:07.066951	\N	\N	\N	\N	\N	\N
967	name_first	text_field	f	3	t	t	t	t	t	f	{"en": "First Name", "es": "Nombre"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	t	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.781578	2026-06-01 20:47:07.07739	\N	\N	\N	\N	\N	\N
968	name_middle	text_field	f	3	t	t	t	t	t	f	{"en": "Middle Name", "es": "Segundo nombre"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.787071	2026-06-01 20:47:07.100961	\N	\N	\N	\N	\N	\N
969	name_last	text_field	f	3	t	t	t	t	t	f	{"en": "Surname", "es": "Apellido"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	t	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.792686	2026-06-01 20:47:07.111081	\N	\N	\N	\N	\N	\N
1002	care_arrangements_type_other	text_field	f	5	t	t	f	f	t	f	{"en": "If Other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.085291	2026-06-01 20:47:07.341725	\N	\N	\N	\N	\N	\N
1073	relation_location_current	select_box	f	14	t	t	f	f	t	f	{"en": "Current Location", "es": "Ubicación actual"}	\N	\N	\N	\N	\N	Location	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.85944	2026-06-01 20:47:07.813183	\N	\N	\N	\N	\N	\N
1061	relation_is_caregiver	tick_box	f	14	t	t	f	f	t	f	{"en": "Is this person the caregiver?", "es": "¿Esta persona es el cuidador?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.765214	2026-06-01 20:50:17.133751	\N	\N	\N	\N	\N	\N
1109	cp_incident_perpetrator_other_id_no	text_field	f	21	t	t	f	f	t	f	{"en": "Number of Other ID Document", "es": "Número de otro documento de identidad"}	\N	\N	\N	\N	\N	\N	19	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.25068	2026-06-01 20:47:08.024326	\N	\N	\N	\N	\N	\N
1063	relation_is_alive	select_box	f	14	t	t	f	f	t	f	{"en": "Is this family member alive?", "es": "¿Este familiar está vivo?"}	\N	\N	\N	\N	[{"id": "unknown", "display_text": {"en": "Unknown"}}, {"id": "alive", "display_text": {"en": "Alive"}}, {"id": "dead", "display_text": {"en": "Dead"}}]	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.777706	2026-06-01 20:50:17.143895	\N	\N	\N	\N	\N	\N
978	ration_card_no	text_field	f	3	f	t	f	f	t	f	{"en": "Ration Card Number"}	\N	\N	\N	\N	\N	\N	19	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.840664	2026-06-01 20:20:30.005373	\N	\N	\N	\N	\N	\N
979	icrc_ref_no	text_field	f	3	f	t	f	f	t	f	{"en": "ICRC Ref No."}	\N	\N	\N	\N	\N	\N	20	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.845618	2026-06-01 20:20:30.006076	\N	\N	\N	\N	\N	\N
980	rc_id_no	text_field	f	3	f	t	f	f	t	f	{"en": "RC ID No."}	\N	\N	\N	\N	\N	\N	21	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.850812	2026-06-01 20:20:30.00683	\N	\N	\N	\N	\N	\N
981	unhcr_id_no	text_field	f	3	f	t	f	f	t	f	{"en": "proGres Case ID"}	{"en": "UNHCR Asylum Seeker Certificate Number"}	\N	\N	\N	\N	\N	22	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.856257	2026-06-01 20:20:30.007552	\N	\N	\N	\N	\N	\N
982	unhcr_individual_no	text_field	f	3	f	t	f	f	t	f	{"en": "proGres Individual ID"}	{"en": "This ID is shown on the tracking sheet."}	\N	\N	\N	\N	\N	23	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.861515	2026-06-01 20:20:30.008364	\N	\N	\N	\N	\N	\N
983	un_no	text_field	f	3	f	t	f	f	t	f	{"en": "UN Number"}	\N	\N	\N	\N	\N	\N	24	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.866868	2026-06-01 20:20:30.009158	\N	\N	\N	\N	\N	\N
985	family_number	text_field	f	3	f	t	f	f	t	f	{"en": "Family Number"}	\N	\N	\N	\N	\N	\N	26	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.877076	2026-06-01 20:20:30.010719	\N	\N	\N	\N	\N	\N
970	name_nickname	text_field	f	3	t	t	f	t	t	f	{"en": "Nickname", "es": "Apodo"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.79768	2026-06-01 20:47:07.121936	\N	\N	\N	\N	\N	\N
971	name_other	text_field	f	3	t	t	f	f	t	f	{"en": "Other Name", "es": "Otro nombre"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.802695	2026-06-01 20:47:07.130882	\N	\N	\N	\N	\N	\N
972	registration_date	date_field	f	3	t	t	f	f	t	f	{"en": "Date of Registration or Interview", "es": "Fecha de registro o entrevista"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	today	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:29.808038	2026-06-01 20:47:07.140102	\N	\N	\N	\N	\N	\N
973	assessment_due_date	date_field	f	3	t	t	f	f	f	f	{"en": "Date Assessment Due", "es": "Fecha límite de evaluación"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.813576	2026-06-01 20:47:07.149788	\N	\N	\N	\N	\N	\N
974	sex	select_box	f	3	t	t	f	t	t	f	{"en": "Sex", "es": "Sexo"}	\N	\N	\N	\N	\N	lookup lookup-gender	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	t	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.819678	2026-06-01 20:47:07.157951	\N	\N	\N	\N	\N	\N
975	age	numeric_field	f	3	t	t	f	t	t	f	{"en": "Age", "es": "Edad"}	\N	\N	\N	\N	\N	\N	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	t	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.825184	2026-06-01 20:47:07.166064	\N	\N	\N	\N	\N	\N
976	date_of_birth	date_field	f	3	t	t	f	t	t	f	{"en": "Date of Birth", "es": "Fecha de nacimiento"}	\N	\N	\N	\N	\N	\N	17	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.830646	2026-06-01 20:47:07.173742	\N	\N	\N	\N	\N	\N
977	estimated	tick_box	f	3	t	t	f	t	t	f	{"en": "Is the age estimated?", "es": "¿La edad es estimada?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	18	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.835866	2026-06-01 20:47:07.190667	\N	\N	\N	\N	\N	\N
984	national_id_no	text_field	f	3	t	t	f	f	t	f	{"en": "National ID Number", "es": "Número de identificación nacional"}	\N	\N	\N	\N	\N	\N	25	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.872188	2026-06-01 20:47:07.198998	\N	\N	\N	\N	\N	\N
986	other_id_type	text_field	f	3	t	t	f	f	t	f	{"en": "Type of Other ID Document", "es": "Tipo de otro documento de identidad"}	\N	\N	\N	\N	\N	\N	27	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.882487	2026-06-01 20:47:07.206274	\N	\N	\N	\N	\N	\N
987	other_id_no	text_field	f	3	t	t	f	f	t	f	{"en": "Number of Other ID Document", "es": "Número de otro documento de identidad"}	\N	\N	\N	\N	\N	\N	28	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.887431	2026-06-01 20:47:07.213975	\N	\N	\N	\N	\N	\N
988	other_agency_id	text_field	f	3	t	t	f	f	t	f	{"en": "Other Agency ID", "es": "ID de otra agencia"}	\N	\N	\N	\N	\N	\N	29	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.892675	2026-06-01 20:47:07.22063	\N	\N	\N	\N	\N	\N
989	other_agency_name	text_field	f	3	t	t	f	f	t	f	{"en": "Other Agency Name", "es": "Nombre de otra agencia"}	\N	\N	\N	\N	\N	\N	30	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.897975	2026-06-01 20:47:07.227585	\N	\N	\N	\N	\N	\N
990	nationality	select_box	t	3	t	t	f	f	t	f	{"en": "Nationality", "es": "Nacionalidad"}	\N	\N	\N	\N	\N	lookup lookup-country	31	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:29.903535	2026-06-01 20:47:07.234231	\N	\N	\N	\N	\N	\N
991	maritial_status	select_box	f	3	t	t	f	t	t	f	{"en": "Current Civil/Marital Status", "es": "Estado civil actual"}	\N	\N	\N	\N	\N	lookup lookup-marital-status	32	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.90921	2026-06-01 20:47:07.243267	\N	\N	\N	\N	\N	\N
992	occupation	text_field	f	3	t	t	f	f	t	f	{"en": "Occupation", "es": "Ocupación"}	\N	\N	\N	\N	\N	\N	33	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.914667	2026-06-01 20:47:07.250818	\N	\N	\N	\N	\N	\N
993	address_current	textarea	f	3	t	t	f	f	t	f	{"en": "Current Address", "es": "Dirección actual"}	\N	\N	\N	\N	\N	\N	34	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.920052	2026-06-01 20:47:07.259268	\N	\N	\N	\N	\N	\N
994	location_current	select_box	f	3	t	t	f	f	t	f	{"en": "Current Location", "es": "Ubicación actual"}	\N	\N	\N	\N	\N	Location	35	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.925337	2026-06-01 20:47:07.266177	\N	\N	\N	\N	\N	\N
995	address_is_permanent	tick_box	f	3	t	t	f	f	t	f	{"en": "Is this address permanent?", "es": "¿Esta dirección es permanente?"}	\N	\N	\N	\N	\N	\N	36	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.930635	2026-06-01 20:47:07.273814	\N	\N	\N	\N	\N	\N
996	telephone_current	text_field	f	3	t	t	f	f	t	f	{"en": "Current Telephone", "es": "Teléfono actual"}	\N	\N	\N	\N	\N	\N	37	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:29.935959	2026-06-01 20:47:07.282038	\N	\N	\N	\N	\N	\N
1001	care_arrangements_type	select_box	f	5	t	t	f	f	t	f	{"en": "What are the child's current care arrangements?", "es": "¿Cuáles son los acuerdos de cuidado actuales del niño?"}	\N	\N	\N	\N	\N	lookup lookup-care-arrangements-type	3	f	\N	5	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.078228	2026-06-01 20:47:07.335199	\N	\N	\N	\N	\N	\N
1006	name_caregiver	text_field	f	5	t	t	f	f	t	f	{"en": "Name of Current Caregiver", "es": "Nombre del cuidador actual"}	{"en": "If the child is with the parents, proceed to Care Arrangements."}	\N	\N	\N	\N	\N	8	f	\N	5	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.111358	2026-06-01 20:47:07.348273	\N	\N	\N	\N	\N	\N
1011	care_arrangement_started_date	date_field	f	5	t	t	f	f	t	f	{"en": "When did this care arrangement start?", "es": "¿Cuándo comenzó este acuerdo de cuidado?"}	\N	\N	\N	\N	\N	\N	13	f	\N	5	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.14118	2026-06-01 20:47:07.355122	\N	\N	\N	\N	\N	\N
1000	care_arrangements_include_referral_form	tick_box	f	5	t	t	f	f	t	f	{"en": "If this is the current caregiver, include in the Referral Details form?", "es": "Si es el cuidador actual, ¿incluirlo en el formulario de detalles de derivación?"}	{"en": "Only include if the person being referred is a child", "es": "Incluir solo si la persona derivada es un niño"}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.07109	2026-06-01 20:50:16.713615	\N	\N	\N	\N	\N	\N
998	child_caregiver_status	radio_button	f	5	f	t	f	f	t	f	{"en": "Is this a same caregiver as was previously entered for the child?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.056052	2026-06-01 20:20:30.165832	\N	\N	\N	\N	\N	\N
1064	relation_death_details	textarea	f	14	t	t	f	f	t	f	{"en": "If dead, please provide details", "es": "Si falleció, proporcione detalles"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.784801	2026-06-01 20:50:17.150366	\N	\N	\N	\N	\N	\N
1111	cp_incident_perpetrator_occupation	text_field	f	21	t	t	f	f	t	f	{"en": "Occupation", "es": "Ocupación"}	\N	\N	\N	\N	\N	\N	21	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.260934	2026-06-01 20:47:08.034374	\N	\N	\N	\N	\N	\N
1110	cp_incident_perpetrator_marital_status	select_box	f	21	t	t	f	t	t	f	{"en": "Social Status", "es": "Estado social"}	\N	\N	\N	\N	\N	lookup lookup-marital-status	20	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.255886	2026-06-01 20:50:17.446464	\N	\N	\N	\N	\N	\N
1112	cp_incident_perpetrator_relationship	select_box	f	21	t	t	f	f	t	f	{"en": "Relationship with the victim", "es": "Relación con la víctima"}	\N	\N	\N	\N	\N	lookup lookup-perpetrator-relationship	22	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.266344	2026-06-01 20:50:17.454078	\N	\N	\N	\N	\N	\N
1091	cp_incident_violence_header	separator	f	21	t	t	f	f	t	f	{"en": "Incident", "es": "Incidente"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.152929	2026-06-01 20:50:17.341656	\N	\N	\N	\N	\N	\N
1196	service_implemented_day_time	date_field	f	37	t	t	f	f	t	f	{"en": "Service Implemented On", "es": "Fecha de implementación del servicio"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:32.150517	2026-06-01 20:50:17.894618	\N	\N	\N	\N	\N	\N
1197	note_on_referral_from_provider	textarea	f	37	t	t	f	f	f	t	{"en": "Notes on the referral from provider", "es": "Notas del proveedor sobre la derivación"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.155993	2026-06-01 20:50:17.900716	\N	\N	\N	\N	\N	\N
1183	service_response_type	select_box	f	37	t	t	f	f	t	f	{"en": "Type of Response", "es": "Tipo de respuesta"}	\N	\N	\N	\N	\N	lookup lookup-service-response-type	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.074825	2026-06-01 20:50:17.80202	\N	\N	\N	\N	\N	\N
1185	service_response_day_time	date_field	f	37	t	t	f	f	t	f	{"en": "Created on", "es": "Creado el"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	now	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:32.087502	2026-06-01 20:50:17.815385	\N	\N	\N	\N	\N	\N
1013	current_care_arrangement_header	separator	f	6	t	t	f	f	t	f	{"en": "Current Care Arrangement", "es": "Acuerdo de cuidado actual"}	\N	{"en": "Primero automatically fills in the below fields with information from the most recent Care Arrangements subform entry"}	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.197022	2026-06-01 20:47:07.38346	\N	\N	\N	\N	\N	\N
1014	current_name_caregiver	text_field	f	6	t	t	f	f	t	t	{"en": "Name of Current Caregiver", "es": "Nombre del cuidador actual"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.203142	2026-06-01 20:47:07.389534	\N	\N	\N	\N	\N	\N
1015	current_care_arrangements_type	select_box	f	6	t	t	f	f	t	t	{"en": "What are the child's current care arrangements?", "es": "¿Cuáles son los acuerdos de cuidado actuales del niño?"}	\N	\N	\N	\N	\N	lookup lookup-care-arrangements-type	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.20923	2026-06-01 20:47:07.395648	\N	\N	\N	\N	\N	\N
1016	current_care_arrangement_started_date	date_field	f	6	t	t	f	f	t	t	{"en": "When did this care arrangement start?", "es": "¿Cuándo comenzó este acuerdo de cuidado?"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.216057	2026-06-01 20:47:07.40156	\N	\N	\N	\N	\N	\N
1017	care_arrangements_section	subform	f	6	t	t	f	f	t	f	{"en": "Care Arrangements", "es": "Acuerdos de cuidado"}	\N	\N	\N	\N	\N	\N	5	f	5	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.223504	2026-06-01 20:47:07.408171	\N	\N	\N	\N	\N	\N
999	child_caregiver_reason_change	select_box	f	5	t	t	f	f	t	f	{"en": "If this is a new caregiver, give the reason for the change", "es": "Si es un cuidador nuevo, indique el motivo del cambio"}	\N	\N	\N	\N	\N	lookup lookup-caregiver-change-reason	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.065356	2026-06-01 20:50:16.701903	\N	\N	\N	\N	\N	\N
1012	name_caregiver	text_field	f	6	f	t	f	f	t	f	{"en": "Name of Caregiver"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.191721	2026-06-01 20:20:30.25446	\N	\N	\N	\N	\N	\N
1021	wishes_child_family_tracing	radio_button	f	9	t	t	f	f	t	f	{"en": "Does child want to trace family members?", "es": "¿El niño desea localizar a familiares?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.329762	2026-06-01 20:50:16.896701	\N	\N	\N	\N	\N	\N
1022	child_preferences_section	subform	f	9	t	t	f	f	t	f	{"en": "Child's Preferences", "es": "Preferencias del niño"}	\N	\N	\N	\N	\N	\N	1	f	8	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.334881	2026-06-01 20:50:16.911173	\N	\N	\N	\N	\N	\N
1007	nickname_caregiver	text_field	f	5	t	t	f	f	t	f	{"en": "Other names or spellings caregiver is known by", "es": "Otros nombres o formas de escribir el nombre del cuidador"}	{"en": "e.g., nickname, second family name", "es": "Por ejemplo, apodo o segundo apellido"}	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.118342	2026-06-01 20:50:16.744583	\N	\N	\N	\N	\N	\N
1008	caregiver_age	numeric_field	f	5	t	t	f	f	t	f	{"en": "Caregiver's Age", "es": "Edad del cuidador"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.124138	2026-06-01 20:50:16.751226	\N	\N	\N	\N	\N	\N
1009	caregiver_dob	date_field	f	5	t	t	f	f	t	f	{"en": "Caregiver's Date of Birth (DOB)", "es": "Fecha de nacimiento del cuidador"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.129528	2026-06-01 20:50:16.757817	\N	\N	\N	\N	\N	\N
1034	case_plan_timeframe	date_field	f	11	t	t	f	f	t	f	{"en": "Expected timeframe (end date)", "es": "Plazo previsto (fecha de finalización)"}	\N	\N	\N	\N	\N	\N	3	f	\N	11	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.476061	2026-06-01 20:50:17.006025	\N	\N	\N	\N	\N	\N
1031	intervention_service_to_be_provided	text_field	f	11	t	t	f	f	t	f	{"en": "Name of intervention / service to be provided", "es": "Nombre de la intervención o servicio por proporcionar"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.458624	2026-06-01 20:50:16.985988	\N	\N	\N	\N	\N	\N
1023	closure_approved	tick_box	f	10	t	t	f	f	f	t	{"en": "Approved by Manager", "es": "Aprobado por el responsable"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.364521	2026-06-01 20:47:07.473903	\N	\N	\N	\N	\N	\N
1024	closure_approved_date	date_field	f	10	t	t	f	f	f	t	{"en": "Date", "es": "Fecha"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.371182	2026-06-01 20:47:07.480546	\N	\N	\N	\N	\N	\N
1025	closure_approved_comments	textarea	f	10	t	t	f	f	f	t	{"en": "Manager Comments", "es": "Comentarios del responsable"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.376061	2026-06-01 20:47:07.48776	\N	\N	\N	\N	\N	\N
1026	approval_status_closure	select_box	f	10	t	t	f	f	f	t	{"en": "Approval Status", "es": "Estado de aprobación"}	\N	\N	\N	\N	\N	lookup lookup-approval-status	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.381205	2026-06-01 20:47:07.495062	\N	\N	\N	\N	\N	\N
1027	status	select_box	f	10	t	t	f	f	f	t	{"en": "Case Status", "es": "Estado del caso"}	\N	\N	\N	\N	\N	lookup lookup-case-status	4	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.386137	2026-06-01 20:47:07.502879	\N	\N	\N	\N	\N	\N
1028	closure_reason	select_box	f	10	t	t	f	f	t	f	{"en": "What is the reason for closing the child's file?", "es": "¿Cuál es el motivo para cerrar el expediente del niño?"}	\N	\N	\N	\N	[{"id": "death_of_child", "display_text": {"en": "Death of Child"}}, {"id": "formal_closing", "display_text": {"en": "Formal Closing"}}, {"id": "not_seen_during_verification", "display_text": {"en": "Not Seen During Verification"}}, {"id": "repatriated", "display_text": {"en": "Repatriated"}}, {"id": "transferred", "display_text": {"en": "Transferred"}}, {"id": "other", "display_text": {"en": "Other"}}]	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.391377	2026-06-01 20:47:07.510688	\N	\N	\N	\N	\N	\N
1029	closure_reason_other	text_field	f	10	t	t	f	f	t	f	{"en": "If other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.39747	2026-06-01 20:47:07.51879	\N	\N	\N	\N	\N	\N
1079	note_text	textarea	f	17	t	t	f	f	t	f	{"en": "Notes", "es": "Notas"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.980158	2026-06-01 20:47:07.874128	\N	\N	\N	\N	\N	\N
1030	date_closure	date_field	f	10	t	t	f	f	t	f	{"en": "Date of Closure", "es": "Fecha de cierre"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.402865	2026-06-01 20:47:07.525515	\N	\N	\N	\N	\N	\N
1186	service_response_timeframe	select_box	f	37	t	t	f	f	t	f	{"en": "Implementation Timeframe", "es": "Plazo de implementación"}	{"en": "Enter the Implementation Timeframe for the service; the timeframe is used in the dashboard to indicate if services are overdue.", "es": "Indique el plazo de implementación del servicio; se utiliza en el panel para mostrar si está vencido."}	\N	\N	\N	[{"id": "1_hour", "display_text": {"en": "One hour"}}, {"id": "3_hours", "display_text": {"en": "Three hours"}}, {"id": "1_day", "display_text": {"en": "One day"}}, {"id": "3_days", "display_text": {"en": "Three days"}}]	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.093366	2026-06-01 20:50:17.828435	\N	\N	\N	\N	\N	\N
1188	service_implementing_agency	select_box	f	37	t	t	f	f	t	f	{"en": "Implementing Agency", "es": "Agencia implementadora"}	\N	\N	\N	\N	\N	Agency	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.105221	2026-06-01 20:50:17.841207	\N	\N	\N	\N	\N	\N
1032	case_plan_provider_and_contact_details	textarea	f	11	t	t	f	f	t	f	{"en": "Person / agency providing the service or implementing the intervention / services and contact details", "es": "Persona o agencia que presta el servicio o implementa la intervención y sus datos de contacto"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.464554	2026-06-01 20:50:16.994372	\N	\N	\N	\N	\N	\N
1018	wishes_name	text_field	f	8	t	t	f	f	t	f	{"en": "Person(s) child wishes to locate", "es": "Personas que el niño desea localizar"}	\N	\N	\N	\N	\N	\N	0	f	\N	8	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.289439	2026-06-01 20:50:16.862886	\N	\N	\N	\N	\N	\N
1036	case_plan_approval_type	select_box	f	12	t	t	f	f	f	t	{"en": "Approval Type", "es": "Tipo de aprobación"}	\N	\N	\N	\N	\N	lookup lookup-approval-type	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.526914	2026-06-01 20:47:07.54638	\N	\N	\N	\N	\N	\N
1037	case_plan_approved	tick_box	f	12	t	t	f	f	f	t	{"en": "Approved by Manager", "es": "Aprobado por el responsable"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.532603	2026-06-01 20:47:07.559859	\N	\N	\N	\N	\N	\N
1038	case_plan_approved_date	date_field	f	12	t	t	f	f	f	t	{"en": "Date", "es": "Fecha"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.537711	2026-06-01 20:47:07.567658	\N	\N	\N	\N	\N	\N
1039	case_plan_approved_comments	textarea	f	12	t	t	f	f	f	t	{"en": "Manager Comments", "es": "Comentarios del responsable"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.543877	2026-06-01 20:47:07.57513	\N	\N	\N	\N	\N	\N
1040	approval_status_case_plan	select_box	f	12	t	t	f	f	f	t	{"en": "Approval Status", "es": "Estado de aprobación"}	\N	\N	\N	\N	\N	lookup lookup-approval-status	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.548988	2026-06-01 20:47:07.582174	\N	\N	\N	\N	\N	\N
1042	date_case_plan	date_field	f	12	t	t	f	f	t	f	{"en": "Date Case Plan Initiated", "es": "Fecha de inicio del plan del caso"}	{"en": "This field is used for the Workflow status", "es": "Este campo se utiliza para el estado del flujo de trabajo."}	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.559749	2026-06-01 20:47:07.599359	\N	\N	\N	\N	\N	\N
1043	case_plan_header	separator	f	12	t	t	f	f	t	f	{"en": "Intervention Plans and Services to be Provided", "es": "Planes de intervención y servicios por proporcionar"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.564548	2026-06-01 20:47:07.606115	\N	\N	\N	\N	\N	\N
1041	case_plan_section_header	separator	f	12	t	t	f	f	t	f	{"en": "Case Plan", "es": "Plan del caso"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.554245	2026-06-01 20:50:17.036048	\N	\N	\N	\N	\N	\N
1033	intervention_service_goal	textarea	f	11	t	t	f	f	t	f	{"en": "Goal of intervention / service", "es": "Objetivo de la intervención o servicio"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.470054	2026-06-01 20:50:17.00051	\N	\N	\N	\N	\N	\N
1096	cp_incident_timeofday	select_box	f	21	t	t	f	f	t	f	{"en": "Time of Incident", "es": "Hora del incidente"}	\N	\N	\N	\N	\N	lookup lookup-time-of-day	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.18105	2026-06-01 20:50:17.376792	\N	\N	\N	\N	\N	\N
1044	cp_case_plan_subform_case_plan_interventions	subform	f	12	t	t	f	f	t	f	{"en": "Intervention plans and services details", "es": "Detalles de planes de intervención y servicios"}	\N	\N	\N	\N	\N	\N	8	f	11	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "case_plan_timeframe"}	f	2026-06-01 20:20:30.569889	2026-06-01 20:47:07.613639	\N	\N	\N	\N	\N	\N
1045	interview_subject	select_box	f	13	t	t	f	f	t	f	{"en": "Consent Obtained From", "es": "Consentimiento obtenido de"}	\N	\N	\N	\N	[{"id": "individual", "display_text": {"en": "Individual"}}, {"id": "caregiver", "display_text": {"en": "Caregiver"}}, {"id": "other", "display_text": {"en": "Other (please specify)"}}]	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.614162	2026-06-01 20:47:07.638697	\N	\N	\N	\N	\N	\N
1035	intervention_service_success	radio_button	f	11	t	t	f	f	t	f	{"en": "Successfully implemented?", "es": "¿Implementado correctamente?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.491562	2026-06-01 20:50:17.011103	\N	\N	\N	\N	\N	\N
1070	relation_ethnicity	select_box	f	14	t	t	f	f	t	f	{"en": "Ethnicity", "es": "Etnia"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.832346	2026-06-01 20:50:17.165538	\N	\N	\N	\N	\N	\N
1097	cp_incident_timeofday_actual	text_field	f	21	t	t	f	f	t	f	{"en": "Please specify the actual time of the Incident", "es": "Especifique la hora exacta del incidente"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.186753	2026-06-01 20:50:17.383486	\N	\N	\N	\N	\N	\N
1099	cp_incident_previous_incidents	radio_button	f	21	t	t	f	f	t	f	{"en": "Has the case been previously abused?", "es": "¿El caso ha sufrido abuso anteriormente?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.197143	2026-06-01 20:50:17.404046	\N	\N	\N	\N	\N	\N
1100	cp_incident_previous_incidents_description	textarea	f	21	t	t	f	f	t	f	{"en": "If yes please describe in brief", "es": "Si la respuesta es sí, describa brevemente"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.202871	2026-06-01 20:50:17.412261	\N	\N	\N	\N	\N	\N
1101	cp_incident_abuser_header	separator	f	21	t	t	f	f	t	f	{"en": "Perpetrator information", "es": "Información del responsable"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.208246	2026-06-01 20:50:17.418476	\N	\N	\N	\N	\N	\N
1174	transitioned_by	text_field	f	33	t	t	f	f	f	t	{"en": "Transferred or Referred By", "es": "Transferido o derivado por"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.937875	2026-06-01 20:50:17.717556	\N	\N	\N	\N	\N	\N
1176	is_remote	tick_box	f	33	t	t	f	f	f	t	{"en": "Is the referral or transfer to a remote system?", "es": "¿La derivación o transferencia es hacia un sistema remoto?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.948345	2026-06-01 20:50:17.729779	\N	\N	\N	\N	\N	\N
1177	type_of_export	text_field	f	33	t	t	f	f	f	t	{"en": "What type of export do you want", "es": "¿Qué tipo de exportación desea?"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.954451	2026-06-01 20:50:17.737957	\N	\N	\N	\N	\N	\N
1178	consent_overridden	tick_box	f	33	t	t	f	f	f	t	{"en": "No Consent to Share Setting Overridden", "es": "Excepción aplicada a la falta de consentimiento para compartir"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.959969	2026-06-01 20:50:17.744972	\N	\N	\N	\N	\N	\N
1076	family_details_section	subform	f	15	t	t	f	f	t	f	{"en": "Family Details", "es": "Detalles de la familia"}	\N	\N	\N	\N	\N	\N	0	f	14	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.936666	2026-06-01 20:47:07.831531	\N	\N	\N	\N	\N	\N
1179	consent_individual_transfer	tick_box	f	33	t	t	f	f	f	t	{"en": "Did the case worker have the child's consent to make this transfer?", "es": "¿El trabajador del caso tenía el consentimiento del niño para realizar esta transferencia?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.965596	2026-06-01 20:50:17.752637	\N	\N	\N	\N	\N	\N
1049	consent_for_tracing	radio_button	f	13	f	t	f	f	t	f	{"en": "Consent has been obtained to disclose information for tracing purposes"}	{"en": "If this field is 'No', the child's case record will not show up in Matches with InquirerTracing Requests."}	\N	\N	\N	\N	lookup lookup-yes-no	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.635262	2026-06-01 20:20:30.723552	\N	\N	\N	\N	\N	\N
1052	consent_info_sharing	select_box	t	13	f	t	f	f	t	f	{"en": "Consent has been given to share the information collected with"}	\N	\N	\N	\N	[{"id": "family", "display_text": {"en": "Family"}}, {"id": "authorities", "display_text": {"en": "Authorities"}}, {"id": "unhcr", "display_text": {"en": "UNHCR"}}, {"id": "other_organizations", "display_text": {"en": "Other Organizations"}}, {"id": "others", "display_text": {"en": "Others, please specify"}}]	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.652018	2026-06-01 20:20:30.726871	\N	\N	\N	\N	\N	\N
1053	consent_info_sharing_others	text_field	f	13	f	t	f	f	t	f	{"en": "If information can be shared with others, please specify who"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.657639	2026-06-01 20:20:30.728561	\N	\N	\N	\N	\N	\N
1058	legitimate_basis	select_box	t	13	f	t	f	f	t	f	{"en": "Reasons for collecting and retaining information on this Case"}	\N	{"en": "(1) The consent of the data subject, or the child’s representative where appropriate (\\"consent\\").\\n(2) To prepare for or perform a contract with the data subject, including a contract of employment (\\"contract\\").\\n(3) To protect the life, physical or mental integrity of the data subject or another person (\\"vital interests\\").\\n(4) To protect or advance the interests of people UNICEF serves, and particularly those interests UNICEF is mandated to protect or advance (\\"beneficiary interests\\").\\n(5) Compliance with a public legal obligation to which UNICEF is subject (\\"legal obligation\\").\\n(6) Other legitimate interests of UNICEF consistent with its mandate, including the establishment, exercise or defense of legal claims or for UNICEF accountability (\\"other legitimate interests\\")."}	\N	\N	\N	lookup lookup-legitimate-basis	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.690022	2026-06-01 20:20:30.734242	\N	\N	\N	\N	\N	\N
1046	consent_source_other	text_field	f	13	t	t	f	f	t	f	{"en": "If Other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.619993	2026-06-01 20:47:07.645563	\N	\N	\N	\N	\N	\N
1047	consent_for_services	tick_box	f	13	t	t	f	f	t	f	{"en": "Consent has been obtained for the child to receive case management services", "es": "Se obtuvo consentimiento para que el niño reciba servicios de gestión de casos"}	{"en": "This includes consent for sharing information with other organizations providing services", "es": "Incluye el consentimiento para compartir información con otras organizaciones que prestan servicios"}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.624989	2026-06-01 20:47:07.6667	\N	\N	\N	\N	\N	\N
1048	consent_reporting	radio_button	f	13	t	t	f	f	t	f	{"en": "Consent is given share non-identifiable information for reporting", "es": "Se autoriza compartir información no identificable para reportes"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.629839	2026-06-01 20:47:07.673332	\N	\N	\N	\N	\N	\N
1050	disclosure_other_orgs	tick_box	f	13	t	t	f	f	t	f	{"en": "The individual providing consent agrees to share collected information with other organizations for service provision?", "es": "¿La persona que da el consentimiento acepta compartir información con otras organizaciones para prestar servicios?"}	{"en": "This includes sharing information with other oranizations providing services."}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.639994	2026-06-01 20:47:07.687648	\N	\N	\N	\N	\N	\N
1051	consent_share_separator	separator	f	13	t	t	f	f	t	f	{"en": "Consent Details for Sharing Information", "es": "Detalles del consentimiento para compartir información"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.645632	2026-06-01 20:47:07.693968	\N	\N	\N	\N	\N	\N
1054	disclosure_deny_details	text_field	f	13	t	t	f	f	t	f	{"en": "What information should be withheld from a particular person or individual", "es": "¿Qué información debe restringirse a una persona específica?"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.663586	2026-06-01 20:47:07.703027	\N	\N	\N	\N	\N	\N
1055	withholding_info_reason	select_box	t	13	t	t	f	f	t	f	{"en": "Reason for withholding information", "es": "Motivo para restringir información"}	\N	\N	\N	\N	[{"id": "fear", "display_text": {"en": "Fear of harm to themselves or others"}}, {"id": "communicate_information", "display_text": {"en": "Want to communicate information themselves"}}, {"id": "others", "display_text": {"en": "Other reason, please specify"}}]	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.669086	2026-06-01 20:47:07.70993	\N	\N	\N	\N	\N	\N
1056	withholding_info_other_reason	text_field	f	13	t	t	f	f	t	f	{"en": "If other reason for withholding information, please specify", "es": "Si existe otro motivo, especifique"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.674548	2026-06-01 20:47:07.716923	\N	\N	\N	\N	\N	\N
1057	unhcr_export_opt_in	tick_box	f	13	f	t	f	f	f	f	{"en": "The individual providing consent agrees to share information about this case with UNHCR for the purposes of refugee protection case management."}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.682678	2026-06-01 20:47:07.723415	\N	\N	\N	\N	\N	\N
1059	relation_name	text_field	f	14	t	t	f	f	t	f	{"en": "Name", "es": "Nombre"}	\N	\N	\N	\N	\N	\N	0	f	\N	14	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.748779	2026-06-01 20:50:17.120471	\N	\N	\N	\N	\N	\N
1060	relation	select_box	f	14	t	t	f	f	t	f	{"en": "How are they related to the child?", "es": "¿Qué relación tienen con el niño?"}	\N	\N	\N	\N	\N	lookup lookup-family-relationship	1	f	\N	14	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.758133	2026-06-01 20:50:17.127804	\N	\N	\N	\N	\N	\N
1078	note_subject	text_field	f	17	t	t	f	f	t	f	{"en": "Subject", "es": "Asunto"}	\N	\N	\N	\N	\N	\N	1	f	\N	17	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.974521	2026-06-01 20:50:17.22326	\N	\N	\N	\N	\N	\N
1080	note_created_by	text_field	f	17	t	t	f	f	t	t	{"en": "Manager", "es": "Responsable"}	\N	\N	\N	\N	\N	\N	3	f	\N	17	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.985698	2026-06-01 20:50:17.231392	\N	\N	\N	\N	\N	\N
1062	relation_nickname	text_field	f	14	t	t	f	f	t	f	{"en": "Nickname", "es": "Apodo"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.771531	2026-06-01 20:47:07.758472	\N	\N	\N	\N	\N	\N
1065	relation_age	numeric_field	f	14	t	t	f	f	t	f	{"en": "Age", "es": "Edad"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.791338	2026-06-01 20:47:07.765317	\N	\N	\N	\N	\N	\N
1077	note_date	date_field	f	17	t	t	f	f	t	f	{"en": "Date", "es": "Fecha"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:30.968756	2026-06-01 20:47:07.866683	\N	\N	\N	\N	\N	\N
1066	relation_date_of_birth	date_field	f	14	t	t	f	f	t	f	{"en": "Date of Birth", "es": "Fecha de nacimiento"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:30.798583	2026-06-01 20:47:07.772695	\N	\N	\N	\N	\N	\N
1067	relation_sex	select_box	f	14	t	t	f	f	t	f	{"en": "Sex", "es": "Sexo"}	\N	\N	\N	\N	\N	lookup lookup-gender	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:30.806783	2026-06-01 20:47:07.779925	\N	\N	\N	\N	\N	\N
1323	module_id	text_field	f	53	t	t	f	f	f	t	{"en": "Module"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.383018	2026-06-01 20:20:33.412693	\N	\N	\N	\N	\N	\N
1189	service_provider	text_field	f	37	t	t	f	f	t	f	{"en": "Service Provider", "es": "Proveedor del servicio"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.111874	2026-06-01 20:50:17.848267	\N	\N	\N	\N	\N	\N
1068	relation_language	select_box	t	14	t	t	f	f	t	f	{"en": "Language", "es": "Idioma"}	\N	\N	\N	\N	\N	lookup lookup-language	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.816149	2026-06-01 20:47:07.786903	\N	\N	\N	\N	\N	\N
1190	service_delivery_location	select_box	f	37	t	t	f	f	t	f	{"en": "Service delivery location", "es": "Lugar de prestación del servicio"}	\N	\N	\N	\N	\N	ReportingLocation	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.117879	2026-06-01 20:50:17.854834	\N	\N	\N	\N	\N	\N
1081	notes_section	subform	f	18	t	t	f	f	t	f	{"en": "Notes", "es": "Notas"}	\N	\N	\N	\N	\N	\N	0	f	17	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "notes_date"}	f	2026-06-01 20:20:31.016944	2026-06-01 20:47:07.899564	\N	\N	\N	\N	\N	\N
1191	service_implementing_agency_individual	select_box	f	37	t	t	f	f	t	f	{"en": "Service provider name", "es": "Nombre del proveedor del servicio"}	\N	\N	\N	\N	\N	User	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.123561	2026-06-01 20:50:17.860589	\N	\N	\N	\N	\N	\N
1200	tracing_type	select_box	f	39	t	t	f	f	t	f	{"en": "Type of action taken", "es": "Tipo de acción realizada"}	\N	\N	\N	\N	[{"id": "case_by_case_tracing", "display_text": {"en": "Case by Case Tracing"}}, {"id": "individual_tracing", "display_text": {"en": "Individual Tracing"}}, {"id": "mass_tracing", "display_text": {"en": "Mass Tracing"}}, {"id": "photo_tracing", "display_text": {"en": "Photo Tracing"}}, {"id": "referral_to_ngo", "display_text": {"en": "Referral to NGO"}}, {"id": "referral_to_icrc", "display_text": {"en": "Referral to ICRC"}}]	\N	1	f	\N	39	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.236787	2026-06-01 20:50:17.956091	\N	\N	\N	\N	\N	\N
1069	relation_religion	select_box	t	14	t	t	f	f	t	f	{"en": "Religion", "es": "Religión"}	\N	\N	\N	\N	\N	lookup lookup-religion	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.824282	2026-06-01 20:47:07.793951	\N	\N	\N	\N	\N	\N
1071	relation_nationality	select_box	t	14	t	t	f	f	t	f	{"en": "Nationality", "es": "Nacionalidad"}	\N	\N	\N	\N	\N	lookup lookup-country	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:30.840602	2026-06-01 20:47:07.800338	\N	\N	\N	\N	\N	\N
1203	tracing_action_description	text_field	f	39	t	t	f	f	t	f	{"en": "Action taken and remarks", "es": "Acción realizada y observaciones"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.254818	2026-06-01 20:50:17.994021	\N	\N	\N	\N	\N	\N
1204	tracing_outcome	select_box	f	39	t	t	f	f	t	f	{"en": "Outcome of tracing action", "es": "Resultado de la acción de localización"}	\N	\N	\N	\N	[{"id": "pending", "display_text": {"en": "Pending"}}, {"id": "successful", "display_text": {"en": "Successful"}}, {"id": "unsuccessful", "display_text": {"en": "Unsuccessful"}}, {"id": "yes", "display_text": {"en": "Yes"}}]	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.260798	2026-06-01 20:50:18.00534	\N	\N	\N	\N	\N	\N
1082	followup_type	select_box	f	19	t	t	f	f	t	f	{"en": "Type of follow up", "es": "Tipo de seguimiento"}	\N	\N	\N	\N	\N	lookup lookup-followup-type	0	f	\N	19	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.048778	2026-06-01 20:50:17.263776	\N	\N	\N	\N	\N	\N
1087	followup_date	date_field	f	19	t	t	f	f	t	f	{"en": "Follow up date", "es": "Fecha de seguimiento"}	\N	\N	\N	\N	\N	\N	5	f	\N	19	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.077715	2026-06-01 20:50:17.288811	\N	\N	\N	\N	\N	\N
1083	followup_service_type	select_box	f	19	t	t	f	f	t	f	{"en": "Type of service", "es": "Tipo de servicio"}	\N	\N	\N	\N	\N	lookup lookup-service-type	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.054503	2026-06-01 20:50:17.26983	\N	\N	\N	\N	\N	\N
1084	followup_assessment_type	select_box	f	19	t	t	f	f	t	f	{"en": "Type of assessment", "es": "Tipo de evaluación"}	\N	\N	\N	\N	[{"id": "personal_intervention_assessment", "display_text": {"en": "Personal Intervention Assessment"}}, {"id": "medical_intervention_assessment", "display_text": {"en": "Medical Intervention Assessment"}}, {"id": "family_intervention_assessment", "display_text": {"en": "Family Intervention Assessment"}}, {"id": "community_intervention_assessment", "display_text": {"en": "Community Intervention Assessment"}}, {"id": "unhcr_intervention_assessment", "display_text": {"en": "UNHCR Intervention Assessment"}}, {"id": "ngo_intervention_assessment", "display_text": {"en": "NGO Intervention Assessment"}}, {"id": "economic_intervention_assessment", "display_text": {"en": "Economic Intervention Assessment"}}, {"id": "education_intervention_assessment", "display_text": {"en": "Education Intervention Assessment"}}, {"id": "health_intervention_assessment", "display_text": {"en": "Health Intervention Assessment"}}, {"id": "other_intervention_assessment", "display_text": {"en": "Other Intervention Assessment"}}]	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.060275	2026-06-01 20:50:17.276125	\N	\N	\N	\N	\N	\N
1085	protection_concern_type	select_box	f	19	f	t	f	f	t	f	{"en": "Type of Protection Concern "}	\N	\N	\N	\N	\N	lookup lookup-protection-concerns	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.066555	2026-06-01 20:20:31.105125	\N	\N	\N	\N	\N	\N
1089	followup_subform_section	subform	f	20	t	t	f	f	t	f	{"en": "Follow Up", "es": "Seguimiento"}	\N	\N	\N	\N	\N	\N	0	f	19	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "followup_date"}	f	2026-06-01 20:20:31.120335	2026-06-01 20:47:07.949448	\N	\N	\N	\N	\N	\N
1086	followup_needed_by_date	date_field	f	19	t	t	f	f	t	f	{"en": "Follow up needed by", "es": "Seguimiento requerido por"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.07171	2026-06-01 20:50:17.282574	\N	\N	\N	\N	\N	\N
1088	followup_comments	text_field	f	19	t	t	f	f	t	f	{"en": "Comments", "es": "Comentarios"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.083498	2026-06-01 20:50:17.294349	\N	\N	\N	\N	\N	\N
1092	incident_date	date_field	f	21	t	t	f	f	t	f	{"en": "Date of Incident", "es": "Fecha del incidente"}	\N	\N	\N	\N	\N	\N	2	f	\N	21	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.158426	2026-06-01 20:50:17.347457	\N	\N	\N	\N	\N	\N
1098	cp_incident_violence_type	select_box	f	21	t	t	f	f	t	f	{"en": "Type of Violence", "es": "Tipo de violencia"}	\N	\N	\N	\N	\N	lookup lookup-cp-violence-type	8	f	\N	21	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.191986	2026-06-01 20:50:17.389201	\N	\N	\N	\N	\N	\N
1093	cp_incident_location_type	select_box	f	21	t	t	f	f	t	f	{"en": "Area of the Incident", "es": "Área del incidente"}	\N	\N	\N	\N	\N	lookup lookup-incident-location	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.163765	2026-06-01 20:50:17.35357	\N	\N	\N	\N	\N	\N
1094	cp_incident_location_type_other	text_field	f	21	t	t	f	f	t	f	{"en": "If 'Other', please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.169201	2026-06-01 20:50:17.359645	\N	\N	\N	\N	\N	\N
1095	incident_location	select_box	f	21	t	t	f	f	t	f	{"en": "Location of the Incident", "es": "Lugar del incidente"}	\N	\N	\N	\N	\N	Location	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.175508	2026-06-01 20:50:17.366191	\N	\N	\N	\N	\N	\N
1103	cp_incident_perpetrator_nationality	select_box	f	21	t	t	f	f	t	f	{"en": "Nationality", "es": "Nacionalidad"}	\N	\N	\N	\N	\N	lookup lookup-country	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.218988	2026-06-01 20:47:07.984753	\N	\N	\N	\N	\N	\N
1104	perpetrator_sex	radio_button	f	21	t	t	f	f	t	f	{"en": "Sex", "es": "Sexo"}	\N	\N	\N	\N	\N	lookup lookup-gender	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.224112	2026-06-01 20:47:07.991179	\N	\N	\N	\N	\N	\N
1105	cp_incident_perpetrator_date_of_birth	date_field	f	21	t	t	f	f	t	f	{"en": "Date of Birth", "es": "Fecha de nacimiento"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.229522	2026-06-01 20:47:07.997387	\N	\N	\N	\N	\N	\N
1106	cp_incident_perpetrator_age	numeric_field	f	21	t	t	f	f	t	f	{"en": "Age", "es": "Edad"}	\N	\N	\N	\N	\N	\N	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.234736	2026-06-01 20:47:08.004092	\N	\N	\N	\N	\N	\N
1090	cp_incident_identification_violence	select_box	f	21	t	t	f	f	t	f	{"en": "Identification of Incident", "es": "Identificación del incidente"}	\N	\N	\N	\N	\N	lookup lookup-incident-identification	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.147164	2026-06-01 20:50:17.335527	\N	\N	\N	\N	\N	\N
1102	cp_incident_abuser_name	text_field	f	21	t	t	f	f	t	f	{"en": "Name", "es": "Nombre"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.213435	2026-06-01 20:50:17.42582	\N	\N	\N	\N	\N	\N
1113	incident_details	subform	f	22	t	t	f	f	t	f	{"en": "Incident Details", "es": "Detalles del incidente"}	\N	\N	\N	\N	\N	\N	0	f	21	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "summary_date"}	f	2026-06-01 20:20:31.3307	2026-06-01 20:47:08.055958	\N	\N	\N	\N	\N	\N
1114	other_documents	document_upload_box	f	24	t	t	f	f	f	t	{"en": "Other Document", "es": "Otro documento"}	{"en": "Only PDF, TXT, DOC, DOCX, XLS, XLSX, CSV, JPG, JPEG, PNG files permitted", "es": "Solo se permiten archivos PDF, TXT, DOC, DOCX, XLS, XLSX, CSV, JPG, JPEG y PNG"}	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.362089	2026-06-01 20:47:08.101557	\N	\N	\N	\N	\N	\N
1115	nationality	select_box	t	25	t	t	f	f	t	f	{"en": "Nationality", "es": "Nacionalidad"}	\N	\N	\N	\N	\N	lookup lookup-country	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.384669	2026-06-01 20:47:08.118947	\N	\N	\N	\N	\N	\N
1116	country_of_origin	select_box	f	25	t	t	f	f	t	f	{"en": "Country of Origin", "es": "País de origen"}	\N	\N	\N	\N	\N	lookup lookup-country	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.389657	2026-06-01 20:47:08.125319	\N	\N	\N	\N	\N	\N
1117	address_last	textarea	f	25	t	t	f	f	t	f	{"en": "Last Address", "es": "Última dirección"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.395337	2026-06-01 20:47:08.132865	\N	\N	\N	\N	\N	\N
1118	location_last	select_box	f	25	t	t	f	f	t	f	{"en": "Last Location", "es": "Última ubicación"}	\N	\N	\N	\N	\N	Location	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:31.400732	2026-06-01 20:47:08.139142	\N	\N	\N	\N	\N	\N
1119	telephone_last	text_field	f	25	t	t	f	f	t	f	{"en": "Last Telephone", "es": "Último teléfono"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:31.406179	2026-06-01 20:47:08.144879	\N	\N	\N	\N	\N	\N
1120	ethnicity	select_box	t	25	t	t	f	f	t	f	{"en": "Ethnicity/Clan/Tribe", "es": "Etnia, clan o tribu"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:31.41139	2026-06-01 20:47:08.151255	\N	\N	\N	\N	\N	\N
1121	sub_ethnicity_1	select_box	t	25	t	t	f	f	t	f	{"en": "Sub Ethnicity 1", "es": "Subetnia 1"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.416992	2026-06-01 20:47:08.167183	\N	\N	\N	\N	\N	\N
1122	sub_ethnicity_2	select_box	t	25	t	t	f	f	t	f	{"en": "Sub Ethnicity 2", "es": "Subetnia 2"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.422442	2026-06-01 20:47:08.173745	\N	\N	\N	\N	\N	\N
1123	language	select_box	t	25	t	t	f	f	t	f	{"en": "Language", "es": "Idioma"}	\N	\N	\N	\N	\N	lookup lookup-language	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.427483	2026-06-01 20:47:08.17979	\N	\N	\N	\N	\N	\N
1124	religion	select_box	t	25	t	t	f	f	t	f	{"en": "Religion", "es": "Religión"}	\N	\N	\N	\N	\N	lookup lookup-religion	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.432392	2026-06-01 20:47:08.185304	\N	\N	\N	\N	\N	\N
1125	record_state	tick_box	f	26	t	t	f	f	f	t	{"en": "Valid Record?", "es": "¿Registro válido?"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.46984	2026-06-01 20:47:08.192613	\N	\N	\N	\N	\N	\N
1126	owned_by_agency_id	select_box	f	26	t	t	f	f	f	t	{"en": "Record Owner's Agency", "es": "Agencia responsable del registro"}	\N	\N	\N	\N	\N	Agency	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.475758	2026-06-01 20:47:08.198508	\N	\N	\N	\N	\N	\N
1127	owned_by_location	select_box	f	26	t	t	f	f	f	t	{"en": "Record Owner's Location", "es": "Ubicación responsable del registro"}	\N	\N	\N	\N	\N	Location	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.480781	2026-06-01 20:47:08.204155	\N	\N	\N	\N	\N	\N
1128	has_case_plan	tick_box	f	26	t	t	f	f	f	t	{"en": "Does this case have a case plan?", "es": "¿Este caso tiene un plan?"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.485986	2026-06-01 20:47:08.20958	\N	\N	\N	\N	\N	\N
1129	workflow	select_box	f	26	t	t	f	f	f	t	{"en": "Workflow Status", "es": "Estado del flujo de trabajo"}	\N	\N	\N	\N	\N	lookup lookup-workflow	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.490832	2026-06-01 20:47:08.215594	\N	\N	\N	\N	\N	\N
1130	photos	photo_upload_box	f	27	t	t	f	t	f	t	{"en": "Photos", "es": "Fotos"}	{"en": "Only PNG, JPEG, and GIF files permitted", "es": "Solo se permiten archivos PNG, JPEG y GIF"}	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.519619	2026-06-01 20:47:08.237109	\N	\N	\N	\N	\N	\N
1131	recorded_audio	audio_upload_box	f	27	t	t	f	t	f	t	{"en": "Recorded Audio", "es": "Audio grabado"}	{"en": "Only MP3 and M4A files permitted", "es": "Solo se permiten archivos MP3 y M4A"}	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.524603	2026-06-01 20:47:08.248811	\N	\N	\N	\N	\N	\N
1132	protection_concern_type	select_box	f	28	t	t	f	f	t	f	{"en": "Type of Protection Concern", "es": "Tipo de riesgo de protección"}	\N	\N	\N	\N	\N	lookup lookup-protection-concerns	0	f	\N	28	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.550036	2026-06-01 20:50:17.55102	\N	\N	\N	\N	\N	\N
1140	displacement_status	select_box	f	30	t	t	f	f	t	f	{"en": "Displacement Status", "es": "Estado de desplazamiento"}	\N	\N	\N	\N	\N	lookup lookup-displacement-status	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.654746	2026-06-01 20:47:08.324888	\N	\N	\N	\N	\N	\N
1142	protection_concerns	select_box	t	30	t	t	f	f	t	f	{"en": "Protection Concerns", "es": "Riesgos de protección"}	\N	\N	\N	\N	\N	lookup lookup-protection-concerns	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.665677	2026-06-01 20:47:08.330385	\N	\N	\N	\N	\N	\N
1135	protection_concerns	select_box	t	29	t	t	f	f	t	f	{"en": "Protection Concerns", "es": "Riesgos de protección"}	\N	\N	\N	\N	\N	lookup lookup-protection-concerns	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.604245	2026-06-01 20:47:08.283003	\N	\N	\N	\N	\N	\N
1136	protection_concern_detail_subform_section	subform	f	29	t	t	f	f	t	f	{"en": "Protection Concern Details", "es": "Detalles de riesgos de protección"}	\N	\N	\N	\N	\N	\N	1	f	28	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.609104	2026-06-01 20:47:08.288751	\N	\N	\N	\N	\N	\N
1137	protection_status	select_box	f	30	t	t	f	f	t	f	{"en": "Protection Status", "es": "Estado de protección"}	\N	\N	\N	\N	\N	lookup lookup-protection-status	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.637881	2026-06-01 20:47:08.307889	\N	\N	\N	\N	\N	\N
1138	urgent_protection_concern	radio_button	f	30	t	t	f	f	t	f	{"en": "Urgent Protection Concern?", "es": "¿Riesgo de protección urgente?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.643668	2026-06-01 20:47:08.313598	\N	\N	\N	\N	\N	\N
1139	risk_level	select_box	f	30	t	t	f	f	t	f	{"en": "Risk Level", "es": "Nivel de riesgo"}	\N	\N	\N	\N	\N	lookup lookup-risk-level	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.649474	2026-06-01 20:47:08.31945	\N	\N	\N	\N	\N	\N
1143	protection_concerns_other	text_field	f	30	t	t	f	f	t	f	{"en": "If Other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.670901	2026-06-01 20:47:08.335819	\N	\N	\N	\N	\N	\N
1144	unhcr_needs_codes	select_box	t	30	t	t	f	f	t	f	{"en": "UNHCR Needs Codes", "es": "Códigos de necesidades de ACNUR"}	\N	\N	\N	\N	\N	lookup lookup-unhcr-needs-codes	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.675638	2026-06-01 20:47:08.342067	\N	\N	\N	\N	\N	\N
1145	disability_type	select_box	f	30	t	t	f	f	t	f	{"en": "Disability Type", "es": "Tipo de discapacidad"}	\N	\N	\N	\N	\N	lookup lookup-disability-type	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.681553	2026-06-01 20:47:08.347605	\N	\N	\N	\N	\N	\N
1324	age	numeric_field	f	54	t	t	f	t	t	f	{"en": "Age"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.424276	2026-06-01 20:20:33.487715	\N	\N	\N	\N	\N	\N
1133	date_concern_identified	select_box	f	28	t	t	f	f	t	f	{"en": "Period when identified?", "es": "¿Período en que fue identificado?"}	\N	\N	\N	\N	[{"id": "follow_up_after_reunification", "display_text": {"en": "Follow up After Reunification"}}, {"id": "follow_up_in_care", "display_text": {"en": "Follow up In Care"}}, {"id": "registration", "display_text": {"en": "Registration"}}, {"id": "reunification", "display_text": {"en": "Reunification"}}, {"id": "verification", "display_text": {"en": "Verification"}}]	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.563469	2026-06-01 20:50:17.557126	\N	\N	\N	\N	\N	\N
1134	concern_details	textarea	f	28	t	t	f	f	t	f	{"en": "Details of the concern", "es": "Detalles del riesgo"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.568971	2026-06-01 20:50:17.5627	\N	\N	\N	\N	\N	\N
1150	current_owner_separator	separator	f	32	t	f	f	f	t	f	{"en": "Current Owner", "es": "Responsable actual"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.763378	2026-06-01 20:47:08.381398	\N	\N	\N	\N	\N	\N
1151	owned_by_text	text_field	f	32	t	t	f	t	t	f	{"en": "Field/Case/Social Worker", "es": "Trabajador de campo, caso o trabajo social"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.768645	2026-06-01 20:47:08.386776	\N	\N	\N	\N	\N	\N
1152	owned_by	select_box	f	32	t	t	f	t	f	t	{"en": "Caseworker Code", "es": "Código del trabajador del caso"}	\N	\N	\N	\N	\N	User	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.773859	2026-06-01 20:47:08.391999	\N	\N	\N	\N	\N	\N
1148	reopened_date	date_field	f	31	t	t	f	f	f	t	{"en": "Date Reopened", "es": "Fecha de reapertura"}	\N	\N	\N	\N	\N	\N	0	f	\N	31	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.73151	2026-06-01 20:50:17.610962	\N	\N	\N	\N	\N	\N
1149	reopened_user	text_field	f	31	t	t	f	f	f	t	{"en": "Reopened by", "es": "Reabierto por"}	\N	\N	\N	\N	\N	\N	1	f	\N	31	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.737264	2026-06-01 20:50:17.616313	\N	\N	\N	\N	\N	\N
1141	unhcr_protection_code	text_field	f	30	f	t	f	f	f	t	{"en": "UNHCR Protection Code"}	{"en": "This field is deprecated in v1.2 and replaced by unchr_needs_code"}	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.660214	2026-06-01 20:20:31.716324	\N	\N	\N	\N	\N	\N
1146	disability_special_needs	select_box	t	30	f	f	f	f	t	f	{"en": "Special needs"}	\N	\N	\N	\N	\N	lookup lookup-special-needs	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.686887	2026-06-01 20:20:31.720212	\N	\N	\N	\N	\N	\N
1147	disability_communications	select_box	f	30	f	f	f	f	t	f	{"en": "If the child has communicative challenges, what is the best means of communication?"}	\N	\N	\N	\N	\N	lookup lookup-disability-communication-best-means	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.692109	2026-06-01 20:20:31.721002	\N	\N	\N	\N	\N	\N
1166	reopened_logs	subform	f	32	t	f	f	f	f	t	{"en": "Case Reopened", "es": "Caso reabierto"}	\N	\N	\N	\N	\N	\N	16	f	31	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "reopened_date"}	f	2026-06-01 20:20:31.844185	2026-06-01 20:50:17.654639	\N	\N	\N	\N	\N	\N
1175	service	text_field	f	33	t	t	f	f	f	t	{"en": "Service", "es": "Servicio"}	\N	\N	\N	\N	\N	\N	8	f	\N	33	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.943174	2026-06-01 20:50:17.723023	\N	\N	\N	\N	\N	\N
1153	reassigned_tranferred_on	date_field	f	32	t	t	f	f	f	t	{"en": "Reassigned / Transferred On", "es": "Fecha de reasignación o transferencia"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:31.778953	2026-06-01 20:47:08.397592	\N	\N	\N	\N	\N	\N
1154	owned_by_agency_id	select_box	f	32	t	f	f	f	f	t	{"en": "Agency", "es": "Agencia"}	\N	\N	\N	\N	\N	Agency	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.783881	2026-06-01 20:47:08.403747	\N	\N	\N	\N	\N	\N
1156	assigned_user_names	select_box	t	32	t	f	f	f	t	f	{"en": "Other Assigned Users", "es": "Otros usuarios asignados"}	\N	\N	\N	\N	\N	User	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.793829	2026-06-01 20:47:08.409554	\N	\N	\N	\N	\N	\N
1160	record_history_separator	separator	f	32	t	f	f	f	t	f	{"en": "Record History", "es": "Historial del registro"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.81347	2026-06-01 20:47:08.414981	\N	\N	\N	\N	\N	\N
1161	created_by	text_field	f	32	t	f	f	f	f	t	{"en": "Record created by", "es": "Registro creado por"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.818701	2026-06-01 20:47:08.420622	\N	\N	\N	\N	\N	\N
1162	created_by_agency	text_field	f	32	t	f	f	f	t	t	{"en": "Created by agency", "es": "Creado por la agencia"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.823768	2026-06-01 20:47:08.426401	\N	\N	\N	\N	\N	\N
1163	previously_owned_by	text_field	f	32	t	f	f	f	f	t	{"en": "Previous Owner", "es": "Responsable anterior"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.828663	2026-06-01 20:47:08.433652	\N	\N	\N	\N	\N	\N
1164	previous_agency	text_field	f	32	t	f	f	f	t	t	{"en": "Previous Agency", "es": "Agencia anterior"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.83415	2026-06-01 20:47:08.439522	\N	\N	\N	\N	\N	\N
1165	module_id	text_field	f	32	t	f	f	f	f	t	{"en": "Module", "es": "Módulo"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.839072	2026-06-01 20:47:08.446051	\N	\N	\N	\N	\N	\N
1167	type	select_box	f	33	t	t	f	f	f	t	{"en": "Type", "es": "Tipo"}	\N	\N	\N	\N	\N	lookup lookup-transition-type	0	f	\N	33	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.899581	2026-06-01 20:50:17.678364	\N	\N	\N	\N	\N	\N
1168	to_user_local	text_field	f	33	t	t	f	f	f	t	{"en": "Local User", "es": "Usuario local"}	\N	\N	\N	\N	\N	\N	1	f	\N	33	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.904943	2026-06-01 20:50:17.685288	\N	\N	\N	\N	\N	\N
1169	to_user_remote	text_field	f	33	t	t	f	f	f	t	{"en": "Remote User", "es": "Usuario remoto"}	\N	\N	\N	\N	\N	\N	2	f	\N	33	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.910203	2026-06-01 20:50:17.690853	\N	\N	\N	\N	\N	\N
1180	created_at	date_field	f	33	t	t	f	f	f	t	{"en": "Date of referral or transfer", "es": "Fecha de derivación o transferencia"}	\N	\N	\N	\N	\N	\N	13	f	\N	33	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:31.970957	2026-06-01 20:50:17.760037	\N	\N	\N	\N	\N	\N
1181	transfer_status	select_box	f	34	t	t	f	f	f	t	{"en": "Transfer Status", "es": "Estado de transferencia"}	\N	\N	\N	\N	[{"id": "in_progress", "display_text": {"en": "In Progress"}}, {"id": "accepted", "display_text": {"en": "Accepted"}}, {"id": "rejected", "display_text": {"en": "Rejected"}}]	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.020187	2026-06-01 20:47:08.505554	\N	\N	\N	\N	\N	\N
1170	to_user_local_status	select_box	f	33	t	t	f	f	f	t	{"en": "Status", "es": "Estado"}	\N	\N	\N	\N	[{"id": "in_progress", "display_text": {"en": "In Progress"}}, {"id": "pending", "display_text": {"en": "Pending"}}, {"id": "accepted", "display_text": {"en": "Accepted"}}, {"id": "rejected", "display_text": {"en": "Rejected"}}, {"id": "done", "display_text": {"en": "Done"}}]	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.916088	2026-06-01 20:50:17.696153	\N	\N	\N	\N	\N	\N
1171	rejected_reason	text_field	f	33	t	t	f	f	f	t	{"en": "Reason rejected (if applicable)", "es": "Motivo del rechazo, si corresponde"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.921673	2026-06-01 20:50:17.702611	\N	\N	\N	\N	\N	\N
1172	to_user_agency	text_field	f	33	t	t	f	f	f	t	{"en": "Remote User Agency", "es": "Agencia del usuario remoto"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.927103	2026-06-01 20:50:17.708877	\N	\N	\N	\N	\N	\N
1173	notes	textarea	f	33	t	t	f	f	f	t	{"en": "Notes", "es": "Notas"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.932369	2026-06-01 20:47:08.469846	\N	\N	\N	\N	\N	\N
1182	transitions	subform	f	34	t	t	f	f	f	t	{"en": "Transfers and Referrals", "es": "Transferencias y derivaciones"}	\N	\N	\N	\N	\N	\N	1	f	33	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "created_at"}	f	2026-06-01 20:20:32.028627	2026-06-01 20:47:08.511907	\N	\N	\N	\N	\N	\N
1184	service_type	select_box	f	37	t	t	f	f	t	f	{"en": "Type of Service", "es": "Tipo de servicio"}	\N	\N	\N	\N	\N	lookup lookup-service-type	1	f	\N	37	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.081355	2026-06-01 20:50:17.808024	\N	\N	\N	\N	\N	\N
1187	service_appointment_date	date_field	f	37	t	t	f	f	t	f	{"en": "Appointment Date", "es": "Fecha de la cita"}	\N	\N	\N	\N	\N	\N	4	f	\N	37	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.099557	2026-06-01 20:50:17.83574	\N	\N	\N	\N	\N	\N
1192	service_status_referred	tick_box	f	37	t	t	f	f	t	t	{"en": "Referred?", "es": "¿Derivado?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.128915	2026-06-01 20:50:17.867268	\N	\N	\N	\N	\N	\N
1193	service_location	text_field	f	37	t	t	f	f	t	f	{"en": "Service Location", "es": "Lugar del servicio"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.134351	2026-06-01 20:50:17.878802	\N	\N	\N	\N	\N	\N
1194	service_referral_notes	textarea	f	37	t	t	f	f	t	f	{"en": "Notes", "es": "Notas"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.139708	2026-06-01 20:47:08.561931	\N	\N	\N	\N	\N	\N
1195	service_implemented	select_box	f	37	t	t	f	f	t	t	{"en": "Service implemented", "es": "Servicio implementado"}	\N	\N	\N	\N	\N	lookup lookup-service-implemented	12	f	\N	\N	f	\N	not_implemented	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.145323	2026-06-01 20:50:17.887619	\N	\N	\N	\N	\N	\N
1199	date_tracing	date_field	f	39	t	t	f	f	t	f	{"en": "Date of tracing", "es": "Fecha de localización"}	\N	\N	\N	\N	\N	\N	0	f	\N	39	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.23111	2026-06-01 20:50:17.94505	\N	\N	\N	\N	\N	\N
1201	address_tracing	textarea	f	39	t	t	f	f	t	f	{"en": "Address/Village where the tracing action took place", "es": "Dirección o localidad donde se realizó la localización"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.242289	2026-06-01 20:50:17.972103	\N	\N	\N	\N	\N	\N
1198	services_section	subform	f	38	t	t	f	f	t	f	{"en": "Services", "es": "Servicios"}	\N	\N	\N	\N	\N	\N	0	f	37	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "service_appointment_date"}	f	2026-06-01 20:20:32.205066	2026-06-01 20:47:08.577844	\N	\N	\N	\N	\N	\N
1202	location_tracing	select_box	f	39	t	t	f	f	t	f	{"en": "Location of Tracing", "es": "Lugar de localización"}	\N	\N	\N	\N	\N	Location	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.247725	2026-06-01 20:50:17.981196	\N	\N	\N	\N	\N	\N
1205	matched_tracing_request_id	text_field	f	40	t	t	f	f	f	t	{"en": "Matched Tracing Request ID", "es": "ID de solicitud de localización coincidente"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	tracing_request	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.297715	2026-06-01 20:47:08.612053	\N	\N	\N	\N	\N	\N
1206	separation_separator	separator	f	40	t	t	f	f	t	f	{"en": "Separation History", "es": "Historial de separación"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.304461	2026-06-01 20:47:08.617648	\N	\N	\N	\N	\N	\N
1207	tracing_status	select_box	f	40	t	t	f	f	t	f	{"en": "Tracing Status", "es": "Estado de localización"}	\N	\N	\N	\N	\N	lookup lookup-tracing-status	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.311166	2026-06-01 20:47:08.62324	\N	\N	\N	\N	\N	\N
1208	date_of_separation	date_field	f	40	t	t	f	f	t	f	{"en": "Date of Separation", "es": "Fecha de separación"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.31738	2026-06-01 20:47:08.628953	\N	\N	\N	\N	\N	\N
1209	separation_cause	select_box	f	40	t	t	f	f	t	f	{"en": "What was the main cause of separation?", "es": "¿Cuál fue la causa principal de la separación?"}	\N	\N	\N	\N	\N	lookup lookup-separation-cause	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.32378	2026-06-01 20:47:08.636746	\N	\N	\N	\N	\N	\N
1210	separation_cause_other	text_field	f	40	t	t	f	f	t	f	{"en": "If Other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.329963	2026-06-01 20:47:08.645463	\N	\N	\N	\N	\N	\N
1211	location_separation	select_box	f	40	t	t	f	f	t	f	{"en": "Separation Location", "es": "Lugar de separación"}	\N	\N	\N	\N	\N	Location	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.335882	2026-06-01 20:47:08.652041	\N	\N	\N	\N	\N	\N
1212	status	select_box	f	43	t	t	f	f	f	t	{"en": "Record Status"}	\N	\N	\N	\N	\N	lookup lookup-case-status	0	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.380931	2026-06-01 20:20:32.41623	\N	\N	\N	\N	\N	\N
1213	date_closure	date_field	f	43	t	t	f	f	t	f	{"en": "Date of Closure"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.385805	2026-06-01 20:20:32.417116	\N	\N	\N	\N	\N	\N
1214	closure_reason	select_box	f	43	t	t	f	f	t	f	{"en": "Primary reason for family closure"}	\N	\N	\N	\N	[{"id": "overall_goals_met", "display_text": {"en": "Overall goals for the family have been met"}}, {"id": "moving_different_location", "display_text": {"en": "Familiy is moving to a different location"}}, {"id": "cannot_be_contacted", "display_text": {"en": "Family cannot be contacted (wait at least 3 months before closing the case)"}}, {"id": "no_further_action", "display_text": {"en": "No further action possible/required"}}, {"id": "case_opened_error", "display_text": {"en": "Case opened in error"}}, {"id": "other", "display_text": {"en": "Other"}}]	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.390986	2026-06-01 20:20:32.418333	\N	\N	\N	\N	\N	\N
1215	closure_reason_other	text_field	f	43	t	t	f	f	t	f	{"en": "If other, please specify"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.396785	2026-06-01 20:20:32.419544	\N	\N	\N	\N	\N	\N
1216	closure_details	textarea	f	43	t	t	f	f	t	f	{"en": "Provide further details on reason for family closure"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.40179	2026-06-01 20:20:32.420655	\N	\N	\N	\N	\N	\N
1217	family_legitimate_basis	select_box	t	44	t	t	f	f	t	f	{"en": "Reasons for collecting and retaining information on this Family"}	\N	{"en": "(1) The consent of the data subject, or the child’s representative where appropriate (\\"consent\\").\\n(2) To prepare for or perform a contract with the data subject, including a contract of employment (\\"contract\\").\\n(3) To protect the life, physical or mental integrity of the data subject or another person (\\"vital interests\\").\\n(4) To protect or advance the interests of people UNICEF serves, and particularly those interests UNICEF is mandated to protect or advance (\\"beneficiary interests\\").\\n(5) Compliance with a public legal obligation to which UNICEF is subject (\\"legal obligation\\").\\n(6) Other legitimate interests of UNICEF consistent with its mandate, including the establishment, exercise or defense of legal claims or for UNICEF accountability (\\"other legitimate interests\\")."}	\N	\N	\N	lookup lookup-legitimate-basis	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.434369	2026-06-01 20:20:32.570449	\N	\N	\N	\N	\N	\N
1218	family_interview_subject	select_box	f	44	t	t	f	f	t	f	{"en": "Consent Obtained From"}	\N	\N	\N	\N	[{"id": "head_of_household", "display_text": {"en": "Head of Household"}}, {"id": "parent", "display_text": {"en": "Parent"}}, {"id": "caregiver", "display_text": {"en": "Caregiver"}}, {"id": "other", "display_text": {"en": "Other"}}]	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.43971	2026-06-01 20:20:32.572224	\N	\N	\N	\N	\N	\N
1325	cp_sex	select_box	f	54	t	t	f	t	t	f	{"en": "Sex"}	\N	\N	\N	\N	\N	lookup lookup-gender	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.429501	2026-06-01 20:20:33.48882	\N	\N	\N	\N	\N	\N
1220	family_consent_change_reason	textarea	f	44	t	t	f	f	t	f	{"en": "Reason for updating consent"}	{"en": "You only need to complete this field if you are changing an entry you made previously."}	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.449339	2026-06-01 20:20:32.574442	\N	\N	\N	\N	\N	\N
1221	family_consent_notes	text_field	f	44	t	t	f	f	t	f	{"en": "Notes"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.454254	2026-06-01 20:20:32.575336	\N	\N	\N	\N	\N	\N
1222	family_consent_for_services	tick_box	f	44	t	t	f	f	t	f	{"en": "Consent has been given for the family to participate in the case management process"}	{"en": "If consent has not been provided, do not select"}	\N	\N	{"en": "Yes"}	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.458856	2026-06-01 20:20:32.576188	\N	\N	\N	\N	\N	\N
1219	family_consent_source_other	text_field	f	44	t	t	f	f	t	f	{"en": "Provide the name of the individual who provided the consent"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.444562	2026-06-01 20:20:32.573539	\N	\N	\N	\N	\N	\N
1223	family_consent_reporting	radio_button	f	44	t	t	f	f	t	f	{"en": "Consent is given share non-identifiable information for reporting"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.463833	2026-06-01 20:20:32.577165	\N	\N	\N	\N	\N	\N
1224	family_consent_for_data_collection	radio_button	f	44	t	t	f	f	t	f	{"en": "Consent has been given to the caseworker assigned to the case to collect and store personal information about the case (e.g., name, photo, family details)."}	\N	\N	\N	\N	\N	lookup lookup-yes-no	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.469025	2026-06-01 20:20:32.577993	\N	\N	\N	\N	\N	\N
1225	family_disclosure_other_orgs	tick_box	f	44	t	t	f	f	t	f	{"en": "The individual providing consent agrees to share information about this case with other service providers according to the details described below."}	{"en": "This includes sharing information with other organizations providing services, this does not include sharing information with UNHCR."}	\N	\N	{"en": "Yes"}	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.473955	2026-06-01 20:20:32.578913	\N	\N	\N	\N	\N	\N
1226	family_information_shared_services	select_box	f	44	t	t	f	f	t	f	{"en": "Information can be shared for the following services"}	\N	\N	\N	\N	[{"id": "alternative_care", "display_text": {"en": "Alternative care"}}, {"id": "cash_assistance", "display_text": {"en": "Cash assistance"}}, {"id": "education_formal", "display_text": {"en": "Education (formal)"}}, {"id": "family_tracing_and_reunification", "display_text": {"en": "Family tracing and reunification"}}, {"id": "food", "display_text": {"en": "Food"}}, {"id": "gbv_survivor_support", "display_text": {"en": "GBV survivor support"}}, {"id": "legal_support", "display_text": {"en": "Legal support"}}, {"id": "livelihoods", "display_text": {"en": "Livelihoods"}}, {"id": "medical", "display_text": {"en": "Medical"}}, {"id": "mental_health", "display_text": {"en": "Mental health"}}, {"id": "non_food_items", "display_text": {"en": "Non-food items"}}, {"id": "non_formal_education", "display_text": {"en": "Non-formal education"}}, {"id": "nutrition", "display_text": {"en": "Nutrition"}}, {"id": "psychosocial_support", "display_text": {"en": "Psychosocial support"}}, {"id": "services_for_children_with_disabilities", "display_text": {"en": "Services for children with disabilities"}}, {"id": "shelter", "display_text": {"en": "Shelter"}}, {"id": "sexual_and_reproductive_health", "display_text": {"en": "Sexual and Reproductive Health"}}, {"id": "rescue", "display_text": {"en": "Rescue"}}, {"id": "wash", "display_text": {"en": "WASH"}}, {"id": "case_transfer", "display_text": {"en": "Case Transfer"}}, {"id": "other_please_specify", "display_text": {"en": "Other"}}]	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.480032	2026-06-01 20:20:32.580987	\N	\N	\N	\N	\N	\N
1227	family_information_shared_services_other	text_field	f	44	t	t	f	f	t	f	{"en": "If Other, please specify"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.486246	2026-06-01 20:20:32.58242	\N	\N	\N	\N	\N	\N
1228	family_unhcr_export_opt_in	tick_box	f	44	t	t	f	f	t	f	{"en": "The individual providing consent agrees to share information about this case with UNHCR for the purposes of refugee protection case management."}	\N	\N	\N	{"en": "Yes"}	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.491327	2026-06-01 20:20:32.583316	\N	\N	\N	\N	\N	\N
1229	family_consent_share_separator	separator	f	44	f	t	f	f	t	f	{"en": "Consent Details for Sharing Information"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.497027	2026-06-01 20:20:32.584109	\N	\N	\N	\N	\N	\N
1230	family_consent_info_sharing	select_box	t	44	f	t	f	f	t	f	{"en": "Consent has been given to share the information collected with"}	\N	\N	\N	\N	[{"id": "family", "display_text": {"en": "Family"}}, {"id": "authorities", "display_text": {"en": "Authorities"}}, {"id": "unhcr", "display_text": {"en": "UNHCR"}}, {"id": "other_organizations", "display_text": {"en": "Other Organizations"}}, {"id": "others", "display_text": {"en": "Others, please specify"}}]	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.503577	2026-06-01 20:20:32.585111	\N	\N	\N	\N	\N	\N
1231	family_consent_info_sharing_others	text_field	f	44	f	t	f	f	t	f	{"en": "If information can be shared with others, please specify who"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.508733	2026-06-01 20:20:32.585956	\N	\N	\N	\N	\N	\N
1232	family_withhold_details	textarea	f	44	t	t	f	f	t	f	{"en": "Withhold specific information from"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.513576	2026-06-01 20:20:32.587137	\N	\N	\N	\N	\N	\N
1233	family_disclosure_deny_details	text_field	f	44	t	t	f	f	t	f	{"en": "What specific information should be withheld"}	\N	\N	\N	\N	\N	\N	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.518136	2026-06-01 20:20:32.588049	\N	\N	\N	\N	\N	\N
1234	family_withholding_info_reason	select_box	t	44	t	t	f	f	t	f	{"en": "Reason for withholding information"}	\N	\N	\N	\N	[{"id": "fear_of_harm_themselves_or_others", "display_text": {"en": "Fear of harm to themselves or others"}}, {"id": "want_to_communicate_information_themselves", "display_text": {"en": "Want to communicate information themselves"}}, {"id": "unhcr", "display_text": {"en": "UNHCR"}}, {"id": "other", "display_text": {"en": "Other"}}]	\N	17	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.523142	2026-06-01 20:20:32.589137	\N	\N	\N	\N	\N	\N
1235	family_withholding_info_other_reason	text_field	f	44	t	t	f	f	t	f	{"en": "If other reason for withholding information, please specify"}	\N	\N	\N	\N	\N	\N	18	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.528313	2026-06-01 20:20:32.590168	\N	\N	\N	\N	\N	\N
1236	relation_name	text_field	f	45	t	t	f	f	t	f	{"en": "Name"}	\N	\N	\N	\N	\N	\N	0	f	\N	45	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.602083	2026-06-01 20:20:32.850326	\N	\N	\N	\N	\N	\N
1237	family_relationship	select_box	f	45	t	t	f	f	t	f	{"en": "What is their role in the family?"}	{"en": "This field can be copied to/from the Case but is not a shared field and can be edited on the Family record."}	\N	\N	\N	\N	lookup lookup-family-relationship	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.607802	2026-06-01 20:20:32.851632	\N	\N	\N	\N	\N	\N
1238	family_relation_is_caregiver	tick_box	f	45	t	t	f	f	t	f	{"en": "Is this person the caregiver for one of the children in this family?"}	\N	\N	\N	{"en": "Yes"}	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.614109	2026-06-01 20:20:32.852827	\N	\N	\N	\N	\N	\N
1245	relation_age	numeric_field	f	45	t	t	f	f	t	f	{"en": "Age"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.656156	2026-06-01 20:20:32.860567	\N	\N	\N	\N	\N	\N
1239	family_relationship_notes	textarea	f	45	t	t	f	f	t	f	{"en": "Notes on their role in the family."}	{"en": "This field is not shared with the case records."}	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.619719	2026-06-01 20:20:32.853998	\N	\N	\N	\N	\N	\N
1240	family_relationship_additional_notes	textarea	f	45	t	t	f	f	t	f	{"en": "Additional notes on the family member."}	{"en": "This field is not shared with the case records."}	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.625545	2026-06-01 20:20:32.85508	\N	\N	\N	\N	\N	\N
1241	relation_identifiers	text_field	f	45	f	f	f	f	t	f	{"en": "List any agency identifiers as a comma separated list"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.630902	2026-06-01 20:20:32.856071	\N	\N	\N	\N	\N	\N
1326	cp_nationality	select_box	t	54	t	t	f	f	t	f	{"en": "Nationality"}	\N	\N	\N	\N	\N	lookup lookup-country	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.434196	2026-06-01 20:20:33.48974	\N	\N	\N	\N	\N	\N
1242	relation_nickname	text_field	f	45	t	t	f	f	t	f	{"en": "Other names or spellings known by"}	{"en": "e.g., nickname, second family name"}	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.636861	2026-06-01 20:20:32.857063	\N	\N	\N	\N	\N	\N
1243	relation_is_alive	select_box	f	45	t	t	f	f	t	f	{"en": "Is this family member alive?"}	\N	\N	\N	\N	[{"id": "unknown", "display_text": {"en": "Unknown"}}, {"id": "alive", "display_text": {"en": "Alive"}}, {"id": "dead", "display_text": {"en": "Dead"}}]	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.644023	2026-06-01 20:20:32.858232	\N	\N	\N	\N	\N	\N
1244	relation_death_details	textarea	f	45	t	t	f	f	t	f	{"en": "If dead, please provide details"}	{"en": "Include date of death if known "}	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.649978	2026-06-01 20:20:32.85936	\N	\N	\N	\N	\N	\N
1246	relation_date_of_birth	date_field	f	45	t	t	f	f	t	f	{"en": "Date of Birth"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:32.661444	2026-06-01 20:20:32.861557	\N	\N	\N	\N	\N	\N
1247	relation_sex	select_box	f	45	t	t	f	f	t	f	{"en": "Sex"}	\N	\N	\N	\N	\N	lookup lookup-gender	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.668058	2026-06-01 20:20:32.862526	\N	\N	\N	\N	\N	\N
1248	relation_age_estimated	tick_box	f	45	t	t	f	f	t	f	{"en": "Is the age estimated?"}	\N	\N	\N	{"en": "Yes"}	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.673741	2026-06-01 20:20:32.863516	\N	\N	\N	\N	\N	\N
1249	relation_national_id	text_field	f	45	t	t	f	f	t	f	{"en": "National ID"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.679836	2026-06-01 20:20:32.864717	\N	\N	\N	\N	\N	\N
1250	relation_unhcr_individual_id	text_field	f	45	t	t	f	f	t	f	{"en": "UNHCR Individual ID"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.688122	2026-06-01 20:20:32.86593	\N	\N	\N	\N	\N	\N
1251	relation_other_id	text_field	f	45	t	t	f	f	t	f	{"en": "Other ID"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.694656	2026-06-01 20:20:32.867163	\N	\N	\N	\N	\N	\N
1262	relation_landmark_current	text_field	f	45	t	t	f	f	t	f	{"en": "Current Landmark"}	\N	\N	\N	\N	\N	\N	26	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.772732	2026-06-01 20:20:32.878404	\N	\N	\N	\N	\N	\N
1263	relation_location_current	select_box	f	45	t	t	f	f	t	f	{"en": "Current Location"}	\N	\N	\N	\N	\N	Location	27	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.778749	2026-06-01 20:20:32.879513	\N	\N	\N	\N	\N	\N
1264	relation_address_last	textarea	f	45	f	f	f	f	t	f	{"en": "Last Known Address"}	{"en": "If separated from child, last known address"}	\N	\N	\N	\N	\N	28	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.785017	2026-06-01 20:20:32.880712	\N	\N	\N	\N	\N	\N
1265	relation_location_last	select_box	f	45	f	f	f	f	t	f	{"en": "Last Known Location"}	{"en": "If separated from child, last known address"}	\N	\N	\N	\N	Location	29	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.791206	2026-06-01 20:20:32.881734	\N	\N	\N	\N	\N	\N
1266	relation_telephone	text_field	f	45	t	t	f	f	t	f	{"en": "Telephone / other contact details"}	\N	\N	\N	\N	\N	\N	30	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.797429	2026-06-01 20:20:32.882726	\N	\N	\N	\N	\N	\N
1252	relation_language	select_box	t	45	f	f	f	f	t	f	{"en": "Language"}	\N	\N	\N	\N	\N	lookup lookup-language	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.702565	2026-06-01 20:20:32.868327	\N	\N	\N	\N	\N	\N
1253	relation_religion	select_box	t	45	f	f	f	f	t	f	{"en": "Religion"}	\N	\N	\N	\N	\N	lookup lookup-religion	17	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.709923	2026-06-01 20:20:32.869328	\N	\N	\N	\N	\N	\N
1254	relation_ethnicity	select_box	f	45	t	t	f	f	t	f	{"en": "Ethnicity"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	18	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.718749	2026-06-01 20:20:32.870338	\N	\N	\N	\N	\N	\N
1255	relation_sub_ethnicity1	select_box	f	45	t	t	f	f	t	f	{"en": "Sub Ethnicity 1"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	19	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.726253	2026-06-01 20:20:32.871435	\N	\N	\N	\N	\N	\N
1256	relation_sub_ethnicity2	select_box	f	45	t	t	f	f	t	f	{"en": "Sub Ethnicity 2"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	20	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.732935	2026-06-01 20:20:32.872472	\N	\N	\N	\N	\N	\N
1257	relation_nationality	select_box	t	45	f	f	f	f	t	f	{"en": "Nationality"}	\N	\N	\N	\N	\N	lookup lookup-country	21	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.739341	2026-06-01 20:20:32.873458	\N	\N	\N	\N	\N	\N
1258	relation_comments	textarea	f	45	f	f	f	f	t	f	{"en": "Comments"}	\N	\N	\N	\N	\N	\N	22	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.745922	2026-06-01 20:20:32.874543	\N	\N	\N	\N	\N	\N
1259	relation_occupation	text_field	f	45	t	t	f	f	t	f	{"en": "Occupation"}	\N	\N	\N	\N	\N	\N	23	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.752571	2026-06-01 20:20:32.875514	\N	\N	\N	\N	\N	\N
1260	relation_address_current	textarea	f	45	t	t	f	f	t	f	{"en": "Current Address (if different from the child)"}	\N	\N	\N	\N	\N	\N	24	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.759263	2026-06-01 20:20:32.876562	\N	\N	\N	\N	\N	\N
1261	relation_address_is_permanent	tick_box	f	45	f	f	f	f	t	f	{"en": "Is this a permanent location?"}	\N	\N	\N	\N	\N	\N	25	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.766444	2026-06-01 20:20:32.877523	\N	\N	\N	\N	\N	\N
1267	family_number	text_field	f	46	t	t	f	f	t	f	{"en": "Family Number"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.897859	2026-06-01 20:20:32.937804	\N	\N	\N	\N	\N	\N
1268	family_size	numeric_field	f	46	t	t	f	f	t	f	{"en": "Size of Family"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.903305	2026-06-01 20:20:32.938826	\N	\N	\N	\N	\N	\N
1269	family_notes	textarea	f	46	t	t	f	f	t	f	{"en": "Notes on Family"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.908548	2026-06-01 20:20:32.939681	\N	\N	\N	\N	\N	\N
1270	family_notes_additional	textarea	f	46	t	t	f	f	t	f	{"en": "Additional Notes on the family"}	{"en": "Additional notes on the family not shared with the associated case records."}	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.914328	2026-06-01 20:20:32.940546	\N	\N	\N	\N	\N	\N
1271	family_members	subform	f	46	t	t	f	f	t	f	{"en": "Family Member"}	\N	\N	\N	\N	\N	\N	4	f	45	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.919089	2026-06-01 20:20:32.941576	\N	\N	\N	\N	\N	\N
1279	family_number	text_field	f	47	t	t	f	f	t	f	{"en": "Family Number"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.990357	2026-06-01 20:20:33.068452	\N	\N	\N	\N	\N	\N
1280	family_nationality	select_box	t	47	t	t	f	f	t	f	{"en": "Nationality"}	\N	\N	\N	\N	\N	lookup lookup-country	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.994923	2026-06-01 20:20:33.069281	\N	\N	\N	\N	\N	\N
1281	family_ethnicity	select_box	t	47	t	t	f	f	t	f	{"en": "Ethnicity/Clan/Tribe"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.999746	2026-06-01 20:20:33.070106	\N	\N	\N	\N	\N	\N
1282	family_language	select_box	t	47	t	t	f	f	t	f	{"en": "Languages spoken"}	\N	\N	\N	\N	\N	lookup lookup-language	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.004643	2026-06-01 20:20:33.070854	\N	\N	\N	\N	\N	\N
1272	family_id	text_field	f	47	f	f	f	f	f	t	{"en": "Long ID"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.955778	2026-06-01 20:20:33.061845	\N	\N	\N	\N	\N	\N
1283	family_address_current	textarea	f	47	t	t	f	f	t	f	{"en": "Family Address"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.009579	2026-06-01 20:20:33.071592	\N	\N	\N	\N	\N	\N
1284	family_landmark_current	text_field	f	47	f	t	f	f	t	f	{"en": "Family Landmark"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.014196	2026-06-01 20:20:33.07237	\N	\N	\N	\N	\N	\N
1273	short_id	text_field	f	47	f	f	f	f	f	t	{"en": "Short ID"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.961163	2026-06-01 20:20:33.062924	\N	\N	\N	\N	\N	\N
1274	family_id_display	text_field	f	47	t	t	f	f	f	t	{"en": "Family ID"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.965876	2026-06-01 20:20:33.063901	\N	\N	\N	\N	\N	\N
1275	status	select_box	f	47	t	t	f	f	f	t	{"en": "Record Status"}	\N	\N	\N	\N	\N	lookup lookup-case-status	3	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.970505	2026-06-01 20:20:33.064906	\N	\N	\N	\N	\N	\N
1276	family_registration_date	date_field	f	47	t	t	f	f	t	f	{"en": "Registration Date"}	{"en": "Date the Family record was created."}	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	today	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:32.97583	2026-06-01 20:20:33.066041	\N	\N	\N	\N	\N	\N
1277	family_type	select_box	f	47	f	t	f	f	t	f	{"en": "Family Type"}	\N	\N	\N	\N	\N	lookup lookup-family-type	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	t	default_date_validation	f	f	\N	f	2026-06-01 20:20:32.981008	2026-06-01 20:20:33.066862	\N	\N	\N	\N	\N	\N
1278	family_name	text_field	f	47	t	t	f	f	t	f	{"en": "Family Name"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:32.985633	2026-06-01 20:20:33.067677	\N	\N	\N	\N	\N	\N
1285	family_location_current	select_box	f	47	t	t	f	f	t	f	{"en": "Family Location"}	\N	\N	\N	\N	\N	Location	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.019242	2026-06-01 20:20:33.073279	\N	\N	\N	\N	\N	\N
1286	family_telephone_current	text_field	f	47	t	t	f	f	t	f	{"en": "Family Telephone"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.032587	2026-06-01 20:20:33.074053	\N	\N	\N	\N	\N	\N
1287	family_location_notes	text_field	f	47	t	t	f	f	t	f	{"en": "Notes on the Family Location and Telephone"}	{"en": "Note here if the family has multiple addresses and / or multiple telephone numbers that should be used."}	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.038079	2026-06-01 20:20:33.074918	\N	\N	\N	\N	\N	\N
1289	note_subject	text_field	f	48	t	t	f	f	t	f	{"en": "Subject"}	\N	\N	\N	\N	\N	\N	1	f	\N	48	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.091888	2026-06-01 20:20:33.120291	\N	\N	\N	\N	\N	\N
1291	note_created_by	text_field	f	48	t	t	f	f	t	t	{"en": "Notes entered by"}	\N	\N	\N	\N	\N	\N	3	f	\N	48	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.104251	2026-06-01 20:20:33.122236	\N	\N	\N	\N	\N	\N
1288	note_date	date_field	f	48	t	t	f	f	t	f	{"en": "Date"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	today	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:33.085831	2026-06-01 20:20:33.119324	\N	\N	\N	\N	\N	\N
1290	note_text	textarea	f	48	t	t	f	f	t	f	{"en": "Notes"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.098052	2026-06-01 20:20:33.121163	\N	\N	\N	\N	\N	\N
1292	notes_section	subform	f	49	t	t	f	f	t	f	{"en": "Notes"}	\N	\N	\N	\N	\N	\N	0	f	48	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	{"subform_sort_by": "notes_date"}	f	2026-06-01 20:20:33.135055	2026-06-01 20:20:33.149048	\N	\N	\N	\N	\N	\N
1293	documents	document_upload_box	f	50	t	t	f	f	t	f	{"en": "Document"}	{"en": "Only PDF, TXT, DOC, DOCX, XLS, XLSX, CSV, JPG, JPEG, PNG files permitted"}	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.161079	2026-06-01 20:20:33.171598	\N	\N	\N	\N	\N	\N
1294	record_state	tick_box	f	51	t	t	f	f	f	t	{"en": "Valid Record?"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.181744	2026-06-01 20:20:33.225001	\N	\N	\N	\N	\N	\N
1295	owned_by	select_box	f	51	t	t	f	f	t	t	{"en": "Record Owner"}	\N	\N	\N	\N	\N	User	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.186961	2026-06-01 20:20:33.225973	\N	\N	\N	\N	\N	\N
1296	owned_by_agency_id	select_box	f	51	t	t	f	f	f	t	{"en": "Record Owner's Agency"}	\N	\N	\N	\N	\N	Agency	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.191632	2026-06-01 20:20:33.226924	\N	\N	\N	\N	\N	\N
1297	owned_by_location	select_box	f	51	t	t	f	f	f	t	{"en": "Record Owner's Location"}	\N	\N	\N	\N	\N	Location	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.195777	2026-06-01 20:20:33.227765	\N	\N	\N	\N	\N	\N
1298	created_at	date_field	f	51	t	t	f	f	f	t	{"en": "Created at"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	t	f	\N	f	2026-06-01 20:20:33.200296	2026-06-01 20:20:33.228635	\N	\N	\N	\N	\N	\N
1299	created_by	text_field	f	51	t	t	f	f	f	t	{"en": "Record created by"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.204659	2026-06-01 20:20:33.229479	\N	\N	\N	\N	\N	\N
1300	created_organization	select_box	f	51	t	t	f	f	t	t	{"en": "Created by agency"}	\N	\N	\N	\N	\N	Agency	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.209601	2026-06-01 20:20:33.230252	\N	\N	\N	\N	\N	\N
1301	cp_case_id	text_field	f	52	f	f	f	f	f	t	{"en": "Long ID"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.243318	2026-06-01 20:20:33.314901	\N	\N	\N	\N	\N	\N
1302	short_id	text_field	f	52	t	f	f	f	f	t	{"en": "Short ID"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.248225	2026-06-01 20:20:33.315898	\N	\N	\N	\N	\N	\N
1303	status	select_box	f	52	t	t	f	f	t	f	{"en": "Incident Status"}	\N	\N	\N	\N	\N	lookup lookup-incident-status	2	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.253081	2026-06-01 20:20:33.3168	\N	\N	\N	\N	\N	\N
1304	incident_date	date_field	f	52	t	t	f	f	t	f	{"en": "Date of Incident"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.257463	2026-06-01 20:20:33.317639	\N	\N	\N	\N	\N	\N
1305	cp_incident_location_type	select_box	f	52	t	t	f	f	t	f	{"en": "Area of the Incident"}	\N	\N	\N	\N	\N	lookup lookup-incident-location	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.261958	2026-06-01 20:20:33.318473	\N	\N	\N	\N	\N	\N
1306	cp_incident_location_type_other	text_field	f	52	t	t	f	f	t	f	{"en": "If 'Other', please specify"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.266791	2026-06-01 20:20:33.319362	\N	\N	\N	\N	\N	\N
1307	incident_location	select_box	f	52	t	t	f	f	t	f	{"en": "Location of the Incident"}	\N	\N	\N	\N	\N	Location	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.271382	2026-06-01 20:20:33.320235	\N	\N	\N	\N	\N	\N
1308	cp_incident_timeofday	select_box	f	52	t	t	f	f	t	f	{"en": "Time of Incident"}	\N	\N	\N	\N	\N	lookup lookup-time-of-day	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.275695	2026-06-01 20:20:33.321015	\N	\N	\N	\N	\N	\N
1312	cp_incident_previous_incidents_description	textarea	f	52	t	t	f	f	t	f	{"en": "If yes please describe in brief"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.29482	2026-06-01 20:20:33.324275	\N	\N	\N	\N	\N	\N
1309	cp_incident_timeofday_actual	text_field	f	52	t	t	f	f	t	f	{"en": "Please specify the actual time of the Incident"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.279963	2026-06-01 20:20:33.321814	\N	\N	\N	\N	\N	\N
1310	cp_incident_violence_type	select_box	f	52	t	t	f	f	t	f	{"en": "Type of Violence"}	\N	\N	\N	\N	\N	lookup lookup-cp-violence-type	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.284749	2026-06-01 20:20:33.322712	\N	\N	\N	\N	\N	\N
1311	cp_incident_previous_incidents	radio_button	f	52	t	t	f	f	t	f	{"en": "Has the case been previously abused?"}	\N	\N	\N	\N	\N	lookup lookup-yes-no	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.289439	2026-06-01 20:20:33.323504	\N	\N	\N	\N	\N	\N
1313	current_owner_section	separator	f	53	t	t	f	f	t	f	{"en": "Current Owner"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.334421	2026-06-01 20:20:33.403674	\N	\N	\N	\N	\N	\N
1314	caseworker_name	text_field	f	53	f	t	f	f	t	f	{"en": "Field/Case/Social Worker"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.339588	2026-06-01 20:20:33.404783	\N	\N	\N	\N	\N	\N
1315	owned_by	select_box	f	53	t	t	f	f	f	t	{"en": "Caseworker Code"}	\N	\N	\N	\N	\N	User	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.34431	2026-06-01 20:20:33.40579	\N	\N	\N	\N	\N	\N
1316	owned_by_agency_id	select_box	f	53	f	t	f	f	f	t	{"en": "Agency"}	\N	\N	\N	\N	\N	Agency	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.349251	2026-06-01 20:20:33.406637	\N	\N	\N	\N	\N	\N
1317	assigned_user_names	select_box	t	53	t	t	f	f	t	f	{"en": "Other Assigned Users"}	\N	\N	\N	\N	\N	User	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.354074	2026-06-01 20:20:33.407521	\N	\N	\N	\N	\N	\N
1318	record_history_section	separator	f	53	t	t	f	f	t	f	{"en": "Record History"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.358978	2026-06-01 20:20:33.408365	\N	\N	\N	\N	\N	\N
1319	created_by	text_field	f	53	t	t	f	f	f	t	{"en": "Record created by"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.363615	2026-06-01 20:20:33.40919	\N	\N	\N	\N	\N	\N
1320	created_organization	text_field	f	53	t	t	f	f	f	t	{"en": "Created by agency"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.368445	2026-06-01 20:20:33.410065	\N	\N	\N	\N	\N	\N
1321	previously_owned_by	text_field	f	53	t	t	f	f	f	t	{"en": "Previous Owner"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.373257	2026-06-01 20:20:33.410859	\N	\N	\N	\N	\N	\N
1322	previous_agency	text_field	f	53	t	t	f	f	t	f	{"en": "Previous Agency"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.378299	2026-06-01 20:20:33.411799	\N	\N	\N	\N	\N	\N
1327	national_id_no	text_field	f	54	t	t	f	f	t	f	{"en": "National ID Number"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.439036	2026-06-01 20:20:33.490539	\N	\N	\N	\N	\N	\N
1328	other_id_type	text_field	f	54	t	t	f	f	t	f	{"en": "Type of Other ID Document"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.444012	2026-06-01 20:20:33.491357	\N	\N	\N	\N	\N	\N
1329	other_id_no	text_field	f	54	t	t	f	f	t	f	{"en": "Number of Other ID Document"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.449085	2026-06-01 20:20:33.492123	\N	\N	\N	\N	\N	\N
1330	maritial_status	select_box	f	54	t	t	f	t	t	f	{"en": "Social Status"}	\N	\N	\N	\N	\N	lookup lookup-marital-status	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.453963	2026-06-01 20:20:33.492994	\N	\N	\N	\N	\N	\N
1331	educational_status	select_box	f	54	t	t	f	f	t	f	{"en": "Educational Status"}	\N	\N	\N	\N	[{"id": "illiterate", "display_text": {"en": "Illiterate"}}, {"id": "basic", "display_text": {"en": "Basic"}}, {"id": "secondary", "display_text": {"en": "Secondary"}}, {"id": "bachelor", "display_text": {"en": "Bachelor"}}, {"id": "post_graduate_studies", "display_text": {"en": "Post-graduate Studies"}}]	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.458909	2026-06-01 20:20:33.494076	\N	\N	\N	\N	\N	\N
1332	occupation	text_field	f	54	t	t	f	f	t	f	{"en": "Occupation"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.464048	2026-06-01 20:20:33.49506	\N	\N	\N	\N	\N	\N
1333	cp_disability_type	select_box	f	54	t	t	f	f	t	f	{"en": "Disability Type"}	\N	\N	\N	\N	\N	lookup lookup-disability-type	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.468806	2026-06-01 20:20:33.495866	\N	\N	\N	\N	\N	\N
1334	cp_incident_abuser_name	text_field	f	55	f	t	f	f	t	f	{"en": "Name"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.508104	2026-06-01 20:20:33.577096	\N	\N	\N	\N	\N	\N
1335	cp_incident_perpetrator_nationality	select_box	f	55	t	t	f	f	t	f	{"en": "Nationality"}	\N	\N	\N	\N	\N	lookup lookup-country	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.513176	2026-06-01 20:20:33.578158	\N	\N	\N	\N	\N	\N
1336	perpetrator_sex	radio_button	f	55	t	t	f	f	t	f	{"en": "Sex"}	\N	\N	\N	\N	\N	lookup lookup-gender	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.51786	2026-06-01 20:20:33.57939	\N	\N	\N	\N	\N	\N
1337	cp_incident_perpetrator_date_of_birth	date_field	f	55	t	t	f	f	t	f	{"en": "Date of Birth"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.522526	2026-06-01 20:20:33.58022	\N	\N	\N	\N	\N	\N
1338	cp_incident_perpetrator_age	numeric_field	f	55	t	t	f	f	t	f	{"en": "Age"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.527213	2026-06-01 20:20:33.581084	\N	\N	\N	\N	\N	\N
1339	cp_incident_perpetrator_national_id_no	text_field	f	55	t	t	f	f	t	f	{"en": "National ID Number"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.531744	2026-06-01 20:20:33.5819	\N	\N	\N	\N	\N	\N
1340	cp_incident_perpetrator_other_id_type	text_field	f	55	t	t	f	f	t	f	{"en": "Type of Other ID Document"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.536391	2026-06-01 20:20:33.582718	\N	\N	\N	\N	\N	\N
1341	cp_incident_perpetrator_other_id_no	text_field	f	55	t	t	f	f	t	f	{"en": "Number of Other ID Document"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.540898	2026-06-01 20:20:33.583469	\N	\N	\N	\N	\N	\N
1342	cp_incident_perpetrator_marital_status	select_box	f	55	t	t	f	t	t	f	{"en": "Social Status"}	\N	\N	\N	\N	\N	lookup lookup-marital-status	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.545723	2026-06-01 20:20:33.584299	\N	\N	\N	\N	\N	\N
1343	cp_incident_perpetrator_occupation	text_field	f	55	t	t	f	f	t	f	{"en": "Occupation"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.55037	2026-06-01 20:20:33.585093	\N	\N	\N	\N	\N	\N
1344	cp_incident_perpetrator_relationship	select_box	f	55	t	t	f	f	t	f	{"en": "Relationship with the abused"}	\N	\N	\N	\N	\N	lookup lookup-perpetrator-relationship	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.555078	2026-06-01 20:20:33.585916	\N	\N	\N	\N	\N	\N
1345	record_state	tick_box	f	56	t	t	f	f	f	t	{"en": "Valid Record?"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.595496	2026-06-01 20:20:33.6316	\N	\N	\N	\N	\N	\N
1346	owned_by_agency_id	select_box	f	56	t	t	f	f	f	t	{"en": "Case Manager's Agency"}	\N	\N	\N	\N	\N	Agency	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.605848	2026-06-01 20:20:33.632827	\N	\N	\N	\N	\N	\N
1347	owned_by_location	select_box	f	56	t	t	f	f	f	t	{"en": "Case Manager's Location"}	\N	\N	\N	\N	\N	Location	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.61132	2026-06-01 20:20:33.63386	\N	\N	\N	\N	\N	\N
1348	has_case_plan	tick_box	f	56	t	t	f	f	f	t	{"en": "Does this case have a case plan?"}	\N	\N	\N	\N	\N	\N	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.617233	2026-06-01 20:20:33.634781	\N	\N	\N	\N	\N	\N
1349	current_owner_section	separator	f	57	t	f	f	f	t	f	{"en": "Current Owner"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.647594	2026-06-01 20:20:33.757432	\N	\N	\N	\N	\N	\N
1350	caseworker_name	text_field	f	57	t	t	f	t	t	f	{"en": "Field/Case/Social Worker"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.653393	2026-06-01 20:20:33.758496	\N	\N	\N	\N	\N	\N
1351	owned_by	select_box	f	57	t	t	f	t	f	t	{"en": "Caseworker Code"}	\N	\N	\N	\N	\N	User	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.658349	2026-06-01 20:20:33.759477	\N	\N	\N	\N	\N	\N
1352	owned_by_agency_id	select_box	f	57	t	f	f	f	f	t	{"en": "Agency"}	\N	\N	\N	\N	\N	Agency	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.667101	2026-06-01 20:20:33.76034	\N	\N	\N	\N	\N	\N
1353	assigned_user_names	select_box	t	57	t	f	f	f	t	f	{"en": "Other Assigned Users"}	\N	\N	\N	\N	\N	User	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.679415	2026-06-01 20:20:33.761621	\N	\N	\N	\N	\N	\N
1354	record_history_section	separator	f	57	t	f	f	f	t	f	{"en": "Record History"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.691903	2026-06-01 20:20:33.762539	\N	\N	\N	\N	\N	\N
1355	created_by	text_field	f	57	t	f	f	f	f	t	{"en": "Record created by"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.699285	2026-06-01 20:20:33.763441	\N	\N	\N	\N	\N	\N
1356	created_organization	text_field	f	57	t	f	f	f	f	t	{"en": "Created by agency"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.709582	2026-06-01 20:20:33.765047	\N	\N	\N	\N	\N	\N
1357	previously_owned_by	text_field	f	57	t	f	f	f	f	t	{"en": "Previous Owner"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.71662	2026-06-01 20:20:33.767153	\N	\N	\N	\N	\N	\N
1358	previous_agency	text_field	f	57	t	f	f	f	t	f	{"en": "Previous Agency"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.724297	2026-06-01 20:20:33.769687	\N	\N	\N	\N	\N	\N
1359	module_id	text_field	f	57	t	f	f	f	f	t	{"en": "Module"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.729483	2026-06-01 20:20:33.770727	\N	\N	\N	\N	\N	\N
1360	registry_id	text_field	f	58	f	f	f	f	f	t	{"en": "Long ID"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.781734	2026-06-01 20:20:33.884009	\N	\N	\N	\N	\N	\N
1361	short_id	text_field	f	58	f	f	f	f	f	t	{"en": "Short ID"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.789687	2026-06-01 20:20:33.886411	\N	\N	\N	\N	\N	\N
1362	registry_id_display	text_field	f	58	t	t	f	f	f	t	{"en": "Registry ID"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.793937	2026-06-01 20:20:33.887694	\N	\N	\N	\N	\N	\N
1363	status	select_box	f	58	t	t	f	f	f	t	{"en": "Registry Status"}	\N	\N	\N	\N	\N	lookup lookup-registry-status	3	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.799057	2026-06-01 20:20:33.88868	\N	\N	\N	\N	\N	\N
1364	registration_date	date_field	f	58	t	t	f	f	t	f	{"en": "Registration Date"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	today	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:33.806548	2026-06-01 20:20:33.889523	\N	\N	\N	\N	\N	\N
1365	registry_category	select_box	f	58	f	t	f	f	t	f	{"en": "Registry Category"}	\N	\N	\N	\N	\N	lookup lookup-registry-category	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.811113	2026-06-01 20:20:33.890374	\N	\N	\N	\N	\N	\N
1366	name	text_field	f	58	t	t	f	f	t	f	{"en": "Registry Name"}	\N	\N	\N	\N	\N	\N	6	t	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.818292	2026-06-01 20:20:33.891167	\N	\N	\N	\N	\N	\N
1367	sex	select_box	f	58	t	t	f	t	t	f	{"en": "Sex"}	\N	\N	\N	\N	\N	lookup lookup-gender	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.824836	2026-06-01 20:20:33.892162	\N	\N	\N	\N	\N	\N
1373	tracing_request_id	text_field	f	59	t	t	f	f	f	t	{"en": "Long ID", "es": "ID largo"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.910194	2026-06-02 19:58:13.804748	\N	\N	\N	\N	\N	\N
1380	relation_age	numeric_field	f	59	t	t	f	t	t	f	{"en": "Age", "es": "Edad"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.948615	2026-06-02 19:58:13.814814	\N	\N	\N	\N	\N	\N
1381	relation_date_of_birth	date_field	f	59	t	t	f	t	t	f	{"en": "Date of Birth", "es": "Fecha de nacimiento"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	not_future_date	f	f	\N	f	2026-06-01 20:20:33.95694	2026-06-02 19:58:13.822584	\N	\N	\N	\N	\N	\N
1382	relation_language	select_box	t	59	t	t	f	f	t	f	{"en": "Language", "es": "Idioma"}	\N	\N	\N	\N	\N	lookup lookup-language	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.962085	2026-06-02 19:58:13.830656	\N	\N	\N	\N	\N	\N
1368	registry_no	text_field	f	58	t	t	f	f	t	f	{"en": "Registry ID Number"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.8298	2026-06-01 20:20:33.893075	\N	\N	\N	\N	\N	\N
1369	other_id_no_system	text_field	f	58	f	t	f	f	t	f	{"en": "Other ID Number"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.838517	2026-06-01 20:20:33.893899	\N	\N	\N	\N	\N	\N
1370	address_current	textarea	f	58	t	t	f	f	t	f	{"en": "Current Address"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.844338	2026-06-01 20:20:33.894694	\N	\N	\N	\N	\N	\N
1371	location_current	select_box	f	58	t	t	f	f	t	f	{"en": "Current Location"}	\N	\N	\N	\N	\N	Location	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.850318	2026-06-01 20:20:33.895437	\N	\N	\N	\N	\N	\N
1372	telephone_current	text_field	f	58	t	t	f	f	t	f	{"en": "Current Telephone"}	\N	\N	\N	\N	\N	\N	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.858071	2026-06-01 20:20:33.896353	\N	\N	\N	\N	\N	\N
1383	relation_religion	select_box	t	59	t	t	f	f	t	f	{"en": "Religion", "es": "Religión"}	\N	\N	\N	\N	\N	lookup lookup-religion	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.970323	2026-06-02 19:58:13.841158	\N	\N	\N	\N	\N	\N
1384	relation_ethnicity	select_box	f	59	t	t	f	f	t	f	{"en": "Ethnicity", "es": "Etnia"}	\N	\N	\N	\N	\N	lookup lookup-ethnicity	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.975454	2026-06-02 19:58:13.849496	\N	\N	\N	\N	\N	\N
1385	relation_nationality	select_box	t	59	t	t	f	t	t	f	{"en": "Nationality", "es": "Nacionalidad"}	\N	\N	\N	\N	\N	lookup lookup-nationality	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.98006	2026-06-02 19:58:13.85798	\N	\N	\N	\N	\N	\N
1374	short_id	text_field	f	59	t	t	f	f	f	t	{"en": "Inquirer ID"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.916113	2026-06-01 20:20:34.07983	\N	\N	\N	\N	\N	\N
1375	inquiry_date	date_field	f	59	t	t	f	t	t	f	{"en": "Date of Inquiry"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	today	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.921649	2026-06-01 20:20:34.080812	\N	\N	\N	\N	\N	\N
1376	status	select_box	f	59	t	t	f	t	t	f	{"en": "Inquiry Status"}	\N	\N	\N	\N	\N	lookup lookup-inquiry-status	3	f	\N	\N	f	\N	open	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.926339	2026-06-01 20:20:34.081874	\N	\N	\N	\N	\N	\N
1377	inquirer_details_section	separator	f	59	t	t	f	f	t	f	{"en": "Inquirer Details"}	\N	\N	\N	\N	\N	\N	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.932429	2026-06-01 20:20:34.083038	\N	\N	\N	\N	\N	\N
1378	relation_name	text_field	f	59	t	t	f	t	t	f	{"en": "Name of inquirer"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.938407	2026-06-01 20:20:34.084156	\N	\N	\N	\N	\N	\N
1379	relation_nickname	text_field	f	59	t	t	f	f	t	f	{"en": "Nickname of inquirer"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.943415	2026-06-01 20:20:34.085169	\N	\N	\N	\N	\N	\N
1387	relation_address_current	textarea	f	59	t	t	f	t	t	f	{"en": "Current Address", "es": "Dirección actual"}	\N	\N	\N	\N	\N	\N	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.988998	2026-06-02 19:58:13.864493	\N	\N	\N	\N	\N	\N
1388	relation_location_current	select_box	f	59	t	t	f	f	t	f	{"en": "Current Location", "es": "Ubicación actual"}	\N	\N	\N	\N	\N	Location	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.993593	2026-06-02 19:58:13.871969	\N	\N	\N	\N	\N	\N
1389	relation_telephone	text_field	f	59	t	t	f	f	t	f	{"en": "Telephone", "es": "Teléfono"}	\N	\N	\N	\N	\N	\N	16	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:33.997997	2026-06-02 19:58:13.879472	\N	\N	\N	\N	\N	\N
1390	separation_history_section	separator	f	59	t	t	f	f	t	f	{"en": "Separation History", "es": "Historial de separación"}	\N	\N	\N	\N	\N	\N	17	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.003512	2026-06-02 19:58:13.887203	\N	\N	\N	\N	\N	\N
1391	date_of_separation	date_field	f	59	t	t	f	f	t	f	{"en": "Date of Separation", "es": "Fecha de separación"}	\N	\N	\N	\N	\N	\N	18	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.009288	2026-06-02 19:58:13.895743	\N	\N	\N	\N	\N	\N
1392	separation_cause	select_box	f	59	t	t	f	f	t	f	{"en": "What was the main cause of separation?", "es": "¿Cuál fue la causa principal de la separación?"}	\N	\N	\N	\N	\N	lookup lookup-separation-cause	19	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.018219	2026-06-02 19:58:13.901728	\N	\N	\N	\N	\N	\N
1393	separation_cause_other	textarea	f	59	t	t	f	f	t	f	{"en": "If Other, please specify", "es": "Si es otro, especifique"}	\N	\N	\N	\N	\N	\N	20	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.023646	2026-06-02 19:58:13.90981	\N	\N	\N	\N	\N	\N
1394	location_separation	select_box	f	59	t	t	f	f	t	f	{"en": "Separation Location", "es": "Lugar de separación"}	\N	\N	\N	\N	\N	Location	21	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.02893	2026-06-02 19:58:13.91611	\N	\N	\N	\N	\N	\N
1395	location_last	select_box	f	59	t	t	f	f	t	f	{"en": "Last Location", "es": "Última ubicación"}	\N	\N	\N	\N	\N	Location	22	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.034337	2026-06-02 19:58:13.924967	\N	\N	\N	\N	\N	\N
1396	telephone_last	text_field	f	59	t	t	f	f	t	f	{"en": "Last Telephone", "es": "Último teléfono"}	\N	\N	\N	\N	\N	\N	23	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.038772	2026-06-02 19:58:13.93166	\N	\N	\N	\N	\N	\N
1397	disclosure_other_orgs	tick_box	f	59	t	t	f	f	f	t	{"en": "Does the inquirer agree to share collected information with other organizations?"}	{}	\N	\N	{"en": "Yes", "es": "Sí"}	\N	\N	24	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.043947	2026-06-02 19:58:13.93772	\N	\N	\N	\N	\N	\N
1398	record_state	tick_box	f	60	t	t	f	f	f	t	{"en": "Valid Record?", "es": "¿Registro válido?"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.114415	2026-06-02 19:58:13.952976	\N	\N	\N	\N	\N	\N
1399	photos	photo_upload_box	f	61	t	t	f	t	f	t	{"en": "Photos", "es": "Fotos"}	{"en": "Only PNG, JPEG, and GIF files permitted", "es": "Solo se permiten archivos PNG, JPEG y GIF"}	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.134797	2026-06-02 19:58:13.975095	\N	\N	\N	\N	\N	\N
1400	recorded_audio	audio_upload_box	f	61	t	t	f	t	f	t	{"en": "Recorded Audio", "es": "Audio grabado"}	{"en": "Only MP3 and M4A files permitted", "es": "Solo se permiten archivos MP3 y M4A"}	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.140281	2026-06-02 19:58:13.987062	\N	\N	\N	\N	\N	\N
1401	current_owner_section	separator	f	62	t	t	f	f	t	f	{"en": "Current Owner", "es": "Responsable actual"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.178933	2026-06-02 19:58:14.010936	\N	\N	\N	\N	\N	\N
1402	caseworker_name	text_field	f	62	t	t	f	f	t	f	{"en": "Field/Case/Social Worker", "es": "Trabajador de campo, caso o trabajo social"}	\N	\N	\N	\N	\N	\N	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.189354	2026-06-02 19:58:14.018121	\N	\N	\N	\N	\N	\N
1403	owned_by	select_box	f	62	t	t	f	f	f	t	{"en": "Caseworker Code", "es": "Código del trabajador del caso"}	\N	\N	\N	\N	\N	User	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.195046	2026-06-02 19:58:14.026588	\N	\N	\N	\N	\N	\N
1404	owned_by_agency_id	select_box	f	62	t	t	f	f	f	t	{"en": "Agency", "es": "Agencia"}	\N	\N	\N	\N	\N	Agency	3	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.202249	2026-06-02 19:58:14.033738	\N	\N	\N	\N	\N	\N
1405	assigned_user_names	select_box	t	62	t	t	f	f	t	f	{"en": "Other Assigned Users", "es": "Otros usuarios asignados"}	\N	\N	\N	\N	\N	User	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.208584	2026-06-02 19:58:14.042589	\N	\N	\N	\N	\N	\N
1406	record_history_section	separator	f	62	t	t	f	f	t	f	{"en": "Record History", "es": "Historial del registro"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.213647	2026-06-02 19:58:14.049873	\N	\N	\N	\N	\N	\N
1386	contact_information_section	separator	f	59	t	t	f	f	t	f	{"en": "Contact Information"}	\N	\N	\N	\N	\N	\N	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:33.984772	2026-06-01 20:20:34.092083	\N	\N	\N	\N	\N	\N
1407	created_by	text_field	f	62	t	t	f	f	f	t	{"en": "Record created by", "es": "Registro creado por"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.221821	2026-06-02 19:58:14.059004	\N	\N	\N	\N	\N	\N
1408	created_organization	text_field	f	62	t	t	f	f	f	t	{"en": "Created by agency", "es": "Creado por la agencia"}	\N	\N	\N	\N	\N	\N	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.226646	2026-06-02 19:58:14.066275	\N	\N	\N	\N	\N	\N
1409	previously_owned_by	text_field	f	62	t	t	f	f	f	t	{"en": "Previous Owner", "es": "Responsable anterior"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.231778	2026-06-02 19:58:14.07579	\N	\N	\N	\N	\N	\N
1410	previous_agency	text_field	f	62	t	t	f	f	t	f	{"en": "Previous Agency", "es": "Agencia anterior"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.239649	2026-06-02 19:58:14.084057	\N	\N	\N	\N	\N	\N
1411	module_id	text_field	f	62	t	t	f	f	f	t	{"en": "Module", "es": "Módulo"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.245093	2026-06-02 19:58:14.092504	\N	\N	\N	\N	\N	\N
1415	name	text_field	f	63	t	t	f	f	t	f	{"en": "Name", "es": "Nombre"}	\N	\N	\N	\N	\N	\N	3	f	\N	63	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.31499	2026-06-02 19:58:14.102973	\N	\N	\N	\N	\N	\N
1412	matched_case_id	text_field	f	63	t	t	f	f	f	t	{"en": "Matched Case ID"}	\N	\N	\N	\N	\N	\N	0	f	\N	\N	f	\N	\N	case	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.293092	2026-06-01 20:20:34.436034	\N	\N	\N	\N	\N	\N
1413	tracing_request_status	select_box	f	63	t	t	f	f	t	f	{"en": "Tracing status"}	\N	\N	\N	\N	\N	lookup lookup-tracing-status	1	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.300892	2026-06-01 20:20:34.436958	\N	\N	\N	\N	\N	\N
1414	individual_details_section	separator	f	63	t	t	f	f	t	f	{"en": "Individual Details"}	\N	\N	\N	\N	\N	\N	2	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.309109	2026-06-01 20:20:34.437821	\N	\N	\N	\N	\N	\N
1416	relation	select_box	f	63	t	t	f	f	t	f	{"en": "How is the inquirer related to the child?"}	\N	\N	\N	\N	\N	lookup lookup-family-relationship	4	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.323803	2026-06-01 20:20:34.439465	\N	\N	\N	\N	\N	\N
1417	name_nickname	text_field	f	63	t	t	f	f	t	f	{"en": "Nickname", "es": "Apodo"}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.329522	2026-06-02 19:58:14.112985	\N	\N	\N	\N	\N	\N
1418	name_other	text_field	f	63	t	t	f	f	t	f	{"en": "Other Name", "es": "Otro nombre"}	\N	\N	\N	\N	\N	\N	6	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.338843	2026-06-02 19:58:14.119861	\N	\N	\N	\N	\N	\N
1419	sex	select_box	f	63	t	t	f	f	t	f	{"en": "Sex", "es": "Sexo"}	\N	\N	\N	\N	\N	lookup lookup-gender	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.344747	2026-06-02 19:58:14.128374	\N	\N	\N	\N	\N	\N
1421	date_of_birth	date_field	f	63	t	t	f	f	t	f	{"en": "Date of Birth", "es": "Fecha de nacimiento"}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	not_future_date	f	t	\N	f	2026-06-01 20:20:34.359964	2026-06-02 19:58:14.144885	\N	\N	\N	\N	\N	\N
1423	date_of_separation	date_field	f	63	t	t	f	f	t	f	{"en": "Date of Separation", "es": "Fecha de separación"}	\N	\N	\N	\N	\N	\N	11	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.374591	2026-06-02 19:58:14.151814	\N	\N	\N	\N	\N	\N
1427	telephone_last	text_field	f	63	t	t	f	f	t	f	{"en": "Last Telephone", "es": "Último teléfono"}	\N	\N	\N	\N	\N	\N	15	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.406709	2026-06-02 19:58:14.182605	\N	\N	\N	\N	\N	\N
1422	separation_details_section	separator	f	63	t	t	f	f	t	f	{"en": "Separation Details (if different from Inquirer form)"}	\N	\N	\N	\N	\N	\N	10	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.367055	2026-06-01 20:20:34.444343	\N	\N	\N	\N	\N	\N
1420	age	numeric_field	f	63	t	t	f	f	t	f	{"en": "Age", "es": "Edad"}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.351529	2026-06-02 19:58:14.136084	\N	\N	\N	\N	\N	\N
1424	separation_cause	select_box	f	63	t	t	f	f	t	f	{"en": "What was the main cause of separation?", "es": "¿Cuál fue la causa principal de la separación?"}	\N	\N	\N	\N	\N	lookup lookup-separation-cause	12	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.383845	2026-06-02 19:58:14.160392	\N	\N	\N	\N	\N	\N
1425	location_separation	select_box	f	63	t	t	f	f	t	f	{"en": "Separation Location", "es": "Lugar de separación"}	\N	\N	\N	\N	\N	Location	13	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.391635	2026-06-02 19:58:14.167457	\N	\N	\N	\N	\N	\N
1426	location_last	select_box	f	63	t	t	f	f	t	f	{"en": "Last Location", "es": "Última ubicación"}	\N	\N	\N	\N	\N	Location	14	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	t	\N	f	2026-06-01 20:20:34.399078	2026-06-02 19:58:14.176413	\N	\N	\N	\N	\N	\N
1428	tracing_request_subform_section	subform	f	64	t	t	f	f	t	f	{"en": "Tracing Request"}	\N	\N	\N	\N	\N	\N	0	f	63	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:34.461284	2026-06-01 20:20:34.475913	\N	\N	\N	\N	\N	\N
1155	telephone_agency	text_field	f	32	f	f	f	f	t	f	{"en": "Agency Telephone", "es": ""}	\N	\N	\N	\N	\N	\N	5	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.788835	2026-06-05 14:11:28.566805	\N	\N	\N	\N	\N	\N
1157	database_operator_user_name	select_box	f	32	f	f	f	f	t	f	{"en": "Database Operator", "es": ""}	\N	\N	\N	\N	\N	User	7	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.798507	2026-06-05 14:11:28.572462	\N	\N	\N	\N	\N	\N
1158	address_registration	textarea	f	32	f	f	f	f	t	f	{"en": "Registration Address", "es": ""}	\N	\N	\N	\N	\N	\N	8	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.803296	2026-06-05 14:11:28.575953	\N	\N	\N	\N	\N	\N
1159	location_registration	text_field	f	32	f	f	f	f	t	f	{"en": "Location Address", "es": ""}	\N	\N	\N	\N	\N	\N	9	f	\N	\N	f	\N	\N	\N	t	{}	\N	f	f	default_date_validation	f	f	\N	f	2026-06-01 20:20:31.808437	2026-06-05 14:11:28.579272	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: flags; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.flags (id, record_id, record_type, date, message, flagged_by, removed, unflag_message, created_at, system_generated_followup, unflagged_by, unflagged_date, record_uuid) FROM stdin;
\.


--
-- Data for Name: form_sections; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.form_sections (id, unique_id, name_i18n, help_text_i18n, description_i18n, parent_form, visible, "order", order_form_group, order_subform, form_group_keyed, form_group_id, editable, core_form, is_nested, is_first_tab, initial_subforms, subform_prevent_item_removal, subform_append_only, subform_header_links, display_help_text_view, shared_subform, shared_subform_group, is_summary_section, hide_subform_placeholder, mobile_form, header_message_link, created_at, updated_at, display_conditions) FROM stdin;
22	incident_details_container	{"en": "Incident Details", "es": "Detalles del incidente"}	\N	{"en": "Incident details information about a child."}	case	t	0	30	0	f	identification_registration	f	t	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.791139	2026-06-01 20:47:08.04364	\N
23	incident_from_case	{"en": "Incidents", "es": "Incidentes"}	\N	{"en": "Incidents from case"}	case	t	3	0	0	f	record_information	t	t	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.807582	2026-06-01 20:47:08.070645	\N
34	referral_transfer	{"en": "Referrals and Transfers", "es": "Derivaciones y transferencias"}	\N	{"en": "List of Transfers and Referrals"}	case	f	10	150	0	f	referrals_transfers	f	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.11867	2026-06-01 20:47:08.496184	\N
35	referral	{"en": "Referral", "es": "Derivación"}	\N	{"en": "Referral"}	case	t	4	0	0	f	record_information	t	t	f	t	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.140494	2026-06-01 20:47:08.522266	\N
36	registry_from_case	{"en": "Registry Details", "es": "Detalles del registro"}	\N	{"en": "Registry from case"}	case	f	3	1	0	f	identification_registration	t	t	f	t	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.149949	2026-06-01 20:47:08.530368	\N
7	change_logs	{"en": "Change Log", "es": "Historial de cambios"}	\N	{"en": "Change Log"}	case	t	6	0	0	f	record_information	t	t	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.343481	2026-06-01 20:47:07.420745	\N
8	child_preferences_section	{"en": "Nested Child's Preferences", "es": "Preferencias del niño"}	\N	{"en": "Child's Preferences Subform"}	case	f	10	130	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.361272	2026-06-01 20:47:07.430654	\N
9	child_wishes	{"en": "Child's Wishes", "es": "Deseos del niño"}	\N	{"en": "Child's Wishes"}	case	f	10	130	0	f	tracing	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.408483	2026-06-01 20:47:07.445719	\N
15	family_details	{"en": "Family Details", "es": "Detalles de la familia"}	\N	{"en": "Family Details"}	case	t	10	50	0	f	family_partner_details	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.623654	2026-06-01 20:47:07.821347	\N
16	family_from_case	{"en": "Family Details", "es": "Detalles de la familia"}	\N	{"en": "Family Details"}	case	t	4	1	0	f	identification_registration	t	t	f	t	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.640912	2026-06-01 20:47:07.843967	\N
17	notes_section	{"en": "Nested Notes Subform", "es": "Notas"}	\N	{"en": "Nested Notes Subform"}	case	f	20	110	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.650704	2026-06-01 20:47:07.852984	\N
18	notes	{"en": "Notes", "es": "Notas"}	\N	{"en": "Notes"}	case	t	20	1001	0	f	notes	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.674951	2026-06-01 20:47:07.885038	\N
37	services_section	{"en": "Nested Services", "es": "Servicios"}	\N	{"en": "Services Subform"}	case	f	30	110	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.165163	2026-06-01 20:47:08.5409	\N
24	other_documents	{"en": "Other Documents", "es": "Otros documentos"}	\N	{"en": "Other Documents"}	case	t	11	141	0	f	documents	f	f	f	f	0	f	f	{}	t	\N	\N	f	f	f	\N	2026-04-22 19:33:47.821828	2026-06-01 20:47:08.081333	\N
1	approvals	{"en": "Approvals", "es": "Aprobaciones"}	\N	{"en": "Approvals"}	case	t	2	0	0	f	record_information	t	t	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.039176	2026-06-01 20:47:06.845286	\N
27	photos_and_audio	{"en": "Photos and Audio", "es": "Fotos y audio"}	\N	{"en": "All Photo and Audio Files Associated with a Child Record"}	case	t	10	140	0	f	photos_audio	f	f	f	f	0	f	f	{}	t	\N	\N	f	f	t	\N	2026-04-22 19:33:47.880093	2026-06-01 20:47:08.222722	\N
28	protection_concern_detail_subform_section	{"en": "Nested Protection Concerns Subform", "es": "Riesgos de protección"}	\N	{"en": "Nested Protection Concerns Subform"}	case	f	30	70	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.896397	2026-06-01 20:47:08.255477	\N
29	protection_concern_details	{"en": "Protection Concern Details", "es": "Detalles de riesgos de protección"}	\N	{"en": "Protection Concern Details"}	case	t	30	70	0	f	assessment	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.92209	2026-06-01 20:47:08.273184	\N
19	followup_subform_section	{"en": "Nested Followup Subform", "es": "Seguimiento"}	\N	{"en": "Nested Followup Subform"}	case	f	20	110	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.692287	2026-06-01 20:47:07.915284	\N
31	reopened_logs	{"en": "Case Reopened", "es": "Caso reabierto"}	\N	{"en": "Case Reopened Subform"}	case	f	10	150	1	f	\N	f	f	t	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.002915	2026-06-01 20:47:08.3558	\N
4	bid_documents	{"en": "BID Records", "es": "Registros BID"}	\N	{"en": "BID Records"}	case	f	9	121	0	f	documents	f	f	f	f	0	f	f	{}	t	\N	\N	f	f	f	\N	2026-04-22 19:33:47.205291	2026-06-01 20:47:07.291336	\N
38	services	{"en": "Services", "es": "Servicios"}	\N	{"en": "Services form"}	case	t	30	110	0	f	services_follow_up	f	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.205838	2026-06-01 20:47:08.568973	\N
39	tracing_actions_section	{"en": "Nested Tracing Action", "es": "Acciones de localización"}	\N	{"en": "Tracing Action Subform"}	case	f	20	130	2	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.224578	2026-06-01 20:47:08.589066	\N
20	followup	{"en": "Follow Up", "es": "Seguimiento"}	\N	{"en": "Follow Up"}	case	t	20	110	0	f	services_follow_up	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.722879	2026-06-01 20:47:07.937302	\N
26	other_reportable_fields_case	{"en": "Other Reportable Fields", "es": "Otros campos de reporte"}	\N	{"en": "Other Reportable Fields"}	case	f	1000	1000	0	f	other_reportable_fields	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.860163	2026-06-01 20:50:17.511496	\N
49	family_notes	{"en": "Family Notes"}	\N	{"en": "Family Notes"}	family	t	20	1001	0	f	family_notes	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.53543	2026-06-01 20:20:33.139599	\N
2	assessment	{"en": "Assessment", "es": "Evaluación"}	\N	{"en": "Assessment form"}	case	t	10	50	0	f	assessment	f	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.074273	2026-06-01 20:47:06.89383	\N
56	cp_other_reportable_fields	{"en": "Other Reportable Fields"}	\N	{"en": "Other Reportable Fields"}	incident	f	1000	1000	0	f	\N	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.730042	2026-06-01 20:20:33.618379	\N
40	tracing	{"en": "Tracing", "es": "Localización"}	\N	{"en": "Tracing"}	case	f	20	130	0	f	tracing	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.254331	2026-06-01 20:47:08.604619	\N
50	family_documents	{"en": "Documents"}	\N	{"en": "Documents"}	family	t	11	141	0	f	family_documents	f	f	f	f	0	f	f	{}	t	\N	\N	f	f	f	\N	2026-04-22 19:33:48.559406	2026-06-01 20:20:33.162671	\N
57	incident_record_owner	{"en": "Record Owner"}	\N	{"en": "Record Owner"}	incident	t	0	0	0	f	record_owner	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.752174	2026-06-01 20:20:33.73086	\N
43	family_closure_form	{"en": "Closure"}	\N	{"en": "Closure"}	family	t	21	110	0	f	family_closure	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.308178	2026-06-01 20:20:32.403276	\N
41	summary	{"en": "Summary", "es": "Resumen"}	\N	{"en": "Summary"}	case	t	1	130	0	f	tracing	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.275733	2026-06-01 20:47:08.661411	\N
42	transfers_assignments	{"en": "Transfer and Assignments", "es": "Transferencias y asignaciones"}	\N	{"en": "Transfer and Assignments"}	case	t	5	0	0	f	record_information	t	t	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.288885	2026-06-01 20:47:08.670265	\N
60	other_reportable_fields_tracing_request	{"en": "Other Reportable Fields", "es": "Otros campos de reporte"}	\N	{"en": "Other Reportable Fields"}	tracing_request	f	1000	1000	0	f	other_reportable_fields	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.864669	2026-06-02 19:58:13.946173	\N
61	tracing_request_photos_and_audio	{"en": "Photos and Audio", "es": "Fotos y audio"}	\N	\N	tracing_request	t	40	40	0	f	photos_audio	f	f	f	f	0	f	f	{}	t	\N	\N	f	f	t	\N	2026-04-22 19:33:48.880072	2026-06-02 19:58:13.960629	\N
62	tracing_request_record_owner	{"en": "Record Owner", "es": "Responsable del registro"}	\N	{"en": "Record Owner"}	tracing_request	t	0	0	0	f	record_owner	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.896352	2026-06-02 19:58:13.997884	\N
64	tracing_request_tracing_request	{"en": "Tracing Request", "es": "Solicitud de localización"}	\N	{"en": "Tracing Request"}	tracing_request	t	30	30	0	f	tracing_request	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.964406	2026-06-02 19:58:14.206858	\N
54	cp_individual_details	{"en": "CP Individual Details"}	\N	{"en": "CP Individual Details"}	incident	t	15	30	0	f	cp_individual_details	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.668501	2026-06-01 20:20:33.469979	\N
52	cp_incident_form	{"en": "CP Incident"}	\N	{"en": "CP Incident"}	incident	t	10	10	0	f	cp_incident	t	f	f	t	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.608931	2026-06-01 20:20:33.295997	\N
53	cp_incident_record_owner	{"en": "CP Record Owner"}	\N	{"en": "Record Owner"}	incident	t	0	0	0	f	record_owner	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.639074	2026-06-01 20:20:33.384278	\N
46	family_members	{"en": "Family Members"}	\N	{"en": "Family Members"}	family	t	20	30	0	f	family_members	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.440692	2026-06-01 20:20:32.923614	\N
58	registry_details	{"en": "Registry Details"}	\N	{"en": "Registry Details"}	registry_record	f	10	10	0	f	registry_details	t	f	f	t	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.78931	2026-06-01 20:20:33.859281	\N
51	other_reportable_fields_family	{"en": "Other Reportable Fields"}	\N	{"en": "Other Reportable Fields"}	family	f	1000	1000	0	f	other_reportable_fields	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.576082	2026-06-01 20:20:33.210824	\N
55	cp_offender_details	{"en": "Perpetrator Details"}	\N	{"en": "Perpetrator Details"}	incident	t	15	20	0	f	perpetrator_details	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.699609	2026-06-01 20:20:33.556274	\N
48	family_notes_section	{"en": "Nested Notes Subform"}	\N	{"en": "Nested Notes Subform"}	family	f	20	110	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.500657	2026-06-01 20:20:33.118231	\N
5	care_arrangements_section	{"en": "Nested Care Arrangements", "es": "Acuerdos de cuidado"}	\N	{"en": "Care Arrangements Subform"}	case	f	10	50	1	f	\N	t	f	t	f	1	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.246015	2026-06-01 20:47:07.303348	\N
6	care_arrangements	{"en": "Care Arrangements", "es": "Acuerdos de cuidado"}	\N	{"en": "Care Arrangements"}	case	t	10	110	0	f	services_follow_up	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.293087	2026-06-01 20:47:07.365064	\N
63	tracing_request_subform_section	{"en": "Nested Tracing Request Subform"}	\N	{"en": "Nested Tracing Request Subform"}	tracing_request	f	10	10	1	f	\N	t	f	t	f	0	f	f	{tracing}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.92426	2026-06-04 14:30:47.064243	\N
10	closure_form	{"en": "Closure", "es": "Cierre"}	\N	{"en": "Closure"}	case	t	21	110	0	f	closure	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.448753	2026-06-01 20:47:07.457986	\N
12	cp_case_plan	{"en": "Case Plan", "es": "Plan del caso"}	\N	{"en": "Case Plan"}	case	t	999	80	0	f	case_plan	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.512784	2026-06-01 20:47:07.536093	\N
13	consent	{"en": "Data Confidentiality", "es": "Confidencialidad de los datos"}	\N	{"en": "Data Confidentiality"}	case	t	10	40	0	f	data_confidentiality	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.545784	2026-06-01 20:47:07.629448	\N
14	family_details_section	{"en": "Nested Family Details", "es": "Detalles de la familia"}	\N	{"en": "Family Details Subform"}	case	f	10	50	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:47.579622	2026-06-01 20:47:07.733149	\N
25	other_identity_details	{"en": "Other Identity Details", "es": "Otros datos de identidad"}	\N	{"en": "Other Identity Details"}	case	t	30	30	0	f	identification_registration	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.835303	2026-06-01 20:47:08.110588	\N
30	protection_concern	{"en": "Protection Concerns", "es": "Riesgos de protección"}	\N	{"en": "Protection concerns"}	case	t	20	30	0	f	identification_registration	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.941535	2026-06-01 20:47:08.300122	\N
33	transitions	{"en": "Nested Transitions Subform", "es": "Transiciones"}	\N	{"en": "Transitions Subform"}	case	f	10	150	1	f	\N	f	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:48.079514	2026-06-01 20:47:08.454187	\N
11	cp_case_plan_subform_case_plan_interventions	{"en": "List of Interventions and Services", "es": "Lista de intervenciones y servicios"}	\N	{"en": "List of Interventions and Services"}	case	f	999	999	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.484113	2026-06-01 20:50:16.96634	\N
59	tracing_request_inquirer	{"en": "Inquirer", "es": "Solicitante"}	\N	{"en": "Inquirer"}	tracing_request	t	20	20	0	f	inquirer	t	f	f	t	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.824007	2026-06-02 19:58:13.792643	\N
47	family_overview	{"en": "Family Overview"}	\N	{"en": "Basic information about a family."}	family	t	10	30	0	f	family_overview	t	f	f	t	0	f	f	{}	f	\N	\N	f	f	t	workflow_status	2026-04-22 19:33:48.464538	2026-06-01 20:20:33.039332	\N
44	family_consent	{"en": "Family Consent"}	\N	{"en": "Family Consent"}	family	f	10	40	0	f	family_consent	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.328812	2026-06-01 20:20:32.529553	\N
45	family_members_section	{"en": "Nested Family Members"}	\N	{"en": "Family Members Subform"}	family	f	10	50	1	f	\N	t	f	t	f	1	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.376729	2026-06-01 20:20:32.84808	\N
3	basic_identity	{"en": "Basic Identity", "es": "Identidad básica"}	\N	{"en": "Basic identity information about a separated or unaccompanied child."}	case	t	10	30	0	f	identification_registration	t	f	f	t	0	f	f	{}	f	\N	\N	f	f	t	workflow_status	2026-04-22 19:33:47.134917	2026-06-01 20:47:06.976178	\N
21	incident_details_subform_section	{"en": "Nested Incident Details Subform", "es": "Detalles del incidente"}	\N	{"en": "Nested Incident Details Subform"}	case	f	20	110	1	f	\N	t	f	t	f	0	f	f	{}	f	\N	\N	f	f	f	\N	2026-04-22 19:33:47.741836	2026-06-01 20:47:07.965129	\N
32	record_owner	{"en": "Record Information", "es": "Información del registro"}	\N	{"en": "Record Information", "es": ""}	case	t	0	0	0	f	record_information	t	f	f	f	0	f	f	{}	f	\N	\N	f	f	t	\N	2026-04-22 19:33:48.032867	2026-06-05 14:11:28.560166	{"disabled": true}
\.


--
-- Data for Name: form_sections_primero_modules; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.form_sections_primero_modules (primero_module_id, form_section_id) FROM stdin;
1	1
1	2
1	3
1	4
1	6
1	7
1	9
1	10
1	12
1	13
1	15
1	18
1	20
1	22
1	23
1	24
1	25
1	26
1	27
1	29
1	30
1	32
1	34
1	35
1	36
1	38
1	40
1	41
1	43
1	44
1	46
1	47
1	49
1	50
1	51
1	52
1	53
1	54
1	55
1	56
1	58
1	59
1	60
1	61
1	62
1	64
1	5
1	8
1	11
1	14
1	17
1	19
1	21
1	28
1	31
1	33
1	37
1	45
1	48
1	63
\.


--
-- Data for Name: form_sections_roles; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.form_sections_roles (id, role_id, form_section_id, permission, created_at, updated_at) FROM stdin;
1	1	1	rw	2026-04-22 19:33:49.47268	2026-04-22 19:33:49.47268
2	1	2	rw	2026-04-22 19:33:49.474943	2026-04-22 19:33:49.474943
3	1	3	rw	2026-04-22 19:33:49.476475	2026-04-22 19:33:49.476475
4	1	4	rw	2026-04-22 19:33:49.477752	2026-04-22 19:33:49.477752
5	1	5	rw	2026-04-22 19:33:49.478867	2026-04-22 19:33:49.478867
6	1	6	rw	2026-04-22 19:33:49.479888	2026-04-22 19:33:49.479888
7	1	7	rw	2026-04-22 19:33:49.480967	2026-04-22 19:33:49.480967
8	1	8	rw	2026-04-22 19:33:49.482267	2026-04-22 19:33:49.482267
9	1	9	rw	2026-04-22 19:33:49.486053	2026-04-22 19:33:49.486053
10	1	10	rw	2026-04-22 19:33:49.48795	2026-04-22 19:33:49.48795
11	1	11	rw	2026-04-22 19:33:49.489409	2026-04-22 19:33:49.489409
12	1	12	rw	2026-04-22 19:33:49.490648	2026-04-22 19:33:49.490648
13	1	13	rw	2026-04-22 19:33:49.491728	2026-04-22 19:33:49.491728
14	1	14	rw	2026-04-22 19:33:49.492835	2026-04-22 19:33:49.492835
15	1	15	rw	2026-04-22 19:33:49.493883	2026-04-22 19:33:49.493883
16	1	16	rw	2026-04-22 19:33:49.495093	2026-04-22 19:33:49.495093
17	1	17	rw	2026-04-22 19:33:49.496503	2026-04-22 19:33:49.496503
18	1	18	rw	2026-04-22 19:33:49.497665	2026-04-22 19:33:49.497665
19	1	19	rw	2026-04-22 19:33:49.498727	2026-04-22 19:33:49.498727
20	1	20	rw	2026-04-22 19:33:49.501816	2026-04-22 19:33:49.501816
21	1	21	rw	2026-04-22 19:33:49.504123	2026-04-22 19:33:49.504123
22	1	22	rw	2026-04-22 19:33:49.505621	2026-04-22 19:33:49.505621
23	1	23	rw	2026-04-22 19:33:49.506823	2026-04-22 19:33:49.506823
24	1	24	rw	2026-04-22 19:33:49.507982	2026-04-22 19:33:49.507982
25	1	25	rw	2026-04-22 19:33:49.509228	2026-04-22 19:33:49.509228
26	1	26	rw	2026-04-22 19:33:49.5106	2026-04-22 19:33:49.5106
27	1	27	rw	2026-04-22 19:33:49.512045	2026-04-22 19:33:49.512045
28	1	28	rw	2026-04-22 19:33:49.513271	2026-04-22 19:33:49.513271
29	1	29	rw	2026-04-22 19:33:49.514406	2026-04-22 19:33:49.514406
30	1	30	rw	2026-04-22 19:33:49.515708	2026-04-22 19:33:49.515708
31	1	31	rw	2026-04-22 19:33:49.519322	2026-04-22 19:33:49.519322
32	1	32	rw	2026-04-22 19:33:49.521677	2026-04-22 19:33:49.521677
33	1	33	rw	2026-04-22 19:33:49.523933	2026-04-22 19:33:49.523933
34	1	34	rw	2026-04-22 19:33:49.526586	2026-04-22 19:33:49.526586
35	1	35	rw	2026-04-22 19:33:49.529917	2026-04-22 19:33:49.529917
36	1	36	rw	2026-04-22 19:33:49.5351	2026-04-22 19:33:49.5351
37	1	37	rw	2026-04-22 19:33:49.548518	2026-04-22 19:33:49.548518
38	1	38	rw	2026-04-22 19:33:49.572503	2026-04-22 19:33:49.572503
39	1	39	rw	2026-04-22 19:33:49.574936	2026-04-22 19:33:49.574936
40	1	40	rw	2026-04-22 19:33:49.577136	2026-04-22 19:33:49.577136
41	1	41	rw	2026-04-22 19:33:49.579244	2026-04-22 19:33:49.579244
42	1	42	rw	2026-04-22 19:33:49.581177	2026-04-22 19:33:49.581177
43	1	52	rw	2026-04-22 19:33:49.693741	2026-04-22 19:33:49.693741
44	1	53	rw	2026-04-22 19:33:49.695944	2026-04-22 19:33:49.695944
45	1	54	rw	2026-04-22 19:33:49.697381	2026-04-22 19:33:49.697381
46	1	55	rw	2026-04-22 19:33:49.70768	2026-04-22 19:33:49.70768
47	1	56	rw	2026-04-22 19:33:49.710797	2026-04-22 19:33:49.710797
48	1	57	rw	2026-04-22 19:33:49.724565	2026-04-22 19:33:49.724565
49	2	1	rw	2026-04-22 19:33:49.981038	2026-04-22 19:33:49.981038
50	2	2	rw	2026-04-22 19:33:49.984427	2026-04-22 19:33:49.984427
51	2	3	rw	2026-04-22 19:33:49.988904	2026-04-22 19:33:49.988904
52	2	4	rw	2026-04-22 19:33:49.990826	2026-04-22 19:33:49.990826
53	2	5	rw	2026-04-22 19:33:49.992326	2026-04-22 19:33:49.992326
54	2	6	rw	2026-04-22 19:33:49.993534	2026-04-22 19:33:49.993534
55	2	7	rw	2026-04-22 19:33:49.994749	2026-04-22 19:33:49.994749
56	2	8	rw	2026-04-22 19:33:49.997232	2026-04-22 19:33:49.997232
57	2	9	rw	2026-04-22 19:33:49.999571	2026-04-22 19:33:49.999571
58	2	10	rw	2026-04-22 19:33:50.005527	2026-04-22 19:33:50.005527
59	2	11	rw	2026-04-22 19:33:50.008336	2026-04-22 19:33:50.008336
60	2	12	rw	2026-04-22 19:33:50.010866	2026-04-22 19:33:50.010866
61	2	13	rw	2026-04-22 19:33:50.013777	2026-04-22 19:33:50.013777
62	2	14	rw	2026-04-22 19:33:50.021897	2026-04-22 19:33:50.021897
63	2	15	rw	2026-04-22 19:33:50.024728	2026-04-22 19:33:50.024728
64	2	16	rw	2026-04-22 19:33:50.026623	2026-04-22 19:33:50.026623
65	2	17	rw	2026-04-22 19:33:50.028082	2026-04-22 19:33:50.028082
66	2	18	rw	2026-04-22 19:33:50.029449	2026-04-22 19:33:50.029449
67	2	19	rw	2026-04-22 19:33:50.030644	2026-04-22 19:33:50.030644
68	2	20	rw	2026-04-22 19:33:50.03203	2026-04-22 19:33:50.03203
69	2	21	rw	2026-04-22 19:33:50.039651	2026-04-22 19:33:50.039651
70	2	22	rw	2026-04-22 19:33:50.041874	2026-04-22 19:33:50.041874
71	2	23	rw	2026-04-22 19:33:50.043625	2026-04-22 19:33:50.043625
72	2	24	rw	2026-04-22 19:33:50.045198	2026-04-22 19:33:50.045198
73	2	25	rw	2026-04-22 19:33:50.046815	2026-04-22 19:33:50.046815
74	2	26	rw	2026-04-22 19:33:50.048566	2026-04-22 19:33:50.048566
75	2	27	rw	2026-04-22 19:33:50.050662	2026-04-22 19:33:50.050662
76	2	28	rw	2026-04-22 19:33:50.057356	2026-04-22 19:33:50.057356
77	2	29	rw	2026-04-22 19:33:50.05923	2026-04-22 19:33:50.05923
78	2	30	rw	2026-04-22 19:33:50.060995	2026-04-22 19:33:50.060995
79	2	31	rw	2026-04-22 19:33:50.062706	2026-04-22 19:33:50.062706
80	2	32	rw	2026-04-22 19:33:50.064362	2026-04-22 19:33:50.064362
81	2	33	rw	2026-04-22 19:33:50.066131	2026-04-22 19:33:50.066131
82	2	34	rw	2026-04-22 19:33:50.068557	2026-04-22 19:33:50.068557
83	2	35	rw	2026-04-22 19:33:50.074105	2026-04-22 19:33:50.074105
84	2	36	rw	2026-04-22 19:33:50.075965	2026-04-22 19:33:50.075965
85	2	37	rw	2026-04-22 19:33:50.077505	2026-04-22 19:33:50.077505
86	2	38	rw	2026-04-22 19:33:50.078737	2026-04-22 19:33:50.078737
87	2	39	rw	2026-04-22 19:33:50.080055	2026-04-22 19:33:50.080055
88	2	40	rw	2026-04-22 19:33:50.081409	2026-04-22 19:33:50.081409
89	2	41	rw	2026-04-22 19:33:50.08267	2026-04-22 19:33:50.08267
90	2	42	rw	2026-04-22 19:33:50.085128	2026-04-22 19:33:50.085128
91	2	43	rw	2026-04-22 19:33:50.142528	2026-04-22 19:33:50.142528
92	2	44	rw	2026-04-22 19:33:50.14416	2026-04-22 19:33:50.14416
93	2	45	rw	2026-04-22 19:33:50.145263	2026-04-22 19:33:50.145263
94	2	46	rw	2026-04-22 19:33:50.146592	2026-04-22 19:33:50.146592
95	2	47	rw	2026-04-22 19:33:50.147822	2026-04-22 19:33:50.147822
96	2	48	rw	2026-04-22 19:33:50.148922	2026-04-22 19:33:50.148922
97	2	49	rw	2026-04-22 19:33:50.150249	2026-04-22 19:33:50.150249
98	2	50	rw	2026-04-22 19:33:50.152981	2026-04-22 19:33:50.152981
99	2	51	rw	2026-04-22 19:33:50.155601	2026-04-22 19:33:50.155601
100	2	52	rw	2026-04-22 19:33:50.207725	2026-04-22 19:33:50.207725
101	2	53	rw	2026-04-22 19:33:50.210578	2026-04-22 19:33:50.210578
102	2	54	rw	2026-04-22 19:33:50.212337	2026-04-22 19:33:50.212337
103	2	55	rw	2026-04-22 19:33:50.213802	2026-04-22 19:33:50.213802
104	2	56	rw	2026-04-22 19:33:50.215082	2026-04-22 19:33:50.215082
105	2	57	rw	2026-04-22 19:33:50.216259	2026-04-22 19:33:50.216259
106	3	1	rw	2026-04-22 19:33:50.323967	2026-04-22 19:33:50.323967
107	3	2	rw	2026-04-22 19:33:50.325899	2026-04-22 19:33:50.325899
108	3	3	rw	2026-04-22 19:33:50.327529	2026-04-22 19:33:50.327529
109	3	4	rw	2026-04-22 19:33:50.329144	2026-04-22 19:33:50.329144
110	3	5	rw	2026-04-22 19:33:50.330463	2026-04-22 19:33:50.330463
111	3	6	rw	2026-04-22 19:33:50.332119	2026-04-22 19:33:50.332119
112	3	7	rw	2026-04-22 19:33:50.33376	2026-04-22 19:33:50.33376
113	3	8	rw	2026-04-22 19:33:50.337909	2026-04-22 19:33:50.337909
114	3	9	rw	2026-04-22 19:33:50.339791	2026-04-22 19:33:50.339791
115	3	10	rw	2026-04-22 19:33:50.341304	2026-04-22 19:33:50.341304
116	3	11	rw	2026-04-22 19:33:50.342641	2026-04-22 19:33:50.342641
117	3	12	rw	2026-04-22 19:33:50.344076	2026-04-22 19:33:50.344076
118	3	13	rw	2026-04-22 19:33:50.345603	2026-04-22 19:33:50.345603
119	3	14	rw	2026-04-22 19:33:50.346879	2026-04-22 19:33:50.346879
120	3	15	rw	2026-04-22 19:33:50.348119	2026-04-22 19:33:50.348119
121	3	16	rw	2026-04-22 19:33:50.349632	2026-04-22 19:33:50.349632
122	3	17	rw	2026-04-22 19:33:50.354875	2026-04-22 19:33:50.354875
123	3	18	rw	2026-04-22 19:33:50.356976	2026-04-22 19:33:50.356976
124	3	19	rw	2026-04-22 19:33:50.358489	2026-04-22 19:33:50.358489
125	3	20	rw	2026-04-22 19:33:50.359766	2026-04-22 19:33:50.359766
126	3	21	rw	2026-04-22 19:33:50.361097	2026-04-22 19:33:50.361097
127	3	22	rw	2026-04-22 19:33:50.362461	2026-04-22 19:33:50.362461
128	3	23	rw	2026-04-22 19:33:50.363822	2026-04-22 19:33:50.363822
129	3	24	rw	2026-04-22 19:33:50.36512	2026-04-22 19:33:50.36512
130	3	25	rw	2026-04-22 19:33:50.366289	2026-04-22 19:33:50.366289
131	3	26	rw	2026-04-22 19:33:50.367745	2026-04-22 19:33:50.367745
132	3	27	rw	2026-04-22 19:33:50.37213	2026-04-22 19:33:50.37213
133	3	28	rw	2026-04-22 19:33:50.373949	2026-04-22 19:33:50.373949
134	3	29	rw	2026-04-22 19:33:50.375275	2026-04-22 19:33:50.375275
135	3	30	rw	2026-04-22 19:33:50.376419	2026-04-22 19:33:50.376419
136	3	31	rw	2026-04-22 19:33:50.378042	2026-04-22 19:33:50.378042
137	3	32	rw	2026-04-22 19:33:50.379346	2026-04-22 19:33:50.379346
138	3	33	rw	2026-04-22 19:33:50.380487	2026-04-22 19:33:50.380487
139	3	34	rw	2026-04-22 19:33:50.381612	2026-04-22 19:33:50.381612
140	3	35	rw	2026-04-22 19:33:50.383246	2026-04-22 19:33:50.383246
141	3	36	rw	2026-04-22 19:33:50.387686	2026-04-22 19:33:50.387686
142	3	37	rw	2026-04-22 19:33:50.389989	2026-04-22 19:33:50.389989
143	3	38	rw	2026-04-22 19:33:50.39187	2026-04-22 19:33:50.39187
144	3	39	rw	2026-04-22 19:33:50.394314	2026-04-22 19:33:50.394314
145	3	40	rw	2026-04-22 19:33:50.396041	2026-04-22 19:33:50.396041
146	3	41	rw	2026-04-22 19:33:50.397417	2026-04-22 19:33:50.397417
147	3	42	rw	2026-04-22 19:33:50.398679	2026-04-22 19:33:50.398679
148	3	52	rw	2026-04-22 19:33:50.449449	2026-04-22 19:33:50.449449
149	3	53	rw	2026-04-22 19:33:50.451897	2026-04-22 19:33:50.451897
150	3	54	rw	2026-04-22 19:33:50.455276	2026-04-22 19:33:50.455276
151	3	55	rw	2026-04-22 19:33:50.456881	2026-04-22 19:33:50.456881
152	3	56	rw	2026-04-22 19:33:50.458076	2026-04-22 19:33:50.458076
153	3	57	rw	2026-04-22 19:33:50.459295	2026-04-22 19:33:50.459295
154	4	1	rw	2026-04-22 19:33:50.559237	2026-04-22 19:33:50.559237
155	4	2	rw	2026-04-22 19:33:50.560906	2026-04-22 19:33:50.560906
156	4	3	rw	2026-04-22 19:33:50.562274	2026-04-22 19:33:50.562274
157	4	4	rw	2026-04-22 19:33:50.56359	2026-04-22 19:33:50.56359
158	4	5	rw	2026-04-22 19:33:50.564758	2026-04-22 19:33:50.564758
159	4	6	rw	2026-04-22 19:33:50.565768	2026-04-22 19:33:50.565768
160	4	7	rw	2026-04-22 19:33:50.567124	2026-04-22 19:33:50.567124
161	4	8	rw	2026-04-22 19:33:50.570813	2026-04-22 19:33:50.570813
162	4	9	rw	2026-04-22 19:33:50.572614	2026-04-22 19:33:50.572614
163	4	10	rw	2026-04-22 19:33:50.573892	2026-04-22 19:33:50.573892
164	4	11	rw	2026-04-22 19:33:50.575006	2026-04-22 19:33:50.575006
165	4	12	rw	2026-04-22 19:33:50.575999	2026-04-22 19:33:50.575999
166	4	13	rw	2026-04-22 19:33:50.577103	2026-04-22 19:33:50.577103
167	4	14	rw	2026-04-22 19:33:50.578387	2026-04-22 19:33:50.578387
168	4	15	rw	2026-04-22 19:33:50.579563	2026-04-22 19:33:50.579563
169	4	16	rw	2026-04-22 19:33:50.580573	2026-04-22 19:33:50.580573
170	4	17	rw	2026-04-22 19:33:50.581723	2026-04-22 19:33:50.581723
171	4	18	rw	2026-04-22 19:33:50.582744	2026-04-22 19:33:50.582744
172	4	19	rw	2026-04-22 19:33:50.584341	2026-04-22 19:33:50.584341
173	4	20	rw	2026-04-22 19:33:50.588654	2026-04-22 19:33:50.588654
174	4	21	rw	2026-04-22 19:33:50.590244	2026-04-22 19:33:50.590244
175	4	22	rw	2026-04-22 19:33:50.591601	2026-04-22 19:33:50.591601
176	4	23	rw	2026-04-22 19:33:50.592757	2026-04-22 19:33:50.592757
177	4	24	rw	2026-04-22 19:33:50.593981	2026-04-22 19:33:50.593981
178	4	25	rw	2026-04-22 19:33:50.595811	2026-04-22 19:33:50.595811
179	4	26	rw	2026-04-22 19:33:50.597238	2026-04-22 19:33:50.597238
180	4	27	rw	2026-04-22 19:33:50.598615	2026-04-22 19:33:50.598615
181	4	28	rw	2026-04-22 19:33:50.600647	2026-04-22 19:33:50.600647
182	4	29	rw	2026-04-22 19:33:50.604711	2026-04-22 19:33:50.604711
183	4	30	rw	2026-04-22 19:33:50.606324	2026-04-22 19:33:50.606324
184	4	31	rw	2026-04-22 19:33:50.608057	2026-04-22 19:33:50.608057
185	4	32	rw	2026-04-22 19:33:50.609551	2026-04-22 19:33:50.609551
186	4	33	rw	2026-04-22 19:33:50.611428	2026-04-22 19:33:50.611428
187	4	34	rw	2026-04-22 19:33:50.613235	2026-04-22 19:33:50.613235
188	4	35	rw	2026-04-22 19:33:50.615391	2026-04-22 19:33:50.615391
189	4	36	rw	2026-04-22 19:33:50.617695	2026-04-22 19:33:50.617695
190	4	37	rw	2026-04-22 19:33:50.621986	2026-04-22 19:33:50.621986
191	4	38	rw	2026-04-22 19:33:50.623697	2026-04-22 19:33:50.623697
192	4	39	rw	2026-04-22 19:33:50.62742	2026-04-22 19:33:50.62742
193	4	40	rw	2026-04-22 19:33:50.629515	2026-04-22 19:33:50.629515
194	4	41	rw	2026-04-22 19:33:50.631167	2026-04-22 19:33:50.631167
195	4	42	rw	2026-04-22 19:33:50.632837	2026-04-22 19:33:50.632837
196	4	52	rw	2026-04-22 19:33:50.695136	2026-04-22 19:33:50.695136
197	4	53	rw	2026-04-22 19:33:50.697078	2026-04-22 19:33:50.697078
198	4	54	rw	2026-04-22 19:33:50.698268	2026-04-22 19:33:50.698268
199	4	55	rw	2026-04-22 19:33:50.699448	2026-04-22 19:33:50.699448
200	4	56	rw	2026-04-22 19:33:50.701155	2026-04-22 19:33:50.701155
201	4	57	rw	2026-04-22 19:33:50.704905	2026-04-22 19:33:50.704905
202	4	43	rw	2026-04-22 19:33:50.761527	2026-04-22 19:33:50.761527
203	4	44	rw	2026-04-22 19:33:50.76319	2026-04-22 19:33:50.76319
204	4	45	rw	2026-04-22 19:33:50.764612	2026-04-22 19:33:50.764612
205	4	46	rw	2026-04-22 19:33:50.765746	2026-04-22 19:33:50.765746
206	4	47	rw	2026-04-22 19:33:50.767203	2026-04-22 19:33:50.767203
207	4	48	rw	2026-04-22 19:33:50.77086	2026-04-22 19:33:50.77086
208	4	49	rw	2026-04-22 19:33:50.77269	2026-04-22 19:33:50.77269
209	4	50	rw	2026-04-22 19:33:50.774155	2026-04-22 19:33:50.774155
210	4	51	rw	2026-04-22 19:33:50.775258	2026-04-22 19:33:50.775258
211	5	1	rw	2026-04-22 19:33:50.889954	2026-04-22 19:33:50.889954
212	5	2	rw	2026-04-22 19:33:50.891757	2026-04-22 19:33:50.891757
213	5	3	rw	2026-04-22 19:33:50.893029	2026-04-22 19:33:50.893029
214	5	4	rw	2026-04-22 19:33:50.894355	2026-04-22 19:33:50.894355
215	5	5	rw	2026-04-22 19:33:50.895643	2026-04-22 19:33:50.895643
216	5	6	rw	2026-04-22 19:33:50.896758	2026-04-22 19:33:50.896758
217	5	7	rw	2026-04-22 19:33:50.897903	2026-04-22 19:33:50.897903
218	5	8	rw	2026-04-22 19:33:50.898996	2026-04-22 19:33:50.898996
219	5	9	rw	2026-04-22 19:33:50.900308	2026-04-22 19:33:50.900308
220	5	10	rw	2026-04-22 19:33:50.902306	2026-04-22 19:33:50.902306
221	5	11	rw	2026-04-22 19:33:50.905886	2026-04-22 19:33:50.905886
222	5	12	rw	2026-04-22 19:33:50.907861	2026-04-22 19:33:50.907861
223	5	13	rw	2026-04-22 19:33:50.909292	2026-04-22 19:33:50.909292
224	5	14	rw	2026-04-22 19:33:50.910484	2026-04-22 19:33:50.910484
225	5	15	rw	2026-04-22 19:33:50.911632	2026-04-22 19:33:50.911632
226	5	16	rw	2026-04-22 19:33:50.912683	2026-04-22 19:33:50.912683
227	5	17	rw	2026-04-22 19:33:50.914052	2026-04-22 19:33:50.914052
228	5	18	rw	2026-04-22 19:33:50.915279	2026-04-22 19:33:50.915279
229	5	19	rw	2026-04-22 19:33:50.916567	2026-04-22 19:33:50.916567
230	5	20	rw	2026-04-22 19:33:50.918312	2026-04-22 19:33:50.918312
231	5	21	rw	2026-04-22 19:33:50.922147	2026-04-22 19:33:50.922147
232	5	22	rw	2026-04-22 19:33:50.923774	2026-04-22 19:33:50.923774
233	5	23	rw	2026-04-22 19:33:50.925117	2026-04-22 19:33:50.925117
234	5	24	rw	2026-04-22 19:33:50.926355	2026-04-22 19:33:50.926355
235	5	25	rw	2026-04-22 19:33:50.927865	2026-04-22 19:33:50.927865
236	5	26	rw	2026-04-22 19:33:50.929224	2026-04-22 19:33:50.929224
237	5	27	rw	2026-04-22 19:33:50.930475	2026-04-22 19:33:50.930475
238	5	28	rw	2026-04-22 19:33:50.931673	2026-04-22 19:33:50.931673
239	5	29	rw	2026-04-22 19:33:50.932932	2026-04-22 19:33:50.932932
240	5	30	rw	2026-04-22 19:33:50.934629	2026-04-22 19:33:50.934629
241	5	31	rw	2026-04-22 19:33:50.938106	2026-04-22 19:33:50.938106
242	5	32	rw	2026-04-22 19:33:50.939802	2026-04-22 19:33:50.939802
243	5	33	rw	2026-04-22 19:33:50.941299	2026-04-22 19:33:50.941299
244	5	34	rw	2026-04-22 19:33:50.942724	2026-04-22 19:33:50.942724
245	5	35	rw	2026-04-22 19:33:50.94388	2026-04-22 19:33:50.94388
246	5	36	rw	2026-04-22 19:33:50.94503	2026-04-22 19:33:50.94503
247	5	37	rw	2026-04-22 19:33:50.946325	2026-04-22 19:33:50.946325
248	5	38	rw	2026-04-22 19:33:50.947744	2026-04-22 19:33:50.947744
249	5	39	rw	2026-04-22 19:33:50.949159	2026-04-22 19:33:50.949159
250	5	40	rw	2026-04-22 19:33:50.951344	2026-04-22 19:33:50.951344
251	5	41	rw	2026-04-22 19:33:50.955084	2026-04-22 19:33:50.955084
252	5	42	rw	2026-04-22 19:33:50.956839	2026-04-22 19:33:50.956839
253	6	1	rw	2026-04-22 19:33:51.111697	2026-04-22 19:33:51.111697
254	6	2	rw	2026-04-22 19:33:51.113587	2026-04-22 19:33:51.113587
255	6	3	rw	2026-04-22 19:33:51.114872	2026-04-22 19:33:51.114872
256	6	4	rw	2026-04-22 19:33:51.116253	2026-04-22 19:33:51.116253
257	6	5	rw	2026-04-22 19:33:51.118449	2026-04-22 19:33:51.118449
258	6	6	rw	2026-04-22 19:33:51.121717	2026-04-22 19:33:51.121717
259	6	7	rw	2026-04-22 19:33:51.123137	2026-04-22 19:33:51.123137
260	6	8	rw	2026-04-22 19:33:51.124494	2026-04-22 19:33:51.124494
261	6	9	rw	2026-04-22 19:33:51.125622	2026-04-22 19:33:51.125622
262	6	10	rw	2026-04-22 19:33:51.126948	2026-04-22 19:33:51.126948
263	6	11	rw	2026-04-22 19:33:51.128314	2026-04-22 19:33:51.128314
264	6	12	rw	2026-04-22 19:33:51.129395	2026-04-22 19:33:51.129395
265	6	13	rw	2026-04-22 19:33:51.130874	2026-04-22 19:33:51.130874
266	6	14	rw	2026-04-22 19:33:51.131984	2026-04-22 19:33:51.131984
267	6	15	rw	2026-04-22 19:33:51.133225	2026-04-22 19:33:51.133225
268	6	16	rw	2026-04-22 19:33:51.1352	2026-04-22 19:33:51.1352
269	6	17	rw	2026-04-22 19:33:51.138418	2026-04-22 19:33:51.138418
270	6	18	rw	2026-04-22 19:33:51.139893	2026-04-22 19:33:51.139893
271	6	19	rw	2026-04-22 19:33:51.141226	2026-04-22 19:33:51.141226
272	6	20	rw	2026-04-22 19:33:51.142343	2026-04-22 19:33:51.142343
273	6	21	rw	2026-04-22 19:33:51.143473	2026-04-22 19:33:51.143473
274	6	22	rw	2026-04-22 19:33:51.144733	2026-04-22 19:33:51.144733
275	6	23	rw	2026-04-22 19:33:51.14636	2026-04-22 19:33:51.14636
276	6	24	rw	2026-04-22 19:33:51.147839	2026-04-22 19:33:51.147839
277	6	25	rw	2026-04-22 19:33:51.149581	2026-04-22 19:33:51.149581
278	6	26	rw	2026-04-22 19:33:51.151919	2026-04-22 19:33:51.151919
279	6	27	rw	2026-04-22 19:33:51.155584	2026-04-22 19:33:51.155584
280	6	28	rw	2026-04-22 19:33:51.157118	2026-04-22 19:33:51.157118
281	6	29	rw	2026-04-22 19:33:51.158371	2026-04-22 19:33:51.158371
282	6	30	rw	2026-04-22 19:33:51.159662	2026-04-22 19:33:51.159662
283	6	31	rw	2026-04-22 19:33:51.160916	2026-04-22 19:33:51.160916
284	6	32	rw	2026-04-22 19:33:51.162343	2026-04-22 19:33:51.162343
285	6	33	rw	2026-04-22 19:33:51.16375	2026-04-22 19:33:51.16375
286	6	34	rw	2026-04-22 19:33:51.165347	2026-04-22 19:33:51.165347
287	6	35	rw	2026-04-22 19:33:51.166785	2026-04-22 19:33:51.166785
288	6	36	rw	2026-04-22 19:33:51.170703	2026-04-22 19:33:51.170703
289	6	37	rw	2026-04-22 19:33:51.172501	2026-04-22 19:33:51.172501
290	6	38	rw	2026-04-22 19:33:51.173895	2026-04-22 19:33:51.173895
291	6	39	rw	2026-04-22 19:33:51.175146	2026-04-22 19:33:51.175146
292	6	40	rw	2026-04-22 19:33:51.176245	2026-04-22 19:33:51.176245
293	6	41	rw	2026-04-22 19:33:51.17734	2026-04-22 19:33:51.17734
294	6	42	rw	2026-04-22 19:33:51.178861	2026-04-22 19:33:51.178861
295	6	43	rw	2026-04-22 19:33:51.229861	2026-04-22 19:33:51.229861
296	6	44	rw	2026-04-22 19:33:51.231657	2026-04-22 19:33:51.231657
297	6	45	rw	2026-04-22 19:33:51.233151	2026-04-22 19:33:51.233151
298	6	46	rw	2026-04-22 19:33:51.235274	2026-04-22 19:33:51.235274
299	6	47	rw	2026-04-22 19:33:51.23833	2026-04-22 19:33:51.23833
300	6	48	rw	2026-04-22 19:33:51.239629	2026-04-22 19:33:51.239629
301	6	49	rw	2026-04-22 19:33:51.241043	2026-04-22 19:33:51.241043
302	6	50	rw	2026-04-22 19:33:51.242295	2026-04-22 19:33:51.242295
303	6	51	rw	2026-04-22 19:33:51.243477	2026-04-22 19:33:51.243477
304	7	1	rw	2026-04-22 19:33:51.345528	2026-04-22 19:33:51.345528
305	7	2	rw	2026-04-22 19:33:51.34728	2026-04-22 19:33:51.34728
306	7	3	rw	2026-04-22 19:33:51.348513	2026-04-22 19:33:51.348513
307	7	4	rw	2026-04-22 19:33:51.349646	2026-04-22 19:33:51.349646
308	7	5	rw	2026-04-22 19:33:51.351138	2026-04-22 19:33:51.351138
309	7	6	rw	2026-04-22 19:33:51.354485	2026-04-22 19:33:51.354485
310	7	7	rw	2026-04-22 19:33:51.356021	2026-04-22 19:33:51.356021
311	7	8	rw	2026-04-22 19:33:51.357329	2026-04-22 19:33:51.357329
312	7	9	rw	2026-04-22 19:33:51.35856	2026-04-22 19:33:51.35856
313	7	10	rw	2026-04-22 19:33:51.359968	2026-04-22 19:33:51.359968
314	7	11	rw	2026-04-22 19:33:51.36122	2026-04-22 19:33:51.36122
315	7	12	rw	2026-04-22 19:33:51.362361	2026-04-22 19:33:51.362361
316	7	13	rw	2026-04-22 19:33:51.363326	2026-04-22 19:33:51.363326
317	7	14	rw	2026-04-22 19:33:51.364315	2026-04-22 19:33:51.364315
318	7	15	rw	2026-04-22 19:33:51.36553	2026-04-22 19:33:51.36553
319	7	16	rw	2026-04-22 19:33:51.366998	2026-04-22 19:33:51.366998
320	7	17	rw	2026-04-22 19:33:51.370356	2026-04-22 19:33:51.370356
321	7	18	rw	2026-04-22 19:33:51.372186	2026-04-22 19:33:51.372186
322	7	19	rw	2026-04-22 19:33:51.373601	2026-04-22 19:33:51.373601
323	7	20	rw	2026-04-22 19:33:51.374826	2026-04-22 19:33:51.374826
324	7	21	rw	2026-04-22 19:33:51.375957	2026-04-22 19:33:51.375957
325	7	22	rw	2026-04-22 19:33:51.377254	2026-04-22 19:33:51.377254
326	7	23	rw	2026-04-22 19:33:51.37865	2026-04-22 19:33:51.37865
327	7	24	rw	2026-04-22 19:33:51.379938	2026-04-22 19:33:51.379938
328	7	25	rw	2026-04-22 19:33:51.381296	2026-04-22 19:33:51.381296
329	7	26	rw	2026-04-22 19:33:51.382471	2026-04-22 19:33:51.382471
330	7	27	rw	2026-04-22 19:33:51.383821	2026-04-22 19:33:51.383821
331	7	28	rw	2026-04-22 19:33:51.387738	2026-04-22 19:33:51.387738
332	7	29	rw	2026-04-22 19:33:51.389225	2026-04-22 19:33:51.389225
333	7	30	rw	2026-04-22 19:33:51.390497	2026-04-22 19:33:51.390497
334	7	31	rw	2026-04-22 19:33:51.391762	2026-04-22 19:33:51.391762
335	7	32	rw	2026-04-22 19:33:51.392919	2026-04-22 19:33:51.392919
336	7	33	rw	2026-04-22 19:33:51.39423	2026-04-22 19:33:51.39423
337	7	34	rw	2026-04-22 19:33:51.395303	2026-04-22 19:33:51.395303
338	7	35	rw	2026-04-22 19:33:51.396309	2026-04-22 19:33:51.396309
339	7	36	rw	2026-04-22 19:33:51.397293	2026-04-22 19:33:51.397293
340	7	37	rw	2026-04-22 19:33:51.398288	2026-04-22 19:33:51.398288
341	7	38	rw	2026-04-22 19:33:51.399298	2026-04-22 19:33:51.399298
342	7	39	rw	2026-04-22 19:33:51.400954	2026-04-22 19:33:51.400954
343	7	40	rw	2026-04-22 19:33:51.404537	2026-04-22 19:33:51.404537
344	7	41	rw	2026-04-22 19:33:51.40606	2026-04-22 19:33:51.40606
345	7	42	rw	2026-04-22 19:33:51.407457	2026-04-22 19:33:51.407457
346	9	3	rw	2026-04-22 19:33:51.475977	2026-04-22 19:33:51.475977
347	10	1	rw	2026-04-22 19:33:51.546098	2026-04-22 19:33:51.546098
348	10	2	rw	2026-04-22 19:33:51.547814	2026-04-22 19:33:51.547814
349	10	3	rw	2026-04-22 19:33:51.54971	2026-04-22 19:33:51.54971
350	10	4	rw	2026-04-22 19:33:51.55169	2026-04-22 19:33:51.55169
351	10	5	rw	2026-04-22 19:33:51.554944	2026-04-22 19:33:51.554944
352	10	6	rw	2026-04-22 19:33:51.556322	2026-04-22 19:33:51.556322
353	10	7	rw	2026-04-22 19:33:51.55767	2026-04-22 19:33:51.55767
354	10	8	rw	2026-04-22 19:33:51.558898	2026-04-22 19:33:51.558898
355	10	9	rw	2026-04-22 19:33:51.560597	2026-04-22 19:33:51.560597
356	10	10	rw	2026-04-22 19:33:51.562028	2026-04-22 19:33:51.562028
357	10	11	rw	2026-04-22 19:33:51.563392	2026-04-22 19:33:51.563392
358	10	12	rw	2026-04-22 19:33:51.564777	2026-04-22 19:33:51.564777
359	10	13	rw	2026-04-22 19:33:51.566179	2026-04-22 19:33:51.566179
360	10	14	rw	2026-04-22 19:33:51.567641	2026-04-22 19:33:51.567641
361	10	15	rw	2026-04-22 19:33:51.571681	2026-04-22 19:33:51.571681
362	10	16	rw	2026-04-22 19:33:51.573304	2026-04-22 19:33:51.573304
363	10	17	rw	2026-04-22 19:33:51.574506	2026-04-22 19:33:51.574506
364	10	18	rw	2026-04-22 19:33:51.57556	2026-04-22 19:33:51.57556
365	10	19	rw	2026-04-22 19:33:51.576589	2026-04-22 19:33:51.576589
366	10	20	rw	2026-04-22 19:33:51.577757	2026-04-22 19:33:51.577757
367	10	21	rw	2026-04-22 19:33:51.578782	2026-04-22 19:33:51.578782
368	10	22	rw	2026-04-22 19:33:51.580093	2026-04-22 19:33:51.580093
369	10	23	rw	2026-04-22 19:33:51.581585	2026-04-22 19:33:51.581585
370	10	24	rw	2026-04-22 19:33:51.582791	2026-04-22 19:33:51.582791
371	10	25	rw	2026-04-22 19:33:51.584228	2026-04-22 19:33:51.584228
372	10	26	rw	2026-04-22 19:33:51.587893	2026-04-22 19:33:51.587893
373	10	27	rw	2026-04-22 19:33:51.589443	2026-04-22 19:33:51.589443
374	10	28	rw	2026-04-22 19:33:51.590513	2026-04-22 19:33:51.590513
375	10	29	rw	2026-04-22 19:33:51.591611	2026-04-22 19:33:51.591611
376	10	30	rw	2026-04-22 19:33:51.592744	2026-04-22 19:33:51.592744
377	10	31	rw	2026-04-22 19:33:51.594231	2026-04-22 19:33:51.594231
378	10	32	rw	2026-04-22 19:33:51.59532	2026-04-22 19:33:51.59532
379	10	33	rw	2026-04-22 19:33:51.596317	2026-04-22 19:33:51.596317
380	10	34	rw	2026-04-22 19:33:51.597309	2026-04-22 19:33:51.597309
381	10	35	rw	2026-04-22 19:33:51.59828	2026-04-22 19:33:51.59828
382	10	36	rw	2026-04-22 19:33:51.599685	2026-04-22 19:33:51.599685
383	10	37	rw	2026-04-22 19:33:51.603923	2026-04-22 19:33:51.603923
384	10	38	rw	2026-04-22 19:33:51.606149	2026-04-22 19:33:51.606149
385	10	39	rw	2026-04-22 19:33:51.60779	2026-04-22 19:33:51.60779
386	10	40	rw	2026-04-22 19:33:51.60907	2026-04-22 19:33:51.60907
387	10	41	rw	2026-04-22 19:33:51.610128	2026-04-22 19:33:51.610128
388	10	42	rw	2026-04-22 19:33:51.611127	2026-04-22 19:33:51.611127
389	11	3	rw	2026-04-22 19:33:51.677288	2026-04-22 19:33:51.677288
390	11	12	rw	2026-04-22 19:33:51.678392	2026-04-22 19:33:51.678392
391	11	18	rw	2026-04-22 19:33:51.679359	2026-04-22 19:33:51.679359
392	11	38	rw	2026-04-22 19:33:51.680146	2026-04-22 19:33:51.680146
393	12	1	rw	2026-04-22 19:33:51.744722	2026-04-22 19:33:51.744722
394	12	2	rw	2026-04-22 19:33:51.746526	2026-04-22 19:33:51.746526
395	12	3	rw	2026-04-22 19:33:51.747832	2026-04-22 19:33:51.747832
396	12	4	rw	2026-04-22 19:33:51.749531	2026-04-22 19:33:51.749531
397	12	5	rw	2026-04-22 19:33:51.752651	2026-04-22 19:33:51.752651
398	12	6	rw	2026-04-22 19:33:51.756383	2026-04-22 19:33:51.756383
399	12	7	rw	2026-04-22 19:33:51.758255	2026-04-22 19:33:51.758255
400	12	8	rw	2026-04-22 19:33:51.759766	2026-04-22 19:33:51.759766
401	12	9	rw	2026-04-22 19:33:51.761011	2026-04-22 19:33:51.761011
402	12	10	rw	2026-04-22 19:33:51.762164	2026-04-22 19:33:51.762164
403	12	11	rw	2026-04-22 19:33:51.763338	2026-04-22 19:33:51.763338
404	12	12	rw	2026-04-22 19:33:51.764688	2026-04-22 19:33:51.764688
405	12	13	rw	2026-04-22 19:33:51.765915	2026-04-22 19:33:51.765915
406	12	14	rw	2026-04-22 19:33:51.76749	2026-04-22 19:33:51.76749
407	12	15	rw	2026-04-22 19:33:51.771267	2026-04-22 19:33:51.771267
408	12	16	rw	2026-04-22 19:33:51.773114	2026-04-22 19:33:51.773114
409	12	17	rw	2026-04-22 19:33:51.774726	2026-04-22 19:33:51.774726
410	12	18	rw	2026-04-22 19:33:51.775823	2026-04-22 19:33:51.775823
411	12	19	rw	2026-04-22 19:33:51.77682	2026-04-22 19:33:51.77682
412	12	20	rw	2026-04-22 19:33:51.777941	2026-04-22 19:33:51.777941
413	12	21	rw	2026-04-22 19:33:51.77904	2026-04-22 19:33:51.77904
414	12	22	rw	2026-04-22 19:33:51.780298	2026-04-22 19:33:51.780298
415	12	23	rw	2026-04-22 19:33:51.78168	2026-04-22 19:33:51.78168
416	12	24	rw	2026-04-22 19:33:51.782961	2026-04-22 19:33:51.782961
417	12	25	rw	2026-04-22 19:33:51.784577	2026-04-22 19:33:51.784577
418	12	26	rw	2026-04-22 19:33:51.788029	2026-04-22 19:33:51.788029
419	12	27	rw	2026-04-22 19:33:51.789616	2026-04-22 19:33:51.789616
420	12	28	rw	2026-04-22 19:33:51.790915	2026-04-22 19:33:51.790915
421	12	29	rw	2026-04-22 19:33:51.792076	2026-04-22 19:33:51.792076
422	12	30	rw	2026-04-22 19:33:51.793236	2026-04-22 19:33:51.793236
423	12	31	rw	2026-04-22 19:33:51.79441	2026-04-22 19:33:51.79441
424	12	32	rw	2026-04-22 19:33:51.796089	2026-04-22 19:33:51.796089
425	12	33	rw	2026-04-22 19:33:51.797402	2026-04-22 19:33:51.797402
426	12	34	rw	2026-04-22 19:33:51.798522	2026-04-22 19:33:51.798522
427	12	35	rw	2026-04-22 19:33:51.799737	2026-04-22 19:33:51.799737
428	12	36	rw	2026-04-22 19:33:51.803677	2026-04-22 19:33:51.803677
429	12	37	rw	2026-04-22 19:33:51.805583	2026-04-22 19:33:51.805583
430	12	38	rw	2026-04-22 19:33:51.806824	2026-04-22 19:33:51.806824
431	12	39	rw	2026-04-22 19:33:51.807879	2026-04-22 19:33:51.807879
432	12	40	rw	2026-04-22 19:33:51.809001	2026-04-22 19:33:51.809001
433	12	41	rw	2026-04-22 19:33:51.810386	2026-04-22 19:33:51.810386
434	12	42	rw	2026-04-22 19:33:51.812477	2026-04-22 19:33:51.812477
435	12	52	rw	2026-04-22 19:33:51.884634	2026-04-22 19:33:51.884634
436	12	53	rw	2026-04-22 19:33:51.889217	2026-04-22 19:33:51.889217
437	12	54	rw	2026-04-22 19:33:51.891033	2026-04-22 19:33:51.891033
438	12	55	rw	2026-04-22 19:33:51.892469	2026-04-22 19:33:51.892469
439	12	56	rw	2026-04-22 19:33:51.89379	2026-04-22 19:33:51.89379
440	12	57	rw	2026-04-22 19:33:51.895406	2026-04-22 19:33:51.895406
441	12	59	rw	2026-04-22 19:33:51.957041	2026-04-22 19:33:51.957041
442	12	60	rw	2026-04-22 19:33:51.959097	2026-04-22 19:33:51.959097
443	12	61	rw	2026-04-22 19:33:51.960524	2026-04-22 19:33:51.960524
444	12	62	rw	2026-04-22 19:33:51.961939	2026-04-22 19:33:51.961939
445	12	63	rw	2026-04-22 19:33:51.963405	2026-04-22 19:33:51.963405
446	12	64	rw	2026-04-22 19:33:51.964733	2026-04-22 19:33:51.964733
447	12	43	rw	2026-04-22 19:33:52.031651	2026-04-22 19:33:52.031651
448	12	44	rw	2026-04-22 19:33:52.034138	2026-04-22 19:33:52.034138
449	12	45	rw	2026-04-22 19:33:52.038406	2026-04-22 19:33:52.038406
450	12	46	rw	2026-04-22 19:33:52.040092	2026-04-22 19:33:52.040092
451	12	47	rw	2026-04-22 19:33:52.04161	2026-04-22 19:33:52.04161
452	12	48	rw	2026-04-22 19:33:52.042962	2026-04-22 19:33:52.042962
453	12	49	rw	2026-04-22 19:33:52.044397	2026-04-22 19:33:52.044397
454	12	50	rw	2026-04-22 19:33:52.045706	2026-04-22 19:33:52.045706
455	12	51	rw	2026-04-22 19:33:52.046878	2026-04-22 19:33:52.046878
456	13	61	rw	2026-06-01 20:20:37.89904	2026-06-01 20:20:37.89904
457	13	60	rw	2026-06-01 20:20:37.903167	2026-06-01 20:20:37.903167
458	13	62	rw	2026-06-01 20:20:37.905096	2026-06-01 20:20:37.905096
459	13	64	rw	2026-06-01 20:20:37.906826	2026-06-01 20:20:37.906826
460	13	63	rw	2026-06-01 20:20:37.908471	2026-06-01 20:20:37.908471
461	13	59	rw	2026-06-01 20:20:37.909862	2026-06-01 20:20:37.909862
462	14	61	rw	2026-06-01 20:20:38.076516	2026-06-01 20:20:38.076516
463	14	60	rw	2026-06-01 20:20:38.078439	2026-06-01 20:20:38.078439
464	14	62	rw	2026-06-01 20:20:38.0802	2026-06-01 20:20:38.0802
465	14	64	rw	2026-06-01 20:20:38.086282	2026-06-01 20:20:38.086282
466	14	63	rw	2026-06-01 20:20:38.089887	2026-06-01 20:20:38.089887
467	14	59	rw	2026-06-01 20:20:38.092747	2026-06-01 20:20:38.092747
501	15	60	rw	2026-06-03 15:29:33.857228	2026-06-03 15:29:33.857228
502	15	61	rw	2026-06-03 15:29:33.87163	2026-06-03 15:29:33.87163
503	15	62	rw	2026-06-03 15:29:33.874096	2026-06-03 15:29:33.874096
504	15	64	rw	2026-06-03 15:29:33.876446	2026-06-03 15:29:33.876446
505	15	63	rw	2026-06-03 15:29:33.879174	2026-06-03 15:29:33.879174
506	15	59	rw	2026-06-03 15:29:33.882502	2026-06-03 15:29:33.882502
518	16	60	rw	2026-06-03 15:29:34.042133	2026-06-03 15:29:34.042133
519	16	61	rw	2026-06-03 15:29:34.044867	2026-06-03 15:29:34.044867
520	16	62	rw	2026-06-03 15:29:34.047158	2026-06-03 15:29:34.047158
521	16	64	rw	2026-06-03 15:29:34.052435	2026-06-03 15:29:34.052435
522	16	63	rw	2026-06-03 15:29:34.055151	2026-06-03 15:29:34.055151
523	16	59	rw	2026-06-03 15:29:34.057647	2026-06-03 15:29:34.057647
535	17	60	rw	2026-06-03 15:29:34.266963	2026-06-03 15:29:34.266963
536	17	61	rw	2026-06-03 15:29:34.268867	2026-06-03 15:29:34.268867
537	17	62	rw	2026-06-03 15:29:34.270256	2026-06-03 15:29:34.270256
538	17	64	rw	2026-06-03 15:29:34.271648	2026-06-03 15:29:34.271648
539	17	63	rw	2026-06-03 15:29:34.272976	2026-06-03 15:29:34.272976
540	17	59	rw	2026-06-03 15:29:34.274184	2026-06-03 15:29:34.274184
\.


--
-- Data for Name: group_victims; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.group_victims (id, data) FROM stdin;
\.


--
-- Data for Name: group_victims_violations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.group_victims_violations (id, violation_id, group_victim_id) FROM stdin;
\.


--
-- Data for Name: identity_providers; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.identity_providers (id, name, unique_id, provider_type, configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: incidents; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.incidents (id, data, incident_case_id, phonetic_data, srch_created_at, srch_incident_date, srch_incident_location, srch_module_id, srch_owned_by, srch_owned_by_agency_id, srch_record_state, srch_flagged, srch_not_edited_by_owner, srch_status, srch_age, srch_owned_by_groups, srch_transferred_to_users, srch_transferred_to_user_groups, srch_associated_user_agencies, srch_associated_user_names, srch_associated_user_groups, srch_armed_force_group_party_names, srch_violation_with_verification_status, srch_assigned_user_names, srch_incident_date_derived, srch_gbv_sexual_violence_type, srch_cp_sexual_violence_type, srch_owned_by_agency_office, srch_unaccompanied_separated_status) FROM stdin;
\.


--
-- Data for Name: individual_victims; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.individual_victims (id, data) FROM stdin;
\.


--
-- Data for Name: individual_victims_violations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.individual_victims_violations (id, violation_id, individual_victim_id) FROM stdin;
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.locations (id, name_i18n, placename_i18n, location_code, admin_level, type, disabled, hierarchy_path) FROM stdin;
26	{"en": "Venezuela:Anzoátegui:Guanta", "es": "Venezuela:Anzoátegui:Guanta"}	{"en": "Guanta", "es": "Guanta"}	VE0410	2	municipality	f	VE.VE04.VE0410
41	{"en": "Venezuela:Apure:Muñoz", "es": "Venezuela:Apure:Muñoz"}	{"en": "Muñoz", "es": "Muñoz"}	VE0503	2	municipality	f	VE.VE05.VE0503
64	{"en": "Venezuela:Aragua:Zamora", "es": "Venezuela:Aragua:Zamora"}	{"en": "Zamora", "es": "Zamora"}	VE0618	2	municipality	f	VE.VE06.VE0618
65	{"en": "Venezuela:Barinas", "es": "Venezuela:Barinas"}	{"en": "Barinas", "es": "Barinas"}	VE07	1	state	f	VE.VE07
309	{"en": "Venezuela:Trujillo:La Ceiba", "es": "Venezuela:Trujillo:La Ceiba"}	{"en": "La Ceiba", "es": "La Ceiba"}	VE2309	2	municipality	f	VE.VE23.VE2309
13	{"en": "Venezuela", "es": "Venezuela"}	{"en": "Venezuela", "es": "Venezuela"}	VE	0	country	f	VE
14	{"en": "Venezuela:Distrito Capital", "es": "Venezuela:Distrito Capital"}	{"en": "Distrito Capital", "es": "Distrito Capital"}	VE12	1	state	f	VE.VE12
15	{"en": "Venezuela:Distrito Capital:Libertador", "es": "Venezuela:Distrito Capital:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE1201	2	municipality	f	VE.VE12.VE1201
16	{"en": "Venezuela:Anzoátegui", "es": "Venezuela:Anzoátegui"}	{"en": "Anzoátegui", "es": "Anzoátegui"}	VE04	1	state	f	VE.VE04
17	{"en": "Venezuela:Anzoátegui:Anaco", "es": "Venezuela:Anzoátegui:Anaco"}	{"en": "Anaco", "es": "Anaco"}	VE0401	2	municipality	f	VE.VE04.VE0401
18	{"en": "Venezuela:Anzoátegui:Aragua", "es": "Venezuela:Anzoátegui:Aragua"}	{"en": "Aragua", "es": "Aragua"}	VE0402	2	municipality	f	VE.VE04.VE0402
19	{"en": "Venezuela:Anzoátegui:Bolívar", "es": "Venezuela:Anzoátegui:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE0403	2	municipality	f	VE.VE04.VE0403
20	{"en": "Venezuela:Anzoátegui:Bruzual", "es": "Venezuela:Anzoátegui:Bruzual"}	{"en": "Bruzual", "es": "Bruzual"}	VE0404	2	municipality	f	VE.VE04.VE0404
21	{"en": "Venezuela:Anzoátegui:Cajigal", "es": "Venezuela:Anzoátegui:Cajigal"}	{"en": "Cajigal", "es": "Cajigal"}	VE0405	2	municipality	f	VE.VE04.VE0405
22	{"en": "Venezuela:Anzoátegui:Carvajal", "es": "Venezuela:Anzoátegui:Carvajal"}	{"en": "Carvajal", "es": "Carvajal"}	VE0406	2	municipality	f	VE.VE04.VE0406
23	{"en": "Venezuela:Anzoátegui:Diego Bautista Urbaneja", "es": "Venezuela:Anzoátegui:Diego Bautista Urbaneja"}	{"en": "Diego Bautista Urbaneja", "es": "Diego Bautista Urbaneja"}	VE0407	2	municipality	f	VE.VE04.VE0407
24	{"en": "Venezuela:Anzoátegui:Freites", "es": "Venezuela:Anzoátegui:Freites"}	{"en": "Freites", "es": "Freites"}	VE0408	2	municipality	f	VE.VE04.VE0408
25	{"en": "Venezuela:Anzoátegui:Guanipa", "es": "Venezuela:Anzoátegui:Guanipa"}	{"en": "Guanipa", "es": "Guanipa"}	VE0409	2	municipality	f	VE.VE04.VE0409
27	{"en": "Venezuela:Anzoátegui:Independencia", "es": "Venezuela:Anzoátegui:Independencia"}	{"en": "Independencia", "es": "Independencia"}	VE0411	2	municipality	f	VE.VE04.VE0411
28	{"en": "Venezuela:Anzoátegui:Libertad", "es": "Venezuela:Anzoátegui:Libertad"}	{"en": "Libertad", "es": "Libertad"}	VE0412	2	municipality	f	VE.VE04.VE0412
29	{"en": "Venezuela:Anzoátegui:McGregor", "es": "Venezuela:Anzoátegui:McGregor"}	{"en": "McGregor", "es": "McGregor"}	VE0413	2	municipality	f	VE.VE04.VE0413
30	{"en": "Venezuela:Anzoátegui:Miranda", "es": "Venezuela:Anzoátegui:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE0414	2	municipality	f	VE.VE04.VE0414
31	{"en": "Venezuela:Anzoátegui:Monagas", "es": "Venezuela:Anzoátegui:Monagas"}	{"en": "Monagas", "es": "Monagas"}	VE0415	2	municipality	f	VE.VE04.VE0415
32	{"en": "Venezuela:Anzoátegui:Peñalver", "es": "Venezuela:Anzoátegui:Peñalver"}	{"en": "Peñalver", "es": "Peñalver"}	VE0416	2	municipality	f	VE.VE04.VE0416
33	{"en": "Venezuela:Anzoátegui:Píritu", "es": "Venezuela:Anzoátegui:Píritu"}	{"en": "Píritu", "es": "Píritu"}	VE0417	2	municipality	f	VE.VE04.VE0417
34	{"en": "Venezuela:Anzoátegui:San Juan de Capistrano", "es": "Venezuela:Anzoátegui:San Juan de Capistrano"}	{"en": "San Juan de Capistrano", "es": "San Juan de Capistrano"}	VE0418	2	municipality	f	VE.VE04.VE0418
35	{"en": "Venezuela:Anzoátegui:Santa Ana", "es": "Venezuela:Anzoátegui:Santa Ana"}	{"en": "Santa Ana", "es": "Santa Ana"}	VE0419	2	municipality	f	VE.VE04.VE0419
36	{"en": "Venezuela:Anzoátegui:Simón Rodríguez", "es": "Venezuela:Anzoátegui:Simón Rodríguez"}	{"en": "Simón Rodríguez", "es": "Simón Rodríguez"}	VE0420	2	municipality	f	VE.VE04.VE0420
37	{"en": "Venezuela:Anzoátegui:Sotillo", "es": "Venezuela:Anzoátegui:Sotillo"}	{"en": "Sotillo", "es": "Sotillo"}	VE0421	2	municipality	f	VE.VE04.VE0421
38	{"en": "Venezuela:Apure", "es": "Venezuela:Apure"}	{"en": "Apure", "es": "Apure"}	VE05	1	state	f	VE.VE05
39	{"en": "Venezuela:Apure:Achaguas", "es": "Venezuela:Apure:Achaguas"}	{"en": "Achaguas", "es": "Achaguas"}	VE0501	2	municipality	f	VE.VE05.VE0501
40	{"en": "Venezuela:Apure:Biruaca", "es": "Venezuela:Apure:Biruaca"}	{"en": "Biruaca", "es": "Biruaca"}	VE0502	2	municipality	f	VE.VE05.VE0502
42	{"en": "Venezuela:Apure:Páez", "es": "Venezuela:Apure:Páez"}	{"en": "Páez", "es": "Páez"}	VE0504	2	municipality	f	VE.VE05.VE0504
43	{"en": "Venezuela:Apure:Pedro Camejo", "es": "Venezuela:Apure:Pedro Camejo"}	{"en": "Pedro Camejo", "es": "Pedro Camejo"}	VE0505	2	municipality	f	VE.VE05.VE0505
44	{"en": "Venezuela:Apure:Rómulo Gallegos", "es": "Venezuela:Apure:Rómulo Gallegos"}	{"en": "Rómulo Gallegos", "es": "Rómulo Gallegos"}	VE0506	2	municipality	f	VE.VE05.VE0506
45	{"en": "Venezuela:Apure:San Fernando", "es": "Venezuela:Apure:San Fernando"}	{"en": "San Fernando", "es": "San Fernando"}	VE0507	2	municipality	f	VE.VE05.VE0507
46	{"en": "Venezuela:Aragua", "es": "Venezuela:Aragua"}	{"en": "Aragua", "es": "Aragua"}	VE06	1	state	f	VE.VE06
47	{"en": "Venezuela:Aragua:Bolívar", "es": "Venezuela:Aragua:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE0601	2	municipality	f	VE.VE06.VE0601
48	{"en": "Venezuela:Aragua:Camatagua", "es": "Venezuela:Aragua:Camatagua"}	{"en": "Camatagua", "es": "Camatagua"}	VE0602	2	municipality	f	VE.VE06.VE0602
49	{"en": "Venezuela:Aragua:Francisco Linares Alcántara", "es": "Venezuela:Aragua:Francisco Linares Alcántara"}	{"en": "Francisco Linares Alcántara", "es": "Francisco Linares Alcántara"}	VE0603	2	municipality	f	VE.VE06.VE0603
50	{"en": "Venezuela:Aragua:Girardot", "es": "Venezuela:Aragua:Girardot"}	{"en": "Girardot", "es": "Girardot"}	VE0604	2	municipality	f	VE.VE06.VE0604
51	{"en": "Venezuela:Aragua:José Ángel Lamas", "es": "Venezuela:Aragua:José Ángel Lamas"}	{"en": "José Ángel Lamas", "es": "José Ángel Lamas"}	VE0605	2	municipality	f	VE.VE06.VE0605
52	{"en": "Venezuela:Aragua:José Félix Ribas", "es": "Venezuela:Aragua:José Félix Ribas"}	{"en": "José Félix Ribas", "es": "José Félix Ribas"}	VE0606	2	municipality	f	VE.VE06.VE0606
53	{"en": "Venezuela:Aragua:José Rafael Revenga", "es": "Venezuela:Aragua:José Rafael Revenga"}	{"en": "José Rafael Revenga", "es": "José Rafael Revenga"}	VE0607	2	municipality	f	VE.VE06.VE0607
54	{"en": "Venezuela:Aragua:Libertador", "es": "Venezuela:Aragua:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE0608	2	municipality	f	VE.VE06.VE0608
55	{"en": "Venezuela:Aragua:Mario Briceño Iragorry", "es": "Venezuela:Aragua:Mario Briceño Iragorry"}	{"en": "Mario Briceño Iragorry", "es": "Mario Briceño Iragorry"}	VE0609	2	municipality	f	VE.VE06.VE0609
56	{"en": "Venezuela:Aragua:Ocumare de la Costa de Oro", "es": "Venezuela:Aragua:Ocumare de la Costa de Oro"}	{"en": "Ocumare de la Costa de Oro", "es": "Ocumare de la Costa de Oro"}	VE0610	2	municipality	f	VE.VE06.VE0610
57	{"en": "Venezuela:Aragua:San Casimiro", "es": "Venezuela:Aragua:San Casimiro"}	{"en": "San Casimiro", "es": "San Casimiro"}	VE0611	2	municipality	f	VE.VE06.VE0611
58	{"en": "Venezuela:Aragua:San Sebastián", "es": "Venezuela:Aragua:San Sebastián"}	{"en": "San Sebastián", "es": "San Sebastián"}	VE0612	2	municipality	f	VE.VE06.VE0612
59	{"en": "Venezuela:Aragua:Santiago Mariño", "es": "Venezuela:Aragua:Santiago Mariño"}	{"en": "Santiago Mariño", "es": "Santiago Mariño"}	VE0613	2	municipality	f	VE.VE06.VE0613
60	{"en": "Venezuela:Aragua:Santos Michelena", "es": "Venezuela:Aragua:Santos Michelena"}	{"en": "Santos Michelena", "es": "Santos Michelena"}	VE0614	2	municipality	f	VE.VE06.VE0614
61	{"en": "Venezuela:Aragua:Sucre", "es": "Venezuela:Aragua:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE0615	2	municipality	f	VE.VE06.VE0615
62	{"en": "Venezuela:Aragua:Tovar", "es": "Venezuela:Aragua:Tovar"}	{"en": "Tovar", "es": "Tovar"}	VE0616	2	municipality	f	VE.VE06.VE0616
63	{"en": "Venezuela:Aragua:Urdaneta", "es": "Venezuela:Aragua:Urdaneta"}	{"en": "Urdaneta", "es": "Urdaneta"}	VE0617	2	municipality	f	VE.VE06.VE0617
66	{"en": "Venezuela:Barinas:Alberto Arvelo Torrealba", "es": "Venezuela:Barinas:Alberto Arvelo Torrealba"}	{"en": "Alberto Arvelo Torrealba", "es": "Alberto Arvelo Torrealba"}	VE0701	2	municipality	f	VE.VE07.VE0701
67	{"en": "Venezuela:Barinas:Andrés Eloy Blanco", "es": "Venezuela:Barinas:Andrés Eloy Blanco"}	{"en": "Andrés Eloy Blanco", "es": "Andrés Eloy Blanco"}	VE0702	2	municipality	f	VE.VE07.VE0702
68	{"en": "Venezuela:Barinas:Antonio José de Sucre", "es": "Venezuela:Barinas:Antonio José de Sucre"}	{"en": "Antonio José de Sucre", "es": "Antonio José de Sucre"}	VE0703	2	municipality	f	VE.VE07.VE0703
69	{"en": "Venezuela:Barinas:Arismendi", "es": "Venezuela:Barinas:Arismendi"}	{"en": "Arismendi", "es": "Arismendi"}	VE0704	2	municipality	f	VE.VE07.VE0704
70	{"en": "Venezuela:Barinas:Barinas", "es": "Venezuela:Barinas:Barinas"}	{"en": "Barinas", "es": "Barinas"}	VE0705	2	municipality	f	VE.VE07.VE0705
71	{"en": "Venezuela:Barinas:Bolívar", "es": "Venezuela:Barinas:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE0706	2	municipality	f	VE.VE07.VE0706
72	{"en": "Venezuela:Barinas:Cruz Paredes", "es": "Venezuela:Barinas:Cruz Paredes"}	{"en": "Cruz Paredes", "es": "Cruz Paredes"}	VE0707	2	municipality	f	VE.VE07.VE0707
73	{"en": "Venezuela:Barinas:Ezequiel Zamora", "es": "Venezuela:Barinas:Ezequiel Zamora"}	{"en": "Ezequiel Zamora", "es": "Ezequiel Zamora"}	VE0708	2	municipality	f	VE.VE07.VE0708
74	{"en": "Venezuela:Barinas:Obispos", "es": "Venezuela:Barinas:Obispos"}	{"en": "Obispos", "es": "Obispos"}	VE0709	2	municipality	f	VE.VE07.VE0709
75	{"en": "Venezuela:Barinas:Pedraza", "es": "Venezuela:Barinas:Pedraza"}	{"en": "Pedraza", "es": "Pedraza"}	VE0710	2	municipality	f	VE.VE07.VE0710
76	{"en": "Venezuela:Barinas:Rojas", "es": "Venezuela:Barinas:Rojas"}	{"en": "Rojas", "es": "Rojas"}	VE0711	2	municipality	f	VE.VE07.VE0711
77	{"en": "Venezuela:Barinas:Sosa", "es": "Venezuela:Barinas:Sosa"}	{"en": "Sosa", "es": "Sosa"}	VE0712	2	municipality	f	VE.VE07.VE0712
78	{"en": "Venezuela:Bolívar", "es": "Venezuela:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE08	1	state	f	VE.VE08
79	{"en": "Venezuela:Bolívar:Angostura", "es": "Venezuela:Bolívar:Angostura"}	{"en": "Angostura", "es": "Angostura"}	VE0801	2	municipality	f	VE.VE08.VE0801
80	{"en": "Venezuela:Bolívar:Caroní", "es": "Venezuela:Bolívar:Caroní"}	{"en": "Caroní", "es": "Caroní"}	VE0802	2	municipality	f	VE.VE08.VE0802
81	{"en": "Venezuela:Bolívar:Cedeño", "es": "Venezuela:Bolívar:Cedeño"}	{"en": "Cedeño", "es": "Cedeño"}	VE0803	2	municipality	f	VE.VE08.VE0803
82	{"en": "Venezuela:Bolívar:El Callao", "es": "Venezuela:Bolívar:El Callao"}	{"en": "El Callao", "es": "El Callao"}	VE0804	2	municipality	f	VE.VE08.VE0804
83	{"en": "Venezuela:Bolívar:Gran Sabana", "es": "Venezuela:Bolívar:Gran Sabana"}	{"en": "Gran Sabana", "es": "Gran Sabana"}	VE0805	2	municipality	f	VE.VE08.VE0805
84	{"en": "Venezuela:Bolívar:Heres", "es": "Venezuela:Bolívar:Heres"}	{"en": "Heres", "es": "Heres"}	VE0806	2	municipality	f	VE.VE08.VE0806
85	{"en": "Venezuela:Bolívar:Píar", "es": "Venezuela:Bolívar:Píar"}	{"en": "Píar", "es": "Píar"}	VE0807	2	municipality	f	VE.VE08.VE0807
86	{"en": "Venezuela:Bolívar:Roscio", "es": "Venezuela:Bolívar:Roscio"}	{"en": "Roscio", "es": "Roscio"}	VE0808	2	municipality	f	VE.VE08.VE0808
87	{"en": "Venezuela:Bolívar:Sifontes", "es": "Venezuela:Bolívar:Sifontes"}	{"en": "Sifontes", "es": "Sifontes"}	VE0809	2	municipality	f	VE.VE08.VE0809
88	{"en": "Venezuela:Bolívar:Sucre", "es": "Venezuela:Bolívar:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE0810	2	municipality	f	VE.VE08.VE0810
89	{"en": "Venezuela:Bolívar:Padre Pedro Chien", "es": "Venezuela:Bolívar:Padre Pedro Chien"}	{"en": "Padre Pedro Chien", "es": "Padre Pedro Chien"}	VE0811	2	municipality	f	VE.VE08.VE0811
90	{"en": "Venezuela:Carabobo", "es": "Venezuela:Carabobo"}	{"en": "Carabobo", "es": "Carabobo"}	VE09	1	state	f	VE.VE09
91	{"en": "Venezuela:Carabobo:Bejuma", "es": "Venezuela:Carabobo:Bejuma"}	{"en": "Bejuma", "es": "Bejuma"}	VE0901	2	municipality	f	VE.VE09.VE0901
92	{"en": "Venezuela:Carabobo:Carlos Arvelo", "es": "Venezuela:Carabobo:Carlos Arvelo"}	{"en": "Carlos Arvelo", "es": "Carlos Arvelo"}	VE0902	2	municipality	f	VE.VE09.VE0902
93	{"en": "Venezuela:Carabobo:Diego Ibarra", "es": "Venezuela:Carabobo:Diego Ibarra"}	{"en": "Diego Ibarra", "es": "Diego Ibarra"}	VE0903	2	municipality	f	VE.VE09.VE0903
94	{"en": "Venezuela:Carabobo:Guacara", "es": "Venezuela:Carabobo:Guacara"}	{"en": "Guacara", "es": "Guacara"}	VE0904	2	municipality	f	VE.VE09.VE0904
95	{"en": "Venezuela:Carabobo:Mora", "es": "Venezuela:Carabobo:Mora"}	{"en": "Mora", "es": "Mora"}	VE0905	2	municipality	f	VE.VE09.VE0905
96	{"en": "Venezuela:Carabobo:Libertador", "es": "Venezuela:Carabobo:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE0906	2	municipality	f	VE.VE09.VE0906
97	{"en": "Venezuela:Carabobo:Los Guayos", "es": "Venezuela:Carabobo:Los Guayos"}	{"en": "Los Guayos", "es": "Los Guayos"}	VE0907	2	municipality	f	VE.VE09.VE0907
98	{"en": "Venezuela:Carabobo:Miranda", "es": "Venezuela:Carabobo:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE0908	2	municipality	f	VE.VE09.VE0908
99	{"en": "Venezuela:Carabobo:Montalbán", "es": "Venezuela:Carabobo:Montalbán"}	{"en": "Montalbán", "es": "Montalbán"}	VE0909	2	municipality	f	VE.VE09.VE0909
100	{"en": "Venezuela:Carabobo:Naguanagua", "es": "Venezuela:Carabobo:Naguanagua"}	{"en": "Naguanagua", "es": "Naguanagua"}	VE0910	2	municipality	f	VE.VE09.VE0910
101	{"en": "Venezuela:Carabobo:Puerto Cabello", "es": "Venezuela:Carabobo:Puerto Cabello"}	{"en": "Puerto Cabello", "es": "Puerto Cabello"}	VE0911	2	municipality	f	VE.VE09.VE0911
102	{"en": "Venezuela:Carabobo:San Diego", "es": "Venezuela:Carabobo:San Diego"}	{"en": "San Diego", "es": "San Diego"}	VE0912	2	municipality	f	VE.VE09.VE0912
103	{"en": "Venezuela:Carabobo:San Joaquín", "es": "Venezuela:Carabobo:San Joaquín"}	{"en": "San Joaquín", "es": "San Joaquín"}	VE0913	2	municipality	f	VE.VE09.VE0913
104	{"en": "Venezuela:Carabobo:Valencia", "es": "Venezuela:Carabobo:Valencia"}	{"en": "Valencia", "es": "Valencia"}	VE0914	2	municipality	f	VE.VE09.VE0914
105	{"en": "Venezuela:Cojedes", "es": "Venezuela:Cojedes"}	{"en": "Cojedes", "es": "Cojedes"}	VE10	1	state	f	VE.VE10
106	{"en": "Venezuela:Cojedes:Anzoátegui", "es": "Venezuela:Cojedes:Anzoátegui"}	{"en": "Anzoátegui", "es": "Anzoátegui"}	VE1001	2	municipality	f	VE.VE10.VE1001
107	{"en": "Venezuela:Cojedes:Tinaquillo", "es": "Venezuela:Cojedes:Tinaquillo"}	{"en": "Tinaquillo", "es": "Tinaquillo"}	VE1002	2	municipality	f	VE.VE10.VE1002
108	{"en": "Venezuela:Cojedes:Girardot", "es": "Venezuela:Cojedes:Girardot"}	{"en": "Girardot", "es": "Girardot"}	VE1003	2	municipality	f	VE.VE10.VE1003
109	{"en": "Venezuela:Cojedes:Lima Blanco", "es": "Venezuela:Cojedes:Lima Blanco"}	{"en": "Lima Blanco", "es": "Lima Blanco"}	VE1004	2	municipality	f	VE.VE10.VE1004
110	{"en": "Venezuela:Cojedes:Pao de San Juan Bautista", "es": "Venezuela:Cojedes:Pao de San Juan Bautista"}	{"en": "Pao de San Juan Bautista", "es": "Pao de San Juan Bautista"}	VE1005	2	municipality	f	VE.VE10.VE1005
111	{"en": "Venezuela:Cojedes:Ricaurte", "es": "Venezuela:Cojedes:Ricaurte"}	{"en": "Ricaurte", "es": "Ricaurte"}	VE1006	2	municipality	f	VE.VE10.VE1006
112	{"en": "Venezuela:Cojedes:Rómulo Gallegos", "es": "Venezuela:Cojedes:Rómulo Gallegos"}	{"en": "Rómulo Gallegos", "es": "Rómulo Gallegos"}	VE1007	2	municipality	f	VE.VE10.VE1007
113	{"en": "Venezuela:Cojedes:San Carlos", "es": "Venezuela:Cojedes:San Carlos"}	{"en": "San Carlos", "es": "San Carlos"}	VE1008	2	municipality	f	VE.VE10.VE1008
114	{"en": "Venezuela:Cojedes:Tinaco", "es": "Venezuela:Cojedes:Tinaco"}	{"en": "Tinaco", "es": "Tinaco"}	VE1009	2	municipality	f	VE.VE10.VE1009
115	{"en": "Venezuela:Falcón", "es": "Venezuela:Falcón"}	{"en": "Falcón", "es": "Falcón"}	VE13	1	state	f	VE.VE13
116	{"en": "Venezuela:Falcón:Acosta", "es": "Venezuela:Falcón:Acosta"}	{"en": "Acosta", "es": "Acosta"}	VE1301	2	municipality	f	VE.VE13.VE1301
117	{"en": "Venezuela:Falcón:Bolívar", "es": "Venezuela:Falcón:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE1302	2	municipality	f	VE.VE13.VE1302
118	{"en": "Venezuela:Falcón:Buchivacoa", "es": "Venezuela:Falcón:Buchivacoa"}	{"en": "Buchivacoa", "es": "Buchivacoa"}	VE1303	2	municipality	f	VE.VE13.VE1303
119	{"en": "Venezuela:Falcón:Carirubana", "es": "Venezuela:Falcón:Carirubana"}	{"en": "Carirubana", "es": "Carirubana"}	VE1304	2	municipality	f	VE.VE13.VE1304
120	{"en": "Venezuela:Falcón:Colina", "es": "Venezuela:Falcón:Colina"}	{"en": "Colina", "es": "Colina"}	VE1305	2	municipality	f	VE.VE13.VE1305
121	{"en": "Venezuela:Falcón:Dabajuro", "es": "Venezuela:Falcón:Dabajuro"}	{"en": "Dabajuro", "es": "Dabajuro"}	VE1306	2	municipality	f	VE.VE13.VE1306
122	{"en": "Venezuela:Falcón:Democracia", "es": "Venezuela:Falcón:Democracia"}	{"en": "Democracia", "es": "Democracia"}	VE1307	2	municipality	f	VE.VE13.VE1307
123	{"en": "Venezuela:Falcón:Falcón", "es": "Venezuela:Falcón:Falcón"}	{"en": "Falcón", "es": "Falcón"}	VE1308	2	municipality	f	VE.VE13.VE1308
124	{"en": "Venezuela:Falcón:Federación", "es": "Venezuela:Falcón:Federación"}	{"en": "Federación", "es": "Federación"}	VE1309	2	municipality	f	VE.VE13.VE1309
125	{"en": "Venezuela:Falcón:Jacura", "es": "Venezuela:Falcón:Jacura"}	{"en": "Jacura", "es": "Jacura"}	VE1310	2	municipality	f	VE.VE13.VE1310
126	{"en": "Venezuela:Falcón:Los Taques", "es": "Venezuela:Falcón:Los Taques"}	{"en": "Los Taques", "es": "Los Taques"}	VE1311	2	municipality	f	VE.VE13.VE1311
127	{"en": "Venezuela:Falcón:Manaure", "es": "Venezuela:Falcón:Manaure"}	{"en": "Manaure", "es": "Manaure"}	VE1312	2	municipality	f	VE.VE13.VE1312
128	{"en": "Venezuela:Falcón:Mauroa", "es": "Venezuela:Falcón:Mauroa"}	{"en": "Mauroa", "es": "Mauroa"}	VE1313	2	municipality	f	VE.VE13.VE1313
129	{"en": "Venezuela:Falcón:Miranda", "es": "Venezuela:Falcón:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE1314	2	municipality	f	VE.VE13.VE1314
130	{"en": "Venezuela:Falcón:Monseñor Iturriza", "es": "Venezuela:Falcón:Monseñor Iturriza"}	{"en": "Monseñor Iturriza", "es": "Monseñor Iturriza"}	VE1315	2	municipality	f	VE.VE13.VE1315
131	{"en": "Venezuela:Falcón:Palmasola", "es": "Venezuela:Falcón:Palmasola"}	{"en": "Palmasola", "es": "Palmasola"}	VE1316	2	municipality	f	VE.VE13.VE1316
132	{"en": "Venezuela:Falcón:Petit", "es": "Venezuela:Falcón:Petit"}	{"en": "Petit", "es": "Petit"}	VE1317	2	municipality	f	VE.VE13.VE1317
133	{"en": "Venezuela:Falcón:Píritu", "es": "Venezuela:Falcón:Píritu"}	{"en": "Píritu", "es": "Píritu"}	VE1318	2	municipality	f	VE.VE13.VE1318
134	{"en": "Venezuela:Falcón:San Francisco", "es": "Venezuela:Falcón:San Francisco"}	{"en": "San Francisco", "es": "San Francisco"}	VE1319	2	municipality	f	VE.VE13.VE1319
135	{"en": "Venezuela:Falcón:Sucre", "es": "Venezuela:Falcón:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE1320	2	municipality	f	VE.VE13.VE1320
136	{"en": "Venezuela:Falcón:Silva", "es": "Venezuela:Falcón:Silva"}	{"en": "Silva", "es": "Silva"}	VE1321	2	municipality	f	VE.VE13.VE1321
137	{"en": "Venezuela:Falcón:Tocópero", "es": "Venezuela:Falcón:Tocópero"}	{"en": "Tocópero", "es": "Tocópero"}	VE1322	2	municipality	f	VE.VE13.VE1322
138	{"en": "Venezuela:Falcón:Unión", "es": "Venezuela:Falcón:Unión"}	{"en": "Unión", "es": "Unión"}	VE1323	2	municipality	f	VE.VE13.VE1323
139	{"en": "Venezuela:Falcón:Urumaco", "es": "Venezuela:Falcón:Urumaco"}	{"en": "Urumaco", "es": "Urumaco"}	VE1324	2	municipality	f	VE.VE13.VE1324
140	{"en": "Venezuela:Falcón:Zamora", "es": "Venezuela:Falcón:Zamora"}	{"en": "Zamora", "es": "Zamora"}	VE1325	2	municipality	f	VE.VE13.VE1325
141	{"en": "Venezuela:Guárico", "es": "Venezuela:Guárico"}	{"en": "Guárico", "es": "Guárico"}	VE14	1	state	f	VE.VE14
142	{"en": "Venezuela:Guárico:Camaguán", "es": "Venezuela:Guárico:Camaguán"}	{"en": "Camaguán", "es": "Camaguán"}	VE1401	2	municipality	f	VE.VE14.VE1401
143	{"en": "Venezuela:Guárico:Chaguaramas", "es": "Venezuela:Guárico:Chaguaramas"}	{"en": "Chaguaramas", "es": "Chaguaramas"}	VE1402	2	municipality	f	VE.VE14.VE1402
144	{"en": "Venezuela:Guárico:El Socorro", "es": "Venezuela:Guárico:El Socorro"}	{"en": "El Socorro", "es": "El Socorro"}	VE1403	2	municipality	f	VE.VE14.VE1403
145	{"en": "Venezuela:Guárico:Infante", "es": "Venezuela:Guárico:Infante"}	{"en": "Infante", "es": "Infante"}	VE1404	2	municipality	f	VE.VE14.VE1404
146	{"en": "Venezuela:Guárico:Las Mercedes", "es": "Venezuela:Guárico:Las Mercedes"}	{"en": "Las Mercedes", "es": "Las Mercedes"}	VE1405	2	municipality	f	VE.VE14.VE1405
147	{"en": "Venezuela:Guárico:Mellado", "es": "Venezuela:Guárico:Mellado"}	{"en": "Mellado", "es": "Mellado"}	VE1406	2	municipality	f	VE.VE14.VE1406
148	{"en": "Venezuela:Guárico:Miranda", "es": "Venezuela:Guárico:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE1407	2	municipality	f	VE.VE14.VE1407
149	{"en": "Venezuela:Guárico:Monagas", "es": "Venezuela:Guárico:Monagas"}	{"en": "Monagas", "es": "Monagas"}	VE1408	2	municipality	f	VE.VE14.VE1408
150	{"en": "Venezuela:Guárico:Ortiz", "es": "Venezuela:Guárico:Ortiz"}	{"en": "Ortiz", "es": "Ortiz"}	VE1409	2	municipality	f	VE.VE14.VE1409
151	{"en": "Venezuela:Guárico:Ribas", "es": "Venezuela:Guárico:Ribas"}	{"en": "Ribas", "es": "Ribas"}	VE1410	2	municipality	f	VE.VE14.VE1410
152	{"en": "Venezuela:Guárico:Roscio", "es": "Venezuela:Guárico:Roscio"}	{"en": "Roscio", "es": "Roscio"}	VE1411	2	municipality	f	VE.VE14.VE1411
153	{"en": "Venezuela:Guárico:San Gerónimo de Guayabal", "es": "Venezuela:Guárico:San Gerónimo de Guayabal"}	{"en": "San Gerónimo de Guayabal", "es": "San Gerónimo de Guayabal"}	VE1412	2	municipality	f	VE.VE14.VE1412
154	{"en": "Venezuela:Guárico:San José de Guaribe", "es": "Venezuela:Guárico:San José de Guaribe"}	{"en": "San José de Guaribe", "es": "San José de Guaribe"}	VE1413	2	municipality	f	VE.VE14.VE1413
155	{"en": "Venezuela:Guárico:Santa María de Ipire", "es": "Venezuela:Guárico:Santa María de Ipire"}	{"en": "Santa María de Ipire", "es": "Santa María de Ipire"}	VE1414	2	municipality	f	VE.VE14.VE1414
156	{"en": "Venezuela:Guárico:Zaraza", "es": "Venezuela:Guárico:Zaraza"}	{"en": "Zaraza", "es": "Zaraza"}	VE1415	2	municipality	f	VE.VE14.VE1415
157	{"en": "Venezuela:Lara", "es": "Venezuela:Lara"}	{"en": "Lara", "es": "Lara"}	VE16	1	state	f	VE.VE16
158	{"en": "Venezuela:Lara:Andrés Eloy Blanco", "es": "Venezuela:Lara:Andrés Eloy Blanco"}	{"en": "Andrés Eloy Blanco", "es": "Andrés Eloy Blanco"}	VE1601	2	municipality	f	VE.VE16.VE1601
159	{"en": "Venezuela:Lara:Crespo", "es": "Venezuela:Lara:Crespo"}	{"en": "Crespo", "es": "Crespo"}	VE1602	2	municipality	f	VE.VE16.VE1602
160	{"en": "Venezuela:Lara:Iribarren", "es": "Venezuela:Lara:Iribarren"}	{"en": "Iribarren", "es": "Iribarren"}	VE1603	2	municipality	f	VE.VE16.VE1603
161	{"en": "Venezuela:Lara:Jiménez", "es": "Venezuela:Lara:Jiménez"}	{"en": "Jiménez", "es": "Jiménez"}	VE1604	2	municipality	f	VE.VE16.VE1604
162	{"en": "Venezuela:Lara:Morán", "es": "Venezuela:Lara:Morán"}	{"en": "Morán", "es": "Morán"}	VE1605	2	municipality	f	VE.VE16.VE1605
163	{"en": "Venezuela:Lara:Palavecino", "es": "Venezuela:Lara:Palavecino"}	{"en": "Palavecino", "es": "Palavecino"}	VE1606	2	municipality	f	VE.VE16.VE1606
164	{"en": "Venezuela:Lara:Simón Planas", "es": "Venezuela:Lara:Simón Planas"}	{"en": "Simón Planas", "es": "Simón Planas"}	VE1607	2	municipality	f	VE.VE16.VE1607
165	{"en": "Venezuela:Lara:Torres", "es": "Venezuela:Lara:Torres"}	{"en": "Torres", "es": "Torres"}	VE1608	2	municipality	f	VE.VE16.VE1608
166	{"en": "Venezuela:Lara:Urdaneta", "es": "Venezuela:Lara:Urdaneta"}	{"en": "Urdaneta", "es": "Urdaneta"}	VE1609	2	municipality	f	VE.VE16.VE1609
167	{"en": "Venezuela:Mérida", "es": "Venezuela:Mérida"}	{"en": "Mérida", "es": "Mérida"}	VE17	1	state	f	VE.VE17
168	{"en": "Venezuela:Mérida:Alberto Adriani", "es": "Venezuela:Mérida:Alberto Adriani"}	{"en": "Alberto Adriani", "es": "Alberto Adriani"}	VE1701	2	municipality	f	VE.VE17.VE1701
169	{"en": "Venezuela:Mérida:Andrés Bello", "es": "Venezuela:Mérida:Andrés Bello"}	{"en": "Andrés Bello", "es": "Andrés Bello"}	VE1702	2	municipality	f	VE.VE17.VE1702
170	{"en": "Venezuela:Mérida:Antonio Pinto Salinas", "es": "Venezuela:Mérida:Antonio Pinto Salinas"}	{"en": "Antonio Pinto Salinas", "es": "Antonio Pinto Salinas"}	VE1703	2	municipality	f	VE.VE17.VE1703
171	{"en": "Venezuela:Mérida:Aricagua", "es": "Venezuela:Mérida:Aricagua"}	{"en": "Aricagua", "es": "Aricagua"}	VE1704	2	municipality	f	VE.VE17.VE1704
172	{"en": "Venezuela:Mérida:Arzobispo Chacón", "es": "Venezuela:Mérida:Arzobispo Chacón"}	{"en": "Arzobispo Chacón", "es": "Arzobispo Chacón"}	VE1705	2	municipality	f	VE.VE17.VE1705
173	{"en": "Venezuela:Mérida:Campo Elías", "es": "Venezuela:Mérida:Campo Elías"}	{"en": "Campo Elías", "es": "Campo Elías"}	VE1706	2	municipality	f	VE.VE17.VE1706
174	{"en": "Venezuela:Mérida:Caracciolo Parra Olmedo", "es": "Venezuela:Mérida:Caracciolo Parra Olmedo"}	{"en": "Caracciolo Parra Olmedo", "es": "Caracciolo Parra Olmedo"}	VE1707	2	municipality	f	VE.VE17.VE1707
175	{"en": "Venezuela:Mérida:Cardenal Quintero", "es": "Venezuela:Mérida:Cardenal Quintero"}	{"en": "Cardenal Quintero", "es": "Cardenal Quintero"}	VE1708	2	municipality	f	VE.VE17.VE1708
176	{"en": "Venezuela:Mérida:Guaraque", "es": "Venezuela:Mérida:Guaraque"}	{"en": "Guaraque", "es": "Guaraque"}	VE1709	2	municipality	f	VE.VE17.VE1709
177	{"en": "Venezuela:Mérida:Julio César Salas", "es": "Venezuela:Mérida:Julio César Salas"}	{"en": "Julio César Salas", "es": "Julio César Salas"}	VE1710	2	municipality	f	VE.VE17.VE1710
178	{"en": "Venezuela:Mérida:Justo Briceño", "es": "Venezuela:Mérida:Justo Briceño"}	{"en": "Justo Briceño", "es": "Justo Briceño"}	VE1711	2	municipality	f	VE.VE17.VE1711
179	{"en": "Venezuela:Mérida:Libertador", "es": "Venezuela:Mérida:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE1712	2	municipality	f	VE.VE17.VE1712
180	{"en": "Venezuela:Mérida:Miranda", "es": "Venezuela:Mérida:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE1713	2	municipality	f	VE.VE17.VE1713
181	{"en": "Venezuela:Mérida:Obispo Ramos de Lora", "es": "Venezuela:Mérida:Obispo Ramos de Lora"}	{"en": "Obispo Ramos de Lora", "es": "Obispo Ramos de Lora"}	VE1714	2	municipality	f	VE.VE17.VE1714
182	{"en": "Venezuela:Mérida:Padre Noguera", "es": "Venezuela:Mérida:Padre Noguera"}	{"en": "Padre Noguera", "es": "Padre Noguera"}	VE1715	2	municipality	f	VE.VE17.VE1715
183	{"en": "Venezuela:Mérida:Pueblo Llano", "es": "Venezuela:Mérida:Pueblo Llano"}	{"en": "Pueblo Llano", "es": "Pueblo Llano"}	VE1716	2	municipality	f	VE.VE17.VE1716
184	{"en": "Venezuela:Mérida:Rangel", "es": "Venezuela:Mérida:Rangel"}	{"en": "Rangel", "es": "Rangel"}	VE1717	2	municipality	f	VE.VE17.VE1717
185	{"en": "Venezuela:Mérida:Rivas Dávila", "es": "Venezuela:Mérida:Rivas Dávila"}	{"en": "Rivas Dávila", "es": "Rivas Dávila"}	VE1718	2	municipality	f	VE.VE17.VE1718
186	{"en": "Venezuela:Mérida:Santos Marquina", "es": "Venezuela:Mérida:Santos Marquina"}	{"en": "Santos Marquina", "es": "Santos Marquina"}	VE1719	2	municipality	f	VE.VE17.VE1719
187	{"en": "Venezuela:Mérida:Sucre", "es": "Venezuela:Mérida:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE1720	2	municipality	f	VE.VE17.VE1720
188	{"en": "Venezuela:Mérida:Tovar", "es": "Venezuela:Mérida:Tovar"}	{"en": "Tovar", "es": "Tovar"}	VE1721	2	municipality	f	VE.VE17.VE1721
189	{"en": "Venezuela:Mérida:Tulio Febres Cordero", "es": "Venezuela:Mérida:Tulio Febres Cordero"}	{"en": "Tulio Febres Cordero", "es": "Tulio Febres Cordero"}	VE1722	2	municipality	f	VE.VE17.VE1722
190	{"en": "Venezuela:Mérida:Zea", "es": "Venezuela:Mérida:Zea"}	{"en": "Zea", "es": "Zea"}	VE1723	2	municipality	f	VE.VE17.VE1723
191	{"en": "Venezuela:Miranda", "es": "Venezuela:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE18	1	state	f	VE.VE18
192	{"en": "Venezuela:Miranda:Acevedo", "es": "Venezuela:Miranda:Acevedo"}	{"en": "Acevedo", "es": "Acevedo"}	VE1801	2	municipality	f	VE.VE18.VE1801
193	{"en": "Venezuela:Miranda:Andrés Bello", "es": "Venezuela:Miranda:Andrés Bello"}	{"en": "Andrés Bello", "es": "Andrés Bello"}	VE1802	2	municipality	f	VE.VE18.VE1802
194	{"en": "Venezuela:Miranda:Baruta", "es": "Venezuela:Miranda:Baruta"}	{"en": "Baruta", "es": "Baruta"}	VE1803	2	municipality	f	VE.VE18.VE1803
195	{"en": "Venezuela:Miranda:Brión", "es": "Venezuela:Miranda:Brión"}	{"en": "Brión", "es": "Brión"}	VE1804	2	municipality	f	VE.VE18.VE1804
196	{"en": "Venezuela:Miranda:Buroz", "es": "Venezuela:Miranda:Buroz"}	{"en": "Buroz", "es": "Buroz"}	VE1805	2	municipality	f	VE.VE18.VE1805
197	{"en": "Venezuela:Miranda:Carrizal", "es": "Venezuela:Miranda:Carrizal"}	{"en": "Carrizal", "es": "Carrizal"}	VE1806	2	municipality	f	VE.VE18.VE1806
198	{"en": "Venezuela:Miranda:Chacao", "es": "Venezuela:Miranda:Chacao"}	{"en": "Chacao", "es": "Chacao"}	VE1807	2	municipality	f	VE.VE18.VE1807
199	{"en": "Venezuela:Miranda:Cristóbal Rojas", "es": "Venezuela:Miranda:Cristóbal Rojas"}	{"en": "Cristóbal Rojas", "es": "Cristóbal Rojas"}	VE1808	2	municipality	f	VE.VE18.VE1808
200	{"en": "Venezuela:Miranda:El Hatillo", "es": "Venezuela:Miranda:El Hatillo"}	{"en": "El Hatillo", "es": "El Hatillo"}	VE1809	2	municipality	f	VE.VE18.VE1809
201	{"en": "Venezuela:Miranda:Guaicaipuro", "es": "Venezuela:Miranda:Guaicaipuro"}	{"en": "Guaicaipuro", "es": "Guaicaipuro"}	VE1810	2	municipality	f	VE.VE18.VE1810
202	{"en": "Venezuela:Miranda:Independencia", "es": "Venezuela:Miranda:Independencia"}	{"en": "Independencia", "es": "Independencia"}	VE1811	2	municipality	f	VE.VE18.VE1811
203	{"en": "Venezuela:Miranda:Lander", "es": "Venezuela:Miranda:Lander"}	{"en": "Lander", "es": "Lander"}	VE1812	2	municipality	f	VE.VE18.VE1812
204	{"en": "Venezuela:Miranda:Los Salias", "es": "Venezuela:Miranda:Los Salias"}	{"en": "Los Salias", "es": "Los Salias"}	VE1813	2	municipality	f	VE.VE18.VE1813
205	{"en": "Venezuela:Miranda:Páez", "es": "Venezuela:Miranda:Páez"}	{"en": "Páez", "es": "Páez"}	VE1814	2	municipality	f	VE.VE18.VE1814
206	{"en": "Venezuela:Miranda:Paz Castillo", "es": "Venezuela:Miranda:Paz Castillo"}	{"en": "Paz Castillo", "es": "Paz Castillo"}	VE1815	2	municipality	f	VE.VE18.VE1815
207	{"en": "Venezuela:Miranda:Pedro Gual", "es": "Venezuela:Miranda:Pedro Gual"}	{"en": "Pedro Gual", "es": "Pedro Gual"}	VE1816	2	municipality	f	VE.VE18.VE1816
208	{"en": "Venezuela:Miranda:Plaza", "es": "Venezuela:Miranda:Plaza"}	{"en": "Plaza", "es": "Plaza"}	VE1817	2	municipality	f	VE.VE18.VE1817
209	{"en": "Venezuela:Miranda:Simón Bolívar", "es": "Venezuela:Miranda:Simón Bolívar"}	{"en": "Simón Bolívar", "es": "Simón Bolívar"}	VE1818	2	municipality	f	VE.VE18.VE1818
210	{"en": "Venezuela:Miranda:Sucre", "es": "Venezuela:Miranda:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE1819	2	municipality	f	VE.VE18.VE1819
211	{"en": "Venezuela:Miranda:Urdaneta", "es": "Venezuela:Miranda:Urdaneta"}	{"en": "Urdaneta", "es": "Urdaneta"}	VE1820	2	municipality	f	VE.VE18.VE1820
212	{"en": "Venezuela:Miranda:Zamora", "es": "Venezuela:Miranda:Zamora"}	{"en": "Zamora", "es": "Zamora"}	VE1821	2	municipality	f	VE.VE18.VE1821
213	{"en": "Venezuela:Monagas", "es": "Venezuela:Monagas"}	{"en": "Monagas", "es": "Monagas"}	VE19	1	state	f	VE.VE19
214	{"en": "Venezuela:Monagas:Acosta", "es": "Venezuela:Monagas:Acosta"}	{"en": "Acosta", "es": "Acosta"}	VE1901	2	municipality	f	VE.VE19.VE1901
215	{"en": "Venezuela:Monagas:Aguasay", "es": "Venezuela:Monagas:Aguasay"}	{"en": "Aguasay", "es": "Aguasay"}	VE1902	2	municipality	f	VE.VE19.VE1902
216	{"en": "Venezuela:Monagas:Bolívar", "es": "Venezuela:Monagas:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE1903	2	municipality	f	VE.VE19.VE1903
217	{"en": "Venezuela:Monagas:Caripe", "es": "Venezuela:Monagas:Caripe"}	{"en": "Caripe", "es": "Caripe"}	VE1904	2	municipality	f	VE.VE19.VE1904
218	{"en": "Venezuela:Monagas:Cedeño", "es": "Venezuela:Monagas:Cedeño"}	{"en": "Cedeño", "es": "Cedeño"}	VE1905	2	municipality	f	VE.VE19.VE1905
219	{"en": "Venezuela:Monagas:Ezequiel Zamora", "es": "Venezuela:Monagas:Ezequiel Zamora"}	{"en": "Ezequiel Zamora", "es": "Ezequiel Zamora"}	VE1906	2	municipality	f	VE.VE19.VE1906
220	{"en": "Venezuela:Monagas:Libertador", "es": "Venezuela:Monagas:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE1907	2	municipality	f	VE.VE19.VE1907
221	{"en": "Venezuela:Monagas:Maturín", "es": "Venezuela:Monagas:Maturín"}	{"en": "Maturín", "es": "Maturín"}	VE1908	2	municipality	f	VE.VE19.VE1908
222	{"en": "Venezuela:Monagas:Piar", "es": "Venezuela:Monagas:Piar"}	{"en": "Piar", "es": "Piar"}	VE1909	2	municipality	f	VE.VE19.VE1909
223	{"en": "Venezuela:Monagas:Punceres", "es": "Venezuela:Monagas:Punceres"}	{"en": "Punceres", "es": "Punceres"}	VE1910	2	municipality	f	VE.VE19.VE1910
224	{"en": "Venezuela:Monagas:Santa Bárbara", "es": "Venezuela:Monagas:Santa Bárbara"}	{"en": "Santa Bárbara", "es": "Santa Bárbara"}	VE1911	2	municipality	f	VE.VE19.VE1911
225	{"en": "Venezuela:Monagas:Sotillo", "es": "Venezuela:Monagas:Sotillo"}	{"en": "Sotillo", "es": "Sotillo"}	VE1912	2	municipality	f	VE.VE19.VE1912
226	{"en": "Venezuela:Monagas:Uracoa", "es": "Venezuela:Monagas:Uracoa"}	{"en": "Uracoa", "es": "Uracoa"}	VE1913	2	municipality	f	VE.VE19.VE1913
227	{"en": "Venezuela:Nueva Esparta", "es": "Venezuela:Nueva Esparta"}	{"en": "Nueva Esparta", "es": "Nueva Esparta"}	VE20	1	state	f	VE.VE20
228	{"en": "Venezuela:Nueva Esparta:Antolín del Campo", "es": "Venezuela:Nueva Esparta:Antolín del Campo"}	{"en": "Antolín del Campo", "es": "Antolín del Campo"}	VE2001	2	municipality	f	VE.VE20.VE2001
229	{"en": "Venezuela:Nueva Esparta:Arismendi", "es": "Venezuela:Nueva Esparta:Arismendi"}	{"en": "Arismendi", "es": "Arismendi"}	VE2002	2	municipality	f	VE.VE20.VE2002
230	{"en": "Venezuela:Nueva Esparta:Díaz", "es": "Venezuela:Nueva Esparta:Díaz"}	{"en": "Díaz", "es": "Díaz"}	VE2003	2	municipality	f	VE.VE20.VE2003
231	{"en": "Venezuela:Nueva Esparta:García", "es": "Venezuela:Nueva Esparta:García"}	{"en": "García", "es": "García"}	VE2004	2	municipality	f	VE.VE20.VE2004
232	{"en": "Venezuela:Nueva Esparta:Gómez", "es": "Venezuela:Nueva Esparta:Gómez"}	{"en": "Gómez", "es": "Gómez"}	VE2005	2	municipality	f	VE.VE20.VE2005
233	{"en": "Venezuela:Nueva Esparta:Maneiro", "es": "Venezuela:Nueva Esparta:Maneiro"}	{"en": "Maneiro", "es": "Maneiro"}	VE2006	2	municipality	f	VE.VE20.VE2006
234	{"en": "Venezuela:Nueva Esparta:Marcano", "es": "Venezuela:Nueva Esparta:Marcano"}	{"en": "Marcano", "es": "Marcano"}	VE2007	2	municipality	f	VE.VE20.VE2007
235	{"en": "Venezuela:Nueva Esparta:Mariño", "es": "Venezuela:Nueva Esparta:Mariño"}	{"en": "Mariño", "es": "Mariño"}	VE2008	2	municipality	f	VE.VE20.VE2008
273	{"en": "Venezuela:Táchira:Ayacucho", "es": "Venezuela:Táchira:Ayacucho"}	{"en": "Ayacucho", "es": "Ayacucho"}	VE0103	2	municipality	f	VE.VE01.VE0103
236	{"en": "Venezuela:Nueva Esparta:Península de Macanao", "es": "Venezuela:Nueva Esparta:Península de Macanao"}	{"en": "Península de Macanao", "es": "Península de Macanao"}	VE2009	2	municipality	f	VE.VE20.VE2009
237	{"en": "Venezuela:Nueva Esparta:Tubores", "es": "Venezuela:Nueva Esparta:Tubores"}	{"en": "Tubores", "es": "Tubores"}	VE2010	2	municipality	f	VE.VE20.VE2010
238	{"en": "Venezuela:Nueva Esparta:Villalba", "es": "Venezuela:Nueva Esparta:Villalba"}	{"en": "Villalba", "es": "Villalba"}	VE2011	2	municipality	f	VE.VE20.VE2011
239	{"en": "Venezuela:Portuguesa", "es": "Venezuela:Portuguesa"}	{"en": "Portuguesa", "es": "Portuguesa"}	VE21	1	state	f	VE.VE21
240	{"en": "Venezuela:Portuguesa:Agua Blanca", "es": "Venezuela:Portuguesa:Agua Blanca"}	{"en": "Agua Blanca", "es": "Agua Blanca"}	VE2101	2	municipality	f	VE.VE21.VE2101
241	{"en": "Venezuela:Portuguesa:Araure", "es": "Venezuela:Portuguesa:Araure"}	{"en": "Araure", "es": "Araure"}	VE2102	2	municipality	f	VE.VE21.VE2102
242	{"en": "Venezuela:Portuguesa:Esteller", "es": "Venezuela:Portuguesa:Esteller"}	{"en": "Esteller", "es": "Esteller"}	VE2103	2	municipality	f	VE.VE21.VE2103
243	{"en": "Venezuela:Portuguesa:Guanare", "es": "Venezuela:Portuguesa:Guanare"}	{"en": "Guanare", "es": "Guanare"}	VE2104	2	municipality	f	VE.VE21.VE2104
244	{"en": "Venezuela:Portuguesa:Guanarito", "es": "Venezuela:Portuguesa:Guanarito"}	{"en": "Guanarito", "es": "Guanarito"}	VE2105	2	municipality	f	VE.VE21.VE2105
245	{"en": "Venezuela:Portuguesa:Monseñor José Vicente de Unda", "es": "Venezuela:Portuguesa:Monseñor José Vicente de Unda"}	{"en": "Monseñor José Vicente de Unda", "es": "Monseñor José Vicente de Unda"}	VE2106	2	municipality	f	VE.VE21.VE2106
246	{"en": "Venezuela:Portuguesa:Ospino", "es": "Venezuela:Portuguesa:Ospino"}	{"en": "Ospino", "es": "Ospino"}	VE2107	2	municipality	f	VE.VE21.VE2107
247	{"en": "Venezuela:Portuguesa:Páez", "es": "Venezuela:Portuguesa:Páez"}	{"en": "Páez", "es": "Páez"}	VE2108	2	municipality	f	VE.VE21.VE2108
248	{"en": "Venezuela:Portuguesa:Papelón", "es": "Venezuela:Portuguesa:Papelón"}	{"en": "Papelón", "es": "Papelón"}	VE2109	2	municipality	f	VE.VE21.VE2109
249	{"en": "Venezuela:Portuguesa:San Genaro de Boconoíto", "es": "Venezuela:Portuguesa:San Genaro de Boconoíto"}	{"en": "San Genaro de Boconoíto", "es": "San Genaro de Boconoíto"}	VE2110	2	municipality	f	VE.VE21.VE2110
250	{"en": "Venezuela:Portuguesa:San Rafael de Onoto", "es": "Venezuela:Portuguesa:San Rafael de Onoto"}	{"en": "San Rafael de Onoto", "es": "San Rafael de Onoto"}	VE2111	2	municipality	f	VE.VE21.VE2111
251	{"en": "Venezuela:Portuguesa:Santa Rosalía", "es": "Venezuela:Portuguesa:Santa Rosalía"}	{"en": "Santa Rosalía", "es": "Santa Rosalía"}	VE2112	2	municipality	f	VE.VE21.VE2112
252	{"en": "Venezuela:Portuguesa:Sucre", "es": "Venezuela:Portuguesa:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE2113	2	municipality	f	VE.VE21.VE2113
253	{"en": "Venezuela:Portuguesa:Turén", "es": "Venezuela:Portuguesa:Turén"}	{"en": "Turén", "es": "Turén"}	VE2114	2	municipality	f	VE.VE21.VE2114
254	{"en": "Venezuela:Sucre", "es": "Venezuela:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE22	1	state	f	VE.VE22
255	{"en": "Venezuela:Sucre:Andrés Eloy Blanco", "es": "Venezuela:Sucre:Andrés Eloy Blanco"}	{"en": "Andrés Eloy Blanco", "es": "Andrés Eloy Blanco"}	VE2201	2	municipality	f	VE.VE22.VE2201
256	{"en": "Venezuela:Sucre:Andrés Mata", "es": "Venezuela:Sucre:Andrés Mata"}	{"en": "Andrés Mata", "es": "Andrés Mata"}	VE2202	2	municipality	f	VE.VE22.VE2202
257	{"en": "Venezuela:Sucre:Arismendi", "es": "Venezuela:Sucre:Arismendi"}	{"en": "Arismendi", "es": "Arismendi"}	VE2203	2	municipality	f	VE.VE22.VE2203
258	{"en": "Venezuela:Sucre:Benítez", "es": "Venezuela:Sucre:Benítez"}	{"en": "Benítez", "es": "Benítez"}	VE2204	2	municipality	f	VE.VE22.VE2204
259	{"en": "Venezuela:Sucre:Bermúdez", "es": "Venezuela:Sucre:Bermúdez"}	{"en": "Bermúdez", "es": "Bermúdez"}	VE2205	2	municipality	f	VE.VE22.VE2205
260	{"en": "Venezuela:Sucre:Bolívar", "es": "Venezuela:Sucre:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE2206	2	municipality	f	VE.VE22.VE2206
261	{"en": "Venezuela:Sucre:Cajigal", "es": "Venezuela:Sucre:Cajigal"}	{"en": "Cajigal", "es": "Cajigal"}	VE2207	2	municipality	f	VE.VE22.VE2207
262	{"en": "Venezuela:Sucre:Cruz Salmerón Acosta", "es": "Venezuela:Sucre:Cruz Salmerón Acosta"}	{"en": "Cruz Salmerón Acosta", "es": "Cruz Salmerón Acosta"}	VE2208	2	municipality	f	VE.VE22.VE2208
263	{"en": "Venezuela:Sucre:Libertador", "es": "Venezuela:Sucre:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE2209	2	municipality	f	VE.VE22.VE2209
264	{"en": "Venezuela:Sucre:Mariño", "es": "Venezuela:Sucre:Mariño"}	{"en": "Mariño", "es": "Mariño"}	VE2210	2	municipality	f	VE.VE22.VE2210
265	{"en": "Venezuela:Sucre:Mejía", "es": "Venezuela:Sucre:Mejía"}	{"en": "Mejía", "es": "Mejía"}	VE2211	2	municipality	f	VE.VE22.VE2211
266	{"en": "Venezuela:Sucre:Montes", "es": "Venezuela:Sucre:Montes"}	{"en": "Montes", "es": "Montes"}	VE2212	2	municipality	f	VE.VE22.VE2212
267	{"en": "Venezuela:Sucre:Ribero", "es": "Venezuela:Sucre:Ribero"}	{"en": "Ribero", "es": "Ribero"}	VE2213	2	municipality	f	VE.VE22.VE2213
268	{"en": "Venezuela:Sucre:Sucre", "es": "Venezuela:Sucre:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE2214	2	municipality	f	VE.VE22.VE2214
269	{"en": "Venezuela:Sucre:Valdez", "es": "Venezuela:Sucre:Valdez"}	{"en": "Valdez", "es": "Valdez"}	VE2215	2	municipality	f	VE.VE22.VE2215
270	{"en": "Venezuela:Táchira", "es": "Venezuela:Táchira"}	{"en": "Táchira", "es": "Táchira"}	VE01	1	state	f	VE.VE01
271	{"en": "Venezuela:Táchira:Andrés Bello", "es": "Venezuela:Táchira:Andrés Bello"}	{"en": "Andrés Bello", "es": "Andrés Bello"}	VE0101	2	municipality	f	VE.VE01.VE0101
272	{"en": "Venezuela:Táchira:Antonio Rómulo Costa", "es": "Venezuela:Táchira:Antonio Rómulo Costa"}	{"en": "Antonio Rómulo Costa", "es": "Antonio Rómulo Costa"}	VE0102	2	municipality	f	VE.VE01.VE0102
274	{"en": "Venezuela:Táchira:Bolívar", "es": "Venezuela:Táchira:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE0104	2	municipality	f	VE.VE01.VE0104
275	{"en": "Venezuela:Táchira:Cárdenas", "es": "Venezuela:Táchira:Cárdenas"}	{"en": "Cárdenas", "es": "Cárdenas"}	VE0105	2	municipality	f	VE.VE01.VE0105
276	{"en": "Venezuela:Táchira:Córdoba", "es": "Venezuela:Táchira:Córdoba"}	{"en": "Córdoba", "es": "Córdoba"}	VE0106	2	municipality	f	VE.VE01.VE0106
277	{"en": "Venezuela:Táchira:Fernández Feo", "es": "Venezuela:Táchira:Fernández Feo"}	{"en": "Fernández Feo", "es": "Fernández Feo"}	VE0107	2	municipality	f	VE.VE01.VE0107
278	{"en": "Venezuela:Táchira:Francisco de Miranda", "es": "Venezuela:Táchira:Francisco de Miranda"}	{"en": "Francisco de Miranda", "es": "Francisco de Miranda"}	VE0108	2	municipality	f	VE.VE01.VE0108
279	{"en": "Venezuela:Táchira:García de Hevia", "es": "Venezuela:Táchira:García de Hevia"}	{"en": "García de Hevia", "es": "García de Hevia"}	VE0109	2	municipality	f	VE.VE01.VE0109
280	{"en": "Venezuela:Táchira:Guásimos", "es": "Venezuela:Táchira:Guásimos"}	{"en": "Guásimos", "es": "Guásimos"}	VE0110	2	municipality	f	VE.VE01.VE0110
281	{"en": "Venezuela:Táchira:Independencia", "es": "Venezuela:Táchira:Independencia"}	{"en": "Independencia", "es": "Independencia"}	VE0111	2	municipality	f	VE.VE01.VE0111
282	{"en": "Venezuela:Táchira:Jáuregui", "es": "Venezuela:Táchira:Jáuregui"}	{"en": "Jáuregui", "es": "Jáuregui"}	VE0112	2	municipality	f	VE.VE01.VE0112
283	{"en": "Venezuela:Táchira:José María Vargas", "es": "Venezuela:Táchira:José María Vargas"}	{"en": "José María Vargas", "es": "José María Vargas"}	VE0113	2	municipality	f	VE.VE01.VE0113
284	{"en": "Venezuela:Táchira:Junín", "es": "Venezuela:Táchira:Junín"}	{"en": "Junín", "es": "Junín"}	VE0114	2	municipality	f	VE.VE01.VE0114
285	{"en": "Venezuela:Táchira:Libertad", "es": "Venezuela:Táchira:Libertad"}	{"en": "Libertad", "es": "Libertad"}	VE0115	2	municipality	f	VE.VE01.VE0115
286	{"en": "Venezuela:Táchira:Libertador", "es": "Venezuela:Táchira:Libertador"}	{"en": "Libertador", "es": "Libertador"}	VE0116	2	municipality	f	VE.VE01.VE0116
287	{"en": "Venezuela:Táchira:Lobatera", "es": "Venezuela:Táchira:Lobatera"}	{"en": "Lobatera", "es": "Lobatera"}	VE0117	2	municipality	f	VE.VE01.VE0117
288	{"en": "Venezuela:Táchira:Michelena", "es": "Venezuela:Táchira:Michelena"}	{"en": "Michelena", "es": "Michelena"}	VE0118	2	municipality	f	VE.VE01.VE0118
289	{"en": "Venezuela:Táchira:Panamericano", "es": "Venezuela:Táchira:Panamericano"}	{"en": "Panamericano", "es": "Panamericano"}	VE0119	2	municipality	f	VE.VE01.VE0119
290	{"en": "Venezuela:Táchira:Pedro María Ureña", "es": "Venezuela:Táchira:Pedro María Ureña"}	{"en": "Pedro María Ureña", "es": "Pedro María Ureña"}	VE0120	2	municipality	f	VE.VE01.VE0120
291	{"en": "Venezuela:Táchira:Rafael Urdaneta", "es": "Venezuela:Táchira:Rafael Urdaneta"}	{"en": "Rafael Urdaneta", "es": "Rafael Urdaneta"}	VE0121	2	municipality	f	VE.VE01.VE0121
292	{"en": "Venezuela:Táchira:Samuel Darío Maldonado", "es": "Venezuela:Táchira:Samuel Darío Maldonado"}	{"en": "Samuel Darío Maldonado", "es": "Samuel Darío Maldonado"}	VE0122	2	municipality	f	VE.VE01.VE0122
293	{"en": "Venezuela:Táchira:San Cristóbal", "es": "Venezuela:Táchira:San Cristóbal"}	{"en": "San Cristóbal", "es": "San Cristóbal"}	VE0123	2	municipality	f	VE.VE01.VE0123
294	{"en": "Venezuela:Táchira:Seboruco", "es": "Venezuela:Táchira:Seboruco"}	{"en": "Seboruco", "es": "Seboruco"}	VE0124	2	municipality	f	VE.VE01.VE0124
295	{"en": "Venezuela:Táchira:Simón Rodríguez", "es": "Venezuela:Táchira:Simón Rodríguez"}	{"en": "Simón Rodríguez", "es": "Simón Rodríguez"}	VE0125	2	municipality	f	VE.VE01.VE0125
296	{"en": "Venezuela:Táchira:Sucre", "es": "Venezuela:Táchira:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE0126	2	municipality	f	VE.VE01.VE0126
297	{"en": "Venezuela:Táchira:Torbes", "es": "Venezuela:Táchira:Torbes"}	{"en": "Torbes", "es": "Torbes"}	VE0127	2	municipality	f	VE.VE01.VE0127
298	{"en": "Venezuela:Táchira:Uribante", "es": "Venezuela:Táchira:Uribante"}	{"en": "Uribante", "es": "Uribante"}	VE0128	2	municipality	f	VE.VE01.VE0128
299	{"en": "Venezuela:Táchira:San Judas Tadeo", "es": "Venezuela:Táchira:San Judas Tadeo"}	{"en": "San Judas Tadeo", "es": "San Judas Tadeo"}	VE0129	2	municipality	f	VE.VE01.VE0129
300	{"en": "Venezuela:Trujillo", "es": "Venezuela:Trujillo"}	{"en": "Trujillo", "es": "Trujillo"}	VE23	1	state	f	VE.VE23
301	{"en": "Venezuela:Trujillo:Andrés Bello", "es": "Venezuela:Trujillo:Andrés Bello"}	{"en": "Andrés Bello", "es": "Andrés Bello"}	VE2301	2	municipality	f	VE.VE23.VE2301
302	{"en": "Venezuela:Trujillo:Boconó", "es": "Venezuela:Trujillo:Boconó"}	{"en": "Boconó", "es": "Boconó"}	VE2302	2	municipality	f	VE.VE23.VE2302
303	{"en": "Venezuela:Trujillo:Bolívar", "es": "Venezuela:Trujillo:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE2303	2	municipality	f	VE.VE23.VE2303
304	{"en": "Venezuela:Trujillo:Candelaria", "es": "Venezuela:Trujillo:Candelaria"}	{"en": "Candelaria", "es": "Candelaria"}	VE2304	2	municipality	f	VE.VE23.VE2304
305	{"en": "Venezuela:Trujillo:Carache", "es": "Venezuela:Trujillo:Carache"}	{"en": "Carache", "es": "Carache"}	VE2305	2	municipality	f	VE.VE23.VE2305
306	{"en": "Venezuela:Trujillo:Escuque", "es": "Venezuela:Trujillo:Escuque"}	{"en": "Escuque", "es": "Escuque"}	VE2306	2	municipality	f	VE.VE23.VE2306
307	{"en": "Venezuela:Trujillo:José Felipe Márquez Cañizalez", "es": "Venezuela:Trujillo:José Felipe Márquez Cañizalez"}	{"en": "José Felipe Márquez Cañizalez", "es": "José Felipe Márquez Cañizalez"}	VE2307	2	municipality	f	VE.VE23.VE2307
308	{"en": "Venezuela:Trujillo:Juan Vicente Campos Elías", "es": "Venezuela:Trujillo:Juan Vicente Campos Elías"}	{"en": "Juan Vicente Campos Elías", "es": "Juan Vicente Campos Elías"}	VE2308	2	municipality	f	VE.VE23.VE2308
310	{"en": "Venezuela:Trujillo:Miranda", "es": "Venezuela:Trujillo:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE2310	2	municipality	f	VE.VE23.VE2310
311	{"en": "Venezuela:Trujillo:Monte Carmelo", "es": "Venezuela:Trujillo:Monte Carmelo"}	{"en": "Monte Carmelo", "es": "Monte Carmelo"}	VE2311	2	municipality	f	VE.VE23.VE2311
312	{"en": "Venezuela:Trujillo:Motatán", "es": "Venezuela:Trujillo:Motatán"}	{"en": "Motatán", "es": "Motatán"}	VE2312	2	municipality	f	VE.VE23.VE2312
313	{"en": "Venezuela:Trujillo:Pampán", "es": "Venezuela:Trujillo:Pampán"}	{"en": "Pampán", "es": "Pampán"}	VE2313	2	municipality	f	VE.VE23.VE2313
314	{"en": "Venezuela:Trujillo:Pampanito", "es": "Venezuela:Trujillo:Pampanito"}	{"en": "Pampanito", "es": "Pampanito"}	VE2314	2	municipality	f	VE.VE23.VE2314
315	{"en": "Venezuela:Trujillo:Rafael Rangel", "es": "Venezuela:Trujillo:Rafael Rangel"}	{"en": "Rafael Rangel", "es": "Rafael Rangel"}	VE2315	2	municipality	f	VE.VE23.VE2315
316	{"en": "Venezuela:Trujillo:San Rafael de Carvajal", "es": "Venezuela:Trujillo:San Rafael de Carvajal"}	{"en": "San Rafael de Carvajal", "es": "San Rafael de Carvajal"}	VE2316	2	municipality	f	VE.VE23.VE2316
317	{"en": "Venezuela:Trujillo:Sucre", "es": "Venezuela:Trujillo:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE2317	2	municipality	f	VE.VE23.VE2317
318	{"en": "Venezuela:Trujillo:Trujillo", "es": "Venezuela:Trujillo:Trujillo"}	{"en": "Trujillo", "es": "Trujillo"}	VE2318	2	municipality	f	VE.VE23.VE2318
319	{"en": "Venezuela:Trujillo:Urdaneta", "es": "Venezuela:Trujillo:Urdaneta"}	{"en": "Urdaneta", "es": "Urdaneta"}	VE2319	2	municipality	f	VE.VE23.VE2319
320	{"en": "Venezuela:Trujillo:Valera", "es": "Venezuela:Trujillo:Valera"}	{"en": "Valera", "es": "Valera"}	VE2320	2	municipality	f	VE.VE23.VE2320
321	{"en": "Venezuela:Yaracuy", "es": "Venezuela:Yaracuy"}	{"en": "Yaracuy", "es": "Yaracuy"}	VE24	1	state	f	VE.VE24
322	{"en": "Venezuela:Yaracuy:Arístides Bastidas", "es": "Venezuela:Yaracuy:Arístides Bastidas"}	{"en": "Arístides Bastidas", "es": "Arístides Bastidas"}	VE2401	2	municipality	f	VE.VE24.VE2401
323	{"en": "Venezuela:Yaracuy:Bolívar", "es": "Venezuela:Yaracuy:Bolívar"}	{"en": "Bolívar", "es": "Bolívar"}	VE2402	2	municipality	f	VE.VE24.VE2402
324	{"en": "Venezuela:Yaracuy:Bruzual", "es": "Venezuela:Yaracuy:Bruzual"}	{"en": "Bruzual", "es": "Bruzual"}	VE2403	2	municipality	f	VE.VE24.VE2403
325	{"en": "Venezuela:Yaracuy:Cocorote", "es": "Venezuela:Yaracuy:Cocorote"}	{"en": "Cocorote", "es": "Cocorote"}	VE2404	2	municipality	f	VE.VE24.VE2404
326	{"en": "Venezuela:Yaracuy:Independencia", "es": "Venezuela:Yaracuy:Independencia"}	{"en": "Independencia", "es": "Independencia"}	VE2405	2	municipality	f	VE.VE24.VE2405
327	{"en": "Venezuela:Yaracuy:José Antonio Páez", "es": "Venezuela:Yaracuy:José Antonio Páez"}	{"en": "José Antonio Páez", "es": "José Antonio Páez"}	VE2406	2	municipality	f	VE.VE24.VE2406
328	{"en": "Venezuela:Yaracuy:La Trinidad", "es": "Venezuela:Yaracuy:La Trinidad"}	{"en": "La Trinidad", "es": "La Trinidad"}	VE2407	2	municipality	f	VE.VE24.VE2407
329	{"en": "Venezuela:Yaracuy:Manuel Monge", "es": "Venezuela:Yaracuy:Manuel Monge"}	{"en": "Manuel Monge", "es": "Manuel Monge"}	VE2408	2	municipality	f	VE.VE24.VE2408
330	{"en": "Venezuela:Yaracuy:Nirgua", "es": "Venezuela:Yaracuy:Nirgua"}	{"en": "Nirgua", "es": "Nirgua"}	VE2409	2	municipality	f	VE.VE24.VE2409
331	{"en": "Venezuela:Yaracuy:Peña", "es": "Venezuela:Yaracuy:Peña"}	{"en": "Peña", "es": "Peña"}	VE2410	2	municipality	f	VE.VE24.VE2410
332	{"en": "Venezuela:Yaracuy:San Felipe", "es": "Venezuela:Yaracuy:San Felipe"}	{"en": "San Felipe", "es": "San Felipe"}	VE2411	2	municipality	f	VE.VE24.VE2411
333	{"en": "Venezuela:Yaracuy:Sucre", "es": "Venezuela:Yaracuy:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE2412	2	municipality	f	VE.VE24.VE2412
334	{"en": "Venezuela:Yaracuy:Urachiche", "es": "Venezuela:Yaracuy:Urachiche"}	{"en": "Urachiche", "es": "Urachiche"}	VE2413	2	municipality	f	VE.VE24.VE2413
335	{"en": "Venezuela:Yaracuy:Veroes", "es": "Venezuela:Yaracuy:Veroes"}	{"en": "Veroes", "es": "Veroes"}	VE2414	2	municipality	f	VE.VE24.VE2414
336	{"en": "Venezuela:Zulia", "es": "Venezuela:Zulia"}	{"en": "Zulia", "es": "Zulia"}	VE02	1	state	f	VE.VE02
337	{"en": "Venezuela:Zulia:Almirante Padilla", "es": "Venezuela:Zulia:Almirante Padilla"}	{"en": "Almirante Padilla", "es": "Almirante Padilla"}	VE0201	2	municipality	f	VE.VE02.VE0201
338	{"en": "Venezuela:Zulia:Baralt", "es": "Venezuela:Zulia:Baralt"}	{"en": "Baralt", "es": "Baralt"}	VE0202	2	municipality	f	VE.VE02.VE0202
339	{"en": "Venezuela:Zulia:Cabimas", "es": "Venezuela:Zulia:Cabimas"}	{"en": "Cabimas", "es": "Cabimas"}	VE0203	2	municipality	f	VE.VE02.VE0203
340	{"en": "Venezuela:Zulia:Catatumbo", "es": "Venezuela:Zulia:Catatumbo"}	{"en": "Catatumbo", "es": "Catatumbo"}	VE0204	2	municipality	f	VE.VE02.VE0204
341	{"en": "Venezuela:Zulia:Colón", "es": "Venezuela:Zulia:Colón"}	{"en": "Colón", "es": "Colón"}	VE0205	2	municipality	f	VE.VE02.VE0205
342	{"en": "Venezuela:Zulia:Francisco Javier Pulgar", "es": "Venezuela:Zulia:Francisco Javier Pulgar"}	{"en": "Francisco Javier Pulgar", "es": "Francisco Javier Pulgar"}	VE0206	2	municipality	f	VE.VE02.VE0206
343	{"en": "Venezuela:Zulia:Páez", "es": "Venezuela:Zulia:Páez"}	{"en": "Páez", "es": "Páez"}	VE0207	2	municipality	f	VE.VE02.VE0207
344	{"en": "Venezuela:Zulia:Jesús Enrique Lossada", "es": "Venezuela:Zulia:Jesús Enrique Lossada"}	{"en": "Jesús Enrique Lossada", "es": "Jesús Enrique Lossada"}	VE0208	2	municipality	f	VE.VE02.VE0208
345	{"en": "Venezuela:Zulia:Jesús María Semprún", "es": "Venezuela:Zulia:Jesús María Semprún"}	{"en": "Jesús María Semprún", "es": "Jesús María Semprún"}	VE0209	2	municipality	f	VE.VE02.VE0209
346	{"en": "Venezuela:Zulia:La Cañada de Urdaneta", "es": "Venezuela:Zulia:La Cañada de Urdaneta"}	{"en": "La Cañada de Urdaneta", "es": "La Cañada de Urdaneta"}	VE0210	2	municipality	f	VE.VE02.VE0210
347	{"en": "Venezuela:Zulia:Lagunillas", "es": "Venezuela:Zulia:Lagunillas"}	{"en": "Lagunillas", "es": "Lagunillas"}	VE0211	2	municipality	f	VE.VE02.VE0211
348	{"en": "Venezuela:Zulia:Machiques de Perijá", "es": "Venezuela:Zulia:Machiques de Perijá"}	{"en": "Machiques de Perijá", "es": "Machiques de Perijá"}	VE0212	2	municipality	f	VE.VE02.VE0212
349	{"en": "Venezuela:Zulia:Mara", "es": "Venezuela:Zulia:Mara"}	{"en": "Mara", "es": "Mara"}	VE0213	2	municipality	f	VE.VE02.VE0213
350	{"en": "Venezuela:Zulia:Maracaibo", "es": "Venezuela:Zulia:Maracaibo"}	{"en": "Maracaibo", "es": "Maracaibo"}	VE0214	2	municipality	f	VE.VE02.VE0214
351	{"en": "Venezuela:Zulia:Miranda", "es": "Venezuela:Zulia:Miranda"}	{"en": "Miranda", "es": "Miranda"}	VE0215	2	municipality	f	VE.VE02.VE0215
352	{"en": "Venezuela:Zulia:Rosario de Perijá", "es": "Venezuela:Zulia:Rosario de Perijá"}	{"en": "Rosario de Perijá", "es": "Rosario de Perijá"}	VE0216	2	municipality	f	VE.VE02.VE0216
353	{"en": "Venezuela:Zulia:San Francisco", "es": "Venezuela:Zulia:San Francisco"}	{"en": "San Francisco", "es": "San Francisco"}	VE0217	2	municipality	f	VE.VE02.VE0217
354	{"en": "Venezuela:Zulia:Santa Rita", "es": "Venezuela:Zulia:Santa Rita"}	{"en": "Santa Rita", "es": "Santa Rita"}	VE0218	2	municipality	f	VE.VE02.VE0218
355	{"en": "Venezuela:Zulia:Simón Bolívar", "es": "Venezuela:Zulia:Simón Bolívar"}	{"en": "Simón Bolívar", "es": "Simón Bolívar"}	VE0219	2	municipality	f	VE.VE02.VE0219
356	{"en": "Venezuela:Zulia:Sucre", "es": "Venezuela:Zulia:Sucre"}	{"en": "Sucre", "es": "Sucre"}	VE0220	2	municipality	f	VE.VE02.VE0220
357	{"en": "Venezuela:Zulia:Valmore Rodríguez", "es": "Venezuela:Zulia:Valmore Rodríguez"}	{"en": "Valmore Rodríguez", "es": "Valmore Rodríguez"}	VE0221	2	municipality	f	VE.VE02.VE0221
358	{"en": "Venezuela:La Guaira", "es": "Venezuela:La Guaira"}	{"en": "La Guaira", "es": "La Guaira"}	VE15	1	state	f	VE.VE15
359	{"en": "Venezuela:La Guaira:Vargas", "es": "Venezuela:La Guaira:Vargas"}	{"en": "Vargas", "es": "Vargas"}	VE1501	2	municipality	f	VE.VE15.VE1501
360	{"en": "Venezuela:Delta Amacuro", "es": "Venezuela:Delta Amacuro"}	{"en": "Delta Amacuro", "es": "Delta Amacuro"}	VE11	1	state	f	VE.VE11
361	{"en": "Venezuela:Delta Amacuro:Antonio Díaz", "es": "Venezuela:Delta Amacuro:Antonio Díaz"}	{"en": "Antonio Díaz", "es": "Antonio Díaz"}	VE1101	2	municipality	f	VE.VE11.VE1101
362	{"en": "Venezuela:Delta Amacuro:Casacoima", "es": "Venezuela:Delta Amacuro:Casacoima"}	{"en": "Casacoima", "es": "Casacoima"}	VE1102	2	municipality	f	VE.VE11.VE1102
363	{"en": "Venezuela:Delta Amacuro:Pedernales", "es": "Venezuela:Delta Amacuro:Pedernales"}	{"en": "Pedernales", "es": "Pedernales"}	VE1103	2	municipality	f	VE.VE11.VE1103
364	{"en": "Venezuela:Delta Amacuro:Tucupita", "es": "Venezuela:Delta Amacuro:Tucupita"}	{"en": "Tucupita", "es": "Tucupita"}	VE1104	2	municipality	f	VE.VE11.VE1104
365	{"en": "Venezuela:Amazonas", "es": "Venezuela:Amazonas"}	{"en": "Amazonas", "es": "Amazonas"}	VE03	1	state	f	VE.VE03
366	{"en": "Venezuela:Amazonas:Alto Orinoco", "es": "Venezuela:Amazonas:Alto Orinoco"}	{"en": "Alto Orinoco", "es": "Alto Orinoco"}	VE0301	2	municipality	f	VE.VE03.VE0301
367	{"en": "Venezuela:Amazonas:Atabapo", "es": "Venezuela:Amazonas:Atabapo"}	{"en": "Atabapo", "es": "Atabapo"}	VE0302	2	municipality	f	VE.VE03.VE0302
368	{"en": "Venezuela:Amazonas:Atures", "es": "Venezuela:Amazonas:Atures"}	{"en": "Atures", "es": "Atures"}	VE0303	2	municipality	f	VE.VE03.VE0303
369	{"en": "Venezuela:Amazonas:Autana", "es": "Venezuela:Amazonas:Autana"}	{"en": "Autana", "es": "Autana"}	VE0304	2	municipality	f	VE.VE03.VE0304
370	{"en": "Venezuela:Amazonas:Manapiare", "es": "Venezuela:Amazonas:Manapiare"}	{"en": "Manapiare", "es": "Manapiare"}	VE0305	2	municipality	f	VE.VE03.VE0305
371	{"en": "Venezuela:Amazonas:Maroa", "es": "Venezuela:Amazonas:Maroa"}	{"en": "Maroa", "es": "Maroa"}	VE0306	2	municipality	f	VE.VE03.VE0306
372	{"en": "Venezuela:Amazonas:Río Negro", "es": "Venezuela:Amazonas:Río Negro"}	{"en": "Río Negro", "es": "Río Negro"}	VE0307	2	municipality	f	VE.VE03.VE0307
\.


--
-- Data for Name: lookups; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.lookups (id, unique_id, name_i18n, lookup_values_i18n, locked, created_at, updated_at) FROM stdin;
197	lookup-form-group-cp-case	{"en": "Form Groups - CP Case", "es": "Grupos de formularios - Casos CP"}	[{"id": "record_information", "display_text": {"en": "Record Information", "es": "Información del registro"}}, {"id": "approvals", "display_text": {"en": "Approvals", "es": "Aprobaciones"}}, {"id": "case_conference_details", "display_text": {"en": "Case Conference Details", "es": "Detalles de la conferencia del caso"}}, {"id": "identification_registration", "display_text": {"en": "Identification / Registration", "es": "Identificación y registro"}}, {"id": "data_confidentiality", "display_text": {"en": "Data Confidentiality", "es": "Confidencialidad de los datos"}}, {"id": "assessment", "display_text": {"en": "Assessment", "es": "Evaluación"}}, {"id": "family_partner_details", "display_text": {"en": "Family / Partner Details", "es": "Detalles de la familia o pareja"}}, {"id": "case_plan", "display_text": {"en": "Case Plan", "es": "Plan del caso"}}, {"id": "services_follow_up", "display_text": {"en": "Services / Follow Up", "es": "Servicios y seguimiento"}}, {"id": "closure", "display_text": {"en": "Closure", "es": "Cierre"}}, {"id": "tracing", "display_text": {"en": "Tracing", "es": "Localización"}}, {"id": "bia_form", "display_text": {"en": "BIA Form", "es": "Formulario BIA"}}, {"id": "photos_audio", "display_text": {"en": "Photos and Audio", "es": "Fotos y audio"}}, {"id": "other_documents", "display_text": {"en": "Other Documents", "es": "Otros documentos"}}, {"id": "referrals_transfers", "display_text": {"en": "Referrals and Transfers", "es": "Derivaciones y transferencias"}}, {"id": "notes", "display_text": {"en": "Notes", "es": "Notas"}}, {"id": "documents", "display_text": {"en": "Documents", "es": "Documentos"}}, {"id": "other_reportable_fields", "display_text": {"en": "Other Reportable Fields", "es": "Otros campos de reporte"}}]	f	2026-06-01 20:20:29.300795	2026-06-01 20:47:08.693537
178	lookup-gender	{"en": "gender", "es": "Sexo"}	[{"id": "male", "display_text": {"en": "Male", "es": "Masculino"}}, {"id": "female", "display_text": {"en": "Female", "es": "Femenino"}}]	f	2026-06-01 20:20:29.171684	2026-06-01 20:47:08.717189
160	lookup-risk-level	{"en": "risk_level", "es": "Nivel de riesgo"}	[{"id": "high", "display_text": {"en": "High", "es": "Alto"}}, {"id": "medium", "display_text": {"en": "Medium", "es": "Medio"}}, {"id": "low", "display_text": {"en": "Low", "es": "Bajo"}}]	f	2026-06-01 20:20:29.029499	2026-06-01 20:47:08.753848
177	lookup-approval-status	{"en": "Approval Status", "es": "Estado de aprobación"}	[{"id": "requested", "display_text": {"en": "Requested", "es": "Solicitado"}}, {"id": "pending", "display_text": {"en": "Pending", "es": "Pendiente"}}, {"id": "approved", "display_text": {"en": "Approved", "es": "Aprobado"}}, {"id": "rejected", "display_text": {"en": "Rejected", "es": "Rechazado"}}]	f	2026-06-01 20:20:29.16492	2026-06-01 20:47:08.765149
181	lookup-workflow	{"en": "Workflow", "es": "Flujo de trabajo"}	[{"id": "new", "display_text": {"en": "New case", "es": "Caso nuevo"}}, {"id": "closed", "display_text": {"en": "Case closed", "es": "Caso cerrado"}}, {"id": "reopened", "display_text": {"en": "Case reopened", "es": "Caso reabierto"}}, {"id": "service_provision", "display_text": {"en": "Service provision", "es": "Prestación de servicios"}}, {"id": "services_implemented", "display_text": {"en": "All response services implemented", "es": "Todos los servicios de respuesta implementados"}}, {"id": "case_plan", "display_text": {"en": "Case Plan", "es": "Plan del caso"}}]	t	2026-06-01 20:20:29.194137	2026-06-01 20:47:08.775
198	lookup-form-group-cp-tracing-request	{"en": "Form Groups - CP Tracing Request"}	[{"id": "record_owner", "display_text": {"en": "Record Owner", "es": "Responsable del registro"}}, {"id": "inquirer", "display_text": {"en": "Inquirer", "es": "Solicitante"}}, {"id": "tracing_request", "display_text": {"en": "Tracing Request", "es": "Solicitud de localización"}}, {"id": "photos_audio", "display_text": {"en": "Photos and Audio", "es": "Fotos y audio"}}, {"id": "other_reportable_fields", "display_text": {"en": "Other Reportable Fields", "es": "Otros campos de reporte"}}]	f	2026-06-01 20:20:29.306935	2026-06-04 14:30:47.094341
173	lookup-care-arrangements-type	{"en": "Care Arrangements Type", "es": "Tipo de acuerdo de cuidado"}	[{"id": "parent_s", "display_text": {"en": "Parent(s)", "es": "Padres"}}, {"id": "step_parent", "display_text": {"en": "Step parent", "es": "Padrastro o madrastra"}}, {"id": "customary_caregiver_s", "display_text": {"en": "Customary caregiver(s)", "es": "Cuidadores habituales"}}, {"id": "adult_sibling", "display_text": {"en": "Adult sibling", "es": "Hermano adulto"}}, {"id": "kinship_care_extended_family", "display_text": {"en": "Kinship care / extended family", "es": "Cuidado por familiares o familia extendida"}}, {"id": "foster_care", "display_text": {"en": "Foster care", "es": "Acogimiento familiar"}}, {"id": "residential_care", "display_text": {"en": "Residential care", "es": "Cuidado residencial"}}, {"id": "kafala", "display_text": {"en": "Kafala", "es": "Kafala"}}, {"id": "independent_living", "display_text": {"en": "Independent living", "es": "Vida independiente"}}, {"id": "child_headed_household", "display_text": {"en": "Child-headed household", "es": "Hogar encabezado por un niño"}}, {"id": "unrelated_adult", "display_text": {"en": "Unrelated adult", "es": "Adulto sin parentesco"}}, {"id": "no_care_arrangement", "display_text": {"en": "No care arrangement", "es": "Sin acuerdo de cuidado"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}]	f	2026-06-01 20:20:29.135989	2026-06-01 20:50:18.151949
157	lookup-displacement-status	{"en": "Displacement Status", "es": "Estado de desplazamiento"}	[{"id": "resident", "display_text": {"en": "Resident", "es": "Residente"}}, {"id": "idp", "display_text": {"en": "IDP", "es": "Persona desplazada internamente"}}, {"id": "refugee", "display_text": {"en": "Refugee", "es": "Refugiado"}}, {"id": "stateless_person", "display_text": {"en": "Stateless Person", "es": "Persona apátrida"}}, {"id": "returnee", "display_text": {"en": "Returnee", "es": "Retornado"}}, {"id": "foreign_national", "display_text": {"en": "Foreign National", "es": "Extranjero"}}, {"id": "asylum_seeker", "display_text": {"en": "Asylum Seeker", "es": "Solicitante de asilo"}}]	f	2026-06-01 20:20:29.003664	2026-06-01 20:50:18.192866
195	lookup-family-relationship	{"en": "Family Relationship", "es": "Relación familiar"}	[{"id": "mother", "display_text": {"en": "Mother", "es": "Madre"}}, {"id": "father", "display_text": {"en": "Father", "es": "Padre"}}, {"id": "aunt", "display_text": {"en": "Aunt", "es": "Tía"}}, {"id": "uncle", "display_text": {"en": "Uncle", "es": "Tío"}}, {"id": "grandmother", "display_text": {"en": "Grandmother", "es": "Abuela"}}, {"id": "grandfather", "display_text": {"en": "Grandfather", "es": "Abuelo"}}, {"id": "brother", "display_text": {"en": "Brother", "es": "Hermano"}}, {"id": "sister", "display_text": {"en": "Sister", "es": "Hermana"}}, {"id": "husband", "display_text": {"en": "Husband", "es": "Esposo"}}, {"id": "wife", "display_text": {"en": "Wife", "es": "Esposa"}}, {"id": "partner", "display_text": {"en": "Partner", "es": "Pareja"}}, {"id": "other_family", "display_text": {"en": "Other Family", "es": "Otro familiar"}}, {"id": "other_nonfamily", "display_text": {"en": "Other Nonfamily", "es": "Otra persona sin parentesco"}}]	f	2026-06-01 20:20:29.288536	2026-06-01 20:50:18.205165
169	lookup-yes-no	{"en": "Yes or No", "es": "Sí o no"}	[{"id": "true", "display_text": {"en": "Yes", "es": "Sí"}}, {"id": "false", "display_text": {"en": "No", "es": "No"}}]	t	2026-06-01 20:20:29.105368	2026-06-01 20:47:08.738274
175	lookup-approval-type	{"en": "Approval Type", "es": "Tipo de aprobación"}	[{"id": "service_provision", "display_text": {"en": "Service Provision", "es": "Prestación de servicios"}}]	t	2026-06-01 20:20:29.150456	2026-06-01 20:50:18.138515
164	lookup-separation-cause	{"en": "Separation Cause", "es": "Causa de separación"}	[{"id": "conflict", "display_text": {"en": "Conflict", "es": "Conflicto"}}, {"id": "death", "display_text": {"en": "Death", "es": "Fallecimiento"}}, {"id": "family_abuse_violence_exploitation", "display_text": {"en": "Family abuse/violence/exploitation", "es": "Abuso, violencia o explotación familiar"}}, {"id": "lack_of_access_to_services_support", "display_text": {"en": "Lack of access to services/support", "es": "Falta de acceso a servicios o apoyo"}}, {"id": "caafag", "display_text": {"en": "CAAFAG", "es": "Niño asociado con fuerzas o grupos armados"}}, {"id": "sickness_of_family_member", "display_text": {"en": "Sickness of family member", "es": "Enfermedad de un familiar"}}, {"id": "entrusted_into_the_care_of_an_individual", "display_text": {"en": "Entrusted into the care of an individual", "es": "Confiado al cuidado de otra persona"}}, {"id": "arrest_and_detention", "display_text": {"en": "Arrest and detention", "es": "Arresto y detención"}}, {"id": "abandonment", "display_text": {"en": "Abandonment", "es": "Abandono"}}, {"id": "repatriation", "display_text": {"en": "Repatriation", "es": "Repatriación"}}, {"id": "population_movement", "display_text": {"en": "Population movement", "es": "Movimiento de población"}}, {"id": "migration", "display_text": {"en": "Migration", "es": "Migración"}}, {"id": "poverty", "display_text": {"en": "Poverty", "es": "Pobreza"}}, {"id": "natural_disaster", "display_text": {"en": "Natural disaster", "es": "Desastre natural"}}, {"id": "divorce_remarriage", "display_text": {"en": "Divorce/remarriage", "es": "Divorcio o nuevo matrimonio"}}, {"id": "other_please_specify", "display_text": {"en": "Other (please specify)", "es": "Otro, especifique"}}]	f	2026-06-01 20:20:29.061714	2026-06-01 20:50:18.25158
161	lookup-cp-violence-type	{"en": "CP Violence Type", "es": "Tipo de violencia de protección infantil"}	[{"id": "rape", "display_text": {"en": "Rape", "es": "Violación"}}, {"id": "sexual_assault", "display_text": {"en": "Sexual Assault", "es": "Agresión sexual"}}, {"id": "physical_assault", "display_text": {"en": "Physical Assault", "es": "Agresión física"}}, {"id": "forced_marriage", "display_text": {"en": "Forced Marriage", "es": "Matrimonio forzado"}}, {"id": "denial_of_resources_opportunities_or_services", "display_text": {"en": "Denial of Resources, Opportunities or Services", "es": "Negación de recursos, oportunidades o servicios"}}, {"id": "psychological_emotional_abuse", "display_text": {"en": "Psychological / Emotional Abuse", "es": "Abuso psicológico o emocional"}}, {"id": "non-gbv", "display_text": {"en": "Non-GBV", "es": "No relacionado con violencia de género"}}]	f	2026-06-01 20:20:29.037588	2026-06-01 20:52:42.830324
186	lookup-perpetrator-relationship	{"en": "Perpetrator Relationship", "es": "Relación con el responsable"}	[{"id": "intimate_partner_former_partner", "display_text": {"en": "Intimate Partner / Former Partner", "es": "Pareja íntima o expareja"}}, {"id": "primary_caregiver", "display_text": {"en": "Primary Caregiver", "es": "Cuidador principal"}}, {"id": "family_other_than_spouse_or_caregiver", "display_text": {"en": "Family other than spouse or caregiver", "es": "Familiar distinto del cónyuge o cuidador"}}, {"id": "supervisor_employer", "display_text": {"en": "Supervisor / Employer", "es": "Supervisor o empleador"}}, {"id": "schoolmate", "display_text": {"en": "Schoolmate", "es": "Compañero de escuela"}}, {"id": "teacher_school_official", "display_text": {"en": "Teacher / School Official", "es": "Docente o personal escolar"}}, {"id": "service_provider", "display_text": {"en": "Service Provider", "es": "Proveedor del servicio"}}, {"id": "cotenant_housemate", "display_text": {"en": "Cotenant / Housemate", "es": "Inquilino o compañero de vivienda"}}, {"id": "family_friend_neighbor", "display_text": {"en": "Family Friend/Neighbor", "es": "Amigo de la familia o vecino"}}, {"id": "other_refugee_idp_returnee", "display_text": {"en": "Other refugee / IDP / Returnee", "es": "Otro refugiado, desplazado o retornado"}}, {"id": "other_resident_community_member", "display_text": {"en": "Other resident community member", "es": "Otro residente o integrante de la comunidad"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}, {"id": "no_relation", "display_text": {"en": "No relation", "es": "Sin relación"}}, {"id": "unknown", "display_text": {"en": "Unknown", "es": "Desconocido"}}]	f	2026-06-01 20:20:29.229647	2026-06-01 20:52:42.900232
206	lookup-special-needs	{"en": "Special Needs", "es": "Necesidades especiales"}	[{"id": "physical_muscular_dystrophy", "display_text": {"en": "Physical: Muscular dystrophy", "es": "Física: distrofia muscular"}}, {"id": "physical_multiple_sclerosis", "display_text": {"en": "Physical: Multiple sclerosis", "es": "Física: esclerosis múltiple"}}, {"id": "physical_chronic_asthma", "display_text": {"en": "Physical: Chronic asthma", "es": "Física: asma crónica"}}, {"id": "physical_epilepsy", "display_text": {"en": "Physical: Epilepsy", "es": "Física: epilepsia"}}, {"id": "physical_brain_or_spinal_cord_injuries", "display_text": {"en": "Physical: Brain or spinal cord injuries", "es": "Física: lesiones cerebrales o de médula espinal"}}, {"id": "physical_cerebral_palsy", "display_text": {"en": "Physical: Cerebral palsy ", "es": "Física: parálisis cerebral"}}, {"id": "developmental_down_syndrome", "display_text": {"en": "Developmental: Down syndrome", "es": "Desarrollo: síndrome de Down"}}, {"id": "developmental_autism", "display_text": {"en": "Developmental: Autism", "es": "Desarrollo: autismo"}}, {"id": "developmental_specific_learning_difficulty", "display_text": {"en": "Developmental: Specific learning difficulty", "es": "Desarrollo: dificultad específica de aprendizaje"}}, {"id": "developmental_intellectual_disability_id", "display_text": {"en": "Developmental: Intellectual disability (ID)", "es": "Desarrollo: discapacidad intelectual"}}, {"id": "developmental_attention_deficit_hyperactivity_disorder_adhd", "display_text": {"en": "Developmental: Attention deficit hyperactivity disorder (ADHD)", "es": "Desarrollo: trastorno por déficit de atención e hiperactividad"}}, {"id": "behavioral_emotional_extremely_challenging_behavior", "display_text": {"en": "Behavioral/Emotional: Extremely challenging behavior", "es": "Conductual o emocional: conducta extremadamente desafiante"}}, {"id": "behavioral_emotional_aggression_or_self_injurious_behavior_acting_out_fighting", "display_text": {"en": "Behavioral/Emotional: Aggression or self-injurious behavior (acting out, fighting)", "es": "Conductual o emocional: agresión o conducta autolesiva"}}, {"id": "behavioral_emotional_withdrawal_not_interacting_socially_with_others_excessive_fear_or_anxiety_oppositional_behavior", "display_text": {"en": "Behavioral/Emotional: Withdrawal (not interacting socially with others, excessive fear or anxiety), oppositional behavior", "es": "Conductual o emocional: aislamiento, temor, ansiedad o conducta oposicionista"}}, {"id": "sensory_impaired_blind", "display_text": {"en": "Sensory Impaired: Blind", "es": "Sensorial: ceguera"}}, {"id": "sensory_impaired_visually_impaired", "display_text": {"en": "Sensory Impaired: Visually impaired", "es": "Sensorial: discapacidad visual"}}, {"id": "sensory_impaired_deaf", "display_text": {"en": "Sensory Impaired: Deaf", "es": "Sensorial: sordera"}}, {"id": "sensory_impaired_limited_hearing", "display_text": {"en": "Sensory Impaired: Limited hearing", "es": "Sensorial: audición limitada"}}]	f	2026-06-01 20:20:29.392638	2026-06-01 20:52:42.912859
166	lookup-followup-type	{"en": "Followup Type", "es": "Tipo de seguimiento"}	[{"id": "after_reunification", "display_text": {"en": "Follow up After Reunification", "es": "Seguimiento después de la reunificación"}}, {"id": "in_care", "display_text": {"en": "Follow up in Care", "es": "Seguimiento durante el cuidado"}}, {"id": "for_service", "display_text": {"en": "Follow up for Service", "es": "Seguimiento del servicio"}}, {"id": "for_assesment", "display_text": {"en": "Follow up for Assessment", "es": "Seguimiento de la evaluación"}}]	f	2026-06-01 20:20:29.077937	2026-06-01 20:50:18.216471
158	lookup-protection-status	{"en": "Protection Status", "es": "Estado de protección"}	[{"id": "unaccompanied", "display_text": {"en": "Unaccompanied", "es": "No acompañado"}}, {"id": "separated", "display_text": {"en": "Separated", "es": "Separado"}}]	f	2026-06-01 20:20:29.010371	2026-06-01 20:50:18.2269
174	lookup-caregiver-change-reason	{"en": "Caregiver Change Reason", "es": "Motivo del cambio de cuidador"}	[{"id": "abuse_exploitation", "display_text": {"en": "Abuse & Exploitation", "es": "Abuso o explotación"}}, {"id": "death_of_caregiver", "display_text": {"en": "Death of Caregiver", "es": "Fallecimiento del cuidador"}}, {"id": "Education", "display_text": {"en": "Education", "es": "Educación"}}, {"id": "ill_health_of_caregiver", "display_text": {"en": "Ill health of caregiver", "es": "Problemas de salud del cuidador"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}, {"id": "poverty", "display_text": {"en": "Poverty", "es": "Pobreza"}}, {"id": "relationship_breakdown", "display_text": {"en": "Relationship Breakdown", "es": "Ruptura de la relación"}}]	f	2026-06-01 20:20:29.14375	2026-06-01 20:50:18.163283
165	lookup-service-type	{"en": "Service Type", "es": "Tipo de servicio"}	[{"id": "safehouse_service", "display_text": {"en": "Safehouse Service", "es": "Servicio de refugio seguro"}}, {"id": "health_medical_service", "display_text": {"en": "Health/Medical Service", "es": "Servicio médico o de salud"}}, {"id": "psychosocial_service", "display_text": {"en": "Psychosocial Service", "es": "Servicio psicosocial"}}, {"id": "police_other_service", "display_text": {"en": "Police/Other Service", "es": "Policía u otro servicio"}}, {"id": "legal_assistance_service", "display_text": {"en": "Legal Assistance Service", "es": "Asistencia legal"}}, {"id": "livelihoods_service", "display_text": {"en": "Livelihoods Service", "es": "Medios de vida"}}, {"id": "child_protection_service", "display_text": {"en": "Child Protection Service", "es": "Protección infantil"}}, {"id": "family_mediation_service", "display_text": {"en": "Family Mediation Service", "es": "Mediación familiar"}}, {"id": "family_seunification_service", "display_text": {"en": "Family Reunification Service", "es": "Reunificación familiar"}}, {"id": "education_service", "display_text": {"en": "Education Service", "es": "Educación"}}, {"id": "nfi_clothes_shoes_service", "display_text": {"en": "NFI/Clothes/Shoes Service", "es": "Artículos no alimentarios, ropa o calzado"}}, {"id": "water_sanitation_service", "display_text": {"en": "Water/Sanitation Service", "es": "Agua y saneamiento"}}, {"id": "registration_service", "display_text": {"en": "Registration Service", "es": "Registro"}}, {"id": "food_service", "display_text": {"en": "Food Service", "es": "Alimentación"}}, {"id": "other_service", "display_text": {"en": "Other Service", "es": "Otro servicio"}}]	f	2026-06-01 20:20:29.070623	2026-06-01 20:50:18.326234
155	lookup-conference-case-status	{"en": "Conference Case Status"}	[{"id": "open", "display_text": {"en": "The case will remain open"}}, {"id": "closed", "display_text": {"en": "The case will be closed"}}, {"id": "transferred", "display_text": {"en": "The case will be transferred"}}, {"id": "other", "display_text": {"en": "Other"}}]	f	2026-06-01 20:20:28.990181	2026-06-01 20:20:28.990181
156	lookup-incident-status	{"en": "Incident Status"}	[{"id": "open", "display_text": {"en": "Open"}}, {"id": "closed", "display_text": {"en": "Closed"}}, {"id": "duplicate", "display_text": {"en": "Duplicate"}}]	f	2026-06-01 20:20:28.996511	2026-06-01 20:20:28.996511
159	lookup-verification-status	{"en": "Verification Status"}	[{"id": "verified", "display_text": {"en": "Verified"}}, {"id": "unverified", "display_text": {"en": "Unverified"}}, {"id": "pending_verification", "display_text": {"en": "Pending Verification"}}, {"id": "falsely_attributed", "display_text": {"en": "Falsely Attributed"}}, {"id": "rejected", "display_text": {"en": "Rejected"}}]	f	2026-06-01 20:20:29.017862	2026-06-01 20:20:29.017862
162	lookup-armed-force-group-type	{"en": "Armed Force Group Type"}	[{"id": "national_army", "display_text": {"en": "National Army"}}, {"id": "security_forces", "display_text": {"en": "Security Forces"}}, {"id": "international_forces", "display_text": {"en": "International Forces"}}, {"id": "police_forces", "display_text": {"en": "Police Forces"}}, {"id": "para-military_forces", "display_text": {"en": "Para-Military Forces"}}, {"id": "unknown", "display_text": {"en": "Unknown"}}, {"id": "other", "display_text": {"en": "Other"}}]	f	2026-06-01 20:20:29.047545	2026-06-01 20:20:29.047545
163	lookup-armed-force-group-name	{"en": "Armed Force Group Name"}	[{"id": "armed_force_or_group_1", "display_text": {"en": "Armed Force or Group 1"}}, {"id": "armed_force_or_group_2", "display_text": {"en": "Armed Force or Group 2"}}, {"id": "armed_force_or_group_3", "display_text": {"en": "Armed Force or Group 3"}}, {"id": "other_please_specify", "display_text": {"en": "Other, please specify"}}]	f	2026-06-01 20:20:29.054483	2026-06-01 20:20:29.054483
184	lookup-marital-status	{"en": "Marital Status", "es": "Estado civil"}	[{"id": "single", "display_text": {"en": "Single", "es": "Soltero"}}, {"id": "married_cohabitating", "display_text": {"en": "Married/Cohabitating", "es": "Casado o en convivencia"}}, {"id": "divorced_separated", "display_text": {"en": "Divorced/Separated", "es": "Divorciado o separado"}}, {"id": "widowed", "display_text": {"en": "Widowed", "es": "Viudo"}}]	f	2026-06-01 20:20:29.214682	2026-06-01 20:47:08.727213
182	lookup-service-implemented	{"en": "Service Implemented", "es": "Servicio implementado"}	[{"id": "not_implemented", "display_text": {"en": "Not Implemented", "es": "No implementado"}}, {"id": "implemented", "display_text": {"en": "Implemented", "es": "Implementado"}}]	t	2026-06-01 20:20:29.200984	2026-06-01 20:50:18.263454
183	lookup-service-response-type	{"en": "Service Response Type", "es": "Tipo de respuesta del servicio"}	[{"id": "care_plan", "display_text": {"en": "Care plan", "es": "Plan de cuidado"}}, {"id": "action_plan", "display_text": {"en": "Action plan", "es": "Plan de acción"}}, {"id": "service_provision", "display_text": {"en": "Service provision", "es": "Prestación de servicios"}}]	t	2026-06-01 20:20:29.207891	2026-06-01 20:50:18.282689
151	lookup-ethnicity	{"en": "Ethnicity", "es": "Etnia"}	[{"id": "ethnicity1", "display_text": {"en": "Ethnicity1", "es": "Etnia1"}}, {"id": "ethnicity2", "display_text": {"en": "Ethnicity2", "es": "Etnia2"}}, {"id": "ethnicity3", "display_text": {"en": "Ethnicity3", "es": "Etnia3"}}, {"id": "ethnicity4", "display_text": {"en": "Ethnicity4", "es": "Etnia4"}}, {"id": "ethnicity5", "display_text": {"en": "Ethnicity5", "es": "Etnia5"}}, {"id": "ethnicity6", "display_text": {"en": "Ethnicity6", "es": "Etnia6"}}, {"id": "ethnicity7", "display_text": {"en": "Ethnicity7", "es": "Etnia7"}}, {"id": "ethnicity8", "display_text": {"en": "Ethnicity8", "es": "Etnia8"}}, {"id": "ethnicity9", "display_text": {"en": "Ethnicity9", "es": "Etnia9"}}, {"id": "ethnicity10", "display_text": {"en": "Ethnicity10", "es": "Etnia10"}}]	f	2026-06-01 20:20:28.95744	2026-06-01 20:52:42.92593
154	lookup-case-status	{"en": "Case Status", "es": "Estado del caso"}	[{"id": "open", "display_text": {"en": "Open", "es": "Abierto"}}, {"id": "closed", "display_text": {"en": "Closed", "es": "Cerrado"}}, {"id": "transferred", "display_text": {"en": "Transferred", "es": "Transferido"}}, {"id": "duplicate", "display_text": {"en": "Duplicate", "es": "Duplicado"}}]	f	2026-06-01 20:20:28.982335	2026-06-01 20:47:08.706897
202	lookup-agency-office	{"en": "Agency Office"}	[{"id": "agency_office_1", "display_text": {"en": "Agency Office 1"}}, {"id": "agency_office_2", "display_text": {"en": "Agency Office 2"}}, {"id": "agency_office_3", "display_text": {"en": "Agency Office 3"}}, {"id": "agency_office_4", "display_text": {"en": "Agency Office 4"}}, {"id": "agency_office_5", "display_text": {"en": "Agency Office 5"}}]	t	2026-06-01 20:20:29.330633	2026-06-01 20:20:29.330633
148	lookup-location-type	{"en": "Location Type"}	[{"id": "country", "display_text": {"en": "Country"}}, {"id": "region", "display_text": {"en": "Region"}}, {"id": "province", "display_text": {"en": "Province"}}, {"id": "district", "display_text": {"en": "District"}}, {"id": "governorate", "display_text": {"en": "Governorate"}}, {"id": "chiefdom", "display_text": {"en": "Chiefdom"}}, {"id": "state", "display_text": {"en": "State"}}, {"id": "city", "display_text": {"en": "City"}}, {"id": "county", "display_text": {"en": "County"}}, {"id": "camp", "display_text": {"en": "Camp"}}, {"id": "site", "display_text": {"en": "Site"}}, {"id": "village", "display_text": {"en": "Village"}}, {"id": "zone", "display_text": {"en": "Zone"}}, {"id": "sub_district", "display_text": {"en": "Sub District"}}, {"id": "locality", "display_text": {"en": "Locality"}}, {"id": "prefecture", "display_text": {"en": "Prefecture"}}, {"id": "sub-prefecture", "display_text": {"en": "Sub-Prefecture"}}, {"id": "commune", "display_text": {"en": "Commune"}}, {"id": "payam", "display_text": {"en": "Payam"}}, {"id": "departement_fr", "display_text": {"en": "Département"}}, {"id": "region_fr", "display_text": {"en": "Région"}}, {"id": "wilaya", "display_text": {"en": "Wilaya"}}, {"id": "division_fr", "display_text": {"en": "Division"}}, {"id": "moughataa", "display_text": {"en": "Moughataa"}}, {"id": "sub_division", "display_text": {"en": "Sub-division"}}, {"id": "other", "display_text": {"en": "Other"}}]	t	2026-06-01 20:20:28.917245	2026-06-01 20:20:28.917245
150	lookup-nationality	{"en": "Nationality"}	[{"id": "nationality1", "display_text": {"en": "Nationality1"}}, {"id": "nationality2", "display_text": {"en": "Nationality2"}}, {"id": "nationality3", "display_text": {"en": "Nationality3"}}, {"id": "nationality4", "display_text": {"en": "Nationality4"}}, {"id": "nationality5", "display_text": {"en": "Nationality5"}}, {"id": "nationality6", "display_text": {"en": "Nationality6"}}, {"id": "nationality7", "display_text": {"en": "Nationality7"}}, {"id": "nationality8", "display_text": {"en": "Nationality8"}}, {"id": "nationality9", "display_text": {"en": "Nationality9"}}, {"id": "nationality10", "display_text": {"en": "Nationality10"}}]	f	2026-06-01 20:20:28.948582	2026-06-01 20:20:28.948582
152	lookup-language	{"en": "Language", "es": "Idioma"}	[{"id": "language1", "display_text": {"en": "Language1", "es": "Idioma1"}}, {"id": "language2", "display_text": {"en": "Language2", "es": "Idioma2"}}, {"id": "language3", "display_text": {"en": "Language3", "es": "Idioma3"}}, {"id": "language4", "display_text": {"en": "Language4", "es": "Idioma4"}}, {"id": "language5", "display_text": {"en": "Language5", "es": "Idioma5"}}, {"id": "language6", "display_text": {"en": "Language6", "es": "Idioma6"}}, {"id": "language7", "display_text": {"en": "Language7", "es": "Idioma7"}}, {"id": "language8", "display_text": {"en": "Language8", "es": "Idioma8"}}, {"id": "language9", "display_text": {"en": "Language9", "es": "Idioma9"}}, {"id": "language10", "display_text": {"en": "Language10", "es": "Idioma10"}}]	f	2026-06-01 20:20:28.966745	2026-06-01 20:52:42.93831
153	lookup-religion	{"en": "Religion", "es": "Religión"}	[{"id": "religion1", "display_text": {"en": "Religion1", "es": "Religión1"}}, {"id": "religion2", "display_text": {"en": "Religion2", "es": "Religión2"}}, {"id": "religion3", "display_text": {"en": "Religion3", "es": "Religión3"}}, {"id": "religion4", "display_text": {"en": "Religion4", "es": "Religión4"}}, {"id": "religion5", "display_text": {"en": "Religion5", "es": "Religión5"}}, {"id": "religion6", "display_text": {"en": "Religion6", "es": "Religión6"}}, {"id": "religion7", "display_text": {"en": "Religion7", "es": "Religión7"}}, {"id": "religion8", "display_text": {"en": "Religion8", "es": "Religión8"}}, {"id": "religion9", "display_text": {"en": "Religion9", "es": "Religión9"}}, {"id": "religion10", "display_text": {"en": "Religion10", "es": "Religión10"}}]	f	2026-06-01 20:20:28.974219	2026-06-01 20:52:42.949931
149	lookup-country	{"en": "Country", "es": "País"}	[{"id": "afghanistan", "display_text": {"en": "Afghanistan", "es": "Afganistán"}}, {"id": "albania", "display_text": {"en": "Albania", "es": "Albania"}}, {"id": "algeria", "display_text": {"en": "Algeria", "es": "Argelia"}}, {"id": "andorra", "display_text": {"en": "Andorra", "es": "Andorra"}}, {"id": "angola", "display_text": {"en": "Angola", "es": "Angola"}}, {"id": "antigua_and_barbuda", "display_text": {"en": "Antigua and Barbuda", "es": "Antigua and Barbuda"}}, {"id": "argentina", "display_text": {"en": "Argentina", "es": "Argentina"}}, {"id": "armenia", "display_text": {"en": "Armenia", "es": "Armenia"}}, {"id": "australia", "display_text": {"en": "Australia", "es": "Australia"}}, {"id": "austria", "display_text": {"en": "Austria", "es": "Austria"}}, {"id": "azerbaijan", "display_text": {"en": "Azerbaijan", "es": "Azerbaiyán"}}, {"id": "bahamas", "display_text": {"en": "Bahamas", "es": "Bahamas"}}, {"id": "bahrain", "display_text": {"en": "Bahrain", "es": "Baréin"}}, {"id": "bangladesh", "display_text": {"en": "Bangladesh", "es": "Bangladés"}}, {"id": "barbados", "display_text": {"en": "Barbados", "es": "Barbados"}}, {"id": "belarus", "display_text": {"en": "Belarus", "es": "Bielorrusia"}}, {"id": "belgium", "display_text": {"en": "Belgium", "es": "Bélgica"}}, {"id": "belize", "display_text": {"en": "Belize", "es": "Belice"}}, {"id": "benin", "display_text": {"en": "Benin", "es": "Benín"}}, {"id": "bhutan", "display_text": {"en": "Bhutan", "es": "Bután"}}, {"id": "bolivia", "display_text": {"en": "Bolivia", "es": "Bolivia"}}, {"id": "bosnia_and_herzegovina", "display_text": {"en": "Bosnia and Herzegovina", "es": "Bosnia and Herzegovina"}}, {"id": "botswana", "display_text": {"en": "Botswana", "es": "Botsuana"}}, {"id": "brazil", "display_text": {"en": "Brazil", "es": "Brasil"}}, {"id": "brunei", "display_text": {"en": "Brunei", "es": "Brunéi"}}, {"id": "bulgaria", "display_text": {"en": "Bulgaria", "es": "Bulgaria"}}, {"id": "burkina_faso", "display_text": {"en": "Burkina Faso", "es": "Burkina Faso"}}, {"id": "burundi", "display_text": {"en": "Burundi", "es": "Burundi"}}, {"id": "cabo_verde", "display_text": {"en": "Cabo Verde", "es": "Cabo Verde"}}, {"id": "cambodia", "display_text": {"en": "Cambodia", "es": "Camboya"}}, {"id": "cameroon", "display_text": {"en": "Cameroon", "es": "Camerún"}}, {"id": "canada", "display_text": {"en": "Canada", "es": "Canadá"}}, {"id": "central_african_republic", "display_text": {"en": "Central African Republic", "es": "República Centroafricana"}}, {"id": "chad", "display_text": {"en": "Chad", "es": "Chad"}}, {"id": "chile", "display_text": {"en": "Chile", "es": "Chile"}}, {"id": "china", "display_text": {"en": "China", "es": "China"}}, {"id": "colombia", "display_text": {"en": "Colombia", "es": "Colombia"}}, {"id": "comoros", "display_text": {"en": "Comoros", "es": "Comoras"}}, {"id": "congo", "display_text": {"en": "Congo, Republic of the", "es": "República del Congo"}}, {"id": "drc", "display_text": {"en": "Congo, Democratic Republic of the", "es": "República Democrática del Congo"}}, {"id": "costa_rica", "display_text": {"en": "Costa Rica", "es": "Costa Rica"}}, {"id": "cote_divoire", "display_text": {"en": "Cote d'Ivoire", "es": "Costa de Marfil"}}, {"id": "croatia", "display_text": {"en": "Croatia", "es": "Croacia"}}, {"id": "cuba", "display_text": {"en": "Cuba", "es": "Cuba"}}, {"id": "cyprus", "display_text": {"en": "Cyprus", "es": "Chipre"}}, {"id": "czech_republic", "display_text": {"en": "Czech Republic", "es": "República Checa"}}, {"id": "denmark", "display_text": {"en": "Denmark", "es": "Dinamarca"}}, {"id": "djibouti", "display_text": {"en": "Djibouti", "es": "Yibuti"}}, {"id": "dominica", "display_text": {"en": "Dominica", "es": "Dominica"}}, {"id": "dominican_republic", "display_text": {"en": "Dominican Republic", "es": "República Dominicana"}}, {"id": "ecuador", "display_text": {"en": "Ecuador", "es": "Ecuador"}}, {"id": "egypt", "display_text": {"en": "Egypt", "es": "Egipto"}}, {"id": "el_salvador", "display_text": {"en": "El Salvador", "es": "El Salvador"}}, {"id": "equatorial_guinea", "display_text": {"en": "Equatorial Guinea", "es": "Guinea Ecuatorial"}}, {"id": "eritrea", "display_text": {"en": "Eritrea", "es": "Eritrea"}}, {"id": "estonia", "display_text": {"en": "Estonia", "es": "Estonia"}}, {"id": "ethiopia", "display_text": {"en": "Ethiopia", "es": "Etiopía"}}, {"id": "fiji", "display_text": {"en": "Fiji", "es": "Fiyi"}}, {"id": "finland", "display_text": {"en": "Finland", "es": "Finlandia"}}, {"id": "france", "display_text": {"en": "France", "es": "Francia"}}, {"id": "gabon", "display_text": {"en": "Gabon", "es": "Gabón"}}, {"id": "gambia", "display_text": {"en": "Gambia", "es": "Gambia"}}, {"id": "georgia", "display_text": {"en": "Georgia", "es": "Georgia"}}, {"id": "germany", "display_text": {"en": "Germany", "es": "Alemania"}}, {"id": "ghana", "display_text": {"en": "Ghana", "es": "Ghana"}}, {"id": "greece", "display_text": {"en": "Greece", "es": "Grecia"}}, {"id": "grenada", "display_text": {"en": "Grenada", "es": "Granada"}}, {"id": "guatemala", "display_text": {"en": "Guatemala", "es": "Guatemala"}}, {"id": "guinea", "display_text": {"en": "Guinea", "es": "Guinea"}}, {"id": "guinea_bissau", "display_text": {"en": "Guinea-Bissau", "es": "Guinea-Bisáu"}}, {"id": "guyana", "display_text": {"en": "Guyana", "es": "Guyana"}}, {"id": "haiti", "display_text": {"en": "Haiti", "es": "Haití"}}, {"id": "honduras", "display_text": {"en": "Honduras", "es": "Honduras"}}, {"id": "hungary", "display_text": {"en": "Hungary", "es": "Hungría"}}, {"id": "iceland", "display_text": {"en": "Iceland", "es": "Islandia"}}, {"id": "india", "display_text": {"en": "India", "es": "India"}}, {"id": "indonesia", "display_text": {"en": "Indonesia", "es": "Indonesia"}}, {"id": "iran", "display_text": {"en": "Iran", "es": "Irán"}}, {"id": "iraq", "display_text": {"en": "Iraq", "es": "Irak"}}, {"id": "ireland", "display_text": {"en": "Ireland", "es": "Irlanda"}}, {"id": "israel", "display_text": {"en": "Israel", "es": "Israel"}}, {"id": "italy", "display_text": {"en": "Italy", "es": "Italia"}}, {"id": "jamaica", "display_text": {"en": "Jamaica", "es": "Jamaica"}}, {"id": "japan", "display_text": {"en": "Japan", "es": "Japón"}}, {"id": "jordan", "display_text": {"en": "Jordan", "es": "Jordania"}}, {"id": "kazakhstan", "display_text": {"en": "Kazakhstan", "es": "Kazajistán"}}, {"id": "kenya", "display_text": {"en": "Kenya", "es": "Kenia"}}, {"id": "kiribati", "display_text": {"en": "Kiribati", "es": "Kiribati"}}, {"id": "kosovo", "display_text": {"en": "Kosovo", "es": "Kosovo"}}, {"id": "kuwait", "display_text": {"en": "Kuwait", "es": "Kuwait"}}, {"id": "kyrgyzstan", "display_text": {"en": "Kyrgyzstan", "es": "Kirguistán"}}, {"id": "laos", "display_text": {"en": "Laos", "es": "Laos"}}, {"id": "latvia", "display_text": {"en": "Latvia", "es": "Letonia"}}, {"id": "lebanon", "display_text": {"en": "Lebanon", "es": "Líbano"}}, {"id": "lesotho", "display_text": {"en": "Lesotho", "es": "Lesoto"}}, {"id": "liberia", "display_text": {"en": "Liberia", "es": "Liberia"}}, {"id": "libya", "display_text": {"en": "Libya", "es": "Libia"}}, {"id": "liechtenstein", "display_text": {"en": "Liechtenstein", "es": "Liechtenstein"}}, {"id": "lithuania", "display_text": {"en": "Lithuania", "es": "Lituania"}}, {"id": "luxembourg", "display_text": {"en": "Luxembourg", "es": "Luxemburgo"}}, {"id": "macedonia", "display_text": {"en": "Macedonia", "es": "Macedonia del Norte"}}, {"id": "madagascar", "display_text": {"en": "Madagascar", "es": "Madagascar"}}, {"id": "malawi", "display_text": {"en": "Malawi", "es": "Malaui"}}, {"id": "malaysia", "display_text": {"en": "Malaysia", "es": "Malasia"}}, {"id": "maldives", "display_text": {"en": "Maldives", "es": "Maldivas"}}, {"id": "mali", "display_text": {"en": "Mali", "es": "Mali"}}, {"id": "malta", "display_text": {"en": "Malta", "es": "Malta"}}, {"id": "marshall_islands", "display_text": {"en": "Marshall Islands", "es": "Islas Marshall"}}, {"id": "mauritania", "display_text": {"en": "Mauritania", "es": "Mauritania"}}, {"id": "mauritius", "display_text": {"en": "Mauritius", "es": "Mauricio"}}, {"id": "mexico", "display_text": {"en": "Mexico", "es": "México"}}, {"id": "micronesia", "display_text": {"en": "Micronesia", "es": "Micronesia"}}, {"id": "moldova", "display_text": {"en": "Moldova", "es": "Moldavia"}}, {"id": "monaco", "display_text": {"en": "Monaco", "es": "Mónaco"}}, {"id": "mongolia", "display_text": {"en": "Mongolia", "es": "Mongolia"}}, {"id": "montenegro", "display_text": {"en": "Montenegro", "es": "Montenegro"}}, {"id": "morocco", "display_text": {"en": "Morocco", "es": "Marruecos"}}, {"id": "mozambique", "display_text": {"en": "Mozambique", "es": "Mozambique"}}, {"id": "myanmar", "display_text": {"en": "Myanmar", "es": "Myanmar (Birmania)"}}, {"id": "namibia", "display_text": {"en": "Namibia", "es": "Namibia"}}, {"id": "nauru", "display_text": {"en": "Nauru", "es": "Nauru"}}, {"id": "nepal", "display_text": {"en": "Nepal", "es": "Nepal"}}, {"id": "netherlands", "display_text": {"en": "Netherlands", "es": "Países Bajos"}}, {"id": "new_zealand", "display_text": {"en": "New Zealand", "es": "Nueva Zelanda"}}, {"id": "nicaragua", "display_text": {"en": "Nicaragua", "es": "Nicaragua"}}, {"id": "niger", "display_text": {"en": "Niger", "es": "Níger"}}, {"id": "nigeria", "display_text": {"en": "Nigeria", "es": "Nigeria"}}, {"id": "north_korea", "display_text": {"en": "North Korea", "es": "Corea del Norte"}}, {"id": "norway", "display_text": {"en": "Norway", "es": "Noruega"}}, {"id": "oman", "display_text": {"en": "Oman", "es": "Omán"}}, {"id": "pakistan", "display_text": {"en": "Pakistan", "es": "Pakistán"}}, {"id": "palau", "display_text": {"en": "Palau", "es": "Palaos"}}, {"id": "palestine", "display_text": {"en": "Palestine", "es": "Palestina"}}, {"id": "panama", "display_text": {"en": "Panama", "es": "Panamá"}}, {"id": "papua_new_guinea", "display_text": {"en": "Papua New Guinea", "es": "Papúa Nueva Guinea"}}, {"id": "paraguay", "display_text": {"en": "Paraguay", "es": "Paraguay"}}, {"id": "peru", "display_text": {"en": "Peru", "es": "Perú"}}, {"id": "philippines", "display_text": {"en": "Philippines", "es": "Filipinas"}}, {"id": "poland", "display_text": {"en": "Poland", "es": "Polonia"}}, {"id": "portugal", "display_text": {"en": "Portugal", "es": "Portugal"}}, {"id": "qatar", "display_text": {"en": "Qatar", "es": "Catar"}}, {"id": "romania", "display_text": {"en": "Romania", "es": "Rumanía"}}, {"id": "russia", "display_text": {"en": "Russia", "es": "Rusia"}}, {"id": "rwanda", "display_text": {"en": "Rwanda", "es": "Ruanda"}}, {"id": "st_kitts_and_nevis", "display_text": {"en": "St. Kitts and Nevis", "es": "St. Kitts and Nevis"}}, {"id": "st_lucia", "display_text": {"en": "St. Lucia", "es": "Santa Lucía"}}, {"id": "st_vincent_and_the_grenadines", "display_text": {"en": "St. Vincent and The Grenadines", "es": "St. Vincent and The Grenadines"}}, {"id": "samoa", "display_text": {"en": "Samoa", "es": "Samoa"}}, {"id": "san_marino", "display_text": {"en": "San Marino", "es": "San Marino"}}, {"id": "sao_tome_and_principe", "display_text": {"en": "Sao Tome and Principe", "es": "Sao Tome and Principe"}}, {"id": "saudi_arabia", "display_text": {"en": "Saudi Arabia", "es": "Arabia Saudí"}}, {"id": "senegal", "display_text": {"en": "Senegal", "es": "Senegal"}}, {"id": "serbia", "display_text": {"en": "Serbia", "es": "Serbia"}}, {"id": "seychelles", "display_text": {"en": "Seychelles", "es": "Seychelles"}}, {"id": "sierra_leone", "display_text": {"en": "Sierra Leone", "es": "Sierra Leona"}}, {"id": "singapore", "display_text": {"en": "Singapore", "es": "Singapur"}}, {"id": "slovakia", "display_text": {"en": "Slovakia", "es": "Eslovaquia"}}, {"id": "slovenia", "display_text": {"en": "Slovenia", "es": "Eslovenia"}}, {"id": "solomon_islands", "display_text": {"en": "Solomon Islands", "es": "Islas Salomón"}}, {"id": "somalia", "display_text": {"en": "Somalia", "es": "Somalia"}}, {"id": "south_africa", "display_text": {"en": "South Africa", "es": "Sudáfrica"}}, {"id": "south_korea", "display_text": {"en": "South Korea", "es": "Corea del Sur"}}, {"id": "south_sudan", "display_text": {"en": "South Sudan", "es": "Sudán del Sur"}}, {"id": "spain", "display_text": {"en": "Spain", "es": "España"}}, {"id": "sri_lanka", "display_text": {"en": "Sri Lanka", "es": "Sri Lanka"}}, {"id": "sudan", "display_text": {"en": "Sudan", "es": "Sudán"}}, {"id": "suriname", "display_text": {"en": "Suriname", "es": "Surinam"}}, {"id": "swaziland", "display_text": {"en": "Swaziland", "es": "Suazilandia"}}, {"id": "sweden", "display_text": {"en": "Sweden", "es": "Suecia"}}, {"id": "switzerland", "display_text": {"en": "Switzerland", "es": "Suiza"}}, {"id": "syria", "display_text": {"en": "Syria", "es": "Siria"}}, {"id": "taiwan", "display_text": {"en": "Taiwan", "es": "Taiwán"}}, {"id": "tajikistan", "display_text": {"en": "Tajikistan", "es": "Tayikistán"}}, {"id": "tanzania", "display_text": {"en": "Tanzania", "es": "Tanzania"}}, {"id": "thailand", "display_text": {"en": "Thailand", "es": "Tailandia"}}, {"id": "timor_leste", "display_text": {"en": "Timor-Leste", "es": "Timor-Leste"}}, {"id": "togo", "display_text": {"en": "Togo", "es": "Togo"}}, {"id": "tonga", "display_text": {"en": "Tonga", "es": "Tonga"}}, {"id": "trinidad_and_tobago", "display_text": {"en": "Trinidad and Tobago", "es": "Trinidad and Tobago"}}, {"id": "tunisia", "display_text": {"en": "Tunisia", "es": "Túnez"}}, {"id": "turkey", "display_text": {"en": "Turkey", "es": "Turquía"}}, {"id": "turkmenistan", "display_text": {"en": "Turkmenistan", "es": "Turkmenistán"}}, {"id": "tuvalu", "display_text": {"en": "Tuvalu", "es": "Tuvalu"}}, {"id": "uganda", "display_text": {"en": "Uganda", "es": "Uganda"}}, {"id": "ukraine", "display_text": {"en": "Ukraine", "es": "Ucrania"}}, {"id": "united_arab_emirates", "display_text": {"en": "United Arab Emirates", "es": "Emiratos Árabes Unidos"}}, {"id": "uk", "display_text": {"en": "UK (United Kingdom)", "es": "Reino Unido"}}, {"id": "usa", "display_text": {"en": "USA (United States of America)", "es": "Estados Unidos"}}, {"id": "uruguay", "display_text": {"en": "Uruguay", "es": "Uruguay"}}, {"id": "uzbekistan", "display_text": {"en": "Uzbekistan", "es": "Uzbekistán"}}, {"id": "vanuatu", "display_text": {"en": "Vanuatu", "es": "Vanuatu"}}, {"id": "vatican", "display_text": {"en": "Vatican City (Holy See)", "es": "Ciudad del Vaticano"}}, {"id": "venezuela", "display_text": {"en": "Venezuela", "es": "Venezuela"}}, {"id": "vietnam", "display_text": {"en": "Vietnam", "es": "Vietnam"}}, {"id": "yemen", "display_text": {"en": "Yemen", "es": "Yemen"}}, {"id": "zambia", "display_text": {"en": "Zambia", "es": "Zambia"}}, {"id": "zimbabwe", "display_text": {"en": "Zimbabwe", "es": "Zimbabue"}}]	f	2026-06-01 20:20:28.935613	2026-06-01 20:52:43.027484
170	lookup-yes-no-unknown	{"en": "Yes, No, or Unknown"}	[{"id": "true", "display_text": {"en": "Yes"}}, {"id": "false", "display_text": {"en": "No"}}, {"id": "unknown", "display_text": {"en": "Unknown"}}]	f	2026-06-01 20:20:29.112842	2026-06-01 20:20:29.112842
171	lookup-yes-no-undecided	{"en": "Yes, No, or Undecided"}	[{"id": "true", "display_text": {"en": "Yes"}}, {"id": "false", "display_text": {"en": "No"}}, {"id": "undecided", "display_text": {"en": "Undecided"}}]	f	2026-06-01 20:20:29.119616	2026-06-01 20:20:29.119616
172	lookup-yes-no-duration	{"en": "Yes, No Duration"}	[{"id": "yes_short_term", "display_text": {"en": "Yes, short-term"}}, {"id": "yes_long_term", "display_text": {"en": "Yes, long-term"}}, {"id": "no", "display_text": {"en": "No"}}]	f	2026-06-01 20:20:29.126525	2026-06-01 20:20:29.126525
176	lookup-gbv-approval-types	{"en": "Approval Type for GBV users"}	[{"id": "case_plan", "display_text": {"en": "Case Plan"}}, {"id": "closure", "display_text": {"en": "Closure"}}]	t	2026-06-01 20:20:29.157688	2026-06-01 20:20:29.157688
179	lookup-inquiry-status	{"en": "Inquiry Status"}	[{"id": "open", "display_text": {"en": "Open"}}, {"id": "closed", "display_text": {"en": "Closed"}}]	f	2026-06-01 20:20:29.179307	2026-06-01 20:20:29.179307
180	lookup-service-referred	{"en": "Service Referred"}	[{"id": "referred", "display_text": {"en": "Referred"}}, {"id": "service_provided_by_your_agency", "display_text": {"en": "Service provided by your agency"}}, {"id": "services_already_received_from_another_agency", "display_text": {"en": "Services already received from another agency"}}, {"id": "service_not_applicable", "display_text": {"en": "Service not applicable"}}, {"id": "referral_declined_by_survivor", "display_text": {"en": "Referral declined by survivor"}}, {"id": "service_unavailable", "display_text": {"en": "Service unavailable"}}]	f	2026-06-01 20:20:29.186422	2026-06-01 20:20:29.186422
168	lookup-unhcr-needs-codes	{"en": "UNHCR Needs Codes", "es": "Códigos de necesidades de ACNUR"}	[{"id": "cr-cp", "display_text": {"en": "CR-CP", "es": "CR-CP"}}, {"id": "cr-cs", "display_text": {"en": "CR-CS", "es": "CR-CS"}}, {"id": "cr-cc", "display_text": {"en": "CR-CC", "es": "CR-CC"}}, {"id": "cr-tp", "display_text": {"en": "CR-TP", "es": "CR-TP"}}, {"id": "cr-lw", "display_text": {"en": "CR-LW", "es": "CR-LW"}}, {"id": "cr-lo", "display_text": {"en": "CR-LO", "es": "CR-LO"}}, {"id": "cr-ne", "display_text": {"en": "CR-NE", "es": "CR-NE"}}, {"id": "cr-se", "display_text": {"en": "CR-SE", "es": "CR-SE"}}, {"id": "cr-af", "display_text": {"en": "CR-AF", "es": "CR-AF"}}, {"id": "cr-cl", "display_text": {"en": "CR-CL", "es": "CR-CL"}}, {"id": "sc-ch", "display_text": {"en": "SC-CH", "es": "SC-CH"}}, {"id": "sc-ic", "display_text": {"en": "SC-IC", "es": "SC-IC"}}, {"id": "sc-fc", "display_text": {"en": "SC-FC", "es": "SC-FC"}}, {"id": "ds-bd", "display_text": {"en": "DS-BD", "es": "DS-BD"}}, {"id": "ds-df", "display_text": {"en": "DS-DF", "es": "DS-DF"}}, {"id": "ds-pm", "display_text": {"en": "DS-PM", "es": "DS-PM"}}, {"id": "ds-ps", "display_text": {"en": "DS-PS", "es": "DS-PS"}}, {"id": "ds-mm", "display_text": {"en": "DS-MM", "es": "DS-MM"}}, {"id": "ds-ms", "display_text": {"en": "DS-MS", "es": "DS-MS"}}, {"id": "ds-sd", "display_text": {"en": "DS-SD", "es": "DS-SD"}}, {"id": "sm-mi", "display_text": {"en": "SM-MI", "es": "SM-MI"}}, {"id": "sm-mn", "display_text": {"en": "SM-MN", "es": "SM-MN"}}, {"id": "sm-ci", "display_text": {"en": "SM-CI", "es": "SM-CI"}}, {"id": "sm-cc", "display_text": {"en": "SM-CC", "es": "SM-CC"}}, {"id": "sm-ot", "display_text": {"en": "SM-OT", "es": "SM-OT"}}, {"id": "fu-tr", "display_text": {"en": "FU-TR", "es": "FU-TR"}}, {"id": "fu-fr", "display_text": {"en": "FU-FR", "es": "FU-FR"}}, {"id": "lp-nd", "display_text": {"en": "LP-ND", "es": "LP-ND"}}, {"id": "tr-pi", "display_text": {"en": "TR-PI", "es": "TR-PI"}}, {"id": "tr-ho", "display_text": {"en": "TR-HO", "es": "TR-HO"}}, {"id": "tr-wv", "display_text": {"en": "TR-WV", "es": "TR-WV"}}, {"id": "sv-va", "display_text": {"en": "SV-VA", "es": "SV-VA"}}, {"id": "lp-an", "display_text": {"en": "LP-AN", "es": "LP-AN"}}, {"id": "lp-md", "display_text": {"en": "LP-MD", "es": "LP-MD"}}, {"id": "lp-ms", "display_text": {"en": "LP-MS", "es": "LP-MS"}}, {"id": "lp-rr", "display_text": {"en": "LP-RR", "es": "LP-RR"}}]	f	2026-06-01 20:20:29.096316	2026-06-01 20:52:42.964421
167	lookup-protection-concerns	{"en": "Protection Concerns", "es": "Riesgos de protección"}	[{"id": "sexually_exploited", "display_text": {"en": "Sexually Exploited", "es": "Explotación sexual"}}, {"id": "gbv_survivor", "display_text": {"en": "GBV survivor", "es": "Sobreviviente de violencia de género"}}, {"id": "trafficked_smuggled", "display_text": {"en": "Trafficked/smuggled", "es": "Trata o tráfico de personas"}}, {"id": "statelessness", "display_text": {"en": "Statelessness", "es": "Apatridia"}}, {"id": "arrested_detained", "display_text": {"en": "Arrested/Detained", "es": "Arrestado o detenido"}}, {"id": "migrant", "display_text": {"en": "Migrant", "es": "Migrante"}}, {"id": "disabled", "display_text": {"en": "Disabled", "es": "Con discapacidad"}}, {"id": "serious_health_issue", "display_text": {"en": "Serious health issue", "es": "Problema grave de salud"}}, {"id": "refugee", "display_text": {"en": "Refugee", "es": "Refugiado"}}, {"id": "caafag", "display_text": {"en": "CAAFAG", "es": "Niño asociado con fuerzas o grupos armados"}}, {"id": "street_child", "display_text": {"en": "Street child", "es": "Niño en situación de calle"}}, {"id": "child_mother", "display_text": {"en": "Child Mother", "es": "Niña madre"}}, {"id": "physically_or_mentally_abused", "display_text": {"en": "Physically or Mentally Abused", "es": "Abuso físico o mental"}}, {"id": "living_with_vulnerable_person", "display_text": {"en": "Living with vulnerable person", "es": "Convive con una persona vulnerable"}}, {"id": "worst_forms_of_child_labor", "display_text": {"en": "Worst Forms of Child Labor", "es": "Peores formas de trabajo infantil"}}, {"id": "child_headed_household", "display_text": {"en": "Child Headed Household", "es": "Hogar encabezado por un niño"}}, {"id": "mentally_distressed", "display_text": {"en": "Mentally Distressed", "es": "Afectación emocional"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}]	f	2026-06-01 20:20:29.086709	2026-06-01 20:50:18.238469
185	lookup-marital-status-with-spouse	{"en": "Marital Status"}	[{"id": "single", "display_text": {"en": "Single"}}, {"id": "married_cohabitating", "display_text": {"en": "Married/Cohabitating"}}, {"id": "divorced_separated", "display_text": {"en": "Divorced/Separated"}}, {"id": "widowed", "display_text": {"en": "Widowed"}}, {"id": "with_spouse", "display_text": {"en": "With Partner/Spouse"}}]	f	2026-06-01 20:20:29.221643	2026-06-01 20:20:29.221643
192	lookup-age-group-type	{"en": "Age Group Type"}	[{"id": "adult", "display_text": {"en": "Adult"}}, {"id": "minor", "display_text": {"en": "Minor"}}, {"id": "unknown", "display_text": {"en": "Unknown"}}]	f	2026-06-01 20:20:29.270914	2026-06-01 20:20:29.270914
193	lookup-assessment-progress	{"en": "Assessment Progress"}	[{"id": "n_a", "display_text": {"en": "N/A"}}, {"id": "in_progress", "display_text": {"en": "In progress"}}, {"id": "met", "display_text": {"en": "Met"}}]	f	2026-06-01 20:20:29.276705	2026-06-01 20:20:29.276705
194	lookup-further-action_needed	{"en": "Further Action Needed"}	[{"id": "no_further_action_needed", "display_text": {"en": "No Further Action Needed"}}, {"id": "ongoing_monitoring", "display_text": {"en": "Ongoing Monitoring"}}, {"id": "urgent_intervention", "display_text": {"en": "Urgent Intervention"}}]	f	2026-06-01 20:20:29.282499	2026-06-01 20:20:29.282499
189	lookup-incident-identification	{"en": "Incident Identification", "es": "Identificación del incidente"}	[{"id": "disclosure_complaint_by_the_abused_person_or_family_member", "display_text": {"en": "Disclosure / complaint by the abused person or family member", "es": "Revelación o denuncia de la persona afectada o un familiar"}}, {"id": "discovered_by_service_provider", "display_text": {"en": "Discovered by service provider", "es": "Detectado por el proveedor del servicio"}}, {"id": "report_by_the_institution_providing_the_service_discovery", "display_text": {"en": "Report by the institution providing the service (discovery)", "es": "Reporte de la institución que presta el servicio"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}]	f	2026-06-01 20:20:29.251279	2026-06-01 20:52:42.852861
190	lookup-disability-type	{"en": "Disability Type", "es": "Tipo de discapacidad"}	[{"id": "mental_disability", "display_text": {"en": "Mental Disability", "es": "Discapacidad mental"}}, {"id": "physical_disability", "display_text": {"en": "Physical Disability", "es": "Discapacidad física"}}, {"id": "both", "display_text": {"en": "Both", "es": "Ambas"}}]	f	2026-06-01 20:20:29.257596	2026-06-01 20:50:18.175642
187	lookup-time-of-day	{"en": "Time of Day", "es": "Momento del día"}	[{"id": "morning", "display_text": {"en": "Morning", "es": "Mañana"}}, {"id": "noon", "display_text": {"en": "Noon", "es": "Mediodía"}}, {"id": "evening", "display_text": {"en": "Evening", "es": "Tarde"}}, {"id": "night", "display_text": {"en": "Night", "es": "Noche"}}]	f	2026-06-01 20:20:29.237297	2026-06-01 20:50:18.359057
191	lookup-transition-type	{"en": "Transition Type", "es": "Tipo de transición"}	[{"id": "referral", "display_text": {"en": "Referral", "es": "Derivación"}}, {"id": "reassign", "display_text": {"en": "Reassign", "es": "Reasignación"}}, {"id": "transfer", "display_text": {"en": "Transfer", "es": "Transferencia"}}, {"id": "transfer_request", "display_text": {"en": "Transfer Request", "es": "Solicitud de transferencia"}}]	f	2026-06-01 20:20:29.265106	2026-06-01 20:50:18.395758
196	lookup-tracing-status	{"en": "Tracing Status", "es": "Estado de localización"}	[{"id": "open", "display_text": {"en": "Open", "es": "Abierto"}}, {"id": "tracing_in_progress", "display_text": {"en": "Tracing in Progress", "es": "Localización en curso"}}, {"id": "verified", "display_text": {"en": "Verified", "es": "Verificado"}}, {"id": "reunified", "display_text": {"en": "Reunified", "es": "Reunificado"}}, {"id": "closed", "display_text": {"en": "Closed", "es": "Cerrado"}}]	f	2026-06-01 20:20:29.294244	2026-06-01 20:50:18.375649
188	lookup-incident-location	{"en": "Incident Location", "es": "Lugar del incidente"}	[{"id": "home", "display_text": {"en": "Home", "es": "Hogar"}}, {"id": "street", "display_text": {"en": "Street", "es": "Calle"}}, {"id": "school", "display_text": {"en": "School", "es": "Escuela"}}, {"id": "work_place", "display_text": {"en": "Work Place", "es": "Lugar de trabajo"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}]	f	2026-06-01 20:20:29.244193	2026-06-01 20:52:42.888897
199	lookup-form-group-cp-incident	{"en": "Form Groups - CP Incident"}	[{"id": "record_owner", "display_text": {"en": "Record Owner"}}, {"id": "perpetrator_details", "display_text": {"en": "Perpetrator Details"}}, {"id": "cp_incident", "display_text": {"en": "CP Incident"}}, {"id": "cp_individual_details", "display_text": {"en": "CP Individual Details"}}]	f	2026-06-01 20:20:29.312626	2026-06-01 20:20:29.312626
200	lookup-form-group-cp-registry-record	{"en": "Form Groups - CP Registry"}	[{"id": "record_information", "display_text": {"en": "Record Information"}}, {"id": "registry_details", "display_text": {"en": "Registry Details"}}]	f	2026-06-01 20:20:29.318702	2026-06-01 20:20:29.318702
201	lookup-form-group-cp-family	{"en": "Form Groups - CP Family"}	[{"id": "record_information", "display_text": {"en": "Record Information"}}, {"id": "family_overview", "display_text": {"en": "Family Overview"}}, {"id": "family_closure", "display_text": {"en": "Family Closure"}}, {"id": "family_consent", "display_text": {"en": "Family Consent"}}, {"id": "family_members", "display_text": {"en": "Family Members"}}, {"id": "family_notes", "display_text": {"en": "Family Notes"}}, {"id": "family_documents", "display_text": {"en": "Documents"}}, {"id": "other_reportable_fields", "display_text": {"en": "Other Reportable Fields"}}]	f	2026-06-01 20:20:29.324673	2026-06-01 20:20:29.324673
203	lookup-registry-status	{"en": "Registry Status"}	[{"id": "open", "display_text": {"en": "Open"}}, {"id": "closed", "display_text": {"en": "Closed"}}, {"id": "duplicate", "display_text": {"en": "Duplicate"}}]	f	2026-06-01 20:20:29.33797	2026-06-01 20:20:29.33797
204	lookup-registry-category	{"en": "Registry Category"}	[{"id": "registry_category1", "display_text": {"en": "Registry Category 1"}}, {"id": "registry_category2", "display_text": {"en": "Registry Category 2"}}, {"id": "registry_category3", "display_text": {"en": "Registry Category 3"}}]	f	2026-06-01 20:20:29.343449	2026-06-01 20:20:29.343449
205	lookup-family-type	{"en": "Family Type"}	[{"id": "family_type1", "display_text": {"en": "Family Type 1"}}, {"id": "family_type2", "display_text": {"en": "Family Type 2"}}, {"id": "family_type3", "display_text": {"en": "Family Type 3"}}]	f	2026-06-01 20:20:29.349414	2026-06-01 20:20:29.349414
207	lookup-disability-communication-best-means	{"en": "Disability Communication Best Means", "es": "Mejor medio de comunicación ante una discapacidad"}	[{"id": "through_parents", "display_text": {"en": "Through parents", "es": "A través de los padres"}}, {"id": "through_sibling", "display_text": {"en": "Through siblings", "es": "A través de hermanos"}}, {"id": "through_family_members", "display_text": {"en": "Through family members", "es": "A través de familiares"}}, {"id": "through_teacher", "display_text": {"en": "Through teacher", "es": "A través del docente"}}, {"id": "through_aid", "display_text": {"en": "Through aid", "es": "A través de apoyo"}}, {"id": "through_specialized_center", "display_text": {"en": "Through Specialized Center", "es": "A través de un centro especializado"}}, {"id": "other", "display_text": {"en": "Other", "es": "Otro"}}]	f	2026-06-01 20:20:29.423964	2026-06-01 20:52:42.842678
\.


--
-- Data for Name: perpetrators; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.perpetrators (id, data) FROM stdin;
\.


--
-- Data for Name: perpetrators_violations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.perpetrators_violations (id, violation_id, perpetrator_id) FROM stdin;
\.


--
-- Data for Name: primero_configurations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.primero_configurations (id, name, description, version, created_by, created_on, applied_by, applied_on, data, primero_version) FROM stdin;
\.


--
-- Data for Name: primero_modules; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.primero_modules (id, unique_id, primero_program_id, name, description, associated_record_types, core_resource, field_map, module_options, created_at, updated_at) FROM stdin;
1	primeromodule-cp	1	"CP"	"Child Protection"	{case,tracing_request,incident,registry_record,family}	t	{"fields": [{"source": ["incident_details", "cp_incident_identification_violence"], "target": "cp_incident_identification_violence"}, {"source": ["incident_details", "incident_date"], "target": "incident_date"}, {"source": ["incident_details", "cp_incident_location_type"], "target": "cp_incident_location_type"}, {"source": ["incident_details", "cp_incident_location_type_other"], "target": "cp_incident_location_type_other"}, {"source": ["incident_details", "incident_location"], "target": "incident_location"}, {"source": ["incident_details", "cp_incident_timeofday"], "target": "cp_incident_timeofday"}, {"source": ["incident_details", "cp_incident_timeofday_actual"], "target": "cp_incident_timeofday_actual"}, {"source": ["incident_details", "cp_incident_violence_type"], "target": "cp_incident_violence_type"}, {"source": ["incident_details", "cp_incident_previous_incidents"], "target": "cp_incident_previous_incidents"}, {"source": ["incident_details", "cp_incident_previous_incidents_description"], "target": "cp_incident_previous_incidents_description"}, {"source": ["incident_details", "cp_incident_abuser_name"], "target": "cp_incident_abuser_name"}, {"source": ["incident_details", "cp_incident_perpetrator_nationality"], "target": "cp_incident_perpetrator_nationality"}, {"source": ["incident_details", "perpetrator_sex"], "target": "perpetrator_sex"}, {"source": ["incident_details", "cp_incident_perpetrator_age"], "target": "cp_incident_perpetrator_age"}, {"source": ["incident_details", "cp_incident_perpetrator_national_id_no"], "target": "cp_incident_perpetrator_national_id_no"}, {"source": ["incident_details", "cp_incident_perpetrator_other_id_type"], "target": "cp_incident_perpetrator_other_id_type"}, {"source": ["incident_details", "cp_incident_perpetrator_other_id_no"], "target": "cp_incident_perpetrator_other_id_no"}, {"source": ["incident_details", "cp_incident_perpetrator_marital_status"], "target": "cp_incident_perpetrator_marital_status"}, {"source": ["incident_details", "cp_incident_perpetrator_occupation"], "target": "cp_incident_perpetrator_occupation"}, {"source": ["incident_details", "cp_incident_perpetrator_relationship"], "target": "cp_incident_perpetrator_relationship"}, {"source": ["age"], "target": "age"}, {"source": ["sex"], "target": "cp_sex"}, {"source": ["nationality"], "target": "cp_nationality"}, {"source": ["national_id_no"], "target": "national_id_no"}, {"source": ["other_id_type"], "target": "other_id_type"}, {"source": ["other_id_no"], "target": "other_id_no"}, {"source": ["maritial_status"], "target": "maritial_status"}, {"source": ["educational_status"], "target": "educational_status"}, {"source": ["occupation"], "target": "occupation"}, {"source": ["disability_type"], "target": "cp_disability_type"}, {"source": ["owned_by"], "target": "owned_by"}], "map_to": "primeromodule-cp"}	{"case_type": "person", "consent_form": "consent", "services_form": "services", "workflow_lookup": "lookup-workflow", "allow_searchable_ids": true, "response_type_lookup": "lookup-service-response-type", "use_workflow_case_plan": true, "use_workflow_assessment": false, "reporting_location_filter": true, "workflow_status_indicator": true, "use_workflow_service_implemented": true}	2026-04-22 19:33:49.178025	2026-06-01 20:20:37.91468
\.


--
-- Data for Name: primero_modules_roles; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.primero_modules_roles (role_id, primero_module_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	1
\.


--
-- Data for Name: primero_modules_saved_searches; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.primero_modules_saved_searches (id, primero_module_id, saved_search_id) FROM stdin;
\.


--
-- Data for Name: primero_programs; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.primero_programs (id, unique_id, name_i18n, description_i18n, start_date, end_date, core_resource, created_at, updated_at) FROM stdin;
1	primeroprogram-primero	{"en": "Primero"}	{"en": "Default Primero Program"}	\N	\N	f	2026-04-22 19:33:48.993025	2026-04-22 19:33:48.993025
\.


--
-- Data for Name: record_histories; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.record_histories (id, record_id, record_type, datetime, user_name, action, record_changes) FROM stdin;
1	f9ea6df8-951a-4551-b8dc-e4552272df9f	TracingRequest	2026-06-03 20:38:10.62	zenenperaza	create	{"status": {"to": "open", "from": null}, "flagged": {"to": false, "from": null}, "owned_by": {"to": "zenenperaza", "from": null}, "short_id": {"to": "52df0a4", "from": null}, "has_photo": {"to": false, "from": null}, "module_id": {"to": "primeromodule-cp", "from": null}, "posted_at": {"to": "2026-06-03T20:38:10.620Z", "from": null}, "created_at": {"to": "2026-06-03T20:38:10.620Z", "from": null}, "created_by": {"to": "zenenperaza", "from": null}, "inquiry_date": {"to": "2026-06-03", "from": null}, "record_state": {"to": true, "from": null}, "relation_age": {"to": 46, "from": null}, "tracing_names": {"to": ["ZENENCITO", "ALEXITO"], "from": null}, "caseworker_name": {"to": "ZENEN PERAZA", "from": null}, "owned_by_groups": {"to": ["usergroup-lrf-state-ve02"], "from": null}, "ftr_child_assent": {"to": false, "from": null}, "separation_cause": {"to": "conflict", "from": null}, "created_by_groups": {"to": ["usergroup-lrf-state-ve02"], "from": null}, "ftr_referral_date": {"to": "2026-06-03", "from": null}, "owned_by_location": {"to": "VEV", "from": null}, "relation_language": {"to": ["language1"], "from": null}, "relation_nickname": {"to": "investigador", "from": null}, "relation_religion": {"to": ["religion1"], "from": null}, "tracing_nicknames": {"to": ["zenencito", "alexis sanches"], "from": null}, "unique_identifier": {"to": "a8934fde-445e-4125-b07b-5b3a452df0a4", "from": null}, "date_of_separation": {"to": "2026-06-03", "from": null}, "ftr_related_people": {"to": [{"unique_id": "35cca5af-d8db-4776-a343-092d23fa3990", "ftr_related_person_age": 48, "ftr_related_person_sex": "male", "ftr_related_person_name": "VICULADAS 1", "ftr_related_person_type": "caregiver", "ftr_related_person_notes": "sin observacinoes", "ftr_related_person_location": "VE", "ftr_related_person_telephone": "041689745236", "ftr_related_person_relationship": "father", "ftr_related_person_date_of_birth": "1978-01-01", "ftr_related_person_document_type": "national_id", "ftr_related_person_contact_consent": true, "ftr_related_person_document_number": "14695963", "ftr_related_person_lives_with_sought_person": true}], "from": null}, "owned_by_agency_id": {"to": "LRF", "from": null}, "owned_by_full_name": {"to": "Zenen Peraza", "from": null}, "owned_by_user_code": {"to": "007", "from": null}, "relation_ethnicity": {"to": "ethnicity1", "from": null}, "relation_telephone": {"to": "041258936978", "from": null}, "tracing_request_id": {"to": "a8934fde-445e-4125-b07b-5b3a452df0a4", "from": null}, "current_alert_types": {"to": [], "from": null}, "location_separation": {"to": "VEK003", "from": null}, "not_edited_by_owner": {"to": false, "from": null}, "created_by_full_name": {"to": "Zenen Peraza", "from": null}, "created_organization": {"to": "LRF", "from": null}, "relation_nationality": {"to": ["nationality1"], "from": null}, "associated_user_names": {"to": ["zenenperaza"], "from": null}, "disclosure_other_orgs": {"to": false, "from": null}, "associated_user_groups": {"to": ["usergroup-lrf-state-ve02"], "from": null}, "ftr_authorizes_contact": {"to": false, "from": null}, "relation_date_of_birth": {"to": "1980-01-01", "from": null}, "associated_user_agencies": {"to": ["LRF"], "from": null}, "ftr_authorizes_image_use": {"to": false, "from": null}, "relation_address_current": {"to": "barri las veritas", "from": null}, "relation_location_current": {"to": "VEK003", "from": null}, "ftr_case_management_required": {"to": false, "from": null}, "ftr_family_contacts_available": {"to": false, "from": null}, "ftr_informed_consent_obtained": {"to": false, "from": null}, "ftr_immediate_response_required": {"to": false, "from": null}, "ftr_authorizes_information_storage": {"to": false, "from": null}, "ftr_authorizes_service_provider_sharing": {"to": false, "from": null}}
2	f9ea6df8-951a-4551-b8dc-e4552272df9f	TracingRequest	2026-06-03 20:41:54.355	marymelendez	update	{"ftr_alert_notes": {"to": "referencia", "from": null}, "not_edited_by_owner": {"to": true, "from": false}, "ftr_immediate_action": {"to": "referencia", "from": null}, "ftr_protection_alerts": {"to": ["physical_abuse", "sexual_abuse"], "from": null}, "ftr_updated_risk_level": {"to": "high", "from": null}, "ftr_immediate_response_areas": {"to": ["health"], "from": null}, "ftr_immediate_response_required": {"to": true, "from": false}}
3	f9ea6df8-951a-4551-b8dc-e4552272df9f	TracingRequest	2026-06-03 20:42:51.077	marymelendez	update	{"ftr_document_notes": {"to": "obersavaciones", "from": null}}
\.


--
-- Data for Name: registry_records; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.registry_records (id, data, phonetic_data, srch_created_at, srch_registration_date, srch_status, srch_record_state, srch_location_current, srch_not_edited_by_owner, srch_owned_by_groups, srch_associated_user_agencies, srch_associated_user_names, srch_associated_user_groups, srch_owned_by, srch_owned_by_agency_id, srch_assigned_user_names) FROM stdin;
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.reports (id, name_i18n, description_i18n, module_id, record_type, aggregate_by, disaggregate_by, aggregate_counts_from, filters, group_ages, group_dates_by, is_graph, editable, unique_id, disabled, exclude_empty_rows) FROM stdin;
27	{"en": "Registration CP"}	{"en": "Case registrations over time"}	primeromodule-cp	case	{registration_date}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	month	t	f	report-registration-cp-df7911a	f	f
28	{"en": "Caseload Summary CP"}	{"en": "Number of cases for each case worker"}	primeromodule-cp	case	{owned_by}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	t	f	report-caseload-summary-cp-71f3963	f	f
29	{"en": "Case status by case worker CP"}	{"en": "Status of cases held by case workers"}	primeromodule-cp	case	{owned_by}	{status}	\N	{"{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	t	f	report-case-status-by-case-worker-cp-3dbe8ca	f	f
30	{"en": "Cases by Agency CP"}	{"en": "Number of cases broken down by agency"}	primeromodule-cp	case	{owned_by_agency_id}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	t	f	report-cases-by-agency-cp-669f897	f	f
31	{"en": "Cases by Nationality"}	{"en": "Number of cases broken down by nationality"}	primeromodule-cp	case	{nationality}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	t	f	report-cases-by-nationality-c5dec8c	f	f
32	{"en": "Cases by Age and Sex"}	{"en": "Number of cases broken down by age and sex"}	primeromodule-cp	case	{age}	{sex}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	t	date	t	f	report-cases-by-age-and-sex-de2bc16	f	f
33	{"en": "Cases by Protection Concern"}	{"en": "Number of cases broken down by protection concern and sex"}	primeromodule-cp	case	{protection_concerns}	{sex}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	t	f	report-cases-by-protection-concern-63d9840	f	f
34	{"en": "Current Care Arrangements"}	{"en": "The care arrangements broken down by age and sex"}	primeromodule-cp	case	{care_arrangements_type}	{sex,age}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	t	date	t	f	report-current-care-arrangements-999256c	f	f
35	{"en": "Workflow Status"}	{"en": "Cases broken down by current workflow status"}	primeromodule-cp	case	{workflow_status}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	t	date	t	f	report-workflow-status-e457fc7	f	f
36	{"en": "Follow up by month by Agency"}	{"en": "Number of followups broken down by month and agency"}	primeromodule-cp	reportable_follow_up	{followup_date}	{owned_by_agency_id}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}","{\\"value\\": \\"\\", \\"attribute\\": \\"followup_date\\", \\"constraint\\": \\"not_null\\"}"}	f	month	t	f	report-follow-up-by-month-by-agency-faf1638	f	f
37	{"en": "Follow up by week by Agency"}	{"en": "Number of followups broken down by week and agency"}	primeromodule-cp	reportable_follow_up	{followup_date}	{owned_by_agency_id}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}","{\\"value\\": \\"\\", \\"attribute\\": \\"followup_date\\", \\"constraint\\": \\"not_null\\"}"}	f	week	t	f	report-follow-up-by-week-by-agency-a8d3dc4	f	f
38	{"en": "Cases per Month"}	{"en": " Number of newly registered cases per month per location "}	primeromodule-cp	case	{owned_by_location}	{created_at}	\N	{"{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	month	t	f	report-cases-per-month-478cdc0	f	f
39	{"en": "Cases with case plans"}	{"en": "How many registered cases have case plans?"}	primeromodule-cp	case	{has_case_plan}	{}	\N	{"{\\"value\\": [\\"open\\"], \\"attribute\\": \\"status\\"}","{\\"value\\": [\\"true\\"], \\"attribute\\": \\"record_state\\"}"}	f	date	f	f	report-cases-with-case-plans-5adc0ab	f	f
\.


--
-- Data for Name: responses; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.responses (id, data, violation_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.roles (id, unique_id, name, description, permissions, group_permission, referral, transfer, is_manager, reporting_location_level, disabled, created_at, updated_at, referral_authorization, user_category) FROM stdin;
8	role-agency-user-administrator	Agency User Administrator	\N	{"role": ["read", "assign"], "user": ["agency_read", "create", "write", "manage"], "objects": {"role": ["role-cp-case-worker", "role-cp-manager", "role-cp-user-manager", "role-cp-administrator"]}, "user_group": ["read", "create", "write", "assign"]}	group	f	f	t	\N	f	2026-04-22 19:33:51.449421	2026-06-01 20:20:35.812276	f	\N
16	role-lrf-monitor	Monitor LRF	Monitorea y gestiona todas las solicitudes LRF a nivel nacional	{"kpi": [], "case": [], "role": [], "user": [], "agency": [], "family": [], "report": ["read"], "system": [], "objects": {"role": []}, "webhook": [], "incident": [], "metadata": [], "audit_log": [], "dashboard": ["dash_matching_results", "dash_group_overview", "dash_reporting_location", "dash_flags"], "duplicate": [], "user_group": [], "activity_log": [], "usage_report": [], "managed_report": [], "potential_match": ["manage"], "registry_record": [], "tracing_request": ["manage"], "primero_configuration": [], "matching_configuration": []}	all	f	f	f	\N	f	2026-06-03 15:29:34.0388	2026-06-04 14:30:47.390933	f	\N
15	role-lrf-administrator	Administrador LRF	Administra a nivel nacional usuarios, roles, grupos y solicitudes LRF	{"kpi": [], "case": [], "role": ["read", "create", "write", "assign", "copy", "manage"], "user": ["manage"], "agency": ["read"], "family": [], "report": ["manage"], "system": [], "objects": {"role": []}, "webhook": [], "incident": [], "metadata": [], "audit_log": ["read"], "dashboard": ["dash_matching_results", "dash_group_overview", "dash_reporting_location", "dash_flags"], "duplicate": [], "user_group": ["manage"], "activity_log": [], "usage_report": [], "managed_report": [], "potential_match": ["manage"], "registry_record": [], "tracing_request": ["manage"], "primero_configuration": [], "matching_configuration": []}	all	f	f	t	\N	f	2026-06-03 15:29:33.84475	2026-06-04 14:30:47.390933	f	\N
13	role-ftr-worker	Coordinador Terreno LRF	Registra y gestiona las solicitudes LRF en campo	{"kpi": [], "case": [], "role": [], "user": [], "agency": [], "family": [], "report": [], "system": [], "objects": {"role": []}, "webhook": [], "incident": [], "metadata": [], "audit_log": [], "dashboard": ["dash_matching_results", "dash_group_overview", "dash_reporting_location", "dash_flags"], "duplicate": [], "user_group": [], "activity_log": [], "usage_report": [], "managed_report": [], "potential_match": ["manage"], "registry_record": [], "tracing_request": ["read", "create", "write", "enable_disable_record", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_pdf"], "primero_configuration": [], "matching_configuration": []}	group	f	f	f	1	f	2026-06-01 20:20:37.896584	2026-06-04 14:30:47.390933	f	\N
14	role-ftr-manager	Coordinador Regional LRF	Gestiona las solicitudes LRF de una region asignada	{"kpi": [], "case": [], "role": [], "user": ["read"], "agency": [], "family": [], "report": ["read"], "system": [], "objects": {"role": []}, "webhook": [], "incident": [], "metadata": [], "audit_log": [], "dashboard": ["dash_matching_results", "dash_group_overview", "dash_reporting_location", "dash_flags"], "duplicate": [], "user_group": ["read"], "activity_log": [], "usage_report": [], "managed_report": [], "potential_match": ["manage"], "registry_record": [], "tracing_request": ["manage"], "primero_configuration": [], "matching_configuration": []}	group	f	f	t	1	f	2026-06-01 20:20:38.073449	2026-06-04 14:30:47.390933	f	\N
17	role-lrf-manager	Gerente LRF	Supervisa nacionalmente y aprueba casos vinculados al flujo LRF	{"kpi": [], "case": [], "role": [], "user": [], "agency": [], "family": [], "report": ["read", "group_read"], "system": [], "objects": {"role": []}, "webhook": [], "incident": [], "metadata": [], "audit_log": [], "dashboard": ["approvals_assessment", "approvals_case_plan", "approvals_closure", "approvals_action_plan", "dash_national_admin_summary"], "duplicate": [], "user_group": [], "activity_log": [], "usage_report": [], "managed_report": [], "potential_match": ["read", "view_photo", "view_audio"], "registry_record": [], "tracing_request": ["read", "export_list_view_csv", "export_csv", "export_xls", "export_pdf", "change_log", "access_log"], "primero_configuration": [], "matching_configuration": []}	all	f	f	t	\N	f	2026-06-03 15:29:34.264395	2026-06-04 14:30:47.390933	f	\N
9	role-referral	Referral	\N	{"case": ["read", "write", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "create", "view_protection_concerns_filter"], "objects": {}, "dashboard": ["case_overview"]}	self	t	f	f	\N	f	2026-04-22 19:33:51.474821	2026-06-01 20:20:35.844879	f	\N
11	role-cp-service-provider	CP Service Provider	\N	{"case": ["read", "write", "flag", "services_section_from_case", "search_owned_by_others", "display_view_page", "receive_referral"], "objects": {}, "dashboard": ["case_overview", "view_response", "dash_shared_with_me", "case_risk", "workflow", "dash_flags"]}	self	t	f	f	\N	f	2026-04-22 19:33:51.676067	2026-06-01 20:20:35.950513	f	\N
12	role-superuser	Superuser	\N	{"case": ["manage"], "role": ["manage"], "user": ["manage"], "agency": ["manage"], "family": ["manage"], "report": ["manage"], "system": ["manage"], "objects": {}, "incident": ["manage"], "metadata": ["manage"], "audit_log": ["manage"], "dashboard": ["dash_reporting_location", "dash_protection_concerns"], "duplicate": ["read"], "user_group": ["manage"], "usage_report": ["read"], "code_of_conduct": ["manage"], "potential_match": ["read"], "tracing_request": ["manage"], "primero_configuration": ["manage"], "matching_configuration": ["manage"]}	all	f	f	t	\N	f	2026-04-22 19:33:51.693213	2026-06-05 14:11:28.592471	f	\N
1	role-cp-administrator	CP Administrator	\N	{"case": ["read", "write", "flag", "assign", "consent_override", "import", "referral", "transfer", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "search_owned_by_others", "create", "view_protection_concerns_filter", "enable_disable_record", "reopen", "close", "view_photo"], "role": ["read", "write", "assign", "create"], "user": ["read", "write", "create"], "agency": ["read", "write", "create"], "report": ["read", "write", "create"], "system": ["manage"], "objects": {"role": ["role-cp-case-worker", "role-cp-manager", "role-cp-user-manager", "role-referral", "role-transfer"]}, "incident": ["read", "write", "create"], "metadata": ["manage"], "audit_log": ["read"], "dashboard": ["dash_reporting_location", "dash_protection_concerns_by_location", "dash_protection_concerns"], "duplicate": ["read"], "user_group": ["read", "write", "create", "assign"], "code_of_conduct": ["manage"], "primero_configuration": ["manage"]}	all	f	f	t	\N	f	2026-04-22 19:33:49.326714	2026-06-05 14:11:28.592471	f	\N
10	role-transfer	Transfer	\N	{"case": ["read", "write", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "create", "view_protection_concerns_filter"], "objects": {}, "dashboard": ["case_overview"]}	self	f	t	f	\N	f	2026-04-22 19:33:51.491081	2026-06-05 14:11:28.592471	f	\N
2	role-cp-administrator-families	CP Administrator with Families	\N	{"case": ["read", "write", "flag", "assign", "consent_override", "import", "referral", "transfer", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "search_owned_by_others", "create", "view_protection_concerns_filter", "enable_disable_record", "reopen", "close", "view_photo", "view_family_record", "link_family_record"], "role": ["read", "write", "assign", "create"], "user": ["read", "write", "create"], "agency": ["read", "write", "create"], "family": ["read", "create", "write", "enable_disable_record", "flag", "reopen", "close", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_pdf"], "report": ["read", "write", "create"], "system": ["manage"], "objects": {"role": ["role-cp-case-worker", "role-cp-manager", "role-cp-user-manager", "role-referral", "role-transfer"]}, "incident": ["read", "write", "create"], "metadata": ["manage"], "audit_log": ["read"], "dashboard": ["dash_reporting_location", "dash_protection_concerns_by_location", "dash_protection_concerns"], "duplicate": ["read"], "user_group": ["read", "write", "create", "assign"], "code_of_conduct": ["manage"], "primero_configuration": ["manage"]}	all	f	f	t	\N	f	2026-04-22 19:33:49.878556	2026-06-05 14:11:28.592471	f	\N
3	role-cp-case-worker	CP Case Worker	\N	{"case": ["read", "write", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "sync_mobile", "request_approval_case_plan", "request_approval_closure", "search_owned_by_others", "incident_from_case", "create", "referral_from_service", "referral", "receive_referral", "receive_transfer", "view_protection_concerns_filter", "remove_assigned_users", "enable_disable_record", "display_view_page", "incident_details_from_case", "view_photo"], "objects": {}, "incident": ["read", "write", "create"], "dashboard": ["workflow", "approvals_assessment", "approvals_case_plan", "approvals_closure", "view_response", "case_risk", "dash_tasks", "case_overview", "dash_shared_with_others", "dash_shared_with_me"]}	self	f	f	f	\N	f	2026-04-22 19:33:50.272897	2026-06-05 14:11:28.592471	f	\N
4	role-cp-case-worker-families	CP Case Worker with Families	\N	{"case": ["read", "write", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "sync_mobile", "request_approval_case_plan", "request_approval_closure", "search_owned_by_others", "incident_from_case", "create", "referral_from_service", "referral", "receive_referral", "receive_transfer", "view_protection_concerns_filter", "remove_assigned_users", "enable_disable_record", "display_view_page", "incident_details_from_case", "view_photo", "case_from_family", "view_family_record", "link_family_record"], "family": ["read", "create", "write", "enable_disable_record", "flag", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_pdf", "change_log", "sync_mobile", "case_from_family"], "objects": {}, "incident": ["read", "write", "create"], "dashboard": ["workflow", "approvals_assessment", "approvals_case_plan", "approvals_closure", "view_response", "case_risk", "dash_tasks", "case_overview", "dash_shared_with_others", "dash_shared_with_me"]}	self	f	f	f	\N	f	2026-04-22 19:33:50.508561	2026-06-05 14:11:28.592471	f	\N
5	role-cp-manager	CP Manager	\N	{"case": ["read", "flag", "assign", "consent_override", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "sync_mobile", "approve_case_plan", "search_owned_by_others", "incident_from_case", "view_protection_concerns_filter", "enable_disable_record", "add_note", "reopen", "close", "display_view_page", "receive_transfer", "view_photo"], "role": ["read"], "user": ["read"], "agency": ["read"], "report": ["read", "write", "create"], "objects": {}, "dashboard": ["workflow_team", "approvals_assessment_pending", "approvals_case_plan_pending", "approvals_closure_pending", "view_response", "case_risk", "cases_by_task_overdue_assessment", "cases_by_task_overdue_case_plan", "cases_by_task_overdue_services", "cases_by_task_overdue_followups", "dash_shared_with_me", "dash_shared_with_others", "dash_group_overview", "dash_shared_from_my_team", "dash_shared_with_my_team"], "user_group": ["read"]}	group	f	f	t	\N	f	2026-04-22 19:33:50.838441	2026-06-05 14:11:28.592471	f	\N
7	role-cp-user-manager	CP User Manager	\N	{"case": ["read", "flag", "assign", "consent_override", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "sync_mobile", "approve_case_plan", "view_protection_concerns_filter", "view_photo"], "role": ["read", "assign"], "user": ["read", "create", "write"], "agency": ["read", "create", "write"], "report": ["read", "write"], "objects": {}, "dashboard": ["approvals_assessment_pending", "approvals_case_plan_pending", "approvals_closure_pending", "view_response", "case_risk", "dash_group_overview"], "user_group": ["read", "create", "write", "assign"]}	group	f	f	t	\N	f	2026-04-22 19:33:51.296334	2026-06-05 14:11:28.592471	f	\N
6	role-cp-manager-families	CP Manager with Families	\N	{"case": ["read", "flag", "assign", "consent_override", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_photowall", "export_pdf", "export_unhcr_csv", "sync_mobile", "approve_case_plan", "search_owned_by_others", "incident_from_case", "view_protection_concerns_filter", "enable_disable_record", "add_note", "reopen", "close", "display_view_page", "receive_transfer", "view_photo", "case_from_family", "view_family_record", "link_family_record"], "role": ["read"], "user": ["read"], "agency": ["read"], "family": ["read", "enable_disable_record", "flag", "export_custom", "export_list_view_csv", "export_csv", "export_xls", "export_json", "export_pdf", "reopen", "close", "change_log", "sync_mobile", "case_from_family"], "report": ["read", "write", "create"], "objects": {}, "dashboard": ["workflow_team", "approvals_assessment_pending", "approvals_case_plan_pending", "approvals_closure_pending", "view_response", "case_risk", "cases_by_task_overdue_assessment", "cases_by_task_overdue_case_plan", "cases_by_task_overdue_services", "cases_by_task_overdue_followups", "dash_shared_with_me", "dash_shared_with_others", "dash_group_overview", "dash_shared_from_my_team", "dash_shared_with_my_team"], "user_group": ["read"]}	group	f	f	t	\N	f	2026-04-22 19:33:51.014731	2026-06-05 14:11:28.592471	f	\N
\.


--
-- Data for Name: saved_searches; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.saved_searches (id, name, record_type, user_id, filters) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.schema_migrations (version) FROM stdin;
20251126000000
20190130000000
20190131000000
20190131000001
20190216000000
20190216000001
20190216000002
20190216000003
20190216000004
20190226000000
20190226000001
20190226000002
20190228000000
20190305000000
20190306000001
20190308000000
20190311000001
20190311000005
20190318000000
20190405000000
20190408000000
20190409000000
20190410000000
20190416181147
20190717000000
20190912000000
20191125000000
20191210000000
20200127000000
20200215000000
20200602160905
20200607000000
20200715232433
20200805210050
20200812155523
20200813000000
20200814000000
20200830000001
20200903000000
20201011000000
20210114000000
20210114000001
20210115000000
20210122000000
20210123000001
20210209000000
20210210000000
20210211000000
20210217000000
20210312000000
20210313000000
20210313000001
20210323000000
20210325000000
20210521000000
20210525000000
20210811020349
20210811020350
20210817000000
20211001000000
20211001000001
20211001000002
20211001000003
20211001000004
20211001000005
20211110000001
20211224000001
20220103000000
20220104000000
20220126000000
20220201145440
20220215000000
20220217000000
20220328075916
20230126000000
20230216000000
20230227000000
20230310000000
20230315000000
20230626000000
20230704000000
20230713162211
20230726000000
20230802000000
20230920000000
20230921124122
20231110000000
20231113000000
20231122151051
20240306154915
20240708000000
20241009000000
20241205000000
20250221221207
20250228000004
20250228000006
20250421000000
20250512000000
20250519000000
20250519195505
20250623000000
20250910000000
20250922000000
20251003000000
20251009185327
20251028000000
20251113000000
\.


--
-- Data for Name: searchable_identifiers; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.searchable_identifiers (id, record_type, record_id, field_name, value) FROM stdin;
1	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	tracing_request_id	a8934fde-445e-4125-b07b-5b3a452df0a4
2	TracingRequest	f9ea6df8-951a-4551-b8dc-e4552272df9f	short_id	52df0a4
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.sessions (id, session_id, data, expired, created_at, updated_at) FROM stdin;
365	2::a47bbca9ed8cc17710f8ccfb893a07b001c98b99278a4a44e5eae34ec7563118	{"_csrf_token": "cvVPpFyh6sa5fLS_m5t_ACn1L2yP2TtLz9pHTap_MyE="}	f	2026-06-09 19:44:16.376839	2026-06-09 19:44:16.502124
366	2::fc74efe1e29fe4082456326a31a0d7dbdc796d12b37c72f8ce26659b84618cc7	{"_csrf_token": "M3KbiAvKIrjTTNZibkX4l1Zu82_ZYjidRSJkXxpKVX8="}	f	2026-06-09 20:36:12.314147	2026-06-09 20:36:12.430606
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.sources (id, data) FROM stdin;
\.


--
-- Data for Name: sources_violations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.sources_violations (id, violation_id, source_id) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.system_settings (id, default_locale, locales, base_language, case_code_format, case_code_separator, auto_populate_list, unhcr_needs_codes_mapping, reporting_location_config, age_ranges, welcome_email_text_i18n, primary_age_range, location_limit_for_api, approval_forms_to_alert, changes_field_to_form, export_config_id, duplicate_export_field, primero_version, system_options, approvals_labels_i18n, config_update_lock, configuration_file_version, created_at, updated_at, incident_reporting_location_config) FROM stdin;
1	en	{en}	en	{}	\N	{"{\\"format\\": [\\"name_first\\", \\"name_middle\\", \\"name_last\\"], \\"field_key\\": \\"name\\", \\"separator\\": \\" \\", \\"auto_populated\\": true}"}	\N	{"field_key": "owned_by_location", "label_keys": ["district"], "admin_level": 1, "admin_level_map": {"0": ["country"], "1": ["state"], "2": ["municipality"], "3": ["sub_district"], "4": ["township"]}, "hierarchy_filter": []}	{"unhcr": ["0..4", "5..11", "12..17", "18..59", "60..999"], "primero": ["0..5", "6..11", "12..17", "18..999"]}	\N	primero	\N	{"assessment": "assessment", "closure_form": "closure", "cp_case_plan": "case_plan", "action_plan_form": "action_plan", "gbv_case_closure_form": "gbv_closure"}	{"notes_section": "notes", "incident_details": "incident_details_container", "services_section": "services"}	{"unhcr": "export-unhcr-csv", "duplicate_id": "export-duplicate-id-csv"}	national_id_no	2.14.5	{"show_alerts": true, "due_date_from_appointment_date": false}	{"en": {"closure": "Closure", "case_plan": "Case Plan", "assessment": "Assessment", "action_plan": "Action Plan", "gbv_closure": "GBV Closure"}}	f	\N	2026-04-22 19:33:46.988021	2026-06-09 20:11:38.840541	\N
\.


--
-- Data for Name: themes; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.themes (id, data, disabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: traces; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.traces (id, data, tracing_request_id, matched_case_id) FROM stdin;
34aa251e-3dee-43c2-b495-d50c135c8955	{"age": 8, "sex": "male", "name": "ZENENCITO", "relation": "father", "unique_id": "34aa251e-3dee-43c2-b495-d50c135c8955", "name_other": "ALEXIS", "date_of_birth": "2018-01-01", "name_nickname": "zenencito", "ftr_sought_language": ["language1"], "ftr_sought_ethnicity": "ethnicity1", "ftr_sought_nationality": ["nationality1"], "tracing_request_status": "open", "ftr_sought_document_type": "national_id", "ftr_sought_birth_date_approximate": false}	f9ea6df8-951a-4551-b8dc-e4552272df9f	\N
a3174ade-9876-419d-9c57-9706e34fce4a	{"age": 8, "sex": "male", "name": "ALEXITO", "relation": "father", "unique_id": "a3174ade-9876-419d-9c57-9706e34fce4a", "date_of_birth": "2018-01-01", "name_nickname": "alexis sanches", "separation_cause": "conflict", "ftr_sought_language": ["language1"], "location_separation": "VE", "ftr_sought_nationality": ["nationality1"], "tracing_request_status": "open", "ftr_sought_document_type": "national_id", "ftr_sought_birth_date_approximate": false}	f9ea6df8-951a-4551-b8dc-e4552272df9f	\N
\.


--
-- Data for Name: tracing_requests; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.tracing_requests (id, data, phonetic_data, srch_created_at, srch_inquiry_date, srch_status, srch_record_state, srch_flagged, srch_not_edited_by_owner, srch_owned_by_groups, srch_associated_user_agencies, srch_associated_user_names, srch_associated_user_groups, srch_owned_by, srch_owned_by_agency_id, srch_assigned_user_names) FROM stdin;
f9ea6df8-951a-4551-b8dc-e4552272df9f	{"status": "open", "flagged": false, "owned_by": "zenenperaza", "short_id": "52df0a4", "has_photo": false, "module_id": "primeromodule-cp", "posted_at": "2026-06-03T20:38:10.620Z", "created_at": "2026-06-03T20:38:10.620Z", "created_by": "zenenperaza", "inquiry_date": "2026-06-03", "record_state": true, "relation_age": 46, "tracing_names": ["ZENENCITO", "ALEXITO"], "caseworker_name": "ZENEN PERAZA", "ftr_alert_notes": "referencia", "last_updated_at": "2026-06-05T13:50:50.400+00:00", "last_updated_by": "admin", "owned_by_groups": ["usergroup-lrf-state-ve02"], "ftr_child_assent": false, "separation_cause": "conflict", "created_by_groups": ["usergroup-lrf-state-ve02"], "ftr_referral_date": "2026-06-03", "owned_by_location": "VEV", "relation_language": ["language1"], "relation_nickname": "investigador", "relation_religion": ["religion1"], "tracing_nicknames": ["zenencito", "alexis sanches"], "unique_identifier": "a8934fde-445e-4125-b07b-5b3a452df0a4", "date_of_separation": "2026-06-03", "ftr_document_notes": "obersavaciones", "ftr_related_people": [{"unique_id": "35cca5af-d8db-4776-a343-092d23fa3990", "ftr_related_person_age": 48, "ftr_related_person_sex": "male", "ftr_related_person_name": "VICULADAS 1", "ftr_related_person_type": "caregiver", "ftr_related_person_notes": "sin observacinoes", "ftr_related_person_location": "VE", "ftr_related_person_telephone": "041689745236", "ftr_related_person_relationship": "father", "ftr_related_person_date_of_birth": "1978-01-01", "ftr_related_person_document_type": "national_id", "ftr_related_person_contact_consent": true, "ftr_related_person_document_number": "14695963", "ftr_related_person_lives_with_sought_person": true}], "owned_by_agency_id": "LRF", "owned_by_full_name": "Zenen Peraza", "owned_by_user_code": "007", "relation_ethnicity": "ethnicity1", "relation_telephone": "041258936978", "tracing_request_id": "a8934fde-445e-4125-b07b-5b3a452df0a4", "current_alert_types": [], "location_separation": "VEK003", "not_edited_by_owner": true, "created_by_full_name": "Zenen Peraza", "created_organization": "LRF", "ftr_immediate_action": "referencia", "relation_nationality": ["nationality1"], "associated_user_names": ["zenenperaza"], "disclosure_other_orgs": false, "ftr_protection_alerts": ["physical_abuse", "sexual_abuse"], "associated_user_groups": ["usergroup-lrf-state-ve02"], "ftr_authorizes_contact": false, "ftr_updated_risk_level": "high", "relation_date_of_birth": "1980-01-01", "associated_user_agencies": ["LRF"], "ftr_authorizes_image_use": false, "relation_address_current": "barri las veritas", "relation_location_current": "VEK003", "ftr_case_management_required": false, "ftr_immediate_response_areas": ["health"], "ftr_family_contacts_available": false, "ftr_informed_consent_obtained": false, "ftr_immediate_response_required": true, "ftr_authorizes_information_storage": false, "ftr_authorizes_service_provider_sharing": false}	{"tokens": ["ANFS", "SNNS", "ALKS", "SNXS"]}	2026-06-03 20:38:10.62	2026-06-03 00:00:00	open	t	f	t	{usergroup-lrf-state-ve02}	{LRF}	{zenenperaza}	{usergroup-lrf-state-ve02}	zenenperaza	LRF	\N
\.


--
-- Data for Name: transitions; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.transitions (id, type, status, record_id, record_type, transitioned_to, transitioned_to_remote, transitioned_to_agency, rejected_reason, notes, transitioned_by, service, service_record_id, remote, type_of_export, consent_overridden, consent_individual_transfer, created_at, responded_at, rejection_note, record_owned_by, record_owned_by_agency, record_owned_by_groups, transitioned_by_user_agency, transitioned_by_user_groups, transitioned_to_user_agency, transitioned_to_user_groups, authorized_role_unique_id, allow_case_creation) FROM stdin;
\.


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.user_groups (id, unique_id, name, description, core_resource, disabled, created_at, updated_at) FROM stdin;
1	usergroup-primero-cp	Primero CP	Default Primero User Group for CP	f	f	2026-04-22 19:33:52.248126	2026-04-22 19:33:52.248126
3	usergroup-primero-cp-families	Primero CP with Families	Default user group for CP users with Families	f	f	2026-04-22 19:33:52.297028	2026-04-22 19:33:52.297028
2	usergroup-primero-ftr	LRF Nacional	Solicitudes de Localización - ASONACOP	f	f	2026-04-22 19:33:52.262462	2026-06-02 20:09:05.237082
24	usergroup-lrf-state-ve02	LRF - Zulia	Equipo de terreno LRF de Zulia	f	f	2026-06-02 20:09:05.774066	2026-06-03 18:33:58.04029
21	usergroup-lrf-state-ve01	LRF - Táchira	Equipo de terrino LRF de Táchira	f	f	2026-06-02 20:09:05.713209	2026-06-03 18:34:20.211435
28	usergroup-lrf-apure-eb9deda	LRF - Apure	Equipo de terreno LRF de Apure	f	f	2026-06-03 19:40:42.511481	2026-06-03 19:41:08.987243
\.


--
-- Data for Name: user_groups_users; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.user_groups_users (id, user_id, user_group_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	1
5	3	3
6	4	1
7	5	3
8	6	1
9	7	3
10	8	1
11	9	1
12	10	1
13	11	1
14	13	2
15	14	2
19	15	24
20	18	24
21	19	24
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.users (id, full_name, user_name, encrypted_password, code, phone, email, agency_id, "position", location, reporting_location_code, role_id, time_zone, locale, send_mail, disabled, services, agency_office, reset_password_token, reset_password_sent_at, created_at, updated_at, identity_provider_id, identity_provider_sync, failed_attempts, unlock_token, locked_at, service_account, code_of_conduct_accepted_on, code_of_conduct_id, receive_webpush, settings, unverified, registration_stream, data_processing_consent_provided_on, self_registered, duplicate) FROM stdin;
1	System Superuser	primero	$2a$11$4r9xfeDi5i.coAdg31EeTeRTF9pW1waZa7.9oxpxFzIkv3KhWJ9M2	\N	\N	primero@primero.com	1	\N	\N	\N	12	UTC	es	t	f	{}	\N	\N	\N	2026-04-22 19:33:52.464413	2026-06-01 20:20:36.545239	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
13	FTR Worker	primero_ftr	$2a$11$XJDrkZCv0sOQ9ct.V6ijyuN.7i3bRIDHbmevaimE/gEknnDMJJMCO	\N	\N	primero_ftr@primero.local	2	\N	\N	\N	13	UTC	es	t	f	{safehouse_service}	\N	\N	\N	2026-06-01 20:20:38.233774	2026-06-02 20:09:06.205142	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
14	FTR Manager	primero_mgr_ftr	$2a$11$UrMqbhyFoPqeCd8dgdUj4OEFIevQ9f9Qc9ChkYMkiZMJsDomJeWc.	\N	\N	primero_mgr_ftr@primero.local	2	\N	\N	\N	14	UTC	es	t	f	{safehouse_service}	\N	\N	\N	2026-06-01 20:20:38.353907	2026-06-02 20:09:06.245797	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
10	CP Worker AR	primero_cp_ar	$2a$11$GqnueA8lcbuMVzY3OBYS7u097GyVU/ExREkDEnOSAlRiuQcBZ8TS2	\N	\N	primero_cp_ar@primero.com	1	\N	\N	\N	3	UTC	ar	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.468491	2026-05-26 12:57:00.554639	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
11	CP Manager AR	primero_mgr_cp_ar	$2a$11$ow/hdYaCkTCPnw83ClOehOD.ZC8zaY2YKK9KysVmYcm3ALEH3z2D.	\N	\N	primero_mgr_cp_ar@primero.com	1	\N	\N	\N	5	UTC	ar	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.576412	2026-05-26 12:57:00.674463	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
19	MARY MELENDEZ	marymelendez	$2a$11$cWuNdAZUdZIngoi3VJrfBOMrMRfHmF2kjmB4QzI8vK5pdFWrriNnq	\N	04245034999	mmelendez@asonacop.org	2	MONITOR ESTADAL ZULIA	VE	\N	14	UTC	es	t	f	{family_seunification_service}	\N	\N	\N	2026-06-03 19:59:41.278804	2026-06-03 19:59:41.278804	\N	\N	0	\N	\N	f	\N	\N	\N	{"notifications": {"send_mail": {"approval_request": true, "transfer_request": true, "approval_response": true, "transition_notification": true}}}	f	\N	\N	f	f
2	CP Administrator	primero_admin_cp	$2a$11$C7BiZ34v03CrGAJ.HeUowezCwQnyccSh6T.Qo0MLOR5PPN0NyircC	\N	\N	primero_admin_cp@primero.com	1	\N	\N	\N	1	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:52.579945	2026-06-01 20:20:36.667736	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
3	CP Administrator with Families	primero_admin_cp_fam	$2a$11$S839j9spGozMSDe873uFBenSBfXdUdpU2mP/upYJgpUZHfzT00lRa	\N	\N	primero_admin_cp_fam@primero.com	1	\N	\N	\N	2	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:52.687139	2026-06-01 20:20:36.782212	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
4	CP Worker	primero_cp	$2a$11$jsOFhwT/G66rhED.HRf5O.CXOIBJ7dZkPKg02CzELXRHDuJ269xrS	\N	\N	primero_cp@primero.com	1	\N	\N	\N	3	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:52.804435	2026-06-01 20:20:36.890258	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
5	CP Worker with Families	primero_cp_fam	$2a$11$PBTRlsP5gox33JYSmuTY1e/dkH2Hpt4z/jKkdOEetkiizPGNhHB/q	\N	\N	primero_cp_fam@primero.com	1	\N	\N	\N	4	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:52.927042	2026-06-01 20:20:37.000785	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
6	CP Manager	primero_mgr_cp	$2a$11$OQtKjaB0cR9MyTvJ9JpHqOLfLVpwmzG63IpK0Xyvdu/KkpGGpysjm	\N	\N	primero_mgr_cp@primero.com	1	\N	\N	\N	5	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.036355	2026-06-01 20:20:37.112826	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
7	CP Manager with Families	primero_mgr_cp_fam	$2a$11$J5QWeVsDh7dLKqaxDsMnGOXPCJwTMT2VSWrEKy2i.YcshRCaxFbQ2	\N	\N	primero_mgr_cp_fam@primero.com	1	\N	\N	\N	6	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.144254	2026-06-01 20:20:37.222323	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
8	CP User Manager	primero_user_mgr_cp	$2a$11$HtGGM0f7ur5dD1nBeIMMaOJi8KgP4gLkak8xJbfLsk3b5ElgIIiTG	\N	\N	primero_user_mgr_cp@primero.com	1	\N	\N	\N	7	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.25269	2026-06-01 20:20:37.328255	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
9	Agency User Administrator	agency_user_admin	$2a$11$G.b28YhqvsKoIFvS6db3oeZmCz4weJoITqbYQv6tOLpC0OhQjtXDy	UNICEF/AGENCY_USER_ADMIN_CP	\N	agency_user_admin_cp@primero.com	1	\N	\N	\N	8	UTC	en	t	f	{}	\N	\N	\N	2026-04-22 19:33:53.36001	2026-06-01 20:20:37.433183	\N	\N	0	\N	\N	f	\N	\N	\N	\N	f	\N	\N	f	f
15	Zenen Peraza	zenenperaza	$2a$11$Wn4gpEIr63FUbWgcv1QuZeG9xKPKR96fpcv6il9NI3M1GMGhHDbSG	007	04245034999	zenenperaza@gmail.com	2	ANALISTA	VEV	\N	13	UTC	es	t	f	{family_seunification_service}	\N	\N	\N	2026-06-02 19:37:26.326873	2026-06-03 18:49:43.207124	\N	\N	0	\N	\N	f	\N	\N	\N	{"notifications": {"send_mail": {"approval_request": true, "transfer_request": true, "approval_response": true, "transition_notification": true}}}	f	\N	\N	f	f
18	DANNY PRIMERA	dannyprimera	$2a$11$9NiFZnai44JOXkbVEsXonuvmHrlCRIHSKelm7LrYOHStaWkeaLPnC	\N	04245034999	dannyprimera@gmail.com	2	MONITOR	VEV	\N	13	UTC	es	t	f	{family_seunification_service}	\N	\N	\N	2026-06-03 19:55:00.441343	2026-06-03 19:55:00.441343	\N	\N	0	\N	\N	f	\N	\N	\N	{"notifications": {"send_mail": {"approval_request": true, "transfer_request": true, "approval_response": true, "transition_notification": true}}}	f	\N	\N	f	f
12	Administrador	admin	$2a$11$4nr2fKyF9oon6DrpSnotn.Ml3rep6c0DSF4Vb2oJ8bMFzAZrIn3.C	\N	\N	peraza@outlook.com	1	\N	XX	\N	12	UTC	es	t	f	{}	\N	\N	\N	2026-04-22 19:35:19.523411	2026-06-05 14:00:11.269225	\N	\N	0	\N	\N	f	\N	\N	\N	{"notifications": {"send_mail": {"approval_request": true, "transfer_request": false, "approval_response": true, "transition_notification": false}}}	f	\N	\N	f	f
\.


--
-- Data for Name: violations; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.violations (id, data, incident_id, source_id) FROM stdin;
\.


--
-- Data for Name: webhooks; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.webhooks (id, events, url, auth_type, auth_secret_encrypted, role_unique_id, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: webpush_subscriptions; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.webpush_subscriptions (id, disabled, notification_url, auth, p256dh, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: whitelisted_jwts; Type: TABLE DATA; Schema: public; Owner: primero
--

COPY public.whitelisted_jwts (id, jti, aud, exp, user_id) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 31, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 31, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: agencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.agencies_id_seq', 2, true);


--
-- Name: agencies_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.agencies_user_groups_id_seq', 28, true);


--
-- Name: alerts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.alerts_id_seq', 1, false);


--
-- Name: attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.attachments_id_seq', 1, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1823, true);


--
-- Name: bulk_exports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.bulk_exports_id_seq', 1, false);


--
-- Name: codes_of_conduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.codes_of_conduct_id_seq', 1, true);


--
-- Name: contact_informations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.contact_informations_id_seq', 1, true);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.delayed_jobs_id_seq', 2049, true);


--
-- Name: export_configurations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.export_configurations_id_seq', 3, true);


--
-- Name: fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.fields_id_seq', 1860, true);


--
-- Name: flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.flags_id_seq', 1, false);


--
-- Name: form_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.form_sections_id_seq', 75, true);


--
-- Name: form_sections_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.form_sections_roles_id_seq', 551, true);


--
-- Name: group_victims_violations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.group_victims_violations_id_seq', 1, false);


--
-- Name: identity_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.identity_providers_id_seq', 1, false);


--
-- Name: individual_victims_violations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.individual_victims_violations_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.locations_id_seq', 372, true);


--
-- Name: lookups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.lookups_id_seq', 207, true);


--
-- Name: perpetrators_violations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.perpetrators_violations_id_seq', 1, false);


--
-- Name: primero_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.primero_modules_id_seq', 1, true);


--
-- Name: primero_modules_saved_searches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.primero_modules_saved_searches_id_seq', 1, false);


--
-- Name: primero_programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.primero_programs_id_seq', 1, true);


--
-- Name: record_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.record_histories_id_seq', 3, true);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.reports_id_seq', 39, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.roles_id_seq', 17, true);


--
-- Name: saved_searches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.saved_searches_id_seq', 1, false);


--
-- Name: searchable_identifiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.searchable_identifiers_id_seq', 2, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.sessions_id_seq', 366, true);


--
-- Name: sources_violations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.sources_violations_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 1, true);


--
-- Name: themes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.themes_id_seq', 1, false);


--
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.user_groups_id_seq', 28, true);


--
-- Name: user_groups_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.user_groups_users_id_seq', 21, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.users_id_seq', 19, true);


--
-- Name: webpush_subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.webpush_subscriptions_id_seq', 1, false);


--
-- Name: whitelisted_jwts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: primero
--

SELECT pg_catalog.setval('public.whitelisted_jwts_id_seq', 1, false);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: agencies agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies
    ADD CONSTRAINT agencies_pkey PRIMARY KEY (id);


--
-- Name: agencies_user_groups agencies_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies_user_groups
    ADD CONSTRAINT agencies_user_groups_pkey PRIMARY KEY (id);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: bulk_exports bulk_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.bulk_exports
    ADD CONSTRAINT bulk_exports_pkey PRIMARY KEY (id);


--
-- Name: case_relationships case_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.case_relationships
    ADD CONSTRAINT case_relationships_pkey PRIMARY KEY (id);


--
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);


--
-- Name: codes_of_conduct codes_of_conduct_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.codes_of_conduct
    ADD CONSTRAINT codes_of_conduct_pkey PRIMARY KEY (id);


--
-- Name: contact_informations contact_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.contact_informations
    ADD CONSTRAINT contact_informations_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: export_configurations export_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.export_configurations
    ADD CONSTRAINT export_configurations_pkey PRIMARY KEY (id);


--
-- Name: families families_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.families
    ADD CONSTRAINT families_pkey PRIMARY KEY (id);


--
-- Name: fields fields_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);


--
-- Name: flags flags_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (id);


--
-- Name: form_sections form_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections
    ADD CONSTRAINT form_sections_pkey PRIMARY KEY (id);


--
-- Name: form_sections_roles form_sections_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_roles
    ADD CONSTRAINT form_sections_roles_pkey PRIMARY KEY (id);


--
-- Name: group_victims group_victims_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.group_victims
    ADD CONSTRAINT group_victims_pkey PRIMARY KEY (id);


--
-- Name: group_victims_violations group_victims_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.group_victims_violations
    ADD CONSTRAINT group_victims_violations_pkey PRIMARY KEY (id);


--
-- Name: identity_providers identity_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.identity_providers
    ADD CONSTRAINT identity_providers_pkey PRIMARY KEY (id);


--
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- Name: individual_victims individual_victims_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.individual_victims
    ADD CONSTRAINT individual_victims_pkey PRIMARY KEY (id);


--
-- Name: individual_victims_violations individual_victims_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.individual_victims_violations
    ADD CONSTRAINT individual_victims_violations_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: lookups lookups_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.lookups
    ADD CONSTRAINT lookups_pkey PRIMARY KEY (id);


--
-- Name: perpetrators perpetrators_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.perpetrators
    ADD CONSTRAINT perpetrators_pkey PRIMARY KEY (id);


--
-- Name: perpetrators_violations perpetrators_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.perpetrators_violations
    ADD CONSTRAINT perpetrators_violations_pkey PRIMARY KEY (id);


--
-- Name: primero_configurations primero_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_configurations
    ADD CONSTRAINT primero_configurations_pkey PRIMARY KEY (id);


--
-- Name: primero_modules primero_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules
    ADD CONSTRAINT primero_modules_pkey PRIMARY KEY (id);


--
-- Name: primero_modules_saved_searches primero_modules_saved_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_saved_searches
    ADD CONSTRAINT primero_modules_saved_searches_pkey PRIMARY KEY (id);


--
-- Name: primero_programs primero_programs_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_programs
    ADD CONSTRAINT primero_programs_pkey PRIMARY KEY (id);


--
-- Name: record_histories record_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.record_histories
    ADD CONSTRAINT record_histories_pkey PRIMARY KEY (id);


--
-- Name: registry_records registry_records_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.registry_records
    ADD CONSTRAINT registry_records_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: responses responses_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.responses
    ADD CONSTRAINT responses_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: saved_searches saved_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: searchable_identifiers searchable_identifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.searchable_identifiers
    ADD CONSTRAINT searchable_identifiers_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: sources_violations sources_violations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sources_violations
    ADD CONSTRAINT sources_violations_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (id);


--
-- Name: traces traces_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT traces_pkey PRIMARY KEY (id);


--
-- Name: tracing_requests tracing_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.tracing_requests
    ADD CONSTRAINT tracing_requests_pkey PRIMARY KEY (id);


--
-- Name: transitions transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.transitions
    ADD CONSTRAINT transitions_pkey PRIMARY KEY (id);


--
-- Name: user_groups user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_groups_users user_groups_users_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups_users
    ADD CONSTRAINT user_groups_users_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: violations violations_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.violations
    ADD CONSTRAINT violations_pkey PRIMARY KEY (id);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- Name: webpush_subscriptions webpush_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.webpush_subscriptions
    ADD CONSTRAINT webpush_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: whitelisted_jwts whitelisted_jwts_pkey; Type: CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.whitelisted_jwts
    ADD CONSTRAINT whitelisted_jwts_pkey PRIMARY KEY (id);


--
-- Name: approvals_action_plan_approved_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_approved_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'approved'::text));


--
-- Name: approvals_action_plan_approved_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_approved_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'approved'::text));


--
-- Name: approvals_action_plan_approved_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_approved_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'approved'::text));


--
-- Name: approvals_action_plan_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'pending'::text));


--
-- Name: approvals_action_plan_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'pending'::text));


--
-- Name: approvals_action_plan_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'pending'::text));


--
-- Name: approvals_action_plan_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'rejected'::text));


--
-- Name: approvals_action_plan_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'rejected'::text));


--
-- Name: approvals_action_plan_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_action_plan_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_action_plan, srch_module_id) WHERE ((srch_approval_status_action_plan IS NOT NULL) AND ((srch_approval_status_action_plan)::text = 'rejected'::text));


--
-- Name: approvals_assessment_approved_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_approved_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'approved'::text));


--
-- Name: approvals_assessment_approved_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_approved_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'approved'::text));


--
-- Name: approvals_assessment_approved_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_approved_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'approved'::text));


--
-- Name: approvals_assessment_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'pending'::text));


--
-- Name: approvals_assessment_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'pending'::text));


--
-- Name: approvals_assessment_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'pending'::text));


--
-- Name: approvals_assessment_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'rejected'::text));


--
-- Name: approvals_assessment_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'rejected'::text));


--
-- Name: approvals_assessment_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_assessment_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_assessment, srch_module_id) WHERE ((srch_approval_status_assessment IS NOT NULL) AND ((srch_approval_status_assessment)::text = 'rejected'::text));


--
-- Name: approvals_case_plan_approved_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_approved_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'approved'::text));


--
-- Name: approvals_case_plan_approved_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_approved_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'approved'::text));


--
-- Name: approvals_case_plan_approved_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_approved_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'approved'::text));


--
-- Name: approvals_case_plan_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'pending'::text));


--
-- Name: approvals_case_plan_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'pending'::text));


--
-- Name: approvals_case_plan_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'pending'::text));


--
-- Name: approvals_case_plan_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'rejected'::text));


--
-- Name: approvals_case_plan_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'rejected'::text));


--
-- Name: approvals_case_plan_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_case_plan_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_case_plan, srch_module_id) WHERE ((srch_approval_status_case_plan IS NOT NULL) AND ((srch_approval_status_case_plan)::text = 'rejected'::text));


--
-- Name: approvals_closure_approved_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_approved_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'approved'::text));


--
-- Name: approvals_closure_approved_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_approved_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'approved'::text));


--
-- Name: approvals_closure_approved_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_approved_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'approved'::text));


--
-- Name: approvals_closure_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'pending'::text));


--
-- Name: approvals_closure_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'pending'::text));


--
-- Name: approvals_closure_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'pending'::text));


--
-- Name: approvals_closure_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'rejected'::text));


--
-- Name: approvals_closure_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'rejected'::text));


--
-- Name: approvals_closure_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_closure_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_closure, srch_module_id) WHERE ((srch_approval_status_closure IS NOT NULL) AND ((srch_approval_status_closure)::text = 'rejected'::text));


--
-- Name: approvals_gbv_closure_approved_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_approved_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'approved'::text));


--
-- Name: approvals_gbv_closure_approved_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_approved_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'approved'::text));


--
-- Name: approvals_gbv_closure_approved_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_approved_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'approved'::text));


--
-- Name: approvals_gbv_closure_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'pending'::text));


--
-- Name: approvals_gbv_closure_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'pending'::text));


--
-- Name: approvals_gbv_closure_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'pending'::text));


--
-- Name: approvals_gbv_closure_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'rejected'::text));


--
-- Name: approvals_gbv_closure_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'rejected'::text));


--
-- Name: approvals_gbv_closure_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX approvals_gbv_closure_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_approval_status_gbv_closure, srch_module_id) WHERE ((srch_approval_status_gbv_closure IS NOT NULL) AND ((srch_approval_status_gbv_closure)::text = 'rejected'::text));


--
-- Name: cases_case_id_unique_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX cases_case_id_unique_idx ON public.cases USING btree (((data ->> 'case_id'::text)));


--
-- Name: cases_default_associated_user_agencies_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_default_associated_user_agencies_idx ON public.cases USING btree (srch_record_state, srch_status, srch_associated_user_agencies);


--
-- Name: cases_default_associated_user_groups_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_default_associated_user_groups_idx ON public.cases USING btree (srch_record_state, srch_status, srch_associated_user_groups);


--
-- Name: cases_default_associated_user_names_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_default_associated_user_names_idx ON public.cases USING btree (srch_record_state, srch_status, srch_associated_user_names);


--
-- Name: cases_followup_subform_section_length; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_followup_subform_section_length ON public.cases USING btree (jsonb_array_length((data -> 'followup_subform_section'::text))) WHERE (jsonb_array_length((data -> 'followup_subform_section'::text)) > 0);


--
-- Name: cases_phonetic_tokens_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_phonetic_tokens_idx ON public.cases USING gin (((phonetic_data -> 'tokens'::text)));


--
-- Name: cases_services_section_length; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_services_section_length ON public.cases USING btree (jsonb_array_length((data -> 'services_section'::text))) WHERE (jsonb_array_length((data -> 'services_section'::text)) > 0);


--
-- Name: cases_srch_created_at_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_srch_created_at_idx ON public.cases USING btree (srch_created_at);


--
-- Name: cases_srch_date_closure_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_srch_date_closure_idx ON public.cases USING btree (srch_date_closure);


--
-- Name: cases_srch_registration_date_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX cases_srch_registration_date_idx ON public.cases USING btree (srch_registration_date);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX delayed_jobs_priority ON public.delayed_jobs USING btree (priority, run_at);


--
-- Name: families_created_at_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_created_at_idx ON public.families USING btree (srch_created_at);


--
-- Name: families_default_associated_user_agencies_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_default_associated_user_agencies_idx ON public.families USING btree (srch_record_state, srch_status, srch_associated_user_agencies);


--
-- Name: families_default_associated_user_groups_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_default_associated_user_groups_idx ON public.families USING btree (srch_record_state, srch_status, srch_associated_user_groups);


--
-- Name: families_default_associated_user_names_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_default_associated_user_names_idx ON public.families USING btree (srch_record_state, srch_status, srch_associated_user_names);


--
-- Name: families_family_registration_date_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_family_registration_date_idx ON public.families USING btree (srch_family_registration_date);


--
-- Name: families_tokens_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX families_tokens_idx ON public.families USING gin (((phonetic_data -> 'tokens'::text)));


--
-- Name: incidents_default_associated_user_agencies_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_default_associated_user_agencies_idx ON public.incidents USING btree (srch_record_state, srch_status, srch_associated_user_agencies);


--
-- Name: incidents_default_associated_user_groups_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_default_associated_user_groups_idx ON public.incidents USING btree (srch_record_state, srch_status, srch_associated_user_groups);


--
-- Name: incidents_default_associated_user_names_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_default_associated_user_names_idx ON public.incidents USING btree (srch_record_state, srch_status, srch_associated_user_names);


--
-- Name: incidents_incident_id_unique_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX incidents_incident_id_unique_idx ON public.incidents USING btree (((data ->> 'incident_id'::text)));


--
-- Name: incidents_phonetic_tokens_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_phonetic_tokens_idx ON public.incidents USING gin (((phonetic_data -> 'tokens'::text)));


--
-- Name: incidents_srch_created_at_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_srch_created_at_idx ON public.incidents USING btree (srch_created_at);


--
-- Name: incidents_srch_incident_date_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX incidents_srch_incident_date_idx ON public.incidents USING btree (srch_incident_date);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_agencies_on_agency_code; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_agencies_on_agency_code ON public.agencies USING btree (agency_code);


--
-- Name: index_agencies_on_services; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_agencies_on_services ON public.agencies USING gin (services);


--
-- Name: index_agencies_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_agencies_on_unique_id ON public.agencies USING btree (unique_id);


--
-- Name: index_agencies_user_groups_on_agency_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_agencies_user_groups_on_agency_id ON public.agencies_user_groups USING btree (agency_id);


--
-- Name: index_agencies_user_groups_on_user_group_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_agencies_user_groups_on_user_group_id ON public.agencies_user_groups USING btree (user_group_id);


--
-- Name: index_alerts_on_agency_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_alerts_on_agency_id ON public.alerts USING btree (agency_id);


--
-- Name: index_alerts_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_alerts_on_record_type_and_record_id ON public.alerts USING btree (record_type, record_id);


--
-- Name: index_alerts_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_alerts_on_user_id ON public.alerts USING btree (user_id);


--
-- Name: index_attachments_on_field_name; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_attachments_on_field_name ON public.attachments USING btree (field_name);


--
-- Name: index_attachments_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_attachments_on_record_type_and_record_id ON public.attachments USING btree (record_type, record_id);


--
-- Name: index_audit_logs_on_action; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_audit_logs_on_action ON public.audit_logs USING btree (action);


--
-- Name: index_audit_logs_on_metadata; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_audit_logs_on_metadata ON public.audit_logs USING gin (metadata);


--
-- Name: index_audit_logs_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_audit_logs_on_record_type_and_record_id ON public.audit_logs USING btree (record_type, record_id);


--
-- Name: index_audit_logs_on_timestamp_and_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_audit_logs_on_timestamp_and_user_id ON public.audit_logs USING btree ("timestamp", user_id);


--
-- Name: index_audit_logs_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_audit_logs_on_user_id ON public.audit_logs USING btree (user_id);


--
-- Name: index_case_relationships_on_from_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_case_relationships_on_from_case_id ON public.case_relationships USING btree (from_case_id);


--
-- Name: index_case_relationships_on_from_case_id_and_to_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_case_relationships_on_from_case_id_and_to_case_id ON public.case_relationships USING btree (from_case_id, to_case_id);


--
-- Name: index_case_relationships_on_to_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_case_relationships_on_to_case_id ON public.case_relationships USING btree (to_case_id);


--
-- Name: index_cases_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_data ON public.cases USING gin (data);


--
-- Name: index_cases_on_duplicate_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_duplicate_case_id ON public.cases USING btree (duplicate_case_id);


--
-- Name: index_cases_on_family_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_family_id ON public.cases USING btree (family_id);


--
-- Name: index_cases_on_registry_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_registry_record_id ON public.cases USING btree (registry_record_id);


--
-- Name: index_cases_on_srch_identified_at; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_srch_identified_at ON public.cases USING btree (srch_identified_at);


--
-- Name: index_cases_on_srch_identified_by; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_cases_on_srch_identified_by ON public.cases USING btree (srch_identified_by);


--
-- Name: index_export_configurations_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_export_configurations_on_unique_id ON public.export_configurations USING btree (unique_id);


--
-- Name: index_families_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_families_on_data ON public.families USING gin (data);


--
-- Name: index_fields_on_form_section_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_fields_on_form_section_id ON public.fields USING btree (form_section_id);


--
-- Name: index_fields_on_name; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_fields_on_name ON public.fields USING btree (name);


--
-- Name: index_fields_on_subform_summary; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_fields_on_subform_summary ON public.fields USING gin (subform_summary);


--
-- Name: index_fields_on_type; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_fields_on_type ON public.fields USING btree (type);


--
-- Name: index_fields_on_updated_at; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_fields_on_updated_at ON public.fields USING btree (updated_at);


--
-- Name: index_flags_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_flags_on_record_type_and_record_id ON public.flags USING btree (record_type, record_id);


--
-- Name: index_form_sections_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_form_sections_on_unique_id ON public.form_sections USING btree (unique_id);


--
-- Name: index_form_sections_primero_modules_on_form_section_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_form_sections_primero_modules_on_form_section_id ON public.form_sections_primero_modules USING btree (form_section_id);


--
-- Name: index_form_sections_primero_modules_on_primero_module_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_form_sections_primero_modules_on_primero_module_id ON public.form_sections_primero_modules USING btree (primero_module_id);


--
-- Name: index_form_sections_roles_on_form_section_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_form_sections_roles_on_form_section_id ON public.form_sections_roles USING btree (form_section_id);


--
-- Name: index_form_sections_roles_on_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_form_sections_roles_on_id ON public.form_sections_roles USING btree (id);


--
-- Name: index_form_sections_roles_on_role_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_form_sections_roles_on_role_id ON public.form_sections_roles USING btree (role_id);


--
-- Name: index_form_sections_roles_on_role_id_and_form_section_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_form_sections_roles_on_role_id_and_form_section_id ON public.form_sections_roles USING btree (role_id, form_section_id);


--
-- Name: index_group_victims_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_group_victims_on_data ON public.group_victims USING gin (data);


--
-- Name: index_group_victims_violations_on_group_victim_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_group_victims_violations_on_group_victim_id ON public.group_victims_violations USING btree (group_victim_id);


--
-- Name: index_group_victims_violations_on_violation_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_group_victims_violations_on_violation_id ON public.group_victims_violations USING btree (violation_id);


--
-- Name: index_identity_providers_on_configuration; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_identity_providers_on_configuration ON public.identity_providers USING gin (configuration);


--
-- Name: index_identity_providers_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_identity_providers_on_unique_id ON public.identity_providers USING btree (unique_id);


--
-- Name: index_incidents_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_incidents_on_data ON public.incidents USING gin (data);


--
-- Name: index_incidents_on_incident_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_incidents_on_incident_case_id ON public.incidents USING btree (incident_case_id);


--
-- Name: index_individual_victims_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_individual_victims_on_data ON public.individual_victims USING gin (data);


--
-- Name: index_individual_victims_violations_on_individual_victim_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_individual_victims_violations_on_individual_victim_id ON public.individual_victims_violations USING btree (individual_victim_id);


--
-- Name: index_individual_victims_violations_on_violation_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_individual_victims_violations_on_violation_id ON public.individual_victims_violations USING btree (violation_id);


--
-- Name: index_locations_on_hierarchy_path; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_locations_on_hierarchy_path ON public.locations USING gist (hierarchy_path);


--
-- Name: index_locations_on_location_code; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_locations_on_location_code ON public.locations USING btree (location_code);


--
-- Name: index_lookups_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_lookups_on_unique_id ON public.lookups USING btree (unique_id);


--
-- Name: index_perpetrators_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_perpetrators_on_data ON public.perpetrators USING gin (data);


--
-- Name: index_perpetrators_violations_on_perpetrator_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_perpetrators_violations_on_perpetrator_id ON public.perpetrators_violations USING btree (perpetrator_id);


--
-- Name: index_perpetrators_violations_on_violation_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_perpetrators_violations_on_violation_id ON public.perpetrators_violations USING btree (violation_id);


--
-- Name: index_primero_modules_on_primero_program_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_primero_modules_on_primero_program_id ON public.primero_modules USING btree (primero_program_id);


--
-- Name: index_primero_modules_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_primero_modules_on_unique_id ON public.primero_modules USING btree (unique_id);


--
-- Name: index_primero_modules_roles_on_primero_module_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_primero_modules_roles_on_primero_module_id ON public.primero_modules_roles USING btree (primero_module_id);


--
-- Name: index_primero_modules_roles_on_role_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_primero_modules_roles_on_role_id ON public.primero_modules_roles USING btree (role_id);


--
-- Name: index_primero_modules_roles_on_role_id_and_primero_module_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_primero_modules_roles_on_role_id_and_primero_module_id ON public.primero_modules_roles USING btree (role_id, primero_module_id);


--
-- Name: index_primero_modules_saved_searches_on_primero_module_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_primero_modules_saved_searches_on_primero_module_id ON public.primero_modules_saved_searches USING btree (primero_module_id);


--
-- Name: index_primero_modules_saved_searches_on_saved_search_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_primero_modules_saved_searches_on_saved_search_id ON public.primero_modules_saved_searches USING btree (saved_search_id);


--
-- Name: index_record_histories_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_record_histories_on_record_type_and_record_id ON public.record_histories USING btree (record_type, record_id);


--
-- Name: index_registry_records_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_registry_records_on_data ON public.registry_records USING gin (data);


--
-- Name: index_reports_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_reports_on_unique_id ON public.reports USING btree (unique_id);


--
-- Name: index_responses_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_responses_on_data ON public.responses USING gin (data);


--
-- Name: index_responses_on_violation_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_responses_on_violation_id ON public.responses USING btree (violation_id);


--
-- Name: index_roles_on_permissions; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_roles_on_permissions ON public.roles USING gin (permissions);


--
-- Name: index_roles_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_roles_on_unique_id ON public.roles USING btree (unique_id);


--
-- Name: index_saved_searches_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_saved_searches_on_user_id ON public.saved_searches USING btree (user_id);


--
-- Name: index_searchable_identifiers_on_record; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_searchable_identifiers_on_record ON public.searchable_identifiers USING btree (record_type, record_id);


--
-- Name: index_sessions_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_sessions_on_data ON public.sessions USING gin (data);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_sessions_on_session_id ON public.sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_sessions_on_updated_at ON public.sessions USING btree (updated_at);


--
-- Name: index_sources_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_sources_on_data ON public.sources USING gin (data);


--
-- Name: index_sources_violations_on_source_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_sources_violations_on_source_id ON public.sources_violations USING btree (source_id);


--
-- Name: index_sources_violations_on_violation_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_sources_violations_on_violation_id ON public.sources_violations USING btree (violation_id);


--
-- Name: index_themes_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_themes_on_data ON public.themes USING gin (data);


--
-- Name: index_traces_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_traces_on_data ON public.traces USING gin (data);


--
-- Name: index_traces_on_matched_case_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_traces_on_matched_case_id ON public.traces USING btree (matched_case_id);


--
-- Name: index_traces_on_tracing_request_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_traces_on_tracing_request_id ON public.traces USING btree (tracing_request_id);


--
-- Name: index_tracing_requests_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_tracing_requests_on_data ON public.tracing_requests USING gin (data);


--
-- Name: index_transitions_on_authorized_role_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_transitions_on_authorized_role_unique_id ON public.transitions USING btree (authorized_role_unique_id);


--
-- Name: index_transitions_on_id_and_type; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_transitions_on_id_and_type ON public.transitions USING btree (id, type);


--
-- Name: index_transitions_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_transitions_on_record_type_and_record_id ON public.transitions USING btree (record_type, record_id);


--
-- Name: index_user_groups_on_unique_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_user_groups_on_unique_id ON public.user_groups USING btree (unique_id);


--
-- Name: index_user_groups_users_on_user_group_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_user_groups_users_on_user_group_id ON public.user_groups_users USING btree (user_group_id);


--
-- Name: index_user_groups_users_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_user_groups_users_on_user_id ON public.user_groups_users USING btree (user_id);


--
-- Name: index_users_on_agency_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_users_on_agency_id ON public.users USING btree (agency_id);


--
-- Name: index_users_on_code_of_conduct_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_users_on_code_of_conduct_id ON public.users USING btree (code_of_conduct_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_identity_provider_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_users_on_identity_provider_id ON public.users USING btree (identity_provider_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_user_name; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_users_on_user_name ON public.users USING btree (user_name);


--
-- Name: index_violations_on_data; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_violations_on_data ON public.violations USING gin (data);


--
-- Name: index_violations_on_incident_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_violations_on_incident_id ON public.violations USING btree (incident_id);


--
-- Name: index_webhooks_on_events; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_webhooks_on_events ON public.webhooks USING gin (events);


--
-- Name: index_webhooks_on_url; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_webhooks_on_url ON public.webhooks USING btree (url);


--
-- Name: index_webpush_subscriptions_notification_url_user_id_disabled; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_webpush_subscriptions_notification_url_user_id_disabled ON public.webpush_subscriptions USING btree (notification_url, user_id, disabled);


--
-- Name: index_webpush_subscriptions_on_notification_url; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_webpush_subscriptions_on_notification_url ON public.webpush_subscriptions USING btree (notification_url);


--
-- Name: index_webpush_subscriptions_on_notification_url_and_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_webpush_subscriptions_on_notification_url_and_user_id ON public.webpush_subscriptions USING btree (notification_url, user_id);


--
-- Name: index_webpush_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_webpush_subscriptions_on_user_id ON public.webpush_subscriptions USING btree (user_id);


--
-- Name: index_whitelisted_jwts_on_jti; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX index_whitelisted_jwts_on_jti ON public.whitelisted_jwts USING btree (jti);


--
-- Name: index_whitelisted_jwts_on_user_id; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX index_whitelisted_jwts_on_user_id ON public.whitelisted_jwts USING btree (user_id);


--
-- Name: new_or_updated_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX new_or_updated_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_not_edited_by_owner) WHERE ((srch_record_state IS NOT NULL) AND (srch_record_state = true) AND ((srch_status IS NOT NULL) AND ((srch_status)::text = 'open'::text)) AND ((srch_not_edited_by_owner IS NOT NULL) AND (srch_not_edited_by_owner = true)));


--
-- Name: new_or_updated_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX new_or_updated_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_not_edited_by_owner) WHERE ((srch_record_state IS NOT NULL) AND (srch_record_state = true) AND ((srch_status IS NOT NULL) AND ((srch_status)::text = 'open'::text)) AND ((srch_not_edited_by_owner IS NOT NULL) AND (srch_not_edited_by_owner = true)));


--
-- Name: new_or_updated_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX new_or_updated_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_not_edited_by_owner) WHERE ((srch_record_state IS NOT NULL) AND (srch_record_state = true) AND ((srch_status IS NOT NULL) AND ((srch_status)::text = 'open'::text)) AND ((srch_not_edited_by_owner IS NOT NULL) AND (srch_not_edited_by_owner = true)));


--
-- Name: registry_records_phonetic_tokens_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX registry_records_phonetic_tokens_idx ON public.registry_records USING gin (((phonetic_data -> 'tokens'::text)));


--
-- Name: risk_level_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX risk_level_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_risk_level);


--
-- Name: risk_level_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX risk_level_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_risk_level);


--
-- Name: risk_level_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX risk_level_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_risk_level);


--
-- Name: searchable_identifiers_value_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX searchable_identifiers_value_idx ON public.searchable_identifiers USING gin (value public.gin_trgm_ops);


--
-- Name: shared_with_me_new_referrals_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_new_referrals_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_referred_users, srch_last_updated_by);


--
-- Name: shared_with_me_new_referrals_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_new_referrals_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_referred_users, srch_last_updated_by);


--
-- Name: shared_with_me_new_referrals_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_new_referrals_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_referred_users, srch_last_updated_by);


--
-- Name: shared_with_me_transfers_awaiting_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_transfers_awaiting_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_transferred_to_users);


--
-- Name: shared_with_me_transfers_awaiting_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_transfers_awaiting_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_transferred_to_users);


--
-- Name: shared_with_me_transfers_awaiting_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_me_transfers_awaiting_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_transferred_to_users);


--
-- Name: shared_with_others_referrals_users_present_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_referrals_users_present_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_referred_users_present, srch_owned_by) WHERE ((srch_referred_users_present IS NOT NULL) AND (srch_referred_users_present = true));


--
-- Name: shared_with_others_referrals_users_present_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_referrals_users_present_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_referred_users_present, srch_owned_by) WHERE ((srch_referred_users_present IS NOT NULL) AND (srch_referred_users_present = true));


--
-- Name: shared_with_others_referrals_users_present_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_referrals_users_present_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_referred_users_present, srch_owned_by) WHERE ((srch_referred_users_present IS NOT NULL) AND (srch_referred_users_present = true));


--
-- Name: shared_with_others_transfers_pending_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_pending_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'in_progress'::text));


--
-- Name: shared_with_others_transfers_pending_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_pending_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'in_progress'::text));


--
-- Name: shared_with_others_transfers_pending_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_pending_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'in_progress'::text));


--
-- Name: shared_with_others_transfers_rejected_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_rejected_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'rejected'::text));


--
-- Name: shared_with_others_transfers_rejected_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_rejected_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'rejected'::text));


--
-- Name: shared_with_others_transfers_rejected_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX shared_with_others_transfers_rejected_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_record_state, srch_status, srch_transfer_status, srch_owned_by) WHERE ((srch_transfer_status IS NOT NULL) AND ((srch_transfer_status)::text = 'rejected'::text));


--
-- Name: tracing_requests_default_associated_user_agencies_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_default_associated_user_agencies_idx ON public.tracing_requests USING btree (srch_record_state, srch_status, srch_associated_user_agencies);


--
-- Name: tracing_requests_default_associated_user_groups_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_default_associated_user_groups_idx ON public.tracing_requests USING btree (srch_record_state, srch_status, srch_associated_user_groups);


--
-- Name: tracing_requests_default_associated_user_names_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_default_associated_user_names_idx ON public.tracing_requests USING btree (srch_record_state, srch_status, srch_associated_user_names);


--
-- Name: tracing_requests_phonetic_tokens_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_phonetic_tokens_idx ON public.tracing_requests USING gin (((phonetic_data -> 'tokens'::text)));


--
-- Name: tracing_requests_srch_created_at_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_srch_created_at_idx ON public.tracing_requests USING btree (srch_created_at);


--
-- Name: tracing_requests_srch_inquiry_date_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX tracing_requests_srch_inquiry_date_idx ON public.tracing_requests USING btree (srch_inquiry_date);


--
-- Name: tracing_requests_tracing_request_id_unique_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE UNIQUE INDEX tracing_requests_tracing_request_id_unique_idx ON public.tracing_requests USING btree (((data ->> 'tracing_request_id'::text)));


--
-- Name: workflow_dashboard_agency_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX workflow_dashboard_agency_idx ON public.cases USING btree (srch_associated_user_agencies, srch_owned_by, srch_record_state, srch_status, srch_module_id, srch_workflow);


--
-- Name: workflow_dashboard_group_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX workflow_dashboard_group_idx ON public.cases USING btree (srch_associated_user_groups, srch_owned_by, srch_record_state, srch_status, srch_module_id, srch_workflow);


--
-- Name: workflow_dashboard_user_idx; Type: INDEX; Schema: public; Owner: primero
--

CREATE INDEX workflow_dashboard_user_idx ON public.cases USING btree (srch_associated_user_names, srch_owned_by, srch_record_state, srch_status, srch_module_id, srch_workflow);


--
-- Name: fields fk_rails_140c8ee70d; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fk_rails_140c8ee70d FOREIGN KEY (form_section_id) REFERENCES public.form_sections(id);


--
-- Name: traces fk_rails_1d0d72fdc8; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT fk_rails_1d0d72fdc8 FOREIGN KEY (matched_case_id) REFERENCES public.cases(id);


--
-- Name: user_groups_users fk_rails_1e1f78cc9c; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups_users
    ADD CONSTRAINT fk_rails_1e1f78cc9c FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: alerts fk_rails_2387e5a488; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_rails_2387e5a488 FOREIGN KEY (agency_id) REFERENCES public.agencies(id);


--
-- Name: cases fk_rails_23af31a2f2; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT fk_rails_23af31a2f2 FOREIGN KEY (matched_tracing_request_id) REFERENCES public.tracing_requests(id);


--
-- Name: individual_victims_violations fk_rails_256851ab96; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.individual_victims_violations
    ADD CONSTRAINT fk_rails_256851ab96 FOREIGN KEY (violation_id) REFERENCES public.violations(id);


--
-- Name: users fk_rails_28e992a736; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_28e992a736 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_providers(id);


--
-- Name: traces fk_rails_3693ca1acd; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.traces
    ADD CONSTRAINT fk_rails_3693ca1acd FOREIGN KEY (tracing_request_id) REFERENCES public.tracing_requests(id);


--
-- Name: primero_modules_roles fk_rails_37b05ca3fd; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_roles
    ADD CONSTRAINT fk_rails_37b05ca3fd FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: responses fk_rails_3836dc1abe; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.responses
    ADD CONSTRAINT fk_rails_3836dc1abe FOREIGN KEY (violation_id) REFERENCES public.violations(id);


--
-- Name: case_relationships fk_rails_46e89b4820; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.case_relationships
    ADD CONSTRAINT fk_rails_46e89b4820 FOREIGN KEY (from_case_id) REFERENCES public.cases(id);


--
-- Name: fields fk_rails_491969bfbf; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fk_rails_491969bfbf FOREIGN KEY (subform_section_id) REFERENCES public.form_sections(id);


--
-- Name: form_sections_roles fk_rails_4bfc25265b; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_roles
    ADD CONSTRAINT fk_rails_4bfc25265b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: agencies_user_groups fk_rails_529c95d603; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies_user_groups
    ADD CONSTRAINT fk_rails_529c95d603 FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: users fk_rails_627daf9bbe; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_627daf9bbe FOREIGN KEY (agency_id) REFERENCES public.agencies(id);


--
-- Name: saved_searches fk_rails_63c5382842; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.saved_searches
    ADD CONSTRAINT fk_rails_63c5382842 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: group_victims_violations fk_rails_69939a5160; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.group_victims_violations
    ADD CONSTRAINT fk_rails_69939a5160 FOREIGN KEY (violation_id) REFERENCES public.violations(id);


--
-- Name: cases fk_rails_83cfb2e561; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT fk_rails_83cfb2e561 FOREIGN KEY (family_id) REFERENCES public.families(id);


--
-- Name: agencies_user_groups fk_rails_85e5cd4603; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.agencies_user_groups
    ADD CONSTRAINT fk_rails_85e5cd4603 FOREIGN KEY (agency_id) REFERENCES public.agencies(id);


--
-- Name: form_sections_roles fk_rails_88632a83ce; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_roles
    ADD CONSTRAINT fk_rails_88632a83ce FOREIGN KEY (form_section_id) REFERENCES public.form_sections(id);


--
-- Name: cases fk_rails_8ed87b9d91; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT fk_rails_8ed87b9d91 FOREIGN KEY (registry_record_id) REFERENCES public.registry_records(id);


--
-- Name: individual_victims_violations fk_rails_9083fdd40b; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.individual_victims_violations
    ADD CONSTRAINT fk_rails_9083fdd40b FOREIGN KEY (individual_victim_id) REFERENCES public.individual_victims(id);


--
-- Name: webpush_subscriptions fk_rails_90c23a43b6; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.webpush_subscriptions
    ADD CONSTRAINT fk_rails_90c23a43b6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_groups_users fk_rails_98466c2677; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.user_groups_users
    ADD CONSTRAINT fk_rails_98466c2677 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: perpetrators_violations fk_rails_9f7dff9771; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.perpetrators_violations
    ADD CONSTRAINT fk_rails_9f7dff9771 FOREIGN KEY (violation_id) REFERENCES public.violations(id);


--
-- Name: form_sections_primero_modules fk_rails_a4ead8a6f6; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_primero_modules
    ADD CONSTRAINT fk_rails_a4ead8a6f6 FOREIGN KEY (form_section_id) REFERENCES public.form_sections(id);


--
-- Name: sources_violations fk_rails_a79bc00145; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sources_violations
    ADD CONSTRAINT fk_rails_a79bc00145 FOREIGN KEY (violation_id) REFERENCES public.violations(id);


--
-- Name: case_relationships fk_rails_b82f94b073; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.case_relationships
    ADD CONSTRAINT fk_rails_b82f94b073 FOREIGN KEY (to_case_id) REFERENCES public.cases(id);


--
-- Name: cases fk_rails_bbb21d6cce; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT fk_rails_bbb21d6cce FOREIGN KEY (duplicate_case_id) REFERENCES public.cases(id);


--
-- Name: primero_modules_roles fk_rails_c224a4367d; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_roles
    ADD CONSTRAINT fk_rails_c224a4367d FOREIGN KEY (primero_module_id) REFERENCES public.primero_modules(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: users fk_rails_c4f7ea32ba; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_c4f7ea32ba FOREIGN KEY (code_of_conduct_id) REFERENCES public.codes_of_conduct(id);


--
-- Name: sources_violations fk_rails_ca3335a314; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.sources_violations
    ADD CONSTRAINT fk_rails_ca3335a314 FOREIGN KEY (source_id) REFERENCES public.sources(id);


--
-- Name: group_victims_violations fk_rails_cc009128b2; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.group_victims_violations
    ADD CONSTRAINT fk_rails_cc009128b2 FOREIGN KEY (group_victim_id) REFERENCES public.group_victims(id);


--
-- Name: alerts fk_rails_d4053234e7; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT fk_rails_d4053234e7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: incidents fk_rails_db1b2a2812; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT fk_rails_db1b2a2812 FOREIGN KEY (incident_case_id) REFERENCES public.cases(id);


--
-- Name: perpetrators_violations fk_rails_e077c14810; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.perpetrators_violations
    ADD CONSTRAINT fk_rails_e077c14810 FOREIGN KEY (perpetrator_id) REFERENCES public.perpetrators(id);


--
-- Name: primero_modules_saved_searches fk_rails_e88da5b7f5; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_saved_searches
    ADD CONSTRAINT fk_rails_e88da5b7f5 FOREIGN KEY (primero_module_id) REFERENCES public.primero_modules(id);


--
-- Name: form_sections_primero_modules fk_rails_eac282d7e1; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.form_sections_primero_modules
    ADD CONSTRAINT fk_rails_eac282d7e1 FOREIGN KEY (primero_module_id) REFERENCES public.primero_modules(id);


--
-- Name: primero_modules_saved_searches fk_rails_f25b6eff10; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules_saved_searches
    ADD CONSTRAINT fk_rails_f25b6eff10 FOREIGN KEY (saved_search_id) REFERENCES public.saved_searches(id);


--
-- Name: primero_modules fk_rails_f52bef17bb; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.primero_modules
    ADD CONSTRAINT fk_rails_f52bef17bb FOREIGN KEY (primero_program_id) REFERENCES public.primero_programs(id);


--
-- Name: violations fk_rails_f84e2a5f07; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.violations
    ADD CONSTRAINT fk_rails_f84e2a5f07 FOREIGN KEY (incident_id) REFERENCES public.incidents(id);


--
-- Name: whitelisted_jwts fk_rails_fb288e0065; Type: FK CONSTRAINT; Schema: public; Owner: primero
--

ALTER TABLE ONLY public.whitelisted_jwts
    ADD CONSTRAINT fk_rails_fb288e0065 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: primero
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

