/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 	('Agumon', '2020-02-03', 0, 1::bit, 10.23),
		('Gabumon', '2018-11-15', 2, 1::bit, 8.00),
		('Pikachu', '2021-01-07', 1, 0::bit, 15.04),
		('Devimon', '2017-05-12', 5, 1::bit, 11.00);
