{{
    config(
        materialized='view'
    )
}}

with tbl as (
    select *, timestamp_diff(drop_off_datetime, pickup_datetime, second) as trip_duration
     from {{ref("dim_fhv_trips")}}
),
perc as (
    select distinct dropoff_zone, pickup_zone, yr, mth, p_ulocation_id, d_olocation_id,
    PERCENTILE_CONT(trip_duration, 0.9 )
            OVER (PARTITION BY yr, mth, p_ulocation_id, d_olocation_id) AS p90
    from tbl where (pickup_zone = 'Newark Airport' or pickup_zone= 'SoHo' or pickup_zone='Yorkville East') and
    yr = 2019 and mth=11
    order by p90 desc

)

select * from perc