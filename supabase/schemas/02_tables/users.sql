create table if not exists public.users (
  id UUID NOT NULL PRIMARY KEY REFERENCES auth.users(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  role TEXT NOT NULL default 'voluntario'::TEXT,
  nome TEXT NOT NULL,
  telefone TEXT NOT NULL
    CONSTRAINT telefone_valido 
    CHECK (telefone ~ '^[0-9]{10,11}$'),
  cpf TEXT NOT NULL UNIQUE 
    CONSTRAINT cpf_valido 
    CHECK (cpf ~ '^[0-9]{11}$'),
  email TEXT NOT NULL UNIQUE
    CONSTRAINT email_valido 
    CHECK (email ~ '^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$'),
  ativo bool NOT NULL DEFAULT TRUE
);

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;