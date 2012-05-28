--
-- Base de données: `yacedb`
-- Import DATA 
-- 28-05-2012
--
USE yacedb;
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
(7, 'test@test.be', '10272a50ec98dffc53d8359c8aacc79', 'test', 1);

