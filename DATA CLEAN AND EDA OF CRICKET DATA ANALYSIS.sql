CREATE WAREHOUSE AG_CRICKET_DATA_CLEANING
WITH WAREHOUSE_SIZE = 'SMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE; 
  
CREATE DATABASE AG_CRICKET_DATA;
USE AG_CRICKET_DATA;

------------------------------------BATSMAN DATA---------------------------------------
CREATE OR REPLACE TABLE AG_BATSMAN(
Batsman_Bat1 VARCHAR(60),          
Batsman_Runs  VARCHAR(30),       
Batsman_BF  VARCHAR(30),               
Batsman_SR  VARCHAR(30),              
Batsman_foures VARCHAR(30),        
Batsman_sixes VARCHAR(30),         
Batsman_Opposition VARCHAR(50),        
Batsman_Ground  VARCHAR(60),           
Batsman_Start_Date VARCHAR(50),
Batsman_Match_ID VARCHAR(10),        
Batsman_name VARCHAR(50),       
Batsman_Player_ID INTEGER );
   
SELECT * FROM AG_BATSMAN;


------------------------------------------------BOWLER TABLE--------------------------------------------------------------------   
CREATE OR REPLACE TABLE AG_BOWLER(
Bowler_Overs  VARCHAR(10),             
Bowler_Mdns   VARCHAR(10),
Bowler_Runs   VARCHAR(10),            
Bowler_Wkts   VARCHAR(10),             
Bowler_Econ   VARCHAR(10),         
Bowler_Ave    VARCHAR(10),          
Bowler_SR     VARCHAR(10),            
Bowler_Opposition VARCHAR(60),        
Bowler_Ground  VARCHAR(50),            
Bowler_Start_Date VARCHAR(50), 
Bowler_Match_ID   VARCHAR(10),         
Bowler_Bowler     VARCHAR(50),        
Bowler_Player_ID INTEGER);
 
 
SELECT * FROM AG_BOWLER;

----------------------------------------------MATCH_RESULT TABLE---------------------------------------------------------------- 
CREATE OR REPLACE TABLE AG_MATCH_RESULT(
Match_Result VARCHAR(20),        
Match_Margin VARCHAR(20),        
Match_Toss VARCHAR(20),       
Match_Bat VARCHAR(20),       
Match_Opposition VARCHAR(50),        
Match_Ground VARCHAR(50),       
Match_Start_Date VARCHAR(20),
Match_Result_ID VARCHAR(20),        
Match_Country VARCHAR(30),       
Match_Country_ID INTEGER); 
 

 SELECT * FROM AG_MATCH_RESULT; 
 
 
 


-----------EDA----------------------------------

DESCRIBE TABLE AG_BATSMAN;
DESCRIBE TABLE AG_BOWLER;
DESCRIBE TABLE AG_MATCH_RESULT;

------NOW REPLACING '-' WITH '0'-------------

UPDATE AG_BATSMAN SET Batsman_Runs = REPLACE(REPLACE(Batsman_Runs,'-','0'),';','0')

UPDATE AG_BATSMAN SET Batsman_BF = REPLACE(REPLACE(Batsman_BF,'-','0'),';','0')

UPDATE AG_BATSMAN SET Batsman_SR = REPLACE(REPLACE(Batsman_SR,'-','0'),';','0')

UPDATE AG_BATSMAN SET Batsman_foures = REPLACE(REPLACE(Batsman_foures,'-','0'),';','0')

UPDATE AG_BATSMAN SET Batsman_sixes = REPLACE(REPLACE(Batsman_sixes,'-','0'),';','0')


UPDATE AG_BOWLER SET Bowler_Overs = REPLACE(REPLACE(Bowler_Overs,'-','0'),';','0')

UPDATE AG_BOWLER SET Bowler_Mdns = REPLACE(REPLACE(Bowler_Mdns,'-','0'),';','0')

UPDATE AG_BOWLER SET Bowler_Runs = REPLACE(REPLACE(Bowler_Runs,'-','0'),';','0')


UPDATE AG_BOWLER SET Bowler_Wkts = REPLACE(REPLACE(Bowler_Wkts,'-','0'),';','0')

UPDATE AG_BOWLER SET Bowler_Econ = REPLACE(REPLACE(Bowler_Econ,'-','0'),';','0')

UPDATE AG_BOWLER SET Bowler_Ave = REPLACE(REPLACE(Bowler_Ave,'-','0'),';','0')

UPDATE AG_BOWLER SET Bowler_SR = REPLACE(REPLACE(Bowler_SR,'-','0'),';','0')


