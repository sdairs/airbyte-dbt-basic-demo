# What
Pulls the latest Airbyte, sets up the default stack

Pulls latest Postgres & MariaDB, creates an instance of each

Puts 5 dummy records into Postgres

Configures Airbyte with:
- Postgres source
- MariaDB destintion
- Connection between the source & dest

Triggers the Connection to sync, resulting in 5 records in MariaDB

# How
Requires Docker

Run `start.sh`

Run `configure_airbyte.sh`

# TODO
- Add a csv file source
- Load the example covid dataset into Postgres
- Sync this data set
- Setup a custom transformation with dbt
