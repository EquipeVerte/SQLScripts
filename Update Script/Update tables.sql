ALTER TABLE [dbo].[Contenu]
	ADD typage VARCHAR(100) NULL;

UPDATE [dbo].[Contenu]
	SET typage = 'standard'

CREATE TABLE [dbo].[ContenuPromo] (
  [Titre]   nvarchar(200)  NOT NULL PRIMARY KEY,
  [RuntimeMins] int NOT NULL,
);

CREATE TABLE [dbo].[SeanceContenu] (
  [ContenuTitre]   nvarchar(200) NOT NULL,
  [SeanceID]       int NOT NULL,
  [indexOrdre]     int NULL,
  [estPrincipal]   bit NULL,
  CONSTRAINT  [PK_ContenuSeance] PRIMARY KEY ([ContenuTitre], [SeanceID]),
  CONSTRAINT  [FK_ContenuSeance_Contenu] FOREIGN KEY ([ContenuTitre])
  REFERENCES  [dbo].[Contenu] ([Titre]),
  CONSTRAINT  [FK_ContenuSeance_Seance] FOREIGN KEY ([SeanceID])
  REFERENCES  [dbo].[Seance] ([SeanceID])
);
							       
INSERT INTO SeanceContenu (ContenuTitre, SeanceID, indexOrdre, estPrincipal)
	SELECT ContenuTitre, SeanceID, 1, 1 FROM Seance WHERE ContenuTitre IS NOT NULL;		
							    
-- Supprimer la colonne qui n'est plus utilisée.
ALTER TABLE [Seance]
  DROP COLUMN [ContenuTitre];

CREATE TABLE [dbo].[SeancePromo] (
  [PromoTitre]   nvarchar(200) NOT NULL,
  [SeanceID]     int NOT NULL,
  [indexOrdre]   int NULL,
  CONSTRAINT  [PK_PromoSeance] PRIMARY KEY ([PromoTitre], [SeanceID]),
  CONSTRAINT  [FK_PromoSeance_Promo] FOREIGN KEY ([PromoTitre])
  REFERENCES  [dbo].[ContenuPromo] ([Titre]),
  CONSTRAINT  [FK_PromoSeance_Seance] FOREIGN KEY ([SeanceID])
  REFERENCES  [dbo].[Seance] ([SeanceID])
);
