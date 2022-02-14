    with __dbt__cte__raw_covid_ab1 as (
        -- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
        -- depends_on: "src_db".covid._airbyte_raw_raw_covid
        select jsonb_extract_path_text(_airbyte_data, 'key') as "key",
            jsonb_extract_path_text(_airbyte_data, 'date') as "date",
            jsonb_extract_path_text(_airbyte_data, 'new_tested') as new_tested,
            jsonb_extract_path_text(_airbyte_data, 'new_deceased') as new_deceased,
            jsonb_extract_path_text(_airbyte_data, 'total_tested') as total_tested,
            jsonb_extract_path_text(_airbyte_data, 'new_confirmed') as new_confirmed,
            jsonb_extract_path_text(_airbyte_data, 'new_recovered') as new_recovered,
            jsonb_extract_path_text(_airbyte_data, 'total_deceased') as total_deceased,
            jsonb_extract_path_text(_airbyte_data, 'total_confirmed') as total_confirmed,
            jsonb_extract_path_text(_airbyte_data, 'total_recovered') as total_recovered,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            now() as _airbyte_normalized_at
        from "src_db".covid._airbyte_raw_raw_covid as table_alias -- raw_covid
        where 1 = 1
    ),
    __dbt__cte__raw_covid_ab2 as (
        -- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
        -- depends_on: __dbt__cte__raw_covid_ab1
        select cast("key" as varchar) as "key",
            cast("date" as varchar) as "date",
            cast(new_tested as float) as new_tested,
            cast(new_deceased as float) as new_deceased,
            cast(total_tested as float) as total_tested,
            cast(new_confirmed as float) as new_confirmed,
            cast(new_recovered as float) as new_recovered,
            cast(total_deceased as float) as total_deceased,
            cast(total_confirmed as float) as total_confirmed,
            cast(total_recovered as float) as total_recovered,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            now() as _airbyte_normalized_at
        from __dbt__cte__raw_covid_ab1 -- raw_covid
        where 1 = 1
    ),
    __dbt__cte__raw_covid_ab3 as (
        -- SQL model to build a hash column based on the values of this record
        -- depends_on: __dbt__cte__raw_covid_ab2
        select md5(
                cast(
                    coalesce(cast("key" as varchar), '') || '-' || coalesce(cast("date" as varchar), '') || '-' || coalesce(cast(new_tested as varchar), '') || '-' || coalesce(cast(new_deceased as varchar), '') || '-' || coalesce(cast(total_tested as varchar), '') || '-' || coalesce(cast(new_confirmed as varchar), '') || '-' || coalesce(cast(new_recovered as varchar), '') || '-' || coalesce(cast(total_deceased as varchar), '') || '-' || coalesce(cast(total_confirmed as varchar), '') || '-' || coalesce(cast(total_recovered as varchar), '') as varchar
                )
            ) as _airbyte_raw_covid_hashid,
            tmp.*
        from __dbt__cte__raw_covid_ab2 tmp -- raw_covid
        where 1 = 1
    ) -- Final base SQL model
    -- depends_on: __dbt__cte__raw_covid_ab3
    select "key",
        "date",
        new_tested,
        new_deceased,
        total_tested,
        new_confirmed,
        new_recovered,
        total_deceased,
        total_confirmed,
        total_recovered,
        _airbyte_ab_id,
        _airbyte_emitted_at,
        now() as _airbyte_normalized_at,
        _airbyte_raw_covid_hashid
    from __dbt__cte__raw_covid_ab3 -- raw_covid from "src_db".covid._airbyte_raw_raw_covid
    where 1 = 1
