DROP TABLE IF EXISTS "TBDispendioEquipamentoSoftware"
CASCADE;
DROP TABLE IF EXISTS "TBDispendioRecursosHumano"
CASCADE;
DROP TABLE IF EXISTS "TBProjeto"
CASCADE;
DROP TABLE IF EXISTS "TBProjetoConveniado"
CASCADE;
DROP TABLE IF EXISTS "TBTipoProjeto"
CASCADE;
DROP TABLE IF EXISTS "TBAreaAplicacao"
CASCADE;
DROP TABLE IF EXISTS "TBInstituicao"
CASCADE;
DROP TABLE IF EXISTS "TBFormacao"
CASCADE;
DROP TABLE IF EXISTS "TBTipoDispendio"
CASCADE;
DROP TABLE IF EXISTS "TBEscolaridade"
CASCADE;
DROP TABLE IF EXISTS "TBEstrangeiro"
CASCADE;
DROP TABLE IF EXISTS "TBTipoApropriacao"
CASCADE;



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
    "NRNome" VARCHAR(50),
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

CREATE TABLE "TBTipoApropriacao"
(
    "CDTipoApropriacao" serial primary key not null,
    "TPProjeto" VARCHAR(50),
    "NOTipoApropriacao" VARCHAR(50)
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
    "IDProjetoConveniado" INTEGER,
    "IDHistoricoPessoaColaborador" INTEGER,
    "NRFormacaoEspecifica" varchar(50),
    "NRHorasTrabalhadas" varchar(8),
    "DTInicioAtuacao" date,
    "DTFinalAtuacao" date,
    "VLRecurso" numeric,
    "DSAtuacaoProjeto" TEXT,
    FOREIGN KEY ( "CDTipoDispendio" ) REFERENCES "TBTipoDispendio" ("CDTipoDispendio"),
    FOREIGN KEY ( "CDEscolaridade" ) REFERENCES "TBEscolaridade" ("CDEscolaridade"),
    FOREIGN KEY ( "CDFormacao" ) REFERENCES "TBFormacao" ("CDFormacao"),
    FOREIGN KEY ( "IDProjeto" ) REFERENCES "TBProjeto" ("IDProjeto"),
    FOREIGN KEY ( "IDProjetoConveniado" ) REFERENCES "TBProjetoConveniado" ("IDProjetoConveniado"),
    FOREIGN KEY ( "IDEstrangeiro" ) REFERENCES "TBEstrangeiro" ("IDEstrangeiro")
);

CREATE TABLE "TBDispendioEquipamentoSoftware"
(
    "IDDispendioEquipamentoSoftware" serial primary key not null,
    "IDProjeto" INTEGER,
    "IDProjetoConveniado" INTEGER,
    "CDTipoDispendio" INTEGER,
    "DSTipoDispendio" VARCHAR(100),
    "CDTipoApropriacao" INTEGER,
    "DSOutrosTipoApropriacao" VARCHAR(50),
    "VLDispendio" NUMERIC,
    "VLDepreciacao" NUMERIC,
    "DTAquisicao" DATE,
    "DSJustificativa" TEXT,
    FOREIGN KEY ( "CDTipoDispendio" ) REFERENCES "TBTipoDispendio" ("CDTipoDispendio"),
    FOREIGN KEY ( "CDTipoApropriacao" ) REFERENCES "TBTipoApropriacao" ("CDTipoApropriacao"),
    FOREIGN KEY ( "IDProjeto" ) REFERENCES "TBProjeto" ("IDProjeto"),
    FOREIGN KEY ( "IDProjetoConveniado" ) REFERENCES "TBProjetoConveniado" ("IDProjetoConveniado")
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
    ("NOTipoDispendio", "TPDispendio")
VALUES
    ('RH Direto', 1);
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio", "TPDispendio")
VALUES
    ('RH Indireto', 1 );
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio", "TPDispendio")
VALUES
    ('Software', 2);
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio", "TPDispendio")
VALUES
    ('Equipamento- TICs', 2);
INSERT INTO "TBTipoDispendio"
    ("NOTipoDispendio", "TPDispendio")
VALUES
    ('Equipamento- Outros', 2);

-- Tipo apropriação
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Licença anual');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Licença mensal');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Licença perpétua/vitalícia');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Aluguel');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Aquisição');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Cessão');
INSERT INTO "TBTipoApropriacao"
    ("NOTipoApropriacao")
VALUES
    ('Outro');
