/*
	Patch sql ajout de champs is_public � la table yitemtype
*/

USE yacedb;
ALTER TABLE yitemtype ADD is_public BOOLEAN NOT NULL;
