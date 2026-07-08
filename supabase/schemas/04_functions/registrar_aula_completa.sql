CREATE OR REPLACE FUNCTION registrar_aula_completa(
    p_turma_id INT,
    p_data DATE,
    p_voluntario UUID,
    p_observacao TEXT,
    p_alunos_presentes INT[]
) RETURNS void AS $$
DECLARE
    v_voluntario_id UUID;
BEGIN
    IF auth.uid() IS NULL THEN
        RAISE EXCEPTION 'Acesso negado: Usuário não autenticado.';
    END IF;
    
    INSERT INTO observacoes (voluntario, turma_id, data, observacao)
    VALUES (p_voluntario, p_turma_id, p_data, p_observacao)
    ON CONFLICT ON CONSTRAINT observacoes_turma_data_key
    DO UPDATE SET
        observacao = EXCLUDED.observacao,
        voluntario = EXCLUDED.voluntario;

    DELETE FROM presencas
    WHERE turma_id = p_turma_id
      AND data = p_data
      AND NOT (aluno_id = ANY(p_alunos_presentes));

    INSERT INTO presencas (aluno_id, turma_id, data)
    SELECT unnest(p_alunos_presentes), p_turma_id, p_data
    ON CONFLICT ON CONSTRAINT presencas_aluno_turma_data_key DO NOTHING;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;