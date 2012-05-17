SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `yacedb` ;
CREATE SCHEMA IF NOT EXISTS `yacedb` DEFAULT CHARACTER SET latin1 ;
USE `yacedb` ;

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
-- Table `yacedb`.`YUSER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YUSER` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YUSER` (
  `idYUSER` INT NOT NULL AUTO_INCREMENT ,
  `email` VARCHAR(255) NOT NULL ,
  `password_hash` VARCHAR(32) NOT NULL ,
  `pseudo` VARCHAR(45) NULL ,
  `rank` INT NULL ,
  PRIMARY KEY (`idYUSER`) ,
  INDEX `rank` (`rank` ASC) ,
  CONSTRAINT `rank`
    FOREIGN KEY (`rank` )
    REFERENCES `yacedb`.`YRANK` (`idYRANK` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`YCOLLECTION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YCOLLECTION` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YCOLLECTION` (
  `idYCOLLECTION` INT NOT NULL AUTO_INCREMENT ,
  `theme` VARCHAR(255) NOT NULL ,
  `is_public` BINARY NOT NULL ,
  `owner` INT NULL ,
  PRIMARY KEY (`idYCOLLECTION`) ,
  INDEX `owner` (`owner` ASC) ,
  CONSTRAINT `owner`
    FOREIGN KEY (`owner` )
    REFERENCES `yacedb`.`YUSER` (`idYUSER` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`YITEMTYPE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YITEMTYPE` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YITEMTYPE` (
  `idYITEMTYPE` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`idYITEMTYPE`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`YITEM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YITEM` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YITEM` (
  `idYITEM` INT NOT NULL AUTO_INCREMENT ,
  `collection` INT NULL ,
  `type` INT NULL ,
  PRIMARY KEY (`idYITEM`) ,
  INDEX `collection` (`collection` ASC) ,
  INDEX `type` (`type` ASC) ,
  CONSTRAINT `collection`
    FOREIGN KEY (`collection` )
    REFERENCES `yacedb`.`YCOLLECTION` (`idYCOLLECTION` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `type`
    FOREIGN KEY (`type` )
    REFERENCES `yacedb`.`YITEMTYPE` (`idYITEMTYPE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`YATTRIBUTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YATTRIBUTE` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YATTRIBUTE` (
  `idYATTRIBUTE` INT NOT NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `type` VARCHAR(45) NOT NULL ,
  `no_order` INT NOT NULL ,
  `many` BINARY NOT NULL ,
  `itemtype` INT NULL ,
  PRIMARY KEY (`idYATTRIBUTE`) ,
  INDEX `itemtype` (`itemtype` ASC) ,
  CONSTRAINT `itemtype`
    FOREIGN KEY (`itemtype` )
    REFERENCES `yacedb`.`YITEMTYPE` (`idYITEMTYPE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`YATTRIBUTEVALUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`YATTRIBUTEVALUE` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`YATTRIBUTEVALUE` (
  `idYATTRIBUTEVALUE` INT NOT NULL ,
  `val_str` LONGTEXT NULL ,
  `val_int` INT NULL ,
  `val_flt` DECIMAL(2) NULL ,
  `val_date` DATETIME NULL ,
  `val_bool` BINARY NULL ,
  `attribute` INT NULL ,
  PRIMARY KEY (`idYATTRIBUTEVALUE`) ,
  INDEX `attribute` (`attribute` ASC) ,
  CONSTRAINT `attribute`
    FOREIGN KEY (`attribute` )
    REFERENCES `yacedb`.`YATTRIBUTE` (`idYATTRIBUTE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`LINK_ATTR_ITEM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`LINK_ATTR_ITEM` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`LINK_ATTR_ITEM` (
  `item` INT NOT NULL ,
  `value` INT NOT NULL ,
  INDEX `value` (`value` ASC) ,
  PRIMARY KEY (`item`, `value`) ,
  CONSTRAINT `item`
    FOREIGN KEY (`item` )
    REFERENCES `yacedb`.`YITEM` (`idYITEM` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `value`
    FOREIGN KEY (`value` )
    REFERENCES `yacedb`.`YATTRIBUTEVALUE` (`idYATTRIBUTEVALUE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `yacedb`.`LINK_TYPES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `yacedb`.`LINK_TYPES` ;

CREATE  TABLE IF NOT EXISTS `yacedb`.`LINK_TYPES` (
  `parent` INT NOT NULL ,
  `child` INT NOT NULL ,
  INDEX `child` (`child` ASC) ,
  PRIMARY KEY (`parent`, `child`) ,
  CONSTRAINT `parent`
    FOREIGN KEY (`parent` )
    REFERENCES `yacedb`.`YITEMTYPE` (`idYITEMTYPE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `child`
    FOREIGN KEY (`child` )
    REFERENCES `yacedb`.`YITEMTYPE` (`idYITEMTYPE` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
