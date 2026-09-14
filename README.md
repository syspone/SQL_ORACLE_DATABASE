# Estudos de SQL — Oracle Database

Repositório de estudos de SQL no **Oracle Database**, com scripts comentados em português
sobre fundamentos da linguagem e prática de consultas no schema de exemplo **HR**.

**Autor:** Cristian Matias de Souza
**Ferramenta:** DataGrip · **Banco:** Oracle Database 23ai Free (compatível com driver Oracle 19+)

---

## 📁 Estrutura

```
.
├── Fundamentos.sql     # Teoria: tipos de instruções SQL (DML, DDL, DCL, TCL)
└── HR/
    ├── hr.sql          # Criação e carga do schema HR (tabelas, dados e constraints)
    └── Consultas.sql   # Prática de SELECT no schema HR
```

---

## 📌 Conteúdo atual

### `Fundamentos.sql`
Resumo teórico das sublinguagens do SQL:

| Sigla | Nome | Comandos |
|-------|------|----------|
| **DML** | Data Manipulation Language | `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `MERGE` |
| **DDL** | Data Definition Language | `CREATE`, `ALTER`, `DROP`, `RENAME`, `TRUNCATE`, `COMMENT` |
| **DCL** | Data Control Language | `GRANT`, `REVOKE` |
| **TCL** | Transaction Control Language | `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION` |

Inclui observações específicas do Oracle, como o *COMMIT implícito* após DDL/DCL.

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
2. Crie um usuário `HR` no PDB e conecte-se com ele.
3. Execute `HR/hr.sql` para criar e popular as tabelas.
4. Execute as consultas de `HR/Consultas.sql` uma a uma para acompanhar os exemplos.

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

*Última atualização: 13/09/2026*
