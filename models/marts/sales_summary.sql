{{ config(materialized='table') }}

select
    order_date,
    count(distinct order_id) as total_orders,
    sum(quantity) as total_units_sold,
    sum(line_amount) as total_sales,
    round(avg(line_amount), 2) as avg_line_value
from {{ ref('fact_sales') }}
where is_completed = 1
group by order_date
order by order_date