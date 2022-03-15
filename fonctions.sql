create or replace function calculer_longueur_max( c1 varchar(200), c2 varchar(200) ) returns integer as 
$$
	BEGIN
		if length(c1) > length(c2) then 
			return length(c1);
		elsif c1 = c2 then
			raise info 'Les deux chaines sont de même longueur.'; 
			return length(c1);
		else
			return length(c2);
		end if;
	END;
$$ language plpgsql; 


create or replace function nb_occurencesFor( lettre char, chaine varchar, debut integer, fin integer ) returns integer as 
$$
	DECLARE
		nb_occurences integer := 0;
		i integer := 0;
	BEGIN
		if debut >= 0 and fin <= length(chaine) and fin > 0 then
			for i in debut..fin loop
				if substr(left(chaine, i), i) = lettre then
					raise info 'Lettre détectée pour la lettre n°%', i;
					nb_occurences := nb_occurences +1;
				else
					raise info 'aucune correspondance pour la lettre n°%', i;
				end if;
				i := i+1;
			end loop;
			return nb_occurences;
		else
			raise info 'Le début et la fin doivent être compris entre 0 et %', length(chaine);
			return 0;
		end if;
	END;
$$ language plpgsql;

create or replace function nb_occurencesLoop( lettre char, chaine varchar, debut integer, fin integer ) returns integer as 
$$
	DECLARE
		nb_occurences integer := 0;
		i integer := 0;
	BEGIN
		if debut >= 0 and fin <= length(chaine) and fin > 0 then
			loop
				if substr(left(chaine, i), i) = lettre then
					raise info 'Lettre détectée pour la lettre n°%', i;
					nb_occurences := nb_occurences +1;
				else
					raise info 'aucune correspondance pour la lettre n°%', i;
				end if;
				i := i+1;
				exit when i = fin;
			end loop;
			return nb_occurences;
		else
			raise info 'Le début et la fin doivent être compris entre 0 et %', length(chaine);
			return 0;
		end if;
	END;
$$ language plpgsql;

create or replace function nb_occurencesWhile( lettre char, chaine varchar, debut integer, fin integer ) returns integer as 
$$
	DECLARE
		nb_occurences integer := 0;
		i integer := 0;
	BEGIN
		if debut >= 0 and fin <= length(chaine) and fin > 0 then
			while i < fin loop
				if substr(left(chaine, i), i) = lettre then
					raise info 'Lettre détectée pour la lettre n°%', i;
					nb_occurences := nb_occurences +1;
				else
					raise info 'aucune correspondance pour la lettre n°%', i;
				end if;
				i := i+1;
			end loop;
			return nb_occurences;
		else
			raise info 'Le début et la fin doivent être compris entre 0 et %', length(chaine);
			return 0;
		end if;
	END;
$$ language plpgsql;

