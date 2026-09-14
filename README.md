# Estudos de SQL — Oracle Database

Repositório de estudos de SQL no **Oracle Database**, com scripts comentados em português
sobre fundamentos da linguagem, administração da arquitetura **multitenant** (CDB/PDBs)
e prática de consultas no schema de exemplo **HR**.

**Autor:** Cristian Matias de Souza
**Ferramenta:** DataGrip · **Banco:** Oracle Database 23ai Free (compatível com driver Oracle 19+)

---

## 📁 Estrutura

```
.
├── LICENSE              # Licença MIT
├── CDB/
│   └── criacao_pdbs.sql # Criação e administração dos PDBs (HR, SQLDB1)
├── HR/
│   ├── hr.sql           # Criação e carga do schema HR (tabelas, dados e constraints)
│   ├── usuarios.sql     # Usuário PRODUTOS e verificações de privilégios
│   └── Consultas.sql    # Prática de SELECT no schema HR
└── SQLDB1/
    ├── usuarios.sql     # Usuários locais GESTOR (admin) e USR1 (aplicação)
    └── Fundamentos.sql  # Teoria: tipos de instruções SQL (DML, DDL, DCL, TCL)
```

### 🧱 Ambiente multitenant

```
CDB (FREE) ── CDB$ROOT ─┬─ PDB HR      → usuários HR, PRODUTOS   · 7 tabelas
                        └─ PDB SQLDB1  → usuários GESTOR, USR1
```

---

## 📌 Conteúdo atual

### `SQLDB1/Fundamentos.sql`
Resumo teórico das sublinguagens do SQL:

| Sigla | Nome | Comandos |
|-------|------|----------|
| **DML** | Data Manipulation Language | `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `MERGE` |
| **DDL** | Data Definition Language | `CREATE`, `ALTER`, `DROP`, `RENAME`, `TRUNCATE`, `COMMENT` |
| **DCL** | Data Control Language | `GRANT`, `REVOKE` |
| **TCL** | Transaction Control Language | `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION` |

Inclui observações específicas do Oracle, como o *COMMIT implícito* após DDL/DCL.

### `CDB/criacao_pdbs.sql`
Administração do container (conectado como `SYS AS SYSDBA` no `CDB$ROOT`):
- Conferências do CDB: `v$database`, `max_pdbs`, datafiles
- *Oracle Managed Files* com `db_create_file_dest`
- `CREATE PLUGGABLE DATABASE` com `ADMIN USER`, `DEFAULT TABLESPACE` e `STORAGE (MAXSIZE)`
- `OPEN READ WRITE` e `SAVE STATE` para o PDB abrir junto com o CDB
- `ALTER SESSION SET CONTAINER` e views `CDB_*` para enxergar todos os PDBs

### `SQLDB1/usuarios.sql`
Diferença entre o **administrador do PDB** (`GESTOR`, com `PDB_DBA` + `DBA`) e o
**usuário de aplicação** (`USR1`, dono do schema com privilégios mínimos de desenvolvimento).

### `HR/usuarios.sql`
Criação do usuário `PRODUTOS` no PDB HR, consultas de contexto da sessão (`SYS_CONTEXT`),
privilégios/quotas do usuário e conferência da carga do schema.

### `HR/hr.sql`
Script para montar o schema de exemplo **HR** da Oracle do zero:
- 7 tabelas: `REGIONS`, `COUNTRIES`, `LOCATIONS`, `DEPARTMENTS`, `JOBS`, `EMPLOYEES`, `JOB_HISTORY`
- Chaves primárias, estrangeiras, `NOT NULL`, `UNIQUE` e `CHECK`
- Carga de dados respeitando a ordem das FKs (pai antes de filho)
- FKs circulares (`DEPARTMENTS` ↔ `EMPLOYEES`) adicionadas ao final, após a carga

### `HR/Consultas.sql`
Exercícios de consulta:
- ✅ Alternativa ao `DESCRIBE` via dicionário de dados (`USER_TAB_COLUMNS` / `ALL_TAB_COLUMNS`)
- ✅ `SELECT` de todas as colunas e de colunas específicas
- ✅ Operadores aritméticos e *aliases* (`AS`)
- ✅ Regras de precedência de operadores
- ✅ Limitando linhas com `FETCH FIRST n ROWS ONLY`
- ✅ Valores `NULL` em expressões aritméticas e `IS NULL`
- ✅ Operador de concatenação (`||`)
- ✅ Eliminando linhas duplicadas com `DISTINCT`

---

## ▶️ Como usar

1. Tenha um Oracle Database rodando (ex.: [Oracle Database Free](https://www.oracle.com/database/free/) ou via Docker `gvenzl/oracle-free`).
2. Como `SYS AS SYSDBA`, execute `CDB/criacao_pdbs.sql` para criar os PDBs.
3. Crie os usuários com `HR/usuarios.sql` e `SQLDB1/usuarios.sql`.
4. Conectado como `HR` no PDB HR, execute `HR/hr.sql` para criar e popular as tabelas.
5. Execute as consultas de `HR/Consultas.sql` uma a uma para acompanhar os exemplos.

> **Senhas:** os scripts usam marcadores como `<senha_hr>`. Troque pelas suas senhas
> localmente e **não** faça commit delas.

> **Dica:** `DESCRIBE` é comando do SQL*Plus e não funciona via JDBC (DataGrip, DBeaver).
> Use a consulta ao dicionário de dados presente em `Consultas.sql`.

---

## 🗺️ Próximos passos

- [ ] Filtros com `WHERE` e operadores de comparação (`BETWEEN`, `IN`, `LIKE`)
- [ ] Ordenação com `ORDER BY`
- [ ] Funções de linha (caractere, número, data, conversão)
- [ ] Funções de grupo, `GROUP BY` e `HAVING`
- [ ] Junções (`JOIN`)
- [ ] Subconsultas
- [ ] DML e controle de transações na prática

---

## 📄 Licença

Distribuído sob a licença **MIT**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

*Última atualização: 13/09/2026*
