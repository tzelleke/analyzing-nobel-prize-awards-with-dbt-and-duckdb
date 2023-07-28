select

    laureate_id,
    array_agg({
        'award_year': award_year,
        'category_slug': category_slug,
        'category': category,
        'prize_share': prize_share,
        'prize_share_raw': prize_share_raw,
        'prize_sort_order': prize_sort_order,
        'motivation': motivation,
        'prize_amount_adjusted': prize_amount_adjusted,
        'prize_amount': prize_amount,
    }) as prizes,

from {{ ref('stg_prizes') }}

group by

    1
