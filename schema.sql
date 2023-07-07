DROP DATABASE IF EXISTS subtracker;
CREATE DATABASE subtracker;

\c subtracker

CREATE TABLE users (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE,
  password text NOT NULL UNIQUE
);

CREATE TABLE instruments (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE
);

CREATE TABLE musicians (
  id serial PRIMARY KEY,
  name text UNIQUE NOT NULL,
  phone_number text,
  email_address text,
  instrument_id integer NOT NULL REFERENCES instruments (id) ON DELETE CASCADE
);

INSERT INTO users (
  name, password
) VALUES ( 'admin', '$2a$12$CMFqcrmhP9kF0hQ0VMx0oubJrVLZR3Z4CiAQq4eU/l2w9P35KXD6a' );

INSERT INTO instruments (
  name
) VALUES ( 'banjo' ),
         ( 'guitar' ),
         ( 'violin' ),
         ( 'viola' ),
         ( 'cello' ),
         ( 'bass' ),
         ( 'drums' ),
         ( 'vocals' ),
         ( 'trombone' ),
         ( 'clarinet' ),
         ( 'trumpet' ),
         ( 'oboe' ),
         ( 'bassoon' ),
         ( 'triangle' ),
         ( 'bass drum' ),
         ( 'theremin' ),
         ( 'piano' ),
         ( 'steel pan' ),
         ( 'ewi' ),
         ( 'baritone saxophone' ),
         ( 'tenor saxophone' ),
         ( 'alto saxophone' ),
         ( 'soprano saxophone' ),
         ( 'bugle' ),
         ( 'flugelhorn' ),
         ( 'bass trombone' ),
         ( 'lute' ),
         ( 'baroque trumpet' ),
         ( 'mandolin' ),
         ( 'flute' ),
         ( 'english horn' ),
         ( 'musical saw' );

INSERT INTO musicians (
  name, phone_number, email_address, instrument_id
) VALUES ( 'caleb', '5555555555', 'caleb@gmail.com', 1 ),
         ( 'stef', '5555555555', 'stef@gmail.com', 8 ),
         ( 'steve', '5555555555', 'steve@gmail.com', 1 ),
         ( 'joe', '5555555555', 'joe@gmail.com', 11 ),
         ( 'joon', '5555555555', 'joon@gmail.com', 1 ),
         ( 'alice', '5555555555', 'alice@gmail.com', 1 ),
         ( 'bethany', '5555555555', 'bethany@gmail.com', 1 ),
         ( 'alex', '5555555555', 'alex@gmail.com', 1 ),
         ( 'jim', '5555555555', 'jim@gmail.com', 1 ),
         ( 'tony', '5555555555', 'tony@gmail.com', 1 ),
         ( 'johnny', '5555555555', 'johnny@gmail.com', 5 ),
         ( 'josh', '5555555555', 'josh@gmail.com', 1 ),
         ( 'jess', '5555555555', 'jess@gmail.com', 7 ),
         ( 'ryan', '5555555555', 'ryan@gmail.com', 1 ),
         ( 'angie', '5555555555', 'angie@gmail.com', 1 ),
         ( 'bud', '5555555555', 'bud@gmail.com', 13 ),
         ( 'declan', '5555555555', 'declan@gmail.com', 1 ),
         ( 'molly', '5555555555', 'molly@gmail.com', 1 ),
         ( 'autumn', '5555555555', 'autumn@gmail.com', 1 ),
         ( 'esther', '5555555555', 'esther@gmail.com', 17 ),
         ( 'renee', '5555555555', 'renee@gmail.com', 18 ),
         ( 'rona', '5555555555', 'rona@gmail.com', 19 ),
         ( 'jimmy', '5555555555', 'jimmy@gmail.com', 1 ),
         ( 'myla', '5555555555', 'myla@gmail.com', 11 ),
         ( 'elouise', '5555555555', 'elouise@gmail.com', 1 ),
         ( 'remi', '5555555555', 'remi@gmail.com', 1 ),
         ( 'euan', '5555555555', 'euan@gmail.com', 1 ),
         ( 'bertha', '5555555555', 'bertha@gmail.com', 15 ),
         ( 'shawn', '5555555555', 'shawn@gmail.com', 16 ),
         ( 'tanya', '5555555555', 'tanya@gmail.com', 17 ),
         ( 'kirsty', '5555555555', 'kirsty@gmail.com', 1 ),
         ( 'howard', '5555555555', 'howard@gmail.com', 19 ),
         ( 'peter', '5555555555', 'peter@gmail.com', 1 ),
         ( 'gabriel', '5555555555', 'gabriel@gmail.com', 1 ),
         ( 'dillon', '5555555555', 'dillon@gmail.com', 1 ),
         ( 'dylan', '5555555555', 'dylan@gmail.com', 1 ),
         ( 'shirley', '5555555555', 'shirley@gmail.com', 1 ),
         ( 'ash', '5555555555', 'ash@gmail.com', 1 ),
         ( 'sam', '5555555555', 'sam@gmail.com', 1 ),
         ( 'leyla', '5555555555', 'leyla@gmail.com', 1 ),
         ( 'aaron', '5555555555', 'aaron@gmail.com', 1 ),
         ( 'megan', '5555555555', 'megan@gmail.com', 1 ),
         ( 'david', '5555555555', 'david@gmail.com', 1 ),
         ( 'edgar', '5555555555', 'edgar@gmail.com', 19 );
