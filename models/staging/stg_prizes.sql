with

prizes_unnested as (

    select

        *,
        unnest(_data.nobelPrizes) as prize,

    from {{ ref('base') }}

),

prizes_extracted as (

    select

        laureate_id,
        prize.awardYear as award_year,
        {{ slugify_category('prize.category.en') }} as category_slug,
        prize.category.en as category,
        is_organization,
        {{ parse_prize_share('prize.portion') }} as prize_share,
        prize.portion as prize_share_raw,
        prize.sortOrder as prize_sort_order,
        prize.motivation.en as motivation,
        prize.dateAwarded::date as date_awarded,
        prize.prizeAmountAdjusted as prize_amount_adjusted,
        prize.prizeAmount as prize_amount,
        prize.affiliations as affiliations,

    from prizes_unnested

)

select * from prizes_extracted