UPDATE AG_MATCH_RESULT SET Match_Result = REPLACE(REPLACE(Match_Result,'-','0'),';','0')

UPDATE AG_MATCH_RESULT SET Match_Margin = REPLACE(REPLACE(Match_Margin,'-','0'),';','0')

UPDATE AG_MATCH_RESULT SET Match_Toss = REPLACE(REPLACE(Match_Toss,'-','0'),';','0')

UPDATE AG_MATCH_RESULT SET Match_Bat = REPLACE(REPLACE(Match_Bat,'-','0'),';','0')



SELECT COUNT(*) FROM AG_MATCH_RESULT WHERE MATCH_RESULT IS NULL ;


----------------SPLITING THE STRING-------------------------------------------------------------

UPDATE AG_BATSMAN SET Batsman_Opposition = SUBSTR(Batsman_Opposition,3,LENGTH(Batsman_Opposition));

UPDATE AG_BATSMAN SET Batsman_Match_ID = SUBSTR(Batsman_Match_ID,7,LENGTH(Batsman_Match_ID));

UPDATE  AG_BOWLER SET Bowler_Opposition = SUBSTR(Bowler_Opposition,3,LENGTH(Bowler_Opposition));

UPDATE  AG_BOWLER SET Bowler_Match_ID = SUBSTR(Bowler_Match_ID,7,LENGTH(Bowler_Match_ID));

UPDATE AG_MATCH_RESULT SET Match_Opposition = SUBSTR(Match_Opposition,3,LENGTH(Match_Opposition));

UPDATE AG_MATCH_RESULT SET Match_Result_ID = SUBSTR(Match_Result_ID,7,LENGTH(Match_Result_ID));

UPDATE AG_MATCH_RESULT SET Match_Result_ID = REPLACE(REPLACE(Match_Result_ID,'a',''),';','')


-----------------CONVERT INTO DATETIME-----------------------------------------------------------------

UPDATE AG_BATSMAN SET Batsman_Start_Date = TO_CHAR(TO_DATE(Batsman_Start_Date),'DD-MM-YY');

UPDATE AG_BOWLER SET Bowler_Start_Date = TO_CHAR(TO_DATE(Bowler_Start_Date),'DD-MM-YY');

UPDATE AG_MATCH_RESULT SET Match_Start_Date = TO_CHAR(TO_DATE(Match_Start_Date),'DD-MM-YY');


-----------------CREATING AN ADDTIONAL_MATCH_RESULT_TABLE--------------

CREATE OR REPLACE TABLE AG_MATCH_RESULT_UPDATED AS
 SELECT * FROM AG_MATCH_RESULT; 


SELECT * FROM AG_MATCH_RESULT_UPDATED;

---------------------REPLACING VALUES FOR MATCH RESULT----------------
UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'won',2),';',2)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'lost',1),';',1)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'n/r',3),';',3)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'aban',4),';',4)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'tied',5),';',5)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'canc',6),';',6)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_RESULT = REPLACE(REPLACE(MATCH_RESULT,'0',7),';',7)



---------------------REPLACING VALUES FOR TOSS----------------

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_TOSS = REPLACE(REPLACE(MATCH_TOSS,'lost',1),';',1)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_TOSS = REPLACE(REPLACE(MATCH_TOSS,'won',2),';',2)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_TOSS = REPLACE(REPLACE(MATCH_TOSS,'0',3),';',3)


---------------------REPLACING VALUES FOR BAT----------------

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_BAT = REPLACE(REPLACE(MATCH_BAT,'1st',1),';',1)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_BAT = REPLACE(REPLACE(MATCH_BAT,'2nd',2),';',2)

UPDATE AG_MATCH_RESULT_UPDATED SET MATCH_BAT = REPLACE(REPLACE(MATCH_BAT,'0',3),';',3)


SELECT * FROM AG_MATCH_RESULT_UPDATED;







----------------OPTIONAL,DOES NOT GIVE DESIRED RESULT---------------------------------------------------------------------------------

 --------------------------------------------------JOINING THE TABLE INTO A MASTER TABLE---------------------------------------------
 

CREATE OR REPLACE TABLE MASTER_CRICKET_TABLE AS
SELECT A.*,B.*,C.* FROM AG_BATSMAN A
LEFT OUTER JOIN AG_BOWLER B ON A.Batsman_Match_ID = B.Bowler_Match_ID
LEFT OUTER JOIN AG_MATCH_RESULT C ON A.Batsman_Match_ID = C.Match_Result_ID;

SELECT * FROM MASTER_CRICKET_TABLE;

