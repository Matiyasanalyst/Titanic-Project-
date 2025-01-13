	CREATE DATABASE SQL_TITANIC
	GO

	/* IMPORTING THE CSV FILE FROM THE CSV FILE COMPUTER*/
	

	BULK INSERT TITANIC
FROM 'C:\\TITANICDATASETDOC\\TITANIC.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specifies column delimiter (comma for CSV)
    ROWTERMINATOR = '\n',   -- Specifies row delimiter (newline)
    FIRSTROW = 2            -- Skips header row in the file
);

	
	SELECT COUNT(*)AS NUMBER_OF_TRAVELERS 
	FROM TITANIC 
	
	/*QIESTION 1 * BASED ON SEX LOOKING 
	 AT THE SURVIVAL OF FEMAILE AND MALE IN PERCENTAGE */

 SELECT SEX,
	     SUM(CASE WHEN survived = 1 THEN 1 ELSE 0 END) AS survived_count,
    SUM(CASE WHEN survived = 0 THEN 1 ELSE 0 END) AS Not_survived_count,
	 ROUND(AVG(Survived) * 100, 2) AS Survival_Rate_Percentage
	FROM TITANIC
	----WHERE SEX = 'FEMALE' 
	 GROUP BY SEX


	/*QUESTION2*/ /*"What is the total number of passengers, the number of survivors, 
	 and the survival rate (as a percentage) 
	 for each embarkation point on the Titanic?*/

	SELECT 
   Embarked,
    COUNT(*) AS Total_Passengers,
    SUM(Survived) AS Survivors,
    ROUND(AVG(Survived) * 100, 2) AS Survival_Rate_Percentage
FROM 
TITANIC
	WHERE EMBARKED IS NOT NULL
GROUP BY 
   Embarked
ORDER BY 
    Embarked;

	SELECT *
	FROM TITANIC

	/*QUESTION WHAT IS THE SERVIVAL RATE AND HOW MANY
	PEOPLE ACUTALLY SURVIVED FROM THE CLASSES  */


	SELECT 
    Pclass AS Passenger_Class,
    COUNT(*) AS Total_Passengers,
    SUM(Survived) AS Survivors,
    ROUND(AVG(Survived) * 100, 2) AS Survival_Rate_Percentage
FROM 
    Titanic
GROUP BY 
    Pclass
		ORDER BY PCLASS ASC

	
	SELECT*
	FROM TITANIC


	/* LOOKING AT THE DATA BASED ON FARE AND ALSO COUNTING THEIR SERVIVAL RATES BASED UP ON FARE*/
	SELECT 
    CASE 
        WHEN Fare BETWEEN 0 AND 50 THEN '0-50'
        WHEN Fare BETWEEN 51 AND 100 THEN '51-100'
        WHEN Fare BETWEEN 101 AND 150 THEN '101-150'
        ELSE '150+'
    END AS Fare_Range,
    SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS Survived_Count,
    SUM(CASE WHEN Survived = 0 THEN 1 ELSE 0 END) AS Not_Survived_Count
FROM 
    Titanic
GROUP BY 
    CASE 
        WHEN Fare BETWEEN 0 AND 50 THEN '0-50'
        WHEN Fare BETWEEN 51 AND 100 THEN '51-100'
        WHEN Fare BETWEEN 101 AND 150 THEN '101-150'
        ELSE '150+'
    END
	ORDER BY FARE_RANGE

/*	WHO PAID THE HIGHEST FARE AND WHAT CALSS IS THIS PERSON ON DID THEY SURVIVE USING */

SELECT Name, Pclass, Fare,survived
FROM Titanic
WHERE Fare = (SELECT MAX(Fare) FROM Titanic); 


SELECT Name, Pclass, Fare,survived
FROM Titanic
WHERE Fare = (SELECT MIN(FARE) FROM TITANIC)
 
