CREATE TABLE IF NOT EXISTS `categorias_fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(45) NULL,
  `tipo_categoria` char(1) default 'P',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;