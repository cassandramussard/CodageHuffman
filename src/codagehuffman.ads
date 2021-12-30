with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with cellule;

package codageHuffman is
   type T_Tableau is limited private;

   -- Calculer les fr�quences des caract�res du texte
   function Calcul_Frequence(texte : in String) return T_Tableau;

   --Trier par ordre croissant le tableau de fr�quence
   procedure Tri_Rapide(Tableau : in out T_Tableau);

   -- Construire l'arbre de Huffman gr�ce aux fr�quences des caract�res
   procedure Construire_Arbre(Tableau : in out T_Tableau);

   -- Compresser le fichier
   function Compresser_ficher(texte : in String) return String;

   -- D�compresser le fichier
   function Decompresser_fichier(texte : in String) return String;

   generic
      with procedure Traiter(Frequence : in Integer; Caractere : in Character);
   procedure Parcours_infixe(Tableau : in T_Tableau);

private

   package Cellule_codageHuffman is
     new Cellule(T_Cle => Character, T_Donnee => Integer);
   use Cellule_codageHuffman;

   type T_Tableau is array(0..128) of T_Cellule;


end codagehuffman;
