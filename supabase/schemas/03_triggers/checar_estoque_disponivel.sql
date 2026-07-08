CREATE OR REPLACE FUNCTION checar_estoque_disponivel()
RETURNS TRIGGER AS $$
DECLARE
    v_estoque_atual INT;
    v_qtd_desejada INT;
BEGIN
    IF TG_TABLE_NAME = 'emprestimos' THEN
        v_qtd_desejada := 1; 
    ELSIF TG_TABLE_NAME = 'perdas' THEN
        v_qtd_desejada := NEW.quantidade;
    END IF;

    SELECT quantidade_disponivel INTO v_estoque_atual
    FROM public.estoque_kimonos
    WHERE cor = NEW.cor AND tamanho = NEW.tamanho;

    v_estoque_atual := COALESCE(v_estoque_atual, 0);

    IF v_estoque_atual < v_qtd_desejada THEN
        RAISE EXCEPTION 'Estoque insuficiente. Tentou retirar %, mas só há % kimono(s) % tamanho %.', 
            v_qtd_desejada, v_estoque_atual, NEW.cor, NEW.tamanho;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_checar_estoque_emprestimo
BEFORE INSERT ON public.emprestimos
FOR EACH ROW EXECUTE FUNCTION checar_estoque_disponivel();

CREATE TRIGGER trigger_checar_estoque_perda
BEFORE INSERT ON public.perdas
FOR EACH ROW EXECUTE FUNCTION checar_estoque_disponivel();