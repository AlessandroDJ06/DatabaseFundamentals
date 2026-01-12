CREATE TABLE festival (
    festival_id INT CONSTRAINT pk_festival_id_festival PRIMARY KEY,
    name VARCHAR(100) CONSTRAINT nn_name_festival NOT NULL,
    location VARCHAR(100) CONSTRAINT nn_location_festival NOT NULL,
    start_date DATE CONSTRAINT nn_start_date_festival NOT NULL,
    end_date DATE CONSTRAINT nn_end_date_festival NOT NULL
    );

CREATE TABLE artist (
    artist_id INT CONSTRAINT pk_artist_id_artist PRIMARY KEY,
    name VARCHAR(100) CONSTRAINT nn_name_artist NOT NULL,
    country VARCHAR(50),
    genre VARCHAR(30)
);

CREATE TABLE stage (
    stage_id INT CONSTRAINT pk_stage_id_stage PRIMARY KEY,
    festival_id INT CONSTRAINT nn_festival_id_stage NOT NULL,
    name VARCHAR(100) CONSTRAINT nn_name_stage NOT NULL,
    capacity INT,

    CONSTRAINT fk_festival_id_stage FOREIGN KEY (festival_id) REFERENCES festival(festival_id)
);

CREATE TABLE performance (
    performance_id INT CONSTRAINT pk_performance_id_performance PRIMARY KEY,
    artist_id INT CONSTRAINT nn_artist_id_performance NOT NULL,
    stage_id INT CONSTRAINT nn_stage_id_performance NOT NULL,
    start_time TIMESTAMP CONSTRAINT nn_start_time_performance NOT NULL,
    end_time TIMESTAMP CONSTRAINT nn_end_time_performance NOT NULL,

    CONSTRAINT fk_artist_id_performance FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
    CONSTRAINT fk_stage_id_performance FOREIGN KEY (stage_id) REFERENCES stage(stage_id)
);

CREATE TABLE ticket_type (
    ticket_type_id INT CONSTRAINT pk_ticket_type_id_ticket_type PRIMARY KEY,
    festival_id INT CONSTRAINT nn_festival_id_ticket_type NOT NULL,
    name VARCHAR(50) CONSTRAINT nn_name_ticket_type NOT NULL,
    price DECIMAL(8,2) CONSTRAINT nn_price_ticket_type NOT NULL,

    CONSTRAINT fk_festival_id FOREIGN KEY (festival_id) REFERENCES festival(festival_id)
);

CREATE TABLE visitor (
    visitor_id INT CONSTRAINT pk_visitor_id_visitors PRIMARY KEY,
    name VARCHAR(100) CONSTRAINT nn_name_visitors NOT NULL,
    email VARCHAR(100),
    birth_date DATE
);

CREATE TABLE ticket (
    ticket_id INT CONSTRAINT pk_ticket_id_ticket PRIMARY KEY,
    visitor_id INT CONSTRAINT nn_visitor_id_ticket NOT NULL,
    ticket_type_id INT CONSTRAINT nn_ticket_type_id_ticket NOT NULL,
    purchase_date DATE CONSTRAINT nn_purchase_date_ticket NOT NULL,
    used BOOLEAN,

    CONSTRAINT fk_visitor_id_ticket FOREIGN KEY (visitor_id) REFERENCES visitor(visitor_id),
    CONSTRAINT fk_ticket_type_id_ticket FOREIGN KEY (ticket_type_id) REFERENCES ticket_type(ticket_type_id)
);

--deel2
-- Festivals
INSERT INTO festival (festival_id, name, location, start_date, end_date)
VALUES
    (1, 'Summer Fest', 'Netherlands', '2026-07-10', '2026-07-12'),
    (2, 'Winter Jam', 'Belgium', '2026-12-01', '2026-12-03');
INSERT INTO festival (festival_id, name, location, start_date, end_date)
VALUES (3, 'October Fest', 'Belgium', '2026-10-01', '2026-10-03');


-- Artists
INSERT INTO artist (artist_id, name, country, genre)
VALUES
    (1, 'Daft Punk', 'France', 'Electronic'),
    (2, 'Coldplay', 'UK', 'Pop'),
    (3, 'Adele', 'UK', 'Pop'),
    (4, 'Martin Garrix', 'Netherlands', 'EDM');

