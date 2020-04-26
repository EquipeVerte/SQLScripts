--  Script de création de base de données pour le projet de gestion des cinémas.
--  Updated : 26-04-20

USE [CinemaProjectDB];

GO;

CREATE SCHEMA [u];

GO;

CREATE SCHEMA [c];

GO;

CREATE SCHEMA [co];

GO:

CREATE SCHEMA [p];

GO;

CREATE TABLE [u].[User] (
  [Login]           varchar(20) PRIMARY KEY,
  [PasswordHash]    binary(24) NOT NULL,
  [Salt]            binary(24) NOT NULL,
  [HashIterations]  int NOT NULL,
  [NomComplet]      varchar(100) NOT NULL,
  [Type]            char(5) NOT NULL
);

CREATE TABLE [c].[Responsable] (
  [ResponsableID] int identity(1,1) PRIMARY KEY,
  [Nom]           varchar(100) NOT NULL,
  [NumTel]        varchar(100) NOT NULL,
  [Email]         varchar(200) NOT NULL
);

CREATE TABLE [c].[Cinema] (
  [CinemaID]        int identity(1,1) PRIMARY KEY,
  [Nom]             varchar(100) NOT NULL,
  [Adresse]         varchar(200) NOT NULL,
  [EnExploitation]        bit NOT NULL,
  [ResponsableID]   int NOT NULL,
  [Programmateur] varchar(100) NULL,
  CONSTRAINT FK_Cinema_Responsable FOREIGN KEY  ([ResponsableID])
  REFERENCES [c].[Responsable] ([ResponsableID]),
  CONSTRAINT FK_Cinema_User FOREIGN KEY ([Programmateur])
  REFERENCES [u].[User] ([Login])
);

CREATE TABLE [c].[Salle] (
  [SalleID]   int identity(1,1) PRIMARY KEY,
  [Nom]       varchar(100) NOT NULL,
  [TypeEcran] varchar(100) NULL,
  [SystemSon] varchar(100) NULL,
  [EnExploitation]  bit NOT NULL,
  [CinemaID]  int NOT NULL,
  CONSTRAINT  FK_Salle_Cinema FOREIGN KEY ([CinemaID])
  REFERENCES  [c].[Cinema] ([CinemaID])
);

CREATE TABLE [co].[Oeuvre] (
  [Titre]       varchar(200) PRIMARY KEY,
  [Description] varchar(2000) NOT NULL,
  [Annee]       int NOT NULL,
  [RuntimeMins] int NOT NULL,
  [Rating]      decimal(3,1),
  [Votes]       int,
  [Revenue]     decimal(6,2),
  [MetaScore]   int
);

CREATE [co].[Acteur] (
  [Nom] varchar(200) PRIMARY KEY
);

CREATE [co].[Directeur] (
  [Nom] varchar(200) PRIMARY KEY 
);

CREATE [co].[Genre] (
  [Nom] varchar(100) PRIMARY KEY
);

CREATE [co].[OeuvreActeur] (
  [OeuvreTitre]   varchar(200) NOT NULL,
  [ActeurNom]  varchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreActeur] PRIMARY KEY ([OeuvreTitre], [ActeurNom]),
  CONSTRAINT  [FK_OeuvreActeur_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreActeur_Acteur] FOREIGN KEY ([ActeurNom])
  REFERENCES  [co].[Acteur] ([ActeurNom])
);

CREATE [co].[OeuvreDirecteur] (
  [OeuvreTitre]   varchar(200) NOT NULL,
  [DirecteurNom]  varchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreDirecteurr] PRIMARY KEY ([OeuvreTitre], [DirecteurNom]),
  CONSTRAINT  [FK_OeuvreDirecteur_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreDirecteur_Directeur] FOREIGN KEY ([DirecteurNom])
  REFERENCES  [co].[Directeur] ([DirecteurNom])
);

CREATE [co].[OeuvreGenre] (
  [OeuvreTitre]   varchar(200) NOT NULL,
  [GenreNom]  varchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreGenre] PRIMARY KEY ([OeuvreTitre], [GenreNom]),
  CONSTRAINT  [FK_OeuvreGenre_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreGenre_Genre] FOREIGN KEY ([GenreNom])
  REFERENCES  [co].[Genre] ([GenreNom])
);

CREATE TABLE [p].[Seance] (
  [SeanceID]    int         IDENTITY(1,1) PRIMARY KEY,
  [Titre]       varchar(20) NOT NULL,
  [HeureDebut]  datetime    NOT NULL,
  [HeureFin]    datetime    NOT NULL,
  [SalleID]     int         NOT NULL,
  [ContenuID]   int         NULL,
  CONSTRAINT  FK_Seance_Salle FOREIGN KEY (SalleID)
  REFERENCES  [CinemaManagement].[Salle] (SalleID),
  CONSTRAINT  FK_Seance_Contenu FOREIGN KEY (ContenuID)
  REFERENCES  [ContentManagement].[Contenu] (ContenuID)
);

