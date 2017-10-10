- <ID Module> : id["Module"]
	CONDITIONS : 
		GEA.add( id["TV"]), 30, "", {ACTIONS} ) 	- Si la TV est allumée depuis 30 secondes
		GEA.add( id["TV"]!), 30, "", {ACTIONS} ) 	- Si la TV est éteinte depuis 30 secondes
		GEA.add( {72, 73, 74}), 30, "", {ACTIONS} ) - Si les modules 72, 73 et 74 sont ON depuis 30 secondes
		

- Global : {"Global", <nom variable>, <valeur>} - {"Global+", <nom variable>, <valeur>} - {"Global-", <nom variable>, <valeur>} - {"Global!", <nom variable>, <valeur>}
	CONDITIONS :
		GEA.add( {"Global", "JourNuit", "Nuit"}, 30, "", {ACTIONS} ) 		- Si la variable "JourNuit" est égale à "Nuit"
		GEA.add( {"Global", "JourNuit", {"Value", 73}, 30, "", {ACTIONS} )	- Si la variable "JourNuit" est égale à la valeur du module 73
		GEA.add( {"Global+", "Nombre", "2"}, 30, "", {ACTIONS} )	 		- Si la valeur de la variable "Nombre" est SUPERIEURE à 2
		GEA.add( {"Global-", "Nombre", "2"}, 30, "", {ACTIONS} )	 		- Si la valeur de la variable "Nombre" est INFERIEURE à 2
		GEA.add( {"Global!", "Nombre", "2"}, 30, "", {ACTIONS} )			- Si la valeur de la variable "Nombre" est DIFFERENTE de 2

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Global", "JourNuit", "Nuit"} )					- Affecte la valeur "Nuit" à la variable "JourNuit"
		GEA.add( {CONDITIONS}, 30, "", {"Global", {"JourNuit", "Periode"}, "Nuit"} )	- Affecte la valeur "Nuit" AUX variables "JourNuit" ET "Periode"
		GEA.add( {CONDITIONS}, 30, "", {"Global", "JourNuit", {"Value", 73}} )			- Affecte la valeur du module 73 à la variable "JourNuit"

- Value : {"Value", <id module>, <valeur max>} - {"Value+", <id module>, <valeur max>} - {"Value-", <id module>, <valeur max>} - {"Value!", <id module>, <valeur max>}
	CONDITIONS :
		GEA.add( {"Value", 73, 50}, 30, "", {ACTIONS} )		- Si la valeur du module 73 est égale à 50
		GEA.add( {"Value+", 73, 50}, 30, "", {ACTIONS} )	- Si la valeur du module 73 est SUPERIEURE à 50
		GEA.add( {"Value-", 73, 50}, 30, "", {ACTIONS} )	- Si la valeur du module 73 est INFERIEURE à 50
		GEA.add( {"Value!", 73, 50}, 30, "", {ACTIONS} )	- Si la valeur du module 73 est DIFFERENTE de 50

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Value", 73, 50} )			- Affecte la valeur 50 au module 73
		GEA.add( {CONDITIONS}, 30, "", {"Value", {73, 74}, 50} )	- Affecte la valeur 50 AUX modules 73 ET 74

- Value2 : Usage : orientation lamelles stores - cf Value, possibilité d'utilisation d'alias
	ALIAS : 
		{"Slide", 73, 50} ou {"Orientation", 73, 50} sont identiques à {"Value2", 73, 50}

- Property : {"Property", <id_module>, <nom propriété>, <valeur>} - {"Property+", <id_module>, <nom propriété>, <valeur>} - {"Property-", <id_module>, <nom propriété>, <valeur>} - {"Property!", <id_module>, <nom propriété>, <valeur>}
	CONDITIONS : 
		GEA.add( {"Property", 73, "Value", 30}, 30, "", {ACTIONS} ) 		- Si la valeur de la propriété "Value" du module 73 est égale à 30
		GEA.add( {"Property+", 73, "Value", 30}, 30, "", {ACTIONS} ) 		- Si la valeur de la propriété "Value" du module 73 est SUPERIEURE à 30
		GEA.add( {"Property-", 73, "Value", 30}, 30, "", {ACTIONS} ) 		- Si la valeur de la propriété "Value" du module 73 est INFERIEURE à 30
		GEA.add( {"Property!", 73, "Value", 30}, 30, "", {ACTIONS} ) 		- Si la valeur de la propriété "Value" du module 73 est DIFFERENTE de 30

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Property", 73, "Value", 30} )		- Affecte la valeur 30 à la propriété "Value" du module 73
		GEA.add( {CONDITIONS}, 30, "", {"Property", {73, 74}, "Value", 30} )	- Affecte la valeur 30 à la propriété "Value" DES modules 73 ET 74

- turnOn : {"turnOn",<id module>} 
	CONDITIONS : 
		GEA.add( {"turnOn", 73}, 30, "", {ACTIONS} )					- Si le module 73 est allumé

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"turnOn", 73} )					- Allume le module 73
		GEA.add( {CONDITIONS}, 30, "", {"turnOn", {73, 74}} )			- Allume le module 73 ET le module 74
		GEA.add( 73, 30, "", { {"Inverse"}, {"turnOn"} })				- Allume le module 73 SI il est éteint (voir <Inverse>)
		GEA.add( 73!, 30, "", {"turnOn"} )								- Allume le module 73 SI il est éteint (voir <Inverse>)
		GEA.add( {CONDITIONS}, 30, "", {"turnOn", 73, 5*60} )			- Allume le module 73 puis EXTINCTION après 5 mins

