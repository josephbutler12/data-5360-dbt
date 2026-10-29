{#{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    EMPLOYEE_ID AS employee_key,
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    POSITION,
    HIRE_DATE
FROM {{ source('oliver_landing', 'employee') }}#}
