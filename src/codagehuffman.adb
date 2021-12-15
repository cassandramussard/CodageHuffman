package body codagehuffman is

    function Calcul_Frequence(texte : in String) return T_Tableau is
        Tableau : T_Tableau;
    begin
        for i in 1..128 loop
            Tableau(i) := 0;
        end loop ;

        for i in texte'range loop
            Tableau(Character'Pos(texte(i))) := Tableau(Character'Pos(texte(i))) + 1;
        end loop;

        return Tableau;
    end Calcul_Frequence;


    function Tri(Tableau : in out T_Tableau; premier : in Integer; dernier : in Integer) return Integer is
        Index : Integer;
        Pivot : Integer;
    begin
        Index := premier-1;
        Pivot := Tableau(dernier);

        for i in premier..dernier loop
            if Tableau(i)<= Pivot then
                Index := Index +1;
                Tableau(Index) := Tableau(i);
                Tableau(i) := Tableau(Index);
            else
                null;
            end if;

        end loop;
        Tableau(Index+1) := Tableau(dernier);
        Tableau(dernier) := Tableau(Index+1);
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




        function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule is
            Cellule : T_Cellule;
        begin
            return Cellule;
        end Construire_Arbre;

        procedure Afficher_Arbre(Cellule : in T_Cellule) is
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
