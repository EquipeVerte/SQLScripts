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
  [Login]           nvarchar(20) PRIMARY KEY,
  [PasswordHash]    binary(24) NOT NULL,
  [Salt]            binary(24) NOT NULL,
  [HashIterations]  int NOT NULL,
  [NomComplet]      nvarchar(100) NOT NULL,
  [Type]            char(5) NOT NULL
);

CREATE TABLE [c].[Responsable] (
  [ResponsableID] int identity(1,1) PRIMARY KEY,
  [Nom]           nvarchar(100) NOT NULL,
  [NumTel]        nvarchar(100) NOT NULL,
  [Email]         nvarchar(200) NOT NULL
);

CREATE TABLE [c].[Cinema] (
  [CinemaID]        int identity(1,1) PRIMARY KEY,
  [Nom]             nvarchar(100) NOT NULL,
  [Adresse]         nvarchar(200) NOT NULL,
  [IsActive]        bit NOT NULL,
  [ResponsableID]   int NOT NULL,
  [ProgrammerLogin] nvarchar(100) NULL,
  CONSTRAINT FK_Cinema_Responsable FOREIGN KEY  ([ResponsableID])
  REFERENCES [c].[Responsable] ([ResponsableID]),
  CONSTRAINT FK_Cinema_User FOREIGN KEY ([ProgrammerLogin])
  REFERENCES [u].[User] ([Login])
);

CREATE TABLE [c].[Salle] (
  [SalleID]   int identity(1,1) PRIMARY KEY,
  [Nom]       nvarchar(100) NOT NULL,
  [TypeEcran] nvarchar(100) NULL,
  [SystemSon] nvarchar(100) NULL,
  [IsActive]  bit NOT NULL,
  [CinemaID]  int NOT NULL,
  CONSTRAINT  FK_Salle_Cinema FOREIGN KEY ([CinemaID])
  REFERENCES  [c].[Cinema] ([CinemaID])
);

CREATE TABLE [co].[Oeuvre] (
  [Titre]       nvarchar(200) PRIMARY KEY,
  [Description] nvarchar(2000) NOT NULL,
  [Annee]       int NOT NULL,
  [RuntimeMins] int NOT NULL,
  [Rating]      decimal(3,1),
  [Votes]       int,
  [Revenue]     decimal(6,2),
  [MetaScore]   int
);

CREATE [co].[Acteur] (
  [Nom] nvarchar(200) PRIMARY KEY
);

CREATE [co].[Directeur] (
  [Nom] nvarchar(200) PRIMARY KEY 
);

CREATE [co].[Genre] (
  [Nom] nvarchar(100) PRIMARY KEY
);

CREATE [co].[OeuvreActeur] (
  [OeuvreTitre]   nvarchar(200) NOT NULL,
  [ActeurNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreActeur] PRIMARY KEY ([OeuvreTitre], [ActeurNom]),
  CONSTRAINT  [FK_OeuvreActeur_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreActeur_Acteur] FOREIGN KEY ([ActeurNom])
  REFERENCES  [co].[Acteur] ([ActeurNom])
);

CREATE [co].[OeuvreDirecteur] (
  [OeuvreTitre]   nvarchar(200) NOT NULL,
  [DirecteurNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreDirecteurr] PRIMARY KEY ([OeuvreTitre], [DirecteurNom]),
  CONSTRAINT  [FK_OeuvreDirecteur_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreDirecteur_Directeur] FOREIGN KEY ([DirecteurNom])
  REFERENCES  [co].[Directeur] ([DirecteurNom])
);

CREATE [co].[OeuvreGenre] (
  [OeuvreTitre]   nvarchar(200) NOT NULL,
  [GenreNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_OeuvreGenre] PRIMARY KEY ([OeuvreTitre], [GenreNom]),
  CONSTRAINT  [FK_OeuvreGenre_Oeuvre] FOREIGN KEY ([OeuvreTitre])
  REFERENCES  [co].[Oeuvre] ([Titre]),
  CONSTRAINT  [FK_OeuvreGenre_Genre] FOREIGN KEY ([GenreNom])
  REFERENCES  [co].[Genre] ([GenreNom])
);

CREATE TABLE [p].[Seance] (
  [SeanceID]    int         IDENTITY(1,1) PRIMARY KEY,
  [Titre]       nvarchar(20) NOT NULL,
  [HeureDebut]  datetime    NOT NULL,
  [HeureFin]    datetime    NOT NULL,
  [SalleID]     int         NOT NULL,
  [ContenuID]   int         NULL,
  CONSTRAINT  FK_Seance_Salle FOREIGN KEY (SalleID)
  REFERENCES  [CinemaManagement].[Salle] (SalleID),
  CONSTRAINT  FK_Seance_Contenu FOREIGN KEY (ContenuID)
  REFERENCES  [ContentManagement].[Contenu] (ContenuID)
);

