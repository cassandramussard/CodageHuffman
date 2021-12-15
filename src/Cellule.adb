with Cellule_Exceptions;         use Cellule_Exceptions;
with Ada.Unchecked_Deallocation;

package body Cellule is

   procedure Free is
     new Ada.Unchecked_Deallocation (Object => T_Element, Name => T_Cellule);

   procedure Initialiser(Cellule: out T_Cellule) is
   begin
      Cellule := NULL;
   end Initialiser;

   function Est_Vide (Cellule : in T_Cellule) return Boolean is
   begin
      if Cellule = NULL then
         return True;
      end if;
      return False;
   end;

   -- Obtenir le nombre d'�l�ments d'une Cellule.
   function Taille (Cellule : in T_Cellule) return Integer is
   begin
      if Est_Vide(Cellule) then
         return 0;
      else
         return 1 + Taille(Cellule.all.Fils_droit) + Taille(Cellule.all.Fils_gauche);
      end if;
   end Taille;

   procedure Vider(Cellule : in out T_Cellule) is
   begin
      if Est_Vide(Cellule) then
         Null;
      else
         Vider(Cellule.all.Fils_droit);
         Vider(Cellule.all.Fils_gauche);
         Free(Cellule);
      end if;
   end Vider;

   function Est_Feuille(Cellule : in T_Cellule) return Boolean is
   begin
      if Est_Vide(Cellule.all.Fils_droit) and Est_Vide(Cellule.all.Fils_gauche) then
         return False;
      end if;
      return True;
   end Est_Feuille;

   function Cle_Presente(Cellule : in T_Cellule ; Cle : in T_Cle) return Boolean is
   begin
      if Est_Vide(Cellule) then
         return False;
      elsif Cellule.all.Cle = Cle then
         return True;
      else
         return Cle_Presente(Cellule.all.Fils_droit,Cle) or Cle_Presente(Cellule.all.Fils_gauche,Cle);
      end if;
   end Cle_Presente;

   function La_Donnee (Cellule : in T_Cellule ; Cle : in T_Cle) return T_Donnee is
   begin
      if Est_Vide(Cellule) then
         raise Cle_Absente_Exception;
      elsif Cellule.All.Cle = Cle then
         return Cellule.all.Donnee;
      elsif Cle_Presente(Cellule.all.Fils_gauche, Cle) then
         return La_Donnee(Cellule.All.Fils_gauche, Cle);
      else
         return La_Donnee(Cellule.All.Fils_droit, Cle);
      end if;
   end La_Donnee;


   procedure Enregistrer(Cellule : in out T_Cellule ; Cle : in T_Cle ; Donnee : in T_Donnee) is
      C_new : T_Cellule;
   begin
      Initialiser(C_new);
      C_new.All.Cle := Cle;
      C_new.All.Donnee := Donnee;
      Cellule.All.Fils_droit := C_new;
   end Enregistrer;

   Procedure Supprimer(Cellule : in out T_Cellule ; Cle : in T_Cle) is
   begin
      if Est_Vide(Cellule) then
         raise Cle_Absente_Exception;
      elsif Cellule.all.Cle /= Cle then
         Supprimer(Cellule.all.Fils_gauche,Cle);
         Supprimer(Cellule.all.Fils_droit,Cle);
      else
         Free(Cellule);
      end if;
   end Supprimer;

   procedure Parcours_Infixe(Cellule : in out T_Cellule) is
   begin
      if not(Est_Vide(Cellule.all.Fils_gauche)) then
         Parcours_Infixe(Cellule.all.Fils_gauche);
      end if;
      if Est_Feuille(Cellule) then
         Traiter(Cellule.all.Cle, Cellule.all.Donnee);
      end if;
      if not(Est_Vide(Cellule.all.Fils_droit)) then
         Parcours_Infixe(Cellule.all.Fils_droit);
      end if;
   end Parcours_Infixe;

end Cellule;
