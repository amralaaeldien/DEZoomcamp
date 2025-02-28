{{
    config(
        materialized='view'
    )
}}

with tbl as (
    select f.service_type, f.yr, f.mth, f.qr, f.total_amount, f.tripid, f.fare_amount, f.trip_distance, f.payment_type_description from {{ ref("fact_trips") }} as f where
    fare_amount > 0 and 
    trip_distance > 0 and 
    payment_type_description in ('Cash', 'Credit card') 

)
select distinct service_type, yr, mth, PERCENTILE_CONT(fare_amount, 0.97 ) over(partition by service_type, yr, mth) as p97,
PERCENTILE_CONT(fare_amount, 0.95 ) over(partition by service_type, yr, mth)  AS p95,
PERCENTILE_CONT(fare_amount, 0.9 ) over(partition by service_type, yr, mth) AS p90
 from tbl 
 where yr=2020 and mth=04 
   

