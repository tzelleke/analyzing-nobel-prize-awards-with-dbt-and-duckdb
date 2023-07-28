with

filtered as (

    select

        *,

    from {{ ref('int_research_affiliations') }} as affiliations

    where

        affiliation_name is not null
),

with_affiliation_count as (

    select

        *,
        count(affiliation_name) over (
            partition by laureate_id, category_slug, award_year
        ) as affiliation_count,

    from filtered

),

stats as (

    select

        affiliation_name,
        category_slug,
        award_year,
        ifnull(
            sum(prize_share/affiliation_count),
            0
        ) as prizes_total,
        ifnull(
            sum(1/affiliation_count),
            0
        ) as laureates_total,

    from with_affiliation_count

    group by

        1,
        2,
        3

),

final as (

    select

        affiliation_name,
        category_slug,
        award_year,
        prizes_total,
        laureates_total,

    from stats

)

select * from final
