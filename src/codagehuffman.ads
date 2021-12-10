with Cellule;

package Huffman is
  type T_Tableau is array(0..128) of Integer;

-- Calculer les fréquences des caractères du texte
  function Calcul_Frequence(texte : in String) return T_Tableau;

-- Construire l'arbre de Huffman grâce aux fréquences des caractères
  function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;

-- Afficher l'arbre de Huffman
  procedure Afficher_Arbre(Cellule : in T_Cellule);

-- Compresser le fichier
  function Compresser_ficher(texte : in String) return String;

-- Décompresser le fichier
  function Decompresser_fichier(texte : in String) return String;

private
  package Cellule_Huffman is
    new Cellule(Fils_gauche => T_Cellule, Fils_droit => T_Cellule, Frequence => Integer, Caractere => Character);
    use Cellule_Huffman;
end Huffman;
