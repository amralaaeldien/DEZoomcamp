{{
    config(
        materialized='view'
    )
}}

with tbl as (
    select *,
    extract (year from s.pickup_datetime) as yr,
    extract (month from s.pickup_datetime) as mth,
    extract (quarter from s.pickup_datetime) as qr
     from {{ source('staging','fhv') }} as s where dispatching_base_num is not null
)

select * from tbl