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

