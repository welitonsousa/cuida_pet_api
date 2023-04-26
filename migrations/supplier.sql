CREATE TABLE IF NOT EXISTS `fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NULL,
  `logo` TEXT NULL,
  `endereco` VARCHAR(100) NULL,
  `telefone` VARCHAR(45) NULL,
  `latlng` POINT NULL,
  `categorias_fornecedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fornecedor_categorias_fornecedor1_idx` (`categorias_fornecedor_id` ASC),
  CONSTRAINT `fk_fornecedor_categorias_fornecedor1`
    FOREIGN KEY (`categorias_fornecedor_id`)
    REFERENCES `categorias_fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;