CREATE DATABASE db_huansync;
USE db_huansync;

CREATE TABLE `tbl_events` (
  `eventId` integer PRIMARY KEY AUTO_INCREMENT,
  `nameEvent` varchar(50) UNIQUE,
  `countryEvent` varchar(30),
  `cityEvent` varchar(30),
  `addressEvent` varchar(40),
  `peopleCapacity` integer,
  `storeCapacity` integer,
  `restaurantCapacity` integer,
  `dateEvent` date,
  `timeEvent` time,
  `organizerId` integer NOT NULL,
  `ageClassification` ENUM ('family', 'adult', 'younger'),
  `statusEvent` ENUM ('active', 'finished', 'pending')
);

CREATE TABLE `tbl_workerRoles` (
  `workerRoleId` integer PRIMARY KEY AUTO_INCREMENT,
  `nameWorkerRole` varchar(50) UNIQUE,
  `activitiesWorkerRole` text
);

CREATE TABLE `tbl_staff` (
  `staffId` integer PRIMARY KEY AUTO_INCREMENT,
  `staffNumberId` varchar(15) UNIQUE,
  `nameStaff` varchar(50) NOT NULL,
  `birthdayStaff` date,
  `statusStaff` ENUM ('TASK_ASSIGNED', 'NO_TASK_ASSIGNED', 'DISMISSED', 'INCAPACITED'),
  `roleWorkId` integer
);

CREATE TABLE `tbl_staff_event` (
  `eventId` integer,
  `staffId` integer
);

CREATE TABLE `tbl_ticketoffice` (
  `ticketOfficeId` INT PRIMARY KEY AUTO_INCREMENT,
  `eventId` INT NOT NULL,
  `address` VARCHAR(50) DEFAULT NULL,
  `location` BOOLEAN NOT NULL,
  `contactNumber` VARCHAR(40) NOT NULL,
  `staffId` INT NOT NULL
);

CREATE TABLE `tbl_ticketType` (
  `ticketTypeId` INT PRIMARY KEY AUTO_INCREMENT,
  `nameTicketType` VARCHAR(40),
  `description` VARCHAR(255),
  `price` DECIMAL(10,2)
);

CREATE TABLE `tbl_customers` (
  `customerId` INT PRIMARY KEY AUTO_INCREMENT,
  `nameCustomer` VARCHAR(50) NOT NULL,
  `document` INT NOT NULL,
  `gender` VARCHAR(20) DEFAULT NULL,
  `birthDate` DATE DEFAULT NULL,
  `emailCustomer` VARCHAR(50) DEFAULT NULL,
  `phoneNumber` VARCHAR(50) DEFAULT NULL,
  `typeCustomer` VARCHAR(50) DEFAULT NULL
);

CREATE TABLE `tbl_tickets` (
  `ticketId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nameTicket` VARCHAR(50) DEFAULT NULL,
  `status` ENUM ('paid', 'reserved') DEFAULT NULL,
  `additionalCost` DECIMAL(10,2) DEFAULT NULL,
  `customerId` INT NOT NULL,
  `ticketOfficeId` INT NOT NULL,
  `ticketTypeId` INT NOT NULL
);

CREATE TABLE `tbl_ingredients` (
  `ingredientId` int PRIMARY KEY AUTO_INCREMENT,
  `nameIngredient` varchar(50) NOT NULL,
  `availableQuantity` int NOT NULL,
  `establishmentId` int
);

CREATE TABLE `tbl_itemMenu` (
  `itemMenuId` int PRIMARY KEY AUTO_INCREMENT,
  `nameItemMenu` varchar(50) NOT NULL,
  `priceItemMenu` decimal(10,2) NOT NULL,
  `itemMenuType` ENUM ('appetizer', 'main course', 'drink', 'dessert') NOT NULL,
  `preparationTime` int NOT NULL,
  `establishmentId` int NOT NULL
);

CREATE TABLE `tbl_ingredients_itemMenu` (
  `itemMenuId` int NOT NULL,
  `ingredientId` int NOT NULL
);

CREATE TABLE `tbl_establishments` (
  `establishmentId` INT PRIMARY KEY AUTO_INCREMENT,
  `categoryEstablishment` ENUM ('restaurant', 'store') NOT NULL,
  `nameEstablishment` VARCHAR(40) NOT NULL,
  `eventId` INT,
  `managerEstablishmentId` INT
);

CREATE TABLE `tbl_product` (
  `productId` INT PRIMARY KEY AUTO_INCREMENT,
  `productName` varchar(255),
  `productPrice` decimal(10,2) NOT NULL,
  `description` varchar(255),
  `manufacturer` varchar(255),
  `typeProduct` ENUM ('Manga', 'Multimedia', 'Art', 'Figures', 'Souvenirs', 'Indumentary', 'Tecnology'),
  `quantity` int NOT NULL,
  `establishmentsId` int
);

