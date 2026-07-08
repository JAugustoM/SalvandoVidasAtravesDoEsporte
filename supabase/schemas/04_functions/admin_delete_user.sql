CREATE OR REPLACE FUNCTION public.admin_delete_user(id uuid)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    IF NOT public.is_admin() THEN
        RAISE EXCEPTION 'Apenas usuários admin podem deletar outros usuários.';
    END IF;
    
    DELETE FROM auth.users WHERE id = id;
END;
$$;