-- Stages
INSERT INTO stage (stage_id, festival_id, name, capacity)
VALUES
    (1, 1, 'Main Stage', 20000),
    (2, 1, 'Second Stage', 10000),
    (3, 2, 'Winter Stage', 15000);

-- Performances
INSERT INTO performance (performance_id, artist_id, stage_id, start_time, end_time)
VALUES
    (1, 1, 1, '2026-07-10 18:00', '2026-07-10 20:00'),
    (2, 2, 1, '2026-07-11 19:00', '2026-07-11 21:00'),
    (3, 3, 2, '2026-07-12 17:00', '2026-07-12 19:00'),
    (4, 4, 3, '2026-12-01 20:00', '2026-12-01 22:00');

-- Ticket Types
INSERT INTO ticket_type (ticket_type_id, festival_id, name, price)
VALUES
    (1, 1, 'Standard', 100),
    (2, 1, 'VIP', 250),
    (3, 2, 'Standard', 120);

-- Visitors
INSERT INTO visitor (visitor_id, name, email, birth_date, phone)
VALUES
    (1, 'Alice', 'alice@mail.com', '2000-05-01', '0123456789'),
    (2, 'Bob', NULL, '1998-09-20', NULL),
    (3, 'Charlie', 'charlie@mail.com', '2001-02-15', '0987654321'),
    (4, 'Diana', NULL, '1995-12-30', NULL);


-- Tickets
INSERT INTO ticket (ticket_id, visitor_id, ticket_type_id, purchase_date, used)
VALUES
    (1, 1, 1, '2026-06-01', TRUE),
    (2, 2, 2, '2026-06-05', FALSE),
    (3, 3, 1, '2026-06-10', NULL),
    (4, 4, 3, '2026-11-15', TRUE);

DELETE FROM ticket
WHERE visitor_id = 4

--deel3
--A)
SELECT *
FROM festival;
--B)
SELECT name
FROM artist;
--C)
SELECT stage_id , f.festival_id ,f.name
FROM stage s
JOIN festival f on s.festival_id = f.festival_id

--deel4
--A)
UPDATE festival
SET location = 'Netherlands'
WHERE UPPER(name) = 'SUMMER FEST';
--B)
UPDATE stage
SET capacity = capacity + 5000
WHERE UPPER(name) = 'MAIN STAGE';
--C)
DELETE FROM artist
WHERE UPPER(name) = 'COLDPLAY';

--deel5
--A)
ALTER TABLE visitor
ADD COLUMN phone VARCHAR(20);
--B)
ALTER TABLE visitor
ADD CONSTRAINT un_email_visitors
UNIQUE (email);
--C)
ALTER TABLE ticket_type
ADD CONSTRAINT ch_price_ticket_type
CHECK ( price > 0 );
--deel6
--A)
SELECT name,COALESCE(email,'no email')
FROM visitor;
--B)
SELECT ticket_id,
       CASE used
           WHEN true THEN 'used'
           WHEN false THEN 'unused'
           ELSE 'unknown'
       END AS status
FROM ticket;
--deel7
--A)
SELECT *
FROM artist a
WHERE EXISTS(
    SELECT *
    FROM performance p
    WHERE a.artist_id = p.artist_id
);
--B)
SELECT *
FROM visitor v
WHERE NOT EXISTS(
    SELECT *
    FROM  ticket t
    WHERE v.visitor_id = t.visitor_id
);
--C)
SELECT *
FROM festival f
WHERE NOT EXISTS(
    SELECT *
    FROM ticket_type t
    WHERE t.festival_id = f.festival_id
);

--deel8
--A)
SELECT f.name, (SELECT count(*)
                FROM stage s
                 WHERE f.festival_id = s.festival_id)
FROM festival f;
--B)
SELECT a.name,(SELECT count(*)
               FROM performance p
               WHERE a.artist_id = p.artist_id)
FROM artist a;
--C)
SELECT v.name,(SELECT count(*)
               FROM ticket t
               WHERE v.visitor_id = t.visitor_id)
FROM visitor v



