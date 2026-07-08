CREATE OR REPLACE FUNCTION public.admin_create_user(
    email text,
    senha text,
    role text,
    nome text,
    telefone text,
    cpf text,
    funcao text,
    faixa faixa
) RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    new_user_id uuid;
BEGIN
    IF NOT public.is_admin() THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can create users.';
    END IF;

    INSERT INTO auth.users (
        instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, 
        raw_app_meta_data, raw_user_meta_data, created_at, updated_at, 
        confirmation_token, recovery_token, email_change_token_new, email_change
    ) VALUES (
        '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated', 
        email, extensions.crypt(senha, extensions.gen_salt('bf')), now(),
        '{"provider":"email","providers":["email"]}', '{}', now(), now(), 
        '', '', '', ''
    ) RETURNING id INTO new_user_id;

    INSERT INTO public.users (id, role, nome, telefone, cpf, email, funcao, faixa) 
    VALUES (new_user_id, role, nome, telefone, cpf, email, funcao, faixa)
    ON CONFLICT (id) DO UPDATE SET role = EXCLUDED.role;

    RETURN new_user_id;
END;
$$;