-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vidlyAppDatabase
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `vidlyAppDatabase` ;

-- -----------------------------------------------------
-- Schema vidlyAppDatabase
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vidlyAppDatabase` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `vidlyAppDatabase` ;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Roles` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Users` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`username`),
  INDEX `fk_Users_Roles_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Roles`
    FOREIGN KEY (`role_id`)
    REFERENCES `vidlyAppDatabase`.`Roles` (`role_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Customers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Movies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Movies` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Movies` (
  `movie_id` INT NOT NULL AUTO_INCREMENT,
  `barcode` VARCHAR(50) NOT NULL,
  `daily_rental_rate` DECIMAL(5,2) NOT NULL,
  `number_in_stock` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Coupons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Coupons` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Coupons` (
  `coupon_id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(50) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `discount` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`coupon_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `vidlyAppDatabase`.`Rentals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vidlyAppDatabase`.`Rentals` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `vidlyAppDatabase`.`Rentals` (
  `rental_id` INT NOT NULL AUTO_INCREMENT,
  `rent_date` DATE NOT NULL,
  `return_date` DATE NOT NULL,
  `customer_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `coupon_id` INT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_Rentals_Customers1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Rentals_Movies1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_Rentals_Coupons1_idx` (`coupon_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rentals_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `vidlyAppDatabase`.`Customers` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Rentals_Movies1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `vidlyAppDatabase`.`Movies` (`movie_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Rentals_Coupons1`
    FOREIGN KEY (`coupon_id`)
    REFERENCES `vidlyAppDatabase`.`Coupons` (`coupon_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
