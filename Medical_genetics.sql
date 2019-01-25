-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`chromosome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`chromosome` (
  `idchromosome` INT NOT NULL,
  `start-locus` DECIMAL NOT NULL,
  `end-locus` DECIMAL NOT NULL,
  PRIMARY KEY (`idchromosome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Syndrome_descr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Syndrome_descr` (
  `idSyndrome_descr` INT NOT NULL,
  `descr_gene_affected` TEXT(255) NULL,
  `descr_syndrome` TEXT(255) NULL,
  PRIMARY KEY (`idSyndrome_descr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Condition` (
  `idCondition` INT NOT NULL,
  `aff_chr` INT NOT NULL,
  `syndrome_code` INT NOT NULL,
  PRIMARY KEY (`idCondition`),
  INDEX `fk_Condition_1_idx` (`aff_chr` ASC) VISIBLE,
  INDEX `fk_Condition_2_idx` (`syndrome_code` ASC) VISIBLE,
  CONSTRAINT `fk_Condition_1`
    FOREIGN KEY (`aff_chr`)
    REFERENCES `mydb`.`chromosome` (`idchromosome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Condition_2`
    FOREIGN KEY (`syndrome_code`)
    REFERENCES `mydb`.`Syndrome_descr` (`idSyndrome_descr`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `Pat_Name` VARCHAR(55) NULL,
  `Pat_Gender` ENUM('Male', 'Female', 'Trans') NOT NULL,
  `Age_diagnosis` DATE NULL,
  `diag_syndrome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical genetics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical genetics` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `gene_name` VARCHAR(45) NULL,
  `chromosome` INT NOT NULL,
  `syndrome_id` INT NOT NULL,
  `patient_code` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Medical genetics_1_idx` (`chromosome` ASC) VISIBLE,
  INDEX `fk_Medical genetics_2_idx` (`syndrome_id` ASC) VISIBLE,
  INDEX `fk_Medical genetics_3_idx` (`patient_code` ASC) VISIBLE,
  CONSTRAINT `fk_Medical genetics_1`
    FOREIGN KEY (`chromosome`)
    REFERENCES `mydb`.`chromosome` (`idchromosome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medical genetics_2`
    FOREIGN KEY (`syndrome_id`)
    REFERENCES `mydb`.`Condition` (`idCondition`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medical genetics_3`
    FOREIGN KEY (`patient_code`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
