/* ============================================================
   Autor: Cristian Matias de Souza
   Empresa: ciruscom informatica
   Arquivo:  Fundamentos.sql
   Criado:   11/09/2026 23:39
   Banco: SQLDB1
   Descrição: Fundamentos
   ============================================================ */


/* ============================================================
   TIPOS DE INSTRUÇÕES SQL (SQL Statement Types)
   ------------------------------------------------------------
   O SQL é dividido em sublinguagens, cada uma com uma finalidade.
   ============================================================

    1) Data Manipulation Language (DML) - Linguagem de Manipulação de Dados
       Consulta e altera os DADOS armazenados nas tabelas.
        ==> SELECT   : consulta (lê) registros
        ==> INSERT   : insere novos registros
        ==> UPDATE   : altera registros existentes
        ==> DELETE   : remove registros
        ==> MERGE    : insere ou atualiza (upsert) conforme uma condição
       Obs.: no Oracle, DML exige COMMIT (confirmar) ou ROLLBACK (desfazer).

    2) Data Definition Language (DDL) - Linguagem de Definição de Dados
       Cria e altera a ESTRUTURA dos objetos do banco (tabelas, views, índices...).
        ==> CREATE   : cria um objeto
        ==> ALTER    : modifica a estrutura de um objeto
        ==> DROP     : exclui um objeto
        ==> RENAME   : renomeia um objeto
        ==> TRUNCATE : remove todos os registros de uma tabela (sem WHERE, sem rollback)
        ==> COMMENT  : adiciona comentários a tabelas/colunas no dicionário de dados
       Obs.: no Oracle, comandos DDL executam COMMIT automático (implícito).

    3) Data Control Language (DCL) - Linguagem de Controle de Dados
       Controla as PERMISSÕES de acesso dos usuários.
        ==> GRANT    : concede privilégios
        ==> REVOKE   : revoga (retira) privilégios

    4) Transaction Control Language (TCL) - Linguagem de Controle de Transações
       Gerencia as TRANSAÇÕES, confirmando ou desfazendo as alterações feitas por DML.
        ==> COMMIT          : confirma (grava definitivamente) as alterações da transação
        ==> ROLLBACK        : desfaz as alterações até o último COMMIT (ou até um SAVEPOINT)
        ==> SAVEPOINT       : cria um ponto intermediário para ROLLBACK parcial
        ==> SET TRANSACTION : define propriedades da transação (ex.: READ ONLY, nível de isolamento)
       Obs.: uma transação começa no primeiro DML e termina com COMMIT, ROLLBACK
             ou um DDL/DCL (que faz COMMIT implícito).

   ============================================================ */

