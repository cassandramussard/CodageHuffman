with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with arbre;

package codagehuffman is

    package Arbre_Huffman is
            new arbre(T_Cle => Character, T_Donnee => Integer);
    use Arbre_Huffman;

    type T_Tableau is limited private;


    -- Calculer les fr�quences des caract�res du texte
    procedure Calcul_Frequence(texte : in String);
    --Trier par ordre croissant le tableau de fr�quence
    function Tri(Tableau : in out T_Tableau; premier : in Integer; dernier : in Integer) return Integer;

    procedure  Tri_rapide(Tableau : in out T_Tableau ; premier : in Integer; dernier : in Integer);

    -- Construire l'arbre de Huffman gr�ce aux fr�quences des caract�res
    procedure Construire_Arbre(Tableau : in T_Tableau; Arbre : out T_arbre);

    -- Décompresser le fichier
    function Decompresser_fichier(texte : in String) return String;

    -- Compresser le fichier
    function Compresser_ficher(texte : in String) return String;

    generic
        with procedure Traiter(Frequence : in Integer; Caractere : in Character);
    procedure Parcours_infixe(Tableau : in T_Tableau);

private

    type T_Tableau is array(0..256) of Integer;


end codagehuffman;
