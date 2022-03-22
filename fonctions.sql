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
				if i >= debut then
					if substr(left(chaine, i), i) = lettre then
						raise info 'Lettre détectée pour la lettre n°%', i;
						nb_occurences := nb_occurences +1;
					else
						raise info 'aucune correspondance pour la lettre n°%', i;
					end if;
					exit when i = fin;
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

create or replace function nb_occurencesWhile( lettre char, chaine varchar, debut integer, fin integer ) returns integer as 
$$
	DECLARE
		nb_occurences integer := 0;
		i integer := 0;
	BEGIN
		if debut >= 0 and fin <= length(chaine) and fin > 0 then
			while i <= fin loop
				if i >= debut then
					if substr(left(chaine, i), i) = lettre then
						raise info 'Lettre détectée pour la lettre n°%', i;
						nb_occurences := nb_occurences +1;
					else
						raise info 'aucune correspondance pour la lettre n°%', i;
					end if;
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


create or replace function getNbJoursParMois(date date) returns date as
$$
	BEGIN
		return (date_trunc('month', $1) + interval '1 month' - interval '1 day')::date;
	END;
$$ language plpgsql;


create or replace function dateSqlToDatefr(date date) returns date as
$$
	BEGIN
		return to_char(date, 'dd/mm/yyyy');
	END;
$$ language plpgsql;


create or replace function getNomJour(date date) returns varchar as
$$
	DECLARE
		jours varchar[] := array ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'vendredi', 'Samedi', 'Dimanche'];
	BEGIN
		return jours[extract(dow from date)];
	END;
$$ language plpgsql;


\c hhbdirect;
create or replace function getNbClientsDebiteurs() returns integer as
$$
	BEGIN
		
	END;
$$ language plpgsql;

create or replace function getNbClientsParVille(ville varchar) returns integer as
$$	
	DECLARE
		villeClient record;
	BEGIN
		select adresse_client into villeClient from client where instr( adresse_client, ville, 1) = 7;
		raise info 'villeClient : %', villeClient;
		return count(villeClient); 
	END;
$$ language plpgsql;

