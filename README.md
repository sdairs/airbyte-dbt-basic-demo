# What
This is an automated demonstration of using Airbyte & DBT to:
- Obtain a CSV file via HTTP and push it into to Postgres
- Run a DBT transformation over raw data in Postgres
- Sync Postgres to MariaDB

Two stacks are created in Docker
- The default Airbyte stack
- A custom stack of Postgres, MariaDB and pgAdmin

# How
Requires:
- Docker
- jq

## start.sh
This is the entry point that will configure the required stacks in Postgres.

## configure_airbyte.sh
This uses Airbyte's REST API to push configurations of:
- HTTP CSV File source
- PostgreSQL source
- MariaDB destination
- PostgreSQL destination
- Custom DBT transformation

With the following connections:
- File Source > PostgreSQL + Custom DBT Transformation
- PostgreSQL > MariaDB

Lastly, the script will trigger a manual sync of both connections.

When the script it complete, it will print your Airbyte URL to the terminal.

**Note**: You should use the Airbyte URL that is print to terminal, as it includes the default Workspace ID. Opening the link from Docker Desktop can create a new Workspace and you may not see any connections in the UI.

# Quickstart

Run `start.sh`

Run `configure_airbyte.sh`

Your Airbyte & pgAdmin URL will be printed to the terminal, along with user/password & container IPs.

When the two scripts complete successfully, you will find data available in Postgres & MaraiaDB.

In Postgres you will find a database called `src_db` with a schema `covid` and tables `raw_covid` and `typed_covid`.
In MariaDB you will find a database called `dest_sb` and the raw_covid table prefixed with abt_ e.g. `abt_raw_covid`.

**Note**: pgAdmin is not pre-configured with the Postgres server. You need to add a new Server connection, using the Postgres details that are printed to the terminal.