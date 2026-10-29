{#{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    STORE_ID AS store_key,
    STORE_ID,
    STORE_NAME,
    CITY,
    STATE,
    STREET
FROM {{ source('oliver_landing', 'store') }}#}
