--oef1
--Geef alle gegevens over alle projecten die binnen het bedrijf worden gerealiseerd.

SELECT * from projects;

--oef2
--Druk voor alle projecten de projectnaam en het afdelingsnummer van de ondersteunende afdeling af
SELECT project_name,department_id FROM projects;

--oef3a
--Wijzig de voorgaande select zodat je de volgende resultatentabel krijgt:
SELECT 'project',project_name,'is handled by',department_id FROM projects;

--oef3b
--Zorg er nu voor dat de hoofdingen voor de constante kolommen blanco (hebben GEEN kolomnaam) blijven.
--Ter info : kolom namen staan hieronder in het vet gedrukt, de woorden ‘text’ en ‘numeric‘ geven het datatype van die kolom aan
SELECT 'project' AS " ",project_name,'is handled by' AS " ",department_id FROM projects;

--oef3c
--Zorg ervoor dat je alles in 1 kolom afdrukt en geef die kolom de hoofding "projects with departments"
SELECT  CONCAT_WS(' ','project',project_name,'is handled by' , department_id)  AS "Projects with departments" FROM projects;

--oef4
-- Voer de volgende instructie uit. Wat geeft het resultaat weer?
SELECT current_date - birth_date
FROM FAMILY_MEMBERS;
--het geeft hoeveel dagen je oud bent

--oef5
--Verklaar telkens de fout:
SELECT employee_id,project_id,hours; --from statement niet gebruikt
SELECT * FROM TASK; -- TASK moet in kleine letters

--verbeterde versie
SELECT employee_id,project_id,hours FROM tasks;



