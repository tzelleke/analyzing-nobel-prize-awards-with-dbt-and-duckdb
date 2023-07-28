with

extracted as (

    select

        laureate_id,
        _data.fullName.en as full_name,
        _data.gender as gender,
        replace(_data.birth.date, '-00-00', '-12-31')::date as birth_date,
        _data.birth.place.locationString.en as birth_place,
        _data.birth.place.countryNow.en as birth_country,
        _data.death.date::date as death_date,
        _data.orgName.en as org_name,
        _data.wikipedia as wikipedia,
        _data.wikidata as wikidata,

    from {{ ref('base') }}

    where

        is_organization = false

),

with_age as (

    select

        extracted.*,
        case
            when death_date is null
                then date_diff('year', birth_date, current_date)
        end as age,

    from extracted

)

select * from with_age
