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
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born 
between 1990 and 2000?*/
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE (date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-31')
GROUP BY species;




/*Write queries (using JOIN) to answer the following questions:
What animals belong to Melody Pond?*/
SELECT name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon).*/
SELECT a.name, s.name AS SPECIES
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/
SELECT full_name AS owner_name, name AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

/* How many animals are there per species?*/
SELECT s.name AS species, COUNT(a.id) AS number_animals
FROM species s
JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell.*/
SELECT full_name AS owner_name, name AS animal_name
FROM owners o
JOIN animals a ON o.id = a.owner_id
WHERE o.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT full_name AS owner_name, name AS animal_name
FROM owners o
JOIN animals a ON o.id = a.owner_id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

/* Who owns the most animals?*/
SELECT o.full_name, COUNT(a.id) AS number_animals
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY number_animals DESC
LIMIT 1;




/* Write queries to answer the following: 
Who was the last animal seen by William Tatcher?*/
SELECT a.name AS last_animal_seen
FROM visits v
JOIN animals a ON v.animals_id = a.id
JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see?*/
SELECT COUNT(an.id) AS number_of_different_animals 
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN vets vt ON vt.id = vi.vets_id
WHERE vt.name = 'Stephanie Mendez'

/* List all vets and their specialties, including vets with no specialties.*/
SELECT vets.name AS vet_name, species.name AS speciality 
FROM vets
LEFT JOIN specializations specia ON vets.id = specia.vets_id
LEFT JOIN species ON species.id = specia.species_id

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT an.name AS animal_name, vi.date_of_visit
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN vets vt ON vi.vets_id = vt.id
WHERE vt.name = 'Stephanie Mendez' 
AND vi.date_of_visit >= '2020-04-01' 
AND vi.date_of_visit <= '2020-08-30'

/* What animal has the most visits to vets?*/
SELECT an.name as most_visited_animal, COUNT(*) AS number_of_visits
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
GROUP BY (vi.animals_id, an.name)
ORDER BY number_of_visits DESC
LIMIT 1;

/* Who was Maisy Smith's first visit?*/
SELECT an.name, MIN(vi.date_of_visit) AS date
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN vets vt ON vi.vets_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY (an.name)
LIMIT 1

/* Details for most recent visit: animal information, vet information, and date of visit. 2021-05-04*/
SELECT an.*, vt.*,
vt.name AS vet_name, vi.date_of_visit
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN vets vt ON vi.vets_id = vt.id
ORDER BY date_of_visit DESC
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(*) AS num_visits
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN vets vt ON vi.vets_id = vt.id
WHERE NOT EXISTS (
	SELECT 1
	FROM specializations sp
	WHERE sp.species_id = an.species_id AND sp.vets_id = vt.id
);
/*RESULT COUNTING BY HAND 12*/

/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT sp.name AS species_name, COUNT(*) AS number_of_visits
FROM visits vi
JOIN animals an ON vi.animals_id = an.id
JOIN SPECIES SP ON sp.id = an.species_id
JOIN vets vt ON vi.vets_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY (species_name)
