CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `senha` TEXT NULL DEFAULT NULL,
  `tipo_cadastro` ENUM('FACEBOOK', 'GOOGLE', 'APPLE', 'APP') NOT NULL,
  `ios_token` TEXT NULL DEFAULT NULL,
  `android_token` TEXT NULL DEFAULT NULL,
  `refresh_token` TEXT NULL DEFAULT NULL,
  `img_avatar` TEXT NULL DEFAULT NULL,
  `social_id` TEXT NULL DEFAULT NULL,
  `fornecedor_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_fornecedor_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_usuario_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;