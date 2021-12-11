with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Cellule;

package Codagehuffman is

   package Cellule_String_Integer is
     new Cellule(T_Cle => Unbounded_String, T_Donnee => Integer);
   use Cellule_String_Integer;

   type T_Tableau is array(0..128) of Integer;

   -- Calculer les fréquences des caractères du texte
   function Calcul_Frequence(texte : in String) return T_Tableau;

   -- Trier par fusion le tableau de fréquences
   procedure Tri_fusion(Tableau : in T_Tableau);

   -- Construire l'arbre de Huffman grâce aux fréquences des caractères
   function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;

   -- Afficher l'arbre de Huffman
   procedure Afficher_Arbre(Cellule : in T_Cellule);

   -- Compresser le fichier
   function Compresser_ficher(texte : in String) return String;

   -- Décompresser le fichier
   function Decompresser_fichier(texte : in String) return String;

private

end Codagehuffman;
