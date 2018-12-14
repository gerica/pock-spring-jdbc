DROP TABLE "TBDispendioRecursosHumano";
DROP TABLE "TBProjeto";
DROP TABLE "TBProjetoConveniado";
DROP TABLE "TBTipoProjeto";
DROP TABLE "TBAreaAplicacao";
DROP TABLE "TBInstituicao";
DROP TABLE "TBFormacao";
DROP TABLE "TBTipoDispendio";
DROP TABLE "TBEscolaridade";
DROP TABLE "TBEstrangeiro";


CREATE TABLE "TBTipoProjeto"
(
    "IDTipoProjeto" serial primary key not null,
    "NRDescricao" VARCHAR(255)
);

CREATE TABLE "TBAreaAplicacao"
(
    "IDAreaAplicacao" serial primary key not null,
    "CDCodigo" INTEGER,
    "NRNome" VARCHAR(255)
);


CREATE TABLE "TBInstituicao"
(
    "IDInstituicao" serial primary key not null,
    "CDCodigo" INTEGER,
    "NRNome" VARCHAR(255)
);

CREATE TABLE "TBEstrangeiro"
(
    "IDEstrangeiro" serial primary key not null,
    "NRDispendio" VARCHAR(50),
    "NRNumero" VARCHAR(10),
    "NRPais" VARCHAR(50),
    "DTVencimento" DATE,
    "DTNascimento" DATE,
    "NRSexo" VARCHAR(10)
);


CREATE TABLE "TBFormacao"
(
    "CDFormacao" serial primary key not null,
    "NOFormacao" VARCHAR(50)
);


CREATE TABLE "TBTipoDispendio"
(
    "CDTipoDispendio" serial primary key not null,
    "NOTipoDispendio" VARCHAR(50),
    "TPDispendio" INTEGER
);


CREATE TABLE "TBEscolaridade"
(
    "CDEscolaridade" serial primary key not null,
    "NOEscolaridade" VARCHAR(50)
);


CREATE TABLE "TBProjeto"
(
    "IDProjeto" serial primary key not null,
    "IDTipoProjeto" INTEGER,
    -- "NRIdentificado" VARCHAR (255),
    "NRSigla" VARCHAR(10),
    "NRNome" VARCHAR(255),
    "NREspecificador" VARCHAR(2000),
    "DTInicio" date,
    "DTFim" date,
    "BLTrocaPPBparaPD" VARCHAR(3),
    "NRAlcance" VARCHAR(20),
    "NRGrauInovacaoG1" VARCHAR(60),
    "NRGrauInovacaoG2" VARCHAR(60),
    "IDAreaAplicacao" INTEGER,
    "BLPropriedadeIntelectual" VARCHAR(3),
    "BLPublicacao" VARCHAR(3),
    "QDQuantidadePublicacao" INTEGER,
    "CKArtigoI" boolean,
    "CKArtigoII" boolean,
    "CKArtigoIII" boolean,
    "CKArtigoIV" boolean,
    "CKArtigoIVA" boolean,
    "CKArtigoIVB" boolean,
    "CKArtigoIVC" boolean,
    "CKArtigoIV1" boolean,
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
    "DSObjetivo" text,
    "DSDescricaoEtapa" text,
    "DSResultadoObtido" text,
    FOREIGN KEY ( "IDTipoProjeto" ) REFERENCES "TBTipoProjeto" ("IDTipoProjeto"),
    FOREIGN KEY ( "IDAreaAplicacao" ) REFERENCES "TBAreaAplicacao" ("IDAreaAplicacao")
);

CREATE TABLE "TBProjetoConveniado"
(
    "IDProjetoConveniado" serial primary key not null,
    "IDTipoProjeto" INTEGER,
    "IDInstituicao" INTEGER,
    -- "NRIdentificado" VARCHAR(50),
    "NRSigla" VARCHAR (10),
    "NRNome" VARCHAR (255),
    "NREspecificador" VARCHAR(255),
    "NRRegiao" VARCHAR (50),
    "NREmpresa" VARCHAR(255),
    "NRResponsavel" VARCHAR(255),
    "NREmail" VARCHAR(50),
    "NRTelefone" VARCHAR(20),
    "DTInicio" date,
    "DTFim" date,
    "BLTrocaPPBparaPD" VARCHAR(3),
    "NRAlcance" varchar(20),
    "NRGrauInovacaoG1" varchar(60),
    "NRGrauInovacaoG2" varchar(60),
    "IDAreaAplicacao" INTEGER,
    "BLPropriedadeIntelectual" VARCHAR(3),
    "BLPublicacao" VARCHAR(3),
    "QDQuantidadePublicacao" INTEGER,
    "CKArtigoI" boolean,
    "CKArtigoII" boolean,
    "CKArtigoIII" boolean,
    "CKArtigoIV" boolean,
    "CKArtigoIVA" boolean,
    "CKArtigoIVB" boolean,
    "CKArtigoIVC" boolean,
    "CKArtigoIV1" boolean,
    "DTRepassadoAnoBase" INTEGER,
    "VLRepassadoRecursosHumanoa" REAL,
    "VLRepassadoTreinamento" REAL,
    "VLRepassadoEquipamentoSoftware" REAL,
    "VLRepassadoLivroPeriodico" REAL,
    "VLRepassadoObraCivil" REAL,
    "VLRepassadoViagem" REAL,
    "VLRepassadoMaterialConsumo" REAL,
    "VLRepassadoOuroCorrelato" REAL,
    "VLRepassadoServicoTerceiro" REAL,
    "VLRepassadoCustoInstituicao" REAL,
    "VLRepassadoTotalRepassadoInstituicao" REAL,
    "VLRepassadoAntecipadoProximoAno" REAL,
    "VLRepassadoAntecipadoAnoAnterior" REAL,
    "VLRepassadoTotalDispendio" REAL,
    "VLRepassadoTotalDemaisCustos" REAL,
    "VLRepassadoTotalValido" REAL,
    "DTProprioAnoBase" INTEGER,
    "VLProprioRecursosHumanoa" REAL,
    "VLProprioTreinamento" REAL,
    "VLProprioEquipamentoSoftware" REAL,
    "VLProprioLivroPeriodico" REAL,
    "VLProprioObraCivil" REAL,
    "VLProprioViagem" REAL,
    "VLProprioMaterialConsumo" REAL,
    "VLProprioOuroCorrelato" REAL,
    "VLProprioServicoTerceiro" REAL,
    "VLProprioTotalValido" REAL,
    "DSObjetivo" text,
    "DSDescricaoEtapa" text,
    "DSResultadoObtido" text,
    FOREIGN KEY ( "IDTipoProjeto" ) REFERENCES "TBTipoProjeto" ("IDTipoProjeto"),
    FOREIGN KEY ( "IDInstituicao" ) REFERENCES "TBInstituicao" ("IDInstituicao"),
    FOREIGN KEY ( "IDAreaAplicacao" ) REFERENCES "TBAreaAplicacao" ("IDAreaAplicacao")
);

