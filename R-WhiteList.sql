USE `essentialmode`;

CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(40) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
);