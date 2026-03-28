SELECT COUNT(*) as Contagem_CPF_Invalido
FROM alunos_legado
WHERE cpf_valido = 0;

SELECT COUNT(*) as Data_Invalida
FROM alunos_legado
WHERE data_nasc < '1900-01-01'
   OR data_nasc > GETDATE();

SELECT COUNT(*) as Nome_Invalido
FROM alunos_legado
WHERE nome LIKE '%@%'
   OR nome LIKE '%!%';

SELECT status, COUNT(*) as quant_status
FROM alunos_legado
GROUP BY status;