- turnOff : {"turnOff",<id module>}
	CONDITIONS : 
		GEA.add( {"turnOff", 73}, 30, "", {ACTIONS} )					- Si le module 73 est éteint

	ACTIONS : 
		GEA.add( 73, 30, "", {"turnOff", 73} )							- Eteint le module 73 SI il est allumé (voir <ID Module>)
		GEA.add( 73, 30, "", {"turnOff"} )								- Eteint le module 73 SI il est allumé (voir <ID Module>)
		GEA.add( {CONDITIONS}, 30, "", {"turnOff", {73, 74}} )			- Eteint le module 73 ET le module 74
		GEA.add( {CONDITIONS}, 30, "", {"turnOff", 73, 5*60} )			- Eteint le module 73 puis le rallume automatiquement après 5 minutes
		GEA.add( {CONDITIONS}, 30, "", {"turnOff", {73, 74}, 5*60} )	- Eteint les modules 73 ET 74 puis LES rallume automatiquement après 5 minutes


- Switch : {"Switch", <id module>}
	CONDITIONS : Ne peut-êre utilisé en tant que CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Switch", 73} )				- Allume OU Eteint le module 73 en fonction de son état (si allumé, on éteint ; si éteint, on allume.)
		GEA.add( {CONDITIONS}, 30, "", {"Switch", {73, 74}} )		- Allume OU Eteint le module 73 ET le module 74 en fonction de leur état (si allumé, on éteint ; si éteint, on allume.)

- Armed : {"Armed", <id module>} - {"setArmed", <id_module>} --> Pour compatibilité avec 5.40
	CONDITIONS : 
		GEA.add( {"Armed", 73}, 30, "", {ACTIONS} ) 				- Ne vérifie QUE si le module 73 est armé
		GEA.add( {"setArmed", 73}, 30, "", {ACTIONS} )				- Ne vérifie QUE si le module 73 est armé --> maintien de la compatibilité en 5.40

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Armed", 73} )				- Arme le module 73
		GEA.add( {CONDITIONS}, 30, "", {"Armed", {73, 74}} )		- Arme le module 73 ET le module 74
		GEA.add( {CONDITIONS}, 30, "", {"setArmed", 73} )			- Arme le module 73 --> maintien de la compatibilité en 5.40
		GEA.add( {CONDITIONS}, 30, "", {"setArmed", {73, 74}} )		- Arme le module 73 ET le module 74 --maintien de la compatibilité en 5.40

- Disarmed : {"Disarmed", <id module>}
	CONDITIONS :
		GEA.add( {"Disarmed", 73}, 30, "", {ACTIONS} ) 					- Ne vérifie QUE si le module 73 est désarmé
		GEA.add( {"setDisarmed", 73}, 30, "", {ACTIONS} ) 				- Ne vérifie QUE si le module 73 est désarmé --> maintien de la compatibilité en 5.40

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Disarmed", 73} )				- Désarme le module 73
		GEA.add( {CONDITIONS}, 30, "", {"Disarmed", {73, 74}} )			- Désarme le module 73 ET le module 74
		GEA.add( {CONDITIONS}, 30, "", {"setDisarmed", 73} )			- Désarme le module 73 --> maintien de la compatibilité en 5.40
		GEA.add( {CONDITIONS}, 30, "", {"setDisarmed", {73, 74}} )		- Désarme le module 73 ET le module 74 --> maintien de la compatibilité en 5.40


- Sensor : {"Sensor", <id module>, <valeur max>}, {"Sensor+", <id module>, <valeur max>}, {"Sensor-", <id module>, <valeur max>}, {"Sensor!", <id module>, <valeur max>}
	CONDITIONS : 
		GEA.add( {"Sensor", 73, 50}, 30, "", {ACTIONS} )		- Si la consommation du module 73 est égale à 50
		GEA.add( {"Sensor+", 73, 50}, 30, "", {ACTIONS} )		- Si la consommation du module 73 est SUPERIEURE à 50
		GEA.add( {"Sensor-", 73, 50}, 30, "", {ACTIONS} )		- Si la consommation du module 73 est INFERIEURE à 50
		GEA.add( {"Sensor!", 73, 50}, 30, "", {ACTIONS} )		- Si la consommation du module 73 est DIFFERENTE de 50

	ACTIONS : Ne peut-être utilisé en tant qu ACTIONS

	ALIAS : 
		{"Power", 73, 50} est identique à {"Sensor", 73, 50}
		{"Power+", 73, 50} est identique à {"Sensor+", 73, 50}
		{"Power-", 73, 50} est identique à {"Sensor-", 73, 50}
		{"Power!", 73, 50} est identique à {"Sensor!", 73, 50}

- VirtualDevice : {"VirtualDevice", <id,_module>, <no_bouton>}
	CONDITIONS : Ne peut-êre utilisé en tant que CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"VirtualDevice", 73, 2} )			- Appui sur le bouton numéro 2 du VirtualDevice numéro 73
		GEA.add( {CONDITIONS}, 30, "", {"VirtualDevice", {73, 74}, 2} )		- Appui sur le bouton numéro 2 du VirtualDevice numéro 73 ET 74

	ALIAS : 
		{"VD", 73, 2} équivaut à {"VirtualDevice", 73, 2}
		{"PressButton", 73, 2} équivaut à {"VirtualDevice", 73, 2}

