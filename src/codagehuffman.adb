package body codagehuffman is

   function Calcul_Frequence(texte : in String) return T_Tableau is
      Tableau : T_Tableau;
   begin
      for i in 1..128 loop
         Enregistrer(Tableau(i),Character'Val(i),i);
      end loop ;

      for i in texte'range loop
         Enregistrer(Tableau(Character'Pos(texte(i))), Tableau(Character'Pos(texte(i))).All.Cle, Tableau(Character'Pos(texte(i))).All.Donnee + 1);
      end loop;

      return Tableau;
   end Calcul_Frequence;

   function Tri(Tableau : in out T_Tableau; premier : in Integer; dernier : in Integer) return Integer is
        Index : Integer;
        Pivot : Integer;
    begin
        Index := premier-1;
        Pivot := Tableau(dernier).Donnee;

        for i in premier..dernier loop
            if Tableau(i).Donnee <= Pivot then
                Index := Index +1;
                Tableau(Index).Donnee := Tableau(i).Donnee;
                Tableau(i).Donnee := Tableau(Index).Donnee;
            else
                null;
            end if;

        end loop;
        Tableau(Index+1).Donnee := Tableau(dernier).Donnee;
        Tableau(dernier).Donnee := Tableau(Index+1).Donnee;
        return Index +1 ;
    end Tri;

    procedure Tri_rapide(Tableau : in out T_Tableau ; premier : in Integer; dernier : in Integer) is
        variable : Integer;

    begin
        if premier < dernier then
            variable := Tri(Tableau, premier, dernier);
            Tri_rapide(Tableau, premier, variable-1);
            Tri_rapide(Tableau, variable+1, dernier);
        else
            null;
        end if;

    end Tri_rapide;

function Construire_Arbre(Tableau : in T_Tableau) return T_arbre is
        arbre : T_arbre;
        Tableau_Construction : T_Tableau;
        Tab : T_Tableau;
   begin
        Cellule.all.Fils_gauche := Tab(1);
        arbre.all.Fils_droit := Tab(2);
        arbre.all.Donnee := Tab(1).all.Donnee + Tab(2).all.Donnee;
        Tableau_Construction(1) := arbre;
        for I in 3..Taille loop
            for J in 1.. Taille loop
                if Tab(I).all.Donnee = Tab(I+1).all.Donnee and Tab(I).all.Donnee = Tableau_Construction(J).all.Donnee then
                    Tableau_Construction(J).all.Fils_gauche := Tab(I);
                    Tableau_Construction(J).all.Fils_droit := Tab(I+1);
                    Tableau_Construction(J).all.Donnee := Tab(I).all.Donnee +Tab(I+1).all.Donnee;
                    Tableau_Construction := Tri_rapide(Tableau_Construction, 1, Taille);
                else
                    Tableau_Construction(I).all.Fils_gauche := Tableau_Construction(I);
                    Tableau_Construction(I).all.Fils_droit := Tab(J);
                    Tableau_Construction(I).all.Donnee := Tableau_Construction(I).all.Donnee+Tab(J).all.Donnee;
                    Tableau_Construction := Tri_rapide(Tableau_Construction, 1, Taille);
                end if ;
            end loop;
        end loop;
   end Construire_Arbre;

   procedure Afficher_Arbre(arbre : in T_arbre) is
   begin
      Null;
   end Afficher_Arbre;

   function Compresser_ficher(texte : in String) return String is
   begin
      return "Null";
   end Compresser_ficher;

   function Decompresser_fichier(texte : in String) return String is
   begin
      return "Null";
   end Decompresser_fichier;

   procedure Parcours_infixe(Tableau : in T_Tableau) is
   begin
      Null;
   end Parcours_infixe;

begin

   Null;

end codagehuffman;
