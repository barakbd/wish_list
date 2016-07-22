-- MySQL Script generated by MySQL Workbench
-- Fri 22 Jul 2016 09:37:52 AM PDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema quotes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `quotes` ;

-- -----------------------------------------------------
-- Schema quotes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quotes` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `quotes` ;

-- -----------------------------------------------------
-- Table `quotes`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quotes`.`users` ;

CREATE TABLE IF NOT EXISTS `quotes`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `first_name` VARCHAR(255) NOT NULL COMMENT '',
  `last_name` VARCHAR(255) NOT NULL COMMENT '',
  `email` VARCHAR(255) NOT NULL COMMENT '',
  `pw_hash` VARCHAR(255) NOT NULL COMMENT '',
  `updated_at` DATETIME NOT NULL COMMENT '',
  `created_at` DATETIME NOT NULL COMMENT '',
  PRIMARY KEY (`user_id`)  COMMENT '');


-- -----------------------------------------------------
-- Table `quotes`.`quotes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quotes`.`quotes` ;

CREATE TABLE IF NOT EXISTS `quotes`.`quotes` (
  `quote_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `quoted_by` VARCHAR(255) NOT NULL COMMENT '',
  `quote_text` LONGTEXT NOT NULL COMMENT '',
  `users_user_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`quote_id`)  COMMENT '',
  INDEX `fk_quotes_users_idx` (`users_user_id` ASC)  COMMENT '',
  CONSTRAINT `fk_quotes_users`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `quotes`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `quotes`.`favourites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `quotes`.`favourites` ;

CREATE TABLE IF NOT EXISTS `quotes`.`favourites` (
  `quotes_quote_id` INT NOT NULL COMMENT '',
  `users_user_id` INT(11) NOT NULL COMMENT '',
  PRIMARY KEY (`quotes_quote_id`, `users_user_id`)  COMMENT '',
  INDEX `fk_quotes_has_users_users1_idx` (`users_user_id` ASC)  COMMENT '',
  INDEX `fk_quotes_has_users_quotes1_idx` (`quotes_quote_id` ASC)  COMMENT '',
  CONSTRAINT `fk_quotes_has_users_quotes1`
    FOREIGN KEY (`quotes_quote_id`)
    REFERENCES `quotes`.`quotes` (`quote_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_quotes_has_users_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `quotes`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
