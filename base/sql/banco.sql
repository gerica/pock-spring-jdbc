DROP TABLE public."TBProjeto";
CREATE TABLE public."TBProjeto"
(
    "IDProjeto" serial primary key not null,
    "IDTipoProjeto" INTEGER,
    "NRIdentificado" character varying(255) COLLATE pg_catalog
    ."default",
    "NRSigla" character varying
    (10) COLLATE pg_catalog."default",
    "NRNome" character varying
    (255) COLLATE pg_catalog."default",  
    "NREspecificador" character varying
    (2000) COLLATE pg_catalog."default",  
    "DTInicio" date,
    "DTFim" date,
    "BLTrocaPPBparaPD" VARCHAR
    (3),
    "NRAlcance" varchar
    (20),
    "NRGrauInovacaoG1" varchar
    (60),
    "NRGrauInovacaoG2" varchar
    (60),
    "IDAreaAplicacao" INTEGER,
    "BLPropriedadeIntelectual" VARCHAR
    (3),
    "BLPublicacao" VARCHAR
    (3),
    "QDQuantidadePublicacao" INTEGER,
    "CKArtigoI" boolean,
    "CKArtigoII" boolean,
    "CKArtigoIII" boolean,
    "CKArtigoIV" boolean,
    "CKArtigoIVA" boolean,
    "CKArtigoIVB" boolean,
    "CKArtigoIVC" boolean,
    "CKArtigoIV1" boolean,
    "DSObjetivo" text,
    "DSDescricaoEtapa" text,
    "DSResultadoObtido" text,
     FOREIGN KEY
    ( "IDTipoProjeto" ) REFERENCES public."TBTipoProjeto"
    ("IDTipoProjeto"),
     FOREIGN KEY
    ( "IDAreaAplicacao" ) REFERENCES public."TBAreaAplicacao"
    ("IDAreaAplicacao")
);

    CREATE TABLE public."TBTipoProjeto"
    (
        "IDTipoProjeto" serial primary key not null,
        "NRDescricao" character varying(255) COLLATE pg_catalog
        ."default"
);

        CREATE TABLE public."TBProjetoDispendio"
        (
            "IDProjetoDispendio" serial primary key not null,
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


        CREATE TABLE public."TBFormacao"
        (
            "IDFormacao" serial primary key not null,
            "NOFormacao" VARCHAR(255)
        );
        CREATE TABLE public."TBAreaAplicacao"
        (
            "IDAreaAplicacao" serial primary key not null,
            "CDCodigo" INTEGER,
            "NRNome" VARCHAR(255)
        );
        CREATE TABLE public."TBInstituicao"
        (
            "IDInstituicao" serial primary key not null,
            "CDCodigo" INTEGER,
            "NRNome" VARCHAR(255)
        );

        DROP TABLE public."TBProjetoConveniado";
        CREATE TABLE public."TBProjetoConveniado"
        (
            "IDProjeto" serial primary key not null,
            "IDTipoProjeto" INTEGER,
            "NRIdentificado" character varying(255) COLLATE pg_catalog
            ."default",
    "NRSigla" character varying
            (10) COLLATE pg_catalog."default",
    "NRNome" character varying
            (255) COLLATE pg_catalog."default",  
    "NREspecificador" character varying
            (2000) COLLATE pg_catalog."default",  
    "DTInicio" date,
    "DTFim" date,
    "BLTrocaPPBparaPD" VARCHAR
            (3),
    "NRAlcance" varchar
            (20),
    "NRGrauInovacaoG1" varchar
            (60),
    "NRGrauInovacaoG2" varchar
            (60),
    "IDAreaAplicacao" INTEGER,
    "BLPropriedadeIntelectual" VARCHAR
            (3),
    "BLPublicacao" VARCHAR
            (3),
    "QDQuantidadePublicacao" INTEGER,
    "CKArtigoI" boolean,
    "CKArtigoII" boolean,
    "CKArtigoIII" boolean,
    "CKArtigoIV" boolean,
    "CKArtigoIVA" boolean,
    "CKArtigoIVB" boolean,
    "CKArtigoIVC" boolean,
    "CKArtigoIV1" boolean,
    "DSObjetivo" text,
    "DSDescricaoEtapa" text,
    "DSResultadoObtido" text,
     FOREIGN KEY
            ( "IDTipoProjeto" ) REFERENCES public."TBTipoProjeto"
            ("IDTipoProjeto"),
     FOREIGN KEY
            ( "IDAreaAplicacao" ) REFERENCES public."TBAreaAplicacao"
            ("IDAreaAplicacao")
);



            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Hardware');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Hardware com software embarcado');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Melhoria de Processo Produtivo');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Software');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Software Aplicativo');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Formação e Capacitação');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Profissional');
            INSERT INTO public."TBTipoProjeto"
                ("NRDescricao")
            VALUES
                ('Outro');


            -- dados areas apliação
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (1, 'Gerência de Configuração de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (2, 'Gerência de Engenharia de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (3, 'Processo de Engenharia de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (4, 'Ferramentas e Métodos');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (5, 'Qualidade de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (6, 'Requisitos de software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (7, 'Design de software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (8, 'Construção de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (9, 'Teste de Software');
            INSERT INTO public."TBAreaAplicacao"
                ("CDCodigo", "NRNome")
            VALUES
                (10, 'Manutenção de Software');

