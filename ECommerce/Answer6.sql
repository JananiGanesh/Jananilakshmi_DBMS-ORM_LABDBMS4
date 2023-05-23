

Select C.cat_id as CategoryID, C.cat_name as CategoryName,
P.pro_id as ProductID,P.pro_name as ProductName, SP.min_price as LeastPrice
from Category C
inner join product P ON C.cat_id = P.cat_id
inner join  (
    select C.cat_id, MIN(SP.supp_price) as min_price
    from Category C
    inner join product P on C.cat_id = P.cat_id
    inner join supplier_pricing SP on P.pro_id = SP.pro_id
    group by C.cat_id
) as SP on C.cat_id = SP.cat_id AND P.pro_id = (
    select P.pro_id
	from product P
    inner join supplier_pricing SP on P.pro_id = SP.pro_id
    where C.cat_id = P.cat_id
    order by SP.supp_price ASC
    LIMIT 1
);
