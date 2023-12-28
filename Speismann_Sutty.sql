------------------ DM de Base de Données: SQL ---------------------

--- Rendu de SPEISMANN Matthieu et SUTTY Charles:


-- Question 1:

SELECT IdQuestion, Intitule
FROM Question
WHERE Niveau = 2 AND Theme = "les croisements";

-- Question 2:

SELECT Nom, Prenom
FROM Eleve
WHERE Ville <> "Nancy" AND Nom LIKE "%v%"; 

-- Remarque: On a pas besoin de différencier 'v' de 'V'.

-- Question 3:

SELECT COUNT(*) AS 'Nombre de themes'
FROM(
    SELECT DISTINCT Theme
    FROM Question
);

-- Question 4:

SELECT Ville, COUNT(IdEleve) AS "Nombre d'élèves"
FROM Eleve
GROUP BY Ville
ORDER BY "Nombre d'élèves" DESC;

-- Question 5:

SELECT IdQuestion, COUNT(IdSerie) AS "Nombre d'apparition", 
    GROUP_CONCAT(IdSerie||": "|| NumeroQuestion) AS "Détails"
FROM Appartenance
GROUP BY IdQuestion
    HAVING "Nombre d'apparition" >=2
ORDER BY "Nombre d'apparition" DESC, IdQuestion ASC;

-- Question 6:

SELECT IdSerie
FROM( 
-- Sous requête attribuant à chaque série le nombre de question sur les panneaux
    SELECT app.IdSerie, COUNT(q.IdQuestion) AS "Nombre de question sur les panneaux"
    FROM Appartenance AS app
    JOIN Question AS q
        ON q.IdQuestion = app.IdQuestion
    WHERE q.Theme = "les panneaux"
    GROUP BY app.IdSerie)
WHERE "Nombre de question sur les panneaux" >= 3;

-- Question 7:

SELECT DISTINCT q.IdQuestion, q.Theme, q.Niveau 
FROM Question AS q 
JOIN Appartenance AS app
    ON app.IdQuestion = q.IdQuestion
JOIN Seance AS s
    ON s.IdSerie = app.IdSerie
JOIN Participation AS part
    ON part.IdSeance = s.IdSeance
JOIN Eleve AS e
    ON e.IdEleve = e.IdEleve
WHERE e.Prenom = "Alexandra" AND e.Nom = "Dubois"
ORDER BY q.IdQuestion ASC;

-- Question 8:

SELECT e.Nom, e.Prenom, COUNT(part.IdSeance) AS "Nombre de séance", ROUND(AVG(part.NbFautes),2) AS "Moyenne de fautes commises", MIN(part.NbFautes) AS "Minimum de fautes commises", MAX(part.NbFautes) AS "Maximum de fautes commises"
FROM Eleve AS e
JOIN Participation AS part
    ON part.IdEleve = e.IdEleve
GROUP BY e.IdEleve
    HAVING "Nombre de séance" >= 2
ORDER BY e.Nom ASC, e.Prenom ASC;

-- Question 9:

SELECT s.IdSeance, s.DateSeance, s.HeureSeance
FROM Seance AS s
JOIN Participation AS part1
    ON part1.IdSeance = s.IdSeance
JOIN Eleve AS e1
    ON e1.IdEleve = part1.IdEleve
JOIN Participation AS part2
    ON part2.IdSeance = part1.IdSeance
JOIN Eleve AS e2
    ON e2.IdEleve = part2.IdEleve
WHERE (e1.Nom = "Dubois" AND e1.Prenom = "Alexandra" ) AND (e2.Nom = "Dupuis" AND e2.Prenom = "Julie");

-- Question 10:

SELECT IdSerie
FROM Serie
WHERE IdSerie NOT IN( 
    -- Sous requête pour avoir les série ayant une question sur le thème les croisements.
    SELECT DISTINCT IdSerie
    FROM Appartenance
    WHERE IdQuestion IN(
-- Sous requête pour avoir les questions de thème les croisements
        SELECT IdQuestion
        FROM Question
        WHERE Theme = "les croisements"));

-- Question 11:

SELECT e.IdEleve, e.Nom, e.Prenom
FROM Eleve AS e
JOIN Participation AS part
    ON e.IdEleve = part.IdEleve
WHERE part.NbFautes = (
-- Sous requête pour récupérer le nombre maximal de fautes commises.
SELECT MAX(NbFautes) AS "Maximum de fautes"
FROM Participation)
ORDER BY e.IdEleve;

-- Question 12:

-- Remarque: Cette requête fonctionne mais répète la séléction du thème et le GROUP BY. 
-- Il est peut être possible de l'améliorer. 

SELECt app.IdSerie
FROM Appartenance AS app
JOIN Question AS q
    ON q.IdQuestion = app.IdQuestion
WHERE q.Theme = "les limitations de vitesse"
GROUP BY app.IdSerie
HAVING COUNT(q.IdQuestion) = (
-- Sous requête pour avoir le maximum du nombre de question sur les limitations de vitesse dans une série. 
    SELECT MAX("Nombre de questions sur les limitations de vitesse") AS "Max"
    FROM(
    -- Sous requête pour avoir le nombre de question sur le thème "les limitations de vitesse" par série.
        SELECT app.IdSerie, COUNT(q.IdQuestion) 
                            AS "Nombre de questions sur les limitations de vitesse"
        FROM Appartenance AS app
        JOIN Question AS q
            ON app.IdQuestion = q.IdQuestion
        WHERE q.Theme = "les limitations de vitesse"
        GROUP BY app.IdSerie));

-- Question 13:

SELECT e.Nom, e.Prenom
FROM Eleve AS e
JOIN Participation AS part
    ON part.IdEleve = e.IdEleve
JOIN Seance
    ON Seance.IdSeance = part.IdSeance
JOIN Serie
    ON Serie.IdSerie = Seance.IdSerie
GROUP BY e.IdEleve
HAVING COUNT(DISTINCT Serie.IdCDROM) = (
    -- Sous requête pour récupérer le nombre total de CDROMs. 
    SELECT COUNT(IdCDROM)
    FROM CDROM);

-- Question 14:

SELECT e.Nom, e.Prenom, ROUND(AVG(part.NbFautes), 2) AS "Nombre de fautes moyen"
FROM Eleve AS e
JOIN Participation AS part
    ON part.IdEleve = e.IdEleve
GROUP BY e.IdEleve
ORDER BY "Nombre de fautes moyen" ASC;

-- Question 15:


-- Question 16 (Bonus):