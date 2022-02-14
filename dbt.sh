# Get the workspace for the Basic Normalisation
# NORMALIZE_WORKSPACE=`docker run --rm -i -v airbyte_workspace:/data  busybox find /data -path "*normalize/models*" | sed -E "s;/data/([0-9]+/[0-9]+/)normalize/.*;\1;g" | sort | uniq | tail -n 1`
# Copy the dbt config
# docker cp airbyte-server:/tmp/workspace/${NORMALIZE_WORKSPACE}/build/run/airbyte_utils/models/generated/ models/

# Locally build dbt models

python3 -m venv .venv
source .venv/bin/activate
pip install dbt-postgres

dbt build --profiles-dir ./.dbt