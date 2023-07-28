# Data analysis of Nobel Prize Awards with dbt and DuckDB

This is a small [dbt](https://www.getdbt.com/) project that shows how to use dbt with [DuckDB](https://duckdb.org/) as data processing engine.

Raw data is obtained from the [Nobel Prize API](https://nobelprize.readme.io/docs).

Results are rendered to a static report with the open source BI reporting tool [Evidence](https://evidence.dev/) (BI as code).

You can view the generated report [here](https://nobel-prize-report.tzelleke.com).

The generated dbt project documentation can be viewed [here](https://tzelleke.github.io/nobel-prize-report/).

## Local setup

```bash
# Clone the repo
git clone https://github.com/tzelleke/nobel-prize-report.git

cd nobel-prize-report/

# Install requirements
pip install -r requirements.txt
dbt deps

# Build dbt project docs
dbt docs generate

# Serve dbt project docs
# documentation site is served at http://localhost:8080
# dbt docs serve

# Download raw data
wget -O raw_data/laureates.json "https://api.nobelprize.org/2.1/laureates?limit=2000"

# Run dbt
dbt build
```
