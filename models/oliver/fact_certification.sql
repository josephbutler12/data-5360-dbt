with certs as (
    select *
    from {{ ref('stg_employee_certifications') }}
),

employees as (
    select employee_key, employee_id
    from {{ ref('oliver_dim_employee') }}
),

dates as (
    select date_key, date_day
    from {{ ref('oliver_dim_date') }}
),

final as (
    select
        e.employee_key,
        d.date_key,
        c.certification_name,
        c.certification_cost
    from certs c
    left join employees e
        on c.employee_id = e.employee_id
    left join dates d
        on c.certification_awarded_date = d.date_day
)

select * from final

