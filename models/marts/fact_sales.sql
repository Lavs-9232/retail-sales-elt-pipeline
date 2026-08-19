{{ config(materialized='table') }}

select
    oi.order_item_id,
    oi.order_id,
    o.order_date,
    o.customer_id,
    oi.product_id,
    oi.quantity,
    oi.item_price,
    oi.line_amount,
    o.order_status,
    o.is_completed
from {{ ref('stg_order_items') }} oi
inner join {{ ref('stg_orders') }} o
    on oi.order_id = o.order_id