with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with arbre_Exceptions; 		use arbre_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with arbre;

procedure Test_arbre is

	package arbre_String_Integer is
		new arbre(T_Cle => Unbounded_String, T_Donnee => Integer);
	use arbre_String_Integer;


	-- Retourner une chaîne avec des guillemets autour de S
	function Avec_Guillemets (S: Unbounded_String) return String is
	begin
		return '"' & To_String (S) & '"';
	end;

	-- Utiliser & entre String à gauche et Unbounded_String à droite.  Des
	-- guillemets sont ajout�es autour de la Unbounded_String
	-- Il s'agit d'un masquage de l'op�rteur & d�fini dans Strings.Unbounded
	function "&" (Left: String; Right: Unbounded_String) return String is
	begin
		return Left & Avec_Guillemets (Right);
	end;


	-- Surcharge l'op�rateur unaire "+" pour convertir une String
	-- en Unbounded_String.
	-- Cette astuce permet de simplifier l'initialisation
	-- de cles un peu plus loin.
	function "+" (Item : in String) return Unbounded_String
		renames To_Unbounded_String;


	-- Afficher une Unbounded_String et un entier.
	procedure Afficher (S : in out Unbounded_String; N: in out Integer) is
	begin
		Put (Avec_Guillemets (S));
		Put (" : ");
		Put (N, 1);
		New_Line;
	end Afficher;

  procedure Afficher is
          new Parcours_Infixe(Afficher);

	Nb_Cles : constant Integer := 7;
	Cles : constant array (1..Nb_Cles) of Unbounded_String
			:= (+"a", +"e", +"f", +"p", +"k",
				+"b", +"i");
	Inconnu : constant  Unbounded_String := To_Unbounded_String ("Inconnu");

	Donnees : constant array (1..Nb_Cles) of Integer
			:= (10, 23, 3, 2, 1, 4, 6);
	Somme_Donnees : constant Integer := 135;
	Somme_Donnees_Len4 : constant Integer := 7; -- somme si Length (Cle) = 4
	Somme_Donnees_Q: constant Integer := 103; -- somme si initiale de Cle = 'q'


	-- Initialiser l'annuaire avec les Donnees et Cles ci-dessus.
	-- Attention, c'est à l'appelant de lib�rer la m�moire associ�e en
	-- utilisant Vider.
	-- Si Bavard est vrai, les insertions sont trac�es (affich�es).
	procedure Construire_Exemple_Sujet (Arbre : out T_arbre; Bavard: Boolean := False) is
  Caractere : constant array (1..7) of Character
			:= ('a', 'm', 'e', 'l', 'r');
  Frequence : constant array (1..7) of Integer
			:= (18, 10, 20, 5, 8);
  Tableau

  procedure Afficher (S : in Character; N: in Integer) is
  	begin
  		Put (S);
  		Put (" : ");
  		Put (N, 1);
  		New_Line;
      end Afficher;
	-- Initialiser l'annuaire avec les Donnees et Cles ci-dessus.
	-- Attention, c'est à l'appelant de libérer la mémoire associée en
	-- utilisant Vider.
	-- Si Bavard est vrai, les insertions sont tracées (affichées).
	procedure Construire_Exemple_Sujet (arbre : out T_arbre; Bavard: Boolean := False) is
	begin
		Initialiser (Arbre);
		pragma Assert (Est_Vide (Arbre));


		for I in 1..7 loop
			Enregistrer (Arbre, Frequence(I), Caractere(I));

			if Bavard then
				Put_Line ("Après insertion de la cle " & Cles (I));
				Afficher (Arbre); New_Line;
				Put_Line ("Après insertion du caractere " & Caractere(I));
				Afficher (Arbre);
				New_Line;
			else
				null;
			end if;

			pragma Assert (not Est_Vide (arbre));


			for J in 1..I loop
				pragma Assert (Frequence(Arbre, Caractere(J)) = Frequence(J));
			end loop;

			for J in I+1..7 loop
				pragma Assert (not Caractere_Present(Arbre, Caractere(J)));
			end loop;

		end loop;
	end Construire_Exemple_Sujet;


	procedure Tester_Exemple_Sujet is
		Arbre : T_arbre;
	begin
		Put_Line ("=== Tester_Exemple_Sujet...");
		New_Line;
	-- Tester suppression en commençant par les derniers �l�ments ajout�s
		Construire_Exemple_Sujet (Arbre, True);
		Vider (Arbre);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commençant par les derniers éléments ajoutés
	procedure Tester_Supprimer_Inverse is
		Arbre : T_arbre;
	begin
		Put_Line ("=== Tester_Supprimer_Inverse..."); New_Line;

		Construire_Exemple_Sujet (Arbre);

		for I in reverse 1..7 loop
			Supprimer (Arbre, Cles (I));
			Put_Line("Ok");
			Supprimer (Arbre, Caractere(I));
			Put_Line ("Après suppression de " & Caractere (I) & " :");
			Afficher (Arbre); New_Line;

			for J in 1..I-1 loop
				pragma Assert (Caractere_Present(Arbre, Caractere(J)));
				pragma Assert (La_Frequence(Arbre, Caractere(J)) = Frequence(J));
			end loop;

			for J in I..7 loop
				pragma Assert (not Caractere_Present(Arbre, Caractere (J)));
			end loop;
		end loop;

		Vider (Arbre);
	end Tester_Supprimer_Inverse;


	-- Tester suppression en commençant les les premiers �l�ments ajout�s
	-- Tester suppression en commençant les les premiers éléments ajoutés
	procedure Tester_Supprimer is
		Arbre : T_arbre;
	begin
		Put_Line ("=== Tester_Supprimer..."); New_Line;

		Construire_Exemple_Sujet (Arbre);

		for I in 1..7 loop
			Put_Line ("Suppression de " & Caractere (I) & " :");

			Supprimer (Arbre, Caractere(I));

			Afficher (Arbre); New_Line;

			for J in 1..I loop
				pragma Assert (not Caractere_Present(Arbre, Caractere (J)));
			end loop;

			for J in I+1..7 loop
				pragma Assert (Caractere_Present(Arbre,Caractere(J)));
				pragma Assert (La_Frequence(Arbre, Caractere(J)) = Frequence (J));
			end loop;
		end loop;

		Vider (Arbre);
	end Tester_Supprimer;


	procedure Tester_Supprimer_Un_Element is
		-- Tester supprimer sur un élément, celui à Indice dans Cles.
		procedure Tester_Supprimer_Un_Element (Indice: in Integer) is
			Arbre : T_arbre;
		begin
			Construire_Exemple_Sujet (Arbre);

			Put_Line ("Suppression de " & Caractere (Indice) & " :");
			Supprimer (Arbre, Caractere (Indice));

			Afficher (Arbre); New_Line;

			for J in 1..7 loop
				if J = Indice then
					pragma Assert (not Caractere_Present (Arbre, Caractere(J)));
				else
					pragma Assert (Caractere_Present (Arbre, Caractere(J)));
				end if;
			end loop;

			Vider (Arbre);
		end Tester_Supprimer_Un_Element;

	begin
		Put_Line ("=== Tester_Supprimer_Un_Element..."); New_Line;

		for I in 1..7 loop
			Tester_Supprimer_Un_Element (I);
		end loop;
	end Tester_Supprimer_Un_Element;


	procedure Tester_Remplacer_Un_Element is
		-- Tester enregistrer sur un élément présent, celui à Indice dans Cles.
		procedure Tester_Remplacer_Un_Element (Indice: in Integer; Nouveau: in Integer) is
			Arbre : T_arbre;
		begin
			Construire_Exemple_Sujet (Arbre);

			Put_Line ("Remplacement de " & Caractere(Indice)
					& " par " & Integer'Image(Nouveau) & " :");
			Enregistrer(Arbre, Caractere(Indice), Nouveau);

			Afficher (Arbre); New_Line;

			for J in 1..7 loop
				pragma Assert (Caractere_Present (Arbre, Caractere(J)));
				if J = Indice then
					pragma Assert (La_Frequence (Arbre, Caractere(J)) = Nouveau);
				else
					pragma Assert (La_Frequence (Arbre, Caractere (J)) = Frequence (J));
				end if;
			end loop;

			Vider (Arbre);
		end Tester_Remplacer_Un_Element;

	begin
		Put_Line ("=== Tester_Remplacer_Un_Element..."); New_Line;

		for I in 1..7 loop
			Tester_Remplacer_Un_Element (I, 0);
			null;
		end loop;
	end Tester_Remplacer_Un_Element;


	procedure Tester_Supprimer_Erreur is
		Arbre : T_arbre;
	begin
		begin
			Put_Line ("=== Tester_Supprimer_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Arbre);
			Supprimer (Arbre, Inconnu);

		exception
			when Caractere_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider (Arbre);
	end Tester_Supprimer_Erreur;


	procedure Tester_La_Frequence_Erreur is
		Arbre: T_arbre;
		Inutile: Integer;
	begin
		begin
			Put_Line ("=== Tester_La_Frequence_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Arbre);
			Inutile := La_Donnee (Arbre, Inconnu);

		exception
			when Caractere_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider (Arbre);
	end Tester_La_Donnee_Erreur;


	procedure Tester_Parcours_Infixe is
		Arbre : T_arbre;
		Somme: Integer;
		procedure Sommer(Cle: in out Unbounded_String; Donnee: in out Integer) is
		begin
			Put (" + ");
			Put (Donnee, 2);
			New_Line;
			Somme := Somme + Donnee;
		end;

		procedure Sommer is
			new Parcours_Infixe(Sommer);

	begin
		Put_Line ("=== Tester_Pour_Chaque...");
		New_Line;
		Construire_Exemple_Sujet(Arbre);
		Somme := 0;
		Sommer (Arbre);
		pragma Assert (Somme = Somme_Donnees);
		Vider(Arbre);
		New_Line;
	end Tester_Parcours_Infixe;


	procedure Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q is
		Arbre : T_arbre;

		Somme: Integer;

		procedure Sommer_Cle_Commence_Par_Q (Cle: in out Unbounded_String; Donnee: in out Integer) is
		begin
			if To_String (Cle) (1) = 'q' then
				Put (" + ");
				Put (Donnee, 2);
				New_Line;

				Somme := Somme + Donnee;
			else
				null;
			end if;
		end;

		procedure Sommer is
			new Parcours_Infixe (Sommer_Cle_Commence_Par_Q);

	begin
		Put_Line ("=== Tester_Pour_Chaque_Somme_Si_Cle_Commence_Par_Q..."); New_Line;
		Construire_Exemple_Sujet(Annuaire);
		Somme := 0;
		Sommer (Arbre);
		pragma Assert (Somme = Somme_Donnees_Q);
		Vider(Arbre);
		New_Line;
	end Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q;
		Vider (Arbre);
	end Tester_La_Frequence_Erreur;


begin
	Tester_Exemple_Sujet;
	Tester_Supprimer_Inverse;
	Tester_Supprimer;
	Tester_Supprimer_Un_Element;
	Tester_Remplacer_Un_Element;
	Tester_Supprimer_Erreur;
	Tester_La_Donnee_Erreur;
	Tester_Parcours_Infixe;
	Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q;
	Tester_La_DFrequence_Erreur;
	Put_Line ("Fin des tests : OK.");
end Test_LCA;