- Label : {"Label", <id_vd>, <nom label>, <contenu>}, {"Label!", <id_vd>, <nom label>, <contenu>}, {"Label-", <id_vd>, <nom label>, <contenu>}, {"Label+", <id_vd>, <nom label>, <contenu>}
	CONDITIONS : 
		GEA.add( {"Label", 73, "consommation", 30}, 30, "", {ACTIONS} )    - Si la valeur du label "consommation" du VirtualDevice numéro 73 est égale à 30
		GEA.add( {"Label", 73, "JourNuit", "Jour"}, 30, "", {ACTIONS} )    - Si la valeur du label "JourNuit" du VirtualDevice numéro 73 est égale à "Jour"
		GEA.add( {"Label!", 73, "consommation", 30}, 30, "", {ACTIONS} )   - Si la valeur du label "consommation" du VirtualDevice numéro 73 est DIFFERENTE de 30
		GEA.add( {"Label!", 73, "JourNuit", "Jour"}, 30, "", {ACTIONS} )   - Si la valeur du label "JourNuit" du VirtualDevice numéro 73 est DIFFERENTE de "Jour"
		GEA.add( {"Label-", 73, "consommation", 30}, 30, "", {ACTIONS} )   - Si la valeur du label "consommation" du VirtualDevice numéro 73 est INFERIEURE à 30
		GEA.add( {"Label+", 73, "consommation", 30}, 30, "", {ACTIONS} )   - Si la valeur du label "consommation" du VirtualDevice numéro 73 est SUPERIEURE à 30


	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Label", 73, "consommation", 30} ) 			- Affecte la valeur 30 au label "consommation" du VirtualDevice numéro 73
		GEA.add( {CONDITIONS}, 30, "", {"Label", 73, "JourNuit", "Jour"} ) 			- Affecte la valeur "JourNuit" au label "JourNuit" du VirtualDevice numéro 73
		GEA.add( {CONDITIONS}, 30, "", {"Label", {73, 74}, "consommation", 30} ) 	- Affecte la valeur 30 au label "consommation" DES VirtualDevices 73 et 74

- Time : {"Time", <from>, <to>}
	CONDITIONS : 
		GEA.add( {"Time", "22:00", "23:00"}, 30, "", {ACTIONS} )								- Ne vérifie QUE si nous sommes dans la tranches horaires
		GEA.add( {"Time", "07:00", "08:00"}, {"Time", "22:00", "23:00"}, 30, "", {ACTIONS} )	- Ne vérifie QUE si nous sommes dans LES tranches horaires
		GEA.add( {"Time", "Sunrise+30", "Sunset-15"}, 30, "", {ACTIONS} )						- Si tranche horaire : lever du soleil + 30 mins, coucher du soleil - 15 minutes
		GEA.add( {"Time", "Sunrise>07:30", "Sunset<21:00"}, 30, "", {ACTIONS} )					- Si tranche horaire : AU lever du soleil SI après 7h30, sinon à 7h30; Au coucher du soleil SI AVANT 21h SINON à 21h
		GEA.add( {"Time", "22:00"}, 30, "", {ACTIONS} )											- Equivaut à {"Time", "22:00", "22:00"}

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Days : {"Days", <jours>}
	CONDITIONS : 
		GEA.add( {"Days", "Monday"}, 30, "", {ACTIONS} )						- Ne vérifie QUE si nous sommes LUNDI
		GEA.add( {"Days", "Monday, Friday"},30 ,"" , {ACTIONS} )				- Ne vérifie QUE si nous sommes LUNDI ET VENDREDI
		GEA.add( {"Days", "WeekDay"},30 ,"" , {ACTIONS} )				        - Ne vérifie QUE pendant les jours de la semaine
		GEA.add( {"Days", "WeekEnd"},30 ,"" , {ACTIONS} )						- Ne vérifie QUE le WeekEnd

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Dates : {"Dates", <from>, <to>}
	CONDITIONS : 
		GEA.add( {"Dates", "01/01", "31/06"}, 30, "", {ACTIONS} )				- Ne vérifie QUE si la date est comprise entre le 1er janvier et le 31 juin inclus
		GEA.add( {"Dates", "01/01"}, 30, "", {ACTIONS} )						- Equivaut à {"Dates", "01/01", "01/01"}

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- DST : {"DST"} 
	CONDITIONS : 
		GEA.add({"DST"}, 30, "", {ACTIONS} )									- Ne vérifie QUE si nous sommes en mode "Saving time", soit heure d"été"

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- NODST : {"NODST"} 
	CONDITIONS : 	
		GEA.add({"NODST"}, 30, "", {ACTIONS} )									- Ne vérifie QUE si nous sommes en mode heure d"hiver"

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Weather : {"Weather", <propriété>} - {"Weather", <propriété>, <valeur>} - {"Weather+", <propriété>, <valeur>} - {"Weather-", <propriété>, <valeur>} - {"Weather!", <propriété>, <valeur>}
	CONDITIONS : 
		GEA.add( {"Weather", "Cloudy"}, 0, "#value#", {ACTIONS} )				- Ne vérifie QUE si la météo indique "Cloudy" ET retourne la valeur de "Weather" au démarrage de GEA (durée :"0")
		GEA.add( {"Weather+", "Temperature", 20}, 0, "#value#", {ACTIONS} )		- Ne vérifie QUE si la température de la météo est SUPERIEURE à 20 degrés 
		GEA.add( {"Weather+", "Wind", 6}, 0, "#value#", {ACTIONS} )  			- Ne vérifie QUE si la vitesse du vent de la météo est SUPERIEURE à 6 km/h  

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Battery : {"Battery", <id module>, <valeur max>}
	CONDITIONS : 						
		GEA.add( {"Battery", 73, 50}, 30, "", {ACTIONS} )						- Si l"état de la pile du module 73 est inférieure ou égale à 50"

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Batteries : {"Batteries", <valeur max>}
	CONDITIONS : 
		GEA.add( {"Batteries", 50}, 30, "", {ACTIONS} )							- Si l"état de la pile des modules sur pile ont une valeur inférieure ou égale à 50"

	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Dead : {"Dead", <id module>}
	CONDITIONS : 
		GEA.add( {"Dead", 73}, 30, "", {ACTIONS} )								- Vérifie si le module 73 est en noeud mort

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Dead", 73} )							- Réveille le module 73
		GEA.add( {CONDITIONS}, 30, "", {"Dead", {73, 74}} )						- Réveille les module 73 ET 74

	ALIAS : 
		{"WakeUp", {73, 74}} équivaut à {"Dead", {73, 74}}

