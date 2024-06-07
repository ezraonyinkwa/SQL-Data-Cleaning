

--Before beginning the data cleaning process,we are going to create a duplicate table,
--Incase of a mistake we can have our other table
SELECT *
INTO Zara
FROM zara_raw

SELECT *
from Zara


--DATA CLEANING
--1.Removing Unwanted columns
--2.Renaming Columns
--3.Standardizing/Formatting data
--4.Removing Nulls 
--5.Removing Duplicates

--1.Removing unwated columns
--Not every column in a dataset is of importance in every analysis,some columns you wont use in your analysis
--the best way to deal with this is to delete the column to reduce the size of the data
 
 --We are going to delete the following columns
 --1.brand(Since all products in this data set are from Zara theirs no need to 
 --have the column we already know which brand we are dealing with)
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


 SELECT *
 FROM Zara


 --2.) Renaming Columns
 USE [Data cleaning]
 EXEC SP_RENAME 'Zara.name','Product_Name'

 EXEC sp_rename 'Zara.terms','Product_Type'

 EXEC sp_rename 'Zara.section','Gender'

 EXEC SP_RENAME 'Zara.Sales_Volume','Units_Sold'

 EXEC SP_RENAME 'Zara.price','Price'

 EXEC SP_RENAME 'Zara.currency','Currency'

 SELECT *
 FROM Zara

 --3.) Standardizing data

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

		SELECT UPPER(SUBSTRING(Product_Name,1,1))+
	   LOWER(SUBSTRING(Product_Name,2,len(Product_Name)-1))
	   from Zara
	   
 UPDATE Zara
 SET Product_Name = UPPER(SUBSTRING(Product_Name,1,1))+
	   LOWER(SUBSTRING(Product_Name,2,len(Product_Name)-1))


 --4.)Checking for nulls	  
	  SELECT *
	   from Zara
	   WHERE Product_Name IS NULL 

DELETE FROM Zara
WHERE Product_ID =173576



--5.Checking for duplicates
	   SELECT *,
	   ROW_NUMBER () 
	   over(PARTITION BY Product_ID ORDER BY Product_ID)
	   FROM Zara -- No duplicates were found

	--We are done lets delete the columns left that we ar not going to use
	ALTER TABLE Zara
	DROP COLUMN Promotion,Seasonal

	  SELECT *
	  FROM Zara
