/*
	correction du type Binary en Boolean
*/

USE yacedb;
ALTER TABLE yrank CHANGE COLUMN `is_admin` is_admin BOOLEAN NOT NULL;
ALTER TABLE ycollection CHANGE COLUMN `is_public` is_public BOOLEAN NOT NULL;
ALTER TABLE yattributevalue CHANGE COLUMN `val_bool` val_bool BOOLEAN NULL;
ALTER TABLE yattribute CHANGE COLUMN `many` many BOOLEAN NOT NULL;

UPDATE `yrank` SET `is_admin`=1 WHERE `description` like 'Administrateur';
UPDATE `yrank` SET `is_admin`=0 WHERE `description` like 'Collectionneur';