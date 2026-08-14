select
    order_item_id,
    order_id,
    product_id,
    quantity,
    item_price,
    quantity * item_price as line_amount
from {{ source('raw', 'order_items') }}