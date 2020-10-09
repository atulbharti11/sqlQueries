-- simple query
SELECT PRODUCT.*
FROM PRODUCT;

-- SELECT WITH A COLUMN LIST
SELECT P_CODE, P_DESCRIPT, P_PRICE, P_QOH
FROM PRODUCT;

-- SELECT WITH COLUMN ALIASES
SELECT P_CODE, P_DESCRIPT AS DESCRIPTION, PRODUCT.P_PRICE AS 'Unit Price', PRODUCT.P_QOH AS QTY
FROM PRODUCT;

-- SELECT STATEMENT WITH A COMPUTED COLUMN AND AN ALIAS
SELECT P_DESCRIPT, P_QOH, P_PRICE, P_PRICE*P_Qoh AS TOTVALUE
FROM PRODUCT;

-- A LISTING OF DISTINCT V_CODE VALUES IN THE PRODUCT TABLE
SELECT DISTINCT V_CODE
FROM PRODUCT;

-- THE RESULTS OF A JOIN
SELECT P_DESCRIPT, P_PRICE, V_NAME, V_CONTACT, V_AREACODE, V_PHONE
FROM VENDOR INNER JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE;

-- CUSTOMER NATURAL JOIN INVOICE RESULTS
SELECT CUSTOMER.CUS_CODE, CUSTOMER.CUS_LNAME, INVOICE.INV_NUMBER, INVOICE.INV_DATE
FROM CUSTOMER  JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE;

--  JOIN WITH THREE TABLES
SELECT INVOICE.INV_NUMBER, LINE.P_CODE, PRODUCT.P_DESCRIPT, LINE.LINE_UNITS, LINE.LINE_PRICE
FROM PRODUCT INNER JOIN (INVOICE INNER JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER) ON PRODUCT.P_CODE = LINE.P_CODE;

-- JOIN USING RESULTS
SELECT PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, VENDOR.V_CODE, VENDOR.V_NAME, VENDOR.V_AREACODE, VENDOR.V_PHONE
FROM VENDOR INNER JOIN PRODUCT USING (V_CODE);

-- LEFT (OUTER) JOIN RESULTS
SELECT PRODUCT.P_CODE, VENDOR.V_CODE, VENDOR.V_NAME
FROM VENDOR LEFT JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE;

-- RIGHT JOIN RESULTS
SELECT PRODUCT.P_CODE, VENDOR.V_CODE, VENDOR.V_NAME
FROM VENDOR RIGHT JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE;

-- USING AN ALIAS TO JOIN A TABLE TO ITSELF
SELECT E.EMP_NUM, E.EMP_LNAME, E.EMP_MGR, M.EMP_LNAME
FROM EMP AS M INNER JOIN EMP AS E ON M.EMP_NUM = E.EMP_MGR;

-- PRODUCTS SORTED BY PRICE IN ASCENDING ORDER
SELECT PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_PRICE
FROM PRODUCT
ORDER BY PRODUCT.P_PRICE ;

-- cascading order sequence
SELECT EMPLOYEE.EMP_LNAME, EMPLOYEE.EMP_FNAME, EMPLOYEE.EMP_INITIAL, EMPLOYEE.EMP_AREACODE, EMPLOYEE.EMP_PHONE
FROM EMPLOYEE
ORDER BY EMPLOYEE.EMP_LNAME, EMPLOYEE.EMP_FNAME, EMPLOYEE.EMP_INITIAL;

-- ORDERING BY A DERIVED ATTRIBUTE
SELECT PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, PRODUCT.V_CODE, Round(P_PRICE*P_QOH,2) AS TOTAL
FROM PRODUCT
ORDER BY PRODUCT.V_CODE, Round((P_PRICE*P_QOH),2) DESC;

-- SELECTED PRODUCT ATTRIBUTES FOR VENDOR CODE 21344
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_PRICE, PRODUCT.V_CODE
FROM PRODUCT
WHERE (((PRODUCT.V_CODE)=21344));

