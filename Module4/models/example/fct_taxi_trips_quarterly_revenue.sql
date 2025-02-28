{{
    config(
        materialized='view'
    )
}}

with tbl as (
    select f.service_type, f.yr, f.mth, f.qr, f.total_amount, f.tripid from {{ ref("fact_trips") }} as f
)


select sum(total_amount) as total_amount, qr, service_type from tbl group by service_type, yr, qr having yr=2020 order by total_amount desc

