{#{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    ol.ORDER_LINE_ID AS sales_key,

    -- Foreign keys to dimensions
    c.customer_key,
    e.employee_key,
    p.product_key,
    s.store_key,
    d.date_key,

    -- Measures
    ol.QUANTITY,
    ol.UNIT_PRICE,
    (ol.QUANTITY * ol.UNIT_PRICE) AS total_amount

FROM {{ source('oliver_landing', 'orderline') }} ol
JOIN {{ source('oliver_landing', 'orders') }} o
    ON ol.ORDER_ID = o.ORDER_ID

JOIN {{ ref('oliver_dim_customer') }} c
    ON o.CUSTOMER_ID = c.CUSTOMER_ID

JOIN {{ ref('oliver_dim_employee') }} e
    ON o.EMPLOYEE_ID = e.EMPLOYEE_ID

JOIN {{ ref('oliver_dim_product') }} p
    ON ol.PRODUCT_ID = p.PRODUCT_ID

JOIN {{ ref('oliver_dim_store') }} s
    ON o.STORE_ID = s.STORE_ID

JOIN {{ ref('oliver_dim_date') }} d
    ON d.date_day = o.ORDER_DATE#}
