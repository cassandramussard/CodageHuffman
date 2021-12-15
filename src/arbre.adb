with Cellule_Exceptions;         use Cellule_Exceptions;
with Ada.Unchecked_Deallocation;

package body arbre is

   procedure Free is
     new Ada.Unchecked_Deallocation (Object => T_Element, Name => T_arbre);

   procedure Initialiser(arbre: out T_arbre) is
   begin
      arbre := NULL;
   end Initialiser;

   function Est_Vide (arbre : in T_arbre) return Boolean is
   begin
      if arbre = NULL then
         return True;
      end if;
      return False;
   end;

   -- Obtenir le nombre d'�l�ments d'une Cellule.
   function Taille (arbre : in T_arbre) return Integer is
   begin
      if Est_Vide(arbre) then
         return 0;
      else
         return 1 + Taille(arbre.all.Fils_droit) + Taille(arbre.all.Fils_gauche);
      end if;
   end Taille;

   procedure Vider(arbre : in out T_arbre) is
   begin
      if Est_Vide(arbre) then
         Null;
      else
         Vider(arbre.all.Fils_droit);
         Vider(arbre.all.Fils_gauche);
         Free(arbre);
      end if;
   end Vider;

   function Est_Feuille(arbre : in T_arbre) return Boolean is
   begin
      if Est_Vide(arbre.all.Fils_droit) and Est_Vide(arbre.all.Fils_gauche) then
         return False;
      end if;
      return True;
   end Est_Feuille;

   function Cle_Presente(arbre : in T_arbre ; Cle : in T_Cle) return Boolean is
   begin
      if Est_Vide(arbre) then
         return False;
      elsif arbre.all.Cle = Cle then
         return True;
      else
         return Cle_Presente(arbre.all.Fils_droit,Cle) or Cle_Presente(arbre.all.Fils_gauche,Cle);
      end if;
   end Cle_Presente;

   function La_Donnee (arbre : in T_arbre ; Cle : in T_Cle) return T_Donnee is
   begin
      if Est_Vide(arbre) then
         raise Cle_Absente_Exception;
      elsif arbre.All.Cle = Cle then
         return arbre.all.Donnee;
      elsif Cle_Presente(arbre.all.Fils_gauche, Cle) then
         return La_Donnee(arbre.All.Fils_gauche, Cle);
      else
         return La_Donnee(arbre.All.Fils_droit, Cle);
      end if;
   end La_Donnee;


   procedure Enregistrer(arbre : in out T_arbre ; Cle : in T_Cle ; Donnee : in T_Donnee) is

   begin
      if arbre = null then
          arbre:= new T_Element'(Cle,Donnee, null, null);
          elsif arbre.All.Cle = Cle then
              arbre.All.Donnee := Donnee;
          else
              Enregistrer(arbre.All.Fils_droit, Cle, Donnee);
          end if;
   end Enregistrer;

   Procedure Supprimer(arbre : in out T_arbre ; Cle : in T_Cle) is
       A_Supprimer : T_arbre;
   begin
       if Est_Vide(arbre) then
           raise Cle_Absente_Exception;
       elsif arbre.All.Cle = Cle then
           if not(Est_Vide(arbre.All.Fils_droit)) and not(Est_Vide(arbre.All.Fils_gauche)) then
               raise Suppression_impossible_Exception;
           else
               A_Supprimer := arbre;
               if Est_Vide(arbre.All.Fils_droit) then
                   arbre := arbre.All.Fils_gauche;
               else
                   arbre := arbre.All.Fils_droit;
               end if;
           end if;
           Free(A_Supprimer);
       elsif Cle_Presente(arbre.All.Fils_gauche,Cle) then
           Supprimer(arbre.all.Fils_gauche,Cle);
       elsif Cle_Presente(arbre.All.Fils_droit,Cle) then
           Supprimer(arbre.all.Fils_droit,Cle);
       else
           raise Cle_Absente_Exception;
       end if;

   end Supprimer;

   procedure Parcours_Infixe(arbre : in out T_arbre) is
   begin
      if not(Est_Vide(arbre)) then
          if not(Est_Vide(arbre.all.Fils_gauche)) then
              Parcours_Infixe(arbre.all.Fils_gauche);
          end if;
          Traiter(arbre.all.Cle, arbre.all.Donnee);
          if not(Est_Vide(arbre.all.Fils_droit)) then
              Parcours_Infixe(arbre.all.Fils_droit);
          end if;
  end if;
   end Parcours_Infixe;

end arbre;
