/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 	('Agumon', '2020-02-03', 0, 1::bit, 10.23),
		('Gabumon', '2018-11-15', 2, 1::bit, 8.00),
		('Pikachu', '2021-01-07', 1, 0::bit, 15.04),
		('Devimon', '2017-05-12', 5, 1::bit, 11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 	('Charmander', '2020-02-08', 0, 0::bit, -11.00),
		('Plantmon', '2021-11-15', 2, 1::bit, -5.70),
		('Squirtle', '1993-04-02', 3, 0::bit, -12.13),
		('Angemon', '2005-06-12', 1, 1::bit, -45.00),
		('Boarmon', '2005-06-07', 7, 1::bit, 20.40),
		('Blossom', '1998-10-13', 3, 1::bit, 17.00),
		('Ditto', '2022-05-14', 4, 1::bit, 22.00);


/* insert the following data into the owners*/
INSERT INTO owners (full_name, age)
VALUES 	('Sam Smith', 34),
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38);

/* insert data into the species*/
INSERT INTO species (name)
VALUES 	('Pokemon'),
		('Digimon');
		
/* modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon*/
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

UPDATE animals										/* id = 3*/
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon'

UPDATE animals										/* id = 4*/
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals										/* id = 5*/
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals										/* id = 6*/
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals										/* id = 7*/
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');




/* Data for vets --------------------------------------*/
INSERT INTO vets (name, age, date_of_graduation)
VALUES 	('William Tatcher', 45, '2000-04-23'),
		('Maisy Smith', 26, '2019-01-17'),
		('Stephanie Mendez', 64, '1981-05-04'),
		('Jack Harkness', 38, '2008-06-08');
		
/* Data for vets  id 3 pokemon, id 4 digimon*/
INSERT INTO specializations (species_id, vets_id)
	VALUES (3, 1),
			(3, 3),
			(4, 3),
			(4, 4);
			
/* data for visits
1 William Tatcher
2 Maisy Smith
3 Stephanie Mendez
4 Jack Harkness*/
INSERT INTO visits (animals_id, vets_id, date_of_visit)
	VALUES  (1, 1, '2020-05-24'),
			(1, 3, '2020-07-22'),
			(2, 4, '2020-07-22'),
			(3, 2, '2020-01-05'),
			(3, 2, '2020-03-08'),
			(3, 2, '2020-05-14'),
			(4, 3, '2021-05-04'),
			(5, 4, '2021-02-24'),
			(6, 2, '2019-12-21'),
			(6, 1, '2020-08-10'),
			(6, 2, '2021-04-07'),
			(7, 3, '2019-09-29'),
			(8, 4, '2020-10-03'),
			(8, 4, '2020-11-04'),
			(9, 2, '2019-01-24'),
			(9, 2, '2019-05-15'),
			(9, 2, '2020-02-27'),
			(9, 2, '2020-08-03'),
			(10, 3, '2020-05-24'),
			(10, 1, '2021-01-11');
