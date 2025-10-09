-- models/staging/stg_car_listings.sql

select
    row_number() over (order by (select null)) as listing_id,

    -- Standardize the BRAND column
    case
        when lower(trim("BRAND")) = 'merc' then 'Mercedes-Benz'
        when lower(trim("BRAND")) = 'hyundi' then 'Hyundai'
        -- Coalesce the 'unclean' brands into their correct ones
        when lower(trim("BRAND")) in ('unclean cclass', 'cclass') then 'Mercedes-Benz'
        when lower(trim("BRAND")) in ('unclean focus', 'focus') then 'Ford'
        else initcap(trim("BRAND")) -- Capitalize the first letter of other brands
    end::varchar as brand,
    
    -- Standardize the MODEL column
    case
        when lower(trim("MODEL")) = 'unclean cclass' then 'C-Class'
        when lower(trim("MODEL")) = 'unclean focus' then 'Focus'
        else trim("MODEL")
    end::varchar as model_name,

    "YEAR"::integer as model_year,
    "PRICE"::number(10, 2) as price,
    "TRANSMISSION"::varchar as transmission,
    "MILEAGE"::integer as mileage,
    "FUEL_TYPE"::varchar as fuel_type,
    "TAX"::number(10, 2) as tax,
    "MPG"::float as miles_per_gallon,
    "ENGINE_SIZE"::float as engine_size

from {{ source('raw', 'RAW_CAR_DATA') }}