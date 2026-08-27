WITH CTE AS (
select
to_timestamp(started_at) as started_at,
DATE(to_timestamp(started_at)) as date_started_at,
hour(to_timestamp(started_at)) as hour_started_at,
case
when dayname(to_timestamp(started_at)) in ('Sat','Sun')
then 'weekend'
else 'businessday'
end as day_type,

case
when month(to_timestamp(started_at)) in (12,1,2)
then 'winter'
when month(to_timestamp(started_at)) in (6,7,8)
then 'summer'
when month(to_timestamp(started_at)) in (3,4,5)
then 'spring'
else 'autumn'
end as station_of_year

from {{ source('demo', 'bike') }}    
)


select * from CTE