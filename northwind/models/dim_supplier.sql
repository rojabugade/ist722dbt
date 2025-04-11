select
  {{ dbt_utils.generate_surrogate_key(['SupplierID']) }} as supplierkey,
  SupplierID,
  CompanyName,
  ContactName,
  ContactTitle,
  Address,
  City,
  Region,
  PostalCode,
  Country,
  Phone
from {{ source('northwind', 'Suppliers') }}
