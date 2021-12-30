with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Cellule_Exceptions; 	use Cellule_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Huffman;

procedure Test_Huffman is

   package Huffman_String_Integer is
     new Huffman(T_Cle => Unbounded_String, T_Donnee => Integer);
   use Huffman_String_Integer;

   function Avec_Guillemets (S: Unbounded_String) return String is
   begin
      return '"' & To_String (S) & '"';
   end;

   function "&" (Left: String; Right: Unbounded_String) return String is
   begin
      return Left & Avec_Guillemets (Right);
   end;

   function "+" (Item : in String) return Unbounded_String
                 renames To_Unbounded_String;

   -- Afficher une Unbounded_String et un entier.
   procedure Afficher (S : in Unbounded_String; N: in Integer) is
   begin
      Put (Avec_Guillemets (S));
      Put (" : ");
      Put (N, 1);
      New_Line;
   end Afficher;

    Donnees : constant array (1..10) of Integer
			:= (2, 5, 1, 1, 15, 2, 4, 3, 5,4);
    Cles : constant array (1..10) of Unbounded_String
			:= (+"\n", +" ", +":", +"d", +"e",
				+"l", +"m", +"p", +"t", +"x");
    procedure Afficher is
     new Parcours_Infixe(Afficher);

   texte : string := "exemple de texte :" ;


   procedure Test_Calcul_Frequence(texte : in String) is
    begin
        pragma Assert(Calcul_Frequence(texte) = Donnees) ;
   end Test_Calcul_Frequence;

   procedure Test_Construire_Arbre(Tableau : in T_Tableau) is

      procedure Parcours_Infixe_verif(Cellule : in T_Cellule; Feuilles : in Unbounded_String) is
      begin
         if not(Est_Vide(Cellule.all.Fils_gauche)) then
            Parcours_Infixe(Cellule.all.Fils_gauche);
         end if;
         if Est_Feuille(Cellule) then
            pragma assert(Cellule.All.Cle = Unbounded_String(0));
         end if;
         if not(Est_Vide(Cellule.all.Fils_droit)) then
            Parcours_Infixe(Cellule.all.Fils_droit);
         end if;
      end Parcours_Infixe_verif;
      Feuille : string := " ipnCsItcxmu";
      begin
         Cellule := Construire_Arbre(Tableau);
      end Test_Construire_Arbre;

      procedure Test_Compresser_ficher(texte : in String) is
      begin
         pragma Assert(Compresser_fichier(texte) = "11.001.11.000.1011.0101.11.011.10101.11.011.100.11.001.100.11.011.10100.0100.11.001.11.000.1011.100.11.011.100.11.000.1011.11.100.11.011.0101.11.001.11.000.11.0100") ;
      end Test_Compresser_ficher;

      procedure Test_Decompresser_fichier(texte : in String) is
      begin
         pragma Assert(Decompresser_fichier(texte)="exemple de texte :");
      end Test_Decompresser_fichier;


   begin
      Test_Calcul_Frequence;
      Test_Construire_Arbre;
      Test_Compresser_ficher;
      Test_Decompresser_fichier;
   end Test_Huffman;