CREATE TABLE `promotion` (
  `promotionId` int PRIMARY KEY AUTO_INCREMENT,
  `namePromotion` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `statusPromotion` boolean,
  `percent` int NOT NULL
);

CREATE TABLE `tbl_cashRegister` (
  `cashRegisterId` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `statusCash` boolean NOT NULL,
  `openingAmount` decimal(10,2) NOT NULL,
  `closingAmount` decimal(10,2) NOT NULL,
  `cashierOperatorId` int,
  `establishmentsId` int
);

CREATE TABLE `tbl_order` (
  `orderId` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customerId` int,
  `establishmentId` int,
  `cashRegisterId` int,
  `cashierOperatorId` int,
  `orderStatusEnum` ENUM ('REGISTERED', 'PAID', 'DELIVERED')
);

CREATE TABLE `tbl_product_order` (
  `orderId` int,
  `productId` int,
  `quantity` int,
  `promotionId` int
);

CREATE TABLE `tbl_categoryCosplay` (
  `categoryCosplayId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nameCosplay` VARCHAR(255) NOT NULL UNIQUE,
  `deletable` BOOLEAN NOT NULL
);

CREATE TABLE `tbl_activities` (
  `activityId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nameActivity` VARCHAR(255) NOT NULL,
  `typeActivity` ENUM("cosplay", "trivia") NOT NULL,
  `categoryCosplayId` INT,
  `numParticipants` INT NOT NULL,
  `eventId` INT,
  `startTime` TIME UNIQUE NOT NULL,
  `price` DECIMAL(10, 2) NOT NULL,
  `completed` BOOLEAN NOT NULL
);

CREATE TABLE `tbl_participation` (
  `customerId` INT NOT NULL,
  `activityId` INT NOT NULL,
  `statusParticipation` ENUM ('participate', 'not participate', 'winner') NOT NULL
);

CREATE TABLE `tbl_cosplay` (
  `cosplayId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `score` DECIMAL(10,2),
  `nameCosplay` VARCHAR(100) NOT NULL,
  `participantId` INT NOT NULL,
  `activityId` INT NOT NULL,
  `statusCosplay` boolean NOT NULL
);

CREATE TABLE `tbl_juryQualification` (
  `cosplayId` int NOT NULL,
  `juryId` int NOT NULL,
  `qualification` int
);

CREATE TABLE `tbl_trivias` (
  `triviaId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `activityId` INT NOT NULL,
  `participantOneId` INT NOT NULL,
  `participantTwoId` INT NOT NULL,
  `winnerId` INT NOT NULL,
  `inchargedId` INT NOT NULL
);

CREATE TABLE `tbl_prizes` (
  `prizeId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `typePrize` ENUM("manga", "multimedia", "art", "figures", "souvenirs", "clothing", "technology") NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10, 2) NOT NULL,
  `statusPrize` ENUM("available", "awarded") NOT NULL,
  `activityId` INT,
  `winnerId` INT
);

