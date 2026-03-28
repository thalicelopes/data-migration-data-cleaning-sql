/*Contagem total de alunos, aproximadamente 1000*/
SELECT COUNT(*) FROM alunos_legado;

/*Verificação de Status, aparecem quatro, que serão ajustados para ATIVO e INATIVO*/
SELECT status, COUNT(*) as quantidade
FROM alunos_legado
GROUP BY status
ORDER BY quantidade DESC;

/*Verificação de CPF, caso esteja nulo ou vazio*/
SELECT COUNT(*) as cpf_nulo
FROM alunos_legado
WHERE cpf IS NULL OR  cpf = '';

/*Contagem de datas inválidas*/
SELECT COUNT(*) as datas_invalidas
FROM alunos_legado
WHERE data_nasc < '1900-01-01'
   OR data_nasc > GETDATE();

/*Verificação de nomes inválidos*/
SELECT nome
FROM alunos_legado
WHERE nome LIKE '%@%'
   OR nome LIKE '%!%';

/*Percentual de Cpf's Inválidos*/
SELECT 
    COUNT(*) as total,
    SUM(CASE WHEN cpf IS NULL OR cpf = '' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as perc_cpf_invalido
FROM alunos_legado;