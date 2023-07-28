---
title: "Nobel Prizes in research by affiliation"
---

```sql aggregated_by_affiliation
select
    *
from
    analytics.aggregated_by_affiliation
order by
    prizes_total desc
```

```sql top_10_affiliations_by_prizes
select * from analytics.top_10_affiliations_by_prizes_with_category_grain
```

```sql top_10_affiliations_by_laureates
select * from analytics.top_10_affiliations_by_laureates_with_category_grain
```

<Details title="Calculation details">

    * Nobel Prizes / Laureates count towards the affiliated research institution.
    * Counts are weighted by the prize share of each laureate.
    * Where a laureate has multiple affiliations, the count is split evenly among each affiliation.

</Details>

## Top 10 research institutions

<Tabs>
    <Tab label="by prize share">
        <BarChart 
            data={top_10_affiliations_by_prizes} 
            swapXY=true 
            x=affiliation_name 
            y=prizes_total
            series=category_slug
            xType=category 
            sort=false
        />
    </Tab>
    <Tab label="by individual laureate">
        <BarChart 
            data={top_10_affiliations_by_laureates} 
            swapXY=true 
            x=affiliation_name 
            y=laureates_total 
            series=category_slug
            xType=category 
            sort=false
        />
    </Tab>
</Tabs>

---

### All institutions

<DataTable data="{aggregated_by_affiliation}" search="false" rowShading="true">
    <Column id="affiliation_name" title="Name" align="left" />
    <Column id="prizes_total" title="# by prize share" />
    <Column id="laureates_total" title="# by individual laureate" align="right" />
</DataTable>
