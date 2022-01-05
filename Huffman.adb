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

    procedure Tri_rapide(Tableau : in out T_Tableau) is
        
        
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

        procedure Tri_rapide_borne(Tableau : in out T_Tableau ; premier : in Integer; dernier : in Integer) is
            variable : Integer;

        begin
            if premier < dernier then
                variable := Tri(Tableau, premier, dernier);
                Tri_rapide_borne(Tableau, premier, variable-1);
                Tri_rapide_borne(Tableau, variable+1, dernier);
            else
                null;
            end if;
        end Tri_rapide_borne;
        
        procedure Enlever_trou(Tableau : in T_Tableau) is
            Tableau_non_vide : T_Tableau;
            indice_fin : Integer := 0;
        begin
            for i in 1..Tableau'length loop
                if Tableau(I).Donnee /= 0 then
                    Tableau_non_vide(indice_fin) := Tableau(i);
                    indice_fin := indice_fin + 1;
                end if;
            end loop;         
        end Enlever_trou;
               
            
                   
    begin
        Tri_rapide_borne(Tableau,1,Tableau'Length);
    end tri_rapide;

    procedure Construire_Arbre(Tableau : in T_Tableau) is

        Tableau_Construction : T_Tableau;
        Taille : Integer;
    begin
        cellule.all.Fils_gauche := Tableau(1);
        cellule.all.Fils_droit := Tableau(2);
        cellule.all.Donnee := Tableau(1).all.Donnee + Tableau(2).all.Donnee;
        Tableau_Construction(1) := cellule;
        for I in 3..Taille loop
            for J in 1.. Taille loop
                if Tableau(I).all.Donnee = Tableau(I+1).all.Donnee and Tableau(I).all.Donnee = Tableau_Construction(J).all.Donnee then
                    Tableau_Construction(J).all.Fils_gauche := Tableau(I);
                    Tableau_Construction(J).all.Fils_droit := Tableau(I+1);
                    Tableau_Construction(J).all.Donnee := Tableau(I).all.Donnee +Tableau(I+1).all.Donnee;
                    Tri_rapide(Tableau_Construction);
                else
                    Tableau_Construction(I).all.Fils_gauche := Tableau_Construction(I);
                    Tableau_Construction(I).all.Fils_droit := Tableau(J);
                    Tableau_Construction(I).all.Donnee := Tableau_Construction(I).all.Donnee+Tableau(J).all.Donnee;
                    Tri_rapide(Tableau_Construction);
                end if ;
            end loop;
        end loop;
    end Construire_Arbre;

    procedure Afficher_Arbre(cellule : in T_cellule) is
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
