with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Cellule;

generic
   type T_Donnee is private;
   type T_Cle is private;

package codageHuffman is
   type T_Tableau is limited private;
   type T_Cellule is limited private;

   -- Calculer les fr�quences des caract�res du texte
   function Calcul_Frequence(texte : in String) return T_Tableau;
   --Trier par ordre croissant le tableau de fr�quence
   procedure Tri_fusion(Tableau : in out T_Tableau);

   -- Construire l'arbre de Huffman gr�ce aux fr�quences des caract�res
   function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;

-- Décompresser le fichier
  function Decompresser_fichier(texte : in String) return String;

   -- Compresser le fichier
   function Compresser_ficher(texte : in String) return String;

   -- D�compresser le fichier
   function Decompresser_fichier(texte : in String) return String;

   generic
      with procedure Traiter(Frequence : in Integer; Caractere : in Character);
   procedure Parcours_infixe(Tableau : in T_Tableau);

private

   type T_Element;

   type T_Cellule is access T_Element;

   type T_Element is
      record
         Donnee : T_Donnee;
         Cle : T_Cle;
         Fils_gauche : T_Cellule;
         Fils_droit : T_Cellule;
      end record;

   type T_Tableau is array(0..128) of T_Donnee;

   package Cellule_Huffman is
     new Cellule(T_Cle => Character, T_Donnee => Integer);
   use Cellule_Huffman;

end codagehuffman;
