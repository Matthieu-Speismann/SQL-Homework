
/* *****************************************************************
   auteur : Fabienne Buffet
   date de création : 14/12/2023
   ***************************************************************** */


/*   SUPPRESSION DES TABLES SI ELLES EXISTENT DEJA   */

DROP TABLE IF EXISTS Eleve;
DROP TABLE IF EXISTS CDROM;
DROP TABLE IF EXISTS Seance;
DROP TABLE IF EXISTS Participation;
DROP TABLE IF EXISTS Serie;
DROP TABLE IF EXISTS Question;
DROP TABLE IF EXISTS Appartenance;


/*   CREATION DES TABLES   */

-- table Eleve

CREATE TABLE Eleve (
    IdEleve VARCHAR(10) NOT NULL,
	Prenom VARCHAR(30) NOT NULL,
	Nom VARCHAR(30) NOT NULL,
	Ville VARCHAR(30) NOT NULL,
	PRIMARY KEY (IdEleve)
	);

-- table CDROM

CREATE TABLE CDROM (
    IdCDROM VARCHAR(10) NOT NULL,
	NomEditeur VARCHAR(30) NOT NULL,
	PRIMARY KEY (IdCDROM)
	);

-- table Serie

CREATE TABLE Serie (
    IdSerie VARCHAR(10) NOT NULL,
    NumSerie INT NOT NULL,
	IdCDROM VARCHAR(10) NOT NULL,
	PRIMARY KEY (IdSerie)
	FOREIGN KEY (IdCDROM) REFERENCES CDROM(IdCDROM)
	);

-- table Seance

CREATE TABLE Seance (
	IdSeance VARCHAR(10) NOT NULL,
    DateSeance DATE NOT NULL,
	HeureSeance VARCHAR(5) NOT NULL,
	IdSerie VARCHAR(10) NOT NULL,
	PRIMARY KEY (IdSeance),
	FOREIGN KEY (IdSerie) REFERENCES Serie(IdSerie)
	);

-- table Participation

CREATE TABLE Participation (
	IdEleve VARCHAR(10) NOT NULL,
    IdSeance VARCHAR(10) NOT NULL,
	NbFautes INT,
	PRIMARY KEY (IdEleve, IdSeance), 
	FOREIGN KEY (IdEleve) REFERENCES Eleve(IdEleve), 
	FOREIGN KEY (IdSeance) REFERENCES Seance(IdSeance)
	);

-- table Question

CREATE TABLE Question (
	IdQuestion VARCHAR(10) NOT NULL,
	Intitule VARCHAR(100) NOT NULL,
	Reponse VARCHAR(100) NOT NULL,
	Niveau INT NOT NULL,
	Theme VARCHAR(20) NOT NULL,
	PRIMARY KEY (IdQuestion)
	);

-- table Appartenance

CREATE TABLE Appartenance (
	IdSerie VARCHAR(10) NOT NULL,
    IdQuestion VARCHAR(10) NOT NULL,
	NumeroQuestion INT NOT NULL,
	PRIMARY KEY (IdSerie, IdQuestion), 
	FOREIGN KEY (IdSerie) REFERENCES Serie(IdSerie), 
	FOREIGN KEY (IdQuestion) REFERENCES Question(IdQuestion)
	);

/*   CREATION DES TABLES   */

-- table Eleve
INSERT INTO Eleve (IdEleve, Prenom, Nom, Ville)
VALUES
('ELEVE00001', 'Martin', 'Dupont', 'Nancy'),
('ELEVE00002', 'Léon', 'Corpot', 'Laxou'),
('ELEVE00003', 'Annie', 'Milvent', 'Tomblaine'),
('ELEVE00004', 'Alexandra', 'Dubois', 'Nancy'),
('ELEVE00005', 'Stéphane', 'Presto', 'Nancy'),
('ELEVE00006', 'Julie', 'Dupuis', 'Nancy'),
('ELEVE00007', 'Laurent', 'Roliot', 'Nancy'),
('ELEVE00008', 'Chloé', 'Moulin', 'Laxou'),
('ELEVE00009', 'Vincent', 'Valence', 'Tomblaine'),
('ELEVE00010', 'Pierre', 'Ponce', 'Laxou');

-- table CDROM

INSERT INTO CDROM (IdCDROM, NomEditeur)
VALUES
('CDROM00001', 'CodePro'), 
('CDROM00002', 'CodePro'), 
('CDROM00003', 'EditRoute');

-- table Serie

INSERT INTO Serie (IdSerie, NumSerie, IdCDROM)
VALUES
('SERIE00001', 1, 'CDROM00001'), 
('SERIE00002', 2, 'CDROM00001'), 
('SERIE00003', 1, 'CDROM00002'), 
('SERIE00004', 2, 'CDROM00002'), 
('SERIE00005', 1, 'CDROM00003'), 
('SERIE00006', 2, 'CDROM00003');

