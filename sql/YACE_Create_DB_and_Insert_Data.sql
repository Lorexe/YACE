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
(6, 15);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `yattribute`
--

INSERT INTO `yattribute` (`idYATTRIBUTE`, `name`, `type`, `no_order`, `many`, `itemtype`) VALUES
(7, 'Titre', 'String', 1, 1, 5),
(8, 'Epoque', 'String', 3, 0, 5),
(9, 'Nom', 'String', 1, 1, 4),
(10, 'Type', 'String', 2, 1, 5),
(11, 'Auteur', 'String', 2, 1, 4),
(12, 'Pays', 'String', 3, 0, 4);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

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
(15, 'Vase moderne en argile', NULL, NULL, NULL, NULL, 7);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`idYCOLLECTION`, `theme`, `is_public`, `owner`) VALUES
(6, 'Vases', 1, 12);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `yitem`
--

INSERT INTO `yitem` (`idYITEM`, `collection`, `type`) VALUES
(4, 6, 4),
(5, 6, 5),
(6, 6, 5);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `yitemtype`
--

INSERT INTO `yitemtype` (`idYITEMTYPE`, `name`, `is_public`) VALUES
(4, 'Vase bronze', 1),
(5, 'Vase argile', 1);

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
(1, 'mabigboy.bb@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'bruno', 1),
(2, 'coucou@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'solacin', 1),
(3, 'alessandrodaviera111@hotmail.com', 'ab4f63f9ac65152575886860dde480a1', 'aless', 1),
(4, 'azerty@azerty.azerty', 'ab4f63f9ac65152575886860dde480a1', 'azerty', 1),
(5, 'b@b.b', '92eb5ffee6ae2fec3ad71c777531578f', 'b', 1),
(6, 'c@c.c', '4a8a8f09d37b73795649038408b5f33', 'c', 1),
(7, 'test@test.be', '10272a50ec98dffc53d8359c8aacc79', 'test', 1),
(8, 'admin@yace.com', '21232f297a57a5a743894ae4a801fc3', 'admin', 1),
(9, 'pegazz@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'pegazz', 1),
(10, 'lorexe@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'lorexe', 1),
(11, 'bru@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'bru', 1),
(12, 'user@user.com', 'ee11cbb19052e4b7aac0ca6c23ee', 'user', 1),
(13, 'mkp@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'mkp', 1);

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
