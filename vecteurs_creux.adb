with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Character_Text_IO;           use Ada.Character_Text_IO;
with Ada.Unchecked_Deallocation;



package body Vecteurs_Creux is

	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := NULL;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
		A_detruire : T_Vecteur_Creux;
	begin
		while V /= Null loop
			A_detruire := V;
			V := V.all.suivant;
			Free(A_detruire);
		end loop;
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return V = NULL;
	end Est_Nul;


	function Composante_Recursif (V : in T_Vecteur_Creux ; Frequence : in Integer) return Character is
	begin
	if (Est_Nul(V)) or else (V.Frequence > Frequence) then
			return 0.0;
		elsif V.Frequence = Frequence then
			return V.Valeur;
		else
			return Composante_Recursif(V.all.suivant, Frequence);
		end if;
	end Composante_Recursif;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Frequence : in Integer ;
					   Valeur : in Character ) is
	begin
		if Est_Nul(V) then
			if Valeur = 0.0 then
				V := (Valeur, Frequence, V);
			end if;
		elsif V.Frequence = Frequence then
			if Valeur = 0.0 then
				V := V.Suivant;
			else
				V := (Valeur, Frequence, V);
			end if;
		elsif V.Frequence > Frequence then
			if Valeur /= 0.0 then
				V := (Valeur, Frequence, V);
			end if;
		else
			Modifier(V.suivant, Frequence, Valeur);
		end if;
	end Modifier;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			-- Afficher la composante V.all
			Put ("-->[ ");
			Put (V.all.Frequence, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");

			-- Afficher les autres composantes
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


end Vecteurs_Creux;
