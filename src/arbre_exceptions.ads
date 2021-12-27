-- Définition d'une exception commune à tous les arbres.
package arbre_Exceptions is

	Cle_Absente_Exception  : Exception;	-- un caractere est absente d'un arbre
	Suppression_impossible_Exception : Exception; -- On ne peux pas supprimer une branche liée à deux Fils
end arbre_Exceptions;
