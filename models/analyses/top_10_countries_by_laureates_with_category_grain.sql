with

top_10_countries as (

    select
    
        affiliation_country,
        laureates_total,

    from {{ ref('aggregated_by_affiliation_country') }}

    order by

        laureates_total desc

    limit 10

),

top_10_filtered as (

    select

        stats.*

    from {{ ref('research_prizes_country_stats') }} as stats

        join top_10_countries using (affiliation_country)

),

aggregated_by_country_and_category as (
    
    select

        affiliation_country,
        category_slug,
        sum(laureates_total) as laureates_total,

    from top_10_filtered

    group by

        1,
        2
    
),

final as (

    select

        aggregated_by_country_and_category.*

    from aggregated_by_country_and_category

        join top_10_countries using (affiliation_country)

    order by

        top_10_countries.laureates_total desc

)

select * from final
