/* ============================================================
   Autor: Cristian Matias de Souza
   Arquivo:  CDB/criacao_pdbs.sql
   Banco: CDB (FREE) — conectado como SYS AS SYSDBA no CDB$ROOT
   Descrição: Arquitetura multitenant — criação e administração
              dos Pluggable Databases (PDBs) HR e SQLDB1
   ------------------------------------------------------------
   ATENÇÃO: substitua <senha_...> por senhas reais antes de rodar.
            Nunca versione senhas no Git.
   ============================================================ */


/* ------------------------------------------------------------
   1) Conferências iniciais do CDB
   ------------------------------------------------------------ */

-- Em qual container / usuário estou, e se o banco é CDB
SELECT SYS_CONTEXT('USERENV', 'CON_NAME')     AS container,
       SYS_CONTEXT('USERENV', 'CURRENT_USER') AS usuario,
       cdb
FROM v$database;

-- Quantidade máxima de PDBs permitida (Oracle Free: 16)
SELECT name, value FROM v$parameter WHERE name = 'max_pdbs';

-- Privilégios de PLUGGABLE DATABASE da sessão
SELECT * FROM session_privs WHERE privilege LIKE '%PLUGGABLE%';

-- Datafiles existentes (tamanho atual x máximo)
SELECT file_name, tablespace_name, autoextensible,
       ROUND(bytes / 1024 / 1024)    AS mb_atual,
       ROUND(maxbytes / 1024 / 1024) AS mb_maximo
FROM dba_data_files;


/* ------------------------------------------------------------
   2) Oracle Managed Files (OMF)
   Com db_create_file_dest definido, o Oracle escolhe sozinho o
   nome/local dos datafiles — dispensa FILE_NAME_CONVERT no
   CREATE PLUGGABLE DATABASE.
   ------------------------------------------------------------ */
SELECT value FROM v$parameter WHERE name = 'db_create_file_dest';

ALTER SYSTEM SET db_create_file_dest = '/opt/oracle/oradata' SCOPE = BOTH;


/* ------------------------------------------------------------
   3) PDB HR — schema de exemplo (ver HR/hr.sql)
   ------------------------------------------------------------ */
CREATE PLUGGABLE DATABASE hr
    ADMIN USER hr IDENTIFIED BY "<senha_hr>"
    STORAGE (MAXSIZE 2G);

-- Todo PDB nasce MOUNTED: é preciso abrir
ALTER PLUGGABLE DATABASE hr OPEN;

-- SAVE STATE: reabre o PDB automaticamente quando o CDB reiniciar
ALTER PLUGGABLE DATABASE hr SAVE STATE;

SELECT name, open_mode FROM v$pdbs;
SELECT con_name, instance_name, state FROM dba_pdb_saved_states;


/* ------------------------------------------------------------
   4) PDB SQLDB1 — já criado com tablespace USERS e limite de 4G
   Usuários locais em SQLDB1/usuarios.sql
   ------------------------------------------------------------ */
CREATE PLUGGABLE DATABASE sqldb1
    ADMIN USER gestor IDENTIFIED BY "<senha_gestor>"
    DEFAULT TABLESPACE users DATAFILE SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 2G
    STORAGE (MAXSIZE 4G);

-- Se a sessão ficar presa em outro container, voltar para o root
ALTER SESSION SET CONTAINER = CDB$ROOT;
ROLLBACK;

ALTER PLUGGABLE DATABASE sqldb1 OPEN READ WRITE;
ALTER PLUGGABLE DATABASE sqldb1 SAVE STATE;


/* ------------------------------------------------------------
   5) Visão geral
   ------------------------------------------------------------ */
SELECT con_id, name, open_mode, restricted,
       ROUND(total_size / 1024 / 1024) AS mb
FROM v$pdbs
ORDER BY con_id;

-- Usuários criados (não mantidos pela Oracle) em cada PDB
SELECT p.name AS pdb, u.username, u.default_tablespace, u.account_status
FROM cdb_users u
         JOIN v$pdbs p ON p.con_id = u.con_id
WHERE u.oracle_maintained = 'N'
ORDER BY p.name, u.username;
