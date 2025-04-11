with stg_orders as (
    select
        OrderID,
        {{ dbt_utils.generate_surrogate_key(['EmployeeID']) }} as employeekey,
        {{ dbt_utils.generate_surrogate_key(['CustomerID']) }} as customerkey,
        replace(to_date(OrderDate)::varchar, '-', '')::int as orderdatekey,
        replace(to_date(ShippedDate)::varchar, '-', '')::int as shippeddatekey,
        replace(to_date(RequiredDate)::varchar, '-', '')::int as requireddatekey,
        ShipName,
        ShipAddress,
        ShipCity,
        ShipRegion,
        ShipPostalCode,
        ShipCountry,
        Freight,
        ShipVia
    from {{ source('northwind', 'Orders') }}
),

stg_order_details as (
    select 
        OrderID,
        sum(Quantity) as quantityonorder,
        sum(Quantity * UnitPrice * (1 - Discount)) as totalorderamount
    from {{ source('northwind', 'Order_Details') }}
    group by OrderID
),

stg_shippers as (
    select * from {{ source('northwind', 'Shippers') }}
)

select
    o.OrderID,
    o.customerkey,
    o.employeekey,
    o.orderdatekey,
    o.requireddatekey,
    o.shippeddatekey,
    o.ShipName,
    o.ShipAddress,
    o.ShipCity,
    o.ShipRegion,
    o.ShipPostalCode,
    o.ShipCountry,
    o.Freight,
    o.ShipVia,
    s.CompanyName as shippercompanyname,
    od.quantityonorder,
    od.totalorderamount,
    o.shippeddatekey - o.orderdatekey as daysfromordertoshipped,
    o.requireddatekey - o.orderdatekey as daysfromordertorequired,
    o.shippeddatekey - o.requireddatekey as shippedtorequireddelta,
    case when o.shippeddatekey - o.requireddatekey <= 0 then 'Y' else 'N' end as shippedontime
from stg_orders o
join stg_order_details od on o.OrderID = od.OrderID
join stg_shippers s on s.ShipperID = o.ShipVia
