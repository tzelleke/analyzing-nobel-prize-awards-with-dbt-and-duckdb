---
title: "Nobel Prizes in research by country"
---

```sql aggregated_by_affiliation_country
select
    *
from
    analytics.aggregated_by_affiliation_country
order by
    prizes_total desc,
    affiliation_country
```

```sql top_10_countries_by_prizes
select * from analytics.top_10_countries_by_prizes_with_category_grain
```

```sql top_10_countries_by_laureates
select * from analytics.top_10_countries_by_laureates_with_category_grain
```

<Details title="Calculation details">

    * Nobel Prizes / Laureates count towards the affiliated research institution's country.
    * Counts are weighted by the prize share of each laureate.
    * Where a laureate has multiple affiliations, the count is split evenly among each affiliation's country.

</Details>

## Top 10 countries

<Tabs>
    <Tab label="by prize share">
        <BarChart 
            data={top_10_countries_by_prizes} 
            swapXY=true 
            x=affiliation_country 
            y=prizes_total
            series=category_slug
            xType=category 
            sort=false
        />
    </Tab>
    <Tab label="by individual laureate">
        <BarChart 
            data={top_10_countries_by_laureates} 
            swapXY=true 
            x=affiliation_country 
            y=laureates_total 
            series=category_slug
            xType=category 
            sort=false
        />
    </Tab>
</Tabs>

---

### All countries

<DataTable data="{aggregated_by_affiliation_country}" search="false" rowShading="true">
    <Column id="affiliation_country" title="Country Name" align="left" />
    <Column id="prizes_total" title="# by prize share" />
    <Column id="laureates_total" title="# by individual laureate" align="right" />
</DataTable>
