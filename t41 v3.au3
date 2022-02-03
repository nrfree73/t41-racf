#pragma compile(FileVersion, 2.0)
#pragma compile(ProductVersion, 2.0)
#pragma compile(FileDescription, [T41 v3.0])
#pragma compile(ProductName, [T41 v3.0])
#pragma compile(LegalCopyright, (01/2022) - Nicolas RISTOVSKI)
#pragma compile(CompanyName, Nicolas RISTOVSKI / EAPI69)

#include <file.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>


if FileExists(@scriptdir & "\t41.ini") Then
;$file=FileOpen(@scriptdir & "\t41.ini",0) ; 0= Read mode (default)
$file=@scriptdir & "\t41.ini"
Else
   $file=@scriptdir & "\t41.ini"
   MsgBox(0,"Premier lancement ?","creation d'un nouveau fichier 't41.ini'")
 IniWrite($file, "Nord-Est", "compte", "D595350x;password")
; IniWrite($file, "Nord-Est", "departements", "02;08;10;21;25;39;51;52;54;55;57;58;59;60;62;67;68;70;71;80;88;89;90")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Nord-Ouest", "compte", "D354090x;password")
; IniWrite($file,"Nord-ouest" , "departements", "14;18;22;27;28;29;35;36;37;41;44;45;49;50;52;53;56;61;72;76;85" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Sud-Est", "compte", "D132340x;password")
; IniWrite($file,"Sud-Est" , "departements","01;03;04;05;06;07;13;15;26;38;42;43;63;69;73;74;83;84;2A;2B" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Sud-Ouest", "compte", "D335990x;password")
; IniWrite($file,"Sud-Ouest" , "departements", "09;11;12;16;17;19;23;24;30;31;32;33;34;40;47;48;64;65;66;79;81;82;86;87")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Ile-de-France",  "compte", "D758520x;password")
; IniWrite($file, "Ile-de-France" , "departements", "75;77;78;91;92;93;94;95")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Outre-MER", "compte", "D941710x;password")
; IniWrite($file,"Outre-MER" , "departements", "971;972;973;974;988")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Website", "t41", "https://stmcv1.sf.intra.laposte.fr:444/ws_t41/T41/canalweb/login.ea" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Temporisation", "logon", "1500" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Rumba", "Macros", "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro" )

;macros samples de base
DirCreate("C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")

FileInstall( "C:\Appliloc\outils exe\macros t41\Rumba-RACF.WDM" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0) ; 0 = ne pas réecrire si existant..
FileInstall( "C:\Appliloc\outils exe\macros t41\Ile-de-France.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
FileInstall( "C:\Appliloc\outils exe\macros t41\Nord-Est.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
FileInstall( "C:\Appliloc\outils exe\macros t41\Nord-Ouest.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
FileInstall( "C:\Appliloc\outils exe\macros t41\Outre-Mer.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
FileInstall( "C:\Appliloc\outils exe\macros t41\Sud-Est.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
FileInstall( "C:\Appliloc\outils exe\macros t41\Sud-Ouest.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;
  MsgBox(0,"Information !","Changez les valeurs de vos comptes dans le fichier généré 't41.ini'" & @crlf & "avec le bloc-notes ... sauvegardez et puis relancez t41.exe" & @crlf & "DSEM/EAPI69: nicolas RISTOVSKI => enjoy t41.exe !" & @crlf & "fichier ini crée sous:" & @crlf & $file)
  Run("notepad.exe " & $file )
   Exit
   EndIf

;DEX	  		file=t41.ini		compte=Identifiant;Mot de Passe
$NordEst= IniRead($file,"Nord-Est","compte",0)		;"D5953505;Th122021"
$depNordEst= IniRead($file,"Nord-Est","departements",0)
if $depNordEst='0' Then
   $depNordEst="02;08;10;21;25;39;51;52;54;55;57;58;59;60;62;67;68;70;71;80;88;89;90"
EndIf

$NordOuest=IniRead($file,"Nord-Ouest","compte",0)	 		;"D3540905;Th122021"
$depNordOuest=IniRead($file,"Nord-Ouest","departements",0)
if $depNordOuest ='0' Then
   $depNordOuest ="14;18;22;27;28;29;35;36;37;41;44;45;49;50;52;53;56;61;72;76;85"
EndIf

$SudEst= IniRead($file,"Sud-Est","compte",0)				;"D1323405;Th122021"
$depSudEst= IniRead($file,"Sud-Est","departements",0)
if $depSudEst ='0' Then
   $depSudEst =  "01;03;04;05;06;07;13;15;26;38;42;43;63;69;73;74;83;84;2A;2B"
EndIf

$SudOuest= IniRead($file,"Sud-Ouest","compte",0) 			;"D3359905;Th122021"
$depSudOuest= IniRead($file,"Sud-Ouest","departements",0)
if $depSudOuest ='0' Then
   $depSudOuest = "09;11;12;16;17;19;23;24;30;31;32;33;34;40;47;48;64;65;66;79;81;82;86;87"
EndIf

$IledeFrance= IniRead($file,"Ile-de-France","compte",0) 		;"D7585205;Th122021"
$depIledeFrance= IniRead($file,"Ile-de-France","departements",0)
if $depIledeFrance ='0' Then
   $depIledeFrance =  "75;77;78;91;92;93;94;95"
EndIf

$OutreMER= IniRead($file,"Outre-MER","compte",0)			;"D9417105;Th122021"
$depOutreMER= IniRead($file,"Outre-MER","departements",0)
if $depOutreMER ='0' Then
   $depOutreMER =  "971;972;973;974;988"
EndIf

$Website= IniRead($file,"Website","t41",0)
if $Website ='0' Then
   $Website = "https://stmcv1.sf.intra.laposte.fr:444/ws_t41/T41/canalweb/login.ea"
EndIf

$Temporisation= IniRead($file,"Temporisation","logon",1500)

$Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf

$navigateur= IniRead($file,"Navigateur","Defaut",0)
;MsgBox(0,"",$navigateur)
 if $navigateur ="" or $navigateur='0' Then
     $navigateur="MSedge"
 ;MsgBox(0,"",$navigateur)
 Elseif $navigateur="Edge" Then
 $navigateur="msedge"
 elseif $navigateur="IE" Then
	$navigateur="iexplore"
EndIf

$tab= IniRead($file,"Navigateur","New",0)
;MsgBox(0,"",$tab)
  if $tab ="" or $tab='0' Then
  $tab="tab"
 ;MsgBox(0,"",$tab)
EndIf


fileclose($file)

$err=0
$dep=""

;$dep=InputBox("Tapez le n° du département","exemple: 01, 02, 69, 2A, 2B, 988 ou 75 ... ","")

while stringlen($dep)<2 or StringLen($dep)>3 and StringIsAlNum($dep) or $dep=""
$dep=InputBox("Tapez le n° du département","N° de Département sur 2 ou sur 3 chiffres !" & @crlf & @crlf & "Pour les nuls: Ain=01, Rhone=69" & @crlf &  "Corse=2A ou 2B, DOM-TOM=971,972,973,974 ou 988. PARIS=75 ... ","")
if @error=1 then
   MsgBox(0,"DSEM/EAPI69/NR","Deja fatigué ?" & @crlf & @crlf & " A bientot !",7)
   Exit ; Cancel Bouton..
   EndIf
WEnd

$identifiant=""
$mdp=""
$DEX=""


;Dex Nord Est
if stringinstr( $depNordEst ,$dep) Then
$DEX="Nord-Est"
$choix=stringsplit($NordEst,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Nord Est" & @crlf & "   " & $identifiant & "   (D59)"

;Dex Sud Est
ElseIf stringinstr( $depSudEst ,$dep) Then
$DEX="Sud-Est"
$choix=stringsplit($SudEst,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Sud Est" & @crlf & "   " & $identifiant & "   (D13)"

;Dex Ile de France
elseif stringinstr( $depIledeFrance ,$dep) Then
$DEX="Ile-de-France"
$choix=stringsplit($IledeFrance,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Ile de France" & @crlf & "   " & $identifiant & "   (D75)"

;Dex Nord Ouest
ElseIf stringinstr( $depNordOuest ,$dep) Then
$DEX="Nord-Ouest"
$choix=stringsplit($NordOuest,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Nord Ouest" & @crlf & "   " & $identifiant & "   (D35)"

;Dex Sud Ouest
elseif stringinstr( $depSudOuest ,$dep) Then
$DEX="Sud-Ouest"
$choix=stringsplit($SudOuest,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Sud Ouest" & @crlf & "   " & $identifiant & "   (D33)"

;Dex Outre Mer
elseif stringinstr( $depOutreMer ,$dep) Then
$DEX="Outre-Mer"
$choix=stringsplit($OutreMER,";")
$identifiant=$choix[1]
$mdp=$choix[2]
   $txt="dép(" & $dep & ") : " & "DEX Outre Mer" & @crlf & "   " & $identifiant & "   (D94)"

Else ;erreur saisie mauvais n° dép.
    MsgBox(0,"dép(" & $dep & ") : " & "??","mauvais n° de département, inconnu ! " & @crlf & @crlf & "Besoin d'une carte à gratter pour les nuls ?")
;	ShellExecute("https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/")
;   -new-window or -new-tab
;
;	shellexecute("firefox",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );,@sw_hide)
;	shellexecute("chrome",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );
;   shellexecute("msedge",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );

if $navigateur<>"iexplore" then
shellexecute($navigateur, "-new-" & $tab & ' "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" )
Else ;IE
   shellexecute($navigateur, '"https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" )
   EndIf

   $err=1
EndIf


if $err=0 Then ;t41 sous Edge...
     $t= MsgBox(4,"Connexion ?",$txt & @crlf & @crlf & "Voulez-vous lancer une connexion à t41 (edge) et Racf (Rumba) ?")

  If $t = 6 Then ;yes
;t41..
 ;ShellExecute($Website)
 if $navigateur<>"iexplore" then
 shellexecute($navigateur, "-new-" & $tab & ' ' & $Website & '',"","" )
 Else
	shellexecute($navigateur,'' & $Website & '',"","" )
	EndIf
;WinWaitActive("Title", "Intranet La Banque Postale - Authentification",15)
sleep($Temporisation) ; en ms...
tooltip("Envoi des credentials t41...",5,5,"")
;send credentials... t41
send($identifiant)
sleep(200)
send("{TAB}")
sleep(500)
send($mdp)
Sleep(200)
Send("{ENTER}")
sleep(500)
ToolTip("",5,5,"")

sleep($Temporisation)

ToolTip ( "Lance la macro Rumba:  Connexion DEX " & $Dex & ".rmc  ",5 ,5 ,"" )
	  ;MsgBox(0,"Executer la macro Rumba !","macro à executer:" & @crlf & @crlf & "   'Connexion DEX" & $Dex & ".rmc'   ")

;Rumba / RACF credentials from macros..
 ShellExecute($rumba & "\Rumba-RACF.WDM" )
sleep(500)
WinWaitActive("[CLASS:WdPageFrame]","",10)
sleep(2000)
send("{ALT}") ; fenetre dialogue ecran Rumba.Wdm pour choix macros
sleep(200)
Send("{O}")
sleep(200)
send("{x}")
;
WinWaitActive("[CLASS:#32770]","",10)
sleep(200)
Send("{TAB}")
sleep(200)

send ( "Connexion DEX " & $Dex )
sleep(200)
;
Send("{TAB}")
sleep(200)
Send("{TAB}")
sleep(200)
;
Send("{ENTER}")
sleep(200)

;
ToolTip("  t41.exe   =>   DSEM/EAPI69/nicolas RISTOVSKI  (12/2021)",5,5,"")
sleep(5000)
ToolTip("",5,5,"")
EndIf ; $t=6 yes


EndIf
