--
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`idYRANK`, `description`, `nb_max_item`, `is_admin`) VALUES
(1, 'Administrateur', -1, 1),
(2, 'Collectionneur', 1000, 0);

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`idYUSER`, `email`, `password_hash`, `pseudo`, `rank`) VALUES
(1, 'user@yace.com', 'ee11cbb19052e40b07aac0ca060c23ee', 'user', 2),
(2, 'admin@yace.com', '21232f297a57a5a743894a0e4a801fc3', 'admin', 1);

--
-- Contenu de la table `yitemtype`
--

INSERT INTO `yitemtype` (`idYITEMTYPE`, `name`, `is_public`) VALUES
(1, 'Film', 1),
(2, 'Musique', 1),
(3, 'Livre', 1);

--
-- Contenu de la table `yattribute`
--

INSERT INTO `yattribute` (`idYATTRIBUTE`, `name`, `type`, `no_order`, `many`, `itemtype`) VALUES
(1, 'cover', 'Image', 1, 0, 1),
(2, 'Titre', 'String', 2, 0, 1),
(3, 'Réalisateur', 'String', 3, 1, 1),
(4, 'Auteur', 'String', 4, 1, 1),
(5, 'Acteur', 'String', 5, 1, 1),
(6, 'Résumé', 'String', 6, 0, 1),
(7, 'Durée', 'String', 7, 0, 1),
(8, 'Note', 'String', 8, 0, 1),
(9, 'Genre', 'String', 9, 1, 1),
(10, 'Date de sortie', 'String', 10, 0, 1);

--
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`idYCOLLECTION`, `theme`, `is_public`, `owner`) VALUES
(1, 'DVD', 1, 2);

--
-- Contenu de la table `yitem`
--

INSERT INTO `yitem` (`idYITEM`, `collection`, `type`) VALUES
(1, 1, 1);

--
-- Contenu de la table `yattributevalue`
--

INSERT INTO `yattributevalue` (`idYATTRIBUTEVALUE`, `val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
(1, '', NULL, NULL, NULL, NULL, 1),
(2, 'Fight club', NULL, NULL, NULL, NULL, 2),
(3, 'David Fincher', NULL, NULL, NULL, NULL, 3),
(4, 'Je sais plus', NULL, NULL, NULL, NULL, 4),
(5, 'Edward Norton', NULL, NULL, NULL, NULL, 5),
(6, 'Brad Pitt', NULL, NULL, NULL, NULL, 5),
(7, 'Personne ne parle du club', NULL, NULL, NULL, NULL, 6),
(8, 'Au moins ça', NULL, NULL, NULL, NULL, 7),
(9, '10', NULL, NULL, NULL, NULL, 8),
(10, 'Bizarre', NULL, NULL, NULL, NULL, 9),
(11, 'Le plus beau jour', NULL, NULL, NULL, NULL, 10);

--
-- Contenu de la table `link_attr_item`
--

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11);

--
-- Contenu de la table `ysetting`
--

INSERT INTO `ysetting` (`idYSETTING`, `name`, `val`) VALUES
(1, 'subscribeOk', 'true');