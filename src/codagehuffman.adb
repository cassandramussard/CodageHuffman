package body codagehuffman is

   function Calcul_Frequence(texte : in String) return T_Tableau is
      Tableau : T_Tableau;
   begin
      return Tableau;
   end Calcul_Frequence;

   procedure Tri_fusion(Tableau : in out T_Tableau) is
   begin
      Null;
   end Tri_fusion;

   function Construire_Arbre(Tableau : in T_Tableau) return T_Cellule is
      Cellule : T_Cellule;
   begin
      Initialiser(Cellule);
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
