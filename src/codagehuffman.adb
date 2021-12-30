package body codagehuffman is

   function Calcul_Frequence(texte : in String) return T_Tableau is
      Tableau : T_Tableau;
   begin
      for i in 1..128 loop
         Enregistrer(Tableau(i),Character'Val(i),i);
      end loop ;

      for i in texte'range loop
         Enregistrer(Tableau(Character'Pos(texte(i))), Tableau(Character'Pos(texte(i))).All.Cle, Tableau(Character'Pos(texte(i))).All.Donnee + 1);
      end loop;

      return Tableau;
   end Calcul_Frequence;

   procedure Tri_Rapide(Tableau : in out T_Tableau) is
   begin
      Null;
   end Tri_Rapide;

   procedure Construire_Arbre(Tableau : in out T_Tableau) is
      Cellule : T_Cellule;
   begin
      Initialiser(Cellule);
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
