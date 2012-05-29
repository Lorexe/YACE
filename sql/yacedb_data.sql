--
-- Base de données: `yacedb`
-- Import DATA 
-- 289-05-2012
--
USE `yacedb`;

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
-- Contenu de la table `ycollection`
--

INSERT INTO `ycollection` (`idYCOLLECTION`, `theme`, `is_public`, `owner`) VALUES
(6, 'Vases', 1, 12);

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
-- Contenu de la table `yrank`
--

INSERT INTO `yrank` (`idYRANK`, `description`, `nb_max_item`, `is_admin`) VALUES
(1, 'Administrateur', -1, 1),
(2, 'Collectionneur', 100, 0);

--
-- Contenu de la table `ysetting`
--

INSERT INTO `ysetting` (`idYSETTING`, `name`, `val`) VALUES
(1, 'subscribeOk', 'true');

--
-- Contenu de la table `yuser`
--

INSERT INTO `yuser` (`idYUSER`, `email`, `password_hash`, `pseudo`, `rank`) VALUES
(1, 'mabigboy.bb@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'bruno', 1),
(2, 'coucou@gmail.com', 'ab4f63f9ac65152575886860dde480a1', 'solacin', 1),
(3, 'alessandrodaviera111@hotmail.com', 'ab4f63f9ac65152575886860dde480a1', 'aless', 1),
(4, 'azerty@azerty.azerty', 'ab4f63f9ac65152575886860dde480a1', 'azerty', 1),
(5, 'b@b.b', '92eb5ffee6ae2fec3ad71c777531578f', 'b', 1),
(6, 'c@c.c', '4a8a8f09d37b73795649038408b5f33', 'c', 1),
(7, 'test@test.be', '10272a50ec98dffc53d8359c8aacc79', 'test', 1),
(8, 'admin@yace.com', '21232f297a57a5a743894ae4a801fc3', 'admin', 1),
(9, 'pegazz@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'pegazz', 1),
(10, 'lorexe@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'lorexe', 1),
(11, 'bru@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'bru', 1),
(12, 'user@user.com', 'ee11cbb19052e4b7aac0ca6c23ee', 'user', 1),
(13, 'mkp@yace.com', 'cc175b9c0f1b6a831c399e269772661', 'mkp', 1);
