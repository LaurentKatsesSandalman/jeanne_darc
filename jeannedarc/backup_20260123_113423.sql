--
-- PostgreSQL database dump
--

\restrict oDn3yGn5oZd4gKeRGgOxCxXDDiGpYWwx0gg3aKRIftfp3t3q1ouukRgUJ2AaMG8

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.7

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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

    NEW.updated_at = NOW();

    RETURN NEW;

END;

$$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


--
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


--
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


--
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


--
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


--
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


--
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


--
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


--
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


--
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: contenu_bandeaubtn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_bandeaubtn (
    id_contenu_bandeaubtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    icone text DEFAULT ''::text NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_contact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_contact (
    id_contenu_contact uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    champ1 text DEFAULT ''::text NOT NULL,
    champ2 text DEFAULT ''::text NOT NULL,
    champ3 text DEFAULT ''::text NOT NULL,
    champ4 text DEFAULT ''::text NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_headerbtn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_headerbtn (
    id_contenu_headerbtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    "position" smallint NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id_page_fk uuid NOT NULL
);


--
-- Name: contenu_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_image (
    id_contenu_image uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    image_url text DEFAULT ''::text NOT NULL,
    alt_text text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_pave; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_pave (
    id_contenu_pave uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    titre text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_pdf; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_pdf (
    id_contenu_pdf uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    pdf_url text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    pdf_titre text DEFAULT ''::text NOT NULL
);


--
-- Name: contenu_solobtn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_solobtn (
    id_contenu_solobtn uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    bouton text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_texte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_texte (
    id_contenu_texte uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    tiptap_content jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: contenu_titre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contenu_titre (
    id_contenu_titre uuid DEFAULT gen_random_uuid() NOT NULL,
    id_section_fk uuid NOT NULL,
    is_mega boolean DEFAULT false NOT NULL,
    titre1 text DEFAULT ''::text NOT NULL,
    titre2 text DEFAULT ''::text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page (
    id_page uuid DEFAULT gen_random_uuid() NOT NULL,
    page_url text NOT NULL,
    nom text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: pave_bloc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pave_bloc (
    id_pave_bloc uuid DEFAULT gen_random_uuid() NOT NULL,
    id_contenu_pave_fk uuid NOT NULL,
    icone text DEFAULT ''::text NOT NULL,
    soustitre text DEFAULT ''::text NOT NULL,
    description1 text DEFAULT ''::text NOT NULL,
    lien_vers text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    description2 text DEFAULT ''::text NOT NULL,
    description3 text DEFAULT ''::text NOT NULL,
    description4 text DEFAULT ''::text NOT NULL,
    description5 text DEFAULT ''::text NOT NULL,
    description6 text DEFAULT ''::text NOT NULL,
    description7 text DEFAULT ''::text NOT NULL
);


--
-- Name: section; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.section (
    id_section uuid DEFAULT gen_random_uuid() NOT NULL,
    id_page_fk uuid NOT NULL,
    type text NOT NULL,
    revert boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: text_index; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.text_index (
    id_text_index uuid DEFAULT gen_random_uuid() NOT NULL,
    id_page_fk uuid NOT NULL,
    ref_table text NOT NULL,
    ref_id uuid NOT NULL,
    content_plaintext text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.utilisateur (
    id_utilisateur uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    name text NOT NULL,
    password text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: contenu_bandeaubtn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_bandeaubtn (id_contenu_bandeaubtn, id_section_fk, icone, titre, description, bouton, lien_vers, created_at, updated_at) FROM stdin;
a55f1030-e11f-4545-966f-d1dac1e726e0	24927bed-1f90-4a4b-995f-9c7a548e8fa2	BigCalendarBigIcon	pré-inscription	Demande de Pré-Inscription de votre enfant à l’école JEANNE D’ARC	pré-inscriptions	https://preinscriptions.ecoledirecte.com/?RNE=0331922K&ETAB=EC	2026-01-12 14:40:23.356019+00	2026-01-12 14:41:15.74017+00
cce2a1e0-463e-403e-89ac-35ec8e2d0795	df2360f2-49bc-46c9-a7b5-9dce3de86043	AAAEmpty2BigIcon			 LIEN DE PRÉ-INSCRIPTION	https://preinscriptions.ecoledirecte.com/?RNE=0331922K&ETAB=EC	2026-01-14 09:41:39.310957+00	2026-01-14 09:42:06.630882+00
b1615ac4-2cda-43cd-965a-93dfe9b7ae56	cad4f442-ee3d-48a1-949c-e71800b3beba	BigDiplomaBigIcon		Accéder aux notes, aux devoirs et à toutes les informations de votre enfant à l’école	école directe	https://www.ecoledirecte.com/login	2026-01-14 09:43:38.39379+00	2026-01-14 09:53:57.790452+00
cb24a194-f802-4364-828a-6e38ae3ca88e	640a25da-7d94-4216-97a9-806118e14fbc	AAAEmpty2BigIcon	Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023		commander la blouse	https://www.letablierbobine.fr/produits?school=jdalebouscat#product-list%0Acode%20d'acc%C3%A8s%20:%20jdalebouscat	2026-01-09 07:51:47.757887+00	2026-01-14 09:55:56.644659+00
371922a6-19cf-4d07-8fd7-c4383b873e75	1fd4931c-5d7e-40c3-b0a6-409b099dd5aa	AAAEmpty2BigIcon			Commander la blouse	https://www.letablierbobine.fr/produits?school=jdalebouscat#product-list%0Acode%20d'acc%C3%A8s%20:%20jdalebouscat	2026-01-14 09:58:29.826793+00	2026-01-14 09:58:56.380053+00
\.


--
-- Data for Name: contenu_contact; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_contact (id_contenu_contact, id_section_fk, titre, champ1, champ2, champ3, champ4, bouton, created_at, updated_at) FROM stdin;
cf3e95a5-2aa4-4cf7-962e-2a10bfc87a73	0d1f84b7-acb1-4cf7-aa2c-30a8c4ba27e6	LAISSEZ-NOUS UN MESSAGE	Nom et prénom	Numéro de téléphone	Adresse mail de contact	Votre message	Envoyer	2026-01-22 16:39:52.347119+00	2026-01-22 16:39:52.347119+00
\.


--
-- Data for Name: contenu_headerbtn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_headerbtn (id_contenu_headerbtn, id_section_fk, "position", bouton, lien_vers, created_at, updated_at, id_page_fk) FROM stdin;
11b17fd2-e045-4e39-8315-db8fa7319c6d	6c86d086-0014-4b2c-ad71-573706d345e1	1	projets	/projets	2026-01-05 10:08:14.905232+00	2026-01-06 10:21:48.211512+00	8cecaa91-a539-45fe-8151-a8650934ee7a
89dc08e8-6342-435e-ab91-3ba0d1958d2e	6c86d086-0014-4b2c-ad71-573706d345e1	3	projet pédagogique	/projets/projet-pedagogique	2026-01-05 10:08:23.150542+00	2026-01-06 10:21:48.211512+00	e11935b9-f19d-41ee-a061-d3f9bd26afde
30d95638-16cc-4c9a-8b06-15b6023e91c7	6c86d086-0014-4b2c-ad71-573706d345e1	4	projet pastoral	/projets/projet-pastoral	2026-01-05 10:08:27.614928+00	2026-01-06 10:21:48.211512+00	ccd9338f-0f5c-42a2-9b3e-465645c80ff2
cc1ee6cc-1292-46c1-a7f2-6bfdbc26f244	05ee1e16-c142-42b5-b459-afcc593e3393	1	pré-inscriptions	/pre-inscriptions	2026-01-05 10:08:31.520127+00	2026-01-06 10:21:48.211512+00	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e
b8ca932b-df3c-4e71-a5cb-a6631e37cf00	bed09afd-02b1-4036-87a7-8a95c7918a28	1	contact	/contact	2026-01-05 10:08:42.881036+00	2026-01-06 10:21:48.211512+00	64d857cc-b5f2-4b09-9024-46789bfef3ea
a438debb-0561-4fdc-82de-cdcd4e524e6a	516ca4e0-1661-4991-ab84-b5d5b3b52a27	1	plus	/plus	2026-01-05 10:08:36.362199+00	2026-01-06 10:21:48.211512+00	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3
217eb06c-a158-4b80-abc7-e428e5517e2a	516ca4e0-1661-4991-ab84-b5d5b3b52a27	2	école directe	/plus/ecole-directe	2026-01-05 10:08:39.902771+00	2026-01-06 10:21:48.211512+00	295029ce-e0e9-475a-ae67-574139fa31b2
1a06712b-a0a6-47a2-a8c6-1b0aa7a6e37d	516ca4e0-1661-4991-ab84-b5d5b3b52a27	3	règlement intérieur	/plus/reglement	2026-01-05 13:41:34.553345+00	2026-01-06 10:21:48.211512+00	6446302e-8285-44c0-95df-b49cf8b080bb
c86d4854-54d1-4a6c-b902-b88e29f6caae	516ca4e0-1661-4991-ab84-b5d5b3b52a27	4	Blouses JDA	/plus/blouses	2026-01-05 13:42:52.308789+00	2026-01-06 10:21:48.211512+00	c336b0b8-e554-494d-8837-2f8e2bf4bc85
ccac5f6a-771f-4f73-a48d-76dd1f164f15	516ca4e0-1661-4991-ab84-b5d5b3b52a27	5	Tarifs	/plus/tarifs	2026-01-05 13:43:35.841314+00	2026-01-06 10:21:48.211512+00	c740cf55-6c49-4919-b2d8-e1f6e74e0230
7a09d21d-0a0c-402d-8959-1bc4eaa5591d	516ca4e0-1661-4991-ab84-b5d5b3b52a27	6	OGEC	/plus/ogec	2026-01-05 13:44:17.837002+00	2026-01-06 10:21:48.211512+00	f7c70f0c-23ce-4736-9328-15237670045c
e439a303-2919-4dd9-a881-9dc3f2bf8083	6c86d086-0014-4b2c-ad71-573706d345e1	2	projet éducatif	/projets/projet-educatif	2026-01-05 10:08:19.324654+00	2026-01-06 10:21:48.211512+00	74d676f1-767e-4350-8a41-9c1c0999faf7
8860014a-6584-42fb-ae7b-4bd67da91603	8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	1	accueil	/	2026-01-05 10:08:10.883783+00	2026-01-06 10:24:06.596211+00	8166954f-eb2d-48ed-a915-e207ae1406e4
8909eca5-7749-4f52-ba3c-9c908e84a67f	8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	2	Histoire de l'école	/presentation-histoire	2026-01-12 13:34:21.022578+00	2026-01-12 13:34:21.022578+00	d3d52cd8-5458-44a7-bf81-3f4986377e6a
\.


--
-- Data for Name: contenu_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_image (id_contenu_image, id_section_fk, image_url, alt_text, lien_vers, created_at, updated_at) FROM stdin;
ce425a7e-c10e-4416-a70d-326c44ae2f82	a67777de-6746-4910-823f-ec604fa6363a	/api/files/ce425a7e-c10e-4416-a70d-326c44ae2f82?t=1769076747211	Schéma en pétales : pétale 1 ( intériorité, liberté, fraternité, hospitalité), pétale 2 (responsabilité, curiosité, estime de soi), pétale 3 (accueil, bienveillance, partage, communauté)		2026-01-14 09:32:36.994238+00	2026-01-22 10:34:23.337073+00
1409095f-f110-473a-aaa1-47deef6bbf0d	121ace6e-3bba-49ce-a70f-ff02bac25060	/api/files/1409095f-f110-473a-aaa1-47deef6bbf0d?t=1769156326448	Fronton de l'institution Jeanne d'Arc		2026-01-12 14:40:06.775833+00	2026-01-23 08:18:48.392487+00
2eb6341f-1456-4ccb-8609-e3f85aef1d29	f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	/api/files/2eb6341f-1456-4ccb-8609-e3f85aef1d29?t=1769156350597	Photo de Madame Estrampe		2026-01-14 09:16:38.996071+00	2026-01-23 08:19:12.380592+00
ba19954f-6152-40c7-9e17-57a2648cc5ba	8a1ed75d-0ad1-4339-9cbe-45fe3418009a	/api/files/ba19954f-6152-40c7-9e17-57a2648cc5ba?t=1769156371902	Equipe de l'école privée Jeanne d'Arc - Le Bouscat - année scolaire 2025/2026		2026-01-14 09:25:33.92772+00	2026-01-23 08:19:33.810822+00
0f3b344e-4bdf-4374-a669-a852d2aa95f9	dad61c44-7a22-4307-8e63-cbe1a7847346	/api/files/0f3b344e-4bdf-4374-a669-a852d2aa95f9?t=1769156398777	Cour de récréation, illustration		2026-01-13 13:22:29.804974+00	2026-01-23 08:20:00.568079+00
71c9a03b-a74d-41bf-9fb1-d94eabad38e0	610a236a-6c92-46e1-b281-41060ac503e8	/api/files/71c9a03b-a74d-41bf-9fb1-d94eabad38e0?t=1769156453183	Schéma projet pédagogique et pastoral		2025-12-17 12:02:16.116947+00	2026-01-23 08:20:54.962497+00
5abd390b-4136-42ee-a99e-b0ac5964ade2	4e3b39ec-7f51-4444-a2ec-b318c9522e0e	/api/files/5abd390b-4136-42ee-a99e-b0ac5964ade2?t=1769156486448	la crèche de Noël		2026-01-07 16:12:05.61063+00	2026-01-23 08:21:28.425751+00
8bc01f96-d279-41f2-bc5a-9034ed6c720c	30c8a13e-ac22-4c2d-a150-dca3093f3661	/api/files/8bc01f96-d279-41f2-bc5a-9034ed6c720c?t=1769156507952	schéma du projet pastoral		2026-01-07 16:19:13.474066+00	2026-01-23 08:21:49.888901+00
77faf54b-5d6c-43c6-9537-f0eb2f03fe61	cf221b63-3868-42c3-ac1a-ee9e456eadef	/api/files/77faf54b-5d6c-43c6-9537-f0eb2f03fe61?t=1769156834607			2026-01-14 10:01:34.59434+00	2026-01-23 08:27:16.55583+00
0dfd1736-cced-4966-8a0a-1364ca53ee14	0d1f84b7-acb1-4cf7-aa2c-30a8c4ba27e6	/api/files/0dfd1736-cced-4966-8a0a-1364ca53ee14?t=1769161656983			2026-01-22 16:39:52.172309+00	2026-01-23 09:47:38.98294+00
\.


--
-- Data for Name: contenu_pave; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_pave (id_contenu_pave, id_section_fk, titre, created_at, updated_at) FROM stdin;
33da439e-f856-4562-ab64-1db067c416a1	fcb5856f-3ac2-4d04-becb-081b588b0464	LE PROJET D’ÉTABLISSEMENT	2026-01-13 13:23:47.373832+00	2026-01-13 13:24:10.206069+00
fd346e21-5871-4d15-a152-53f3c8671fc1	3ec7ccdc-46fc-426d-8cbb-92d38d59c10e		2026-01-13 11:21:16.8551+00	2026-01-13 14:50:37.128968+00
b0479b65-e5cf-4de2-bb5c-42c234df8342	d789a75b-2f50-418a-b4a6-00e77dfe6581		2026-01-13 15:51:35.676811+00	2026-01-13 15:51:35.676811+00
dc6fc558-8f03-40e6-8e70-0e5e28a3198d	2190e0a1-cf08-4f3c-98a8-002c1e4ad2a1		2026-01-14 08:00:20.589213+00	2026-01-14 08:00:20.589213+00
\.


--
-- Data for Name: contenu_pdf; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_pdf (id_contenu_pdf, id_section_fk, pdf_url, created_at, updated_at, pdf_titre) FROM stdin;
e943d4b8-6444-4705-be99-1907d91bf5ac	4ac5f0aa-48d0-4ee1-b342-2c31801f7dc4	/api/files/e943d4b8-6444-4705-be99-1907d91bf5ac?t=1769078478658	2026-01-07 16:31:34.487794+00	2026-01-22 10:41:20.112407+00	Règlement intérieur
7985ea3e-37a6-4516-8f11-83aceddc17d6	62f8c8a7-f586-4a6b-bece-806cb37675a7	/api/files/7985ea3e-37a6-4516-8f11-83aceddc17d6?t=1769156740605	2026-01-14 09:57:08.045433+00	2026-01-23 08:25:42.540896+00	Commande de la blouse Jeanne d'Arc
11c1c10c-db3a-4f63-85c9-812d811d7ea8	602196fd-53b4-4752-b05a-cc569b22b61a	/api/files/11c1c10c-db3a-4f63-85c9-812d811d7ea8?t=1769156796314	2026-01-14 09:59:55.91033+00	2026-01-23 08:26:38.23654+00	TARIFS 2025-2026
\.


--
-- Data for Name: contenu_solobtn; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_solobtn (id_contenu_solobtn, id_section_fk, bouton, lien_vers, created_at, updated_at) FROM stdin;
2f196cfe-4e52-4af7-a829-03846f3151fc	121ace6e-3bba-49ce-a70f-ff02bac25060	histoire de l'école	/presentation-histoire	2026-01-12 14:45:51.445687+00	2026-01-12 14:52:30.801513+00
e72ad051-52db-4210-af60-5dc7759ba3da	121ace6e-3bba-49ce-a70f-ff02bac25060	voir le projet d'établissement	/projets	2026-01-12 14:52:37.722832+00	2026-01-12 14:52:56.504612+00
243fa9b0-f121-45f8-ab2f-07eb966b9e6d	121ace6e-3bba-49ce-a70f-ff02bac25060	nous contacter	/contact	2026-01-13 15:50:41.686777+00	2026-01-13 15:50:57.642558+00
\.


--
-- Data for Name: contenu_texte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_texte (id_contenu_texte, id_section_fk, tiptap_content, created_at, updated_at) FROM stdin;
fec83639-9b1a-4480-929e-2c2b01cb7c52	610a236a-6c92-46e1-b281-41060ac503e8	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "S’émerveiller d’apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Un climat de classe et d’école serein pour bien apprendre et bien vivre ensemble", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La Classe-qualité : réflexion et attention afin de répondre aux besoins des élèves pour bien apprendre. Donner la possibilité à nos élèves de restituer et d’offrir : lors des spectacles, de mises en scène, de chorale…", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "S’engager activement dans ses apprentissages", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Accompagner nos élèves à développer le questionnement et la réflexion", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Travailler ensemble", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Se mettre en projet", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Apprendre à apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Les apports des neurosciences et de la gestion mentale pour mieux apprendre", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La place du statut de l’erreur", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La cohérence pédagogique", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2025-12-17 12:02:11.532495+00	2025-12-17 15:37:35.449017+00
df61c9a8-ea5c-4a72-9724-05b8875fdee2	2e5b0548-c923-45c8-80b5-6e045a4877f5	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": "center"}, "content": [{"text": "L’école met au centre de la vie scolaire 6 piliers.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(191, 55, 19)"}}, {"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La culture littéraire : « Silence On Lit », mini-médiathèque, les incorruptibles, participation au salon du livre du Bouscat.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Le sport et l’éducation sportive : utilisation des installations sportives et animateurs sportifs de la ville et de l’école, animations sportives sur la pause méridienne.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "La culture numérique : Toutes les classes de l’école est équipée de VPI, et d’une flotte d’IPAD qui servent de support aux apprentissages des élèves.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’anglais : des cours d’anglais et des « English Games » sont proposés à tous les élèves (de la Petite Section au CM2) par une personne native anglophone.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Un projet d’école annuel : chaque année, un thème d’année est choisi en lien avec un mode différent d’intelligence.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Les activités culturelles : Tout au long de l’année, les élèves participent à des spectacles, des expositions… , en lien et en illustration avec les apprentissages.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2025-12-17 12:02:11.532495+00	2025-12-17 12:57:03.96492+00
b7895663-f2b4-49c5-bd35-b0381032d3b5	4e3b39ec-7f51-4444-a2ec-b318c9522e0e	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Vivre en Frères :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(246, 174, 59)"}}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Écoute, accueil, convivialité : rencontres proposées aux familles pour mieux se connaître et échanger.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Service : mise à disposition des talents des uns et des autres pour l’école et l’entraide.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Actions solidaires.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "heading", "attrs": {"level": 2, "textAlign": null}, "content": [{"text": "Pour découvrir la parole de Dieu :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(246, 174, 59)"}}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Éveil à la foi pour les plus jeunes et catéchèse pour les autres", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "T", "type": "text"}, {"text": "emps pastoraux et communautaires : 3 samedis dans l’année", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Temps spirituels, prières, célébrations", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-07 16:12:05.683094+00	2026-01-07 16:15:13.227755+00
1b3cf84e-e381-4009-b3c9-367f546ab1eb	f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école Jeanne d’Arc est officiellement créée le 29 août 1902.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "Le premier octobre 1902, Madame Estrampes ouvre l’école sur la propriété que possède son mari depuis 1884 au 45 rue Francis de Pressensé. École privée de filles, certes, où les registres portent parfois les noms d’Albert, Auguste, Paul… !", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école se développe et les directrices se succèdent, Pauline Estrampes (1904), Angèle Lacrampe (1960) …. Melle Tricotet (1968).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’école est menacée de fermeture en 1968, quand Françoise Clion en prend la direction. Il faut faire ses preuves, patiemment, consciencieusement. Les garçons sont admis officiellement. Malgré les menaces qui pèsent sur l’enseignement libre, l’école résiste, sa réputation se répand.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "Un don généreux d’une ancienne maman de l’école permettra de rembourser un emprunt fait pour les travaux.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "En 1985, l’école signe un contrat d’association avec l’État. L’école se développe, dédouble des classes, diversifie ses activités pédagogiques et approfondit le travail d’équipe.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "En mars 2008, elle obtient de l’Inspection Académique l’ouverture d’une classe maternelle pour la rentrée 2008-2009.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}, "content": [{"text": "L’OGEC (organisme de gestion de l’établissement) décide alors d’un projet d’extension et de rénovation en 2009.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 09:16:39.086258+00	2026-01-14 09:20:24.642354+00
b7797350-ac31-496a-bdb5-1a2bb9383209	fbe7a9d9-a622-437b-976b-b2082ead2539	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Les dates clés :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "29 août 1902 : Création de l’école Jeanne d’arc, école privée de filles.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1er octobre 1902 : Ouverture de l’école : 2 classes – Mme Estrampes, directrice, sa fille Pauline est adjointe.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1er octobre 1904 : Pauline Estrampes devient directrice, Mme Estrampes, mère, reste adjointe.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1916 : 3 classes.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1957 : 7 classes.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "J", "type": "text"}, {"text": "usqu’en 1960, internat à l’école.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1960 : Angèle Lacrampe (adjointe depuis 1928) devient directrice puis MlleTricotet jusqu’en 1968 (classe de maternelle au collège 6/5ᵉ et 4/3ᵉ).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1968 : Fermeture du collège – Arrivée de Mme Clion à la direction.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "1985 : Obtention du contrat d’association avec l’Etat.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "2004 : Nomination de Mme Brigitte Dejean, à la direction de l’établissement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "2019 : Nomination de Mme Albane Motais de Narbonne, actuel chef d’établissement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 09:20:39.561741+00	2026-01-14 09:24:27.877146+00
522a90bd-9621-46ac-886c-de5e58d34b3d	23b44287-025a-4bf2-befa-c36a9dc914a3	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": "center"}, "content": [{"text": "Aujourd’hui", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}, "content": [{"text": "Actuellement, nous accueillons 215 élèves de la petite section au CM2 répartis en 8 classes :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "3 classes maternelles (accueil dès 3 ans) et 5 classes élémentaires", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "La demi-pension est assuréee par une société de restauration avec des repas préparés sur place.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Une garderie est proposée à partir de 7h45 et jusqu’à 18h15.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}	2026-01-14 09:24:36.147551+00	2026-01-14 09:25:05.1138+00
dcaab956-20f3-42c8-8c2a-caf9609681f3	5943387f-6a9c-462b-a669-9f2285d73a86	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 2, "textAlign": "center"}, "content": [{"text": "Établissement privé catholique sous contrat avec l’État, l’École catholique Jeanne d’Arc-Le Bouscat est placée sous la tutelle de la Direction Diocésaine de l’Enseignement Catholique de Gironde.", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}, "content": [{"text": "À ce double titre, elle respecte les programmes de l’Éducation Nationale, ainsi que les orientations éducatives diocésaines.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "paragraph", "attrs": {"textAlign": "center"}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "École de quartier, familiale et chaleureuse, elle accueille tous les enfants et leur famille qui acceptent et respectent le projet éducatif.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre école a pour vocation d’être une école qui accueille, éduque, accompagne, donne des repères, propose la foi et annonce le Christ.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre communauté éducative porte la responsabilité, l’ambition et l’espérance d’accompagner chacun pour devenir des personnalités autonomes et responsables, capables de choix libres.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "Notre école est un lieu privilégié pour vivre en communauté d’école et s’enrichir des échanges entre la paroisse, la mairie, les familles et l’équipe éducative et les différents intervenants.", "type": "text"}, {"type": "hardBreak"}, {"text": "Chacun est ainsi appelé à œuvrer, dans la joie et l’Espérance, pour le bien commun.", "type": "text"}]}, {"type": "heading", "attrs": {"level": 3, "textAlign": null}}, {"type": "heading", "attrs": {"level": 3, "textAlign": "center"}, "content": [{"text": "« Tous les hommes de n’importe quelle race, âge ou condition, possèdent, en tant qu’ils jouissent de la dignité de personne, un droit inaliénable à une éducation qui réponde à leur vocation propre, soit conforme à leur tempérament, à la différence des sexes, à la culture et aux traditions nationales, en même temps qu’ouverte aux échanges fraternels avec les autres peuples pour favoriser l’unité véritable et la paix dans le monde. »", "type": "text", "marks": [{"type": "italic"}]}, {"type": "hardBreak", "marks": [{"type": "italic"}]}, {"text": "Concile Vatican II, Déclaration conciliaire Gravissimum educationis", "type": "text", "marks": [{"type": "italic"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 09:27:57.045492+00	2026-01-14 10:31:44.931067+00
493ea1b0-7c8b-4655-b9a8-84bf13f3a9e3	cf221b63-3868-42c3-ac1a-ee9e456eadef	{"type": "doc", "content": [{"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "L’OGEC c’est quoi ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OGEC ou Organisme de Gestion de l’Enseignement Catholique", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}, {"text": " ", "type": "text"}, {"text": "est une association loi 1901, initiée par l’Enseignement Catholique.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Toute école privée catholique sous contrat avec l’État est gérée par un Organisme de Gestion de l’Enseignement Catholique.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "En ce qui concerne notre école, cette association s’appelle OJAB (OGEC de Jeanne d’Arc le Bouscat).", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Comment est composé le Bureau ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OJAB comporte un Conseil d’Administration et un bureau, désigné par le Conseil d’Administration. Le bureau assure le bon fonctionnement de l’association.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Au quotidien, la délégation de gestion est donnée au Chef d’Établissement, qui est associé au fonctionnement de l’OGEC et assiste à toutes les réunions.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "Les membres de l’OGEC sont des bénévoles au service de l’Enseignement Catholique, dans le respect de ses valeurs.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}, {"type": "heading", "attrs": {"level": 1, "textAlign": null}, "content": [{"text": "Quelles sont les missions de l’OGEC ?", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(78, 177, 105)"}}, {"type": "bold"}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "L’OGEC est en charge :", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– du budget de l’école (établissement et suivi) de la tenue des comptes,", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– de la détermination de la contribution demandée aux familles,", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "– du paiement des charges de fonctionnement de l’établissement, etc…", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"type": "hardBreak", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}, {"text": "L’OGEC doit également veiller à la gestion des locaux, à leur entretien, à leur rénovation, à leur aménagement et à leur agrandissement en se préoccupant des questions d’hygiène et de sécurité. L’OGEC est aussi l’employeur du personnel non-enseignant de l’établissement qu’il rémunère directement.", "type": "text", "marks": [{"type": "textStyle", "attrs": {"color": "rgb(23, 56, 62)"}}]}]}]}	2026-01-14 10:01:34.679564+00	2026-01-14 10:02:46.131436+00
244deb2e-67c7-448c-8f61-6f0d05f62b15	a67777de-6746-4910-823f-ec604fa6363a	{"type": "doc", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "ALLER A LA RENCONTRE DE DIEU :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Se construire dans un environnement porteur de sens", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Aimer Dieu : découvrir la Parole, proposer, célébrer", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Vivre en frères : Accueillir, Participer, S’engager, s’entraider", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Servir son prochain : prendre soin des plus fragiles, solidarité", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "VIVRE EN RELATION :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école de quartier implantée dans son environnement local et paroissial", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école ouverte sur le monde", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école respectueuse de chacun pour encourager la confiance et la Paix", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école qui développe l’écoute pour favoriser les échanges", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Une école qui célèbre dans la Joie", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "SE CONNAITRE :", "type": "text", "marks": [{"type": "bold"}]}]}, {"type": "bulletList", "content": [{"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de faire des choix en considérant leur portée.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de développer différentes intelligences.", "type": "text"}]}]}, {"type": "listItem", "content": [{"type": "paragraph", "attrs": {"textAlign": null}, "content": [{"text": "Permettre aux élèves de reconnaître leurs talents, de les exprimer et de les valoriser.", "type": "text"}]}]}]}, {"type": "paragraph", "attrs": {"textAlign": null}}]}	2026-01-14 09:32:37.107453+00	2026-01-21 16:32:32.650964+00
\.


--
-- Data for Name: contenu_titre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenu_titre (id_contenu_titre, id_section_fk, is_mega, titre1, titre2, description, created_at, updated_at) FROM stdin;
3370eb0b-8c0d-49e1-affb-19723c67f3cf	ba66e409-f0f8-44fe-91a8-d7c67eadc1ef	f	HISTOIRE DE L’ÉCOLE	HISTOIRE DE L’ÉCOLE		2026-01-12 13:34:38.167872+00	2026-01-14 11:36:47.895636+00
74242580-d9a1-492c-bcf9-3cde032110dc	3d8b5765-479b-43b8-af29-b52d9dbeefa4	f	PRÉ INSCRIPTION			2025-12-18 15:05:21.237803+00	2025-12-19 08:37:28.026629+00
916aa856-e9c0-4965-9335-f64aecd1b6ff	67c6f5df-b954-46c1-8cd4-60b4c83aa690	t	CONTACT		VOUS SOUHAITEZ NOUS CONTACTER ?	2025-12-18 15:05:21.237803+00	2025-12-19 08:59:43.708983+00
b8b0c9cd-e848-4389-9440-b229dab5ea1b	f20e7d57-5f0b-4b03-a234-fe5aa76437f1	t	PLUS		Nos autres pages	2025-12-18 15:05:21.237803+00	2025-12-19 10:11:02.991855+00
ee613f13-791a-47d7-bc0c-b779cb1b90dc	8446c363-0b39-4cbe-a99a-da2473aeee2a	f	PROJET PASTORAL			2025-12-18 15:05:21.237803+00	2026-01-07 16:11:58.127625+00
307d2b5e-749e-4889-8061-9fac7d12f43f	9cdb591f-c234-436f-800b-513fe5420f22	f	RÈGLEMENT INTÉRIEUR			2025-12-18 15:05:21.237803+00	2026-01-07 16:31:28.927362+00
c1509b60-8fab-457f-a481-4d074a440d91	121ace6e-3bba-49ce-a70f-ff02bac25060	f	INSTITUTION JEANNE D’ARC		ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE, sous CONTRAT AVEC L’ETAT	2026-01-12 14:40:06.859077+00	2026-01-12 14:42:27.442054+00
7ef6e902-3dd3-434e-8a0c-7a8ed5eb10f4	8c42367f-f686-477e-8145-19dbee03da3c	t	LES PROJETS		INSTITUTION JEANNE D’ARC – LE BOUSCAT	2025-12-18 15:05:21.237803+00	2026-01-13 11:21:09.108274+00
7f73500c-65ad-42de-bd3f-4c40ff44ee86	5247c29a-59c4-41d9-9e50-139cd15ae654	f	PROJET ÉDUCATIF	PROJET ÉDUCATIF DE L’ÉTABLISSEMENT	Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations.	2025-12-18 15:05:21.237803+00	2026-01-14 09:27:44.445917+00
779d8f80-2331-4fac-bd35-61b22f4402de	99950c5a-de9f-46b6-9dd9-bc5c453e6ef0	f	École directe	ÉCOLE DIRECTE		2025-12-18 15:05:21.237803+00	2026-01-14 09:43:32.770775+00
0e94fba2-728f-4240-abf0-8a9418a578d2	ba84e21b-78ba-4be4-b0d9-f1f7fba158ab	f	TARIFS	TARIFS		2025-12-18 15:05:21.237803+00	2026-01-14 09:59:40.54787+00
aa14ddd6-783d-4f44-b0fa-0891205e94d3	93e05a7b-2549-49d2-8b23-e64e8abcb1d2	f	OGEC	OGEC – Organisme de Gestion de l’Enseignement Catholique		2025-12-18 15:05:21.237803+00	2026-01-14 10:01:23.06294+00
f925e1c3-40bd-4f3d-9b21-d7899cdd91e0	b1386907-04fd-4e23-b527-200f3204653e	f	PROJET PÉDAGOGIQUE	PROJET PÉDAGOGIQUE		2025-12-17 12:01:53.424746+00	2026-01-23 08:20:38.50564+00
046f0fd6-adb9-4f47-9ecd-99907e248697	6b8b5046-370e-4bcf-9933-86a18f9d539f	f	BLOUSES JDA			2025-12-18 15:05:21.237803+00	2026-01-23 08:24:28.39431+00
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.page (id_page, page_url, nom, created_at, updated_at) FROM stdin;
e11935b9-f19d-41ee-a061-d3f9bd26afde	projets/projet-pedagogique	Projet Pédagogique	2025-12-17 11:58:24.400635+00	2025-12-17 11:58:24.400635+00
8166954f-eb2d-48ed-a915-e207ae1406e4	/	Accueil	2025-12-18 14:50:33.084039+00	2025-12-18 14:50:33.084039+00
74d676f1-767e-4350-8a41-9c1c0999faf7	projets/projet-educatif	Projet Éducatif	2025-12-18 14:50:33.084039+00	2025-12-18 14:50:33.084039+00
ccd9338f-0f5c-42a2-9b3e-465645c80ff2	projets/projet-pastoral	Projet Pastoral	2025-12-18 14:50:33.084039+00	2025-12-18 14:50:33.084039+00
8cecaa91-a539-45fe-8151-a8650934ee7a	projets	Projets	2025-12-18 14:50:33.084039+00	2025-12-19 08:30:17.003798+00
a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	pre-inscriptions	Pré-inscriptions	2025-12-18 14:50:33.084039+00	2025-12-19 08:31:08.545657+00
60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	plus	Plus	2025-12-18 14:50:33.084039+00	2025-12-19 08:31:35.090148+00
295029ce-e0e9-475a-ae67-574139fa31b2	plus/ecole-directe	École Directe	2025-12-18 14:50:33.084039+00	2025-12-19 08:32:25.642048+00
6446302e-8285-44c0-95df-b49cf8b080bb	plus/reglement	Règlement intérieur	2025-12-18 14:50:33.084039+00	2025-12-19 08:33:11.642162+00
c336b0b8-e554-494d-8837-2f8e2bf4bc85	plus/blouses	Blouses JDA	2025-12-18 14:50:33.084039+00	2025-12-19 08:33:33.834272+00
c740cf55-6c49-4919-b2d8-e1f6e74e0230	plus/tarifs	Tarifs	2025-12-18 14:50:33.084039+00	2025-12-19 08:33:55.258417+00
f7c70f0c-23ce-4736-9328-15237670045c	plus/ogec	OGEC	2025-12-18 14:50:33.084039+00	2025-12-19 08:34:35.577699+00
64d857cc-b5f2-4b09-9024-46789bfef3ea	contact	Contact	2025-12-18 14:50:33.084039+00	2025-12-19 08:34:56.21774+00
9acbbb90-c4da-48eb-b825-ad27d3e72247	header	Barre de navigation	2026-01-05 09:37:33.120298+00	2026-01-05 09:37:33.120298+00
f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	footer	Pied de page	2026-01-05 09:37:33.120298+00	2026-01-05 09:37:33.120298+00
d3d52cd8-5458-44a7-bf81-3f4986377e6a	presentation-histoire	Histoire de l'école	2026-01-12 13:34:20.978216+00	2026-01-12 13:34:20.978216+00
663db8d8-f940-4408-bd6f-53dca0fe54c6	/footer	Footer	2026-01-14 07:54:21.849405+00	2026-01-14 07:54:21.849405+00
\.


--
-- Data for Name: pave_bloc; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pave_bloc (id_pave_bloc, id_contenu_pave_fk, icone, soustitre, description1, lien_vers, created_at, updated_at, description2, description3, description4, description5, description6, description7) FROM stdin;
5413dc29-a043-4568-a266-1faa9d43d061	fd346e21-5871-4d15-a152-53f3c8671fc1	BigSchoolBigIcon	PROJET ÉDUCATIF	Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. Découvrir le projet éducatif de l’établissement	/projets/projet-educatif	2026-01-13 11:21:24.770138+00	2026-01-13 11:23:30.264241+00						
e35d6f5a-8368-4962-8284-841fc1c80251	fd346e21-5871-4d15-a152-53f3c8671fc1	BigReaderBigIcon	PROJET PÉDAGOGIQUE	Nous favorisons l’épanouissement de nos élèves afin qu’ils progressent scolairement et qu’ils grandissent en humanité. Découvrir le projet pédagogique de l’établissement	/projets/projet-pedagogique	2026-01-13 11:24:00.797562+00	2026-01-13 11:24:40.820949+00						
c3d26cb1-b4b0-4a49-ab42-f7d1814c0cfe	fd346e21-5871-4d15-a152-53f3c8671fc1	BigChristianCrossBigIcon	PROJET PASTORAL	Vivre en frère, découvrir la parole de dieu. Découvrir le projet pastorale de l’établissement\r\n\r\n	/projets/projet-pastoral	2026-01-13 11:24:48.366293+00	2026-01-13 11:26:56.072672+00						
0b5a82a5-f747-4155-bd8b-a0c263eb0820	33da439e-f856-4562-ab64-1db067c416a1	BigSchoolBigIcon	PROJET ÉDUCATIF		/projets/projet-educatif	2026-01-13 14:45:09.389544+00	2026-01-13 15:00:33.297093+00						
57cd76a1-709c-4d71-b9a5-9b73dbb06b9a	33da439e-f856-4562-ab64-1db067c416a1	BigReaderBigIcon	PROJET PÉDAGOGIQUE		/projets/projet-pedagogique	2026-01-13 14:45:15.039797+00	2026-01-13 15:01:13.492833+00						
32e590eb-1cd0-4b4d-bff6-f789b716fa5e	33da439e-f856-4562-ab64-1db067c416a1	BigChristianCrossBigIcon	PROJET PASTORAL		/projets/projet-pastoral	2026-01-13 15:00:42.542358+00	2026-01-13 15:01:40.275645+00						
29f3ed1c-84ce-4d8e-9b14-ae36ac87e78a	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallHereBigIcon	Adresse	45 Rue Francis de Pressensé		2026-01-13 15:51:40.480473+00	2026-01-13 16:04:48.866874+00	33110 Le Bouscat					
16c5c138-cec3-4758-96f5-113a9f30d440	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallLetterBigIcon	Courriel	administratif@jeannedarc33.fr		2026-01-13 15:51:42.080477+00	2026-01-13 16:22:51.551828+00						
51798fc2-043c-4e38-881a-e3aa79ae69cb	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallClockBigIcon	Horaires	Horaires de classe :		2026-01-13 15:51:43.205524+00	2026-01-13 16:23:44.760827+00	8 h 45 12 h 00 et 13 h 30 – 16 h 30	Accueil en garderie à partir de :	7 h 45 jusqu’à 18 h 15.			
67ac043b-f786-4d0b-984d-ac9064f146b4	b0479b65-e5cf-4de2-bb5c-42c234df8342	SmallPhoneBigIcon	Numéro de téléphone	(+33)5 56 08 52 16		2026-01-13 15:52:01.606717+00	2026-01-13 16:24:21.245045+00						
62fed117-04d0-4b89-8ac4-50242e4de4e8	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Horaires de classe	Lundi, mardi, jeudi et vendredi		2026-01-14 08:12:25.564743+00	2026-01-14 08:21:11.877761+00	08h45 - 12h00 et 13h30 - 16h30					
bafaafdf-11a9-436a-a649-303ec5eda890	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Horaires de garderie	Lundi, mardi, jeudi et vendredi		2026-01-14 08:13:16.100336+00	2026-01-14 08:21:43.378094+00	À partir de 07h45 et jusqu'à 18h15					
792420fc-0089-40be-9c98-8e718b53dcbe	dc6fc558-8f03-40e6-8e70-0e5e28a3198d	AAAEmpty2BigIcon	Contact & Adresse	Adresse : 45 Rue Francis de Préssensé 33110 Le Bouscat		2026-01-14 08:13:17.224938+00	2026-01-14 08:23:04.843817+00	05 56 08 52 16	administratif@jeannedarc33.fr				
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.section (id_section, id_page_fk, type, revert, created_at, updated_at) FROM stdin;
b1386907-04fd-4e23-b527-200f3204653e	e11935b9-f19d-41ee-a061-d3f9bd26afde	Titre	f	2025-12-17 12:00:06.554458+00	2025-12-17 12:00:06.554458+00
2e5b0548-c923-45c8-80b5-6e045a4877f5	e11935b9-f19d-41ee-a061-d3f9bd26afde	Texte	f	2025-12-17 12:00:26.755482+00	2025-12-17 12:00:26.755482+00
8c42367f-f686-477e-8145-19dbee03da3c	8cecaa91-a539-45fe-8151-a8650934ee7a	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
5247c29a-59c4-41d9-9e50-139cd15ae654	74d676f1-767e-4350-8a41-9c1c0999faf7	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
8446c363-0b39-4cbe-a99a-da2473aeee2a	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
3d8b5765-479b-43b8-af29-b52d9dbeefa4	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
f20e7d57-5f0b-4b03-a234-fe5aa76437f1	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
99950c5a-de9f-46b6-9dd9-bc5c453e6ef0	295029ce-e0e9-475a-ae67-574139fa31b2	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
9cdb591f-c234-436f-800b-513fe5420f22	6446302e-8285-44c0-95df-b49cf8b080bb	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
6b8b5046-370e-4bcf-9933-86a18f9d539f	c336b0b8-e554-494d-8837-2f8e2bf4bc85	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
ba84e21b-78ba-4be4-b0d9-f1f7fba158ab	c740cf55-6c49-4919-b2d8-e1f6e74e0230	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
93e05a7b-2549-49d2-8b23-e64e8abcb1d2	f7c70f0c-23ce-4736-9328-15237670045c	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
67c6f5df-b954-46c1-8cd4-60b4c83aa690	64d857cc-b5f2-4b09-9024-46789bfef3ea	Titre	f	2025-12-18 14:59:06.672671+00	2025-12-18 14:59:06.672671+00
8b8c60e7-e4ca-41ca-9b1e-4c978b755d5d	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 10:04:17.330427+00	2026-01-05 10:04:17.330427+00
6c86d086-0014-4b2c-ad71-573706d345e1	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 10:04:26.306782+00	2026-01-05 10:04:26.306782+00
05ee1e16-c142-42b5-b459-afcc593e3393	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 10:04:34.767728+00	2026-01-05 10:04:34.767728+00
516ca4e0-1661-4991-ab84-b5d5b3b52a27	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 10:04:45.743819+00	2026-01-05 10:04:45.743819+00
bed09afd-02b1-4036-87a7-8a95c7918a28	9acbbb90-c4da-48eb-b825-ad27d3e72247	HeaderBoutons	f	2026-01-05 10:04:54.893304+00	2026-01-05 10:04:54.893304+00
610a236a-6c92-46e1-b281-41060ac503e8	e11935b9-f19d-41ee-a061-d3f9bd26afde	ImageTexte	t	2025-12-17 12:00:16.65258+00	2026-01-07 14:58:29.185155+00
4e3b39ec-7f51-4444-a2ec-b318c9522e0e	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	ImageTexte	t	2026-01-07 16:12:05.574326+00	2026-01-07 16:12:09.64663+00
30c8a13e-ac22-4c2d-a150-dca3093f3661	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	Image	f	2026-01-07 16:19:13.440566+00	2026-01-07 16:19:13.440566+00
4ac5f0aa-48d0-4ee1-b342-2c31801f7dc4	6446302e-8285-44c0-95df-b49cf8b080bb	Pdf	f	2026-01-07 16:31:34.42634+00	2026-01-07 16:31:34.42634+00
640a25da-7d94-4216-97a9-806118e14fbc	c336b0b8-e554-494d-8837-2f8e2bf4bc85	BandeauBtn	f	2026-01-09 07:51:47.720269+00	2026-01-09 07:51:47.720269+00
ba66e409-f0f8-44fe-91a8-d7c67eadc1ef	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Titre	f	2026-01-12 13:34:38.11997+00	2026-01-12 13:34:38.11997+00
121ace6e-3bba-49ce-a70f-ff02bac25060	8166954f-eb2d-48ed-a915-e207ae1406e4	TitreImage	t	2026-01-12 14:40:06.723857+00	2026-01-12 14:40:10.954859+00
24927bed-1f90-4a4b-995f-9c7a548e8fa2	8166954f-eb2d-48ed-a915-e207ae1406e4	BandeauBtn	f	2026-01-12 14:40:23.316658+00	2026-01-12 14:40:23.316658+00
3ec7ccdc-46fc-426d-8cbb-92d38d59c10e	8cecaa91-a539-45fe-8151-a8650934ee7a	PavesNav	f	2026-01-13 11:21:16.820055+00	2026-01-13 11:21:16.820055+00
dad61c44-7a22-4307-8e63-cbe1a7847346	8cecaa91-a539-45fe-8151-a8650934ee7a	Image	f	2026-01-13 13:22:29.757882+00	2026-01-13 13:22:29.757882+00
fcb5856f-3ac2-4d04-becb-081b588b0464	8166954f-eb2d-48ed-a915-e207ae1406e4	PavesNav	f	2026-01-13 13:23:47.340711+00	2026-01-13 13:23:47.340711+00
d789a75b-2f50-418a-b4a6-00e77dfe6581	64d857cc-b5f2-4b09-9024-46789bfef3ea	PavesNav	f	2026-01-13 15:51:35.628447+00	2026-01-13 15:51:35.628447+00
2190e0a1-cf08-4f3c-98a8-002c1e4ad2a1	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	PavesNav	f	2026-01-14 07:57:35.872295+00	2026-01-14 07:57:35.872295+00
fbe7a9d9-a622-437b-976b-b2082ead2539	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Texte	f	2026-01-14 09:20:39.529646+00	2026-01-14 09:20:39.529646+00
23b44287-025a-4bf2-befa-c36a9dc914a3	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Texte	f	2026-01-14 09:24:36.113688+00	2026-01-14 09:24:36.113688+00
8a1ed75d-0ad1-4339-9cbe-45fe3418009a	d3d52cd8-5458-44a7-bf81-3f4986377e6a	Image	f	2026-01-14 09:25:33.882639+00	2026-01-14 09:25:33.882639+00
5943387f-6a9c-462b-a669-9f2285d73a86	74d676f1-767e-4350-8a41-9c1c0999faf7	Texte	f	2026-01-14 09:27:56.98067+00	2026-01-14 09:27:56.98067+00
a67777de-6746-4910-823f-ec604fa6363a	74d676f1-767e-4350-8a41-9c1c0999faf7	ImageTexte	f	2026-01-14 09:32:36.947587+00	2026-01-14 09:32:36.947587+00
df2360f2-49bc-46c9-a7b5-9dce3de86043	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	BandeauBtn	f	2026-01-14 09:41:39.265706+00	2026-01-14 09:41:39.265706+00
cad4f442-ee3d-48a1-949c-e71800b3beba	295029ce-e0e9-475a-ae67-574139fa31b2	BandeauBtn	f	2026-01-14 09:43:38.349744+00	2026-01-14 09:43:38.349744+00
62f8c8a7-f586-4a6b-bece-806cb37675a7	c336b0b8-e554-494d-8837-2f8e2bf4bc85	Pdf	f	2026-01-14 09:57:08.009639+00	2026-01-14 09:57:08.009639+00
1fd4931c-5d7e-40c3-b0a6-409b099dd5aa	c336b0b8-e554-494d-8837-2f8e2bf4bc85	BandeauBtn	f	2026-01-14 09:58:29.79423+00	2026-01-14 09:58:29.79423+00
602196fd-53b4-4752-b05a-cc569b22b61a	c740cf55-6c49-4919-b2d8-e1f6e74e0230	Pdf	f	2026-01-14 09:59:55.86946+00	2026-01-14 09:59:55.86946+00
cf221b63-3868-42c3-ac1a-ee9e456eadef	f7c70f0c-23ce-4736-9328-15237670045c	ImageTexte	t	2026-01-14 10:01:34.550495+00	2026-01-14 10:01:37.328608+00
f4bd0be0-e3e4-4b91-8a1c-b719a567bf63	d3d52cd8-5458-44a7-bf81-3f4986377e6a	ImageTexte	f	2026-01-14 09:16:38.94894+00	2026-01-14 11:36:52.291154+00
0d1f84b7-acb1-4cf7-aa2c-30a8c4ba27e6	64d857cc-b5f2-4b09-9024-46789bfef3ea	Contact	f	2026-01-22 16:39:52.062287+00	2026-01-22 16:39:52.062287+00
\.


--
-- Data for Name: text_index; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.text_index (id_text_index, id_page_fk, ref_table, ref_id, content_plaintext, created_at, updated_at) FROM stdin;
86855bdb-3877-4542-85de-f4e98779e18a	e11935b9-f19d-41ee-a061-d3f9bd26afde	page	e11935b9-f19d-41ee-a061-d3f9bd26afde	 Projet Pédagogique	2026-01-15 16:53:42.55224+00	2026-01-15 16:56:57.908539+00
0527008d-ef5a-4195-8b13-f8ea2cd303c3	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_titre	f925e1c3-40bd-4f3d-9b21-d7899cdd91e0	 PROJET PÉDAGOGIQUE test PROJET PÉDAGOGIQUE	2026-01-15 16:53:42.584237+00	2026-01-15 16:56:57.919148+00
3a210096-c6c4-474b-9eae-ed56cc8994ce	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_texte	fec83639-9b1a-4480-929e-2c2b01cb7c52	  S’émerveiller d’apprendre Un climat de classe et d’école serein pour bien apprendre et bien vivre ensemble La Classe-qualité : réflexion et attention afin de répondre aux besoins des élèves pour bien apprendre. Donner la possibilité à nos élèves de restituer et d’offrir : lors des spectacles, de mises en scène, de chorale… S’engager activement dans ses apprentissages Accompagner nos élèves à développer le questionnement et la réflexion Travailler ensemble Se mettre en projet Apprendre à apprendre Les apports des neurosciences et de la gestion mentale pour mieux apprendre La place du statut de l’erreur La cohérence pédagogique	2026-01-15 16:53:42.59143+00	2026-01-15 16:56:57.921776+00
d780eca2-09ec-433d-815b-ff5fb00eb976	e11935b9-f19d-41ee-a061-d3f9bd26afde	contenu_texte	df61c9a8-ea5c-4a72-9724-05b8875fdee2	  L’école met au centre de la vie scolaire 6 piliers. La culture littéraire : « Silence On Lit », mini-médiathèque, les incorruptibles, participation au salon du livre du Bouscat. Le sport et l’éducation sportive : utilisation des installations sportives et animateurs sportifs de la ville et de l’école, animations sportives sur la pause méridienne. La culture numérique : Toutes les classes de l’école est équipée de VPI, et d’une flotte d’IPAD qui servent de support aux apprentissages des élèves. L’anglais : des cours d’anglais et des « English Games » sont proposés à tous les élèves (de la Petite Section au CM2) par une personne native anglophone. Un projet d’école annuel : chaque année, un thème d’année est choisi en lien avec un mode différent d’intelligence. Les activités culturelles : Tout au long de l’année, les élèves participent à des spectacles, des expositions… , en lien et en illustration avec les apprentissages.	2026-01-15 16:53:42.592872+00	2026-01-15 16:56:57.92257+00
3acfed1c-e433-4809-9dad-125256f3d753	8166954f-eb2d-48ed-a915-e207ae1406e4	page	8166954f-eb2d-48ed-a915-e207ae1406e4	 Accueil	2026-01-15 16:56:57.932659+00	2026-01-15 16:56:57.932659+00
2e843172-d7c8-4520-addb-48fe26496d85	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_titre	c1509b60-8fab-457f-a481-4d074a440d91	 ETABLISSEMENT CATHOLIQUE sous TUTELLE DIOCESAINE, sous CONTRAT AVEC L’ETAT INSTITUTION JEANNE D’ARC	2026-01-15 16:56:57.935214+00	2026-01-15 16:56:57.935214+00
65ef7eb3-7749-4c9b-ad90-bdf3cfc2802c	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_pave	33da439e-f856-4562-ab64-1db067c416a1	 LE PROJET D’ÉTABLISSEMENT	2026-01-15 16:56:57.938089+00	2026-01-15 16:56:57.938089+00
5c4ef6b0-8eca-48ab-a50e-ce6d6359882b	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_bandeaubtn	a55f1030-e11f-4545-966f-d1dac1e726e0	 pré-inscription Demande de Pré-Inscription de votre enfant à l’école JEANNE D’ARC pré-inscriptions	2026-01-15 16:56:57.939422+00	2026-01-15 16:56:57.939422+00
90109bd3-efd4-42ef-b9d3-85028b50ef4d	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	243fa9b0-f121-45f8-ab2f-07eb966b9e6d	 nous contacter	2026-01-15 16:56:57.940813+00	2026-01-15 16:56:57.940813+00
c9b385a1-de37-435c-a8ca-d3296af79db4	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	e72ad051-52db-4210-af60-5dc7759ba3da	 voir le projet d'établissement	2026-01-15 16:56:57.941523+00	2026-01-15 16:56:57.941523+00
da3eb810-56cc-44f9-b731-836beadf228b	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_solobtn	2f196cfe-4e52-4af7-a829-03846f3151fc	 histoire de l'école	2026-01-15 16:56:57.942185+00	2026-01-15 16:56:57.942185+00
a1a34f3c-d95d-4c84-80af-991ae2892e93	74d676f1-767e-4350-8a41-9c1c0999faf7	page	74d676f1-767e-4350-8a41-9c1c0999faf7	 Projet Éducatif	2026-01-15 16:56:57.944064+00	2026-01-15 16:56:57.944064+00
d8d2dbe7-3190-4c90-ab92-8305425cd8ba	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_titre	7f73500c-65ad-42de-bd3f-4c40ff44ee86	 Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. PROJET ÉDUCATIF PROJET ÉDUCATIF DE L’ÉTABLISSEMENT	2026-01-15 16:56:57.946553+00	2026-01-15 16:56:57.946553+00
5b757209-0d4c-4132-9e0e-2a6aa56dc419	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_texte	244deb2e-67c7-448c-8f61-6f0d05f62b15	  ALLER A LA RENCONTRE DE DIEU : Se construire dans un environnement porteur de sens Aimer Dieu : découvrir la Parole, proposer, célébrer Vivre en frères : Accueillir, Participer, S’engager, s’entraider Servir son prochain : prendre soin des plus fragiles, solidarité VIVRE EN RELATION : Une école de quartier implantée dans son environnement local et paroissial Une école ouverte sur le monde Une école respectueuse de chacun pour encourager la confiance et la Paix Une école qui développe l’écoute pour favoriser les échanges Une école qui célèbre dans la Joie SE CONNAITRE : Permettre aux élèves de faire des choix en considérant leur portée. Permettre aux élèves de développer différentes intelligences. Permettre aux élèves de reconnaître leurs talents, de les exprimer et de les valoriser.	2026-01-15 16:56:57.948322+00	2026-01-15 16:56:57.948322+00
6853f7a9-fd81-4511-afd2-6058c86b2b12	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_titre	3370eb0b-8c0d-49e1-affb-19723c67f3cf	 HISTOIRE DE L’ÉCOLE HISTOIRE DE L’ÉCOLE	2026-01-15 16:56:58.054035+00	2026-01-15 16:56:58.054035+00
e84170cf-0d51-428e-bc95-2bf346be5004	74d676f1-767e-4350-8a41-9c1c0999faf7	contenu_texte	dcaab956-20f3-42c8-8c2a-caf9609681f3	  Établissement privé catholique sous contrat avec l’État, l’École catholique Jeanne d’Arc-Le Bouscat est placée sous la tutelle de la Direction Diocésaine de l’Enseignement Catholique de Gironde. À ce double titre, elle respecte les programmes de l’Éducation Nationale, ainsi que les orientations éducatives diocésaines. École de quartier, familiale et chaleureuse, elle accueille tous les enfants et leur famille qui acceptent et respectent le projet éducatif. Notre école a pour vocation d’être une école qui accueille, éduque, accompagne, donne des repères, propose la foi et annonce le Christ. Notre communauté éducative porte la responsabilité, l’ambition et l’espérance d’accompagner chacun pour devenir des personnalités autonomes et responsables, capables de choix libres. Notre école est un lieu privilégié pour vivre en communauté d’école et s’enrichir des échanges entre la paroisse, la mairie, les familles et l’équipe éducative et les différents intervenants. Chacun est ainsi appelé à œuvrer, dans la joie et l’Espérance, pour le bien commun. « Tous les hommes de n’importe quelle race, âge ou condition, possèdent, en tant qu’ils jouissent de la dignité de personne, un droit inaliénable à une éducation qui réponde à leur vocation propre, soit conforme à leur tempérament, à la différence des sexes, à la culture et aux traditions nationales, en même temps qu’ouverte aux échanges fraternels avec les autres peuples pour favoriser l’unité véritable et la paix dans le monde. » Concile Vatican II, Déclaration conciliaire Gravissimum educationis	2026-01-15 16:56:57.94924+00	2026-01-15 16:56:57.94924+00
5f896978-cb37-4700-881c-5fd60a3a1a07	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	page	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	 Projet Pastoral	2026-01-15 16:56:57.955373+00	2026-01-15 16:56:57.955373+00
6b6cc3de-e170-44b7-ac95-c79e6294044f	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	contenu_titre	ee613f13-791a-47d7-bc0c-b779cb1b90dc	 PROJET PASTORAL	2026-01-15 16:56:57.956634+00	2026-01-15 16:56:57.956634+00
9711a3e4-73fe-4d37-bd56-28b3ff3aff49	ccd9338f-0f5c-42a2-9b3e-465645c80ff2	contenu_texte	b7895663-f2b4-49c5-bd35-b0381032d3b5	  Vivre en Frères : Écoute, accueil, convivialité : rencontres proposées aux familles pour mieux se connaître et échanger. Service : mise à disposition des talents des uns et des autres pour l’école et l’entraide. Actions solidaires. Pour découvrir la parole de Dieu : Éveil à la foi pour les plus jeunes et catéchèse pour les autres T emps pastoraux et communautaires : 3 samedis dans l’année Temps spirituels, prières, célébrations	2026-01-15 16:56:57.95793+00	2026-01-15 16:56:57.95793+00
0dddfcb5-c2b8-4383-91ce-c1aad7b81882	8cecaa91-a539-45fe-8151-a8650934ee7a	page	8cecaa91-a539-45fe-8151-a8650934ee7a	 Projets	2026-01-15 16:56:57.964159+00	2026-01-15 16:56:57.964159+00
36c94791-afe1-4de0-a5cc-bc286130b362	8cecaa91-a539-45fe-8151-a8650934ee7a	contenu_titre	7ef6e902-3dd3-434e-8a0c-7a8ed5eb10f4	 INSTITUTION JEANNE D’ARC – LE BOUSCAT LES PROJETS	2026-01-15 16:56:57.965695+00	2026-01-15 16:56:57.965695+00
6d569b77-c2fe-41ee-8265-87ee4fef2938	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	page	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	 Pré-inscriptions	2026-01-15 16:56:57.97232+00	2026-01-15 16:56:57.97232+00
9a5580b2-7293-4439-b9b4-7a66739de5b9	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	contenu_titre	74242580-d9a1-492c-bcf9-3cde032110dc	 PRÉ INSCRIPTION	2026-01-15 16:56:57.973873+00	2026-01-15 16:56:57.973873+00
134eac5c-cf4e-44de-a468-c490db4b0467	a52e900a-e3c9-4cd2-83e7-7d83c16f9b0e	contenu_bandeaubtn	cce2a1e0-463e-403e-89ac-35ec8e2d0795	  LIEN DE PRÉ-INSCRIPTION	2026-01-15 16:56:57.978509+00	2026-01-15 16:56:57.978509+00
7c5a3557-5d5e-484e-bb72-d84a1875140b	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	page	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	 Plus	2026-01-15 16:56:57.98079+00	2026-01-15 16:56:57.98079+00
001792b3-8d5c-4edb-90f7-b008deb4c38c	60595902-e6ce-4a0a-b2d2-ad19f6f1a3c3	contenu_titre	b8b0c9cd-e848-4389-9440-b229dab5ea1b	 Nos autres pages PLUS	2026-01-15 16:56:57.982105+00	2026-01-15 16:56:57.982105+00
0c403602-9cdc-4f6a-b943-6f47ec2d2b73	295029ce-e0e9-475a-ae67-574139fa31b2	page	295029ce-e0e9-475a-ae67-574139fa31b2	 École Directe	2026-01-15 16:56:57.98704+00	2026-01-15 16:56:57.98704+00
ddb01de6-b057-4f7e-811d-2c97d28afffd	295029ce-e0e9-475a-ae67-574139fa31b2	contenu_titre	779d8f80-2331-4fac-bd35-61b22f4402de	 École directe ÉCOLE DIRECTE	2026-01-15 16:56:57.988342+00	2026-01-15 16:56:57.988342+00
b39ac5d1-d5b8-4c64-8c1e-511ab05eb043	295029ce-e0e9-475a-ae67-574139fa31b2	contenu_bandeaubtn	b1615ac4-2cda-43cd-965a-93dfe9b7ae56	 Accéder aux notes, aux devoirs et à toutes les informations de votre enfant à l’école école directe	2026-01-15 16:56:57.991222+00	2026-01-15 16:56:57.991222+00
a898f912-f078-4d1b-a602-5d66b8e43c7f	6446302e-8285-44c0-95df-b49cf8b080bb	page	6446302e-8285-44c0-95df-b49cf8b080bb	 Règlement intérieur	2026-01-15 16:56:57.994785+00	2026-01-15 16:56:57.994785+00
9a1ba75c-70e5-4ab2-8739-2a223f46da8a	6446302e-8285-44c0-95df-b49cf8b080bb	contenu_titre	307d2b5e-749e-4889-8061-9fac7d12f43f	 RÈGLEMENT INTÉRIEUR	2026-01-15 16:56:57.996549+00	2026-01-15 16:56:57.996549+00
f052959f-d87d-4515-a6b8-7b03e08a51e3	6446302e-8285-44c0-95df-b49cf8b080bb	contenu_pdf	e943d4b8-6444-4705-be99-1907d91bf5ac	 Règlement intérieur	2026-01-15 16:56:57.999363+00	2026-01-15 16:56:57.999363+00
2189088e-c328-44b2-8a5c-3668166f6ad3	c336b0b8-e554-494d-8837-2f8e2bf4bc85	page	c336b0b8-e554-494d-8837-2f8e2bf4bc85	 Blouses JDA	2026-01-15 16:56:58.002942+00	2026-01-15 16:56:58.002942+00
58e7a230-eb05-43ba-a496-064ad030d369	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_titre	046f0fd6-adb9-4f47-9ecd-99907e248697	 Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023 BLOUSES JDA	2026-01-15 16:56:58.004235+00	2026-01-15 16:56:58.004235+00
874a49e9-c0f6-45cc-867f-dac9f921ce96	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_pdf	7985ea3e-37a6-4516-8f11-83aceddc17d6	 Commande de la blouse Jeanne d'Arc	2026-01-15 16:56:58.006685+00	2026-01-15 16:56:58.006685+00
4821a78c-e0f5-479b-ad17-5082dd3970cc	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_bandeaubtn	cb24a194-f802-4364-828a-6e38ae3ca88e	 Les blouses avec le logo de l’école Jeanne d’Arc font leur arrivée pour la rentrée : septembre 2023 commander la blouse	2026-01-15 16:56:58.009114+00	2026-01-15 16:56:58.009114+00
e0838279-2a67-46ee-8ddc-405f3b02937f	c336b0b8-e554-494d-8837-2f8e2bf4bc85	contenu_bandeaubtn	371922a6-19cf-4d07-8fd7-c4383b873e75	 Commander la blouse	2026-01-15 16:56:58.01013+00	2026-01-15 16:56:58.01013+00
e466f9c7-02b1-40f3-9dc0-586e72103921	c740cf55-6c49-4919-b2d8-e1f6e74e0230	page	c740cf55-6c49-4919-b2d8-e1f6e74e0230	 Tarifs	2026-01-15 16:56:58.013044+00	2026-01-15 16:56:58.013044+00
c31ebfe6-047e-473d-ae20-7b502eef8357	c740cf55-6c49-4919-b2d8-e1f6e74e0230	contenu_titre	0e94fba2-728f-4240-abf0-8a9418a578d2	 TARIFS TARIFS	2026-01-15 16:56:58.014666+00	2026-01-15 16:56:58.014666+00
cef08487-ea12-414a-b168-89343d138946	c740cf55-6c49-4919-b2d8-e1f6e74e0230	contenu_pdf	11c1c10c-db3a-4f63-85c9-812d811d7ea8	 TARIFS 2025-2026	2026-01-15 16:56:58.017085+00	2026-01-15 16:56:58.017085+00
6a2df2c7-c97d-4e0a-bb59-82feac85b345	f7c70f0c-23ce-4736-9328-15237670045c	page	f7c70f0c-23ce-4736-9328-15237670045c	 OGEC	2026-01-15 16:56:58.021922+00	2026-01-15 16:56:58.021922+00
632985c8-9b60-4e65-a32b-cadd9ff0aefc	f7c70f0c-23ce-4736-9328-15237670045c	contenu_titre	aa14ddd6-783d-4f44-b0fa-0891205e94d3	 OGEC OGEC – Organisme de Gestion de l’Enseignement Catholique	2026-01-15 16:56:58.023095+00	2026-01-15 16:56:58.023095+00
cf53f675-568e-4ee3-97c3-90e2d296e40d	f7c70f0c-23ce-4736-9328-15237670045c	contenu_texte	493ea1b0-7c8b-4655-b9a8-84bf13f3a9e3	  L’OGEC c’est quoi ? L’OGEC ou Organisme de Gestion de l’Enseignement Catholique   est une association loi 1901, initiée par l’Enseignement Catholique. Toute école privée catholique sous contrat avec l’État est gérée par un Organisme de Gestion de l’Enseignement Catholique. En ce qui concerne notre école, cette association s’appelle OJAB (OGEC de Jeanne d’Arc le Bouscat). Comment est composé le Bureau ? L’OJAB comporte un Conseil d’Administration et un bureau, désigné par le Conseil d’Administration. Le bureau assure le bon fonctionnement de l’association. Au quotidien, la délégation de gestion est donnée au Chef d’Établissement, qui est associé au fonctionnement de l’OGEC et assiste à toutes les réunions. Les membres de l’OGEC sont des bénévoles au service de l’Enseignement Catholique, dans le respect de ses valeurs. Quelles sont les missions de l’OGEC ? L’OGEC est en charge : – du budget de l’école (établissement et suivi) de la tenue des comptes, – de la détermination de la contribution demandée aux familles, – du paiement des charges de fonctionnement de l’établissement, etc… L’OGEC doit également veiller à la gestion des locaux, à leur entretien, à leur rénovation, à leur aménagement et à leur agrandissement en se préoccupant des questions d’hygiène et de sécurité. L’OGEC est aussi l’employeur du personnel non-enseignant de l’établissement qu’il rémunère directement.	2026-01-15 16:56:58.024479+00	2026-01-15 16:56:58.024479+00
ca528faa-347c-4154-aa7d-5e4e374363b0	64d857cc-b5f2-4b09-9024-46789bfef3ea	page	64d857cc-b5f2-4b09-9024-46789bfef3ea	 Contact	2026-01-15 16:56:58.029867+00	2026-01-15 16:56:58.029867+00
75c029da-3623-4903-96a5-6f864685c512	64d857cc-b5f2-4b09-9024-46789bfef3ea	contenu_titre	916aa856-e9c0-4965-9335-f64aecd1b6ff	 VOUS SOUHAITEZ NOUS CONTACTER ? CONTACT	2026-01-15 16:56:58.031309+00	2026-01-15 16:56:58.031309+00
57204443-c5df-418d-b15b-62e73c51dc42	9acbbb90-c4da-48eb-b825-ad27d3e72247	page	9acbbb90-c4da-48eb-b825-ad27d3e72247	 Barre de navigation	2026-01-15 16:56:58.036942+00	2026-01-15 16:56:58.036942+00
5db8c3c0-4213-4e00-8ccf-52bd37e509e1	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	page	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	 Pied de page	2026-01-15 16:56:58.042339+00	2026-01-15 16:56:58.042339+00
53e14e88-77e3-482b-b3a7-fb315a53adff	d3d52cd8-5458-44a7-bf81-3f4986377e6a	page	d3d52cd8-5458-44a7-bf81-3f4986377e6a	 Histoire de l'école	2026-01-15 16:56:58.052691+00	2026-01-15 16:56:58.052691+00
cc13542d-cc94-4be0-bd71-6bc03bdf74fe	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	1b3cf84e-e381-4009-b3c9-367f546ab1eb	  L’école Jeanne d’Arc est officiellement créée le 29 août 1902. Le premier octobre 1902, Madame Estrampes ouvre l’école sur la propriété que possède son mari depuis 1884 au 45 rue Francis de Pressensé. École privée de filles, certes, où les registres portent parfois les noms d’Albert, Auguste, Paul… ! L’école se développe et les directrices se succèdent, Pauline Estrampes (1904), Angèle Lacrampe (1960) …. Melle Tricotet (1968). L’école est menacée de fermeture en 1968, quand Françoise Clion en prend la direction. Il faut faire ses preuves, patiemment, consciencieusement. Les garçons sont admis officiellement. Malgré les menaces qui pèsent sur l’enseignement libre, l’école résiste, sa réputation se répand. Un don généreux d’une ancienne maman de l’école permettra de rembourser un emprunt fait pour les travaux. En 1985, l’école signe un contrat d’association avec l’État. L’école se développe, dédouble des classes, diversifie ses activités pédagogiques et approfondit le travail d’équipe. En mars 2008, elle obtient de l’Inspection Académique l’ouverture d’une classe maternelle pour la rentrée 2008-2009. L’OGEC (organisme de gestion de l’établissement) décide alors d’un projet d’extension et de rénovation en 2009.	2026-01-15 16:56:58.055555+00	2026-01-15 16:56:58.055555+00
9c0c6fb8-3534-4dfe-9a8b-d96a971be538	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	b7797350-ac31-496a-bdb5-1a2bb9383209	  Les dates clés : 29 août 1902 : Création de l’école Jeanne d’arc, école privée de filles. 1er octobre 1902 : Ouverture de l’école : 2 classes – Mme Estrampes, directrice, sa fille Pauline est adjointe. 1er octobre 1904 : Pauline Estrampes devient directrice, Mme Estrampes, mère, reste adjointe. 1916 : 3 classes. 1957 : 7 classes. J usqu’en 1960, internat à l’école. 1960 : Angèle Lacrampe (adjointe depuis 1928) devient directrice puis MlleTricotet jusqu’en 1968 (classe de maternelle au collège 6/5ᵉ et 4/3ᵉ). 1968 : Fermeture du collège – Arrivée de Mme Clion à la direction. 1985 : Obtention du contrat d’association avec l’Etat. 2004 : Nomination de Mme Brigitte Dejean, à la direction de l’établissement. 2019 : Nomination de Mme Albane Motais de Narbonne, actuel chef d’établissement.	2026-01-15 16:56:58.056655+00	2026-01-15 16:56:58.056655+00
3b717d5c-56e7-4506-a5a7-93a7122df7d8	d3d52cd8-5458-44a7-bf81-3f4986377e6a	contenu_texte	522a90bd-9621-46ac-886c-de5e58d34b3d	  Aujourd’hui Actuellement, nous accueillons 215 élèves de la petite section au CM2 répartis en 8 classes : 3 classes maternelles (accueil dès 3 ans) et 5 classes élémentaires La demi-pension est assuréee par une société de restauration avec des repas préparés sur place. Une garderie est proposée à partir de 7h45 et jusqu’à 18h15.	2026-01-15 16:56:58.05748+00	2026-01-15 16:56:58.05748+00
24275882-413b-42f1-b8f9-0c62580d1878	663db8d8-f940-4408-bd6f-53dca0fe54c6	page	663db8d8-f940-4408-bd6f-53dca0fe54c6	 Footer	2026-01-15 16:56:58.063286+00	2026-01-15 16:56:58.063286+00
9867bad4-69b2-4e67-9cc2-2c75423ca8b6	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	5413dc29-a043-4568-a266-1faa9d43d061	 PROJET ÉDUCATIF Le projet éducatif de l’établissement catholique d’enseignement L’École catholique Jeanne d’Arc-Le Bouscat est le texte qui guide notre action éducative et en présente les orientations. Découvrir le projet éducatif de l’établissement	2026-01-15 17:22:02.434566+00	2026-01-15 17:22:02.434566+00
cb1bab43-e505-46d8-949d-8a3127b3bc5e	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	e35d6f5a-8368-4962-8284-841fc1c80251	 PROJET PÉDAGOGIQUE Nous favorisons l’épanouissement de nos élèves afin qu’ils progressent scolairement et qu’ils grandissent en humanité. Découvrir le projet pédagogique de l’établissement	2026-01-15 17:22:02.438698+00	2026-01-15 17:22:02.438698+00
481235a9-8d56-4639-9c8b-13ceb6fd7108	8cecaa91-a539-45fe-8151-a8650934ee7a	pave_bloc	c3d26cb1-b4b0-4a49-ab42-f7d1814c0cfe	 PROJET PASTORAL Vivre en frère, découvrir la parole de dieu. Découvrir le projet pastorale de l’établissement\r\n\r\n	2026-01-15 17:22:02.440288+00	2026-01-15 17:22:02.440288+00
d5e751e4-7caf-47df-ae29-d521bf36e540	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	0b5a82a5-f747-4155-bd8b-a0c263eb0820	 PROJET ÉDUCATIF	2026-01-15 17:22:02.441436+00	2026-01-15 17:22:02.441436+00
e395b4b4-ebb0-4e52-8640-047384581af7	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	57cd76a1-709c-4d71-b9a5-9b73dbb06b9a	 PROJET PÉDAGOGIQUE	2026-01-15 17:22:02.442521+00	2026-01-15 17:22:02.442521+00
fc662719-29dc-4278-8af6-cefec23b5700	8166954f-eb2d-48ed-a915-e207ae1406e4	pave_bloc	32e590eb-1cd0-4b4d-bff6-f789b716fa5e	 PROJET PASTORAL	2026-01-15 17:22:02.443607+00	2026-01-15 17:22:02.443607+00
c3a64ade-1c30-4419-984e-8428a7969a01	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	29f3ed1c-84ce-4d8e-9b14-ae36ac87e78a	 Adresse 45 Rue Francis de Pressensé 33110 Le Bouscat	2026-01-15 17:22:02.444999+00	2026-01-15 17:22:02.444999+00
d61406db-1bc1-4918-b751-360d556eb2dd	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	16c5c138-cec3-4758-96f5-113a9f30d440	 Courriel administratif@jeannedarc33.fr	2026-01-15 17:22:02.446148+00	2026-01-15 17:22:02.446148+00
6a57ab87-4cd3-414e-ab47-ef44bf950a83	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	51798fc2-043c-4e38-881a-e3aa79ae69cb	 Horaires Horaires de classe : 8 h 45 12 h 00 et 13 h 30 – 16 h 30 Accueil en garderie à partir de : 7 h 45 jusqu’à 18 h 15.	2026-01-15 17:22:02.447272+00	2026-01-15 17:22:02.447272+00
b006e437-5b1b-489b-866e-1f8ac20b1675	64d857cc-b5f2-4b09-9024-46789bfef3ea	pave_bloc	67ac043b-f786-4d0b-984d-ac9064f146b4	 Numéro de téléphone (+33)5 56 08 52 16	2026-01-15 17:22:02.448335+00	2026-01-15 17:22:02.448335+00
7885e37e-bb7b-459b-8b03-90dd0657b0ea	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	62fed117-04d0-4b89-8ac4-50242e4de4e8	 Horaires de classe Lundi, mardi, jeudi et vendredi 08h45 - 12h00 et 13h30 - 16h30	2026-01-15 17:22:02.449284+00	2026-01-15 17:22:02.449284+00
889a04c6-2143-40d7-afc7-9aefdcf3ea54	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	bafaafdf-11a9-436a-a649-303ec5eda890	 Horaires de garderie Lundi, mardi, jeudi et vendredi À partir de 07h45 et jusqu'à 18h15	2026-01-15 17:22:02.450235+00	2026-01-15 17:22:02.450235+00
68b03e45-341d-439c-b3e1-baab5d35f594	f506bcbd-a9b9-4f1f-b192-ab0e9ec20f67	pave_bloc	792420fc-0089-40be-9c98-8e718b53dcbe	 Contact & Adresse Adresse : 45 Rue Francis de Préssensé 33110 Le Bouscat 05 56 08 52 16 administratif@jeannedarc33.fr	2026-01-15 17:22:02.451172+00	2026-01-15 17:22:02.451172+00
47416163-ea16-4ac4-9761-623f9662d0d4	8166954f-eb2d-48ed-a915-e207ae1406e4	contenu_image	1409095f-f110-473a-aaa1-47deef6bbf0d	 Fronton de l'institution Jeanne d'Arc	2026-01-23 08:18:48.480412+00	2026-01-23 08:18:48.480412+00
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.utilisateur (id_utilisateur, email, name, password, is_admin, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-01-20 08:51:43
20211116045059	2026-01-20 08:51:44
20211116050929	2026-01-20 08:51:44
20211116051442	2026-01-20 08:51:44
20211116212300	2026-01-20 08:51:44
20211116213355	2026-01-20 08:51:44
20211116213934	2026-01-20 08:51:44
20211116214523	2026-01-20 08:51:44
20211122062447	2026-01-20 08:51:45
20211124070109	2026-01-20 08:51:45
20211202204204	2026-01-20 08:51:45
20211202204605	2026-01-20 08:51:45
20211210212804	2026-01-20 08:51:45
20211228014915	2026-01-20 08:51:46
20220107221237	2026-01-20 08:51:46
20220228202821	2026-01-20 08:51:46
20220312004840	2026-01-20 08:51:46
20220603231003	2026-01-20 08:51:46
20220603232444	2026-01-20 08:51:46
20220615214548	2026-01-20 08:51:46
20220712093339	2026-01-20 08:51:47
20220908172859	2026-01-20 08:51:47
20220916233421	2026-01-20 08:51:47
20230119133233	2026-01-20 08:51:47
20230128025114	2026-01-20 08:51:47
20230128025212	2026-01-20 08:51:47
20230227211149	2026-01-20 08:51:47
20230228184745	2026-01-20 08:51:47
20230308225145	2026-01-20 08:51:48
20230328144023	2026-01-20 08:51:48
20231018144023	2026-01-20 08:51:48
20231204144023	2026-01-20 08:51:48
20231204144024	2026-01-20 08:51:48
20231204144025	2026-01-20 08:51:48
20240108234812	2026-01-20 08:51:48
20240109165339	2026-01-20 08:51:49
20240227174441	2026-01-20 08:51:49
20240311171622	2026-01-20 08:51:49
20240321100241	2026-01-20 08:51:49
20240401105812	2026-01-20 08:51:50
20240418121054	2026-01-20 08:51:50
20240523004032	2026-01-20 08:51:50
20240618124746	2026-01-20 08:51:50
20240801235015	2026-01-20 08:51:51
20240805133720	2026-01-20 08:51:51
20240827160934	2026-01-20 08:51:51
20240919163303	2026-01-20 08:51:51
20240919163305	2026-01-20 08:51:51
20241019105805	2026-01-20 08:51:51
20241030150047	2026-01-20 08:51:52
20241108114728	2026-01-20 08:51:52
20241121104152	2026-01-20 08:51:52
20241130184212	2026-01-20 08:51:52
20241220035512	2026-01-20 08:51:52
20241220123912	2026-01-20 08:51:52
20241224161212	2026-01-20 08:51:53
20250107150512	2026-01-20 08:51:53
20250110162412	2026-01-20 08:51:53
20250123174212	2026-01-20 08:51:53
20250128220012	2026-01-20 08:51:53
20250506224012	2026-01-20 08:51:53
20250523164012	2026-01-20 08:51:53
20250714121412	2026-01-20 08:51:53
20250905041441	2026-01-20 08:51:54
20251103001201	2026-01-20 08:51:54
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
medias-jeannedarc	medias-jeannedarc	\N	2026-01-21 10:12:24.692921+00	2026-01-21 10:12:24.692921+00	t	f	\N	\N	\N	STANDARD
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-01-20 08:35:50.441114
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-01-20 08:35:50.482985
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2026-01-20 08:35:50.490436
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-01-20 08:35:50.52485
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-01-20 08:35:50.540954
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-01-20 08:35:50.545636
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2026-01-20 08:35:50.552367
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-01-20 08:35:50.558826
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-01-20 08:35:50.563876
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2026-01-20 08:35:50.57075
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2026-01-20 08:35:50.576125
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-01-20 08:35:50.582292
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-01-20 08:35:50.587975
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-01-20 08:35:50.593471
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-01-20 08:35:50.59991
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-01-20 08:35:50.625431
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-01-20 08:35:50.630835
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-01-20 08:35:50.635817
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-01-20 08:35:50.641678
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-01-20 08:35:50.648795
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-01-20 08:35:50.653719
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-01-20 08:35:50.660105
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-01-20 08:35:50.673109
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-01-20 08:35:50.683983
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-01-20 08:35:50.688886
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-01-20 08:35:50.695329
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2026-01-20 08:35:50.700439
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2026-01-20 08:35:50.710998
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2026-01-20 08:35:50.721669
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2026-01-20 08:35:50.730209
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2026-01-20 08:35:50.736815
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2026-01-20 08:35:50.744123
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2026-01-20 08:35:50.751725
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2026-01-20 08:35:50.763198
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2026-01-20 08:35:50.767429
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2026-01-20 08:35:50.773436
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2026-01-20 08:35:50.778832
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-01-20 08:35:50.787478
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2026-01-20 08:35:50.794652
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2026-01-20 08:35:50.812722
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2026-01-20 08:35:50.81794
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2026-01-20 08:35:50.842221
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2026-01-20 08:35:50.851632
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2026-01-20 08:35:50.857845
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-01-20 08:35:50.862921
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-01-20 08:35:50.86841
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-01-20 08:35:50.87903
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-01-20 08:35:50.884297
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2026-01-20 08:35:50.889174
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-20 08:35:50.907824
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_pkey PRIMARY KEY (id_contenu_bandeaubtn);


--
-- Name: contenu_contact contenu_contact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_pkey PRIMARY KEY (id_contenu_contact);


--
-- Name: contenu_headerbtn contenu_headerbtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_pkey PRIMARY KEY (id_contenu_headerbtn);


--
-- Name: contenu_image contenu_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_pkey PRIMARY KEY (id_contenu_image);


--
-- Name: contenu_pave contenu_pave_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_pkey PRIMARY KEY (id_contenu_pave);


--
-- Name: contenu_pdf contenu_pdf_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_pkey PRIMARY KEY (id_contenu_pdf);


--
-- Name: contenu_solobtn contenu_solobtn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_pkey PRIMARY KEY (id_contenu_solobtn);


--
-- Name: contenu_texte contenu_texte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_pkey PRIMARY KEY (id_contenu_texte);


--
-- Name: contenu_titre contenu_titre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_pkey PRIMARY KEY (id_contenu_titre);


--
-- Name: page page_page_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_page_url_key UNIQUE (page_url);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id_page);


--
-- Name: pave_bloc pave_bloc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_pkey PRIMARY KEY (id_pave_bloc);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id_section);


--
-- Name: text_index text_index_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_pkey PRIMARY KEY (id_text_index);


--
-- Name: text_index text_index_ref_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_ref_unique UNIQUE (ref_id);


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: idx_text_index_content_plaintext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_text_index_content_plaintext ON public.text_index USING gin (to_tsvector('french'::regconfig, content_plaintext));


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: contenu_bandeaubtn update_contenu_bandeaubtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_bandeaubtn_updated_at BEFORE UPDATE ON public.contenu_bandeaubtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_contact update_contenu_contact_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_contact_updated_at BEFORE UPDATE ON public.contenu_contact FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_headerbtn update_contenu_headerbtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_headerbtn_updated_at BEFORE UPDATE ON public.contenu_headerbtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_image update_contenu_image_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_image_updated_at BEFORE UPDATE ON public.contenu_image FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pave update_contenu_pave_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_pave_updated_at BEFORE UPDATE ON public.contenu_pave FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_pdf update_contenu_pdf_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_pdf_updated_at BEFORE UPDATE ON public.contenu_pdf FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_solobtn update_contenu_solobtn_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_solobtn_updated_at BEFORE UPDATE ON public.contenu_solobtn FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_texte update_contenu_texte_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_texte_updated_at BEFORE UPDATE ON public.contenu_texte FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: contenu_titre update_contenu_titre_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contenu_titre_updated_at BEFORE UPDATE ON public.contenu_titre FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: page update_page_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_page_updated_at BEFORE UPDATE ON public.page FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: pave_bloc update_pave_bloc_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_pave_bloc_updated_at BEFORE UPDATE ON public.pave_bloc FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: section update_section_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_section_updated_at BEFORE UPDATE ON public.section FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: text_index update_text_index_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_text_index_updated_at BEFORE UPDATE ON public.text_index FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: utilisateur update_utilisateur_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_utilisateur_updated_at BEFORE UPDATE ON public.utilisateur FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: contenu_bandeaubtn contenu_bandeaubtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_bandeaubtn
    ADD CONSTRAINT contenu_bandeaubtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_contact contenu_contact_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_contact
    ADD CONSTRAINT contenu_contact_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_page_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_page_fk_fkey FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: contenu_headerbtn contenu_headerbtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_headerbtn
    ADD CONSTRAINT contenu_headerbtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_image contenu_image_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_image
    ADD CONSTRAINT contenu_image_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pave contenu_pave_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pave
    ADD CONSTRAINT contenu_pave_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_pdf contenu_pdf_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_pdf
    ADD CONSTRAINT contenu_pdf_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_solobtn contenu_solobtn_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_solobtn
    ADD CONSTRAINT contenu_solobtn_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_texte contenu_texte_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_texte
    ADD CONSTRAINT contenu_texte_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: contenu_titre contenu_titre_id_section_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenu_titre
    ADD CONSTRAINT contenu_titre_id_section_fk FOREIGN KEY (id_section_fk) REFERENCES public.section(id_section) ON DELETE CASCADE;


--
-- Name: pave_bloc pave_bloc_id_contenu_pave_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pave_bloc
    ADD CONSTRAINT pave_bloc_id_contenu_pave_fk FOREIGN KEY (id_contenu_pave_fk) REFERENCES public.contenu_pave(id_contenu_pave) ON DELETE CASCADE;


--
-- Name: section section_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: text_index text_index_id_page_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_index
    ADD CONSTRAINT text_index_id_page_fk FOREIGN KEY (id_page_fk) REFERENCES public.page(id_page) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

\unrestrict oDn3yGn5oZd4gKeRGgOxCxXDDiGpYWwx0gg3aKRIftfp3t3q1ouukRgUJ2AaMG8

