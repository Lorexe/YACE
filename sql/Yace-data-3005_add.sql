USE yace;

--Musique
INSERT INTO `yattribute` (`name`, `type`, `no_order`, `many`, `itemtype`) VALUES
('cover', 'Image', 1, 0, 2),
('Artiste', 'String', 2, 0, 2),
('Nom', 'String', 3, 1, 2),
('Date de sortie', 'Date', 4, 0, 2),
('Tracklist', 'String', 5, 1, 2),
('Date de sortie', 'String', 6, 0, 2);

--Livre
INSERT INTO `yattribute` (`name`, `type`, `no_order`, `many`, `itemtype`) VALUES
('cover', 'Image', 1, 0, 3),
('Auteur', 'String', 2, 0, 3),
('Titre', 'String', 3, 1, 3),
('Résumé', 'Date', 4, 1, 3),
('Editeur', 'String', 5, 0, 3),
('Date de sortie', 'String', 6, 0, 3),
('Nombre de pages', 'Int', 7, 0, 3);


