generic
type T_Donnee is private;
    type T_Cle is private;

package TH is
    type T_Tableau is limited private;



private
  type T_Tableau is array(0..128) of T_LCA;
        type T_Cellule is
        		record
        			Indice : Integer;
        			Valeur : Float;
        			Suivant : T_Vecteur_Creux;
        			-- Invariant :
        			--   Indice >= 1;
        			--   Suivant = Null or else Suivant.all.Indice > Indice;
        			--   	-- les cellules sont stockés dans l'ordre croissant des indices.
        		end record;
          end TH;
