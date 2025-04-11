with stg_employees as (
    select * from {{ source('northwind', 'Employees') }}
),

stg_supervisors as (
    select * from {{ source('northwind', 'Employees') }}
)

select 
    {{ dbt_utils.generate_surrogate_key(['e.EmployeeID']) }} as employeekey,
    e.EmployeeID,
    concat(e.LastName , ', ', e.FirstName) as employeenamelastfirst,
    concat(e.FirstName , ' ', e.LastName) as employeenamefirstlast,
    e.Title as employeetitle,
    concat(s.LastName , ', ', s.FirstName) as supervisornamelastfirst,
    concat(s.FirstName , ' ', s.LastName) as supervisornamefirstlast

from stg_employees e
left join stg_supervisors s on e.ReportsTo = s.EmployeeID
