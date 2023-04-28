CREATE TABLE IF NOT EXISTS `fornecedor_servicos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fornecedor_id` INT NOT NULL,
  `nome_servico` VARCHAR(200) NULL,
  `valor_servico` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fornecedor_servicos_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_fornecedor_servicos_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;