-- Product Attributes for Vendor Codes Other than 21344
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_PRICE, PRODUCT.V_CODE
FROM PRODUCT
WHERE (((PRODUCT.V_CODE)<>21344));

-- Select Product Table Attributes with a P_Price Restriction
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_MIN, PRODUCT.P_PRICE
FROM PRODUCT
WHERE (((PRODUCT.P_PRICE)<=10));

-- Using Comparison Operators on Character Attributes
SELECT PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_MIN, PRODUCT.P_PRICE
FROM PRODUCT
WHERE (((PRODUCT.P_CODE)<'1558-QW1'));

-- SELECTED PRODUCT TABLE ATTRIBUTES: DATE RESTRICTION
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_MIN, PRODUCT.P_PRICE, PRODUCT.P_INDATE
FROM PRODUCT
WHERE (((PRODUCT.P_INDATE)>='2018-01-20-'));

-- THE LOGICAL OR
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_QOH, PRODUCT.P_PRICE, PRODUCT.V_CODE
FROM PRODUCT
WHERE (((PRODUCT.V_CODE)=21344)) OR (((PRODUCT.V_CODE)=24288));

-- THE LOGICAL AND
SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE
FROM PRODUCT
WHERE (((P_QOH)<20) AND ((P_PRICE)>100));

-- THE LOGICAL AND and OR
SELECT PRODUCT.P_DESCRIPT, PRODUCT.P_PRICE, PRODUCT.V_CODE
FROM PRODUCT
WHERE (((PRODUCT.P_PRICE)>100) AND ((PRODUCT.V_CODE)=25595)) OR (((PRODUCT.P_PRICE)>100) AND ((PRODUCT.V_CODE)=24288));

-- VENDOR CONTACTS THAT START WITH “SMITH”
SELECT VENDOR.V_NAME, VENDOR.V_CONTACT, VENDOR.V_AREACODE, VENDOR.V_PHONE
FROM VENDOR
WHERE (((VENDOR.V_CONTACT) Like "Smith%"));

-- PRODUCTS NOT ASSOCIATED WITH A VENDOR
SELECT PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, PRODUCT.V_CODE
FROM PRODUCT
WHERE (((PRODUCT.V_CODE) Is Null));

-- VENDORS NOT ASSOCIATED WITH ANY PRODUCT
SELECT VENDOR.V_CODE, VENDOR.V_NAME, PRODUCT.P_CODE
FROM VENDOR LEFT JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE
WHERE (((PRODUCT.P_CODE) Is Null));

-- TOTAL VALUE OF PRODUCTS FROM VENDOR IN TN OR KY
SELECT VENDOR.V_CODE, VENDOR.V_NAME, VENDOR.V_STATE, PRODUCT.P_CODE, PRODUCT.P_DESCRIPT, (P_PRICE*P_QOH) AS TOTAL
FROM VENDOR INNER JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE
WHERE (((VENDOR.V_STATE)="TN" Or (VENDOR.V_STATE)="KY"))
ORDER BY VENDOR.V_STATE, P_PRICE*P_QOH DESC;

-- COUNT OF DISTINCT VENDOR CODES
SELECT count(v_code) AS 'Count Distinct'
FROM (select distinct v_code from product)  AS sub1;

-- MAXIMUM AND MINIMUM PRICE OUTPUT
SELECT Max(PRODUCT.P_PRICE) AS MAXPRICE, Min(PRODUCT.P_PRICE) AS MINPRICE
FROM PRODUCT;

SELECT Sum(p_qoh*P_price) AS TOTVALUE
FROM PRODUCT;

SELECT Avg(PRODUCT.P_PRICE) AS AVGPRICE
FROM PRODUCT;

-- AVERAGE PRICE OF PRODUCTS FROM EACH VENDOR
SELECT PRODUCT.V_CODE, Avg(PRODUCT.P_PRICE) AS AVGPRICE
FROM PRODUCT
GROUP BY PRODUCT.V_CODE;

