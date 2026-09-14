-- DESCRIBE/DESC é comando do SQL*Plus (cliente), não SQL: não roda pelo JDBC.
-- Equivalente como consulta, no dicionário de dados:

SELECT column_id,
       column_name                                  AS "Name",
       CASE WHEN nullable = 'N' THEN 'NOT NULL' END AS "Null?",
       CASE
           WHEN data_type IN ('VARCHAR2', 'CHAR', 'NVARCHAR2', 'NCHAR', 'RAW')
               THEN data_type || '(' || data_length || ')'
           WHEN data_type = 'NUMBER' AND data_precision IS NOT NULL
               THEN data_type || '(' || data_precision
               || NVL2(NULLIF(data_scale, 0), ',' || data_scale, '') || ')'
           ELSE data_type
           END                                      AS "Type"
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES' -- sempre em MAIÚSCULAS
ORDER BY column_id;

-- Tabela de outro schema: use ALL_TAB_COLUMNS (ou DBA_ com privilégio)
SELECT owner, table_name, column_id, column_name, data_type, data_length, nullable
FROM all_tab_columns
WHERE owner = 'HR'
  AND table_name = 'DEPARTMENTS'
ORDER BY column_id;

-- Comandos DQL
select *
from EMPLOYEES;

select DEPARTMENT_ID, LOCATION_ID
from DEPARTMENTS;

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES;

-- Utilizando operadores aritméticos
select FIRST_NAME,
       LAST_NAME,
       SALARY,
       SALARY * 1.15 as Salario -- as, aliás para nomes
from EMPLOYEES;

-- Regras de precedências
select FIRST_NAME,
       LAST_NAME,
       SALARY,
       (SALARY + 100) * 1.15 as Salario
from EMPLOYEES
    fetch first 10 rows only;           -- retorna apenas 10 primeiros valores


-- Utilizando valores Nulos em expressões aritméticas
select FIRST_NAME,
       LAST_NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT -- Retorna valor null (vazio)
from EMPLOYEES
    fetch first 10 rows only;

select FIRST_NAME,
       LAST_NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT,
       200000 * COMMISSION_PCT as PercentualdeComissao
from EMPLOYEES
where COMMISSION_PCT is null;
-- Retorna somente o que é null

-- Utilizando operador de concatenação
select FIRST_NAME || ' ' || LAST_NAME || ', data de admissão: ' || HIRE_DATE as "Funcionário"
from EMPLOYEES;

-- Linhas Duplicadas
select distinct
    DEPARTMENT_ID
from
    DEPARTMENTS;

select distinct
    LAST_NAME, FIRST_NAME
from
    EMPLOYEES;
























