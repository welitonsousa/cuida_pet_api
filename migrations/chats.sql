CREATE TABLE IF NOT EXISTS `chats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agendamento_id` INT NOT NULL,
  `status` CHAR(1) NULL DEFAULT 'A',
  `data_criacao` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chats_agendamento1_idx` (`agendamento_id` ASC),
  CONSTRAINT `fk_chats_agendamento1`
    FOREIGN KEY (`agendamento_id`)
    REFERENCES `agendamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;