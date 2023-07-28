with

affiliations_unnested as (

    select

        *,
        unnest(affiliations) as affiliation,

    from {{ ref('int_research_prizes') }}

    where

        is_organization = false

),

affiliations_extracted as (

    select

        laureate_id,
        award_year,
        category_slug,
        prize_share,
        prize_share_raw,
        affiliation.countryNow.en as affiliation_country,
        {{ fix_affiliation_name('affiliation.nameNow.en', 'affiliation.locationString.en') }} as affiliation_name,
        affiliation.locationString.en as affiliation_place,

    from affiliations_unnested

)

select * from affiliations_extracted
