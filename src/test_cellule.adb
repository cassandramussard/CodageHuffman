with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with SDA_Exceptions; 		use SDA_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
	--! Les Unbounded_String ont une capacité variable, contrairement au String
	--! pour lesquelles une capacité doit être fixée.
with Cellule;

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
	procedure Construire_Exemple_Sujet (Cellule : out T_Cellule; Bavard: Boolean := False) is
	begin
		Initialiser (Cellule);
		pragma Assert (Est_Vide (Cellule));


		for I in 1..7 loop
			Enregistrer (Cellule, Frequence(I), Caractere(I));

			if Bavard then
				Put_Line ("Après insertion du caractere " & Caractere(I));
				Afficher (Cellule); New_Line;
			else
				null;
			end if;

			pragma Assert (not Est_Vide (Cellule));


			for J in 1..I loop
				pragma Assert (Frequence(Cellule, Caractere(J)) = Frequence(J));
			end loop;

			for J in I+1..7 loop
				pragma Assert (not Caractere_Present(Cellule, Caractere(J)));
			end loop;

		end loop;
	end Construire_Exemple_Sujet;


	procedure Tester_Exemple_Sujet is
		Cellule : T_Cellule;
	begin
		Construire_Exemple_Sujet (Cellule, True);
		Vider (Cellule);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commençant par les derniers éléments ajoutés
	procedure Tester_Supprimer_Inverse is
		Cellule : T_Cellule;
	begin
		Put_Line ("=== Tester_Supprimer_Inverse..."); New_Line;

		Construire_Exemple_Sujet (Cellule);

		for I in reverse 1..7 loop

			Supprimer (Cellule, Caractere(I));

			Put_Line ("Après suppression de " & Caractere (I) & " :");
			Afficher (Cellule); New_Line;

			for J in 1..I-1 loop
				pragma Assert (Caractere_Present(Cellule, Caractere(J)));
				pragma Assert (La_Frequence(Cellule, Caractere(J)) = Frequence(J));
			end loop;

			for J in I..7 loop
				pragma Assert (not Caractere_Present(Cellule, Caractere (J)));
			end loop;
		end loop;

		Vider (Cellule);
	end Tester_Supprimer_Inverse;


	-- Tester suppression en commençant les les premiers éléments ajoutés
	procedure Tester_Supprimer is
		Cellule : T_Cellule;
	begin
		Put_Line ("=== Tester_Supprimer..."); New_Line;

		Construire_Exemple_Sujet (Cellule);

		for I in 1..7 loop
			Put_Line ("Suppression de " & Caractere (I) & " :");

			Supprimer (Cellule, Caractere(I));

			Afficher (Cellule); New_Line;

			for J in 1..I loop
				pragma Assert (not Caractere_Present(Cellule, Caractere (J)));
			end loop;

			for J in I+1..7 loop
				pragma Assert (Caractere_Present(Cellule,Caractere(J)));
				pragma Assert (La_Frequence(Annuaire, Caractere(J)) = Frequence (J));
			end loop;
		end loop;

		Vider (Cellule);
	end Tester_Supprimer;


	procedure Tester_Supprimer_Un_Element is

		-- Tester supprimer sur un élément, celui à Indice dans Cles.
		procedure Tester_Supprimer_Un_Element (Indice: in Integer) is
			Cellule : T_Cellule;
		begin
			Construire_Exemple_Sujet (Cellule);

			Put_Line ("Suppression de " & Caractere (Indice) & " :");
			Supprimer (Cellule, Caractere (Indice));

			Afficher (Cellule); New_Line;

			for J in 1..7 loop
				if J = Indice then
					pragma Assert (not Caractere_Present (Cellule, Caractere(J)));
				else
					pragma Assert (Caractere_Present (Cellule, Caractere(J)));
				end if;
			end loop;

			Vider (Cellule);
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
			Cellule : T_Cellule;
		begin
			Construire_Exemple_Sujet (Cellule);

			Put_Line ("Remplacement de " & Caractere(Indice)
					& " par " & Integer'Image(Nouveau) & " :");
			Enregistrer(Cellule, Caractere(Indice), Nouveau);

			Afficher (Cellule); New_Line;

			for J in 1..7 loop
				pragma Assert (Caractere_Present (Cellule, Caractere(J)));
				if J = Indice then
					pragma Assert (La_Frequence (Cellule, Caractere(J)) = Nouveau);
				else
					pragma Assert (La_Frequence (Cellule, Caractere (J)) = Frequence (J));
				end if;
			end loop;

			Vider (Cellule);
		end Tester_Remplacer_Un_Element;

	begin
		Put_Line ("=== Tester_Remplacer_Un_Element..."); New_Line;

		for I in 1..7 loop
			Tester_Remplacer_Un_Element (I, 0);
			null;
		end loop;
	end Tester_Remplacer_Un_Element;


	procedure Tester_Supprimer_Erreur is
		Cellule : T_Cellule;
	begin
		begin
			Put_Line ("=== Tester_Supprimer_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Cellule);
			Supprimer (Cellule, Inconnu);

		exception
			when Caractere_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider (Cellule);
	end Tester_Supprimer_Erreur;


	procedure Tester_La_Frequence_Erreur is
		Cellule: T_Cellule;
		Inutile: Integer;
	begin
		begin
			Put_Line ("=== Tester_La_Frequence_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Cellule);
			Inutile := La_Donnee (Cellule, Inconnu);

		exception
			when Caractere_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Vider (Cellule);
	end Tester_La_Frequence_Erreur;




begin
	Tester_Exemple_Sujet;
	Tester_Supprimer_Inverse;
	Tester_Supprimer;
	Tester_Supprimer_Un_Element;
	Tester_Remplacer_Un_Element;
	Tester_Supprimer_Erreur;
	Tester_La_DFrequence_Erreur;
	Put_Line ("Fin des tests : OK.");
end Test_LCA;
