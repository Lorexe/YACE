SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

--
-- Base de données: `yacedb`
--
DROP DATABASE IF EXISTS `yacedb`;
CREATE DATABASE `yacedb` DEFAULT CHARACTER SET latin1;
USE `yacedb`;

-- --------------------------------------------------------

--
-- Structure de la table `link_attr_item`
--

DROP TABLE IF EXISTS `link_attr_item`;
CREATE TABLE IF NOT EXISTS `link_attr_item` (
  `item` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`item`,`value`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `link_attr_item`
--

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(5, 7),
(5, 8),
(4, 9),
(4, 10),
(4, 11),
(6, 12),
(5, 13),
(6, 14),
(6, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(8, 21),
(8, 22),
(8, 23),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 31),
(10, 32),
(10, 33),
(10, 34),
(10, 35),
(10, 36),
(10, 37),
(10, 38),
(10, 39),
(11, 40),
(11, 41),
(11, 42),
(11, 43),
(11, 44),
(11, 45),
(11, 46),
(11, 47),
(12, 48),
(12, 49),
(12, 50),
(12, 51),
(12, 52),
(12, 53),
(12, 54),
(12, 55);

-- --------------------------------------------------------

--
-- Structure de la table `link_types`
--

DROP TABLE IF EXISTS `link_types`;
CREATE TABLE IF NOT EXISTS `link_types` (
  `parent` int(11) NOT NULL,
  `child` int(11) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `yattribute`
--

DROP TABLE IF EXISTS `yattribute`;
CREATE TABLE IF NOT EXISTS `yattribute` (
  `idYATTRIBUTE` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `no_order` int(11) NOT NULL,
  `many` BOOLEAN NOT NULL,
  `itemtype` int(11) DEFAULT NULL,
  PRIMARY KEY (`idYATTRIBUTE`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Contenu de la table `yattribute`
--

INSERT INTO `yattribute` (`idYATTRIBUTE`, `name`, `type`, `no_order`, `many`, `itemtype`) VALUES
(7, 'Titre', 'String', 1, 1, 5),
(8, 'Epoque', 'String', 3, 0, 5),
(9, 'Nom', 'String', 1, 1, 4),
(10, 'Type', 'String', 2, 1, 5),
(11, 'Auteur', 'String', 2, 1, 4),
(12, 'Pays', 'String', 3, 0, 4),
(13, 'Auteur', 'String', 2, 1, 6),
(14, 'Genre', 'String', 4, 0, 6),
(15, 'Langue', 'String', 6, 0, 6),
(16, 'ISBN', 'String', 8, 0, 6),
(17, 'Description', 'String', 3, 0, 6),
(18, 'Titre', 'String', 1, 1, 6),
(19, 'Parution', 'Date', 7, 0, 6),
(20, 'Editeur', 'String', 5, 0, 6);

-- --------------------------------------------------------

--
-- Structure de la table `yattributevalue`
--

DROP TABLE IF EXISTS `yattributevalue`;
CREATE TABLE IF NOT EXISTS `yattributevalue` (
  `idYATTRIBUTEVALUE` int(11) NOT NULL AUTO_INCREMENT,
  `val_str` longtext,
  `val_int` int(11) DEFAULT NULL,
  `val_flt` decimal(2,0) DEFAULT NULL,
  `val_date` datetime DEFAULT NULL,
  `val_bool` BOOLEAN DEFAULT NULL,
  `attribute` int(11) DEFAULT NULL,
  PRIMARY KEY (`idYATTRIBUTEVALUE`),
  KEY `attribute` (`attribute`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=56 ;

--
-- Contenu de la table `yattributevalue`
--

INSERT INTO `yattributevalue` (`idYATTRIBUTEVALUE`, `val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
(7, 'Antiquité', NULL, NULL, NULL, NULL, 8),
(8, 'argile', NULL, NULL, NULL, NULL, 10),
(9, 'Vase en Bronze', NULL, NULL, NULL, NULL, 9),
(10, 'inconnu', NULL, NULL, NULL, NULL, 11),
(11, 'France', NULL, NULL, NULL, NULL, 12),
(12, 'argile blanche', NULL, NULL, NULL, NULL, 10),
(13, 'Vase ancienne argile', NULL, NULL, NULL, NULL, 7),
(14, 'Moderne', NULL, NULL, NULL, NULL, 8),
(15, 'Vase moderne en argile', NULL, NULL, NULL, NULL, 7),
(16, NULL, NULL, NULL, '2002-09-18 00:00:00', NULL, 19),
(17, 'Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 17),
(18, '978-2253008880', NULL, NULL, NULL, NULL, 16),
(19, 'Roman Historique', NULL, NULL, NULL, NULL, 14),
(20, 'Français', NULL, NULL, NULL, NULL, 15),
(21, 'Alexandre Dumas', NULL, NULL, NULL, NULL, 13),
(22, 'Les Trois mousquetaires', NULL, NULL, NULL, NULL, 18),
(23, 'Le Livre de Poche', NULL, NULL, NULL, NULL, 20),
(24, 'Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 17),
(25, 'Gallimard', NULL, NULL, NULL, NULL, 20),
(26, '978-2070101801', NULL, NULL, NULL, NULL, 16),
(27, 'Français', NULL, NULL, NULL, NULL, 15),
(28, 'Roman Historique', NULL, NULL, NULL, NULL, 14),
(29, 'Alexandre Dumas', NULL, NULL, NULL, NULL, 13),
(30, NULL, NULL, NULL, '1962-05-28 00:00:00', NULL, 19),
(31, 'Les Trois Mousquetaires - Vingt ans après', NULL, NULL, NULL, NULL, 18),
(32, 'Emile Zola', NULL, NULL, NULL, NULL, 13),
(33, 'Français', NULL, NULL, NULL, NULL, 15),
(34, 'Germinal', NULL, NULL, NULL, NULL, 18),
(35, 'Le Livre de Poche', NULL, NULL, NULL, NULL, 20),
(36, NULL, NULL, NULL, '1971-11-08 00:00:00', NULL, 19),
(37, 'Roman Historique', NULL, NULL, NULL, NULL, 14),
(38, 'Le roman de la lutte des classes et de la misère ouvrière', NULL, NULL, NULL, NULL, 17),
(39, '978-2253004226', NULL, NULL, NULL, NULL, 16),
(40, '978-2070345830', NULL, NULL, NULL, NULL, 16),
(41, 'Broché', NULL, NULL, NULL, NULL, 20),
(42, 'Notre-Dame de Paris', NULL, NULL, NULL, NULL, 18),
(43, 'Français', NULL, NULL, NULL, NULL, 15),
(44, 'Autour de Notre-Dame, dans la cité médiévale de Paris, s''agite une kyrielle de personnages très différents: Quasimodo, le bossu sonneur de cloches; Gringoire, le poète; Frollo, le sinistre archidiacre; Phoebus, le capitaine des archers du roi. Ils sont tous fascinés par la belle bohémienne Esméralda...', NULL, NULL, NULL, NULL, 17),
(45, 'Roman Historique', NULL, NULL, NULL, NULL, 14),
(46, NULL, NULL, NULL, '2009-03-26 00:00:00', NULL, 19),
(47, 'Victor Hugo', NULL, NULL, NULL, NULL, 13),
(48, 'L''oeuvre phare de Victor Hugo', NULL, NULL, NULL, NULL, 17),
(49, 'Roman Historique', NULL, NULL, NULL, NULL, 14),
(50, 'Victor Hugo', NULL, NULL, NULL, NULL, 13),
(51, 'Ecole des loisirs', NULL, NULL, NULL, NULL, 20),
(52, NULL, NULL, NULL, '1996-10-15 00:00:00', NULL, 19),
(53, 'Français', NULL, NULL, NULL, NULL, 15),
(54, 'Les Misérables', NULL, NULL, NULL, NULL, 18),
(55, '978-2211041997', NULL, NULL, NULL, NULL, 16);

-- --------------------------------------------------------

--
-- Structure de la table `ycollection`
--

DROP TABLE IF EXISTS `ycollection`;
CREATE TABLE IF NOT EXISTS `ycollection` (
  `idYCOLLECTION` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(255) NOT NULL,
  `is_public` BOOLEAN NOT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`idYCOLLECTION`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`idYCOLLECTION`, `theme`, `is_public`, `owner`) VALUES
(6, 'Vases', 1, 12),
(7, 'Romans', 1, 8);

-- --------------------------------------------------------

--
-- Structure de la table `yitem`
--

DROP TABLE IF EXISTS `yitem`;
CREATE TABLE IF NOT EXISTS `yitem` (
  `idYITEM` int(11) NOT NULL AUTO_INCREMENT,
  `collection` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`idYITEM`),
  KEY `collection` (`collection`),
  KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `yitem`
--

INSERT INTO `yitem` (`idYITEM`, `collection`, `type`) VALUES
(4, 6, 4),
(5, 6, 5),
(6, 6, 5),
(8, 7, 6),
(9, 7, 6),
(10, 7, 6),
(11, 7, 6),
(12, 7, 6);

-- --------------------------------------------------------

--
-- Structure de la table `yitemtype`
--

DROP TABLE IF EXISTS `yitemtype`;
CREATE TABLE IF NOT EXISTS `yitemtype` (
  `idYITEMTYPE` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_public` BOOLEAN NOT NULL,
  PRIMARY KEY (`idYITEMTYPE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `yitemtype`
--

INSERT INTO `yitemtype` (`idYITEMTYPE`, `name`, `is_public`) VALUES
(4, 'Vase bronze', 1),
(5, 'Vase argile', 1),
(6, 'Livre', 1);

-- --------------------------------------------------------

--
-- Structure de la table `yrank`
--

DROP TABLE IF EXISTS `yrank`;
CREATE TABLE IF NOT EXISTS `yrank` (
  `idYRANK` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `nb_max_item` int(11) NOT NULL,
  `is_admin` BOOLEAN NOT NULL,
  PRIMARY KEY (`idYRANK`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`idYRANK`, `description`, `nb_max_item`, `is_admin`) VALUES
(1, 'Administrateur', -1, 1),
(2, 'Collectionneur', 100, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ysetting`
--

DROP TABLE IF EXISTS `ysetting`;
CREATE TABLE IF NOT EXISTS `ysetting` (
  `idYSETTING` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `val` varchar(255) NOT NULL,
  PRIMARY KEY (`idYSETTING`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ysetting`
--

INSERT INTO `ysetting` (`idYSETTING`, `name`, `val`) VALUES
(1, 'subscribeOk', 'true');

-- --------------------------------------------------------

--
-- Structure de la table `yuser`
--

DROP TABLE IF EXISTS `yuser`;
CREATE TABLE IF NOT EXISTS `yuser` (
  `idYUSER` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(32) NOT NULL,
  `pseudo` varchar(45) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`idYUSER`),
  KEY `rank` (`rank`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`idYUSER`, `email`, `password_hash`, `pseudo`, `rank`) VALUES
(7, 'test@test.be', '10272a50ec98dffc53d8359c8aacc79', 'test', 0),
(8, 'admin@yace.com', '21232f297a57a5a743894ae4a801fc3', 'admin', 1),
(9, 'pegazz@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'pegazz', 0),
(10, 'lorexe@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'lorexe', 0),
(11, 'bru@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'bru', 0),
(12, 'user@user.com', 'ee11cbb19052e4b7aac0ca6c23ee', 'user', 0),
(13, 'mkp@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'mkp', 0);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `link_attr_item`
--
ALTER TABLE `link_attr_item`
  ADD CONSTRAINT `item` FOREIGN KEY (`item`) REFERENCES `yitem` (`idYITEM`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `value` FOREIGN KEY (`value`) REFERENCES `yattributevalue` (`idYATTRIBUTEVALUE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `link_types`
--
ALTER TABLE `link_types`
  ADD CONSTRAINT `child` FOREIGN KEY (`child`) REFERENCES `yitemtype` (`idYITEMTYPE`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `parent` FOREIGN KEY (`parent`) REFERENCES `yitemtype` (`idYITEMTYPE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `yattribute`
--
ALTER TABLE `yattribute`
  ADD CONSTRAINT `itemtype` FOREIGN KEY (`itemtype`) REFERENCES `yitemtype` (`idYITEMTYPE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `yattributevalue`
--
ALTER TABLE `yattributevalue`
  ADD CONSTRAINT `attribute` FOREIGN KEY (`attribute`) REFERENCES `yattribute` (`idYATTRIBUTE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ycollection`
--
ALTER TABLE `ycollection`
  ADD CONSTRAINT `owner` FOREIGN KEY (`owner`) REFERENCES `yuser` (`idYUSER`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `yitem`
--
ALTER TABLE `yitem`
  ADD CONSTRAINT `collection` FOREIGN KEY (`collection`) REFERENCES `ycollection` (`idYCOLLECTION`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `type` FOREIGN KEY (`type`) REFERENCES `yitemtype` (`idYITEMTYPE`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `yuser`
--
ALTER TABLE `yuser`
  ADD CONSTRAINT `rank` FOREIGN KEY (`rank`) REFERENCES `yrank` (`idYRANK`) ON DELETE NO ACTION ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
