{{
    config(
        materialized='view'
    )
}}

 with tbl as (
    select s.yr, s.mth, s.qr, s.dispatching_base_num, s.pickup_datetime, s.drop_off_datetime, s.p_ulocation_id, 
    s.d_olocation_id, s.sr_flag, s.affiliated_base_number, pickup_zone.borough as pickup_borough, pickup_zone.zone as
    pickup_zone, pickup_zone.service_zone as pickup_service_zone, dropoff_zone.borough as dropoff_borough, dropoff_zone.zone as
    dropoff_zone, dropoff_zone.service_zone as dropoff_service_zone
     from 
    {{ref('stg_fhv')}} as s
    inner join {{ref("dim_zones")}} as pickup_zone
    on s.p_ulocation_id = cast(pickup_zone.locationid as string) 
    inner join {{ref("dim_zones")}} as dropoff_zone
    on s.d_olocation_id =  cast(dropoff_zone.locationid as string) 
 )

 select * from tbl