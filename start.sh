docker-compose -f stack.yml up -d

git clone https://github.com/airbytehq/airbyte.git
cd airbyte
docker-compose up -d

PG_IP=`docker inspect source_pg_db | jq '.[].NetworkSettings.Networks.airbyte_dbt_default.IPAddress' | tr -d '"'`
MY_IP=`docker inspect dest_my_db | jq '.[].NetworkSettings.Networks.airbyte_dbt_default.IPAddress' | tr -d '"'`

echo "Postgres server details"
echo "-----------------------"
echo "Host: ${PG_IP}"
echo "Port: 5432"
echo "User: postgres"
echo "Pass: password"
echo "-----------------------"
echo "MariaDB server details"
echo "-----------------------"
echo "Host: ${MY_IP}"
echo "Port: 3306"
echo "User: root"
echo "Pass: password"
echo "-----------------------"
echo "Visit pgAdmin on http://localhost:8080"
echo "login with: me@me.me : password"