-- COUNT OF PRODUCTS AND AVERAGE PRICES FROM EACH VENDOR
SELECT PRODUCT.V_CODE, VENDOR.V_NAME, Count(PRODUCT.P_CODE) AS NUMPRODS, Avg(PRODUCT.P_PRICE) AS AVGPRICE
FROM VENDOR INNER JOIN PRODUCT ON VENDOR.V_CODE = PRODUCT.V_CODE
GROUP BY PRODUCT.V_CODE, VENDOR.V_NAME;

-- APPLICATION OF THE HAVING CLAUSE
SELECT PRODUCT.V_CODE, Count(PRODUCT.P_CODE) AS NUMPRODS
FROM PRODUCT
GROUP BY PRODUCT.V_CODE
HAVING (((Avg(PRODUCT.P_PRICE))<10))
ORDER BY PRODUCT.V_CODE;

-- Where Subqueries
SELECT PRODUCT.P_CODE, PRODUCT.P_PRICE
FROM PRODUCT
WHERE (((PRODUCT.P_PRICE)>(SELECT AVG(P_PRICE) FROM PRODUCT)));

create view product_view as select * from product;

                           
/**************************************************************************************************************/
                           
/* Introduction to SQL 					*/
/* Script file for MySQL DBMS			*/
/* This script file creates the following tables:	*/
/* VENDOR, PRODUCT, CUSTOMER, INVOICE, LINE		*/
/* EMPLOYEE, EMP					*/
/* and loads the default data rows			*/

BEGIN;

DROP TABLE IF EXISTS LINE ;
DROP TABLE IF EXISTS INVOICE;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS VENDOR;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS EMP;

CREATE TABLE VENDOR (
V_CODE 		INTEGER,
V_NAME 		VARCHAR(35) NOT NULL,
V_CONTACT 	VARCHAR(15) NOT NULL,
V_AREACODE 	CHAR(3) NOT NULL,
V_PHONE 	CHAR(8) NOT NULL,
V_STATE 	CHAR(2) NOT NULL,
V_ORDER 	CHAR(1) NOT NULL,
PRIMARY KEY (V_CODE));


CREATE TABLE PRODUCT (
P_CODE 	VARCHAR(10) PRIMARY KEY,
P_DESCRIPT 	VARCHAR(35) NOT NULL,
P_INDATE 	DATETIME NOT NULL,
P_QOH 	        INTEGER NOT NULL,
P_MIN 		INTEGER NOT NULL,
P_PRICE 	NUMERIC(8,2) NOT NULL,
P_DISCOUNT 	NUMERIC(4,2) NOT NULL,
V_CODE 		INTEGER,
CONSTRAINT PRODUCT_V_CODE_FK FOREIGN KEY (V_CODE) REFERENCES VENDOR (V_CODE));

CREATE TABLE CUSTOMER (
CUS_CODE	INTEGER PRIMARY KEY,
CUS_LNAME	VARCHAR(15) NOT NULL,
CUS_FNAME	VARCHAR(15) NOT NULL,
CUS_INITIAL	CHAR(1),
CUS_AREACODE 	CHAR(3),
CUS_PHONE	CHAR(8) NOT NULL,
CUS_BALANCE	NUMERIC(9,2) DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME, CUS_PHONE));


CREATE TABLE INVOICE (
INV_NUMBER     	INTEGER PRIMARY KEY,
CUS_CODE	INTEGER NOT NULL,
INV_DATE  	DATETIME NOT NULL,
CONSTRAINT INVOICE_CUS_CODE_FK FOREIGN KEY (CUS_CODE) REFERENCES CUSTOMER(CUS_CODE));


