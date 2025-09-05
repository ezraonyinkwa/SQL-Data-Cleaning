# SQL-Data-Cleaning

Table of Contents

- [Project Overview](#project-overview)
  
- [ Removing Unwanted Columns](#1-removing-unwanted-columns)
  
- [Renaming Columns](#2-renaming-columns)
  
- [Standardizing data](#3-standardizing-data)
  
- [Removing Nulls](#4-removing-nulls)
  
- [Checking for duplicates](#5-checking-for-duplicates)
  
- [Reference](#reference)





## Project Overview
This README file provides a detailed overview of the data cleaning process using SQL. Data cleaning is a crucial step in data preparation, ensuring that the dataset is accurate, consistent, and ready for analysis. 

The following highlight the data cleaning steps I used to ensure a clean dataset;
- Removing Unwanted columns
- Renaming Columns
- Standardizing/Formatting data
- Removing Nulls 
- Removing Duplicates


## 1. Removing Unwanted Columns
Deleting unwanted columns is a critical step in the data cleaning process. This practice holds several key benefits that contribute to the overall quality and efficiency of data analysis.

``` sql
--Not every column in a dataset is of importance in every analysis,some columns you wont use in your analysis
--the best way to deal with this is to remove the column to reduce the size of the data
 
 --We are going to remove the following columns

 --1.brand(Since all products in this data set are from Zara theirs no need to have the column we already know which brand we are dealing with)

 --2.URL we are not going to use this anywhere in our analysis

 --3.SKU

 --4.Scrapped at

 --5.Description

--Deleting the brand column
 ALTER TABLE Zara
 DROP COLUMN brand 
 --Deleting the URL
 ALTER TABLE Zara
 DROP COLUMN url
 --Deleting the sku column
 ALTER TABLE Zara
 DROP COLUMN sku
 --Deleting the scrapped at column
 ALTER TABLE Zara
 DROP COLUMN scraped_at
 --Deleting the description column
 ALTER TABLE Zara
 DROP COLUMN description
```
## 2. Renaming Columns
Renaming columns is a crucial step in the data cleaning process that contributes to the clarity, consistency and usability of a dataset. 

``` sql
USE [Data cleaning] --Select the name of database
 EXEC SP_RENAME 'Zara.name','Product_Name'

 EXEC sp_rename 'Zara.terms','Product_Type'

 EXEC sp_rename 'Zara.section','Gender'

 EXEC SP_RENAME 'Zara.Sales_Volume','Units_Sold'

 EXEC SP_RENAME 'Zara.price','Price'

 EXEC SP_RENAME 'Zara.currency','Currency' --name of tabele.name of column to the name you want to name the column
```
## 3. Standardizing Data

Standardizing data is a vital step in the data cleaning process that ensures consistency, accuracy and usability of the dataset.

```sql
SELECT Promotion,
 CASE
 WHEN Promotion=1 THEN 'Yes'
 WHEN Promotion=0 THEN 'No'
 END 
 from Zara --Testing the Query

 ALTER TABLE Zara
 ADD Promoted VARCHAR(50) --Creating a new Column

 update Zara
 Set Promoted = CASE
 WHEN Promotion=1 THEN 'Yes'
 WHEN Promotion=0 THEN 'No'
 END --Adding data into the new column we created

--Changing the format from "1" and "0" to "Yes"/"No" which is easier to understand
 SELECT Seasonal,
 CASE
 WHEN Seasonal=1 THEN 'Yes'
 WHEN Seasonal=0 THEN 'No'
 END
 FROM Zara

 ALTER TABLE Zara
 ADD Seasonal_Sales varchar(50)
 
	 UPDATE zara
	 SET Seasonal_Sales = CASE
	 WHEN Seasonal=1 THEN 'Yes'
	 WHEN Seasonal=0 THEN  'No'
	 END

 
--Changing the gender's first letter to capital letter and the rest small letters	                                                                                                   
			SELECT UPPER(SUBSTRING(Gender,1,1))+
			LOWER(SUBSTRING(Gender,2, len(Gender)-1)) as gender
			from Zara

			UPDATE Zara
			SET Gender =UPPER(SUBSTRING(Gender,1,1))+
			LOWER(SUBSTRING(Gender,2, len(Gender)-1))

SELECT UPPER(SUBSTRING(Product_Type,1,1))+
	   LOWER(SUBSTRING(Product_Type,2,len(Product_Type)-1)) as product
	   from Zara

	   UPDATE Zara
	   SET Product_Type =UPPER(SUBSTRING(Product_Type,1,1))+
	   LOWER(SUBSTRING(Product_Type,2,len(Product_Type)-1))

--Rounded off the price to two decimal place   
	   SELECT ROUND(Price,2)
	   FROM Zara

	   UPDATE Zara
	   SET Price = ROUND(Price,2)

--Changing the first letter of product name to capital letter and the rest into small letter

		SELECT UPPER(SUBSTRING(Product_Name,1,1))+
	   LOWER(SUBSTRING(Product_Name,2,len(Product_Name)-1))
	   from Zara
```
## 4. Removing Nulls
Removing nulls (missing values)  in the data cleaning process is significantly important since it  impacts the quality, accuracy and reliability of data analysis.
```sql
	  SELECT *
	   from Zara
	   WHERE Product_Name IS NULL  

DELETE FROM Zara
WHERE Product_ID =173576
```

## 5. Checking for Duplicates
Removing duplicates  helps maintain the integrity, accuracy and reliability of a dataset.
```sql
--we are going to partition and order by the unique ID in order to chec if there are duplicates
SELECT *,
	   ROW_NUMBER () 
	   over(PARTITION BY Product_ID ORDER BY Product_ID) 
	   FROM Zara -- No duplicates were found

	--We are done lets delete the columns left that we are not going to use
	ALTER TABLE Zara
	DROP COLUMN Promotion,Seasonal
```
## Reference
- [W3School](https://www.w3schools.com/sql/)
  
- [Stack overflow](https://stackoverflow.com/questions/15290754/sql-capitalize-first-letter-only)