CREATE TABLE "TBDispendioRecursosHumano"
(
    "IDDispendioRecursosHumano" serial primary key not null,
    "CDTipoDispendio" INTEGER,
    "CDEscolaridade" INTEGER,
    "CDFormacao" INTEGER,
    "IDPessoaColaborador" INTEGER,
    "IDEstrangeiro" INTEGER,
    "IDProjeto" INTEGER,
    "IDHistoricoPessoaColaborador" INTEGER,
    "NRHorasTrabalhadas" varchar(8),
    "DTInicioAtuacao" date,
    "DTFinalAtuacao" date,
    "VLRecurso" numeric,
    "DSAtuacaoProjeto" TEXT,
    FOREIGN KEY ( "CDTipoDispendio" ) REFERENCES "TBTipoDispendio" ("CDTipoDispendio"),
    FOREIGN KEY ( "CDEscolaridade" ) REFERENCES "TBEscolaridade" ("CDEscolaridade"),
    FOREIGN KEY ( "CDFormacao" ) REFERENCES "TBFormacao" ("CDFormacao"),
    FOREIGN KEY ( "IDProjeto" ) REFERENCES "TBProjeto" ("IDProjeto"),
    FOREIGN KEY ( "IDEstrangeiro" ) REFERENCES "TBEstrangeiro" ("IDEstrangeiro")
);


INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Hardware');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Hardware com software embarcado');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Melhoria de Processo Produtivo');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Software');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Software Aplicativo');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Formação e Capacitação');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Profissional');
INSERT INTO "TBTipoProjeto"
    ("NRDescricao")
VALUES
    ('Outro');


-- dados areas apliação
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (1, 'Gerência de Configuração de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (2, 'Gerência de Engenharia de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (3, 'Processo de Engenharia de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (4, 'Ferramentas e Métodos');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (5, 'Qualidade de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (6, 'Requisitos de software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (7, 'Design de software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (8, 'Construção de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (9, 'Teste de Software');
INSERT INTO "TBAreaAplicacao"
    ("CDCodigo", "NRNome")
VALUES
    (10, 'Manutenção de Software');

INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (1, 'Instituto Nacional de Meteorologia (INMET)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (2, 'Instituto Nacional de Tecnologia da Informação ITI)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (3, 'Instituto Nacional de Colonização e Reforma Agrária (INCRA)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (4, 'Instituto Nacional de Metrologia, Qualidade e Tecnologia (Inmetro)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (5, 'Instituto Nacional da Propriedade Industrial (INPI)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (6, 'Instituto Nacional de Estudos e Pesquisas Educacionais (INEP)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (7, 'Instituto do Patrimônio Histórico e Artístico Nacional (IPHAN)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (8, 'Instituto de Pesquisas Energéticas e Nucleares (IPEN)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (9, 'Instituto Nacional do Seguro Social (INSS)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (10, 'Instituto Brasileiro de Museus (Ibram)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (11, 'Instituto de Pesquisa Econômica Aplicada (IPEA)');
INSERT INTO "TBInstituicao"
    ("CDCodigo", "NRNome")
VALUES
    (12, 'Empresa Incubada');


INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Administração');
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Ciências da computação' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Computação' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia aeroespacial' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Automotiva' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De automação e controle' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De computação' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De energia' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De produção' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De redes de comunicações' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De software' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia De telecomunicações' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Elétrica' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Eletrônica' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Mecânica' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Mecatrônica' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Engenharia Química' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Estatística' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Física' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Matemática' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Química' );
INSERT INTO "TBFormacao"
    ("NOFormacao")
VALUES
    ('Outra' );


-- DADOS ESCOLARIDADE
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Ensino Médio');
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Ensino Superior' );
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Especialização' );
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Mestrado' );
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Doutorado' );
INSERT INTO "TBEscolaridade"
    ("NOEscolaridade")
VALUES
    ('Pós Doutorado' );

-- DADOS TIPO DISPENDIO
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio")
VALUES
    ('RH Direto');
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio")
VALUES
    ('RH Indireto' );