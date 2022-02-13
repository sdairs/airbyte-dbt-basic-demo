cd airbyte
docker-compose down
docker volume rm airbyte-dbt_mariadb
docker volume rm airbyte-dbt_postgres
docker volume rm airbyte_data
docker volume rm airbyte_db
docker volume rm airbyte_workspace
cd ..
rm -rf ./airbyte