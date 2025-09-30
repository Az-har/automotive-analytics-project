-- models/marts/dimensions/dim_engines.sql

select
    row_number() over (order by fuel_type, engine_size) as engine_key,
    fuel_type,
    engine_size
from {{ ref('stg_car_listings') }}
group by fuel_type, engine_size 