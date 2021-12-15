with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
<<<<<<< HEAD
with cellule_Exceptions; 		use Cellule_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with cellule;

procedure Test_Cellule is

	package Cellule_String_Integer is
		new Cellule(T_Cle => Unbounded_String, T_Donnee => Integer);
	use Cellule_String_Integer;


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
	procedure Construire_Exemple_Sujet (Annuaire : out T_Cellule; Bavard: Boolean := False) is
=======
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
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
	begin
		Initialiser (Cellule);
		pragma Assert (Est_Vide (Cellule));


		for I in 1..7 loop
			Enregistrer (Cellule, Frequence(I), Caractere(I));

			if Bavard then
<<<<<<< HEAD
				Put_Line ("Après insertion de la cle " & Cles (I));
				Afficher (Annuaire); New_Line;
=======
				Put_Line ("Après insertion du caractere " & Caractere(I));
				Afficher (Cellule); New_Line;
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
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
<<<<<<< HEAD
		Put_Line ("=== Tester_Exemple_Sujet..."); New_Line;
		Construire_Exemple_Sujet (Annuaire, True);
		Vider (Annuaire);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commençant par les derniers �l�ments ajout�s
=======
		Construire_Exemple_Sujet (Cellule, True);
		Vider (Cellule);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commençant par les derniers éléments ajoutés
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
	procedure Tester_Supprimer_Inverse is
		Cellule : T_Cellule;
	begin
		Put_Line ("=== Tester_Supprimer_Inverse..."); New_Line;

		Construire_Exemple_Sujet (Cellule);

		for I in reverse 1..7 loop

<<<<<<< HEAD
			Supprimer (Annuaire, Cles (I));
			Put_Line("Ok");
=======
			Supprimer (Cellule, Caractere(I));
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb

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


<<<<<<< HEAD
	-- Tester suppression en commençant les les premiers �l�ments ajout�s
=======
	-- Tester suppression en commençant les les premiers éléments ajoutés
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
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

<<<<<<< HEAD
		-- Tester supprimer sur un �l�ment, celui à Indice dans Cles.
=======
		-- Tester supprimer sur un élément, celui à Indice dans Cles.
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
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

<<<<<<< HEAD
		-- Tester enregistrer sur un �l�ment pr�sent, celui à Indice dans Cles.
=======
		-- Tester enregistrer sur un élément présent, celui à Indice dans Cles.
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
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
<<<<<<< HEAD
		Vider (Annuaire);
	end Tester_La_Donnee_Erreur;


	procedure Tester_Parcours_Infixe is
		Annuaire : T_Cellule;

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
		Put_Line ("=== Tester_Pour_Chaque..."); New_Line;
		Construire_Exemple_Sujet(Annuaire);
		Somme := 0;
		Sommer (Annuaire);
		pragma Assert (Somme = Somme_Donnees);
		Vider(Annuaire);
		New_Line;
	end Tester_Parcours_Infixe;


	procedure Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q is
		Annuaire : T_Cellule;

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
		Sommer (Annuaire);
		pragma Assert (Somme = Somme_Donnees_Q);
		Vider(Annuaire);
		New_Line;
	end Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q;
=======
		Vider (Cellule);
	end Tester_La_Frequence_Erreur;


>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb


begin
	Tester_Exemple_Sujet;
	Tester_Supprimer_Inverse;
	Tester_Supprimer;
	Tester_Supprimer_Un_Element;
	Tester_Remplacer_Un_Element;
	Tester_Supprimer_Erreur;
<<<<<<< HEAD
	Tester_La_Donnee_Erreur;
	Tester_Parcours_Infixe;
	Tester_Parcours_Infixe_Somme_Si_Cle_Commence_Par_Q;
=======
	Tester_La_DFrequence_Erreur;
>>>>>>> 97ae602963d5c2a58b04745ba3bf662e3c5631cb
	Put_Line ("Fin des tests : OK.");
end Test_LCA;
