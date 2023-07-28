select

    affiliation_country,
    sum(prizes_total) as prizes_total,
    sum(laureates_total) as laureates_total,

from {{ ref('research_prizes_country_stats') }}

group by

    1

order by

    prizes_total desc
