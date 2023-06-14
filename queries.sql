/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon".*/
SELECT * FROM animals
WHERE NAME LIKE '%mon';

/* List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals
WHERE (date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31');

/* List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals
WHERE (neutered = 1::bit AND escape_attempts < 3);

/* List the date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth FROM animals
WHERE name IN ('Agumon', 'Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg*/
select name, escape_attempts FROM animals
WHERE (weight_kg > 10.5);

/* Find all animals that are neutered.*/
SELECT * FROM animals
WHERE (neutered = 1::bit);

/* Find all animals not named Gabumon.*/
SELECT * FROM animals
WHERE name NOT IN ('Gabumon');

/* Find all animals with a weight between 10.4kg and 17.3kg 
(including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals
WHERE (weight_kg >= 10.4 AND weight_kg <= 17.3);





/* Inside a transaction update the animals table by setting the species column 
to unspecified. Verify that change was made. Then roll back the change and verify 
that the species columns went back to the state before the transaction.*/	
BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
/*Test change*/
SELECT * FROM animals
/*Rollback change*/
ROLLBACK;

/*Update the animals table by setting the species column to digimon for 
all animals that have a name ending in mon.*/
BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE NAME LIKE '%mon';

select * from animals
/*Update the animals table by setting the species column to pokemon for 
all animals that don't have species already set.*/
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

/* Inside a transaction delete all records in the animals table, 
then roll back the transaction.*/
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM ANIMALS
ROLLBACK;


/* Delete all animals born after Jan 1st, 2022*/
BEGIN TRANSACTION;
DELETE FROM animals
WHERE (date_of_birth > '2022-01-01');

/* Create a savepoint for the transaction.*/
SAVEPOINT SAVE1;

/* Update all animals' weight to be their weight multiplied by -1.*/
UPDATE animals
SET weight_kg = weight_kg * -1

/* Rollback to the savepoint*/
ROLLBACK TO SAVE1

/* Update all animals' weights that are negative to be their weight multiplied by -1.*/
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

/* Commit transaction*/
COMMIT;





/* How many animals are there?*/
SELECT COUNT(*) as Number_animals
FROM animals

/* How many animals have never tried to escape?*/
SELECT escape_attempts, COUNT(*) as Number_of_animals
FROM animals
GROUP BY escape_attempts
HAVING escape_attempts < 1;

/* What is the average weight of animals?*/
SELECT AVG(weight_kg) as avg_weight
FROM animals

/* Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, COUNT(*) AS escape_count
FROM animals
GROUP BY neutered
ORDER BY escape_count DESC;

/* What is the minimum and maximum weight of each type of animal?*/
SELECT species, MIN(WEIGHT_KG) AS Min_weight, MAX(WEIGHT_KG) AS Max_weight 
FROM animals
WHERE species = 'digimon' OR species = 'pokemon'
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born 
between 1990 and 2000?*/
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE (species = 'digimon' OR species = 'pokemon') 
AND (date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31')
GROUP BY species;
