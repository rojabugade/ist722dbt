SELECT
    _ID AS vote_id,
    _POSTID AS post_id,
    _VOTETYPEID AS vote_type_id,
    _CREATIONDATE AS vote_creation_date
FROM SNOWFLAKE_FINAL_PROJECT.PUBLIC.VOTES
