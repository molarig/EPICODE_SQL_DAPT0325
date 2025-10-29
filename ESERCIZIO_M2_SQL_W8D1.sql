#È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda. Uno store è collocato in una precisa area geografica.
#In unʼarea geografica possono essere collocati store diversi. Cosa devi fare:
#1) Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.)
#2) Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …)
#3) Popola le tabelle con pochi record esemplificativi
#4) Esegui operazioni di aggiornamento, modifica ed eliminazione record

CREATE DATABASE azienda;
USE azienda;

SELECT * FROM region;
SELECT * FROM store;

CREATE TABLE region (
	id_region INT AUTO_INCREMENT PRIMARY KEY,
	citta VARCHAR (50),
	provincia VARCHAR (50),
	regione VARCHAR (50)
);

CREATE TABLE store (
	id_store INT AUTO_INCREMENT PRIMARY KEY,
    id_region INT,
    nome_store VARCHAR (50),
    data_apertura DATE NOT NULL,
    FOREIGN KEY (id_region) REFERENCES region(id_region)
);

INSERT INTO region (citta, provincia, regione)
	VALUES
    ('Rimini', 'Rimini', 'Emilia Romagna'),
    ('Cesena', 'Forli Cesena','Emilia Romagna'),
    ('Bergamo','Bergamo','Lombardia'),
    ('Firenze','Firenze','Toscana');
    
INSERT INTO store (id_region, nome_store, data_apertura)
	VALUES
    ('1', 'Svelto A&O', '2021-04-08'),
    ('2', 'Famila Romagnoli','1980-02-12'),
    ('3','Bennet','2008-11-18'),
    ('4','Gala','1999-06-05');
    
#Modifica tabella
ALTER TABLE region
ADD stato VARCHAR(50);
    
UPDATE region
SET stato='Italia';
    
INSERT INTO region (citta, provincia, regione, stato)
	VALUES
	('Lugano','Lugano','Canton Ticino','Svizzera');
        
INSERT INTO store (id_region, nome_store, data_apertura)
	VALUES
	('5','COOP','2012-10-10');
    
START TRANSACTION;
UPDATE store
SET nome_store="Migros"
WHERE id_store=5;
SELECT * FROM store;
#ROLLBACK;
COMMIT;

START TRANSACTION;
DELETE FROM store
WHERE id_store=5;
SELECT * FROM store;
#ROLLBACK;
COMMIT;

START TRANSACTION;
DELETE FROM region
WHERE id_region=5;
SELECT * FROM region;
#ROLLBACK;
COMMIT;
        

    
    