SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Table `yacedb`.`YSETTING`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YSETTING` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YSETTING` (
  `idYSETTING` INT NOT NULL ,
  `name` VARCHAR(255) NOT NULL UNIQUE ,
  `val` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`idYSETTING`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `yacedb`.`YRANK`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YRANK` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YRANK` (
  `idYRANK` INT NOT NULL AUTO_INCREMENT ,
  `description` VARCHAR(255) NOT NULL ,
  `nb_max_item` INT NOT NULL ,
  `is_admin` BINARY NOT NULL ,
  PRIMARY KEY (`idYRANK`) )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `yacedb`.`YUSER` COMMENT_REV1: pseudo not null
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YUSER` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YUSER` (
  `idYUSER` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(255) NOT NULL ,
  `password_hash` VARCHAR(32) NOT NULL ,
  `pseudo` VARCHAR(45) NOT NULL ,
  `rank` INT NULL ,
  PRIMARY KEY (`idYUSER`) ,
  INDEX `rank` (`rank` ASC) ,
  CONSTRAINT `rank`
    FOREIGN KEY (`rank` )
    REFERENCES `yacedb`.`YRANK` (`idYRANK` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--
-- Base de donnees: `yacedb`
--

-- --------------------------------------------------------

--
-- Contenu de la table `ysetting`
--

INSERT INTO `YSETTING` (`idYSETTING`, `name`, `val`) VALUES
(1, 'subscribeOk', 'true');

--
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`idYRANK`, `description`, `nb_max_item`, `is_admin`) VALUES
(1, 'Administrateur', -1, ''),
(2, 'Collectionneur', 100, '\0');

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`idYUSER`, `email`, `password_hash`, `pseudo`, `rank`) VALUES
(1, 'mabigboy.bb@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'bruno', 1),
(2, 'coucou@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'solacin', 1),
(3, 'alessandrodaviera111@hotmail.com', 'ab4f63f9ac65152575886860dde480a1', 'aless', 1),
(4, 'azerty@azerty.azerty', 'ab4f63f9ac65152575886860dde480a1', 'azerty', 1),
(5, 'b@b.b', '92eb5ffee6ae2fec3ad71c777531578f', 'b', 1),
(6, 'c@c.c', '4a8a8f09d37b73795649038408b5f33', 'c', 1);

-- --------------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;