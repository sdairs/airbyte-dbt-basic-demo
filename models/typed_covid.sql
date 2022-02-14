select cast("key" as char(2)) as "country_code",
    cast("date" as date) as "report_date",
    cast(new_tested as integer),
    cast(new_deceased as integer),
    cast(total_tested as integer),
    cast(new_confirmed as integer),
    cast(new_recovered as integer),
    cast(total_deceased as integer),
    cast(total_confirmed as integer),
    cast(total_recovered as integer)
from {{ ref('raw_covid') }}