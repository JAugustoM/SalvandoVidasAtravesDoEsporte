CREATE OR REPLACE FUNCTION public.admin_update_user(
    p_id uuid,
    p_email text DEFAULT NULL,
    p_senha text DEFAULT NULL,
    p_nome text DEFAULT NULL,
    p_telefone text DEFAULT NULL,
    p_cpf text DEFAULT NULL,
    p_funcao text DEFAULT NULL,
    p_faixa faixa DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    IF auth.uid() IS NULL THEN
        RAISE EXCEPTION 'Acesso negado: Usuário não autenticado.';
    END IF;

    IF p_email IS NOT NULL THEN
        UPDATE auth.users SET email = p_email WHERE id = p_id;
        UPDATE public.users SET email = p_email WHERE id = p_id;
    END IF;

    IF p_senha IS NOT NULL THEN
        UPDATE auth.users
        SET encrypted_password = extensions.crypt(p_senha, extensions.gen_salt('bf')),
            updated_at = now()
        WHERE id = p_id;
    END IF;

    IF p_nome IS NOT NULL THEN
        UPDATE public.users SET nome = p_nome WHERE id = p_id;
    END IF;

    IF p_telefone IS NOT NULL THEN
        UPDATE public.users SET telefone = p_telefone WHERE id = p_id;
    END IF;

    IF p_cpf IS NOT NULL THEN
        UPDATE public.users SET cpf = p_cpf WHERE id = p_id;
    END IF;

    IF p_funcao IS NOT NULL THEN
        UPDATE public.users SET funcao = p_funcao WHERE id = p_id;
    END IF;

    IF p_faixa IS NOT NULL THEN
        UPDATE public.users SET faixa = p_faixa WHERE id = p_id;
    END IF;
END;
$$;