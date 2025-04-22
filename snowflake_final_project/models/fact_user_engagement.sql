-- models/fact_user_engagement.sql
with comment_data as (
    select
        user_id,
        count(*) as comments_received
    from {{ ref('stg_comments') }}
    group by user_id
),
post_data as (
    select
        user_id,
        count(*) as posts_created
    from {{ ref('stg_posts') }}
    group by user_id
),
reputation_data as (
    select
        user_id,
        max(reputation) as reputation_change
    from {{ ref('stg_users') }}
    group by user_id
)
select
    u.user_id,
    coalesce(c.comments_received, 0) as comments_received,
    coalesce(p.posts_created, 0) as posts_created,
    coalesce(r.reputation_change, 0) as reputation_change
from {{ ref('stg_users') }} u
left join comment_data c on u.user_id = c.user_id
left join post_data p on u.user_id = p.user_id
left join reputation_data r on u.user_id = r.user_id
