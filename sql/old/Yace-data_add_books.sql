/*
	Ajout de collection Roman
	yitemtype : Livre
	5 yitem

*/

INSERT INTO `ycollection` (`theme`, `is_public`, `owner`) VALUES
('Roman', 1, 2);

INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);
INSERT INTO `yitem` (`collection`, `type`) VALUES
(2, 3);


INSERT INTO `yattributevalue` (`val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
('', NULL, NULL, NULL, NULL, 17),
('Alexandre Dumas', NULL, NULL, NULL, NULL, 18),
('Les Trois mousquetaires', NULL, NULL, NULL, NULL, 19),
('Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('2002-09-18', NULL, NULL, NULL, NULL, 22),
(NULL, 888, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Alexandre Dumas', NULL, NULL, NULL, NULL, 18),
('Les Trois Mousquetaires - Vingt ans après', NULL, NULL, NULL, NULL, 19),
('Avec ses nombreux combats et ses rebondissements romanesques, Les Trois Mousquetaires est l''exemple type du roman de cape et d''épée', NULL, NULL, NULL, NULL, 20),
('Gallimard', NULL, NULL, NULL, NULL, 21),
('1962-05-28', NULL, NULL, NULL, NULL, 22),
(NULL, 924, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Emile Zola', NULL, NULL, NULL, NULL, 18),
('Germinal', NULL, NULL, NULL, NULL, 19),
('Le roman de la lutte des classes et de la misère ouvrière', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('1971-11-08', NULL, NULL, NULL, NULL, 22),
(NULL, 538, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Victor Hugo', NULL, NULL, NULL, NULL, 18),
('Notre-Dame de Paris', NULL, NULL, NULL, NULL, 19),
('Autour de Notre-Dame, dans la cité médiévale de Paris, s''agite une kyrielle de personnages très différents: Quasimodo, le bossu sonneur de cloches; Gringoire, le poète; Frollo, le sinistre archidiacre; Phoebus, le capitaine des archers du roi. Ils sont tous fascinés par la belle bohémienne Esméralda...', NULL, NULL, NULL, NULL, 20),
('Le Livre de Poche', NULL, NULL, NULL, NULL, 21),
('2009-03-26', NULL, NULL, NULL, NULL, 22),
(NULL, 923, NULL, NULL, NULL, 23),
('', NULL, NULL, NULL, NULL, 17),
('Victor Hugo', NULL, NULL, NULL, NULL, 18),
('Les Misérables', NULL, NULL, NULL, NULL, 19),
('L''oeuvre phare de Victor Hugo', NULL, NULL, NULL, NULL, 20),
('Gallimard', NULL, NULL, NULL, NULL, 21),
('1996-10-15', NULL, NULL, NULL, NULL, 22),
(NULL, 962, NULL, NULL, NULL, 23);

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 25),
(4, 26),
(4, 27),
(4, 28),
(4, 29),
(4, 30),
(4, 31),
(4, 32),
(5, 33),
(5, 34),
(5, 35),
(5, 36),
(5, 37),
(5, 38),
(5, 39),
(6, 40),
(6, 41),
(6, 42),
(6, 43),
(6, 44),
(6, 45),
(6, 46);

