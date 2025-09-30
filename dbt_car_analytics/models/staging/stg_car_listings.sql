-- models/staging/stg_car_listings.sql

select
    -- We can add a unique key for each listing
    row_number() over (order by (select null)) as listing_id,

    -- Cast columns to their correct data types, selecting the source columns in UPPERCASE
    "MODEL"::varchar as model_name,
    "YEAR"::integer as model_year,
    "PRICE"::number(10, 2) as price,
    "TRANSMISSION"::varchar as transmission,
    "MILEAGE"::integer as mileage,
    "FUEL_TYPE"::varchar as fuel_type,
    "TAX"::number(10, 2) as tax,
    "MPG"::float as miles_per_gallon,
    "ENGINE_SIZE"::float as engine_size,
    "BRAND"::varchar as brand

from {{ source('raw', 'RAW_CAR_DATA') }}