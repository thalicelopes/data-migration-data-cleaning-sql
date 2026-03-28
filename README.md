# Projeto de Migração e Qualidade de Dados (SQL)

## Contexto

Este projeto simula um cenário hipotético de migração de dados de um sistema escolar legado que apresenta diversas inconsistências.

O objetivo aqui é transformar um conjunto de dados não confiável em uma base estruturada, padronizada e pronta para uso em sistemas modernos.

---

## Objetivo

- Identificar problemas de qualidade de dados;  
- Aplicar técnicas de limpeza e padronização;  
- Garantir consistência e integridade dos dados;  
- Migrar os dados para uma nova estrutura organizada;  
- Preparar os dados para uso analítico e operacional;  

---

## Visão Geral dos Dados

O dataset contém aproximadamente 1000 registros com inconsistências propositalmente inseridas para simular cenários reais, incluindo:

- Valores ausentes  
- Datas inválidas  
- Identificadores inconsistentes (CPF)  
- Problemas de formatação em campos textuais  

---

## Análise dos Dados

### Principais Problemas Identificados

- **CPFs ausentes:** 98 registros (~9,8%)  
- **Datas de nascimento inválidas:** 682 registros 
- **Nomes com caracteres inválidos:** ~493 registros  

---

## Interpretação dos Problemas

A análise indica que os erros encontrados não são pontuais, mas sim estruturais.

- A alta quantidade de datas inválidas sugere ausência de validação no momento da entrada dos dados  
- A presença de CPF's ausentes indica falta de controle sobre identificadores únicos  
- Os erros em nomes reforçam a hipótese de entrada manual sem padronização adequada 

Esses fatores indicam fragilidade nos processos de governança e qualidade de dados do sistema de origem.

---

## Estratégia de Limpeza de Dados

As seguintes ações foram aplicadas:

- Criação de flag de validação de CPF (`cpf_valido`)  
- Padronização dos valores de status (ATIVO / INATIVO / DESCONHECIDO)  
- Remoção de caracteres inválidos nos nomes  
- Substituição de datas inválidas por NULL  
- Normalização do formato de CPF  

Exemplo de padronização:

UPDATE alunos_legado
SET status = CASE
    WHEN LOWER(status) IN ('ativo','a') THEN 'ATIVO'
    WHEN LOWER(status) IN ('inativo','i') THEN 'INATIVO'
    ELSE 'DESCONHECIDO'
END;

## Processo de Migração

Após o tratamento, os dados foram migrados para uma nova estrutura organizada.

Estrutura criada:

CREATE TABLE alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    status VARCHAR(20),
    cpf VARCHAR(20),
    cpf_valido BIT
);

Inserção dos dados tratados:

INSERT INTO alunos
SELECT 
    CAST(id_aluno AS INT),
    nome,
    TRY_CAST(data_nascimento AS DATE),
    status,
    cpf,
    cpf_valido
FROM alunos_legado;

Os problemas identificados apontam para três falhas principais:

Ausência de validação na entrada dos dados
Falta de governança e controle de qualidade
Inexistência de padronização nos processos de cadastro

## Impacto no Negócio

Caso não tratados, esses problemas poderiam gerar:

- Relatórios imprecisos;
- Falhas em integrações entre sistemas;
- Duplicidade de registros;
- Baixa confiabilidade nos dados;

## Conclusão

A análise revelou um alto nível de inconsistência nos dados, evidenciando problemas estruturais no sistema legado. A grande quantidade de datas inválidas indica ausência de validações adequadas no momento da entrada dos dados, enquanto a presença de CPF's ausentes demonstra falhas na definição de identificadores únicos. Além disso, inconsistências em campos textuais reforçam a hipótese de entrada manual sem controle ou padronização. A abordagem adotada priorizou a preservação dos dados, aplicando correções controladas para melhorar a qualidade sem perda de informações relevantes. Este projeto demonstra como processos estruturados de limpeza, validação e migração são essenciais para transformar dados inconsistentes em informações confiáveis, prontas para uso em análises e sistemas operacionais.

# Habilidades Demonstradas
Limpeza de dados (Data Cleaning)
Validação de dados
SQL (consultas avançadas)
Migração de dados
Pensamento analítico

# Tecnologias Utilizadas
SQL Server
SQL

# Estrutura do Projeto
Sql/
  ├── analise_dados_escola.sql
  ├── criacao_tabela_legada.sql
  ├── insert_dados_legados.sql
  ├── limpeza_dados_escola.sql
  ├── migracao_dados.sql
  └── verificacao_limpeza.sql

Evidências/
  └── dados_apos_ajustes.png
  ├── dataset_antigo.png
  ├── dataset_limpo.png
