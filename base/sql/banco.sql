    CREATE TABLE public."TBProjeto"
(
    "IDProjeto"  serial primary key not null,
    "IDTipoProjeto" INTEGER,
    "NRIdentificado" character varying(255) COLLATE pg_catalog."default",
    "NRSigla" character varying(10) COLLATE pg_catalog."default",
    "NRNome" character varying(255) COLLATE pg_catalog."default",  
    "NREspecificador" character varying(2000) COLLATE pg_catalog."default",  
    "DTInicio" date,
    "DTFim" date,
     FOREIGN KEY ( "IDTipoProjeto" ) REFERENCES public."TBTipoProjeto" ("IDTipoProjeto")
);

    CREATE TABLE public."TBTipoProjeto"
(
    "IDTipoProjeto"  serial primary key not null,
    "NRDescricao" character varying(255) COLLATE pg_catalog."default"
);


    CREATE TABLE public."TBProjetoDispendio"
(
    "IDProjetoDispendio"  serial primary key not null,
    "IDProjeto" INTEGER,
    "DTAnoBase" INTEGER,
    "VLRecursosHumanoa" REAL,
    "VLTreinamento" REAL,
    "VLEquipamentoSoftware" REAL,
    "VLLivroPeriodico" REAL,
    "VLObraCivil" REAL,
    "VLViagem" REAL,
    "VLMaterialConsumo" REAL,
    "VLOuroCorrelato" REAL,
    "VLServicoTerceiro" REAL,    
    "VLTotalValido" REAL,    
     FOREIGN KEY ( "IDProjeto" ) REFERENCES public."TBProjeto" ("IDProjeto")
);

INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Hardware');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Hardware com software embarcado');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Melhoria de Processo Produtivo');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Software');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Software Aplicativo');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Formação e Capacitação');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Profissional');
INSERT INTO public."TBTipoProjeto"("NRDescricao")	VALUES ('Outro');
