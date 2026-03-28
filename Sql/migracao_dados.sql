CREATE TABLE alunos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE,
    status VARCHAR(20),
    cpf VARCHAR(20),
    cpf_valido BIT
);

INSERT INTO alunos (id, nome, data_nascimento, status, cpf, cpf_valido)
SELECT 
    CAST(id_aluno AS INT),
    nome,
    TRY_CAST(data_nasc AS DATE),
    status,
    cpf,
    cpf_valido
FROM alunos_legado;