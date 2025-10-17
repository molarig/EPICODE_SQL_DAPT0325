#mostro tutti i database
SHOW DATABASES;

#creo DB denominato "crm"
CREATE DATABASE crm;

#comunico a SQL di usare "crm" come database
USE crm;

#mostra le tabelle del DB
SHOW TABLES;

#creo la tabella "sito"
CREATE TABLE sito (
	id_sito INT AUTO_INCREMENT,
    dominio VARCHAR(50),
    rag_sociale VARCHAR(50),
    p_iva CHAR(11),
    indirizzo VARCHAR(250),
    CONSTRAINT PK_sito PRIMARY KEY (id_sito)
);

#aggiungo constraint per creare la relazione tra la tabella "sito" e "progetto"
ALTER TABLE sito
ADD CONSTRAINT FK_progetto_sito FOREIGN KEY (id_sito)
REFERENCES progetto (id_sito);

#inserisco record nella tabella "sito"
INSERT INTO	sito (dominio, rag_sociale, p_iva, indirizzo)
VALUES 	('rockplaza.it','Valentini SRL',16794852379,'Via Gulliver 12, Amalfi, 48765'),
		('villadellepalme.it','Valentini SRL',16794852379,'Via Eulero 125, Amalfi, 48765'),
        ('hotelcristallo.com','Ulderici SRL',76984521789,'Piazza Tonale 56, Auronzo di Cadore, 23544'),
        ('hotelfrance.it','Seaside Gestioni SNC',97568745123,'Lungomare Belli 68, Rimini, 47822'),
        ('lucesulmarehotel.it','Luce SRL',47821469852,'Strada della Saggia 2, Cagliari, 35988');
        
#descrivo i campi di "sito"
DESCRIBE sito;

#visualizzo i contenuti di "sito"
SELECT * FROM sito;

#creo la tabella "progetto"
CREATE TABLE progetto (
	id_progetto INT AUTO_INCREMENT,
    id_sito INT,
    id_prodotto INT,
    data_avvio DATE,
    data_termine DATE,
    CONSTRAINT PK_progetto PRIMARY KEY (id_progetto)
);

#aggiungo constraint per creare la relazione tra la tabella "progetto" e "prodotto"
ALTER TABLE progetto
ADD CONSTRAINT FK_prodotto_progetto FOREIGN KEY (id_prodotto)
REFERENCES prodotto (id_prodotto);

#inserisco record nella tabella "progetto"
INSERT INTO	progetto (id_sito, id_prodotto, data_avvio, data_termine)
VALUES 	(1,2,'2025-01-01','2026-01-01'),
		(1,5,'2024-11-12','2025-11-12'),
		(1,6,'2024-11-12','2025-11-12'),
		(1,7,'2025-03-25','2025-05-25'),
		(1,10,'2025-03-25','2026-03-25'),
		(2,2,'2025-01-01','2026-01-01'),
		(2,5,'2024-11-12','2025-11-12'),
		(2,6,'2024-11-12','2025-11-12'),
		(2,7,'2025-03-25','2025-05-25'),
		(2,10,'2025-03-25','2026-03-25'),
		(3,1,'2023-04-15','2024-04-15'),
		(3,5,'2023-02-18','2024-02-18'),
		(3,5,'2024-02-19','2025-02-19'),
		(3,5,'2025-02-20','2026-02-20'),
		(3,6,'2023-02-18','2024-02-18'),
		(3,6,'2024-02-19','2025-02-19'),
		(3,6,'2025-02-20','2026-02-20'),
		(4,5,'2024-09-04','2025-09-04'),
		(4,6,'2024-09-04','2025-09-04'),
		(4,9,'2024-09-04','2025-09-04'),
		(4,8,'2024-09-04','2024-11-04'),
		(5,9,'2025-06-22','2026-06-22'),
		(5,10,'2025-06-22','2026-06-22'),
		(5,11,'2025-06-22','2025-07-22'),
		(5,13,'2025-06-22','2026-06-22');

#descrivo i campi di "progetto"
DESCRIBE progetto;

#visualizzo i contenuti di "progetto"
SELECT * FROM progetto;

#creo la tabella "prodotto"
CREATE TABLE prodotto (
	id_prodotto INT AUTO_INCREMENT,
    nome VARCHAR(100),
    prezzo DECIMAL(5,2),
    categoria VARCHAR(50),
    CONSTRAINT PK_prodotto PRIMARY KEY (id_prodotto)
);

#modifico la tabella per portare il valore del DECIMAL di prezzo da (5,2) a (10,2)
ALTER TABLE prodotto
MODIFY COLUMN prezzo DECIMAL (10,2);

#inserisco record nella tabella "prodotto"
INSERT INTO prodotto (nome, prezzo, categoria)
VALUES	('Marketing 120 ore',14000,'Marketing'),
		('Marketing 240 ore',22000,'Marketing'),
		('Advertising 40 ore',6800,'Marketing'),
		('Advertising 60 ore',9000,'Marketing'),
		('Hosting',1000,'Sistemistica'),
		('Dominio',250,'Sistemistica'),
		('Nuovo Sito',4000,'Web'),
		('Migrazione a Wordpress',3500,'Web'),
		('CRM',4800,'Gestionale'),
		('Booking Engine',6600,'Gestionale'),
		('Configurazione GA4',300,'Configurazione'),
		('Server Side',2700,'Configurazione'),
		('Assistenza 2 ore',350,'Assistenza'),
		('Assistenza 4 ore',650,'Assistenza');
        
#descrivo i campi di "prodotto"
DESCRIBE prodotto;

#visualizzo i contenuti di "prodotto"
SELECT * FROM prodotto;

#visualizzo come è stata creata la tabella "sito" e gli attributi associati
SHOW CREATE TABLE sito;

