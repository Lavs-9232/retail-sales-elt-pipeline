select
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    case
        when order_status = 'Completed' then 1
        else 0
    end as is_completed
from {{ source('raw', 'orders') }}