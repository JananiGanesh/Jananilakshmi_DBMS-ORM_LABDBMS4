CREATE DEFINER=`root`@`localhost` PROCEDURE `supplierdetails`()
BEGIN
select s.supp_name,y.*,
case
when AverageRating=5 then 'Excellent Service'
when AverageRating>4 then 'Good Service'
when AverageRating>2 then 'Average Service'
else 'poor service'
end as Type_Of_Service
 from supplier as s inner join(
select SUPP_ID,avg(ratingstars) as AverageRating 
from
(select sp.SUPP_ID,ra.ord_id,ra.rat_ratstars  as ratingstars from supplier_pricing as sp inner join(
select o.ORD_ID,o.PRICING_ID, r.RAT_RATSTARS from `order` as o inner join
 rating as r
on r.ORD_ID=o.ORD_ID) as ra
on ra.PRICING_ID=sp.PRICING_ID) as x
group by SUPP_ID) as y 
on s.supp_id=y.SUPP_ID;
END