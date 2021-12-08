
with Cellule;

package Huffman is
  type T_Tableau is array(0..128) of Integer;

-- Calculer les fréquences des caractères du texte
  procedure Calcul_Frequence(Tableau : in out T_Tableau; texte : in String) with

-- Construire l'arbre de Huffman grâce aux fréquences des caractères
  procedure Construire_Arbre(Tableau : in T_Tableau; Cellule : in T_Cellule) with

-- Afficher l'arbre de Huffman
  procedure Afficher_Arbre(Tableau : in T_Tableau) with

-- Compresser le fichier
  procedure Compresser_ficher(Tableau : in T_Tableau; Ch_Bin : in out String; caractere : in Character, texte : in String; T_char : in out T_tableau)

-- Décompresser le fichier
  procedure Decompresser_fichier(Tableau : in out T_Tableau ; Ch_Arb : out String ; caracteres : in Character )


private
  package Cellule_Huffman is
    new Cellule(Fils_gauche => T_Cellule, Fils_droit => T_Cellule, Frequence => Integer, Caractere => Character)
    use Cellule_Huffman;
end Huffman;
