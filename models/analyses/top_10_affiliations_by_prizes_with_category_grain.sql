with

top_10_affiliations as (

    select
    
        affiliation_name,
        prizes_total,

    from {{ ref('aggregated_by_affiliation') }}

    order by

        prizes_total desc

    limit 10

),

top_10_filtered as (

    select

        stats.*

    from {{ ref('research_prizes_affiliation_stats') }} as stats

        join top_10_affiliations using (affiliation_name)

),

aggregated_by_affiliation_and_category as (
    
    select

        affiliation_name,
        category_slug,
        sum(prizes_total) as prizes_total,

    from top_10_filtered

    group by

        1,
        2
    
),

final as (

    select

        aggregated_by_affiliation_and_category.*

    from aggregated_by_affiliation_and_category

        join top_10_affiliations using (affiliation_name)

    order by

        top_10_affiliations.prizes_total desc

)

select * from final
