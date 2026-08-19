{{ config(materialized='table') }}

with product_sales as (

    select
        oi.product_id,
        sum(oi.quantity) as units_sold,
        sum(oi.line_amount) as total_sales
    from {{ ref('stg_order_items') }} oi
    join {{ ref('stg_orders') }} o
        on oi.order_id = o.order_id
    where o.is_completed = 1
    group by oi.product_id

)

select
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.price_band,
    coalesce(ps.units_sold, 0) as units_sold,
    coalesce(ps.total_sales, 0) as total_sales
from {{ ref('stg_products') }} p
left join product_sales ps
    on p.product_id = ps.product_id