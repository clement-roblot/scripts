#!/usr/bin/perl -w

# Includes
use strict;
use WWW::Mechanize;
use HTTP::Cookies;
use Getopt::Std;
use Date::Calc qw( Day_of_Week );

# Configuration	:	numero projet, nom de la liste, numero du groupe, numero de la classe
my @agendas = (

#arguments
#- numero du projet
#- emploi du temps (élève la pluspart du temps (trainee))
#- un tableau contenant les numero des sections à parcourir avant d'arriver à notre emploi du temps
#- numero de notre enplois du temps
#- la liste des jours qui nous intéressent pour cet emplois du temps (1=lundi, 7=dimanche)
["EII3_SISEA", 
	[
		[14, "trainee", [154], 126, [1, 2, 3, 5, 6, 7]],
		[15, "trainee", [164], 126, [1, 2, 3, 5, 6, 7]],
		[12, "trainee", [4216, 18, 2428], 2446, [4]],
	]
],
["EII3",
	[
		[14, "trainee", [346], 120, [1, 2, 3, 4, 5, 6, 7]],
		[15, "trainee", [346], 46, [1, 2, 3, 4, 5, 6, 7]],
	]
]);

#baulieu : 12, 

my %conf = ( f => "$ENV{HOME}/.perlmonksrc" );
getopts( 'l:f:', \%conf ) or die "Bad parameters";

# Initialisation
my $bot = WWW::Mechanize->new(
agent      => 'Mozilla/15 [en] (X11; I; Linux 2.2.16 i686; Nav)',
cookie_jar => HTTP::Cookies->new(
    file           => $conf{f},
    autosave       => 1,
    ignore_discard => 1,        # le cookie devrait être effacé à la fin
)
);

my $i = 0;
my $j = 0;


#On amorce la communication avec le serveur
$bot->get("http://plannings.univ-rennes1.fr/ade/standard/direct_planning.jsp?login=visu&password=");


#On parse les agendas (= classes)
for $i ( 0 .. $#agendas ) 
{	
	#On supprime l'ancien fichier
	unlink("ENSSAT_${agendas[$i][0]}.ics");
	#on ouvre le fichier dans lequel on va coller l'emploi du temps
	open FILE, ">>:utf8", "ENSSAT_${agendas[$i][0]}.ics";
	#on y ajoute les entêtes
	print FILE "BEGIN:VCALENDAR\nMETHOD:REQUEST\nPRODID:-//ADE/version 5.2\nVERSION:2.0\nCALSCALE:GREGORIAN\n"; 
	#variable temporaire
	my @agendaActuel = @{$agendas[$i][1]};
	#On parse les projets de la classe (= semaines)
	for $j ( 0 .. $#agendaActuel )
	{
		#Selection du projet	
		$bot->post("http://plannings.univ-rennes1.fr/ade/standard/direct_planning.jsp?login=visu&password=", [ 'projectId'=>$agendaActuel[$j][0] ]);

		#Selection de la categorie d'emploi du temps
		$bot->get("http://plannings.univ-rennes1.fr/ade/standard/gui/tree.jsp?selectCategory=".$agendaActuel[$j][1]."&scroll=0");

		my @val_to_check = @{$agendaActuel[$j][2]};
		foreach(@val_to_check){

			$bot->get("http://plannings.univ-rennes1.fr/ade/standard/gui/tree.jsp?selectBranchId=".$_."&reset=true&forceLoad=false&scroll=0");
		}

		#selection du groupe
		$bot->get("http://plannings.univ-rennes1.fr/ade/standard/gui/tree.jsp?selectId=".$agendaActuel[$j][3]."&reset=true&forceLoad=false&scroll=0");


		#Exportation
		$bot->get("http://plannings.univ-rennes1.fr/ade/custom/modules/plannings/icalDates.jsp");
		$bot->form_number(1);

		# on remplit les champs de l'export
		$bot->set_fields( startDay => "01", startMonth => "09", startYear => "2000" );
		$bot->set_fields( endDay => "31", endMonth => "12", endYear => "3000", calType => "ical" );
		# on valide le formulaire
		$bot->submit;

		# on sauvegarde le fichier retourné, event par event (pour éviter d'avoir plusieurs entêtes)
		#print FILE $bot->content(); 
		my $data = $bot->content();
		while($data =~ m/BEGIN:VEVENT((.|\s)*?)END:VEVENT/g){

			my $event = $1;


			#on cherche la date de demarage de l'event
			if($event =~ m/DTSTART:((\d)*?)T((\d)*?)Z/){

				my $date = $1;
				my $houre = $3;

				my $year = substr($date, 0, 4);
				my $month = substr($date, 4, 2);
				my $day = substr($date, 6, 2);

				my $day_of_week = Day_of_Week($year, $month, $day);

				my @valide_days = @{$agendaActuel[$j][4]};
				foreach(@valide_days){	#on parse le tableau des jours que l'on veut garder

					if($day_of_week == $_){	#si celui de l'event est dans le tableau

						#alors on l'affiche dans le calendrier
						print FILE "BEGIN:VEVENT";
						print FILE "$event";
						print FILE "END:VEVENT\n";
					}
				}
			}else{		#si on ne trouve pas de date de demarage on enregistre l'event (dans le doute)

				print FILE "BEGIN:VEVENT";
				print FILE "$event";
				print FILE "END:VEVENT\n";
			}
		}
	}
	#On finit le fichier
	print FILE "END:VCALENDAR";
	#On ferme le fichier
	close FILE;
}