- SceneActivation : {"SceneActivation", <id module>, <id scene>}
	CONDITIONS : 
		GEA.add( {"SceneActivation", 73, 11}									- Si la scene 11 du module 73 est le déclencheur du script
	
	ACTIONS : Ne peut-êre utilisé comme ACTIONS

- Function : {"Function", function() return true or false, value end} -	"RESERVE AUX DEVELOPPEURS"
	CONDITIONS : 
		GEA.add( {"Function",function() return titi end}, 30, "", {ACTIONS} )   - Si la fonction retourne le resultat

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Function", function() code end} )		- Execute le code présent dans la fonction

- CopyGlobal : {"CopyGlobal", <var_source>, <var_dest>}
	CONDITIONS : Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"CopyGlobal", "Source", "Destination"} )         - Copie la valeur de la variable globale "SOURCE" dans la variable globale "DESTINATION"
	Attention voir "Global" pour : identique à CopyGlobal
		GEA.add( {CONDITIONS}, 30, "", {"Global", "Destination", {"Global", "SOURCE"}} ) - Copie la valeur de la variable globale "SOURCE" dans la variable globale "DESTINATION"

- Portable : {"Portable", <id>}
	CONDITIONS : Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Portable", 25} )					- Le message associé à ce périphérique sera envoyé à ce portable au lieu de ceux par défaut
		GEA.add( {CONDITIONS}, 30, "", {"Portable", {25, 26}} )				- Le message associé à ce périphérique sera envoyé à CES portables au lieu de ceux par défaut

	ALIAS : 
		{"Push", 25} équivaut à {"Portable", 25}

- Email : {"Email", <id_user>} - {"Email", <id_user>, <sujet>}
	CONDITIONS : Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "Envoi d'un mail", {"Email", "2"} ) 						- Envoi le message "Envoi d'un mail" par email à l'utilisateur dont l'ID est 2 
		GEA.add( {CONDITIONS}, 30, "Envoi d'un mail", {"Email", {2, 3}} ) 					- Envoi le message "Envoi d'un mail" par email AUX utilisateurs 2 ET 3
		GEA.add( {CONDITIONS}, 30, "Envoi d'un mail", {"Email", "2", "GEA"} ) 				- Envoi le message "Envoi d'un mail" avec pour SUJET : "GEA" par email à l'utilisateur dont l'ID est 2 
		GEA.add( {CONDITIONS}, 30, "Envoi d'un mail", {"Email", {2, 3}, "GEA"} ) 			- Envoi le message "Envoi d'un mail" avec pour SUJET : "GEA" par email AUX utilisateurs 2 et 3

- CurrentIcon : {"CurrentIcon", <id_module>, <no_icon>} - Pour les VirtualDevices
	CONDITIONS : 
		GEA.add( {"CurrentIcon", 73}, 30, "", {ACTIONS} )									- Retourne l'ID de l'icone du module virtuel 73

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"CurrentIcon", 73, 1002} )							- Affecte au module virtuel 73 l"icone numero 1002"
		GEA.add( {CONDITIONS}, 30, "", {"CurrentIcon", {73, 74}, 1002} )					- Affecte AUX modules virtuels 73 ET 74 l"icone numero 1002"

- Scenario : {"Scenario", <id>} - {"Scenario", <id>, {args}}
	CONDITIONS :  Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Scenario", 23} )										- Lance un scénario selon son identifiant, ici 23
		GEA.add( {CONDITIONS}, 30, "", {"Scenario", {23, 24}} )									- Lance un scénario selon son identifiant, ici 23 ET 24
		GEA.add( {CONDITIONS}, 30, "", {"Scenario", 23, {toto= heure, titi=minutes}} )			- Lance un scénario selon son identifiant, ici 23 avec les arguments toto=heure et titi=minutes
		GEA.add( {CONDITIONS}, 30, "", {"Scenario", {23, 24}, {toto= heure, titi=minutes} } )	- Lance un scénario selon son identifiant, ici 23 ET 24 avec les arguments toto=heure et titi=minutes

	ALIAS : 
		{"start", 23} ou {"startScene", 23} {"Scene", 23} équivaut à {"Scenario", 23}

