package Cellule is
  type T_Cellule is limited private;

-- Initialiser la cellule
  procedure Initialiser(Cellule : out T_Cellule) with

-- Enregistrer une cellule d'une fiche avec ses fils droit et gauche, sa frequence et le caractere
  procedure Enregistrer_fiche(Cellule : in out T_Cellule ; Caractere : in Character ; Frequence : in Integer; Fils_droit : in T_Cellule ; Fils_gauche : in T_Cellule) with

--Enregistrer un noeud en fonction de sa fréquence
  procedure Enregistrer_noeud(Cellule : in out T_Cellule ; frequence : in Integer) with

-- Vérifier si le carctere est présent dans la cellule
  procedure Caractere_Present(Cellule : in T_Cellule ; Caractere : in Character) with

--Vérifier si le fils droit est présent dans la cellule
  procedure Fils_Droit_Present(Cellule : in T_Cellule ; Fils_droit : in T_Cellule) with

  private
    type T_Element;
    type T_Element is
      record
        Fils_gauche : T_Cellule;
        Fils_droit : T_Cellule;
        Frequence : Integer;
        Caractere : Character;
      end record;
end Cellule;
