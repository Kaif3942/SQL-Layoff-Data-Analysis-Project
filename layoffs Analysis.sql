SELECT * FROM dataanalytics.layoffs;

-- max_laidoff and min laid__off
-- company who has laid off maximum
-- date max,min of laidoff
-- year wise laidoff 
-- month wise laidoff with rolling laidoff (cum_sum)
-- company wise laidoff with stage of fund_raised
-- company avg percentage laidoff
-- rank of top 5 company in year who has laid of most

-- max_laidoff and min laid__off
select max(total_laid_off) as maximum,min(total_laid_off) as minimum from layoffs;

-- company who has laid off maximum to 5 companies
select company,max(total_laid_off) from layoffs group by company order by 2 desc limit 5;

-- date max,min of laidoff
select max(`date`),min(`date`) from layoffs;

-- year wise laidoff
select date_format(`date`,"%Y") as year,sum(total_laid_off) from layoffs group by year;

-- month wise laidoff with rolling laidoff (cum_sum)
with monthly_laid_off as (select date_format(`date`,"%Y-%m") as `month` ,
sum(total_laid_off) as 'month_laid_off' 
from layoffs group by `month` order by `month`)

select *, sum(month_laid_off) over(order by `month` ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
as `rolling_sum` from monthly_laid_off;

-- company wise laidoff with stage of fund_raise
select company,stage ,sum(total_laid_off) from layoffs group by company,stage order by company;

-- company avg percentage laidoff
 
select company , round(sum(total_laid_off)/(select sum(total_laid_off) from layoffs)*100,2)
 as total from layoffs group by company order by total desc;

-- rank of top 5 company in year who has laid of most
with ans as (with temp as (select company,year(`date`) as y ,sum(total_laid_off) as t
from layoffs group by company,y)

select *, row_number() over(partition by y order by y, t desc) as `rank` from temp)
select * from ans where `rank` < 6;






