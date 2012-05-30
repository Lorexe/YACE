--
-- Base de données: `yacedb`
-- Import DATA 
-- 289-05-2012
--
USE `yacedb`;

--
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`idYRANK`, `description`, `nb_max_item`, `is_admin`) VALUES
(1, 'Administrateur', -1, 1),
(2, 'Collectionneur', 100, 0);

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`idYUSER`, `email`, `password_hash`, `pseudo`, `rank`) VALUES
(1, 'admin@yace.com', '21232f297a57a5a743894ae4a801fc3', 'admin', 1),
(2, 'user@user.com', 'ee11cbb19052e4b7aac0ca6c23ee', 'user', 1);

--
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`idYCOLLECTION`, `theme`, `is_public`, `owner`) VALUES
(6, 'Vases', 1, 2);

--
-- Contenu de la table `yattribute`
--

INSERT INTO `yattribute` (`idYATTRIBUTE`, `name`, `type`, `no_order`, `many`, `itemtype`) VALUES
(7, 'Titre', 'String', 1, 1, 5),
(8, 'Epoque', 'String', 3, 0, 5),
(9, 'Nom', 'String', 1, 1, 4),
(10, 'Type', 'String', 2, 1, 5),
(11, 'Auteur', 'String', 2, 1, 4),
(12, 'Pays', 'String', 3, 0, 4);

--
-- Contenu de la table `yattributevalue`
--

INSERT INTO `yattributevalue` (`idYATTRIBUTEVALUE`, `val_str`, `val_int`, `val_flt`, `val_date`, `val_bool`, `attribute`) VALUES
(7, 'Antiquité', NULL, NULL, NULL, NULL, 8),
(8, 'argile', NULL, NULL, NULL, NULL, 10),
(9, 'Vase en Bronze', NULL, NULL, NULL, NULL, 9),
(10, 'inconnu', NULL, NULL, NULL, NULL, 11),
(11, 'France', NULL, NULL, NULL, NULL, 12),
(12, 'argile blanche', NULL, NULL, NULL, NULL, 10),
(13, 'Vase ancienne argile', NULL, NULL, NULL, NULL, 7),
(14, 'Moderne', NULL, NULL, NULL, NULL, 8),
(15, 'Vase moderne en argile', NULL, NULL, NULL, NULL, 7);

--
-- Contenu de la table `yitem`
--

INSERT INTO `yitem` (`idYITEM`, `collection`, `type`) VALUES
(4, 6, 4),
(5, 6, 5),
(6, 6, 5);

--
-- Contenu de la table `yitemtype`
--

INSERT INTO `yitemtype` (`idYITEMTYPE`, `name`, `is_public`) VALUES
(4, 'Vase bronze', 1),
(5, 'Vase argile', 1);

--
-- Contenu de la table `ysetting`
--

INSERT INTO `ysetting` (`idYSETTING`, `name`, `val`) VALUES
(1, 'subscribeOk', 'true');

--
-- Contenu de la table `link_attr_item`
--

INSERT INTO `link_attr_item` (`item`, `value`) VALUES
(5, 7),
(5, 8),
(4, 9),
(4, 10),
(4, 11),
(6, 12),
(5, 13),
(6, 14),
(6, 15);
