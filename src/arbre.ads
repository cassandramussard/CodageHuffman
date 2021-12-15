generic
   type T_Cle is private;
   type T_Donnee is private;

package arbre is
   type T_arbre is limited private;

   -- Initialiser la cellule
   procedure Initialiser(arbre : out T_arbre);

   procedure Vider(arbre : in out T_arbre) with
     Post => Est_Vide (arbre);

   -- La Cellule est vide
   function Est_Vide(arbre : in T_arbre) return Boolean;

   -- Obtenir le nombre d'Alignements d'une Cellule.
   function Taille (arbre : in T_arbre) return Integer with
     Post => Taille'Result >= 0
     and (Taille'Result = 0) = Est_Vide (arbre);

   --V�rifier si la cellule est une feuille
   function Est_Feuille(arbre : in T_arbre) return Boolean;

   -- V�rifier si le carctere est pr�sent dans la cellule
   function Cle_Presente(arbre : in T_arbre ; Cle : in T_Cle) return Boolean;

   function La_Donnee(arbre : in T_arbre; Cle : in T_Cle) return T_Donnee;


   -- Enregistrer une cellule d'une fiche avec ses fils droit et gauche, sa frequence et le caractere
   procedure Enregistrer(arbre : in out T_arbre ; Cle : in T_Cle ; Donnee : in T_Donnee);

   -- Supprimer la Donn�e associ�e � une Cl� dans une Cellule.
   -- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans la Cellule
   procedure Supprimer(arbre : in out T_arbre ; Cle : in T_Cle) with
     Post =>  Taille (arbre) = Taille (arbre)'Old - 1 -- un �l�ment de moins
     and not Cle_Presente (arbre, Cle);

     -- generique avec fonction traiter
     generic
        with procedure Traiter (Cle : in out T_Cle; Donnee: in out T_Donnee);
     procedure Parcours_Infixe(arbre : in out T_arbre);



private
   type T_Element;

   type T_arbre is access T_Element;

   type T_Element is
      record
         Cle : T_Cle;
         Donnee : T_Donnee;
         Fils_gauche : T_arbre;
         Fils_droit : T_arbre;
      end record;
end arbre;