CREATE TABLE LINE (
INV_NUMBER 	INTEGER NOT NULL,
LINE_NUMBER	NUMERIC(2,0) NOT NULL,
P_CODE		VARCHAR(10) NOT NULL,
LINE_UNITS	NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
LINE_PRICE	NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
PRIMARY KEY (INV_NUMBER,LINE_NUMBER),
FOREIGN KEY (INV_NUMBER) REFERENCES INVOICE (INV_NUMBER) ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMBER, P_CODE));


CREATE TABLE EMPLOYEE (
EMP_NUM		INTEGER	PRIMARY KEY,
EMP_TITLE	CHAR(10),
EMP_LNAME	VARCHAR(15) NOT NULL,
EMP_FNAME	VARCHAR(15) NOT NULL,
EMP_INITIAL	CHAR(1),
EMP_DOB		DATETIME,
EMP_HIRE_DATE	DATETIME,
EMP_YEARS	INTEGER,
EMP_AREACODE 	CHAR(3),
EMP_PHONE	CHAR(8));


CREATE TABLE EMP (
EMP_NUM		INTEGER	PRIMARY KEY,
EMP_TITLE	CHAR(10),
EMP_LNAME	VARCHAR(15) NOT NULL,
EMP_FNAME	VARCHAR(15) NOT NULL,
EMP_INITIAL	CHAR(1),
EMP_DOB		DATETIME,
EMP_HIRE_DATE	DATETIME,
EMP_AREACODE 	CHAR(3),
EMP_PHONE	CHAR(8),
EMP_MGR		INTEGER);



/* Loading data rows					*/


/* VENDOR rows						*/
INSERT INTO VENDOR VALUES(21225,'Bryson, Inc.'    ,'Smithson','615','223-3234','TN','Y');
INSERT INTO VENDOR VALUES(21226,'SuperLoo, Inc.'  ,'Flushing','904','215-8995','FL','N');
INSERT INTO VENDOR VALUES(21231,'D&E Supply'      ,'Singh'   ,'615','228-3245','TN','Y');
INSERT INTO VENDOR VALUES(21344,'Gomez Bros.'     ,'Ortega'  ,'615','889-2546','KY','N');
INSERT INTO VENDOR VALUES(22567,'Dome Supply'     ,'Smith'   ,'901','678-1419','GA','N');
INSERT INTO VENDOR VALUES(23119,'Randsets Ltd.'   ,'Anderson','901','678-3998','GA','Y');
INSERT INTO VENDOR VALUES(24004,'Brackman Bros.'  ,'Browning','615','228-1410','TN','N');
INSERT INTO VENDOR VALUES(24288,'ORDVA, Inc.'     ,'Hakford' ,'615','898-1234','TN','Y');
INSERT INTO VENDOR VALUES(25443,'B&K, Inc.'       ,'Smith'   ,'904','227-0093','FL','N');
INSERT INTO VENDOR VALUES(25501,'Damal Supplies'  ,'Smythe'  ,'615','890-3529','TN','N');
INSERT INTO VENDOR VALUES(25595,'Rubicon Systems' ,'Orton'   ,'904','456-0092','FL','Y');

