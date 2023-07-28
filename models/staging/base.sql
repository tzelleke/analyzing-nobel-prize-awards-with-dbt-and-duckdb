with

source as (

    select

        unnest(laureates) as _data,

    from {{ source('raw_data', 'laureates') }}

),

final as (

    select

        _data.id as laureate_id,
        case
            when _data.orgName is not null then true
            else false
        end as is_organization,
        _data,

    from source

)

select * from final
