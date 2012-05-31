SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
USE `yacedb`;

--
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`description`, `nb_max_item`, `is_admin`) VALUES
('Administrateur', -1, 1),
('Collectionneur', 1000, 0);

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`email`, `password_hash`, `pseudo`, `rank`) VALUES
('admin@yace.com', '21232f297a57a5a743894ae4a801fc3', 'admin', 1),
('user@user.com', 'ee11cbb19052e4b7aac0ca6c23ee', 'user', 2);
					   
--
-- Contenu de la table `yitemtype`
--

INSERT INTO `yitemtype` (`name`, `is_public`) VALUES
('Film', 1),
('Musique', 1),
('Livre', 1);

--
-- Contenu de la table `yattribute`
--

INSERT INTO `yattribute` (`name`, `type`, `no_order`, `many`, `itemtype`) VALUES
('cover', 'Image', 1, 0, 1),
('Titre', 'String', 2, 0, 1),
('Réalisateur', 'String', 3, 1, 1),
('Auteur', 'String', 4, 1, 1),
('Acteur', 'String', 5, 1, 1),
('Résumé', 'String', 6, 0, 1),
('Durée', 'String', 7, 0, 1),
('Note', 'String', 8, 0, 1),
('Genre', 'String', 9, 1, 1),
('Date de sortie', 'String', 10, 0, 1);

--
-- Musique
--

INSERT INTO `yattribute` (`name`, `type`, `no_order`, `many`, `itemtype`) VALUES
('cover', 'Image', 1, 0, 2),
('Artiste', 'String', 2, 0, 2),
('Nom', 'String', 3, 0, 2),
('Date de sortie', 'String', 4, 0, 2),
('Tracklist', 'String', 5, 0, 2),
('Date de sortie', 'String', 6, 0, 2);

--
-- Livre
--

INSERT INTO `yattribute` (`name`, `type`, `no_order`, `many`, `itemtype`) VALUES
('cover', 'Image', 1, 0, 3),
('Auteur', 'String', 2, 1, 3),
('Titre', 'String', 3, 0, 3),
('Résumé', 'String', 4, 0, 3),
('Editeur', 'String', 5, 0, 3),
('Date de sortie', 'String', 6, 0, 3),
('Nombre de pages', 'Int', 7, 0, 3);

--
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`theme`, `is_public`, `owner`) VALUES
('DVD', 1, 2);

--
-- Contenu de la table `yitem`
--

INSERT INTO `yitem` (`collection`, `type`) VALUES
(1, 1);

--
-- Contenu de la table `yattributevalue`
--

INSERT INTO `yattributevalue` (`val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
('', NULL, NULL, NULL, NULL, 1),
('Fight club', NULL, NULL, NULL, NULL, 2),
('David Fincher', NULL, NULL, NULL, NULL, 3),
('Je sais plus', NULL, NULL, NULL, NULL, 4),
('Edward Norton', NULL, NULL, NULL, NULL, 5),
('Brad Pitt', NULL, NULL, NULL, NULL, 5),
('Personne ne parle du club', NULL, NULL, NULL, NULL, 6),
('Au moins ça', NULL, NULL, NULL, NULL, 7),
('10', NULL, NULL, NULL, NULL, 8),
('Bizarre', NULL, NULL, NULL, NULL, 9),
('Someday', NULL, NULL, NULL, NULL, 10);

--
-- Contenu de la table `link_attr_item`
--

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11);


--
-- Contenu de la table `ysetting`
--

INSERT INTO `ysetting` (`name`, `val`) VALUES
('subscribeOk', 'true');


/*
	Ajout de collection Roman
	yitemtype : Livre
	5 yitem

*/

INSERT INTO `ycollection` (`theme`, `is_public`, `owner`) VALUES
('Roman', 1, 2);

INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);


INSERT INTO `yattributevalue` (`val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
('', NULL, NULL, NULL, NULL, 17),
('Alexandre Dumas', NULL, NULL, NULL, NULL, 18),
('Les Trois mousquetaires', NULL, NULL, NULL, NULL, 19),
('Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('2002-09-18', NULL, NULL, NULL, NULL, 22),
(NULL, 888, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Alexandre Dumas', NULL, NULL, NULL, NULL, 18),
('Les Trois Mousquetaires - Vingt ans après', NULL, NULL, NULL, NULL, 19),
('Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 20),
('Gallimard', NULL, NULL, NULL, NULL, 21),
('1962-05-28', NULL, NULL, NULL, NULL, 22),
(NULL, 924, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Emile Zola', NULL, NULL, NULL, NULL, 18),
('Germinal', NULL, NULL, NULL, NULL, 19),
('Le roman de la lutte des classes et de la misère ouvrière', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('1971-11-08', NULL, NULL, NULL, NULL, 22),
(NULL, 538, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Victor Hugo', NULL, NULL, NULL, NULL, 18),
('Notre-Dame de Paris', NULL, NULL, NULL, NULL, 19),
('Autour de Notre-Dame, dans la cité médiévale de Paris, s''agite une kyrielle de personnages très différents: Quasimodo, le bossu sonneur de cloches; Gringoire, le poète; Frollo, le sinistre archidiacre; Phoebus, le capitaine des archers du roi. Ils sont tous fascinés par la belle bohémienne Esméralda...', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('2009-03-26', NULL, NULL, NULL, NULL, 22),
(NULL, 923, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Victor Hugo', NULL, NULL, NULL, NULL, 18),
('Les Misérables', NULL, NULL, NULL, NULL, 19),
('L''oeuvre phare de Victor Hugo', NULL, NULL, NULL, NULL, 20),
('Gallimard', NULL, NULL, NULL, NULL, 21),
('1996-10-15', NULL, NULL, NULL, NULL, 22),
(NULL, 962, NULL, NULL, NULL, 23);

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 25),
(4, 26),
(4, 27),
(4, 28),
(4, 29),
(4, 30),
(4, 31),
(4, 32),
(5, 33),
(5, 34),
(5, 35),
(5, 36),
(5, 37),
(5, 38),
(5, 39),
(6, 40),
(6, 41),
(6, 42),
(6, 43),
(6, 44),
(6, 45),
(6, 46);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;