{{ config(materialized='table') }}

WITH comment_activity AS (
    SELECT
        TRY_TO_NUMBER(c._USERID) AS user_id,
        'comment' AS activity_type,
        c._CREATIONDATE AS activity_timestamp,
        0 AS votes_received,
        1 AS comments_received,
        0 AS posts_created,
        0 AS reputation_change
    FROM {{ source('public', 'comments') }} c
    WHERE TRY_TO_NUMBER(c._USERID) IS NOT NULL
),

post_activity AS (
    SELECT
        TRY_TO_NUMBER(p._OWNERUSERID) AS user_id,
        'post' AS activity_type,
        p._CREATIONDATE AS activity_timestamp,
        0 AS votes_received,
        0 AS comments_received,
        1 AS posts_created,
        0 AS reputation_change
    FROM {{ source('public', 'posts') }} p
    WHERE TRY_TO_NUMBER(p._OWNERUSERID) IS NOT NULL
),

user_snapshot AS (
    SELECT
        TRY_TO_NUMBER(u._ID) AS user_id,
        'reputation_snapshot' AS activity_type,
        u._CREATIONDATE AS activity_timestamp,
        0 AS votes_received,
        0 AS comments_received,
        0 AS posts_created,
        TRY_TO_NUMBER(u._REPUTATION) AS reputation_change
    FROM {{ source('public', 'users') }} u
    WHERE TRY_TO_NUMBER(u._ID) IS NOT NULL
)

SELECT * FROM comment_activity
UNION ALL
SELECT * FROM post_activity
UNION ALL
SELECT * FROM user_snapshot
