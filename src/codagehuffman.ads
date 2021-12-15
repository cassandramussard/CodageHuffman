with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Cellule;

generic
<<<<<<< HEAD
    type T_Donnee is private;
    type T_Cle is private;

package Huffman is
    type T_Tableau is limited private;
    type T_Cellule is limited private;

-- Calculer les frÃ©quences des caractÃ¨res du texte
  function Calcul_Frequence(texte : in String) return T_Tableau;
--Trier par ordre croissant le tableau de frÃ©quence
  function Tri_fusion(Tableau : in T_Tableau) return T_Tableau;

-- Construire l'arbre de Huffman grÃ¢ce aux frÃ©quences des caractÃ¨res
    function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;

-- Afficher l'arbre de Huffman
  procedure Afficher_Arbre(Cellule : in T_Cellule);

-- Compresser le fichier
  function Compresser_ficher(texte : in String) return String;
=======
   type T_Donnee is private;
   type T_Cle is private;

package codageHuffman is
   type T_Tableau is limited private;
   type T_Cellule is limited private;

   -- Calculer les frÉquences des caractères du texte
   function Calcul_Frequence(texte : in String) return T_Tableau;
   --Trier par ordre croissant le tableau de frÉquence
   procedure Tri_fusion(Tableau : in out T_Tableau);

   -- Construire l'arbre de Huffman grâce aux fréquences des caractères
   function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule;
>>>>>>> c02208e4dd125262a9b3baa7e1abfdf5b36c8827

-- DÃ©compresser le fichier
  function Decompresser_fichier(texte : in String) return String;

<<<<<<< HEAD
  generic
        with procedure Traiter(Frequence : in Integer; Caractere : in Character);
  procedure Parcours_infixe(Tableau : in T_Tableau);
=======
   -- Compresser le fichier
   function Compresser_ficher(texte : in String) return String;

   -- Décompresser le fichier
   function Decompresser_fichier(texte : in String) return String;
>>>>>>> c02208e4dd125262a9b3baa7e1abfdf5b36c8827

   generic
      with procedure Traiter(Frequence : in Integer; Caractere : in Character);
   procedure Parcours_infixe(Tableau : in T_Tableau);

private
<<<<<<< HEAD
    type T_Element;
=======

   type T_Element;
>>>>>>> c02208e4dd125262a9b3baa7e1abfdf5b36c8827

   type T_Cellule is access T_Element;

   type T_Element is
      record
         Donnee : T_Donnee;
         Cle : T_Cle;
         Fils_gauche : T_Cellule;
         Fils_droit : T_Cellule;
      end record;
<<<<<<< HEAD
  package Cellule_Huffman is
    new Cellule(T_Cle => T_Cle, T_Donnee => T_Donnee);
  use Cellule_Huffman;

   type T_Tableau is array(0..128) of T_Donnee;
end Huffman;
=======

   type T_Tableau is array(0..128) of T_Donnee;

   package Cellule_Huffman is
     new Cellule(T_Cle => T_Cle, T_Donnee => T_Donnee);
   use Cellule_Huffman;

end codagehuffman;
>>>>>>> c02208e4dd125262a9b3baa7e1abfdf5b36c8827
