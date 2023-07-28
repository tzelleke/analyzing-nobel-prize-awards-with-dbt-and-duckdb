{% set WINDOW_SIZE = 15 %}

with

prizes_with_age_at_announcement as (

    select
    
        award_year,
        category_slug,
        date_diff('year', birth_date, date_awarded) as age_at_announcement,

    from {{ ref('stg_prizes') }}

        join {{ ref('stg_individual_laureates') }} using (laureate_id)

),

rolling_avg_age_by_category as (

    select distinct

        award_year,
        category_slug,
        avg(age_at_announcement) over (
            partition by category_slug
            order by award_year
            range between {{ WINDOW_SIZE - 1 }} preceding and current row
        ) as avg_age

    from prizes_with_age_at_announcement

),

rolling_avg_age_overall as (

    select distinct

        award_year,
        'overall' as category_slug,
        avg(age_at_announcement) over (
            order by award_year
            range between {{ WINDOW_SIZE - 1 }} preceding and current row
        ) as avg_age

    from prizes_with_age_at_announcement

),

final as (

    select * from rolling_avg_age_by_category

    union all

    select * from rolling_avg_age_overall

)

select * from final order by award_year, category_slug
