{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    -- Customer attributes
    c.FIRST_NAME AS customer_first_name,
    c.LAST_NAME AS customer_last_name,
    c.STATE AS customer_state,

    -- Employee attributes
    e.FIRST_NAME AS employee_first_name,
    e.LAST_NAME AS employee_last_name,
    e.POSITION AS employee_position,

    -- Product attributes
    p.PRODUCT_NAME,
    p.DESCRIPTION,
    p.UNIT_PRICE AS product_unit_price,

    -- Store attributes
    s.STORE_NAME,
    s.CITY AS store_city,
    s.STATE AS store_state,
    s.STREET AS store_street,

    -- Date attributes
    d.date_day,
    d.month_name,
    d.year_number,

    -- Measures
    f.QUANTITY,
    f.UNIT_PRICE,
    f.total_amount

FROM {{ ref('fact_sales') }} f
LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key
