with stg_products as (
    select * from {{ source('northwind', 'Products') }}
),

stg_categories as (
    select * from {{ source('northwind', 'Categories') }}
),

stg_suppliers as (
    select * from {{ source('northwind', 'Suppliers') }}
)

select 
    {{ dbt_utils.generate_surrogate_key(['p.ProductID']) }} as productkey,
    p.ProductID,
    p.ProductName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued,
    c.CategoryID,
    c.CategoryName,
    c.Description as CategoryDescription,
    s.SupplierID,
    s.CompanyName as SupplierName,
    s.ContactName as SupplierContact,
    s.Country as SupplierCountry
from stg_products p
left join stg_categories c on p.CategoryID = c.CategoryID
left join stg_suppliers s on p.SupplierID = s.SupplierID
