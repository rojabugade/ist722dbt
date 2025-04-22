SELECT
    _ID AS user_id,
    _DISPLAYNAME AS display_name,
    _REPUTATION AS reputation,
    _CREATIONDATE AS creation_date,
    _LASTACCESSDATE AS last_access_date,
    _WEBSITEURL AS website_url,
    _LOCATION AS location,
    _ABOUTME AS about_me,
    _VIEWS AS views,
    _UPVOTES AS upvotes,
    _DOWNVOTES AS downvotes,
    _ACCOUNTID AS account_id
--FROM SNOWFLAKE_FINAL_PROJECT.PUBLIC.USERS
FROM {{ source('public', 'users') }}
