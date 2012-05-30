SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

--
-- Base de données: `yacedb`
--
DROP DATABASE IF EXISTS `yacedb`;
CREATE DATABASE `yacedb` DEFAULT CHARACTER SET latin1;
USE `yacedb`;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Structure de la table `yitemtype`
--

DROP TABLE IF EXISTS `yitemtype`;
CREATE TABLE IF NOT EXISTS `yitemtype` (
  `idYITEMTYPE` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_public` BOOLEAN NOT NULL,
  PRIMARY KEY (`idYITEMTYPE`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