- Kill : {"Kill", <id_scene>}
	CONDITIONS :  Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Kill", 23} ) 				- Stop la scène numero 23
		GEA.add( {CONDITIONS}, 30, "", {"Kill", {23, 24}} ) 		- Stop LES scènes 23 ET 24

	ALIAS : 
		{"KillScene", 23} équivaut à {"Kill", 23}

- Picture : {"Picture", <id_camera>, <id_user>}
	CONDITIONS : Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Picture", 120, 2} )				- Envoi une capture de la caméra 120 au mail associé à l"utilisateur" dont l"ID" est 2
		GEA.add( {CONDITIONS}, 30, "", {"Picture", 120, {2, 3}} )			- Envoi une capture de la caméra 120 AUX mails associés AUX utilisateurs dont les ID sont 2 et 3

		GEA.add( {CONDITIONS}, 30, "", {"Picture", {120, 121}, 2} )			- Envoi une capture DES caméras 120 et 121 au mail associé à l"utilisateur" dont l"ID" est 2
		GEA.add( {CONDITIONS}, 30, "", {"Picture", {120, 121}, {2, 3}} )	- Envoi une capture DES caméras 120 et 121 AUX mails associés AUX utilisateurs dont les ID sont 2 et 3

	ALIAS : 
		{"Photo", 120, 2} équivaut à {"Picture", 120, 2}

- PictureToEmail : {"PictureToEmail", <id_camera>, <id_user>}
	CONDITIONS : Ne peut-êre utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"PictureToEmail", 120, "adresse@fibaro.com"} )									- Envoi une capture de la caméra 120 à l"adresse" mail spécifiée
		GEA.add( {CONDITIONS}, 30, "", {"PictureToEmail", 120, {"adresse@fibaro.com", "adresse2@fibaro.com"}} )			- Envoi une capture de la caméra 120 AUX adresses mail spécifiées
		GEA.add( {CONDITIONS}, 30, "", {"PictureToEmail", {120, 121}, "adresse@fibaro.com"} )							- Envoi une capture DES caméras 120 et 121 à l"adresse" mail spécifiée
		GEA.add( {CONDITIONS}, 30, "", {"PictureToEmail", {120, 121}, {"adresse@fibaro.com", "adresse2@fibaro.com"}} )	- Envoi une capture DES caméras 120 et 121 AUX adresses mail spécifiées

	ALIAS : 
		{"PhotoToMail", 120, 2} équivaut à {"PictureToEmail", 120, 2}

- Open : {"Open"} - {"Open", <value>} - {"Open", <id>, <value>}
	CONDITIONS : 
		GEA.add( {"Open", 22}, 30, "", {ACTIONS} )			- Retourne le pourcentage d"ouverture" du volet 22

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Open", 35} )				- Ouvre le volet ID 35
		GEA.add( {CONDITIONS}, 30, "", {"Open", {35, 36}} )			- Ouvre LES volets ID 35 ET ID 36
		GEA.add( {CONDITIONS}, 30, "", {"Open", 35, 20} )			- Ouvre le volet ID 35 à 20 %
		GEA.add( {CONDITIONS}, 30, "", {"Open", {35, 36}}, 20} )	- Ouvre LES volets ID 35 ET 36 à 20 %

- Close : {"Close"} - {"Close", <value>} - {"Close", <id>, <value>}
	CONDITIONS : 
		GEA.add( {"Close", 22}, 30, "", {ACTIONS} )			- Retourne le pourcentage de fermeture du volet 22

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Close", 35} )				- Ferme le volet ID 35
		GEA.add( {CONDITIONS}, 30, "", {"Close", {35, 36}} )		- Ferme LES volets ID 35 ET ID 36
		GEA.add( {CONDITIONS}, 30, "", {"Close", 35, 20} )			- Ferme le volet ID 35 à 20 %
		GEA.add( {CONDITIONS}, 30, "", {"Close", {35, 36}}, 20} )	- Ferme LES volets ID 35 ET 36 à 20 %

- Stop : {"Stop", <id_volet> }
	CONDITIONS : Ne peut pas être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Stop", 32} )				- Stop le volet dont l"id" est 32
		GEA.add( {CONDITIONS}, 30, "", {"Stop", {32, 33}} )			- Stop LES volets dont les IDs sont 32 et 33

- ApiPost : {"ApiPost", <url>, <data>}
	CONDITIONS : 
		GEA.add( {"ApiPost", "/devices/6", jsondata}, 30, "", {ACTIONS} ) 

	ACTIONS : 
		GEA.add( {"ApiGet", "/devices/6"}, 30, "", {
			{ "Global", "Test", "#value#"}, 																			- recuperation des valeurs de ApiGet dans la variable globale "Test"
			{"Function", function() local res =json.decode(fibaro:getGlobalValue("Test")) res.toto = valuetoto end}, 	- Traitement du json
			{"ApiPost", "/devices/6", res} 																				- Envoi du json COMPLET
			})

