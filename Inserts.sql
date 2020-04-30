INSERT INTO Responsable (Nom, NumTel, Email) VALUES ('TestResponsable', '5811234567', 'testresp@email.com');

INSERT INTO Cinema (Nom, Adresse, EnExploitation, ResponsableID, Programmateur) VALUES ('Test Cinéma', '200 Rue Lumière, Québec A1B 2C3', 1, 4, NULL);

INSERT INTO Salle (Nom, EnExploitation, CinemaID) VALUES ('1', 1, 1);

INSERT INTO Contenu (Titre, [Description], Annee, RuntimeMins) VALUES ('Test Film', 'A test film.', 2019, 90);

INSERT INTO Seance (Titre, HeureDebut, HeureFin, SalleID, ContenuTitre) VALUES ('Matin', '2020-05-01 09:00:00', '2020-05-01 12:00:00', 1, 'Test Film');

INSERT INTO Seance (Titre, HeureDebut, HeureFin, SalleID, ContenuTitre) VALUES ('Après-Midi', '2020-05-01 12:00:00', '2020-05-01 15:00:00', 1, NULL);