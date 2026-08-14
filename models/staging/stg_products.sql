select
    product_id,
    product_name,
    category,
    price,
    case
        when price < 500 then 'LOW'
        when price < 2000 then 'MEDIUM'
        else 'HIGH'
    end as price_band
from {{ source('raw', 'products') }}