-- table Seance

INSERT INTO Seance (IdSeance, DateSeance, HeureSeance, IdSerie)
VALUES
('SEANCE0001', '2023-12-04', '17:00', 'SERIE00006'), 
('SEANCE0002', '2023-12-04', '18:00', 'SERIE00001'), 
('SEANCE0003', '2023-12-04', '19:00', 'SERIE00004'), 
('SEANCE0004', '2023-12-05', '17:00', 'SERIE00005'), 
('SEANCE0005', '2023-12-05', '18:00', 'SERIE00004'), 
('SEANCE0006', '2023-12-06', '17:00', 'SERIE00002'), 
('SEANCE0007', '2023-12-06', '18:00', 'SERIE00006'), 
('SEANCE0008', '2023-12-06', '19:00', 'SERIE00001');

-- table Participation

INSERT INTO Participation (IdEleve, IdSeance, NbFautes)
VALUES
('ELEVE00001', 'SEANCE0001', 6),
('ELEVE00007', 'SEANCE0001', 3),
('ELEVE00009', 'SEANCE0001', 8),
('ELEVE00004', 'SEANCE0002', 1),
('ELEVE00006', 'SEANCE0002', 6),
('ELEVE00003', 'SEANCE0003', 2),
('ELEVE00006', 'SEANCE0003', 8),
('ELEVE00008', 'SEANCE0003', 4),
('ELEVE00009', 'SEANCE0003', 2),
('ELEVE00002', 'SEANCE0004', 4),
('ELEVE00004', 'SEANCE0004', 0),
('ELEVE00010', 'SEANCE0004', 2),
('ELEVE00002', 'SEANCE0005', 7),
('ELEVE00006', 'SEANCE0005', 2),
('ELEVE00010', 'SEANCE0005', 0),
('ELEVE00001', 'SEANCE0006', 1),
('ELEVE00003', 'SEANCE0006', 1),
('ELEVE00008', 'SEANCE0006', 0),
('ELEVE00009', 'SEANCE0006', 5),
('ELEVE00004', 'SEANCE0007', 0),
('ELEVE00006', 'SEANCE0007', 1),
('ELEVE00002', 'SEANCE0008', 3),
('ELEVE00003', 'SEANCE0008', 2),
('ELEVE00008', 'SEANCE0008', 1),
('ELEVE00009', 'SEANCE0008', 1),
('ELEVE00010', 'SEANCE0008', 1);

-- table Question

INSERT INTO Question (IdQuestion, Intitule, Reponse, Niveau, Theme)
VALUES
('QUEST00001', 'INT0001', 'REP0001', 1, 'les croisements'), 
('QUEST00002', 'INT0002', 'REP0002', 1, 'les croisements'), 
('QUEST00003', 'INT0003', 'REP0003', 1, 'les croisements'), 
('QUEST00004', 'INT0004', 'REP0004', 2, 'les croisements'), 
('QUEST00005', 'INT0005', 'REP0005', 2, 'les croisements'), 
('QUEST00006', 'INT0006', 'REP0006', 2, 'les croisements'), 
('QUEST00007', 'INT0007', 'REP0007', 3, 'les croisements'), 
('QUEST00008', 'INT0008', 'REP0008', 3, 'les croisements'), 
('QUEST00009', 'INT0009', 'REP0009', 3, 'les croisements'), 
('QUEST00010', 'INT0010', 'REP0010', 3, 'les croisements'), 
('QUEST00011', 'INT0011', 'REP0011', 1, 'les panneaux'), 
('QUEST00012', 'INT0012', 'REP0012', 1, 'les panneaux'), 
('QUEST00013', 'INT0013', 'REP0013', 1, 'les panneaux'), 
('QUEST00014', 'INT0014', 'REP0014', 2, 'les panneaux'), 
('QUEST00015', 'INT0015', 'REP0015', 2, 'les panneaux'), 
('QUEST00016', 'INT0016', 'REP0016', 2, 'les panneaux'), 
('QUEST00017', 'INT0017', 'REP0017', 3, 'les panneaux'), 
('QUEST00018', 'INT0018', 'REP0018', 3, 'les panneaux'), 
('QUEST00019', 'INT0019', 'REP0019', 3, 'les panneaux'), 
('QUEST00020', 'INT0020', 'REP0020', 3, 'les panneaux'),
('QUEST00021', 'INT0021', 'REP0021', 1, 'les limitations de vitesse'), 
('QUEST00022', 'INT0022', 'REP0022', 1, 'les limitations de vitesse'), 
('QUEST00023', 'INT0023', 'REP0023', 1, 'les limitations de vitesse'), 
('QUEST00024', 'INT0024', 'REP0024', 2, 'les limitations de vitesse'), 
('QUEST00025', 'INT0025', 'REP0025', 2, 'les limitations de vitesse'), 
('QUEST00026', 'INT0026', 'REP0026', 2, 'les limitations de vitesse'), 
('QUEST00027', 'INT0027', 'REP0027', 3, 'les limitations de vitesse'), 
('QUEST00028', 'INT0028', 'REP0028', 3, 'les limitations de vitesse'), 
('QUEST00029', 'INT0029', 'REP0029', 3, 'les limitations de vitesse'), 
('QUEST00030', 'INT0030', 'REP0030', 3, 'les limitations de vitesse'),
('QUEST00031', 'INT0031', 'REP0031', 1, 'les voitures'), 
('QUEST00032', 'INT0032', 'REP0032', 1, 'les voitures'), 
('QUEST00033', 'INT0033', 'REP0033', 1, 'les voitures'), 
('QUEST00034', 'INT0034', 'REP0034', 2, 'les voitures'), 
('QUEST00035', 'INT0035', 'REP0035', 2, 'les voitures'), 
('QUEST00036', 'INT0036', 'REP0036', 2, 'les voitures'), 
('QUEST00037', 'INT0037', 'REP0037', 3, 'les voitures'), 
('QUEST00038', 'INT0038', 'REP0038', 3, 'les voitures'), 
('QUEST00039', 'INT0039', 'REP0039', 3, 'les voitures'), 
('QUEST00040', 'INT0040', 'REP0040', 3, 'les voitures');

