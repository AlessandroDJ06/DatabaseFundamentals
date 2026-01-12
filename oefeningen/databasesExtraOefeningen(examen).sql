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
INSERT INTO festival (festival_id,name,location,start_date,end_date)
VALUES (1,'Summer Fest','Belgium','2026-07-10','2026-07-12');

INSERT INTO artist (artist_id, name, country, genre)
VALUES (1, 'Daft Punk', 'France', 'Electronic');

INSERT INTO artist (artist_id, name, country, genre)
VALUES (2, 'Coldplay', 'UK', 'Pop');

INSERT INTO stage (stage_id, festival_id, name, capacity)
VALUES (1, 1, 'Main Stage', 20000);

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
FROM ticket


