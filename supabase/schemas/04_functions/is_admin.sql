CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT 
    current_user IN ('postgres', 'service_role') 
    OR 
    EXISTS (
      SELECT 1 FROM public.users
      WHERE id = auth.uid() AND role = 'admin' AND ativo = true
    );
$$;

CREATE POLICY "Admins can insert users" ON public.users FOR INSERT WITH CHECK (public.is_admin());
CREATE POLICY "Admins can update users" ON public.users FOR UPDATE USING (public.is_admin());
CREATE POLICY "Admins can delete users" ON public.users FOR DELETE USING (public.is_admin());
CREATE POLICY "Users can view all users" ON public.users FOR SELECT TO authenticated USING (true);