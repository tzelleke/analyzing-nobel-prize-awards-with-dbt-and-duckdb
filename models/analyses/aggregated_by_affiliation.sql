select

    affiliation_name,
    sum(prizes_total) as prizes_total,
    sum(laureates_total) as laureates_total,

from {{ ref('research_prizes_affiliation_stats') }}

group by

    1

order by

    prizes_total desc
