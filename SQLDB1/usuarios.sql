/* ============================================================
   Autor: Cristian Matias de Souza
   Arquivo:  SQLDB1/usuarios.sql
   Banco: SQLDB1 — conectado como SYS no CDB, sessão dentro do PDB
   Descrição: Usuários locais do PDB SQLDB1 (GESTOR e USR1)
   ------------------------------------------------------------
   ATENÇÃO: substitua <senha_usr1> antes de rodar.
   ============================================================ */

-- Os comandos abaixo precisam rodar DENTRO do PDB
ALTER SESSION SET CONTAINER = sqldb1;

SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS container FROM dual;

--------------------------------------------------------------------------------
-- GESTOR x USR1: dois usuários locais do SQLDB1, com papéis diferentes
--
-- GESTOR -> administrador do PDB. Criado pela cláusula ADMIN USER do CREATE
--           PLUGGABLE DATABASE (ver CDB/criacao_pdbs.sql), já com o role
--           PDB_DBA. É a conta que administra o SQLDB1 sem precisar do SYS:
--           cria usuários, concede privilégios, gerencia tablespaces.
--           Não é dono de tabelas.
--
-- USR1   -> usuário de aplicação / dono do schema. Sem poder administrativo:
--           recebe apenas os privilégios listados no GRANT abaixo e é dono dos
--           objetos que criar (tabelas, views, sequences) no schema USR1.
--           É com ele que a aplicação se conecta no dia a dia.
--
-- Ambos existem SOMENTE dentro do SQLDB1 (usuários locais). Quem é dono do
-- container em si continua sendo o SYS.
--------------------------------------------------------------------------------

-- PDB_DBA sozinho vem bem limitado; DBA dá ao gestor poderes administrativos locais
GRANT DBA TO gestor;

CREATE USER usr1 IDENTIFIED BY "<senha_usr1>"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users
    ACCOUNT UNLOCK;

GRANT CREATE SESSION,
    CREATE TABLE, CREATE VIEW, CREATE SEQUENCE,
    CREATE PROCEDURE, CREATE TRIGGER, CREATE SYNONYM,
    CREATE TYPE, CREATE MATERIALIZED VIEW
    TO usr1;
