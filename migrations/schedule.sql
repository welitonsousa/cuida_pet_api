CREATE TABLE IF NOT EXISTS `agendamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_agendamento` DATETIME NULL,
  `usuario_id` INT NOT NULL,
  `fornecedor_id` INT NOT NULL,
  `status` CHAR(2) NOT NULL DEFAULT 'P' COMMENT 'P=Pendente\nCN=Confirmada\nF=Finalizado\nC=Cancelado',
  nome varchar(200) null,
	nome_pet varchar(200) null,
  PRIMARY KEY (`id`),
  INDEX `fk_solicitacao_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_solicitacao_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_solicitacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitacao_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;