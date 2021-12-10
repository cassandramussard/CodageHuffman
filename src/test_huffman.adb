with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with SDA_Exceptions; 		use SDA_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
	--! Les Unbounded_String ont une capacité variable, contrairement au String
	--! pour lesquelles une capacité doit être fixée.
with Cellule;
with Huffman;
procedure Test_Huffman is

package Cellule_String_Integer is
  new Cellule(T_Cle => Unbounded_String, T_Donnee => Integer);
use Cellule_String_Integer;

-- Retourner une chaîne avec des guillemets autour de S
function Avec_Guillemets (S: Unbounded_String) return String is
begin
  return '"' & To_String (S) & '"';
end;

-- Utiliser & entre String à gauche et Unbounded_String à droite.  Des
-- guillemets sont ajoutées autour de la Unbounded_String
-- Il s'agit d'un masquage de l'opérteur & défini dans Strings.Unbounded
function "&" (Left: String; Right: Unbounded_String) return String is
begin
  return Left & Avec_Guillemets (Right);
end;


-- Surcharge l'opérateur unaire "+" pour convertir une String
-- en Unbounded_String.
-- Cette astuce permet de simplifier l'initialisation
-- de cles un peu plus loin.
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

procedure Afficher is
        new Parcours_Infixe(Afficher);

texte : string := "Ceci est un exemple" ;


procedure Test_Calcul_Frequence(texte : in String) is
  begin
    null;
  end Test_Calcul_Frequence;

procedure Test_Construire_Arbre(Tableau : in T_Tableau) is
begin
  null;
end Test_Construire_Arbre;

procedure Test_Afficher_Arbre(Cellule : in T_Cellule) is
begin
  null;
end Test_Afficher_Arbre;

procedure Test_Compresser_ficher(texte : in String) is
begin
  null;
end Test_Compresser_ficher;

procedure Test_Decompresser_fichier(texte : in String) is
begin
  null;
end Test_Decompresser_fichier;


begin
  Test_Calcul_Frequence;
  Test_Construire_Arbre;
  Test_Afficher_Arbre;
  Test_Compresser_ficher;
  Test_Decompresser_fichier;
end Test_Huffman;
