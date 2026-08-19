{{ config(materialized='table') }}

with customer_sales as (

    select
        o.customer_id,
        count(distinct o.order_id) as total_orders,
        sum(oi.line_amount) as total_sales
    from {{ ref('stg_order_items') }} oi
    join {{ ref('stg_orders') }} o
        on oi.order_id = o.order_id
    where o.is_completed = 1
    group by customer_id

)

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.state,
    c.signup_date,
    coalesce(cs.total_orders, 0) as total_orders,
    coalesce(cs.total_sales, 0) as total_sales,
    case
        when coalesce(cs.total_sales, 0) >= 5000 then 'HIGH_VALUE'
        when coalesce(cs.total_sales, 0) >= 2000 then 'MEDIUM_VALUE'
        else 'LOW_VALUE'
    end as customer_segment
from {{ ref('stg_customers') }} c
left join customer_sales cs
    on c.customer_id = cs.customer_id