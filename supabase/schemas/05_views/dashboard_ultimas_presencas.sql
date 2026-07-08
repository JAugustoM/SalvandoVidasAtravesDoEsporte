CREATE OR REPLACE VIEW dashboard_ultimas_presencas 
WITH (security_invoker = true)
AS
SELECT 
    a.id AS aluno_id,
    a.nome AS aluno_nome,
    MAX(p.data) AS data_ultima_presenca,
    CASE 
        WHEN MAX(p.data) IS NOT NULL THEN CURRENT_DATE - MAX(p.data)
        ELSE NULL
    END AS dias_desde_ultima_presenca
FROM 
    public.alunos a
LEFT JOIN 
    public.presencas p ON a.id = p.aluno_id
GROUP BY 
    a.id, a.nome;