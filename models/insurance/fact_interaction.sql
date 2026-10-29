{{ config(
    materialized = 'table',
    schema = 'DW_INSURANCE'
)}}

with interactions as (
    select
        interaction_id,
        customer_first_name,
        customer_last_name,
        customer_email,
        agent_first_name,
        agent_last_name,
        agent_email,
        interaction_date,
        channel,
        issue_type,
        resolution_status,
        call_duration_min
    from {{ ref('stg_customer_service_interactions') }}
),

customers as (
    select
        customer_key,
        firstname,
        lastname,
        customer_email
    from {{ ref('dim_customer') }}
),

final as (
    select
        i.interaction_id,
        c.customer_key,
        i.agent_first_name,
        i.agent_last_name,
        i.agent_email,
        i.interaction_date,
        i.channel,
        i.issue_type,
        i.resolution_status,
        i.call_duration_min
    from interactions i
    left join customers c
        on i.customer_first_name = c.firstname
        and i.customer_last_name = c.lastname
)

select * from final