/* PRODUCT rows						*/
INSERT INTO PRODUCT VALUES('11QER/31','Power painter, 15 psi., 3-nozzle'     ,'2017-11-03',  8,  5,109.99,0.00,25595);
INSERT INTO PRODUCT VALUES('13-Q2/P2','7.25-in. pwr. saw blade'              ,'2017-12-13', 32, 15, 14.99,0.05,21344);
INSERT INTO PRODUCT VALUES('14-Q1/L3','9.00-in. pwr. saw blade'              ,'2017-11-13', 18, 12, 17.49,0.00,21344);
INSERT INTO PRODUCT VALUES('1546-QQ2','Hrd. cloth, 1/4-in., 2x50'            ,'2018-01-15', 15,  8, 39.95,0.00,23119);
INSERT INTO PRODUCT VALUES('1558-QW1','Hrd. cloth, 1/2-in., 3x50'            ,'2018-01-15', 23,  5, 43.99,0.00,23119);
INSERT INTO PRODUCT VALUES('2232/QTY','B&D jigsaw, 12-in. blade'             ,'2017-12-30',  8,  5,109.92,0.05,24288);
INSERT INTO PRODUCT VALUES('2232/QWE','B&D jigsaw, 8-in. blade'              ,'2017-12-24',  6,  5, 99.87,0.05,24288);
INSERT INTO PRODUCT VALUES('2238/QPD','B&D cordless drill, 1/2-in.'          ,'2018-01-20', 12,  5, 38.95,0.05,25595);
INSERT INTO PRODUCT VALUES('23109-HB','Claw hammer'                          ,'2018-01-20', 23, 10,  9.95,0.10,21225);
INSERT INTO PRODUCT VALUES('23114-AA','Sledge hammer, 12 lb.'                ,'2018-01-02',  8,  5, 14.40,0.05,NULL);
INSERT INTO PRODUCT VALUES('54778-2T','Rat-tail file, 1/8-in. fine'          ,'2017-12-15', 43, 20,  4.99,0.00,21344);
INSERT INTO PRODUCT VALUES('89-WRE-Q','Hicut chain saw, 16 in.'              ,'2018-02-07', 11,  5,256.99,0.05,24288);
INSERT INTO PRODUCT VALUES('PVC23DRT','PVC pipe, 3.5-in., 8-ft'              ,'2018-02-20',188, 75,  5.87,0.00,NULL);
INSERT INTO PRODUCT VALUES('SM-18277','1.25-in. metal screw, 25'             ,'2018-03-01',172, 75,  6.99,0.00,21225);
INSERT INTO PRODUCT VALUES('SW-23116','2.5-in. wd. screw, 50'                ,'2018-02-24',237,100,  8.45,0.00,21231);
INSERT INTO PRODUCT VALUES('WR3/TT3' ,'Steel matting, 4''x8''x1/6", .5" mesh','2018-01-17', 18,  5,119.95,0.10,25595);


/* CUSTOMER rows					*/
INSERT INTO CUSTOMER VALUES(10010,'Ramas'   ,'Alfred','A' ,'615','844-2573',0);
INSERT INTO CUSTOMER VALUES(10011,'Dunne'   ,'Leona' ,'K' ,'713','894-1238',0);
INSERT INTO CUSTOMER VALUES(10012,'Smith'   ,'Kathy' ,'W' ,'615','894-2285',345.86);
INSERT INTO CUSTOMER VALUES(10013,'Olowski' ,'Paul'  ,'F' ,'615','894-2180',536.75);
INSERT INTO CUSTOMER VALUES(10014,'Orlando' ,'Myron' ,NULL,'615','222-1672',0);
INSERT INTO CUSTOMER VALUES(10015,'O''Brian','Amy'   ,'B' ,'713','442-3381',0);
INSERT INTO CUSTOMER VALUES(10016,'Brown'   ,'James' ,'G' ,'615','297-1228',221.19);
INSERT INTO CUSTOMER VALUES(10017,'Williams','George',NULL,'615','290-2556',768.93);
INSERT INTO CUSTOMER VALUES(10018,'Farriss' ,'Anne'  ,'G' ,'713','382-7185',216.55);
INSERT INTO CUSTOMER VALUES(10019,'Smith'   ,'Olette','K' ,'615','297-3809',0);

/* INVOICE rows						*/
INSERT INTO INVOICE VALUES(1001,10014,'2018-01-16');
INSERT INTO INVOICE VALUES(1002,10011,'2018-01-16');
INSERT INTO INVOICE VALUES(1003,10012,'2018-01-16');
INSERT INTO INVOICE VALUES(1004,10011,'2018-01-17');
INSERT INTO INVOICE VALUES(1005,10018,'2018-01-17');
INSERT INTO INVOICE VALUES(1006,10014,'2018-01-17');
INSERT INTO INVOICE VALUES(1007,10015,'2018-01-17');
INSERT INTO INVOICE VALUES(1008,10011,'2018-01-17');

