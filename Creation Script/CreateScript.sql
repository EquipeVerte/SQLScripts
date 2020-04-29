--  Script de création de base de données pour le projet de gestion des cinémas.
--  Updated : 26-04-20

USE [CinemaProjectDB];


CREATE TABLE [dbo].[User] (
  [Login]           nvarchar(20) PRIMARY KEY,
  [PasswordHash]    binary(24) NOT NULL,
  [Salt]            binary(24) NOT NULL,
  [HashIterations]  int NOT NULL,
  [NomComplet]      nvarchar(100) NOT NULL,
  [Type]            char(5) NOT NULL
);

CREATE TABLE [dbo].[Responsable] (
  [ResponsableID] int identity(1,1) PRIMARY KEY,
  [Nom]           nvarchar(100) NOT NULL,
  [NumTel]        nvarchar(100) NOT NULL,
  [Email]         nvarchar(200) NOT NULL
);

CREATE TABLE [dbo].[Cinema] (
  [CinemaID]        int identity(1,1) PRIMARY KEY,
  [Nom]             nvarchar(100) NOT NULL,
  [Adresse]         nvarchar(200) NOT NULL,
  [EnExploitation]        bit NOT NULL,
  [ResponsableID]   int NOT NULL,
  [Programmateur] nvarchar(100) NULL,
  CONSTRAINT FK_Cinema_Responsable FOREIGN KEY  ([ResponsableID])
  REFERENCES [dbo].[Responsable] ([ResponsableID]),
  CONSTRAINT FK_Cinema_User FOREIGN KEY ([Programmateur])
  REFERENCES [dbo].[User] ([Login])
);

CREATE TABLE [dbo].[Salle] (
  [SalleID]   int identity(1,1) PRIMARY KEY,
  [Nom]       nvarchar(100) NOT NULL,
  [TypeEcran] nvarchar(100) NULL,
  [SystemSon] nvarchar(100) NULL,
  [EnExploitation]  bit NOT NULL,
  [CinemaID]  int NOT NULL,
  CONSTRAINT  FK_Salle_Cinema FOREIGN KEY ([CinemaID])
  REFERENCES  [c].[Cinema] ([CinemaID])
);

CREATE TABLE [dbo].[Contenu] (
  [Titre]       nvarchar(200) PRIMARY KEY,
  [Description] nvarchar(2000) NOT NULL,
  [Annee]       int NOT NULL,
  [RuntimeMins] int NOT NULL,
  [Rating]      decimal(3,1),
  [Votes]       int,
  [Revenue]     decimal(6,2),
  [MetaScore]   int
);

CREATE [dbo].[Acteur] (
  [Nom] nvarchar(200) PRIMARY KEY
);

CREATE [dbo].[Directeur] (
  [Nom] nvarchar(200) PRIMARY KEY 
);

CREATE [dbo].[Genre] (
  [Nom] nvarchar(100) PRIMARY KEY
);

CREATE [dbo].[ContenuActeur] (
  [ContenuTitre]   nvarchar(200) NOT NULL,
  [ActeurNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_ContenuActeur] PRIMARY KEY ([ContenuTitre], [ActeurNom]),
  CONSTRAINT  [FK_ContenuActeur_Contenu] FOREIGN KEY ([ContenuTitre])
  REFERENCES  [dbo].[Contenu] ([ContenuTitre]),
  CONSTRAINT  [FK_ContenuActeur_Acteur] FOREIGN KEY ([ActeurNom])
  REFERENCES  [dbo].[Acteur] ([Nom])
);

CREATE [dbo].[ContenuDirecteur] (
  [ContenuTitre]   nvarchar(200) NOT NULL,
  [DirecteurNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_ContenuDirecteurr] PRIMARY KEY ([ContenuTitre], [DirecteurNom]),
  CONSTRAINT  [FK_ContenuDirecteur_Contenu] FOREIGN KEY ([ContenuTitre])
  REFERENCES  [dbo].[Contenu] ([ContenuTitre]),
  CONSTRAINT  [FK_ContenuDirecteur_Directeur] FOREIGN KEY ([DirecteurNom])
  REFERENCES  [dbo].[Directeur] ([Nom])
);

CREATE [dbo].[ContenuGenre] (
  [ContenuTitre]   nvarchar(200) NOT NULL,
  [GenreNom]  nvarchar(200) NOT NULL,
  CONSTRAINT  [PK_ContenuGenre] PRIMARY KEY ([ContenuTitre], [GenreNom]),
  CONSTRAINT  [FK_ContenuGenre_Contenu] FOREIGN KEY ([ContenuTitre])
  REFERENCES  [dbo].[Contenu] ([ContenuTitre]),
  CONSTRAINT  [FK_ContenuGenre_Genre] FOREIGN KEY ([GenreNom])
  REFERENCES  [dbo].[Genre] ([Nom])
);

CREATE TABLE [dbo].[Seance] (
  [SeanceID]    int         IDENTITY(1,1) PRIMARY KEY,
  [Titre]       nvarchar(20) NOT NULL,
  [HeureDebut]  datetime    NOT NULL,
  [HeureFin]    datetime    NOT NULL,
  [SalleID]     int         NOT NULL,
  [ContenuTitre]   nvarchar(200)         NULL,
  CONSTRAINT  FK_Seance_Salle FOREIGN KEY (SalleID)
  REFERENCES  [dbo].[Salle] (SalleID),
  CONSTRAINT  FK_Seance_Contenu FOREIGN KEY (ContenuTitre)
  REFERENCES  [dbo].[Contenu] (ContenuTitre)
);