- ApiGet : {"ApiGet", <url>}
	CONDITIONS : 
		GEA.add( {"ApiGet", "/devices/6"}, 30, "", {ACTIONS} )															- Retourne le json du module dont l"ID" est 6
		GEA.add( {"ApiGet", "/devices/6"}, 30, "", { 
			{"Global", "Test", "#value#"},  																			- Recuperation des valeurs de ApiGet dans la variable globale "Test"
			{"Function", function() 
				local res =json.decode(fibaro:getGlobalValue("Test"))													- Traitement du retour json de la variable "Test"
				fibaro:call(id, "setProperty", "ui.toto.value", res.toto) end} 											- Envoi de la valeur toto du json dans une étiquette "toto" du VD "id" 
			})


	ACTIONS : 
		GEA.add ( {CONDITIONS}, 30, "", {"ApiGet", "/devices/6"} ) 														- Envoi un api.get sur le module dont l"ID" est 6

- ApiPut : {"ApiPut", <url>, <data>}
	CONDITIONS : 
		GEA.add( {"ApiPut", "/devices/6", jsondata}, 30, "", {ACTIONS} )												- Retourne le json du device 6

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"ApiPut", "/devices/6", jsondata} )												- Modification json du device 6

- Program : {"Program", <id_module>}, {"Program+", <id_module>}, {"Program-", <id_module>}, {"Program!", <id_module>}, {"Program", <id_module>, <id_program>}
	CONDITIONS : 
		GEA.add( {"Program", 72}, 30, "", {ACTIONS} )			- Retourne le programme en cours du RGB dont l"ID" est 72
		
	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Program", 72, 6} )				- Démarre le programme 6 du RGB 72
		GEA.add( {CONDITIONS}, 30, "", {"Program", {72, 73}, 6} )		- Démarre le programme 6 DES RGBS 72 ET 73

	ALIAS : 
		{"startProgram", 72, 6} équivaut à {"Program", 72, 6}

- ThermostatLevel : {"ThermostatLevel", <id_thermostat>, <value>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"ThermostatLevel", 72, 21} )			- Modifie la température du Thermostat 72 à 21 degrés
		GEA.add( {CONDITIONS}, 30, "", {"ThermostatLevel", {72, 73} 21} )		- Modifie la température DES Thermostats 72 ET 73 à 21 degrés

	ALIAS : 
		{"Thermostat", 72, 21} équivaut à {"ThermostatLevel", 72, 21}

- ThermostatTime : {"ThermostatTime", <id_thermostat>, <time>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"ThermostatTime", 72, 2*60*60} )				- Modifie la durée du thermostat 72 pour 2 heures
		GEA.add( {CONDITIONS}, 30, "", {"ThermostatTime", {72, 73}, 2*60*60} )			- Modifie la durée DES Thermostats 72 ET 73 pour 2 heures


- Ask : {"Ask", <id_portable>, <question>, <id_scene>} - {"Ask", <id_portable>, <id_scene>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Ask", 72, "Question", 23} )						- Push Interactif, pose la "Question" au portable 72 si ma scène 23 doit être executée
		GEA.add( {CONDITIONS}, 30, "", {"Ask", {72, 73}, "Question", 23} )					- Push Interactif, pose la "Question" AUX portables 72 ET 73 si la scène 23 doit être executée
		GEA.add( {CONDITIONS}, 30, "Question", {"Ask", 72, 23} )							- Push Interactif, pose la "Question" au portable 72 si la scène 23 doit être executée
		GEA.add( {CONDITIONS}, 30, "Question", {"Ask", {72, 73}, 23} )						- Push Interactif, pose la "Question" AUX portables 72 et 73 si la scène 23 doit être executée

- Repeat : {"Repeat"}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( id["FENETRE"] ,  10*60, "Fenetre ouverte depuis #duration#", {"Repeat"} )		- Envoi un push TOUTES LES 10 minutes TANT que la fenetre sera ouverte

- NotStart : {"NotStart"}  (Voir "RestartTask")
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS
		
	ACTIONS : 
		local exemple = GEA.add( id["LUMIERE"] , 5*60, "Lumiere allumée depuis #duration#", {"NotStart"} ) 		- Empêche la tâche "exemple" de démarrer automatiquement
		GEA.add( {CONDITIONS}, 30, "Redemarrage exemple", {"RestartTask", exemple} )							- Redemarre la tâche "exemple" (voir "RestartTask")

- Inverse : {"Inverse"} - {"Inverse", <numéro_condition>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS, CONDITIONS2}, 30, "", { {"Inverse"}, {"Inverse", 2} })					- On inverse la condition si elle était vrai, le script retourne faux
		GEA.add( {101, 102}, 30, "", { {"Inverse"}, {"Inverse", 2}, {"turnOn", {101, 102}, 3*60} })		- Si modules 101 ET 102 sont éteints alors on les allume pendant 3 minutes
		GEA.add( {101, 102}, 30, "", { {"Inverse"}, {"Inverse", 2}, {"turnOn",, 3*60} })				- Si modules 101 ET 102 sont éteints alors on les allume pendant 3 minutes

	ALIAS : 
		GEA.add(101!, 30, "", {ACTIONS} ) équivaut à GEA.add(101, 30, "", {"Inverse"} )