/* LINE rows						*/
INSERT INTO LINE VALUES(1001,1,'13-Q2/P2',1,14.99);
INSERT INTO LINE VALUES(1001,2,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1002,1,'54778-2T',2,4.99);
INSERT INTO LINE VALUES(1003,1,'2238/QPD',1,38.95);
INSERT INTO LINE VALUES(1003,2,'1546-QQ2',1,39.95);
INSERT INTO LINE VALUES(1003,3,'13-Q2/P2',5,14.99);
INSERT INTO LINE VALUES(1004,1,'54778-2T',3,4.99);
INSERT INTO LINE VALUES(1004,2,'23109-HB',2,9.95);
INSERT INTO LINE VALUES(1005,1,'PVC23DRT',12,5.87);
INSERT INTO LINE VALUES(1006,1,'SM-18277',3,6.99);
INSERT INTO LINE VALUES(1006,2,'2232/QTY',1,109.92);
INSERT INTO LINE VALUES(1006,3,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1006,4,'89-WRE-Q',1,256.99);
INSERT INTO LINE VALUES(1007,1,'13-Q2/P2',2,14.99);
INSERT INTO LINE VALUES(1007,2,'54778-2T',1,4.99);
INSERT INTO LINE VALUES(1008,1,'PVC23DRT',5,5.87);
INSERT INTO LINE VALUES(1008,2,'WR3/TT3',3,119.95);
INSERT INTO LINE VALUES(1008,3,'23109-HB',1,9.95);

/* EMP rows						*/
INSERT INTO EMP VALUES(100,'Mr.' ,'Kolmycz'   ,'George' ,'D' ,'1942-06-15','1985-03-15','615','324-5456',NULL);
INSERT INTO EMP VALUES(101,'Ms.' ,'Lewis'     ,'Rhonda' ,'G' ,'1965-03-19','1986-04-25','615','324-4472',100);
INSERT INTO EMP VALUES(102,'Mr.' ,'Vandam'    ,'Rhett'  ,NULL,'1958-11-14','1990-12-20','901','675-8993',100);
INSERT INTO EMP VALUES(103,'Ms.' ,'Jones'     ,'Anne'   ,'M' ,'1974-10-16','1994-08-28','615','898-3456',100);
INSERT INTO EMP VALUES(104,'Mr.' ,'Lange'     ,'John'   ,'P' ,'1971-11-08','1994-10-20','901','504-4430',105);
INSERT INTO EMP VALUES(105,'Mr.' ,'Williams'  ,'Robert' ,'D' ,'1975-03-14','1998-11-08','615','890-3220',NULL);
INSERT INTO EMP VALUES(106,'Mrs.','Smith'     ,'Jeanine','K' ,'1968-02-12','1989-01-05','615','324-7883',105);
INSERT INTO EMP VALUES(107,'Mr.' ,'Diante'    ,'Jorge'  ,'D' ,'1974-08-21','1994-07-02','615','890-4567',105);
INSERT INTO EMP VALUES(108,'Mr.' ,'Wiesenbach','Paul'   ,'R' ,'1966-02-14','1992-11-18','615','897-4358',NULL);
INSERT INTO EMP VALUES(109,'Mr.' ,'Smith'     ,'George' ,'K' ,'1961-06-18','1989-04-14','901','504-3339',108);
INSERT INTO EMP VALUES(110,'Mrs.','Genkazi'   ,'Leighla','W' ,'1970-05-19','1990-12-01','901','569-0093',108);
INSERT INTO EMP VALUES(111,'Mr.' ,'Washington','Rupert' ,'E' ,'1966-01-03','1993-06-21','615','890-4925',105);
INSERT INTO EMP VALUES(112,'Mr.' ,'Johnson'   ,'Edward' ,'E' ,'1961-05-14','1983-12-01','615','898-4387',100);
INSERT INTO EMP VALUES(113,'Ms.' ,'Smythe'    ,'Melanie','P' ,'1970-09-15','1999-05-11','615','324-9006',105);
INSERT INTO EMP VALUES(114,'Ms.' ,'Brandon'   ,'Marie'  ,'G' ,'1956-11-02','1979-11-15','901','882-0845',108);
INSERT INTO EMP VALUES(115,'Mrs.','Saranda'   ,'Hermine','R' ,'1972-07-25','1993-04-23','615','324-5505',105);
INSERT INTO EMP VALUES(116,'Mr.' ,'Smith'     ,'George' ,'A' ,'1965-11-08','1988-12-10','615','890-2984',108);

