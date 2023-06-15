/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  	id INT GENERATED ALWAYS AS IDENTITY,
  	name VARCHAR(250),
  	date_of_birth DATE,
  	escape_attempts INT,
  	neutered BIT,
	weight_kg DECIMAL(4, 2)
  PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);


/* Vet clinic database: query multiple tables -------------------------------------------------*/
/* Create a table named owners*/
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INT
);

/* Create a table named species*/
CREATE TABLE species (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

/* Remove column species*/
ALTER TABLE ANIMALS DROP COLUMN SPECIES
/* Add column species_id which is a foreign key referencing species table*/
ALTER TABLE ANIMALS ADD COLUMN species_id INT REFERENCES species(id);
/* Add column owner_id which is a foreign key referencing the owners table*/
ALTER TABLE ANIMALS ADD COLUMN owner_id INT REFERENCES owners(id);

