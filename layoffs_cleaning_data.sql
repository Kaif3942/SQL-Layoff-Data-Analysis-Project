SELECT * FROM dataanalytics.layoffs;

insert  into layoffs
    select * from  (select *,
         row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off,
         `date` ,country) as row_num
         from layoffs_data) as layoff;
         
select * from layoffs;
-- duplicates delete
delete from layoffs where row_num > 1;

-- trim data of company
select distinct company, trim(company) from layoffs; 

-- update table with trimmed data
update layoffs set company= trim(company);


-- update date
select date, str_to_date(date,'%m/%d/%Y') from layoffs;

update layoffs set date = str_to_date(date,'%m/%d/%Y');


-- update null values with others
select * from layoffs as lf1
	join layoffs as lf2
    on lf1.company = lf2.company 
	where lf1.industry is null or lf1.industry=''
    and lf2.industry is not null and lf2.industry != '';
	
update layoffs as lf1
	join layoffs as lf2
    on lf1.company = lf2.company 
set lf1.industry = lf2.industry
	where lf1.industry is null or lf1.industry=''
    and lf2.industry is not null and lf2.industry != '';
    
--  drop rows where values are null
select * from layoffs where company = 'Bally\'s Interactive';
delete from layoffs where company = 'Bally\'s Interactive';
         

-- drop rows where total_laid_off and percentage_laid_off is null
select * from layoffs where total_laid_off is null and  percentage_laid_off is null;
delete from layoffs where  total_laid_off is null and  percentage_laid_off is null;

-- sort company_name
select * from layoffs order by company;






