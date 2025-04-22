-- models/dim_user.sql
select
    user_id,
    display_name,
    reputation,
    creation_date,
    location
from {{ ref('stg_users') }}
