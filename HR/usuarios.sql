/* ============================================================
   Autor: Cristian Matias de Souza
   Arquivo:  HR/usuarios.sql
   Banco: HR (PDB) — conectado como SYS
   Descrição: Usuário PRODUTOS dentro do PDB HR e verificações
              de sessão/privilégios
   ------------------------------------------------------------
   ATENÇÃO: substitua <senha_produtos> antes de rodar.
   ============================================================ */

-- Garante que a sessão está no PDB certo, e não no CDB$ROOT
ALTER SESSION SET CONTAINER = hr;

SELECT SYS_CONTEXT('USERENV', 'SESSION_USER')   AS quem_sou,
       SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS schema_padrao,
       SYS_CONTEXT('USERENV', 'CON_NAME')       AS container,
       SYS_CONTEXT('USERENV', 'ISDBA')          AS eh_dba
FROM dual;

-- Usuário PRODUTOS: dono de schema, com privilégios básicos de desenvolvimento
CREATE USER produtos IDENTIFIED BY "<senha_produtos>"
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW,
    CREATE SEQUENCE, CREATE PROCEDURE TO produtos;

-- Conferências
SELECT tablespace_name, contents, status FROM dba_tablespaces ORDER BY 1;

SELECT username, default_tablespace, account_status
FROM dba_users
WHERE oracle_maintained = 'N'
ORDER BY 1;


/* ------------------------------------------------------------
   Conectado como HR: o que o usuário pode fazer?
   ------------------------------------------------------------ */
SELECT 'PRIV: ' || privilege AS info FROM user_sys_privs
UNION ALL SELECT 'ROLE: ' || granted_role FROM user_role_privs
UNION ALL SELECT 'QUOTA: ' || tablespace_name || ' = ' || max_bytes FROM user_ts_quotas
UNION ALL SELECT 'DEFAULT_TS: ' || default_tablespace FROM user_users;

-- Conferência da carga do hr.sql
SELECT 'regions      = ' || (SELECT COUNT(*) FROM regions) AS contagem FROM dual
UNION ALL SELECT 'countries    = ' || (SELECT COUNT(*) FROM countries) FROM dual
UNION ALL SELECT 'locations    = ' || (SELECT COUNT(*) FROM locations) FROM dual
UNION ALL SELECT 'departments  = ' || (SELECT COUNT(*) FROM departments) FROM dual
UNION ALL SELECT 'jobs         = ' || (SELECT COUNT(*) FROM jobs) FROM dual
UNION ALL SELECT 'employees    = ' || (SELECT COUNT(*) FROM employees) FROM dual
UNION ALL SELECT 'job_history  = ' || (SELECT COUNT(*) FROM job_history) FROM dual
UNION ALL SELECT 'FKs ativas   = ' || (SELECT COUNT(*) FROM user_constraints
                                       WHERE constraint_type = 'R' AND status = 'ENABLED') FROM dual;
