-- Définition d'une exception commune à toutes les SDA.
package Cellule_Exceptions is

	Cle_Absente_Exception  : Exception;	-- un caractere est absente d'un SDA
	Suppression_impossible_Exception : Exception; -- On ne peux pas supprimer une branche liée à deux Fils
end Cellule_Exceptions;
