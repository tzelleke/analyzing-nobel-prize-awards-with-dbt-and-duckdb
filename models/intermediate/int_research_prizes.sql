select

    *,

from {{ ref('stg_prizes') }}

where

    category_slug in ('physics', 'chemistry', 'physiology-or-medicine', 'economic-sciences')
