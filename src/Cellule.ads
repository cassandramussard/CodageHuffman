generic
   type T_Cle is private;
   type T_Donnee is private;

package Cellule is
   type T_Cellule is limited private;

   -- Initialiser la cellule
   procedure Initialiser(Cellule : out T_Cellule);

   procedure Vider(Cellule : in out T_Cellule) with
     Post => Est_Vide (Cellule);

   -- La Cellule est vide
   function Est_Vide(Cellule : in T_Cellule) return Boolean;

   -- Obtenir le nombre d'éléments d'une Cellule.
   function Taille (Cellule : in T_Cellule) return Integer with
     Post => Taille'Result >= 0
     and (Taille'Result = 0) = Est_Vide (Cellule);

   --Vérifier si la cellule est une feuille
   function Est_Feuille(Cellule : in T_Cellule) return Boolean;

   -- Vérifier si le carctere est présent dans la cellule
   function Cle_Present(Cellule : in T_Cellule ; Cle : in T_Cle) return Boolean;

   function La_Donnee(Cellule : in T_Cellule ; Cle : in T_Cle) return T_Donnee;


   -- Enregistrer une cellule d'une fiche avec ses fils droit et gauche, sa frequence et le caractere
   procedure Enregistrer(Cellule : in out T_Cellule ; Cle : in T_Cle ; Donnee : in T_Donnee; Fils_droit : in T_Cellule ; Fils_gauche : in T_Cellule);

   -- Supprimer la Donn�e associ�e � une Cl� dans une Cellule.
   -- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans la Cellule
   procedure Supprimer(Cellule : in out T_Cellule ; Cle : in T_Cle) with
     Post =>  Taille (Cellule) = Taille (Cellule)'Old - 1 -- un �l�ment de moins
     and not Cle_Presente (Cellule, Cle);

   -- generique avec fonction traiter
   generic
      with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
   procedure Parcours_Infixe(Cellule : in out T_Cellule);



private
   type T_Element;

   type T_Cellule is access T_Element;

   type T_Element is
      record
         Donnee : T_Donnee;
         Cle : T_Cle;
         Fils_gauche : T_Cellule;
         Fils_droit : T_Cellule;
      end record;
end Cellule;
