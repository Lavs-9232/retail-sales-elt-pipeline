select
    customer_id,
    customer_name,
    email,
    city,
    state,
    signup_date
from {{ source('raw', 'customers') }}