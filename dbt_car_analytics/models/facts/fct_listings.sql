-- models/marts/facts/fct_listings.sql

with listings as (
    select * from {{ ref('stg_car_listings') }}
),
cars as (
    select * from {{ ref('dim_cars') }}
),
engines as (
    select * from {{ ref('dim_engines') }}
),
transmissions as (
    select * from {{ ref('dim_transmissions') }}
)
select
    -- Select the unique key from the staging layer
    listings.listing_id,

    -- Select the foreign keys from the dimension tables
    cars.car_key,
    engines.engine_key,
    transmissions.transmission_key,

    -- Select the facts (numeric measures)
    listings.price,
    listings.mileage,
    listings.tax,
    listings.miles_per_gallon,
    listings.model_year

from listings
left join cars on listings.brand = cars.brand and listings.model_name = cars.model_name
left join engines on listings.fuel_type = engines.fuel_type and listings.engine_size = engines.engine_size
left join transmissions on listings.transmission = transmissions.transmission