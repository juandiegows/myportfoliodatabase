-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DBJuanDiegoWS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DBJuanDiegoWS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DBJuanDiegoWS` DEFAULT CHARACTER SET utf8 ;
USE `DBJuanDiegoWS` ;

-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`User` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `UserName` VARCHAR(45) NULL,
  `Password` VARCHAR(100) NULL,
  `Active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Service` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `Title` VARCHAR(250) NOT NULL,
  `SpanishTitle` VARCHAR(250) NOT NULL,
  `Description` TEXT NOT NULL,
  `SpanishDescription` TEXT NOT NULL,
  `Active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) VISIBLE,
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC) VISIBLE,
  UNIQUE INDEX `SpanishTitle_UNIQUE` (`SpanishTitle` ASC) VISIBLE,
  INDEX `user_services_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `user_services`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Client` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL,
  `SpanishDescription` TEXT NULL,
  `Description` TEXT NULL,
  `LinkSite` VARCHAR(300) NULL,
  `Year` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Image` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(400) NULL,
  `Link` VARCHAR(400) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Participant` (
  `UserId` INT NOT NULL,
  `ClientId` INT NOT NULL,
  PRIMARY KEY (`UserId`, `ClientId`),
  INDEX `client_idx` (`ClientId` ASC) VISIBLE,
  CONSTRAINT `user`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `client`
    FOREIGN KEY (`ClientId`)
    REFERENCES `DBJuanDiegoWS`.`Client` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`TopicType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`TopicType` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(400) NOT NULL,
  `SpanishName` VARCHAR(400) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Topic` (
  `Id` INT NOT NULL,
  `TopicTypeId` INT NOT NULL,
  `Name` VARCHAR(400) NOT NULL,
  `SpanishName` VARCHAR(400) NOT NULL,
  `LinkImage` VARCHAR(400) NULL,
  `Description` TEXT NULL,
  `SpanishDescription` TEXT NULL,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) VISIBLE,
  PRIMARY KEY (`Id`),
  INDEX `topic type_idx` (`TopicTypeId` ASC) VISIBLE,
  CONSTRAINT `topic type`
    FOREIGN KEY (`TopicTypeId`)
    REFERENCES `DBJuanDiegoWS`.`TopicType` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ImageClient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ImageClient` (
  `ImageId` INT NOT NULL,
  `ClientId` INT NOT NULL,
  PRIMARY KEY (`ImageId`, `ClientId`),
  INDEX `client_idx` (`ClientId` ASC) VISIBLE,
  CONSTRAINT `client_image`
    FOREIGN KEY (`ClientId`)
    REFERENCES `DBJuanDiegoWS`.`Client` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `image_client`
    FOREIGN KEY (`ImageId`)
    REFERENCES `DBJuanDiegoWS`.`Image` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ClientTopic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ClientTopic` (
  `ClientId` INT NOT NULL,
  `TopicId` INT NOT NULL,
  `Description` TEXT NULL,
  `SpanishDescription` TEXT NULL,
  PRIMARY KEY (`ClientId`, `TopicId`),
  INDEX `topic_idx` (`TopicId` ASC) VISIBLE,
  CONSTRAINT `client_topic`
    FOREIGN KEY (`ClientId`)
    REFERENCES `DBJuanDiegoWS`.`Client` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `topic_client`
    FOREIGN KEY (`TopicId`)
    REFERENCES `DBJuanDiegoWS`.`Topic` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`WorkExperience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`WorkExperience` (
  `Id` INT NOT NULL,
  `UserId` INT NOT NULL,
  `Business` VARCHAR(100) NOT NULL,
  `Description` TEXT NULL,
  `SpanishDescription` TEXT NULL,
  `Rol` VARCHAR(450) NULL,
  `SpanishRol` VARCHAR(450) NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`Id`),
  INDEX `user_work_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `user_work`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`WorkExperienceTopic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`WorkExperienceTopic` (
  `WorkExperienceId` INT NOT NULL,
  `TopicId` INT NOT NULL,
  PRIMARY KEY (`WorkExperienceId`, `TopicId`),
  INDEX `topic_work_idx` (`TopicId` ASC) VISIBLE,
  CONSTRAINT `topic_work`
    FOREIGN KEY (`TopicId`)
    REFERENCES `DBJuanDiegoWS`.`Topic` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `work`
    FOREIGN KEY (`WorkExperienceId`)
    REFERENCES `DBJuanDiegoWS`.`WorkExperience` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Level` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `SpanishName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) VISIBLE,
  UNIQUE INDEX `SpanishName_UNIQUE` (`SpanishName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Skill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Skill` (
  `UserId` INT NOT NULL,
  `TopicId` INT NOT NULL,
  `LevelId` INT NULL,
  PRIMARY KEY (`UserId`, `TopicId`),
  INDEX `level_idx` (`LevelId` ASC) VISIBLE,
  INDEX `topic_skill_idx` (`TopicId` ASC) VISIBLE,
  CONSTRAINT `level`
    FOREIGN KEY (`LevelId`)
    REFERENCES `DBJuanDiegoWS`.`Level` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_skill`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `topic_skill`
    FOREIGN KEY (`TopicId`)
    REFERENCES `DBJuanDiegoWS`.`Topic` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Education`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Education` (
  `Id` INT NOT NULL,
  `UserId` INT NULL,
  `Entity` VARCHAR(200) NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `SpanishTitle` VARCHAR(200) NULL,
  `Description` TEXT NULL,
  `SpanishDescription` TEXT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL,
  PRIMARY KEY (`Id`),
  INDEX `user_education_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `user_education`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`Project` (
  `Id` INT NOT NULL,
  `UserId` INT NOT NULL,
  `Title` VARCHAR(200) NOT NULL,
  `SpanishTitle` VARCHAR(200) NOT NULL,
  `ShortDescription` VARCHAR(200) NOT NULL,
  `SpanishShortDescription` VARCHAR(200) NOT NULL,
  `Description` TEXT NOT NULL,
  `SpanishDescription` TEXT NOT NULL,
  `ViewLink` VARCHAR(200) NOT NULL,
  `DownloadLink` VARCHAR(200) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `user_id_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ProjectTopic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ProjectTopic` (
  `TopicId` INT NOT NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`TopicId`, `ProjectId`),
  INDEX `project_project_topic_idx` (`ProjectId` ASC) VISIBLE,
  CONSTRAINT `topic_projec`
    FOREIGN KEY (`TopicId`)
    REFERENCES `DBJuanDiegoWS`.`Topic` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `project_project_topic`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `DBJuanDiegoWS`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`SocialMedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`SocialMedia` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL,
  `LinkImage` VARCHAR(200) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`SocialMediaUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`SocialMediaUser` (
  `UserId` INT NOT NULL,
  `SocialMediaId` INT NOT NULL,
  `Link` VARCHAR(200) NOT NULL,
  `IsPrincipal` TINYINT NOT NULL,
  PRIMARY KEY (`UserId`, `SocialMediaId`),
  UNIQUE INDEX `Link_UNIQUE` (`Link` ASC) VISIBLE,
  INDEX `social_media_user_idx` (`SocialMediaId` ASC) VISIBLE,
  CONSTRAINT `user_social`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `social_media_user`
    FOREIGN KEY (`SocialMediaId`)
    REFERENCES `DBJuanDiegoWS`.`SocialMedia` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ProjectToProject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ProjectToProject` (
  `PrincipalProojecId` INT NOT NULL,
  `ProjectId` INT NOT NULL,
  PRIMARY KEY (`PrincipalProojecId`, `ProjectId`),
  INDEX `Project_second_idx` (`ProjectId` ASC) VISIBLE,
  CONSTRAINT `project_princpial`
    FOREIGN KEY (`PrincipalProojecId`)
    REFERENCES `DBJuanDiegoWS`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Project_second`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `DBJuanDiegoWS`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ImageProject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ImageProject` (
  `ProjectId` INT NOT NULL,
  `ImageId` INT NOT NULL,
  PRIMARY KEY (`ProjectId`, `ImageId`),
  INDEX `image_project_idx` (`ImageId` ASC) VISIBLE,
  CONSTRAINT `project_image`
    FOREIGN KEY (`ProjectId`)
    REFERENCES `DBJuanDiegoWS`.`Project` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `image_project`
    FOREIGN KEY (`ImageId`)
    REFERENCES `DBJuanDiegoWS`.`Image` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`profession`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`profession` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `NameSpanish` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBJuanDiegoWS`.`ProfessionUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBJuanDiegoWS`.`ProfessionUser` (
  `ProfessionId` INT NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`ProfessionId`, `UserId`),
  INDEX `userProfession_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `professionUser`
    FOREIGN KEY (`ProfessionId`)
    REFERENCES `DBJuanDiegoWS`.`profession` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userProfession`
    FOREIGN KEY (`UserId`)
    REFERENCES `DBJuanDiegoWS`.`User` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `DBJuanDiegoWS`.`User`
-- -----------------------------------------------------
START TRANSACTION;
USE `DBJuanDiegoWS`;
INSERT INTO `DBJuanDiegoWS`.`User` (`Id`, `Name`, `LastName`, `UserName`, `Password`, `Active`) VALUES (1, 'Juan Diego', 'Mejia Maestre', NULL, NULL, 1);

COMMIT;

