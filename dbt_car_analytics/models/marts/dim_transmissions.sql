-- models/marts/dimensions/dim_transmissions.sql

select
    row_number() over (order by transmission) as transmission_key,
    transmission
from {{ ref('stg_car_listings') }}
group by transmission 