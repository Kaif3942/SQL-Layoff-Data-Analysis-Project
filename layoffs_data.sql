SELECT * FROM dataanalytics.layoffs_data;
 ### duplicates rows
 with dup_data as
     (select *,
        row_number() over(partition by company,location, industry,total_laid_off,percentage_laid_off,
       `date`,country)
       as row_num
     from layoffs_data)
     
select * from dup_data where row_num>1;

create table layoffs like layoffs_data;