- Maxtime : {"MaxTime", <nombre>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"MaxTime", 2} )					- Stoppe une tâche après un certain nombre d"exécution", ici la ligne ne sera executée que 2 fois

- RestartTask : {"RestartTask", <id_tache>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		local autooff = GEA.add(id["LUMIERE"], 2*60, "Lumiere allumée depuis 2 minutes", {"turnOff"} ) 								- SI lumiere allumée depuis 2 minutes, on l"éteint"
		GEA.add(id["DETECTEUR"], -1, "Detection de mouvement, on relance la tache d'extinction auto", {"RestartTask", autooff} )	- Si detection, on relance la tache d"extinction" automatique.
		GEA.add( {CONDITIONS}, -1, "", {"RestartTask", {tache1, tache2}} )															- Relance DES tâches 1 ET 2

- StopTask : {"StopTask", <id_tache>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		local GEAok = GEA.add(true, 2*60, "GEA fonctionne")   			- Envoi push toutes les 2 minutes pour vérifier que GEA fonctionne (evidemment inutile, cela fonctionne tout le temps ;-)
		GEA.add( {CONDITIONS}, 30, "", {"StopTask", GEAok} )  			- Arret de la tache GEAok
		GEA.add( {CONDITIONS}, 30, "", {"StopTask", {tache1, tache2}} ) - Arret DES taches 1 ET 2

- Depend : {"Depend", <id_tache} : ATTEND l"EXECUTION" d"une" ligne AVANT d"en" EXECUTER une AUTRE 
	CONDITIONS :
		local ttslavelinge = GEA.add( {CONDITIONS}, 30, "Le lave-linge est terminé")
		GEA.add( {{"Depend", ttslavelinge}, {"Time", "06:00", "22:00"}}, 0, "Lave linge terminé, si dans tranche horaire : TTS", {"VD", id["SONOS_TTS"], 3} )

	ACTIONS : Ne Peut-être utilisé comme ACTIONS

- Sleep : {"Sleep", <duree_en_secondes>, {ACTIONS} } - EXECUTE une ACTION après une certaine durée. 
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS, 30, "", { {"VD", id["TELCO_TV"], telcotv_mute}, 		- Appui sur bouton mute de la télécommande,
			{"Sleep", 1, {"VD", id["TELCO_TV"], telcotv_ok}} }) 					- Attente de 2 secondes puis Appui sur OK de la télécommande

- VariableCache : {"VariableCache", <nom_variable>, <true/false>} - Utilisable UNIQUEMENT sans la même INSTANCE (inutilisable avec les déclenchements instantanés (-1/0) )
	CONDITIONS :
		GEA.add( {"VariableCache", "ampli", true}, 30, "", {"turnOn", id["TV"]} ) 	- SI la variable en cache (PAS une variable globale) est EGAL à true

	ACTIONS
		GEA.add( id["AMPLI"], 30, "", {"VariableCache", "ampli", true} )			- SI ampli allumé depuis 30 secondes, variable en CACHE à true 

- EnableScenario : {"EnableScenario", <id_scene>}
	CONDITIONS : 
		GEA.add( {"EnableScenario", 22}, 0, "", {ACTIONS} )					- Si la scène 22 est Active. 

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"EnableScenario", 22} )				- Active la scène 22. 
		GEA.add( {CONDITIONS}, 30, "", {"EnableScenario", {22, 23}} )		- Active LES scènes 22 ET 23

	ALIAS : 
		GEA.add({"IsSceneEnabled", 22} ..) équivaut à GEA.add( {"EnableScenario", 22}..)
		GEA.add({CONDITIONS}, 30, "", {"EnableScene", 22}) équivaut à GEA.add( {CONDITIONS}, 30, "", {"EnableScenario", 22} )

- DisableScenario : {"DisableScenario", <id_scene>}
	CONDITIONS : 
		GEA.add( {"DisableScenario", 22}, 0, "", {ACTIONS} )				- Si la scène 22 est INACTIVE

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"DisableScenario", 22} )			- Desactive la scène 22. 
		GEA.add( {CONDITIONS}, 30, "", {"DisableScenario", {22, 23}} )		- Desactive LES scènes 22 ET 23.
	ALIAS : 
		GEA.add({"IsSceneDisabled", 22} ..) équivaut à  GEA.add( {"DisableScenario", 22}, ....)
		GEA.add({CONDITIONS}, 30, "", {"DisableScene", 22}) équivaut à GEA.add( {CONDITIONS}, ..., {"DisableScenario", 22})

- SetrunConfigScenario : {"SetrunConfigScenario", <id_scene>} - {"SetrunConfigScenario", <id_scene>, <run_valeur>} - <run_valeur> : TRIGGER_AND_MANUAL, MANUAL_ONLY, DISABLED
	CONDITIONS : 
		GEA.add( {"SetrunConfigScenario", 22}, 0, "#value#", {ACTIONS} )				- Retourne la valeur de la configuration de démarrage de la scène 22

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"SetrunConfigScenario", 22, "MANUAL_ONLY"} )		- Affecte la valeur de demarrage "MANUAL_ONLY" à la scène 22
		GEA.add( {CONDITIONS}, 30, "", {"SetrunConfigScenario", {22, 23}, "MANUAL_ONLY"} )	- Affecte la valeur de demarrage "MANUAL_ONLY" AUX scènes 22 ET 23

	ALIAS : 
		{"RunConfigScene", 22, "MANUAL_ONLY"} équivaut à {"SetrunConfigScenario", 22, "MANUAL_ONLY"}

