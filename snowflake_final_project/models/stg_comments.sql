select
    comment_id,
    post_id,
    user_id,
    creation_date,
    score,
    text
from {{ source('PUBLIC', 'COMMENTS') }}
