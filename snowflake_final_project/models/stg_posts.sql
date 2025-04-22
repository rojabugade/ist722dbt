select
    "Id" as post_id,
    "OwnerUserId" as user_id,
    "CreationDate" as creation_date,
    "Score" as score,
    "Body" as body
from SNOWFLAKE_FINAL_PROJECT.PUBLIC.POSTS
