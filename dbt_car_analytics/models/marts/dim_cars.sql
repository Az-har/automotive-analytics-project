-- models/marts/dimensions/dim_cars.sql

with unique_cars as (
    select
        -- Use a composite key of brand and model name to find unique cars
        distinct
        brand,
        model_name
    from {{ ref('stg_car_listings') }}
)
select
    -- Create a surrogate key for each unique car
    row_number() over (order by brand, model_name) as car_key,
    brand,
    model_name
from unique_cars