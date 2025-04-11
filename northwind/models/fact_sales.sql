with stg_orders as (
    select
        OrderID,
        replace(to_date(OrderDate)::varchar, '-', '')::int as orderdatekey,
        replace(to_date(ShippedDate)::varchar, '-', '')::int as shippeddatekey,
        replace(to_date(RequiredDate)::varchar, '-', '')::int as requireddatekey,
        {{ dbt_utils.generate_surrogate_key(['CustomerID']) }} as customerkey,
        {{ dbt_utils.generate_surrogate_key(['EmployeeID']) }} as employeekey
    from {{ source('northwind', 'Orders') }}
),

stg_order_details as (
    select
        od.OrderID,
        {{ dbt_utils.generate_surrogate_key(['p.ProductID']) }} as productkey,
        {{ dbt_utils.generate_surrogate_key(['s.SupplierID']) }} as supplierkey,
        {{ dbt_utils.generate_surrogate_key(['c.CategoryID']) }} as categorykey,
        od.Quantity,
        od.UnitPrice,
        od.Discount,
        od.Quantity * od.UnitPrice * (1 - od.Discount) as salesamount
    from {{ source('northwind', 'Order_Details') }} od
    join {{ source('northwind', 'Products') }} p on od.ProductID = p.ProductID
    left join {{ source('northwind', 'Categories') }} c on p.CategoryID = c.CategoryID
    left join {{ source('northwind', 'Suppliers') }} s on p.SupplierID = s.SupplierID
)

select
    o.OrderID,
    o.orderdatekey,
    o.shippeddatekey,
    o.requireddatekey,
    o.customerkey,
    o.employeekey,
    od.productkey,
    od.categorykey,
    od.supplierkey,
    od.Quantity,
    od.UnitPrice,
    od.Discount,
    od.salesamount
from stg_orders o
join stg_order_details od on o.OrderID = od.OrderID
