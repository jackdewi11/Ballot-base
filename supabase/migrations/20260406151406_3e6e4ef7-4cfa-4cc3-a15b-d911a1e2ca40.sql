
CREATE OR REPLACE FUNCTION public.search_students(_query text, _limit integer DEFAULT 5)
RETURNS TABLE(id uuid, full_name text, email text)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT p.id, p.full_name, p.email
  FROM public.profiles p
  INNER JOIN public.user_roles ur ON ur.user_id = p.id
  WHERE ur.role = 'student'
    AND p.full_name ILIKE '%' || _query || '%'
  LIMIT _limit;
$$;
