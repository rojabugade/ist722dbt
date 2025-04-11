select
  {{ dbt_utils.generate_surrogate_key(['CategoryID']) }} as categorykey,
  CategoryID,
  CategoryName,
  Description as CategoryDescription
from {{ source('northwind', 'Categories') }}