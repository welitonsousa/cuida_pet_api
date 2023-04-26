CREATE TABLE IF NOT EXISTS `agendamento_servicos` (
  `agendamento_id` INT NOT NULL,
  `fornecedor_servicos_id` INT NOT NULL,
  INDEX `fk_agenda_servicos_agendamento1_idx` (`agendamento_id` ASC),
  INDEX `fk_agenda_servicos_fornecedor_servicos1_idx` (`fornecedor_servicos_id` ASC),
  CONSTRAINT `fk_agenda_servicos_agendamento1`
    FOREIGN KEY (`agendamento_id`)
    REFERENCES `agendamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agenda_servicos_fornecedor_servicos1`
    FOREIGN KEY (`fornecedor_servicos_id`)
    REFERENCES `fornecedor_servicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;