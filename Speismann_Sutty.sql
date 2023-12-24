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


-- Question 7:


-- Question 8:


-- Question 9:


-- Question 10:


-- Question 11:


-- Question 12:


-- Question 13:


-- Question 14:


-- Question 15:


-- Question 16 (Bonus):