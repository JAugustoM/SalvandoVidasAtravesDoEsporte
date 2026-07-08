CREATE OR REPLACE VIEW public.estoque_kimonos
WITH (security_invoker = true)
AS
SELECT 
    cor, 
    tamanho, 
    SUM(alteracao) AS quantidade_disponivel
FROM (
    SELECT cor, tamanho, quantidade AS alteracao 
    FROM doacoes

    UNION ALL

    SELECT cor, tamanho, -1 AS alteracao 
    FROM emprestimos 
    WHERE data_devolucao IS NULL

    UNION ALL

    SELECT cor, tamanho, -quantidade AS alteracao 
    FROM perdas
) AS movimentacoes
GROUP BY cor, tamanho
HAVING SUM(alteracao) > 0;