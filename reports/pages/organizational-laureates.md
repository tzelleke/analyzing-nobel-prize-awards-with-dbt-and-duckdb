---
title: Nobel Prizes awarded to organizations
---

```sql organizations_awarded
select
    make_date(award_year, 1, 1) as award_year,
    category,
    org_name,
    wikipedia.english as further,
from
    analytics.organizations_awarded
order by
    award_year desc,
    category
```

<DataTable data={organizations_awarded} search="true" rowShading="true">
    <Column id="award_year" label="Year" fmt="yyyy" align="left" />
    <Column id="category" label="Category" />
    <Column id="org_name" label="Organization" />
    <Column id="further" contentType="link" linkLabel="Wikipedia &rarr;" align="right" />
</DataTable>