-- table Appartenance

INSERT INTO Appartenance (IdSerie, IdQuestion, NumeroQuestion)
VALUES
('SERIE00001', 'QUEST00001', 1), 
('SERIE00001', 'QUEST00002', 2), 
('SERIE00001', 'QUEST00011', 3), 
('SERIE00001', 'QUEST00012', 4), 
('SERIE00001', 'QUEST00021', 5), 
('SERIE00001', 'QUEST00022', 6), 
('SERIE00001', 'QUEST00023', 7), 
('SERIE00001', 'QUEST00024', 8), 
('SERIE00001', 'QUEST00031', 9), 
('SERIE00001', 'QUEST00033', 10), 
('SERIE00002', 'QUEST00003', 1), 
('SERIE00002', 'QUEST00004', 2), 
('SERIE00002', 'QUEST00005', 3), 
('SERIE00002', 'QUEST00013', 4), 
('SERIE00002', 'QUEST00014', 5), 
('SERIE00002', 'QUEST00022', 6), 
('SERIE00002', 'QUEST00025', 7), 
('SERIE00002', 'QUEST00026', 8), 
('SERIE00002', 'QUEST00035', 9), 
('SERIE00002', 'QUEST00036', 10), 
('SERIE00003', 'QUEST00006', 1), 
('SERIE00003', 'QUEST00007', 2), 
('SERIE00003', 'QUEST00015', 3), 
('SERIE00003', 'QUEST00016', 4), 
('SERIE00003', 'QUEST00017', 5), 
('SERIE00003', 'QUEST00021', 6), 
('SERIE00003', 'QUEST00023', 7), 
('SERIE00003', 'QUEST00026', 8), 
('SERIE00003', 'QUEST00032', 9), 
('SERIE00003', 'QUEST00034', 10), 
('SERIE00004', 'QUEST00011', 1), 
('SERIE00004', 'QUEST00013', 2), 
('SERIE00004', 'QUEST00015', 3), 
('SERIE00004', 'QUEST00016', 4), 
('SERIE00004', 'QUEST00022', 5), 
('SERIE00004', 'QUEST00024', 6), 
('SERIE00004', 'QUEST00026', 7), 
('SERIE00004', 'QUEST00031', 8), 
('SERIE00004', 'QUEST00035', 9), 
('SERIE00004', 'QUEST00036', 10), 
('SERIE00005', 'QUEST00008', 1), 
('SERIE00005', 'QUEST00009', 2), 
('SERIE00005', 'QUEST00010', 3), 
('SERIE00005', 'QUEST00018', 4), 
('SERIE00005', 'QUEST00019', 5), 
('SERIE00005', 'QUEST00020', 6), 
('SERIE00005', 'QUEST00028', 7), 
('SERIE00005', 'QUEST00029', 8), 
('SERIE00005', 'QUEST00037', 9), 
('SERIE00005', 'QUEST00039', 10), 
('SERIE00006', 'QUEST00019', 1), 
('SERIE00006', 'QUEST00020', 2), 
('SERIE00006', 'QUEST00027', 3), 
('SERIE00006', 'QUEST00028', 4), 
('SERIE00006', 'QUEST00029', 5), 
('SERIE00006', 'QUEST00030', 6), 
('SERIE00006', 'QUEST00037', 7), 
('SERIE00006', 'QUEST00038', 8), 
('SERIE00006', 'QUEST00039', 9), 
('SERIE00006', 'QUEST00040', 10);

