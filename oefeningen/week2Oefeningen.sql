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



SELECT employee_id
from tasks;

--oef6
--Er wordt een overzicht gevraagd van de woonplaatsen van de medewerkers van het bedrijf. Dit geeft onderstaande resultatentabel

SELECT location
from employees;

SELECT DISTINCT UPPER(location)
from employees;

--Oef7
--We willen weten in welke afdelingen medewerkers tewerkgesteld zijn en wat hun woonplaats is, sorteer op woonplaats.
SELECT department_id,location
FROM employees
ORDER BY location;

--oef8
--a. vraag de datum van vandaag op.
SELECT now();

--b. bereken een korting van 15% op 150. Je moet onderstaande resultatentabel bekomen
SELECT 150-(150*0.15);

--c. gebruik de afzonderlijke woorden “Data Retrieval”, ” Chapter 3-4”  en “SQL” om in één instructie de volgende resultatentabel te bekomen. Let ook op de titel van de kolom!:
SELECT 'Data Retrievel' ||  '' ||  'Chapter 3-4' || '' || 'SQL' AS "Best Course";

--Oef9
--Welke Personen behoren tot het gezin van medewerker 999111111? Je moet exact de volgende resultatentabel bekomen.

SELECT employee_id AS "employee",NAME AS "NAME FAMILY MEMBERS",relationship,gender
FROM family_members
WHERE employee_id = '999111111';

--Oef10
--Geef alle informatie over de afdeling ‘Administration’?
SELECT department_id, department_name, manager_id,mgr_start_date
FROM departments
WHERE department_name = 'Administration'

--oef11
SELECT employee_id, last_name, location
FROM employees
WHERE INITCAP(location) ='Maastricht';

--oef12
--Welke medewerkers werkten aan project 10 tussen de 20 en 35 uren (beide inclusief)?
--Geef het medewerkersnummer, het projectnummer en het aantal gepresteerde uren weer.

SELECT employee_id,project_id,hours
FROM tasks
WHERE project_id = 10 AND hours BETWEEN 20 AND 35

--oef13
SELECT project_id,hours
FROM tasks
WHERE employee_id = '999222222' AND hours < 10;

--oef14
--Welke medewerkers komen uit de Provincie Groningen (GR) of Noord Brabant (NB)? Los op 2 manieren op!

SELECT employee_id,last_name,province
FROM employees
WHERE province = 'GR' OR province = 'NB';

SELECT employee_id,last_name,province
FROM employees
WHERE province IN ('NB','GR');

--Oef15
--Zijn er medewerkers met voornaam Suzan, Martina, Henk of Douglas en op welke afdeling werken ze? Sorteer op afdelingsnummer (in dalende volgorde) en daarbinnen alfabetisch op voornaam.

SELECT department_id,first_name
FROM employees
WHERE first_name IN ('Suzan','Martina','Henk','Douglas')
ORDER BY department_id DESC,first_name DESC;

--Oef16
--We willen in onze resultatentabel:
--m, afdelingsnummer en salaris van medewerkers uit afdeling 7 die minder dan 40000 verdienen,
--sook de naam, het afdelingsnummer en het salaris van medewerker 999666666

SELECT last_name,salary,department_id
FROM employees
WHERE department_id = 7 AND salary < 40000 OR employee_id = '999666666';

--Oef 17
-- Welke medewerkers wonen niet in Maarssen en ook niet in Eindhoven?

SELECT last_name,department_id
FROM employees
WHERE location NOT IN ('Maarssen','Eindhoven');

--Oef18

SELECT employee_id,project_id,hours
FROM tasks
ORDER BY hours ASC NULLS FIRST

SELECT employee_id,project_id,hours
FROM tasks
ORDER BY hours DESC NULLS LAST

--Oef19

SELECT last_name,location,salary
FROM employees
WHERE Location LIKE 'm%' OR location LIKE 'O%' AND salary > 30000;

--oef20

SELECT name
FROM family_members
WHERE birth_date >= '1988-01-01' AND birth_date <= '1988-12-31';

--oef21

SELECT first_name,last_name,salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

--oef22

SELECT first_name,last_name,birth_date
FROM employees
ORDER BY birth_date ASC
LIMIT 3;

