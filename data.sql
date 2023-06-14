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
