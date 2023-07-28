---
title: "Nobel Prizes awarded to individuals"
---

```sql individual_laureates
select
    laureate_id,
    make_date(award_year, 1, 1) as award_year,
    category,
    full_name,
from
    analytics.individual_laureates
order by
    award_year desc,
    category
```

```sql count_individual_laureates
select
    count(distinct laureate_id) as count
from
    analytics.individual_laureates
```

```sql count_female_laureates
select
    count(distinct laureate_id) as count
from
    analytics.individual_laureates
where
    gender = 'female'
```

```sql average_age_over_time
select
    make_date(award_year, 1, 1) as award_year,
    category_slug,
    avg_age,
from
    analytics.rolling_average_age
where
    award_year >= 1916
    and category_slug != 'overall'
order by
    award_year desc,
    category_slug
```

<BigValue 
    title="Individual Laureates"
    data={count_individual_laureates} 
    value="count" 
    maxWidth="10em"
/>

<BigValue 
    title="Female Laureates"
    data={count_female_laureates} 
    value="count" 
    maxWidth="10em"
/>

---

## Average age of individual laureates over time

_Rolling window over 15 years_

<LineChart 
    data={average_age_over_time} 
    x="award_year" 
    y="avg_age"
    series="category_slug" 
    xFmt="yyyy"
    yMin="40"
    yMax="80"
    yFmt=".2f"
    lineType="dashed"
    lineWidth="3"
    xBaseline="false"
/>

---

## All prizes awarded to individuals

<DataTable data={individual_laureates} search="true" rowShading="true">
    <Column id="award_year" label="Year" fmt="yyyy" align="left" />
    <Column id="category" label="Year" />
    <Column id="full_name" label="Full Name" align="right" />
</DataTable>
