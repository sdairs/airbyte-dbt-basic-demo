# API URLS
# https://airbyte-public-api-docs.s3.us-east-2.amazonaws.com/rapidoc-api-docs.html#overview

AB_API='http://localhost:8000/api'

GET_SRC='/v1/sources/get'
GET_DEST='/v1/destinations/get'
GET_CONN='/v1/connections/get'
GET_WORK='/v1/workspaces/get'
GET_HEALTH='/v1/health'

LIST_WORK='/v1/workspaces/list'

CREATE_SRC='/v1/sources/create'
CREATE_DEST='/v1/destinations/create'
CREATE_CONN='/v1/connections/create'
CREATE_WORK='/v1/workspaces/create'

SYNC_CONN='/v1/connections/sync'

# Wait for Airbyte to be ready

while [[ "$(curl -s -XGET ${AB_API}${GET_HEALTH} | jq '.available' | tr -d '"')" != "true" ]]; do echo "Waiting for Airbyte to start..."; sleep 5; done

# Get default workspace ID

POST_LIST_WORK=`curl -s -XPOST -H 'Content-Type: application/json' ${AB_API}${LIST_WORK}`

WORKSPACE_ID=`echo $POST_LIST_WORK | jq '.workspaces[0].workspaceId' | tr -d '"'`

echo "Workspace ID: ${WORKSPACE_ID}"

# Create SOURCE

source_json_data()
{
  cat <<EOF
{
    "sourceDefinitionId": "decd338e-5647-4c0b-adf4-da0e75f5a750",
    "workspaceId": "${WORKSPACE_ID}",
    "connectionConfiguration": {
        "ssl": false,
        "host": "localhost",
        "port": 5432,
        "schemas": [
            "test"
        ],
        "database": "src_db",
        "password": "password",
        "username": "postgres",
        "tunnel_method": {
            "tunnel_method": "NO_TUNNEL"
        },
        "replication_method": {
            "method": "Standard"
        }
    },
    "name": "Postgres API Test"
}
EOF
}

POST_CREATE_SRC=`curl -s -XPOST -H 'Content-Type: application/json' ${AB_API}${CREATE_SRC} -d "$(source_json_data)"`

SRC_ID=`echo ${POST_CREATE_SRC} | jq '.sourceId'`

echo "Source ID: ${SRC_ID}"

# Create DEST

dest_json_data()
{
  cat <<EOF
{
  "destinationDefinitionId": "ca81ee7c-3163-4246-af40-094cc31e5e42",
  "workspaceId": "${WORKSPACE_ID}",
  "connectionConfiguration": {
    "ssl": false,
    "host": "localhost",
    "port": 3306,
    "database": "dest_db",
    "password": "password",
    "username": "root",
    "tunnel_method": {
      "tunnel_method": "NO_TUNNEL"
    }
  },
  "name": "Maria Dest"
}
EOF
}

POST_CREATE_DEST=`curl -s -XPOST -H 'Content-Type: application/json' ${AB_API}${CREATE_DEST} -d "$(dest_json_data)"`

DEST_ID=`echo ${POST_CREATE_DEST} | jq '.destinationId'`

echo "Destination ID: ${DEST_ID}"

# Create CONNECTION


# Start a sync


# FIN

echo "Go to http://localhost:8000/workspaces/${WORKSPACE_ID}"