with

org_laureates as (

    select

        laureate_id,
        _data.orgName.en as org_name,
        _data.wikipedia as wikipedia,
        _data.wikidata as wikidata,

    from {{ ref('base') }}

    where

        is_organization = true

),

org_laureates_joined_to_awards as (

    select

        org_laureates.laureate_id,
        org_laureates.org_name,
        prizes.award_year,
        prizes.category_slug,
        prizes.category,
        prizes.prize_share,
        prizes.prize_share_raw,
        prizes.prize_sort_order,
        prizes.motivation,
        org_laureates.wikipedia,
        org_laureates.wikidata,
        prizes.prize_amount_adjusted,
        prizes.prize_amount,

    from org_laureates

    left join {{ ref('stg_prizes') }} as prizes
        using (laureate_id)

)

select * from org_laureates_joined_to_awards
