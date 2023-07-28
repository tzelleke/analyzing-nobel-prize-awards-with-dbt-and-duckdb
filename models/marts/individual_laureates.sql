with

laureates_joined_to_awards as (

    select

        laureates.*,
        unnest(prizes.prizes) as prize,

    from {{ ref('stg_individual_laureates') }} as laureates

    left join {{ ref('int_laureate_id_prizes') }} as prizes
        using (laureate_id)

),

awards_unnested as (

    select

        laureates_joined_to_awards.*,
        unnest(prize),

    from laureates_joined_to_awards

),

final as (

    select

        *,

    from awards_unnested

    order by

        award_year

)

select * from final
