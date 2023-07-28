with

birth_country_joined as (

    select

        affiliations.*,
        laureates.birth_country,

    from {{ ref('int_research_affiliations') }} as affiliations

    left join {{ ref('stg_individual_laureates') }} as laureates
        using (laureate_id)

),

filtered as (

    select

        *,

    from birth_country_joined

    where

        affiliation_country is not null
),

with_affiliation_country_count as (

    select

        *,
        count(affiliation_country) over (
            partition by laureate_id, category_slug, award_year
        ) as affiliation_country_count,

    from filtered

),

stats as (

    select

        affiliation_country,
        category_slug,
        award_year,
        ifnull(
            sum(prize_share/affiliation_country_count),
            0
        ) as prizes_total,
        ifnull(
            sum(1/affiliation_country_count),
            0
        ) as laureates_total,
        ifnull(
            sum(prize_share/affiliation_country_count) filter (
                where affiliation_country != birth_country
            ),
        0) as prizes_foreign_born,
        ifnull(
            sum(1/affiliation_country_count) filter (
                where affiliation_country != birth_country
            ),
            0
        ) as laureates_foreign_born,

    from with_affiliation_country_count

    group by

        1,
        2,
        3

),

final as (

    select

        affiliation_country,
        category_slug,
        award_year,
        prizes_total,
        prizes_foreign_born,
        (prizes_total - prizes_foreign_born) as prizes_native_born,
        laureates_total,
        laureates_foreign_born,
        (laureates_total - laureates_foreign_born) as laureates_native_born,

    from stats

)

select * from final