CREATE TABLE `tbl_questions` (
  `questionId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `question` VARCHAR(255) NOT NULL UNIQUE,
  `answer` VARCHAR(255) NOT NULL,
  `category` ENUM("Naruto", "SPYxFamily", "Jujutsu Kaisen", "Harry Potter", "Comics") NOT NULL,
  `difficulty` ENUM("easy", "medium", "hard") NOT NULL
);

CREATE TABLE `tbl_itemMenu_order` (
  `orderId` int,
  `itemMenuId` int,
  `quantity` int
);

ALTER TABLE `tbl_ticketoffice` ADD FOREIGN KEY (`eventId`) REFERENCES `tbl_events` (`eventId`);

ALTER TABLE `tbl_ticketoffice` ADD FOREIGN KEY (`staffId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_staff` ADD FOREIGN KEY (`roleWorkId`) REFERENCES `tbl_workerRoles` (`workerRoleId`);

ALTER TABLE `tbl_staff_event` ADD FOREIGN KEY (`staffId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_staff_event` ADD FOREIGN KEY (`eventId`) REFERENCES `tbl_events` (`eventId`);

ALTER TABLE `tbl_tickets` ADD FOREIGN KEY (`ticketOfficeId`) REFERENCES `tbl_ticketoffice` (`ticketOfficeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `tbl_tickets` ADD FOREIGN KEY (`customerId`) REFERENCES `tbl_customers` (`customerId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `tbl_tickets` ADD FOREIGN KEY (`ticketTypeId`) REFERENCES `tbl_ticketType` (`ticketTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `tbl_ingredients_itemMenu` ADD FOREIGN KEY (`ingredientId`) REFERENCES `tbl_ingredients` (`ingredientId`) ON DELETE CASCADE;

ALTER TABLE `tbl_ingredients_itemMenu` ADD FOREIGN KEY (`itemMenuId`) REFERENCES `tbl_itemMenu` (`itemMenuId`) ON DELETE CASCADE;

ALTER TABLE `tbl_itemMenu` ADD FOREIGN KEY (`establishmentId`) REFERENCES `tbl_establishments` (`establishmentId`) ON DELETE CASCADE;

ALTER TABLE `tbl_ingredients` ADD FOREIGN KEY (`establishmentId`) REFERENCES `tbl_establishments` (`establishmentId`) ON DELETE CASCADE;

ALTER TABLE `tbl_establishments` ADD FOREIGN KEY (`eventId`) REFERENCES `tbl_events` (`eventId`);

ALTER TABLE `tbl_product` ADD FOREIGN KEY (`establishmentsId`) REFERENCES `tbl_establishments` (`establishmentId`);

ALTER TABLE `tbl_cashRegister` ADD FOREIGN KEY (`establishmentsId`) REFERENCES `tbl_establishments` (`establishmentId`);

ALTER TABLE `tbl_product_order` ADD FOREIGN KEY (`orderId`) REFERENCES `tbl_order` (`orderId`);

ALTER TABLE `tbl_order` ADD FOREIGN KEY (`establishmentId`) REFERENCES `tbl_establishments` (`establishmentId`);

ALTER TABLE `tbl_product_order` ADD FOREIGN KEY (`promotionId`) REFERENCES `promotion` (`promotionId`);

ALTER TABLE `tbl_order` ADD FOREIGN KEY (`cashRegisterId`) REFERENCES `tbl_cashRegister` (`cashRegisterId`);

ALTER TABLE `tbl_order` ADD FOREIGN KEY (`customerId`) REFERENCES `tbl_customers` (`customerId`);

ALTER TABLE `tbl_product_order` ADD FOREIGN KEY (`productId`) REFERENCES `tbl_product` (`productId`);

ALTER TABLE `tbl_order` ADD FOREIGN KEY (`cashierOperatorId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_participation` ADD FOREIGN KEY (`customerId`) REFERENCES `tbl_customers` (`customerId`);

ALTER TABLE `tbl_participation` ADD FOREIGN KEY (`activityId`) REFERENCES `tbl_activities` (`activityId`);

ALTER TABLE `tbl_activities` ADD FOREIGN KEY (`eventId`) REFERENCES `tbl_events` (`eventId`);

ALTER TABLE `tbl_activities` ADD FOREIGN KEY (`categoryCosplayId`) REFERENCES `tbl_categoryCosplay` (`categoryCosplayId`);

ALTER TABLE `tbl_cosplay` ADD FOREIGN KEY (`activityId`) REFERENCES `tbl_activities` (`activityId`);

ALTER TABLE `tbl_cosplay` ADD FOREIGN KEY (`participantId`) REFERENCES `tbl_customers` (`customerId`);

ALTER TABLE `tbl_juryQualification` ADD FOREIGN KEY (`cosplayId`) REFERENCES `tbl_cosplay` (`cosplayId`);

ALTER TABLE `tbl_juryQualification` ADD FOREIGN KEY (`juryId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_cashRegister` ADD FOREIGN KEY (`cashierOperatorId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_itemMenu_order` ADD FOREIGN KEY (`orderId`) REFERENCES `tbl_order` (`orderId`);

ALTER TABLE `tbl_itemMenu_order` ADD FOREIGN KEY (`itemMenuId`) REFERENCES `tbl_itemMenu` (`itemMenuId`);

-- ACTIVITY

ALTER TABLE `tbl_activities` ADD FOREIGN KEY (`categoryCosplayId`) REFERENCES `tbl_categoryCosplay` (`categoryCosplayId`);

ALTER TABLE `tbl_activities` ADD FOREIGN KEY (`eventId`) REFERENCES `tbl_events` (`eventId`);

ALTER TABLE `tbl_trivias` ADD FOREIGN KEY (`activityId`) REFERENCES `tbl_activities` (`activityId`);

ALTER TABLE `tbl_trivias` ADD FOREIGN KEY (`winnerId`) REFERENCES `tbl_customers` (`customerId`);

ALTER TABLE `tbl_trivias` ADD FOREIGN KEY (`inchargedId`) REFERENCES `tbl_staff` (`staffId`);

ALTER TABLE `tbl_prizes` ADD FOREIGN KEY (`activityId`) REFERENCES `tbl_activities` (`activityId`);

ALTER TABLE `tbl_prizes` ADD FOREIGN KEY (`winnerId`) REFERENCES `tbl_customers` (`customerId`);