- CountScenes : {"CountScenes", <id_scene>}
	CONDITIONS : 
		GEA.add( {"CountScenes", 22}, 30, "#value#" )	- Retourne le nombre d"instances" de la scène 22 en cours. 

	ACTIONS : 
		Ne Peut-être utilisé comme ACTIONS

- Popup : {"Popup", "Titre", "Message"} - Ne fonctionne que si l"application" FIBARO est ouverte
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"Popup", "GEA Popup", "Absence - Lumieres eteintes"} )	- Envoi un Popup annoncant que toutes les lumieres sont eteintes

- DebugMessage : {"DebugMessage", <id_vd>, "0 (mainloop)button_id|", "Message", "error|debug"} -- UNIQUEMENT pour VIRTUAL DEVICE
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"DebugMessage", 32, "0", "VD 32 est ON", "debug"} )		- Mets en debug du VD 32 le message "VD 32 est ON"
		GEA.add( {CONDITIONS}, 30, "VD 32 est ON", {"DebugMessage", 32, "0"} )					- Mets en debug du VD 32 le message "VD 32 est ON"
		GEA.add( {CONDITIONS}, 30, "VD 32 est ON", {"DebugMessage", {32, 33}, "0"} )			- Mets en debug DES VDs 32 ET 33 le message "VD 32 est ON"
		GEA.add( {CONDITIONS}, 30, "VD 32 est KO", {"DebugMessage", 32, "0", "error"} )			- Mets en debug du VD 32 le message "VD 32 est KO" en ROUGE

- Filters : {"Filters", "Lights|Blinds", "turnOff|Close|Open"}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( id["ALARME"], 30, "", {"Filters", "Lights", "turnOff"} )	- SI alarme activée, EXTINCTION de TOUTES les lumieres
		GEA.add( {CONDITIONS}, 30, "", {"Filters", "Blinds", "Close"})		- Fermeture de TOUS les volets

-RGB : {"RGB", <id_module>, <red>, <green>, <blue>, <White>}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"RGB", 72, 100, 0, 100, 100} ) 				- Affecte au RGB 72 les valeurs Red : 100, Green : 0, Blue : 100, White : 100
		GEA.add( {CONDITIONS}, 30, "", {"RGB", {72, 73}, 100, 0, 100, 100} ) 		- Affecte AUX RGBs 72 ET 73 les valeurs Red : 100, Green : 0, Blue : 100, White : 100

- CentralSceneEvent : {"CentralSceneEvent", <id_module>, <keyID>, <keyAttribute>} - utilisable en déclenchement instantané UNIQUEMENT
	CONDITIONS : 
		GEA.add( {"CentralSceneEvent", 72, 1, "Pressed"}, -1, "", {ACTIONS} ) 		- SI le CentralSceneEvent du module 72 a pour keyID : 1 et pour keyAttribute "Pressed"

	ACTIONS : Ne peut-etre utilisé comme ACTIONS

-  Frequency : {"Frequency", "Day", "Number"}
	CONDITIONS : 
		GEA.add( {"Frequency", "Monday", "2"}, 30, "", {ACTIONS} )					- Si la période est : TOUS les LUNDIS de semaine paire
		GEA.add( {"Frequency", "Monday", "1"}, 30, "", {ACTIONS} )					- Si la période est : TOUS les LUNDIS de chaque mois

	ACTIONS : Ne Peut-être utilisé comme ACTIONS

	ALIAS : 
		{"DayEvenOdd", "Monday", "2"} équivaut à {"Frequency", "Monday", "2"}

- RebootHC2 : 
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"RebootHC2"} )			- Redemarrage de la box HomeCenter 2

- ShutdownHC2 : {"ShutdownHC2"}
	CONDITIONS : Ne Peut-être utilisé comme CONDITIONS

	ACTIONS : 
		GEA.add( {CONDITIONS}, 30, "", {"ShutdownHC2"} )		- Arrêt de la box HomeCenter 2

- Alarm : {"Alarm", <id_vd>} - UTILISABLE UNIQUEMENT avec le VirtualDevice GEA.Alarm
	CONDITIONS : 
		GEA.add( {"Alarm", id["VD_ALARM"]}, 0, "", {ACTIONS} )	- Va vérifier la période (jour et heure) précisée correspond à celle indiquée sur GEA.ALARM, si TRANCHE VERIFIEE, ACTIONS executées

	ACTIONS : Ne peut-etre utilisé en ACTIONS

- Info : {"Info", <propriété>, <valeur>}
	CONDITIONS : 
		GEA.add( {"Info", "updateStableAvailable", true}, 24*60*60, "Une nouvelle version est disponible" ) 		- Si la valeur de la propriété updateStableAvailable est égal à true
		GEA.add( { {"Info", "updateBetaAvailable", true },															- Si la valeur de la propriété updateBetaAvailable est égal à true
		 			{"Info!", "newestBetaVersion", "" }}, 															- ET si la valeur de la propriété newestBetaVersion est DIFFERENTE de "vierge"
		 			24*60*60, "Une nouvelle version BETA est disponible #value[2]#")

	ACTIONS : Ne Peut-être utilisé comme ACTIONS
