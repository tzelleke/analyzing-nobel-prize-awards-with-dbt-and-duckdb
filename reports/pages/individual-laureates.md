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

<BigValue 
    title='Individual Laureates'
    data={count_individual_laureates} 
    value='count' 
    maxWidth='10em'
/>

<BigValue 
    title='Female Laureates'
    data={count_female_laureates} 
    value='count' 
    maxWidth='10em'
/>

---

<DataTable data={individual_laureates} search="true" rowShading="true">
    <Column id="award_year" label="Year" fmt="yyyy" align="left" />
    <Column id="category" label="Year" />
    <Column id="full_name" label="Full Name" align="right" />
</DataTable>
