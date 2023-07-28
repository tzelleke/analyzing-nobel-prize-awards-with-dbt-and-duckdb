{% macro slugify_category(col) -%}
    lower(replace({{ col }}, ' ', '-'))
{%- endmacro %}

{% macro parse_prize_share(col) -%}
    case
        when {{ col }} = '1' then 1.
        when {{ col }} = '1/2' then (1 / 2)
        when {{ col }} = '1/3' then (1 / 3)
        when {{ col }} = '1/4' then (1 / 4)
        else null
    end
{%- endmacro %}

{% macro fix_affiliation_name(name_col, place_col) -%}
    case
        when {{ name_col }}  = 'University of California'
            then 'University of California, ' || split_part({{ place_col }}, ',', 1)
        else {{ name_col}}
    end
{%- endmacro %}