/* EMPLOYEE rows					*/
INSERT INTO EMPLOYEE VALUES(100,'Mr.' ,'Kolmycz'   ,'George' ,'D' ,'1942-06-15','1985-03-15',18,'615','324-5456');
INSERT INTO EMPLOYEE VALUES(101,'Ms.' ,'Lewis'     ,'Rhonda' ,'G' ,'1965-03-19','1986-04-25',16,'615','324-4472');
INSERT INTO EMPLOYEE VALUES(102,'Mr.' ,'Vandam'    ,'Rhett'  ,NULL,'1958-11-14','1990-12-20',12,'901','675-8993');
INSERT INTO EMPLOYEE VALUES(103,'Ms.' ,'Jones'     ,'Anne'   ,'M' ,'1974-10-16','1994-08-28', 8,'615','898-3456');
INSERT INTO EMPLOYEE VALUES(104,'Mr.' ,'Lange'     ,'John'   ,'P' ,'1971-11-08','1994-10-20', 8,'901','504-4430');
INSERT INTO EMPLOYEE VALUES(105,'Mr.' ,'Williams'  ,'Robert' ,'D' ,'1975-03-14','1998-11-08', 4,'615','890-3220');
INSERT INTO EMPLOYEE VALUES(106,'Mrs.','Smith'     ,'Jeanine','K' ,'1968-02-12','1989-01-05',14,'615','324-7883');
INSERT INTO EMPLOYEE VALUES(107,'Mr.' ,'Diante'    ,'Jorge'  ,'D' ,'1974-08-21','1994-07-02', 8,'615','890-4567');
INSERT INTO EMPLOYEE VALUES(108,'Mr.' ,'Wiesenbach','Paul'   ,'R' ,'1966-02-14','1992-11-18',10,'615','897-4358');
INSERT INTO EMPLOYEE VALUES(109,'Mr.' ,'Smith'     ,'George' ,'K' ,'1961-06-18','1989-04-14',13,'901','504-3339');
INSERT INTO EMPLOYEE VALUES(110,'Mrs.','Genkazi'   ,'Leighla','W' ,'1970-05-19','1990-12-01',12,'901','569-0093');
INSERT INTO EMPLOYEE VALUES(111,'Mr.' ,'Washington','Rupert' ,'E' ,'1966-01-03','1993-06-21', 9,'615','890-4925');
INSERT INTO EMPLOYEE VALUES(112,'Mr.' ,'Johnson'   ,'Edward' ,'E' ,'1961-05-14','1983-12-01',19,'615','898-4387');
INSERT INTO EMPLOYEE VALUES(113,'Ms.' ,'Smythe'    ,'Melanie','P' ,'1970-09-15','1999-05-11', 3,'615','324-9006');
INSERT INTO EMPLOYEE VALUES(114,'Ms.' ,'Brandon'   ,'Marie'  ,'G' ,'1956-11-02','1979-11-15',23,'901','882-0845');
INSERT INTO EMPLOYEE VALUES(115,'Mrs.','Saranda'   ,'Hermine','R' ,'1972-07-25','1993-04-23', 9,'615','324-5505');
INSERT INTO EMPLOYEE VALUES(116,'Mr.' ,'Smith'     ,'George' ,'A' ,'1965-11-08','1988-12-10',14,'615','890-2984');

COMMIT;
