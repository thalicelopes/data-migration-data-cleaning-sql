/*Alteração na tabela para inserir flag para verificar quais cpf's estão inválidos, no caso, se estão nulos ou vazios*/
ALTER TABLE alunos_legado
ADD cpf_valido BIT;

UPDATE alunos_legado
SET cpf_valido = CASE
    WHEN cpf IS NULL OR cpf = '' THEN 0
    ELSE 1
END;

/*Alteração na tabela para setar o campo data_nasc para NULL caso a data esteja inválida*/
UPDATE alunos_legado
SET data_nasc = NULL
WHERE data_nasc < '1900-01-01'
   OR data_nasc > GETDATE();

/*Alteração na tabela para ajustar o nome dos alunos, removendo @ e !*/
UPDATE alunos_legado
SET nome = 
    REPLACE(REPLACE(nome, '@', ''), '!', '');

/*Alteração na tabela para ajustar o status e padronizar, deixando sempre como ATIVO ou INATIVO*/
UPDATE alunos_legado
SET status = CASE
    WHEN LOWER(status) IN ('ativo', 'a') THEN 'ATIVO'
    WHEN LOWER(status) IN ('inativo', 'i') THEN 'INATIVO'
    ELSE 'DESCONHECIDO'
END;

/*Alteração na tabela para remover os pontos e traços do cpf*/
UPDATE alunos_legado
SET cpf = REPLACE(REPLACE(REPLACE(cpf, '.', ''), '-', ''), ' ', '');
