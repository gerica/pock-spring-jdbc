INSERT INTO public."TBProjeto2"("NRIdentificado", "NRSigla", "NRNome")
	VALUES ('a', 'b', 'c');
    
    
    CREATE TABLE public."TBProjeto"
(
    "IDProjeto"  serial primary key not null,
    "NRIdentificado" character varying(255) COLLATE pg_catalog."default",
    "NRSigla" character varying(10) COLLATE pg_catalog."default",
    "NRNome" character varying(255) COLLATE pg_catalog."default"    
)