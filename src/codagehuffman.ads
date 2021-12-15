with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Cellule;

package codagehuffman is

    package Cellule_Huffman is
            new Cellule(T_Cle => Character, T_Donnee => Integer);
    use Cellule_Huffman;

    type T_Tableau is limited private;


    -- Calculer les fr�quences des caract�res du texte
    function Calcul_Frequence(texte : in String) return T_Tableau;
    --Trier par ordre croissant le tableau de fr�quence
    function Tri(Tableau : in out T_Tableau; premier : in Integer; dernier : in Integer) return Integer;

    procedure  Tri_rapide(Tableau : in out T_Tableau ; premier : in Integer; dernier : in Integer);

    -- Construire l'arbre de Huffman gr�ce aux fr�quences des caract�res
    function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;

    -- Décompresser le fichier
    function Decompresser_fichier(texte : in String) return String;

    -- Compresser le fichier
    function Compresser_ficher(texte : in String) return String;

    generic
        with procedure Traiter(Frequence : in Integer; Caractere : in Character);
    procedure Parcours_infixe(Tableau : in T_Tableau);

private

    type T_Tableau is array(0..128) of Integer;


end codagehuffman;
