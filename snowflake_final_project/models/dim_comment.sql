SELECT
    _ID AS comment_id,
    _POSTID AS post_id,
    _SCORE AS score,
    _TEXT AS comment_text,
    _CREATIONDATE AS creation_date,
    _USERID AS user_id,
    _USERDISPLAYNAME AS user_display_name
FROM SNOWFLAKE_FINAL_PROJECT.PUBLIC.COMMENTS
