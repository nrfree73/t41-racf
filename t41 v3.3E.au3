#pragma compile(FileVersion, 3.3)
#pragma compile(ProductVersion, 3.3)
#pragma compile(FileDescription, [T41 v3.3E])
#pragma compile(ProductName, [T41 v3.3E)
#pragma compile(LegalCopyright, (09/2023) - Nicolas RISTOVSKI)
#pragma compile(CompanyName, Nicolas RISTOVSKI / EAPI69)

#include <file.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

$mois="Janvier;Fevrier;Mars;Avril;Mai;Juin;Juillet;Aout;Septembre;Octobre;Novembre;Decembre"
$tablemois=StringSplit($mois,";")
;_ArrayDisplay($tablemois)
Global $password=stringleft($tablemois[@MON],4) & @YEAR
$LancerRumba=0 		;  pour premier Lancement sans fichier t41.ini
$LancerQuick3270=0  ;  pour premier Lancement sans fichier t41.ini

if FileExists(@scriptdir & "\t41.ini") Then
;$file=FileOpen(@scriptdir & "\t41.ini",0) ; 0= Read mode (default)
$file=@scriptdir & "\t41.ini"
$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
Else

   $tchoix = MsgBox (4, "Info !","  Choix au premier lancement !" & @CRLF & @CRLF &"  Création 't41.ini' pour RACF, utiliser Rumba ou Quick3270 ?" & @CRLF & @CRLF & "[OUI] = Rumba (non SSH)" & @crlf & @crlf & "[NON]= Quick3270 (SSH)")

If $tchoix = 6 Then   ;Rumba
   $LancerRumba=1
   $LancerQuick3270=0
    ;SplashTextOn ("", "Rumba choisi !", 250, 30,-1,-1,1,-1,14,600)
   ; Sleep (2000)
 ElseIf $tchoix = 7 Then ;Quick3270
	$LancerRumba=0
   $LancerQuick3270=1
   ; SplashTextOn ("", "Quick3270 choisi !", 250, 30,-1,-1,1,-1,14,600)
    ;Sleep (2000)
EndIf

   $file=@scriptdir & "\t41.ini"
   MsgBox(0,"Premier lancement ?","creation d'un nouveau fichier 't41.ini'")
 IniWrite($file, "Nord-Est", "compte", "D5983702;password")
; IniWrite($file, "Nord-Est", "departements", "02;08;10;21;25;39;51;52;54;55;57;58;59;60;62;67;68;70;71;80;88;89;90")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Nord-Ouest", "compte", "D4445302;password")
; IniWrite($file,"Nord-ouest" , "departements", "14;18;22;27;28;29;35;36;37;41;44;45;49;50;52;53;56;61;72;76;85" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Sud-Est", "compte", "D0634102;password")
; IniWrite($file,"Sud-Est" , "departements","01;03;04;05;06;07;13;15;26;38;42;43;63;69;73;74;83;84;2A;2B" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Sud-Ouest", "compte", "D3132702;password")
; IniWrite($file,"Sud-Ouest" , "departements", "09;11;12;16;17;19;23;24;30;31;32;33;34;40;47;48;64;65;66;79;81;82;86;87")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Ile-de-France",  "compte", "D7741002;password")
; IniWrite($file, "Ile-de-France" , "departements", "75;77;78;91;92;93;94;95")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Outre-MER", "compte", "D9718902;password")
; IniWrite($file,"Outre-MER" , "departements", "971;972;973;974;988")
 FileWriteLine($file,@crlf)
 IniWrite($file, "Website", "t41", "https://stmcv1.sf.intra.laposte.fr:444/ws_t41/T41/canalweb/login.ea" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Temporisation", "logon", "1500" )
 FileWriteLine($file,@crlf)
 IniWrite($file, "Rumba", "Macros", "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro" )
 if $tchoix=6 then ;Rumba
 IniWrite($file, "Rumba","LancerRumba" , "1" )
	else
 IniWrite($file, "Rumba","LancerRumba" , "0" )
 EndIf
if $tchoix=7 then ;Quick3270
 IniWrite($file, "Rumba","LancerQuick3270" , "1" )
   Else
 IniWrite($file, "Rumba","LancerQuick3270" , "0" )
 EndIf
 FileWriteLine($file,@crlf)
 FileWriteLine($file,"[Navigateur]" & @crlf & "Defaut=Edge" & @CRLF & "New=tab" & @CRLF & @CRLF)

 FileWriteLine($file,"------------------------------" & @crlf & " Choix navigateur par defaut: " & @crlf & "------------------------------" & @crlf & "Edge: 		Defaut=Edge" & @CRLF & "Firefox:	Defaut=Firefox" & @crlf & "chrome:		Defaut=Chrome" & @crlf & "ie:		Defaut=IE" & @CRLF & @CRLF)
 FileWriteLine($file,"nouvel onglet ou nouvelle fenetre ? (New: ne fonctionne pas avec IE)" & @crlf & "onglet:		New=tab" & @crlf & "fenetre:	New=windows" & @CRLF)

;macros samples de base
DirCreate("C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"

; detection virale possible
;FileInstall( "C:\Appliloc\outils exe\macros t41\Rumba-RACF.WDM" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0) ; 0 = ne pas réecrire si existant..
;FileInstall( "C:\Appliloc\outils exe\macros t41\Ile-de-France.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;FileInstall( "C:\Appliloc\outils exe\macros t41\Nord-Est.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;FileInstall( "C:\Appliloc\outils exe\macros t41\Nord-Ouest.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;FileInstall( "C:\Appliloc\outils exe\macros t41\Outre-Mer.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;FileInstall( "C:\Appliloc\outils exe\macros t41\Sud-Est.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;FileInstall( "C:\Appliloc\outils exe\macros t41\Sud-Ouest.rmc" , "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\" , 0)
;

;nouvelle methode.. on dezippe !

if $tchoix=6 Then ;rumba
if not FileExists($sSavePath & "\Rumba-RACF.WDM") Then
_RumbaRACF()
EndIf

if not FileExists($sSavePath & "\Ile-de-France.rmc") Then
_IledeFrance()
EndIf

if not FileExists($sSavePath & "\Nord-Est.rmc") Then
_NordEst()
EndIf

if not FileExists($sSavePath & "\Nord-Ouest.rmc") Then
_NordOuest()
EndIf

if not FileExists($sSavePath & "\Outre-Mer.rmc") Then
_OutreMer()
EndIf

if not FileExists($sSavePath & "\Sud-Est.rmc") Then
_SudEst()
EndIf

if not FileExists($sSavePath & "\Sud-Ouest.rmc") Then
_SudOuest()
EndIf
EndIf

if $tchoix=7 Then ;Quick3270
;Quick3270
if not FileExists($sSavePath & "\Macro Quick3270.qmc") Then ;creation fichier macro
_macroQuick3270()
EndIf

if not FileExists($sSavePath & "\Rumba.ecf") Then ;creation fichier ECF Ecran Main Frame
_Rumbaecf()
EndIf

EndIf
;

;  MsgBox(0,"Information !","Changez les valeurs de vos comptes dans le fichier généré 't41.ini'" & @crlf & "avec le bloc-notes ... sauvegardez et puis relancez t41.exe" & @crlf & "DSEM/EAPI69: nicolas RISTOVSKI => enjoy t41.exe !" & @crlf & "fichier ini crée sous:" & @crlf & $file)
;  Run("notepad.exe " & $file )
 _Init_pwd()
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
   $depSudEst =  "01;03;04;05;06;07;13;15;26;38;42;43;63;69;73;74;83;84;2A;2B;20"
EndIf

$SudOuest= IniRead($file,"Sud-Ouest","compte",0) 			;"D3359905;Th122021"
$depSudOuest= IniRead($file,"Sud-Ouest","departements",0)
if $depSudOuest ='0' Then
   $depSudOuest = "09;11;12;16;17;19;23;24;30;31;32;33;34;40;46;47;48;64;65;66;79;81;82;86;87"
EndIf

$IledeFrance= IniRead($file,"Ile-de-France","compte",0) 		;"D7585205;Th122021"
$depIledeFrance= IniRead($file,"Ile-de-France","departements",0)
if $depIledeFrance ='0' Then
   $depIledeFrance =  "75;77;78;91;92;93;94;95"
EndIf

$OutreMER= IniRead($file,"Outre-MER","compte",0)			;"D9417105;Th122021"
$depOutreMER= IniRead($file,"Outre-MER","departements",0)
if $depOutreMER ='0' Then
   $depOutreMER =  "971;972;973;974;980;988"
EndIf

$Website= IniRead($file,"Website","t41",0)
if $Website ='0' Then
   $Website = "https://stmcv1.sf.intra.laposte.fr:444/ws_t41/T41/canalweb/login.ea"
EndIf

$Temporisation= IniRead($file,"Temporisation","logon",1500)
;$LancerRumba=0

$Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf
;path
$sSavePath = $Rumba

$LancerRumba= IniRead($file,"Rumba","LancerRumba",0)
if $LancerRumba ='0' Then
$LancerRumba=0
EndIf

;nouveau Quick3270
$LancerQuick3270=IniRead($file,"Rumba","LancerQuick3270",0)
if $LancerQuick3270 ='0' Then
$LancerQuick3270=0
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

if    $LancerRumba=1 And   $LancerQuick3270=1 Then ; t41.ini deux Rumba = 1 => ko !
   MsgBox(0,"Abandon !","  't41.ini'  à les deux Rumba=1 ... " & @CRLF & " definir  LancerRumba=1  ou  LancerQuick3270=1" & @CRLF & " Mais pas les deux variables à 1...",14)
   Exit
   EndIf


;t41.ini deja existant mais check si fichiers macros sont présents...
if $LancerQuick3270='1' Then; si t41.ini deja initialisé mais fichier manquants
   if not FileExists($sSavePath & "\Macro Quick3270.qmc") Then ;creation fichier macro
_macroQuick3270()
EndIf

if not FileExists($sSavePath & "\Rumba.ecf") Then ;creation fichier ECF Ecran Main Frame
_Rumbaecf()
EndIf

EndIf

if $LancerRumba ='1' Then ; si t41.ini deja initialisé mais fichiers manquants
if not FileExists($sSavePath & "\Rumba-RACF.WDM") Then
_RumbaRACF()
EndIf

if not FileExists($sSavePath & "\Ile-de-France.rmc") Then
_IledeFrance()
EndIf

if not FileExists($sSavePath & "\Nord-Est.rmc") Then
_NordEst()
EndIf

if not FileExists($sSavePath & "\Nord-Ouest.rmc") Then
_NordOuest()
EndIf

if not FileExists($sSavePath & "\Outre-Mer.rmc") Then
_OutreMer()
EndIf

if not FileExists($sSavePath & "\Sud-Est.rmc") Then
_SudEst()
EndIf

if not FileExists($sSavePath & "\Sud-Ouest.rmc") Then
_SudOuest()
EndIf

EndIf
;t41.ini deja existant mais check si fichiers macros sont présents...


;boucle Principale...
while stringlen($dep)<2 or StringLen($dep)>3 and StringIsAlNum($dep) or $dep=""  ; "N° de Département sur 2 ou sur 3 chiffres !" & @crlf & @crlf &

$dep=InputBox("Saisir le n° du département   /        [EAPI69/NR]", "	  N° du Département sur 2 ou sur 3 chiffres !" & @crlf & @crlf & "          [  changer password (t41/racf) => tapez: pwd?  ]" & @crlf & @crlf & @CRLF & "Pour les nuls: Corse=2A,2B ou 20  DOM-TOM=971,972,973,974,980 ou 988. PARIS=75, AIN=01 ... ","","",360,220)
;pwd?
if $dep="pwd?" then ;call update pwd into Rumba files and ini file...
;msgbox(0,"","call pwd routine updating files info box",7)

$t = MsgBox (4, "Call pwd ?" ,"Call Password routine ? (Yes/No)")
If $t = 6 Then ;yes
   $dep=""
   _pwd()
ToolTip("relecture du fichier  ' t41.ini ' avec les nouveaux mdps...",5,5,"")
   Sleep(1000)
   $NordEst= IniRead($file,"Nord-Est","compte",0)
   $NordOuest=IniRead($file,"Nord-Ouest","compte",0)
   $SudEst= IniRead($file,"Sud-Est","compte",0)
   $SudOuest= IniRead($file,"Sud-Ouest","compte",0)
   $IledeFrance= IniRead($file,"Ile-de-France","compte",0)
   $OutreMER= IniRead($file,"Outre-MER","compte",0)
ToolTip("",5,5,"")
   $dep=""
 ;  Exit
ElseIf $t = 7 Then ;no
    $dep=""
EndIf

EndIf

;initpwd?
if $dep="Initpwd?" then ;call update pwd into Rumba files and ini file...
;msgbox(0,"","call pwd routine updating files info box",7)

$t = MsgBox (4, "Call Initpwd ?" ,"Call Initial Password routine ? (Yes/No)")
If $t = 6 Then ;yes
   $dep=""
   _Init_pwd()
ToolTip("relecture du fichier  ' t41.ini ' avec les nouveaux mdps...",5,5,"")
   Sleep(1000)
   $NordEst= IniRead($file,"Nord-Est","compte",0)
   $NordOuest=IniRead($file,"Nord-Ouest","compte",0)
   $SudEst= IniRead($file,"Sud-Est","compte",0)
   $SudOuest= IniRead($file,"Sud-Ouest","compte",0)
   $IledeFrance= IniRead($file,"Ile-de-France","compte",0)
   $OutreMER= IniRead($file,"Outre-MER","compte",0)
ToolTip("",5,5,"")
   $dep=""
 ;  Exit
ElseIf $t = 7 Then ;no
    $dep=""
EndIf

EndIf

if $dep="dep?" then ;call liste departement

MsgBox(0,"Liste des Délégations", "" & _
" Nord-Est :  [ " & $NordEst & " ]" & @CRLF & $depNordEst & @CRLF & @CRLF & _
" Nord-Ouest :  [ " & $NordOuest & " ]" & @CRLF & $depNordOuest & @CRLF & @CRLF & _
" Sud-Est :  [ " & $SudEst & " ]" & @CRLF & $depSudEst & @CRLF & @CRLF & _
" Sud-Ouest :  [ " & $SudOuest & " ]" & @CRLF & $depSudOuest & @CRLF & @CRLF & _
" Ile-de-France :  [ " & $IledeFrance & " ]" & @crlf & $depIledeFrance & @CRLF & @CRLF & _
" Outre-MER :  [ " & $OutreMER & " ]" & @crlf & $depOutreMER & @CRLF & @CRLF & "InitPwd? => initial Pwd routine" )
$dep=""
;Exit
EndIf



if @error=1 then
   MsgBox(0,"DSEM/EAPI69/NR","Deja fatigué ?" & @crlf & @crlf & " A bientot !" & @crlf & @crlf & "pour changer les mots de passe, modifier via le lien web t41 tous les comptes puis ensuite seulement lancer t41.exe et tapez la commande: pwd?" & @crlf & "Afin de changer les mots de passes sous t41.ini et sur les macros rumba/racf",20)
   Exit ; Cancel Bouton..
EndIf
WEnd

$identifiant=""
$mdp=""
$DEX=""

;T41 => navigateur...
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
   if StringInStr($dep,"dep?") Then
	  	  $err=1
	  Else
    MsgBox(0,"dép(" & $dep & ") : " & "??","mauvais n° de département, inconnu ! " & @crlf & @crlf & "Besoin d'une carte à gratter pour les nuls ?")
;	ShellExecute("https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/")
;   -new-window or -new-tab
;
;	shellexecute("firefox",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );,@sw_hide)
;	shellexecute("chrome",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );
;   shellexecute("msedge",'-new-tab "https://cartesmonde.com/produit/poster-a-gratter-regions-departements-francais-boomshine/"',"","" );


if $navigateur<>"iexplore" then
shellexecute($navigateur, "-new-" & $tab & ' "https://www.google.fr/search?q=carte+a+gratter+france&sxsrf=AJOqlzV-GVGCF68FmWYrb4lwDls7iaxioQ:1678260475053&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjk2tK758v9AhWbRKQEHWU0BkUQ_AUoAnoECAEQBA&biw=1455&bih=857&dpr=1"',"","" )
Else ;IE
   shellexecute($navigateur, '"https://www.google.fr/search?q=carte+a+gratter+france&sxsrf=AJOqlzV-GVGCF68FmWYrb4lwDls7iaxioQ:1678260475053&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjk2tK758v9AhWbRKQEHWU0BkUQ_AUoAnoECAEQBA&biw=1455&bih=857&dpr=1"',"","" )
   EndIf

   $err=1
   Endif
EndIf

;rumba !
if $err=0 Then ;t41 sous Edge...
   If ProcessExists("Wddsppag.bin") or ProcessExists("Quick3270.exe")  Then
	;  ToolTip ( "macro Rumba: deja ouverte ! ",5 ,5 ,"" )
	 $t= MsgBox(4,"Connexion ?",$txt & @crlf & @crlf & "Voulez-vous lancer une connexion à t41 (edge) ?" & @CRLF & "  ( Rumba/Racf déjà ouvert... ) ")
  Else ; on lance
	 If $LancerRumba=1 or $LancerQuick3270=1 Then
     $t= MsgBox(4,"Connexion ?",$txt & @crlf & @crlf & "Voulez-vous lancer une connexion à t41 (edge) et Racf (Rumba) ?")
     Else
     $t= MsgBox(4,"Connexion ?",$txt & @crlf & @crlf & "Voulez-vous lancer une connexion à t41 (edge) ?" & @CRLF &" ( Rumba inhibé dans t41.ini )")
	 EndIf
   EndIf

  If $t = 6 Then ;yes
;t41..
 ;ShellExecute($Website)
 if $navigateur<>"iexplore" then
 ShellExecuteWait($navigateur, "-new-" & $tab & ' ' & $Website & '',"","" )
 Else
	ShellExecuteWait($navigateur,'' & $Website & '',"","" )
	EndIf
WinWaitActive("Title", "Intranet La Banque Postale - Authentification",2) ;tempo 2s
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

;If _singleton("Rumba") = 0    Then
If $LancerRumba=1 Then
   If ProcessExists("Wddsppag.bin")  Then
	  ToolTip ( "macro Rumba: deja ouverte ! ",5 ,5 ,"" )
   ;ne fait rien
   Else ; on lance
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

EndIf
;
Else ; LancerRumba=0
 ;  MsgBox(0,"","LancerRumba=0")
EndIf ; $LancerRumba=1 ?

If $LancerQuick3270=1 Then
   If ProcessExists("Quick3270.exe")  Then
	  ToolTip ( "Macro Quick3270: deja ouverte ! ",5 ,5 ,"" )
   ;ne fait rien
   Else ; on lance Quick3270.exe
ToolTip ( "Lance Quick3270.exe, [Rumba.ECF]<-->['Macro Quick3270.qmc']  ",5 ,5 ,"" )

;Rumba / RACF credentials from macros..
 ShellExecute($rumba & "\Rumba.ecf" ) ; avec Macro Quick3270.qmc ?
sleep(500)
WinWaitActive("[CLASS:Quick3270]","",30) ;attends 30 secondes max
sleep(2000)

EndIf
;
Else ; $LancerQuick3270=0
 ;  MsgBox(0,"","LancerQuick3270=0")
EndIf ; $LancerQuick3270=1 ?

ToolTip("  t41.exe (v3.3E)  =>   DSEM/EAPI69/nicolas RISTOVSKI  (09/2023)",5,5,"")
if $LancerRumba=1 or $LancerQuick3270=1 Then
sleep(7000)
Else;t41 seul
sleep(2000)
EndIf
ToolTip("",5,5,"")
EndIf ; $t=6 yes


EndIf


#Region routines decompression

Func _WinAPI_Base64Decode($sB64String)
	Local $aCrypt = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $sB64String, "dword", 0, "dword", 1, "ptr", 0, "dword*", 0, "ptr", 0, "ptr", 0)
	If @error Or Not $aCrypt[0] Then Return SetError(1, 0, "")
	Local $bBuffer = DllStructCreate("byte[" & $aCrypt[5] & "]")
	$aCrypt = DllCall("Crypt32.dll", "bool", "CryptStringToBinaryA", "str", $sB64String, "dword", 0, "dword", 1, "struct*", $bBuffer, "dword*", $aCrypt[5], "ptr", 0, "ptr", 0)
	If @error Or Not $aCrypt[0] Then Return SetError(2, 0, "")
	Return DllStructGetData($bBuffer, 1)
 EndFunc

Func _WinAPI_LZNTDecompress(ByRef $tInput, ByRef $tOutput, $iBufferSize)
	$tOutput = DllStructCreate("byte[" & $iBufferSize & "]")
	If @error Then Return SetError(1, 0, 0)
	Local $aRet = DllCall("ntdll.dll", "uint", "RtlDecompressBuffer", "ushort", 0x0002, "struct*", $tOutput, "ulong", $iBufferSize, "struct*", $tInput, "ulong", DllStructGetSize($tInput), "ulong*", 0)
	If @error Then Return SetError(2, 0, 0)
	If $aRet[0] Then Return SetError(3, $aRet[0], 0)
	Return $aRet[6]
EndFunc

#EndRegion routines decompression

Func _RumbaRACF($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $RumbaRACF
	$RumbaRACF &= 'Q7QA0M8R4KGxGuECAAwAPgADAP7/qAkABghMAQQcCwEQUBAAABkAGAIABv44////BT4AFKoBUgACb0AAdAAgAEUAYm7AAXIAeY2CGgAWFAAFxnwFwAPgnmoAlMyKzhGuIQggAAlPZBvJCrDsgCB+v0jYASHAAtTAIMMESEAfc8AdNQCwCgABAcEewaQTwAAAI4WFkbWHzhFEoLbAH1oFw8EIgACFGvmr1NcBUAyvGMIfyQ9NAGEAAmNAPW8ATwBiAFhqAGVAA2kjGMAfBzXAAR7AAA7UCMUfIBlYwL+swAHLH2XAXXUEAENAIG4AZgBpNABnaiIiQN3Jc1WhANuQEqjOEbSBQAgAWsBRm90/F61gAP3fROIrDGAADeQcVjh8fWGCGmAEHWAAOaviJOcFJGQBFuQAIuI4VWMBH+AAO2AAJ2AAKFVgAClgACpgACtgACxVYAAtYAAuYAAvYAAwdWAAMWAANnAR4Q8BADyr5JNhAEJgAUBsBSXgAao6YABDYABEYABBf5j/HwAfAB8AHwAfAB8A/3//fwP/fwaAn1cKPdgBPghhAf9/HwD/f+p/YNbeluIP/38fAO1/A/9//3/3/3/xf+IfBORW+X/xH2U3v3F+cUDxOrEyMQ0xBQm0Oa39PzQwALE6ETAAErQXOhQwABUwAEEfnyb//2ocdFIP5B8+8Rq4AjJvfwMPAA8AAgAzdAvxPjffdATxPn0C9T/1QTV0A/8//w8ADwAPAA8ADwAPAA8ADwBfDwAPAA8ADwALAFTyP2x0AEJwMHLvJQ8ADAAQnxCg+QQfAg8AoKMAgMGj4zKjkS9tAHBULw8ADwDhCQASAAIBcSn1Yx8CWw8AAQB/dABzN3RSOHT/kEgPAA8A/Qf/Dw8ACQAxKGp+tABJ1AdysD+RSGXnPwgPAPpXAQGxdbV2DwDh9z9APG0W/UfBAPEv//FL8T6xALFA8T91czEA/T//MQFxHP8/MQlzhXEJYR6xCf8xQfE/'
	$RumbaRACF &= 'MQoxQLFDMUCxoPF/93FAcYHxeCb/f/9/+H9xQ//xPzFJ8TzxgDFAtQvxfTGF9bFBPXRHP/QB8T55DjUARkeyafEZAABKNAJMUfJaAABOMABPNAFRVXAAUjAAUzAAVDQBVlU4BVmwAFowAFswAFxVeAFfsABgMABhMABiVTAAY7QBZXAAZjAAZ7UwAGgwAGkwAFExazAAqmwwAG0wAG4wAG8wAHpwMABxMABxO1Ej0WJ11TAAdjAAdzAAeDAA0XyqejAAezAAfDAAfbQnVXUIBZALdVAFbfI/edXyKGbQBXISAXTwB/Exew8ABQAo/z8PAAwA8aCk7VQoULJ3cW9ssC8PAA8A/f5HAfEqcej/Bw8AAQCxq98yiPp/DwAPAA8ADPAHoQzf8QT/Bw8AAQDxbywBS7Ik/mHwGlF/0RZxFw8ADwAHAP4UkA8xOXF6/wcPADOT8AoB9BcvswBXAGkAbgBkABBvAHcAMQAOAAKsAf8IACFmCQAGFAQWIFMAdABhAAN1AKhzAEIACXIsfxQwfyoIAAMECH9vgDphABhnAGWAQS0AEgACqgCtPwWAAZyEBVCEPFU1AAqwPwKAAbSEBQFAAP7/AwoAwhDgAJ5qlMyKzhGuACEIAAlPZBsTAcAHUnVtYmEgUABhZ2UgUHJvZlBpbGUAlAUhgAVXAGFsbERhdGEuAkZABE1GRGlzcABsYXlEb2N1bQBlbnQuMgD0OTSycdomAcQAAQC2CaoOwgIgxEw4wAAbQgb04BfFOijICsE1wQjBCtpQ3AoDxAjBClbQCgEAIgzAADCFecICQ2EAcHR1cmUuVHgOdMorwRHBAGBOeQAYSG9zCwcMANBaDzAJrGk6gSkCAE1lAG51Q29uZmlnIE9iamVjzg5QXEAPCbS8OgLFQ00wYWNyb5MKAgDAW8APCeSzlAIGGCAAGBGifp8EGAD5+/9U//7gAPrgJvcAIWhHoIkfABcApuuA6gEkteABPuAALOAA4UAQ'
	$RumbaRACF &= '4lcKBOaHHOQA3ABl9QBjaWNzLXRvcgBzLnNmLmludEByYS5sYXCAMmWgLmZyAGMgnWMgfKItJH5zAC5gAGagAEUhoHRigC4AbKAAcNXgA3MgAmXgAWYikn8H/3cHHwAfAB8AHwAfAB8AHwD/HwAfAB8AHwAfAB8AHwAfAI8fAB8AHwABAKsCwJ8E/x8ADwAPAA8ADwAPAA8ADwA/DwAPAA8ADwAPAAIAwgL+108BDwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADwDhDwAA2QLuTwEPAA8A/w8ADwAPAA8ADwAPAA8ADwAfDwAPAA8ADwAPAADwAv4FRXkPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAOMPAAgABwMcPxIPAA8A/w8ADwAPAA8ADwAPAA8ADwAfDwAPAA8ADwAPAAAeA/4zPxIPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAOEPAAA1A0o/Eg8ADwD/DwAPAA8ADwAPAA8ADwAPAB8PAA8ADwAPAA8AAEwDHmE/EjrVDwADACK1AAEAQwBvAG0AAHAATwBiAGoAwS0AEgACAP8IACFmClUABnoEFksAZQACeQB5bwBhAHIA0mQxfwEUAAcWAAMlfxJQAAMIAQMLSQBuRAB0gEFyAGaAQGNbgAQrABSAP61/S4ABHK2EP1eAOoM/bYKAa68/VAAVgAMPqH9GgAEQwYQ/cRgAAAxuXT8ABQ4AwEMAgEE2AAEEAAlBKUlMRV9OEEVXAAUAA05VTAhMAAgBAm91dmUAYXUAIQAiAB8rQAADAAFCAAiACiAAOhvCAwDGBgMAy0YBAEIKRRhPUEVOhxgHAQACT3V2cmlyAFoGAAMGQABJGCBACjiHRhjFBlwYU0FWRUcYAQFbRW5yZWdpc9B0cmVyABkIwADBHXWHGTiAC1CGGcUGkRkCAcITU1BBQ0VCVXhUVE+IMgYCCwBDGNpdgAfgRhgLAA0ZEcFkbQBw'
	$RumbaRACF &= 'cmltZXIgbMAn6WNyYW6nC7IDuBIAEwADQQNHDlZgBs5uRA6DCgcALk6pAZ8aD5Ma6QGdGiFMRURJVBBfQ1VUyz9Db3WicOAyIgAjwD0gCgx6dCAFjEYYZQPXPwMMTyRQWS0McGkgDAMAqgRgAAMqDIwgBaQmDAtlAzMMCyUMUEFTVFMoTEMMbGxADASgAgTrIABJDKRgArxGDGUDnBgQVU5ETwtxQW5uonVBDCMAJIBxIUoM+sJABdpGDGUD/1dfPV89BY8YECEMRVNTSU/CToAxTk5FQyg+IRyAQ29ubmVjdIAZXhPgqWFXxQwhAOCABfgNRmUSXw1FDUFQVFUGUugyQV5DYXB0dWvAfiZlGiALGaAAlRsB/6AD3yffJ98nHwYfBh8GHwYHHwYfBg9GQVVUT0YAT05UX1NNQUwYTEVS1wUAagBS6QBkdWlyZSBsYSAgZmVu6oBTIGGodXRv0AkDMAACmgfy/qADFgH1GrUBnwf1GmGWB0xBUkeJB4EXQbJnQBpkafAanAcBkAWDdw6TBxYBBQAulgf/ew9fFV8VXxVfFV8VHwbzAQIOUABUUkFOU0aARVJfU0VORPs7YEVudm95IC/BJxjrQhZnBjSADEyGDLUBbwaDxRtmBlJFQ0VJ2W6BYVZSZWNldm8QdVoYwAYXEACpBkygBmQ/pga1Aa8G8QExjqYGQkFYVENIhwbBWFSwGnMEZuniNWVzIGZphGNocFZzIHBhAAHQb3QAHjCBHhAA+Qf6ZPAHfPYHtQH/Bz8bPxuPPxs/Gz8bzRRPUFTgQwBTX0tFWUJPQQZSaBtxSU9wdGlvAG5zIGRlIGNs1GF2cWQNoB4MRpxDB3qCYA2aZg0Lnk8wRwdQMEFMRVTJZBEZU+kObOBRYAdQB3MgY2/RcF91cnMwAgYwAJEC9XcHmnAHsnYHtQF/B+8UX+8U7xTvFO8U+QENUABN0EFDUk+BKU+pFOHCAViYIHVuZSBtYehjcm+wFA8S'
	$RumbaRACF &= 'FUU8EQD6uFAN0FYNUQU/BylzNAcGVTgNsRtFeOljdWtgZtgGECAfDxIYJ2fQ/dAG6NYGQS/fBj8UPxQ/FLU/FAHz13fw19HXc3+53w8A/9//zw8ACAB/MAB1h6pNUM9pcKFm8AdhMNACZZA8VABOADMAYDIANwAwzwMMACJ98NcchBH/Bw8AAQBR5qlFxLtBkO9wAGwwCGNVkthpkBBusPBqMOllDTABdO8DCgAkAAEBD2Ga8QwbxwcA8PONyQC6SNgBYNYYfv6/cAC5AdH3E+hRAP8XDwBv/+//Fw8ACQBWNBgBADC1gAUAUwB1AG0AEABhAHIAeQBJAGBuAGYAbwBYAYh0JABpACxuABcAKAC4AgD/CAAYVAYAOQAGVKQBAxZQAGlvAHFpMABsAGUhPAwAEABoAgEGAAcCAAMlfzjVAAMIBAtNgHJjgkEzAF4MgD8BZYEnpT8PgAEsqgqDBU6AP3aAfmeCtquBuysAFIB8DYADCag/VQE9CIS/VMAcb8BeQpfCf/Jf7n8mwACAGcMCCAEAQ8AfbQBwAKBPAGIAau4fEsBfbgzENOUfAQB/xAFBH261QF5lQgFz8h/tP0DAAG5+xALB20EfcsDAQaJlQewgFgABARjAARoFwAAd1AiAhRr5qwDU1wFAPG0WrFfAAckGAQP+4BYD4AAEa2QB4WkHYABV5AFhAAtVYl0AYk0O5AIQ4AAREWIgAAATYlEAABXxYhIAABdgAOESwTxhE6obYAAcZBQeYAAfYACqIGAAIWAAImAAI2AAKiRgACXkQydiiwAAailgACpgACthZmAALVVgAC5gAC9gADBgADFVYAAyYAAzYAA0YAA1VWAANmAAN2gXOmABO1VgADxgAD1gAD5gAD+t5ANB6ARpAEfgAkjiM2gAAEpkBEzihWF2AKugVWMCUeAAUmAAU2JpVWcJgGQBWeAAWmAAW1VgAFzoA19gAWBgAGG1YABiYABjZANhoGZgAGpnYABo'
	$RumbaRACF &= 'YABpYAChYmt1YABsYABtYADhseGVcF1gAHFgAOF2oUZ0YAB1VWAAdmAAd2AAeGAAeVVgAHpgAHtgAHxgAH2LZE/lEFcgDG4AZOAJ9yEGHwANAA7/Xw4AYZVhRe0BAFOgFiGfdSAYf5Dyn7//DwwAYbVhXeUPoa5hIC6vf2/yf/+fDAAFYADMZAF+UCQPHwB1uf8PDQBh5bQLlQNLBAJCP1NQQUOARUJVVFRPTsILsE5VTEyHAAsAARIA/wtGHwYfBh8GHwYfBh8GHwZ/HwYfBh8GHwYfBvcBEQZIAEVMUF9PTkxJDE5FhwWxUUFpZGUAIGNvbnRleHTgdWVsbGUQKBMAxwYAAQDuAQUABgI/cVL1hO8G5QbRWOIGSU4YREVY1wbRWFJ1YgByaXF1ZXMgZOwnYZAH4DYKMABBN78N/8MGtQHPBt8T3xPfEx8G3xMB3RNGSUxFX1NBEFZFQVP7DEVucgBlZ2lzdHJlcqAgc291c2BiJSBj/0Fj1QYNbbUB3wbxAaGC0gYQRVhJVNsMRXhp+nTgZycwBsFo/wXzBbUBD/8F8QFhcfMFRElUUxhFTEGpErFwRWRpAHRpb24gVG91gHQgc+lsZWPhAOhuZXKAByjADTFwrwd/8wC1Aa8H8QHReVEHogdPZlDYDXEoT3BxBnEh6fcTCNAG8Y9sElC/Tw8ADwBX/18PAA0AXjAAZKQNQ/+QX7EHn68PAA8A8wcBF/ENt/8HDwABAF20jAEARRB1+jMQhDdSyQ8ADwD/B/8P2w8ACQBYsZH2D28QEDGg/9HXDwAPAP/PUTLxlv8HDwD1AQBX+G8p4C7xlv8moy4PtQH/JvEBkcxTRVNTAElPTl9DT05GDElHFydRnkNvbmZgaWd1cmHyLlBQbKJhgVBuZXjRJymQnf4nkp7fB9MHtQHfB4U21QfwQVVUTxAI5wdBqOAHgaMGIGF1dG9tUAj7cFGgpCuiB79KAQCBEUGnZ28HbwdjB0RJGEsx'
	$RumbaRACF &= 'r0TW6TYOigcsEAArUqyPBw/zDlGujwffFk5fSEzwTEFQSXcHcWPVFoBSWmzgX2/kPnECLUCzLQPCs6wWC7YgQwBvAG4AEGUAYGMAdABpAtApABawAAIB/wgAIWZFAAYCBAQWQwBoAGEAFnIAAwF/ZQAJIABThQAHdCR/HAACAC1/qkQIf1KANWeEe1OAQQpygAdlgAVJAGQAqnOgJSCAfxmAAxuAAVWlP0OAARSGBWyAPnCsAGKAQIGDZIAob4AGVmqEyB0AIrB/QoABGDUJCAHAAC2KCIsSAQACDUABVFJBTlNGAEVSX0NGRwAFYQAETlVMTAAgADFvAG5maWd1cmF0AGlvbiB0cmFuAHNmZXJ0cyBmAGljaGllcnMA6C4AL8AALsYTQRzLHwPFBtcfT1BUSU9OwFNfRElTUMcfAVIET3ABHnMgZCdhAmaBHGFnZQAwADoxwAAwWBzFBlccUFIARUZfUFJPRlMUQVZHHBJJHGUgcAByb2ZpbAAzALo0wAAz2BvFBtMbDsUbAFRZUEFIRUFEBQccEQFfYXBlciAA4CBsJ2F2YW7sY2VAG0EANUYbyxuBtwI04RsBAP7/AwoBwwPgnmqUzIrOABGuIQgACU9kBBsT4WN1bWJhIJJQICogUAIdZQDUAgIhwAJXYWxsRGEQdGEuRiACTUZEAGlzcGxheURvAGN1bWVudC4y4AD0ObJxelPBGEUZaLYJDmIBIGAAgSE4oeRsAADgF8UZKGgF1gJkBGEFUHwFA2QEYQWWVnAFAQAMgUSFeeN0AGFwdHVyZS5UDnhrcgEtYQBANkYACEhvcxp28PJIABgsaBfBFAIATWVugnVDZ09iamVjbgcAMPhIAJQfcQXB5SFNYWNyb1MFAgAAYPpNAHy7cgWBBQxBcHBsaWOCcghPamKvBhD/TQAYEaJ+H4YYAPj7/1T/EQAU+eAmCgAhaKP/xxoApuuA6gEk4AFaPuAALOAA4UAQYAACCyAu5acc'
	$RumbaRACF &= '5ADcAGX1AGNpY3MtdG9ygHMuc2YuaW7gkBAubGFwgDJlLmaqcqCpaWAAcwCddCCsqnIgAS5gAGagAGlgFqp0YtAuoLFhoLFvIAP1odEu4ANyoAt/B3cHHwAPHwAfAB8AEwBGX05VwE1GTERPUvdGMRUAT3V0cmVwYXMGc1BHAFVtcCBudYBt6XJpcXVlQEdgNQA2ADevRxY8NgevR69VoE5PT0xCQQ2YBx3IZIAHbGEgYhBhcnJlgF1vdXToaWxzYgc4Qj5fVqMHh7UBrweqB1NUQVSqB4WRAULEBul0YXSCBn45EACvBqUGtQGvBvEBCwERO0FDUk9fRUQMSVSHBuFTTW9kaQJmgHEgdW5lIG37YT3CBjoQAO8G5Qa1Ae8GAZUNSEVMUF9PVmBSVklFVwcHITNBAHNzaXN0YW50ACBSVU1CQQA9XUA1PxAAgAMRoG1wK0/vUocPAA8ACQAS/4cPAAwAqoEwAHq0AEuQMnnYj9cPAA8A/AcBsUAW/5cPAGsEAHFfCPQVSfI7cadm3TKoZe8CDwAIABT/rw8AbQwAS3FL9AdXUAfzB22dEhBr7wIPAPsHABVwAD4P/w8PADU/cVT0BwT4qAAAXBARchAYZ3JMqm1wVkZwTWxQCXOwAIgoAHjAKTYAKXACKFIAdfABYlACUgDaSPAAc7Ab005t0ACRBUZBHAABAFQASn8BALZR3wJQAVW/AlABU78CAVABy5rWV5A15nCsiCxWXwNyB18DAAAAyvIGvNWRBR+QFzkDDwAPAA8AAACUGMByBbGEAQAjhYWAkbWHzhGgtvCTeFoFw4eSkYH/k2EBBJ3wG08ABDEAhT4ADOGTfFByEJPghhEBEX2VkezKCTMA9tB29gR1zA8A4w8ADwAAAHGAwHGODwB/DwAPAA8ADwAPAA8AAADAMRMAgEE2UA7gDQBGoElMRV9OiUwIgQBAb3V2ZWF10KYirAAfEADnUgHwAQXwKn+RnHEStQHvUvEB'
	$RumbaRACF &= 'IK8TBk8oUEVOJwYHom92ctBpcgAGwAAGEAAZBvogkAI4Fga1AR8GGgbAwwZFFwbBFkVucmVnd/BYMG5ABggwAHEHZwY4feACUGYGtQFvBoEh8QRTAFBBQ0VCVVRUXk+oDIYADbYRANrgAeABEQYWtWgAAQANAP8AAAdoAQQAEQAUSW1wcmkAbWVyIGwn6WMgcmFuAAUAUE5VxExME3QSABMAMAE0iwOEAQJWAGZuABsEHhMFNgMALk4JDQIADAEABVNQQUNFQlXwVFRPTgdtBggLAANhCwkPHdQJAAVFRElUUF9DVVSHKgcABEMAb3VwZXIAIgBYIwAggAAJMHSAFIwXBmGFDRMwCgYwT1BZiY0wcGmAMAMABIAB6gOKMIyAFKSGMIUNkzCCC4UwUEFTVEUNMdRsbAAxBIAKBIAACTFqpIAJvAQxAIYNHDFVKE5ET0cYCAACQW4EbnWBGCMAJAAh60AAiRjCgAraRjHFBpEYC796n3oQQRhFU1NJhE9OAGNOTkVDSHwBQThDb25uZWN0cQAzEwAUwq6FGUEA4BUAC/jGSxKnGkFQVAxVUshlgbxDYXB01HVySMoaQBYZQAEVN/4BQAe/T7dPPww/DB+MwEkAVVRPRk9OVF+AU01BTExFUqcLAhgAAVLpZHVpcgBlIGxhIGZlboTqdEABYXV0b6ATKgNgAAIqD/5ABxYBD+U1ZQP3NSYPTEFSR5MJDwEvQWeANGRp4DUdLA8BIAvnHCMPFgEF/AAuJg/rHr8qvyq/KukDAg6gAFRSQU5TRoBFUl9TRU5E63dgRW52b3lAXoFPGOuCLMcMNAAZTAYZZQOXN4HGDFJFQ0VJVmheAcGsUmVjZXZvaWJyAAkZABcgAEkNTF1ADWRGDWUDUw0PSQ1CsEFUQ0gHDYGxVGA1CHNm6cJrZXMgZghpY2jgrHMgcGGBAAJvdAAeAB9gAOoe6g9k4A985g9lA382R382fzaTKU9QVMCHUwBfS0VZ'
	$RumbaRACF &= 'Qk9BUgPINuGST3B0aW9uAHMgZGUgY2xhanbhyA1APQyCE4cOgj3AGprGGmUDl2BFB1BBGExFVMlkERlT6WyH4FFgB1AHcyBjb3Bf6HVyczACBjAAkQJ3B/qacAeydge1AX8H7xTvFC/vFO8U7xT5AQ1QAE1BqENST4EpT6kUFhIwIHJlZ2lzID1yIAB1bmUgbWFjcrpvsBQPEhVFPBEAuFANvtBWDVEFPwcpczQHVTgNwbEbRXjpY3VgZtgGWhAgHw8SGCdn0NAG6P/WBkEv3wY/FD8UPxQ/FD8U/x8GHwYfBh8GHwYfBh8GHwb/HwYfBh8GHwYfBh8GHwYfBgcfBvEBEQZIRUxQX2BPTkxJTvgz8YJBAmnROm9udGV4dLx1ZYCZAFgTAGkf7mAffAYCZR+zAe8Gp5/iBkkQTkRFWCuGUnViEHJpcXWQOmQnYfuQBzBYCjAAkVi/DcMGtQF/zwbfE98T3xMfBt8T3RNGAElMRV9TQVZFDEFT+wxpOnNvdXO18KYl0Lki2AbbBwC2AcffBhU60gZFWEmYoIEAAEV4aXQAJgAn/TAGJP8F9gW1Af8F9VTzBXGQs1NFTPCMVwaRnkUEZGnSVFRvdXQginPFVW6gXCcAKMAN/iWvB/YAtQGvBwVP8rpBAGcwXXsotmMn6RMI0AYp/eAOJv8Gpg61Af8GFXmotThGSUcXB7F0kLVmaXBndXJh1GNhlIAwbkRleNEHKQAqEA8n/98H1ge1Ad8H3bZRnBAIG143gr2hBjKbbVAIcDEAK98QAKEHvyoBAAHRKW8HbweZZgdESRgrwZJE6TYOdYoHLBAAKzAAjwf1DisHjwffFoIHSExMQVDeSXcHcUPVFvSPb+QecQIoLQAuMAAtrxZ2tWoAAQABADAtApAFAP8jAAAHaAEADQAUVFIAQU5TRkVSX0MQRkcABQBATlVMCEwAIgAQQ29uZgBpZ3VyYXRpbwBuIHRyYW5zZgBlcnRzIGZpYwBo'
	$RumbaRACF &= 'aWVycwAuALovAAYuBp4B4gm+AAYbARd/T1BUSU9OU6BfRElTUAd/FAEZAnABeHMgZCdhZgEBcmFnZQAwADEdAAMwGHEFG5c4UFJFAEZfUFJPRlNBClaHOBKJOGUgcHIAb2ZpbAAzADRdgAEzmDeFDZM3DoU3VIBZUEFIRUFEBzgCEQG+YXBlciDgACBsJ2F2YW5jtmWANoEANYY2izcEgAECNKM3TlVNRkxEFE9SxxscATh1dHJgZXBhc3NAHQBUbQBwIG51belyaQhxdWUAHTUANgAWN5QeQQM2o1ZUT09oTEJBSB4dCJMAHmyAYSBiYXJyZQB2QG91dGlsc4IdOA9AAFdZxQacHlNUQVQLih5BBkIEG+l0YXS9Aho5QACXGsUGkxoLQAEATUFDUk9fRUQUSVQHGhPBBW9kaQJmAMYgdW5lIG3QYWNybwIbOkAAlxsDxQZXNkhFTFBfT0BWUlZJRVcHHBABAAJBc3Npc3RhAG50IFJVTUJBwAA9AD4AP0AAVxuHZQOXG6INQUJPVYgbJg9hDUFicG+BYy4u+i4CDUAgAFcNZQNTDeElAFNIT1dfV0FUAEVSTUFSS19EKkwIkBhsRmWgjmxpAmeAkGUAUgBTAH5aIAB3D2UDcw8hb8cOVCBPR0dMRSsPROlAc2FjdGl2LQ9T8ABUAFsgADcPZQMxD6AA/P//RIAE8aAC7O0D4wXtAmSBAgUDQRHuFmAAAWgFDAJgAGAHYoFV4QAGYAAHYAAI5AEJ/+QA/z//P/8//z//P/8//z9f/z//P/8//z/6PwHgPDG1gATyoALa6D/pAlH/P///P+EAsRxxALEbsUKxADFur4EX0XXxALEFF7QAGTAAlhq0ADEAH4gJD/6DCQXRSFPwRmRhcmQu+ENCUvwPDwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAAEHAKMu3Xi+FQAAgDoAH0KJGScABNLEE4F1e/xAbbmJZeIm0BAmsADvvjH/HwQA'
	$RumbaRACF &= 'VjAmgm8QAdYMAABJ+B99eQGPEQP/H/8f/x/6H5de/d8LDwAPAAMA/lALBgGQBuCFn/L5T2gAEKuRCAArJ7Pu2QEIPQEBl3SAAcElwQlq7IQI8EQK9DAAwTUE2zACwQoscAABCzBwAEELrjRwAEELEVAKcACYxCtmpDAAABEAsDAAgSe8qzAA4Y3IRC3QhC3YMAC1ET3oBC5UcARBLuBvDQMGALJJ+wFatNTXAgGyAKFouBI92C/vLAQABRcJAB5EF3BhoHBoMjg18gAgMAARongsIFACpCwgRQJjkEMsIE1haW7gZnJhbWX/A/gDcRKAMS4xMAA5MvIAn8EfAgTghPQDpH5qbF8KAYii+AAAXABQACByAG8AZ1AAYQACbbAJRgBpAGwAiGUAc7AAKAB4wImINgApcAJSAHXwASJiUAJSAEjwAHMAqnkwAHSQAm3QAABwA0ZBHAABAFQASn8BAPZR3wJQAVW/AqFEvwJQAQDLmtZXkDXmrDiILFZfA3IHXwMAAADK8ga81ZEFAD5XOgMPAA8ADwCBNv7/BgPAKPE7I4WFkbUAh84RoLYIAAkIWgXDsSVSdW1iQGEgSG9zdHQeZQciJ28BUrdXYWxsRBBhdGEuRiBEaXMAcGxheS4zAPT4ObJx/we9Jg8ADwAMAN//X/9f/1/7X4WJDvBfgYn//19/Bw8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwD/X/9f//Zf/x//H/8f/x8PAA8ADwAAAABftAAAbQzgUkjoAwACAABlbVxSVQBNQkFEU1AuZABvYwAAbQBGAABpAGwAZQBzAAA9AEMAOgBcAIBQAHIAbwBnABQKYQB8IAiEIAAoAAB4ADgANgApAF4ADE4HSgdGO6JXABU0MAAzADIgRwE7cwaAAHX6WwAAwAAPiGAMewAjdABoCjtkGFAAFAACgB0tAOiwAwAAAa4aBAD/AAH+/wECAgECCIIHgQOFAgIER4ELhBUAU1IASIBb'
	$RumbaRACF &= 'c9QAeYABdIBybYAGJQBZi1WX/bUuAQD+gCMGAQCP4IWf8vlPaAAQq5EIACsns1bZwRjNBDDABHQABhIxwlkAAOzAAIBOAPDVwAAEwAD0wAAFwQLACKoGwAEswAEHwAEwwAGqCMABNMABCcABRMABqgrAAZjAAAvAAKTAAKoMwACwwAANwAC8wACqDsAAyMAAD8AA0MAA6hDAANjAABHBa8AAwSBaVMARE8Ep2DdAAQH7QAFatNTXAcICpuCAQNBI2JZ7wTPBMg0JAB7AAMEvcGFwaGgyODXCAyDAAELbLAAgUHJvZmlsLAAgRWNyYW4sIABNYWluZnJhbQZl2g/BSTEuMTEANDkywgMWwAACECBtRcUPIMIXABV322///P+C5AAfAB8AHwAfAB8A/x8AHwAfAB8AHwAfAB8AHwAHHwAVAEFWUuMLkY8AzhGd4wCqAEsEuFFhW5AB3HwBAAALQ291cmll4HIgTmV3YAXJAcVdGgEgRwOAcWEJI4WFAJG1h84RoLYIIAAJWgXDYWtSdQBtYmEgSG9zdC3kXGVCbtACHMACV2GAbGxEYXRhLoZgAERpc3BsYXkuwDMA9Dmycf+RHwAHHwAfAB8Aoy7deL4AFQCAOgAfQokAGScE0sQTgXUAe/xtuYll4ibBILAmAO++Md8IHwD/HwAbAP9//3//f19233r/f///fx8FHwUfBf9/fwT/f/9///9//38PAP9//38PAA8A/39//3//f/9//38PAP9/tgACHABP8AsxAAEAOEM6SlwQOWewNyBGYDlzQCAoeDg2KZMhUghIXE1SOVxNYWMAcm9cQ0lDUEYAVDAwLnJtYyzeY48DggORPoEDRogDEgj+/4UI9Qg/FA8ADwAPAA8A+w8ABQAMECAPAA8ADwADAP55LwEPAA8ADwAPAA8ADwCPDwAPAA8ACAAE+AC/M4M/ODI4XABSAHXwAY5iUAL/J/EnRgBBHACRAQBUAEp/AQBR3wJtUAFV'
	$RumbaRACF &= 'vwJQAVO/AlABywCa1leQNeasiBwsVl8DcgdfAwAAysDyBrzVkQUQRDkD/w8ADwAPADEr/2//b/9vbwF//2//b/8HvaYPAA8ACQBLEbAbeQB30B9yAGTvslIPAA8ABwAS8EP8hA8AFQwAf3gLTbAkaQBuFABmtCdlECdUAE45kl03ABHDDwAJACIAvAIBkRP/Bw8ABQBkMAD+qQHGDwAPAA8AL1z/Dw8A/w8ADwAPAA8ADwD/Bw8ADwABBAAFsoABAAIATwMAAjABAgAsYzpcUHJvAGdyYW0gRmlsAGVzICh4ODYpAFxSdW1iYVJICFxNRgBkZVxNYSBjcm9cAQHE/wAfAgw3AAU+PEYyAAwAQx26H3nwWX8AJwDzBQAA9p5bAADAAHMAAIBjeADxBQAc9JzIAz8AAwDZHg4AwgAYAIAPAKkABgCTawBXYWwAbERhdGEuVE4AMzI3MExpbmsB0g3QHhfCABkAAoDtG9ceGMIAGoHvDS4eYcIAG+8NwCUeasIAHO8NPwD/HwAfAB8AHwAfAB8AHwAfADcfAP+dAwAPXwV/CVUofna/BB8AHwAfAB8ACwD/AQAARQABRP9bAAoI4QGUZNBMAAgCIMDUewAgYNNjAAA6AFwAUAByAIhvAGegAGEAbeACgEYAaQBsAGVgiAAgACgAeAA4AIg2ACngBFIAdeADomKgBFIASOABc+CzAnN6EFRONgAQJwBjaWNzLXRvcgBzLnNmLmludAByYS5sYXBvc+B0ZS5mch8ZHwAfAP8fAB8AHwAfAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8ADw8ADwAPAA4A'
	$RumbaRACF = _WinAPI_Base64Decode($RumbaRACF)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($RumbaRACF) & ']')
	DllStructSetData($tSource, 1, $RumbaRACF)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 35840)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Rumba-RACF.WDM", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString

EndFunc   ;==>_RumbaRACF

Func _IledeFrance($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $IledeFrance
	$IledeFrance &= 'lLIA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAA0ELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCrD216sQzEjYARPAAsAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGDAAAgECyJ3jLAAAij/EAlbAHHIAaUABKGIAbMAec2o/AABeFMAfyVPhDME/ucQCQxVAPm1AAGFAX2QAMbwAOPAfgVLF3uEMEsAA6ivEAg5gAP3fRAoA4X2yD0OAABHkCWECFOAA/hVkAR8AHwAfAB8AHwAfAP8fAB8AHwAfAB8AHwD/f/9/BfV/CPx/IOUhZsTwydgBCv9/HwDof/9v9/9//3/3bwP/b/9//3//j/f/D+5/5QYEdEBhGTF/sVzX8RyxPDEAC7AADL89DwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADgD9/Sc37yIPAPwn8SI1eB8Cjw8AMWMxMP8vMQA27wL/DwD/L/8vDwAGAHFr9S/9B/417wIPAPwHsTJxM/8HDwDvAQCxc/8P8wc07wIPAP8Pv/8PDwAGADF//w/zBzPvAv8PAPwHcUHxQ/8HDwABAHHD+/8P8wcy7wIPAP8P/w8PAO8GAPEK/wfzBzHvAg8A/Af9sVEJ/w8PAAQA8QL/F/MH/jDvAg8A/w//Dw8ABgDxdzv/D/EHOc8CDwC8ZAIB//E0MQX/Bw8AAQCxEv8P8Qf/328PAP8H/w8PAAkAcW3/D//xB99PDwD/B/E8MS3/Bw8A+wEA8UIf/wfwB99PDwD/Bx//Dw8ACQDxWvUXp7IgQwBvAG0AEGEAQG4AZAA1AC0AEkQAAgAGAAAOAAb/awAAIWYFAAYTBBYL/jRdMX8BAXcFACEzBAADK1USfzOyPxSAAxGofwOtln8ysr+tfwKWfzHy'
	$IledeFrance &= 'P9YVxDPlHwHWPzD/PyQAfhduGhcA8R8/AP8fAQD+/2AGfwB/AGEA4WBhQeUBHwD/HwAfAB8AHwAfAB8AHwAfAI8fAB8AHwAJAAugAeJxAAkAQ0lDUEZURjBfcAoACKAD4geh2eSaQEV/BgkACuAP4Qa3oRDhCIIABUcBhor8U1vv/w//D/8PAAD6/w//D/8PB/8PCwDlNxEARDc3ADQxMDAyU2Vw8HQyMDJfyf8XDwD/C/f/C/8LcQD7/wv/B/8HDwBn/wf/B/8HAPn/B/kTBeAAJHJzZP8BDwD/C///Cw8ADwD/C/8L/y//B/8H/w8ADwD/B/8H/ycPAP8HPwI/DwD/B/8H/wcPAAMADwAASUQgdXRpbGlAc2F0ZXVyZAENAABNb3QgZGUgIHBhc3NlRAEdAIBWYXJpYWJsYAEAb3VyIHRleHQAZSBzdGF0aXE2dUECQQcfRwLgA3Zh3mxABQwGYAIgAAg6lWgDA7gFEARsJ+ljcmEObmQOoQIGAF9SVU0AQkFPRkZJQ0UATUFDU0NSSVAMVF+DAiIGHABDbwBubmV4aW9uIABEZXggSWxlLdBkZS1G8ARjRQ0PAP8PAA8A/38/AD8APwD/f/9//w8ADwAPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAKAP2/7jcvIg8ACAAU/9cPAAwAd7HS/7/zBzbvAg8A/AcG7zTd/wcPAAEAEP/P9gcf8P8PAP8P/w8PAPlK/w/1Bx/w+w8A/QcLtFf/Bw8AAQCx+gH1D2eyIEMAbwBtABBhAABuAGQAMQAzAMErABQAAgH/CAAhZloNAAYTBBYN/jIwfwqtAAcIAAMlfwwYfzHgf6oLgAErlD8wsD8PgAMuCah/gZeTfzlsHwAArhLwP8Eq0z848h8OxHS35R/BitM/N/8/IAAHwABqH9IfNvIfEcTU5R8GXdZfNZ8H/x8eAAX2LzS3nwfwD2EJEP8fBgAE'
	$IledeFrance &= '9h93v5//Hx8AA/Yfv5/xDxR34gD/HwUAAviPHwDvDxX3ZA//DwMAAfYfv5/wD2YP+/8PBwAXXwQfAAQA/w8fAE8fAP8P/w9w0aAB8hgJAABDSUNQRlQwpy8YDwC5VKAD8gOhdC38QEU/Ag8AuGjwB3EDUQjbcQRCAAWnAEYt+68N/wef/wcPAP8H/wf/BwD5/wf//wf/Bw8A/wf/B/8H/wf7GwARAEQ3NzQxMAAwMnBhc3N3b/xyZL8CDwD/C/8LDwD/C/v/C/4L+v8L/wf/Bw8A/wcz/wf/BwD4/wf5EwUA+CRycz8TDwD/C/8LDwD/DwD/C/8L/y//B/8HDwAPAP//B/8H/ycPAP8H/wcPAP8HD/8H/wfPAwQADwBJRAAgdXRpbGlzYRB0ZXVyZsZNb3RQIGRlIBExZUQBHQAAVmFyaWFibAFgAW91ciB0ZXgAdGUgc3RhdGlscXVBAkEHH0cC4AN2/GFsQAUMBmACIACRpDd1B2gDuAUQBGwn6WNyHGFuZA6hAgYAX1JVAE1CQU9GRklDAEVNQUNTQ1JJGFBUX4MCIgYcAEMAb25uZXhpb24AIERleCBJbGWgLWRlLUbwBGNFDQ8PAA8ADwACAA=='
	$IledeFrance = _WinAPI_Base64Decode($IledeFrance)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($IledeFrance) & ']')
	DllStructSetData($tSource, 1, $IledeFrance)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 11776)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Ile-de-France.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_IledeFrance

Func _NordOuest($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $NordOuest
	$NordOuest &= 'k7IA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAAwELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCvA9JLoQzEjYARHAAkAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGLAAAgECyJ3hDBTAAIo8xAJWwBxyAGlAAWhiAGzAHnNqP8ESAq4ByVPhDME/ucQCQ0A+Cm1AAGFAX2QAMQA+NvAfgVLF3uEMgO4AK3XEAg1gAP3fRAYAYX0OrWAGD+QI4QES4AATZAH/HwAfAB8AHwAfAB8AHwAfAH8fAB8AHwAfAP9//3/9fwgB/H9w8+ahxMnY/AEJ/38fAOh//2//f/9//fdvA/9v/3//f/+P/w/uf/3lBgR0QGEZMX+xXPE8MQD6CrAAC/89DwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8Afw8ADwAPAA8ADwAAAP0nNf/vIg8A/CfxIjV4HwIPALFj4/Fi/y8xADTvAg8A/y+//y8PAAYA8Wv1L/0HM+8C/w8A/AexMnEz/wcPADV3/w/98wcy7wIPAP8P/w8PAAYA93G7/wfzBzHvAg8A/AfxBH/xQ/8HDwABALFE/xfzBzD/7wIPAP8P/w8PAAYA8Uz/D93xBznPAg8ACgAS8AfxDH8xbf8HDwABALEC/w/xBzj/zwIPAP4H/w8PAAkAcXr/D/3xBzfPAg8A/gfxNDEV/wf3DwABAPEyH/8H8Affbw8A//8H/w8PAAkA8Ur/F/EH30//DwD/B/F0MT3/Bw8AAQCxQv//F/EH308PAP8H/w8PAAkAA7E69Q+psiBDAG8AbQAQYQBAbgBkADMALQASRAACAAYAAA8ABv9rAAAhZgMABhMEFgv+Mq8yfwF3BQAhMwIAAysSf6oxsT8BgWURqH8Bln/WMOJ/AQAXhAP+wAz9'
	$NordOuest &= 'AP/Bf8EzxQM/AD8APwA/AD8AIz8AHQALoAHiUQkAgENJQ1BGVDBfUFEKAAigA+IHoeR6QPZFfwYJAArgD+EGoRDhCO2CAAVHAYZq/lNb/w//D/v/DwAA/P8P/w//D/8PCwAB5TcRAEQ0NDQ1ADMwMlNlcHQyfDAyX6n/Fx8A/xflF/0f/yf/D/8P/yfzJwUAJPhyc2T/Df8Xfwb/F/AXf4IB/w//D/8P/wf/GwkADwAASUQgdXRpbIBpc2F0ZXVyZAEADQBNb3QgZGVAIHBhc3NlRAEdAABWYXJpYWJsAWABb3VyIHRleAB0ZSBzdGF0aWxxdUECQQcfRwLgA3a8YWxABQwGYAIgAAg6fQdoA7gFEARsJ+ljchxhbmQOoQIGAF9SVQBNQkFPRkZJQwBFTUFDU0NSSRhQVF+DAiIGGQBDAG9ubmV4aW9uACBEZXggTm9ygGQtT3Vlc3SPEP8PAA8ADwAPAA8ADwAPAA8A/w8ADgD/fD8APwD/f/9/DwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAAUA/a/uNS8iDwAIABTwr/+nDwB3+0L/r/UHNO8CDwD8BwbdcAAE/7cPAAQADv+/9ge/H9APAP8P/w8PAAcADf8P7/YHb3sPAP0HC7Rf/wcPAP0BAAz/B/YHH9APAP8P/w9/DwA4d/8X9gfvpw8A/QcKv3Fw/w8PADVv/w/0BznPAt8PAP7f/w8PAAkACf8P9Af+OM8CDwD+B/EkMQX/Bw8AAzKD+A/RsSBDAG8AbQAQYQBAbgBkADcALQASsAACAf8IACFmBwAGVh8EFgv+NjJ/DwAHDKsAAyV/BgADKxJ/NeJ/qgWAAROSPzSyPxGAA2oOqH8Eln8z/z8gAANV1j8y8h8SwAEQ6D8CXdY/MfIfwTLpPwHWPzAv8R/GHuUfAQAXxAELoAIB4hEJAENJQ1AYRlQwXxAKAAigA2XiB6Hk'
	$NordOuest &= 'OkBFfwYJAArf4A/hBqEQ4QiCAAVHAYY6vv1TG/8P/w//DwAA+/8PH/8P/w//DwsA5TcRAEQANDQ0NTMwMnCAYXNzd29yZH8P7/8XHwD/F+QX/P8n/w//D4P/J/MnBQAkcnN/Jv//F/8X/xfxF/8P/w//D/8HA/8bDgAPAElEIHUAdGlsaXNhdGUEdXJkAQ0ATW90UCBkZSARKWVEAR0AAFZhcmlhYmwBYAFvdXIgdGV4AHRlIHN0YXRpbHF1QQJBBx9HAuADdrxhbEAFDAZgAiAACDpdB2gDuAUQBGwn6WNyHGFuZA6hAgYAX1JVAE1CQU9GRklDAEVNQUNTQ1JJGFBUX4MCIgYZAEMAb25uZXhpb25AIERleCBOoDUt4E91ZXN0jxAPAA8A/w8ADwAPAA8ADwAPAA8ADgA='
	$NordOuest = _WinAPI_Base64Decode($NordOuest)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($NordOuest) & ']')
	DllStructSetData($tSource, 1, $NordOuest)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 10752)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Nord-Ouest.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_NordOuest

Func _NordEst($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $NordEst
	$NordEst &= 'lLIA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAA0ELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCnBfwbIQzEjYARPAAsAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGDAAAgECyJ3jLAAAijrEAlbAHHIAaUABKGIAbMAec2o/AABeFMAfyVPhDME/ucQCQxVAPm1AAGFAX2QAMbwAOPAfgVLF3uEMEsAA6ivEAg5gAP3fRAoA4X2yD0OAABHkCWECFOAA/hVkAR8AHwAfAB8AHwAfAP8fAB8AHwAfAB8AHwD/f/9/BfV/CPx/QA7zm8TwydgBCv9/HwDof/9v9/9//3/3bwP/b/9//3//j/f/D+5/5QYEdEBhGTF/sVzX8RyxPDEAC7AADL89DwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADgD9/Sc37yIPAPwn8SI1eB8Cjw8AMWMxMP8vMQA27wL/DwD/L/8vDwAGAHFr9S/9B/417wIPAPwHsTJxM/8HDwDvAQCxc/8P8wc07wIPAP8Pv/8PDwAGADF//w/zBzPvAv8PAPwHcUHxQ/8HDwABAHHD+/8P8wcy7wIPAP8P/w8PAO8GAPEK/wfzBzHvAg8A/Af9sVEJ/w8PAAQA8QL/F/MH/jDvAg8A/w//Dw8ABgDxdzv/D/EHOc8CDwC8ZAIB//E0MQX/Bw8AAQCxEv8P8Qf/328PAP8H/w8PAAkAcW3/D//xB99PDwD/B/E8MS3/Bw8A+wEA8UIf/wfwB99PDwD/Bx//Dw8ACQDxWvUXo7IgQwBvAG0AEGEAQG4AZAA1AC0AEkQAAgAGAAAOAAb/awAAIWYFAAYTBBYL/jRdMX8BAXcFACEzBAADK1USfzOyPxSAAxGofwOtln8ysr+tfwKWfzHy'
	$NordEst &= 'P9YVxDPlHwHWPzD/PyQAfhduGhcA8R8/AP8fAQD+/2AGfwB/AGEA4WBhQeUBHwD/HwAfAB8AHwAfAB8AHwAfAI8fAB8AHwAJAAugAeJxAAkAQ0lDUEZURjBfcAoACKAD4geh2eSaQEV/BgkACuAP4Qa3oRDhCIIABUcBhor+U1vv/w//D/8PAAD8/w//D/8PB/8PCwDlNxEARDU5ADgzNzAyU2Vw8HQyMDJfyf8XDwD/C/f/C/8LcQD9/wv/B/8HDwBn/wf/B/8HAPv/B/kTBeAAJHJzZP8BDwD/C///Cw8ADwD/C/8L/y//B/8H/w8ADwD/B/8H/ycPAP8HPwI/DwD/B/8H/wcPAAMADwAASUQgdXRpbGlAc2F0ZXVyZAENAABNb3QgZGUgIHBhc3NlRAEdAIBWYXJpYWJsYAEAb3VyIHRleHQAZSBzdGF0aXE2dUECQQcfRwLgA3Zh3mxABQwGYAIgAAg6lWgDA7gFEARsJ+ljcmEObmQOoQIGAF9SVU0AQkFPRkZJQ0UATUFDU0NSSVAMVF+DAiIGFwBDbwBubmV4aW9uIABEZXggTm9yZPAtRXN0bxAPAA8A/3//f3w/AD8APwD/fw8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADwC/DwAPAA8ADwAEAP2/Ny8i+w8ACAAU/9cPAAwAsdL/v93zBzbvAg8A/AcGNN3/B/sPAAEAEP/P9gcf8A8A/w///w8PAPlK/w/1Bx/wDwD9B34LtFf/Bw8AAQCx+vUPYLIgQwBvAG0AEGEAAG4AZAAxADMAwSsAFAACAf8IACFmWg0ABhMEFg3+MjB/Cq0ABwgAAyV/DBh/MeB/qguAASuUPzCwPw+AAy4JqH+Bl5N/OWwfAACuEvA/wSrTPzjyHw7EdLflH8GK0z83/z8gAAfAAGof0h828h8RxNTlHwZd1l81nwf/Hx4ABfYvNLefB/APYQkQ/x8GAAT2H3e/'
	$NordEst &= 'n/8fHwAD9h+/n/EPFHfiAP8fBQAC+I8fAO8PFfdkD/8PAwAB9h+/n/APZg/7/w8HABdfBB8ABAD/Dx8ATx8A/w//D3DRoAHyGAkAAENJQ1BGVDCnLxgPALlUoAPyA6F0LfxART8CDwC4aPAHcQNRCNtxBEIABacARi39rw3/B5//Bw8A/wf/B/8HAPv/B///B/8HDwD/B/8H/wf/B/sbABEARDU5ODM3ADAycGFzc3dv/HJkvwIPAP8L/wsPAP8L+/8L/gv8/wv/B/8HDwD/BzP/B/8HAPr/B/kTBQD4JHJzPxMPAP8L/wsPAP8PAP8L/wv/L/8H/wcPAA8A//8H/wf/Jw8A/wf/Bw8A/wcP/wf/B88DBAAPAElEACB1dGlsaXNhEHRldXJmxk1vdFAgZGUgETFlRAEdAABWYXJpYWJsAWABb3VyIHRleAB0ZSBzdGF0aWxxdUECQQcfRwLgA3b8YWxABQwGYAIgAJGkN3UHaAO4BRAEbCfpY3IcYW5kDqECBgBfUlUATUJBT0ZGSUMARU1BQ1NDUkkYUFRfgwIiBhcAQwBvbm5leGlvbkAgRGV4IE6gPS14RXN0bxAPAA8ADgA='
	$NordEst = _WinAPI_Base64Decode($NordEst)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($NordEst) & ']')
	DllStructSetData($tSource, 1, $NordEst)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 11776)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Nord-Est.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_NordEst

Func _OutreMer($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $OutreMer
	$OutreMer &= 'kbIA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAA0ELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCrDuhMAQzEjYARPAAoAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGLAAAgECyJ3hDBXAAIo7xAJWwBxyAGlAAShiAGzAHnNqPwAArhTAH8lT4QwSwAC5xAIqQ0A+bUAAYUBfZAB4MQA38B+BUsXe4QwR1cAAK8QCDmAA/d9ECgC94X0PQ4BiCeEZYQIUZCv/YQEfAB8AHwAfAB8AHwAfAP8fAB8AHwAfAB8A/3//f/V/Agj8f0CI9qXEyfjYAQr/fx8A6H//b/9/+/9/928D/2//f/9//4//D/vuf+UGBHRAYRkxf7Fc8RzrsTwxAAuwAAy/PQ8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA4A/Sf+Nu8iDwD8J/EiNXgfAg8Ax3FjMYD/LzEANe8CDwB//y//Lw8ABgCxa/Uv/Qc0/+8CDwD8B7EycTP/Bw8ANXf7/w/zBzPvAg8A/w//Dw8A7wYAcbv/B/MHMu8CDwD8B/9xQfFD/wcPAAEA8QL/B/MH/jHvAg8A/w//Dw8ABgCxTHv/H/MHMO8CDwD8B/EECb//Dw8ABADxb/8P8Qc5zwL/DwC8ZP8PDwALALEK/w/xB/44zwIPAP4H8TwxDf8HDwD/AQBxZf8P8Qffbw8A/wf/D/cPAAkA8Tof/wfwB99PDwD//gfyRDE1/wcPAAEA8VL/F//xB99PDwD/D/8PDwAJALFKAfUXmLIgQwBvAG0AEGEAQG4AZAA0AC0AElAAAgESAA4OAAb/awAAIWYEAAYrBBYL/jOvMn8BdwUAITMDAAMTEn9WMrE/giURqH8Cln8xrbJ/FIQ9pT8Bln8w8j/7'
	$OutreMer &= '7V8BABduGhcA8R8/AP8f+z8A/x/+YAZ/AH8A4UnhUP/lAR8AHwAfAB8AHwAfAB8APx8AHwAfAB8AHwANAAugAgHigQkAQ0lDUBhGVDBfgAoACKADZeIHoeSqQEV/BgkACt/gD+EGoRDhCIIABUcBhqq+/lNb/w//D/8PAAD8/w8f/w//D/8PCwDlNxEARAA5NzE4OTAyU8BlcHQyMDJf2f8X3w8A/wv/C/8LcQD9/wv/B5//Bw8A/wf/B/8HAPv/B4H5EwUAJFJTRP8B/w8A/wv/Cw8ADwD/A/8DDwD//w//D/8PDwD/B/8HDwAPAA//B/8H/ysLAA8ASUQAIHV0aWxpc2EQdGV1cmQBDQBNAG90IGRlIHBhCHNzZUQBHQBWYSByaWFibGABb3UAciB0ZXh0ZSCAc3RhdGlxdUECjUEHH0cC4AN2YWxABfcMBmACIAAIOploA7gFEASAbCfpY3JhbmQOA6ECBgBfUlVNQkEAT0ZGSUNFTUEAQ1NDUklQVF8DgwIiBhgAQ29ubgBleGlvbiBEZQB4IE91dHJlLfxNZVUODwAPAA8ADwAPAP8PAA8A/38/AD8APwD/fw8A/w8ADwAPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAGAP3H7jYvIg8ACAAU/9cPAAwAdhD/x/YHNe8CDwD8Bwb/NOX/Bw8A80b/1/UHH/APAP//D/8PDwAHALHy/w/zBx/w+w8A/QcLtFv/Bw8Ag1X3B2eyIEMAbwBtABBhAABuAGQAMQAyAMErABQAAgH/CAAhZloMAAYTBBYN/jEwfwqtAAcIAAMlfwsAAysUfy4w4H+BV5N/Oaw+AADqEoA/D4ADCah/gRWTf1448h/tP8Fq0z838h8Oq8SU5R8HwAAf0h82/z9VIAAG1l818h8RwAENdeg/BdZfNJ8H/x8eAATd9h8znwfwD2EZEP8fBgB+A/Yfv5/wD+IO/x8HAAJ3'
	$OutreMer &= '+I8fAO8fFOIA/x8FAAHf9h+/n/8fHwABABdfBB8A/wQA/w8fAB8A/w//Dx8AHwAn/w8fAGjhoAHyIAkAgENJQ1BGVDAvIFMPALlcoAPyA6F0NUD+RT8CDwC4cPAHcQNRCHEE7UIABacARi39rw3/B/8Hzw8A/wf/B/8HAPv/B/8Hf/8HDwD/B/8H/wf/B/sbEQAARDk3MTg5MAAycGFzc3dvcv5kvwIPAP8L/wsPAP8L/wv9/gv8/wv/B/8HDwD/B/8HGf8HAPr/B/kTBQAk+FJTRP8BDwD/C/8LDwD/DwD/A/8DDwD/D/8P/w9yAP/PA/8H/wcPAP8H/wf/B/8rAQYADwBJRCB1dABpbGlzYXRldQJyZAENAE1vdCAoZGUgES1lRAEdAIBWYXJpYWJsYAEAb3VyIHRleHQAZSBzdGF0aXE2dUECQQcfRwLgA3Zh/mxABQwGYAIgAJGoN3loAwO4BRAEbCfpY3JhDm5kDqECBgBfUlVNAEJBT0ZGSUNFAE1BQ1NDUklQDFRfgwIiBhgAQ28Abm5leGlvbiAARGV4IE91dHLwZS1NZVUODwAPAA8ADw8ADwAPAA8AAA=='
	$OutreMer = _WinAPI_Base64Decode($OutreMer)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($OutreMer) & ']')
	DllStructSetData($tSource, 1, $OutreMer)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 11776)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Outre-Mer.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_OutreMer

Func _SudEst($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $SudEst
	$SudEst &= 'lLIA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAAwELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCqCTLckQzEjYARHAAkAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGLAAAgECyJ3hDBTAAIo5xAJWwBxyAGlAAWhiAGzAHnNqP8ESAq4ByVPhDME/ucQCQ0A+Cm1AAGFAX2QAMQA+NvAfgVLF3uEMgO4AK3XEAg1gAP3fRAYAYX0OrWAGD+QI4QES4AATZAH/HwAfAB8AHwAfAB8AHwAfAH8fAB8AHwAfAP9//3/9fwgB/H/wtCGtxMnY/AEJ/38fAOh//2//f/9//fdvA/9v/3//f/+P/w/uf/3lBgR0QGEZMX+xXPE8MQD6CrAAC/89DwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8Afw8ADwAPAA8ADwAAAP0nNf/vIg8A/CfxIjV4HwIPALFj4/Fi/y8xADTvAg8A/y+//y8PAAYA8Wv1L/0HM+8C/w8A/AexMnEz/wcPADV3/w/98wcy7wIPAP8P/w8PAAYA93G7/wfzBzHvAg8A/AfxBH/xQ/8HDwABALFE/xfzBzD/7wIPAP8P/w8PAAYA8Uz/D9/xB1VhDwAPAAMAEvAH8Qx/MW3/Bw8AAQCxAv8P8Qc4/88CDwD+B/8PDwAJAHF6/w/98Qc3zwIPAP4H8TQxFf8H9w8AAQDxMh//B/AH328PAP//B/8PDwAJAPFK/xfxB99P/w8A/wfxdDE9/wcPAAEAsUL//xfxB99PDwD/B/8PDwAJAAOxOvUPo7IgQwBvAG0AEGEAQG4AZAAzAC0AEkQAAgAGAAAPAAb/awAAIWYDAAYTBBYL/jKvMn8BdwUAITMCAAMrEn+qMbE/AYFlEah/AZZ/1jDifwEAF4QD/sAM'
	$SudEst &= '/QD/wX/BM8UDPwA/AD8APwA/ACM/AB0AC6AB4lEJAIBDSUNQRlQwX1BRCgAIoAPiB6HkekD2RX8GCQAK4A/hBqEQ4QjtggAFRwGGav1TW/8P/w/7/w8AAPv/D/8P/w//DwsAAeU3EQBEMDYzNAAxMDJTZXB0MnwwMl+p/xcfAP8X5Rf8H/8n/w//D/8n8ycFACT4UlNE/w3/F38G/xfwFz//D/8P/w//B/8bDgAPAABJRCB1dGlsaUBzYXRldXJkAQ0AAE1vdCBkZSAgcGFzc2VEAR0AgFZhcmlhYmxgAQBvdXIgdGV4dABlIHN0YXRpcTZ1QQJBBx9HAuADdmHebEAFDAZgAiAACDp9aAMDuAUQBGwn6WNyYQ5uZA6hAgYAX1JVTQBCQU9GRklDRQBNQUNTQ1JJUAxUX4MCIgYWAENvAG5uZXhpb24gAERleCBTdWQt+EVzdF8QDwAPAA8ADwD/DwAPAA8ADwAPAA8A/38/AP8/AP9//38PAA8ADwAPAA8A/w8ADwAPAA8ADwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAO8PAA8ABwD9rzUvIg8ACAB+FPCv/6cPAPtC/6/1BzTX7wIPAPwHBnAABK9SDwD9BAAO/7/2Bx/QDwD/D/8P+w8ABwAN/w/2B297DwD9B94LtF//Bw8AAQAM/wf2B/8f0A8A/w//Dw8AOHf/F/YH9++nDwD9BwpxcP8PDwA1b/v/D/QHOc8CDwD+3/8PDwDtCQAJ/w/0BzjPAg8A/gc/8SQxBf8HDwAyg/gP1bEgQwBvAG0AEGEAQG4AZAA3AC0AErAAAgH/CAAhZgcABlYfBBYL/jYyfw8ABwyrAAMlfwYAAysSfzXif6oFgAETkj80sj8RgANqDqh/BJZ/M/8/IAADVdY/MvIfEsABEOg/Al3WPzHyH8Ey6T8B1j8wL/Efxh7lHwEAF8QBC6ACAeIRCQBDSUNQGEZUMF8QCgAIoANl4geh5DpARX8G'
	$SudEst &= 'CQAK3+AP4QahEOEIggAFRwGGOr78Uxv/D/8P/w8AAPr/Dx//D/8P/w8LAOU3EQBEADA2MzQxMDJwgGFzc3dvcmR/D+//Fx8A/xfkF/v/J/8P/w8D/yfzJwUAJFJTRP//Df8Xfwb/F/AXVHv/D/8PD/8H/wf/GwcADwBJRAAgdXRpbGlzYRB0ZXVyZAENAE1Ab3QgZGUgESllAUQBHQBWYXJpYQRibGABb3VyIHQAZXh0ZSBzdGGwdGlxdUECQQcfRwLx4AN2YWxABQwGYAIgAB4IOl1oA7gFEARsJ+lwY3JhbmQOoQIGAF8AUlVNQkFPRkYASUNFTUFDU0NgUklQVF+DAiIGFgAAQ29ubmV4aQBvbiBEZXggU8B1ZC1Fc3RfEA8A/w8ADwAPAA8ADwAPAA8ADwABDwAAAA=='
	$SudEst = _WinAPI_Base64Decode($SudEst)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($SudEst) & ']')
	DllStructSetData($tSource, 1, $SudEst)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 10752)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Sud-Est.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_SudEst

Func _SudOuest($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $SudOuest
	$SudOuest &= 'k7IA0M8R4KGxGuECAAwAPgADAP7/KAkABghMAQkcEACEAAwELP7///8FLiMAFKoBUgBvQAB0ACAgAEUAbsABcgBGeY2CGgAWAAXGfAcBwAOQ7O+/oZrOABGmQAJgjI9oAvHJCoA4nc8QzEjYARHAAkAFwwRNEABhAGNAHW8ASFQAZcACZEABcugfGLAAAgECyJ3hDBTAAIo7xAJWwBxyAGlAAWhiAGzAHnNqP8ESAq4ByVPhDME/ucQCQ0A+Cm1AAGFAX2QAMQA+NvAfgVLF3uEMgO4AK3XEAg1gAP3fRAYAYX0OrWAGD+QI4QES4AATZAH/HwAfAB8AHwAfAB8AHwAfAH8fAB8AHwAfAP9//3/9fwgB/H9wWXCyxMnY/AEJ/38fAOh//2//f/9//fdvA/9v/3//f/+P/w/uf/3lBgR0QGEZMX+xXPE8MQD6CrAAC/89DwAPAA8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8Afw8ADwAPAA8ADwAAAP0nNf/vIg8A/CfxIjV4HwIPALFj4/Fi/y8xADTvAg8A/y+//y8PAAYA8Wv1L/0HM+8C/w8A/AexMnEz/wcPADV3/w/98wcy7wIPAP8P/w8PAAYA93G7/wfzBzHvAg8A/AfxBH/xQ/8HDwABALFE/xfzBzD/7wIPAP8P/w8PAAYA8Uz/D93xBznPAg8ACgAS8AfxDH8xbf8HDwABALEC/w/xBzj/zwIPAP4H/w8PAAkAcXr/D/3xBzfPAg8A/gfxNDEV/wf3DwABAPEyH/8H8Affbw8A//8H/w8PAAkA8Ur/F/EH30//DwD/B/F0MT3/Bw8AAQCxQv//F/EH308PAP8H/w8PAAkAA7E69Q+nsiBDAG8AbQAQYQBAbgBkADMALQASRAACAAYAAA8ABv9rAAAhZgMABhMEFgv+Mq8yfwF3BQAhMwIAAysSf6oxsT8BgWURqH8Bln/WMOJ/AQAXhAP+wAz9'
	$SudOuest &= 'AP/Bf8EzxQM/AD8APwA/AD8AIz8AHQALoAHiUQkAgENJQ1BGVDBfUFEKAAigA+IHoeR6QPZFfwYJAArgD+EGoRDhCO2CAAVHAYZq/lNb/w//D/v/DwAA/P8P/w//D/8PCwAB5TcRAEQzMTMyADcwMlNlcHQyfDAyX6n/Fx8A/xflF/0v/yf/D/8P9g/7+ycFAPAkUlNE/w3/F38G/xd/8Bf/D/8P/w//B/8nDgAPAABJRCB1dGlsgGlzYXRldXJkAQANAE1vdCBkZUAgcGFzc2VEAR0AAFZhcmlhYmwBYAFvdXIgdGV4AHRlIHN0YXRpbHF1QQJBBx9HAuADdrxhbEAFDAZgAiAACDp9B2gDuAUQBGwn6WNyHGFuZA6hAgYAX1JVAE1CQU9GRklDAEVNQUNTQ1JJGFBUX4MCIgYYAEMAb25uZXhpb24AIERleCBTdWTALU91ZXN0fxAPAP8PAA8ADwAPAA8ADwAPAA8A/w8A/3w/AD8A/3//fw8ADwD/DwAPAA8ADwAPAA8ADwAPAP8PAA8ADwAPAA8ADwAPAA8Afw8ADwAPAA8ADwAFAP2vNfcvIg8ACAAU8K//pw8A+0K7/6/1BzTvAg8A/AcGcADuBK9SDwAEAA7/v/YHH9DfDwD/D/8PDwAHAA3/D/YH9297DwD9Bwu0X/8HDwABAP4M/wf2Bx/QDwD/D/8PDwC/OHf/F/YH76cPAP0HCnFw3/8PDwA1b/8P9Ac5zwIPAG/+3/8PDwAJAAn/D/QHOP/PAg8A/gfxJDEF/wcPADKDAfgP1rEgQwBvAG0AEGEAQG4AZAA3AC0AErAAAgH/CAAhZgcABlYfBBYL/jYyfw8ABwyrAAMlfwYAAysSfzXif6oFgAETkj80sj8RgANqDqh/BJZ/M/8/IAADVdY/MvIfEsABEOg/Al3WPzHyH8Ey6T8B1j8wL/Efxh7lHwEAF8QBC6ACAeIRCQBDSUNQGEZUMF8QCgAIoANl4geh5DpA'
	$SudOuest &= 'RX8GCQAK3+AP4QahEOEIggAFRwGGOr79Uxv/D/8P/w8AAPv/Dx//D/8P/w8LAOU3EQBEADMxMzI3MDJwgGFzc3dvcmR/D+//Fx8A/xfkF/z/J/8P/w8F9g/6+ycFACRSU/5E/w3/F38G/xfwF1R7/w8f/w//B/8H/ycHAA8ASQBEIHV0aWxpcyBhdGV1cmQBDQCATW90IGRlIBEpAmVEAR0AVmFyaQhhYmxgAW91ciAAdGV4dGUgc3RgYXRpcXVBAkEHH+NHAuADdmFsQAUMBmACPSAACDpdaAO4BRAEbCfg6WNyYW5kDqECBgAAX1JVTUJBT0YARklDRU1BQ1PAQ1JJUFRfgwIiBgAYAENvbm5leABpb24gRGV4IABTdWQtT3Vlc/50fxAPAA8ADwAPAA8ADwAPDwAPAA8ADwA='
	$SudOuest = _WinAPI_Base64Decode($SudOuest)
	If @error Then Return SetError(1, 0, 0)
	Local $tSource = DllStructCreate('byte[' & BinaryLen($SudOuest) & ']')
	DllStructSetData($tSource, 1, $SudOuest)
	Local $tDecompress
	_WinAPI_LZNTDecompress($tSource, $tDecompress, 10752)
	If @error Then Return SetError(3, 0, 0)
	$tSource = 0
	Local Const $bString = Binary(DllStructGetData($tDecompress, 1))
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Sud-Ouest.rmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString


EndFunc   ;==>_SudOuest


;nouvelle version: Quick3270 avec SSH (du 16-09-2023)

;Macro unique Quick3270 'Macro Quick3270.qmc'
Func _MacroQuick3270($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $MacroQuick3270
	$MacroQuick3270 &= 'Jy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KJyBNYWNybyB3YXMgY3JlYXRlZCBieSB0aGUgUXVpY2szMjcwIE1hY3JvIFJlY29yZGVyLg0KJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQogICBIb3N0U2V0dGxlVGltZSA9IDMwMDAgICAgICAgICAgICAgICA7IG1pbGxpc2Vjb25kcw0KICAgU2VuZEtleXMgImNpY3BmdDAwPEVudGVyPiINCiAgIFJlc3VsdCA9IFdhaXRGb3JBdHRyaWIoMSwgMSwgJkgzMCwgJkgzQywgMywgMzAwMCkNCiAgIFJlc3VsdCA9IFdhaXRGb3JDdXJzb3IoMSwgMSkNCiAgIFJlc3VsdCA9IFdhaXRGb3JLYmRVbmxvY2soKQ0KICAgU2VuZEtleXMgIjxFbnRlcj4iDQogICBSZXN1bHQgPSBXYWl0Rm9yQXR0cmliKDEsIDEsICZIMzAsICZIM0MsIDMsIDMwMDApDQogICBSZXN1bHQgPSBXYWl0Rm9yQ3Vyc29yKDEsIDEpDQogICBSZXN1bHQgPSBXYWl0Rm9yS2JkVW5sb2NrKCkNCiAgIFNlbmRLZXlzICI8RW50ZXI+Ig0KICAgUmVzdWx0ID0gV2FpdEZvckF0dHJpYig3LCAyMywgJkgwMCwgJkgzQywgMywgMzAwMCkNCiAgIFJlc3VsdCA9IFdhaXRGb3JDdXJzb3IoNywgMjQpDQogICBSZXN1bHQgPSBXYWl0Rm9yS2JkVW5sb2NrKCkNCiAgIFNlbmRLZXlzICJjb21wdGVEZWxlZyINCiAgIFNlbmRLZXlzICJwYXNzd29yZCINCiAgIFNlbmRLZXlzICI8RW50ZXI+Ig0KICAg'
	$MacroQuick3270 &= 'UmVzdWx0ID0gV2FpdEZvckF0dHJpYigyNCwgNjgsICZIMzAsICZIM0MsIDMsIDMwMDApDQogICBSZXN1bHQgPSBXYWl0Rm9yQ3Vyc29yKDEsIDEpDQogICBSZXN1bHQgPSBXYWl0Rm9yS2JkVW5sb2NrKCkNCiAgIFNlbmRLZXlzICI8RW50ZXI+Ig0KICAgUmVzdWx0ID0gV2FpdEZvckN1cnNvcigxLCAxKQ0KICAgUmVzdWx0ID0gV2FpdEZvcktiZFVubG9jaygpDQogICBTZW5kS2V5cyAiJFJTRDxFbnRlcj4iDQogICBSZXN1bHQgPSBXYWl0Rm9yQXR0cmliKDI0LCAxLCAmSDAwLCAmSDNDLCAzLCAzMDAwKQ0KICAgUmVzdWx0ID0gV2FpdEZvckN1cnNvcigyNCwgMikNCiAgIFJlc3VsdCA9IFdhaXRGb3JLYmRVbmxvY2soKQ0KICAgU2VuZEtleXMgIjxFbnRlcj4iDQpFbmQ='
	Local $bString = _WinAPI_Base64Decode($MacroQuick3270)
	If @error Then Return SetError(1, 0, 0)
	$bString = Binary($bString)
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Macro Quick3270.qmc", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString
EndFunc   ;==>_MacroQuick3270


;Quick3270 ECF (Ecran Main Frame)
Func _RumbaECF($bSaveBinary = True, $sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro")
	Local $RumbaECF
	$RumbaECF &= 'W1ZlcnNpb25dDQpTb2Z0d2FyZT1RdWljazMyNzANClZlcnNpb249NC42MiBidWlsZCAwMDQNCklEPUNvbmZpZ3VyYXRpb24gZmlsZQ0KDQpbR2VuZXJhbF0NCldpbmRvd1BsYWNlbWVudD0yQzAwMDAwMDAwMDAwMDAwMDEwMDAwMDBGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRjhFRkJGRkZGREIwMDAwMDBGQUZGRkZGRjEzMDQwMDAwOEQNClVJTGFuZ3VhZ2U9MDAwMDAwMDAwMA0KQ2VsbFNpemU9MDIwMDAwMDAwMg0KQXV0b1JlY29ubmVjdD1UcnVlDQpBdXRvQ29ubmVjdD1UcnVlDQpTYXZlV2luZG93UG9zPVRydWUNClZUX0hpc3RvcnlLQj0yDQpWVF9DaGFyc2V0PTANClN0YXJ0dXBNYWNybz1DOlxVc2Vyc1xwaHhnNjkyXEFwcERhdGFcTG9jYWxcVmlydHVhbFN0b3JlXFByb2dyYW0gRmlsZXMgKHg4NilcUlVNQkFSSFxNZnJhbWVcTWFjcm9cTWFjcm8gUXVpY2szMjcwLnFtYw0KDQpbTG9nZ2luZ10NCktleXN0cm9rZUxvZz1LZXlzdHJva2VzLmxvZw0KSGxsYXBpTG9nPVF1aWNrSExMQVBJLmxvZw0KDQpbQ29ubmVjdGlvbl0NClVzZVNTTD1UcnVlDQpIb3N0Q29kZVBhZ2VJRD0xMDAwNw0KUG9ydE51bWJlcj03MDIzDQpIb3N0TmFtZT1DSUNTLUFDQ1VFSUwtUFJPRC56Lm1ldGllci5zZi5pbnRyYS5sYXBvc3RlLmZyDQpNb2RlbE5hbWVBTlNJPQ0KDQpbU2NyZWVuRm9udF0NCkZvbnROYW1lPVF1aWNrMzI3MA0KQ2hhckhlaWdodD0yOA0KQ2hhcldpZHRoPTEyDQoNCltGaWxlVHJhbnNmZXJdDQpIb3N0Q29k'
	$RumbaECF &= 'ZVBhZ2VJRD0xMDAwNw0KUGNDb2RlUGFnZT0xMjUyDQpTdHJ1Y3R1cmVkRmllbGRTaXplPTcxNjgNCg0KW05ld0tleWJvYXJkTWFwcGluZ10NCkxDSUQ9MEMwNDAwMDAxMA0KDQpbUHVzaEJ1dHRvbnNdDQpTdHJpbmdfMD1QQTEgPT0+IA0KUGFyYW1fMD0wMjAwMDAwMDAxMDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMEINClN0cmluZ18xPVBBMiA9PT4gDQpQYXJhbV8xPTAzMDAwMDAwMDEwMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAwQw0KU3RyaW5nXzI9UEYxL1BGMTMgPT0+IA0KUGFyYW1fMj0wNDAwMDAwMDAxMDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMEQNClN0cmluZ18zPVBGMy9QRjE1ID09PiANClBhcmFtXzM9MDYwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBGDQpTdHJpbmdfND1QRjEvMTMNClBhcmFtXzQ9MDQwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBEDQpTdHJpbmdfNT1QRjIvMTQNClBhcmFtXzU9MDUwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBFDQpTdHJpbmdfNj1QRjMvMTUNClBhcmFtXzY9MDYwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAw'
	$RumbaECF &= 'MDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBGDQpTdHJpbmdfNz1QRjQvMTYNClBhcmFtXzc9MDcwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDEwDQpTdHJpbmdfOD1QRjcvMTkNClBhcmFtXzg9MDgwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDExDQpTdHJpbmdfOT1QRjgvMjANClBhcmFtXzk9MDkwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDEyDQpTdHJpbmdfMTA9UEYxMC8yMg0KUGFyYW1fMTA9MEQwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDE2DQpTdHJpbmdfMTE9UEYxMS8yMw0KUGFyYW1fMTE9MEUwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDE3DQpTdHJpbmdfMTI9UEYxMi8yNA0KUGFyYW1fMTI9MEYwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDE4DQpTdHJpbmdfMTM9UEExPQ0KUGFyYW1fMTM9MDIwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBCDQpTdHJpbmdfMTQ9UEEyPQ0KUGFyYW1fMTQ9MDMwMDAwMDAwMTAxMDAwMDAwMDAwMDAwMDAwMDAw'
	$RumbaECF &= 'MDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDBDDQpTdHJpbmdfMTU9MT1IZWxwDQpQYXJhbV8xNT0wNDAwMDAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMEMNClN0cmluZ18xNj1DbGVhcg0KUGFyYW1fMTY9MDEwMDAwMDAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDA5DQpTdHJpbmdfMTc9SG9sZGluZw0KUGFyYW1fMTc9MDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDA4DQpTdHJpbmdfMTg9RW50ZXINClBhcmFtXzE4PTAwMDAwMDAwMDAwMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAwOA0KU3RyaW5nXzE5PU1vcmUNClBhcmFtXzE5PTFDMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAyMw0KU3RyaW5nXzIwPUJvdHRvbQ0KUGFyYW1fMjA9MUQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDI0DQpTdHJpbmdfMjE9RW5kDQpQYXJhbV8yMT0xRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMjQNClN0cmluZ18yMj1FaW5nYWJldGFzdGUNClBhcmFtXzIyPTAwMDAwMDAwMDAwMTAwMDAwMDAw'
	$RumbaECF &= 'MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAwOA0KU3RyaW5nXzIzPVdlaXRlcmUNClBhcmFtXzIzPTFDMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAyMw0KU3RyaW5nXzI0PUVuZGUNClBhcmFtXzI0PTFEMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAyNA0KU3RyaW5nXzI1PUludmlvDQpQYXJhbV8yNT0wMDAwMDAwMDAwMDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMDgNClN0cmluZ18yNj1TZWd1ZQ0KUGFyYW1fMjY9MUMwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDIzDQpTdHJpbmdfMjc9RmluZQ0KUGFyYW1fMjc9MUQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDI0DQpTdHJpbmdfMjg9Mz1Vc2NpdGENClBhcmFtXzI4PTA2MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAwRA0KU3RyaW5nXzI5PUVudHLpZQ0KUGFyYW1fMjk9MDAwMDAwMDAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDQwMDAwMDAwMzAwMDAwMDA4DQpTdHJpbmdfMzA9RmluDQpQYXJhbV8zMD0xRDAwMDAwMDAwMDAwMDAw'
	$RumbaECF &= 'MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMjQNClN0cmluZ18zMT1Sb2xsL1VwDQpQYXJhbV8zMT0xQzAwMDAwMDAxMDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDAzMDAwMDAwMjUNClN0cmluZ18zMj1Sb2xsL2Rvd24NClBhcmFtXzMyPTFEMDAwMDAwMDEwMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA0MDAwMDAwMDMwMDAwMDAyNg0KDQpbVG9vbGJhcl0NCkJ1dHRvbnM9MTUNCkRlZmF1bHQ9MDgwMDAwMDAwMDAwMDAwMDA0MDEwMDAwMDAwMDAwMDBGRkZGRkZGRjA4MDAwMDAwRkZGRkZGRkZGRkZGMDAwMDAwMDAwMDAwRkZGRkZGRkYwNDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDgwMDAwMDAwMTAwMDAwMEEyMEYwMDAwMDQwMDAwMDBGRkZGRkZGRjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDIwMDAwMDBBNDBGMDAwMDA0MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDA4MDAwMDAwMDAwMDAwMDAwNDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMEZGRkZGRkZGRkZGRkZGRkYwNjAwMDAwMEE2MEYwMDAwMDQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDgwMDAwMDAwMDAwMDAwMDA0MDEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwRkZGRkZGRkZGRkZGRkZGRjAzMDAwMDAwMDUxMDE3MDAwMDAwMDAw'
	$RumbaECF &= 'MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwNDAwMDAwMDA2MTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDUwMDAwMDAwODEwMDAwMDA0MDAwMDAwQjE='
	Local $bString = _WinAPI_Base64Decode($RumbaECF)
	If @error Then Return SetError(1, 0, 0)
	$bString = Binary($bString)
	If $bSaveBinary Then
		Local Const $hFile = FileOpen($sSavePath & "\Rumba.ecf", 18)
		If @error Then Return SetError(2, 0, $bString)
		FileWrite($hFile, $bString)
		FileClose($hFile)
	EndIf
	Return $bString
EndFunc   ;==>_RumbaECF

Func _pwd()

If $LancerRumba=1 Then
   $Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf

$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"

   ;mdp actuels fichier ini ...
$NordEst= IniRead($file,"Nord-Est","compte",0)
$NordOuest=IniRead($file,"Nord-Ouest","compte",0)
$SudEst= IniRead($file,"Sud-Est","compte",0)
$SudOuest= IniRead($file,"Sud-Ouest","compte",0)
$IledeFrance= IniRead($file,"Ile-de-France","compte",0)
$OutreMER= IniRead($file,"Outre-MER","compte",0)
$w1=0
$w2=0
$w3=0
$w4=0
$w5=0
$w6=0

;-------------------------------------------
;ecriture fichiers rumba... et màj t41.ini
;-------------------------------------------

;Nord-Est;
$fichier=FileOpen($sSavePath & "\Nord-Est.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Nord-Est.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($NordEst,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Nord-Est, nouveau mdp","actuel: " & $NordEst, $NordEst )
if @error=1 Then
$new=$NordEst
EndIf
$NordEstini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w1=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Nord-Est", "compte", $NordEstini)

;Nord-Ouest
$fichier=FileOpen($sSavePath & "\Nord-Ouest.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Nord-Ouest.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($NordOuest,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Nord-Ouest, nouveau mdp","actuel: " & $NordOuest, $NordOuest )
if @error=1 Then
$new=$NordOuest
EndIf
$NordOuestini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w2=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Nord-Ouest", "compte", $NordOuestini)

;Sud-Est
$fichier=FileOpen($sSavePath & "\Sud-Est.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Sud-Est.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($SudEst,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Sud-Est, nouveau mdp","actuel: " & $SudEst, $SudEst )
if @error=1 Then
$new=$SudEst
EndIf
$SudEstini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w3=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Sud-Est", "compte", $SudEstini)

;Sud-Ouest
$fichier=FileOpen($sSavePath & "\Sud-Ouest.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Sud-Ouest.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($SudOuest,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Sud-Ouest, nouveau mdp","actuel: " & $SudOuest, $SudOuest )
if @error=1 Then
$new=$SudOuest
EndIf
$SudOuestini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w4=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Sud-Ouest", "compte", $SudOuestini)


;$IledeFrance
$fichier=FileOpen($sSavePath & "\Ile-de-France.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Ile-de-France.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($IledeFrance,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Ile-de-France, nouveau mdp","actuel: " & $IledeFrance, $IledeFrance )
if @error=1 Then
$new=$IledeFrance
EndIf
$IledeFranceini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w5=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Ile-de-France", "compte", $IledeFranceini)



;$OutreMER
$fichier=FileOpen($sSavePath & "\Outre-Mer.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Outre-Mer.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($OutreMER,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
$new=InputBox("Outre-Mer, nouveau mdp","actuel: " & $OutreMER, $OutreMER )
if @error=1 Then
$new=$OutreMER
EndIf
$OutreMERini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
$w6=FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Outre-Mer", "compte", $OutreMERini)

if ($w1=0 or $w2=0 or $w3=0 or $w4=0 or $w5=0 or $w6=0) Then
MsgBox(0,"Info !","t41.ini màj: OK" & @CRLF & " => Macros Rumba/RACF màj: KO (lecture seule)" & @CRLF & "NE-NO-SE-SO-IdF-OM" & @CRLF & " " & $w1 & "- " & $w2 & "- " & $w3 & "- " & $w4 & "- " & $w5 & "- " & $w6 )
Else
MsgBox(0,"Info !","t41.ini màj et fichiers Rumba/RACF màj: OK" & @CRLF & "NE-NO-SE-SO-IdF-OM" & @CRLF & " " & $w1 & "- " & $w2 & "- " & $w3 & "- " & $w4 & "- " & $w5 & "- " & $w6)
EndIf
EndIf

If $LancerQuick3270=1 Then ;init pwd avec compte Nord-EST
      ;mdp actuels fichier ini ...
$NordEst= IniRead($file,"Nord-Est","compte",0) ;avec macro traité en dernier
$NordOuest=IniRead($file,"Nord-Ouest","compte",0)
$SudEst= IniRead($file,"Sud-Est","compte",0)
$SudOuest= IniRead($file,"Sud-Ouest","compte",0)
$IledeFrance= IniRead($file,"Ile-de-France","compte",0)
$OutreMER= IniRead($file,"Outre-MER","compte",0)

;;NE
$newNE=InputBox("Nord-Est, nouveau mdp","actuel: " & $NordEst, $NordEst )
if @error=1 Then
$newNE=$NordEst
EndIf
IniWrite($file, "Nord-Est", "compte", $newNE)

;;NO
$newNO=InputBox("Nord-Ouest, nouveau mdp","actuel: " & $NordOuest, $NordOuest )
if @error=1 Then
$newNO=$NordOuest
EndIf
IniWrite($file, "Nord-Ouest", "compte", $newNO)
;;SE
$newSE=InputBox("Sud-Est, nouveau mdp","actuel: " & $SudEst, $SudEst )
if @error=1 Then
$newSE=$SudEst
EndIf
IniWrite($file, "Sud-Est", "compte", $newSE)
;;SO
$newSO=InputBox("Sud-Ouest, nouveau mdp","actuel: " & $SudOuest, $SudOuest )
if @error=1 Then
$newSO=$SudOuest
EndIf
IniWrite($file, "Sud-Ouest", "compte", $newSO)
;;IdF
$newIdF=InputBox("Ile-de-France, nouveau mdp","actuel: " & $IledeFrance, $IledeFrance )
if @error=1 Then
$newIdF=$IledeFrance
EndIf
IniWrite($file, "Ile-de-France", "compte", $newIDF)
;;OM
$newOM=InputBox("Outre-MER, nouveau mdp","actuel: " & $OutreMER, $OutreMER )
if @error=1 Then
$newOM=$OutreMER
EndIf
IniWrite($file, "Outre-MER", "compte", $newOM)

;;NE (avec la macro)
;$NordEst= IniRead($file,"Nord-Est","compte",0) ;mdp de t41.ini deja lu...
$NordEstarray=StringSplit($NordEst,";") ;mdp actuel
if IsArray($NordEstarray) Then
$NordEstarraycompte=$NordEstarray[1]
$NordEstarraypassword=$NordEstarray[2]

$newNEpwd=StringSplit($newNE,";")
if IsArray($newNEpwd) then
$NordEstarraycompteNew=$newNEpwd[1]
$NordEstarrayNewpassword=$newNEpwd[2]
Else
$NordEstarraycompteNew=$NordEstarraycompte
$NordEstarrayNewpassword=$NordEstarraypassword
EndIf
    $Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf
$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"

;Nord-Est; 'Macro Quick3270.qmc' initial...
$fichier=FileOpen($sSavePath & "\Macro Quick3270.qmc", 0 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
;MsgBox(0,"Lecture OK",$binary) ; lecture ok

;écriture compte & pwd du fichier initial avec valeure NE
$fichiermodif=FileOpen($sSavePath & "\Macro Quick3270.qmc", 2 );16+2;binary
$binary=StringReplace($binary,$NordEstarraycompte,$NordEstarraycompteNew) ;new compte NE
$binary=StringReplace($binary,$NordEstarraypassword,$NordEstarrayNewpassword) ;new Pwd ;;NE

;MsgBox(0,"Ecriture OK",$binary) ;Ecriture OK
FileWrite($fichiermodif,$binary)
sleep(1000)
FileClose($fichiermodif)

;déjà ecrit dans ;;NE
;IniWrite($file, "Nord-Est", "compte", $newNE)

;
;startup macro Rumba.ecf (modif du chemin..) => ligne: StartupMacro=C:\Users\phxg692\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\Macro Quick3270.qmc
;
$fichier=FileOpen($sSavePath & "\Rumba.ecf", 0 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
;MsgBox(0,"Lecture OK",$binary) ; lecture ok

if StringInStr($binary,"phxg692") Then ;check si idrh=phxg692 sinon ne fait rien...
;écriture compte & pwd du fichier initial avec valeure NE
$fichiermodif=FileOpen($sSavePath & "\Rumba.ecf", 2 );16+2;binary
$binary=StringReplace($binary,"phxg692",StringStripWS(@username, 8) )

;MsgBox(0,"Ecriture OK",$binary) ;Ecriture OK
FileWrite($fichiermodif,$binary)
sleep(1000)
FileClose($fichiermodif)
EndIf
;
;

MsgBox(0,"Info","t41.ini , mots de passes définis sur t41.ini, y compris pour la macro Quick3270",14)
Else ;ko array
MsgBox(0,"","Lecture Nord-Est => t41.ini KO !",7)
EndIf ;



EndIf

EndFunc

Func _Init_pwd()

If $LancerRumba=1 Then ;mdp Rumba-RACF des 6 comptes de deleg non SSH
   $Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf

$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"

   ;mdp actuels fichier ini ...
$NordEst= IniRead($file,"Nord-Est","compte",0)
$NordOuest=IniRead($file,"Nord-Ouest","compte",0)
$SudEst= IniRead($file,"Sud-Est","compte",0)
$SudOuest= IniRead($file,"Sud-Ouest","compte",0)
$IledeFrance= IniRead($file,"Ile-de-France","compte",0)
$OutreMER= IniRead($file,"Outre-MER","compte",0)


;-------------------------------------------
;ecriture fichiers rumba... et màj t41.ini
;-------------------------------------------

;Nord-Est;
$fichier=FileOpen($sSavePath & "\Nord-Est.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Nord-Est.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($NordEst,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Nord-Est, nouveau mdp","actuel: " & $NordEst, stringreplace($NordEst,"password",$password) )
$new= stringreplace($NordEst,"password",$password)
$NordEstini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Nord-Est", "compte", $NordEstini)

;Nord-Ouest
$fichier=FileOpen($sSavePath & "\Nord-Ouest.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Nord-Ouest.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($NordOuest,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Nord-Ouest, nouveau mdp","actuel: " & $NordOuest, stringreplace( $NordOuest ,"password",$password) )
$new= stringreplace( $NordOuest ,"password",$password)
$NordOuestini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Nord-Ouest", "compte", $NordOuestini)

;Sud-Est
$fichier=FileOpen($sSavePath & "\Sud-Est.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Sud-Est.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($SudEst,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Sud-Est, nouveau mdp","actuel: " & $SudEst, stringreplace( $SudEst ,"password",$password) )
$new= stringreplace( $SudEst ,"password",$password)
$SudEstini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Sud-Est", "compte", $SudEstini)

;Sud-Ouest
$fichier=FileOpen($sSavePath & "\Sud-Ouest.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Sud-Ouest.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($SudOuest,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Sud-Ouest, nouveau mdp","actuel: " & $SudOuest, stringreplace( $SudOuest ,"password",$password) )
$new= stringreplace( $SudOuest ,"password",$password)
$SudOuestini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Sud-Ouest", "compte", $SudOuestini)


;$IledeFrance
$fichier=FileOpen($sSavePath & "\Ile-de-France.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Ile-de-France.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($IledeFrance,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Ile-de-France, nouveau mdp","actuel: " & $IledeFrance, stringreplace( $IledeFrance ,"password",$password) )
$new= stringreplace( $IledeFrance ,"password",$password)
$IledeFranceini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Ile-de-France", "compte", $IledeFranceini)



;$OutreMER
$fichier=FileOpen($sSavePath & "\Outre-Mer.rmc", 16 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
$fichiermodif=FileOpen($sSavePath & "\Outre-Mer.rmc", 16+2 )
$org=StringTrimLeft ( StringToBinary(StringReplace($OutreMER,";","")),2)  ;44353938333730325365707432303232
;$new=stringreplace($NordEst,"Sept2022","Octo2022")
;$new=InputBox("Outre-Mer, nouveau mdp","actuel: " & $OutreMER, stringreplace( $OutreMER ,"password",$password) )
$new= stringreplace( $OutreMER ,"password",$password)
$OutreMERini=$new
$new= StringTrimLeft ( StringToBinary(StringReplace($new,";","")),2)
;MsgBox(0,"","org:  " & $org & @crlf & "remplacé par:" &@crlf & "new: " & $new)
$modif=StringReplace($binary,$org,$new)
FileWrite($fichiermodif,$modif)
FileClose($fichiermodif)
IniWrite($file, "Outre-Mer", "compte", $OutreMERini)

MsgBox(0,"Info !","t41.ini et fichiers Rumba/RACF générés !" & @crlf & @crlf & "> remplacé [ password ]  par:  [ " & $password & " ]" & @crlf & @crlf & " tapez: pwd? à la place du n° d'un dép. pour remodifier les mdp...")
EndIf

If $LancerQuick3270=1 Then ;init pwd avec compte Nord-EST

      ;mdp actuels fichier ini ...
$NordEst= IniRead($file,"Nord-Est","compte",0) ;avec macro traité en dernier
$NordOuest=IniRead($file,"Nord-Ouest","compte",0)
$SudEst= IniRead($file,"Sud-Est","compte",0)
$SudOuest= IniRead($file,"Sud-Ouest","compte",0)
$IledeFrance= IniRead($file,"Ile-de-France","compte",0)
$OutreMER= IniRead($file,"Outre-MER","compte",0)

;;NE
$newNE=InputBox("Nord-Est, nouveau mdp","actuel: " & $NordEst, $NordEst )
if @error=1 Then
$newNE=$NordEst
EndIf
IniWrite($file, "Nord-Est", "compte", $newNE)

;;NO
$newNO=InputBox("Nord-Ouest, nouveau mdp","actuel: " & $NordOuest, $NordOuest )
if @error=1 Then
$newNO=$NordOuest
EndIf
IniWrite($file, "Nord-Ouest", "compte", $newNO)
;;SE
$newSE=InputBox("Sud-Est, nouveau mdp","actuel: " & $SudEst, $SudEst )
if @error=1 Then
$newSE=$SudEst
EndIf
IniWrite($file, "Sud-Est", "compte", $newSE)
;;SO
$newSO=InputBox("Sud-Ouest, nouveau mdp","actuel: " & $SudOuest, $SudOuest )
if @error=1 Then
$newSO=$SudOuest
EndIf
IniWrite($file, "Sud-Ouest", "compte", $newSO)
;;IdF
$newIdF=InputBox("Ile-de-France, nouveau mdp","actuel: " & $IledeFrance, $IledeFrance )
if @error=1 Then
$newIdF=$IledeFrance
EndIf
IniWrite($file, "Ile-de-France", "compte", $newIDF)
;;OM
$newOM=InputBox("Outre-MER, nouveau mdp","actuel: " & $OutreMER, $OutreMER )
if @error=1 Then
$newOM=$OutreMER
EndIf
IniWrite($file, "Outre-MER", "compte", $newOM)

;;NE (avec la macro)
;$NordEst= IniRead($file,"Nord-Est","compte",0) ;mdp de t41.ini deja lu...
$NordEstarray=StringSplit($newNE,";") ;  => $NordEst initial => $newNE saisi dans ;;NE

if IsArray($NordEstarray) Then
$NordEstarraycompte=$NordEstarray[1]
$NordEstarraypassword=$NordEstarray[2]

;MsgBox(0,"",$NordEstarraycompte & " - " & $NordEstarraypassword)

    $Rumba= IniRead($file,"Rumba","Macros",0)
if $Rumba ='0' Then
   $Rumba = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"
EndIf
$sSavePath = "C:\Users\" & StringStripWS(@username, 8) & "\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro"

;Nord-Est; 'Macro Quick3270.qmc' initial...
$fichier=FileOpen($sSavePath & "\Macro Quick3270.qmc", 0 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
;MsgBox(0,"Lecture OK",$binary) ; lecture ok

;écriture compte & pwd du fichier initial avec valeure NE
$fichiermodif=FileOpen($sSavePath & "\Macro Quick3270.qmc", 2 );16+2;binary
$binary=StringReplace($binary,"compteDeleg",$NordEstarraycompte)
$binary=StringReplace($binary,"password",$NordEstarraypassword)

;MsgBox(0,"Ecriture OK",$binary) ;Ecriture OK
FileWrite($fichiermodif,$binary)
sleep(1000)
FileClose($fichiermodif)

;déjà ecrit dans ;;NE
;IniWrite($file, "Nord-Est", "compte", $newNE)

;
;startup macro Rumba.ecf (modif du chemin..) => ligne: StartupMacro=C:\Users\phxg692\AppData\Local\VirtualStore\Program Files (x86)\RUMBARH\Mframe\Macro\Macro Quick3270.qmc
;
$fichier=FileOpen($sSavePath & "\Rumba.ecf", 0 ) ;16) ;binary mode=16 ; 0=read; 1=write append
$binary=FileRead($fichier) ; Binary
FileClose($fichier)
;MsgBox(0,"Lecture OK",$binary) ; lecture ok

;écriture compte & pwd du fichier initial avec valeure NE
$fichiermodif=FileOpen($sSavePath & "\Rumba.ecf", 2 );16+2;binary
$binary=StringReplace($binary,"phxg692",StringStripWS(@username, 8) )

;MsgBox(0,"Ecriture OK",$binary) ;Ecriture OK
FileWrite($fichiermodif,$binary)
sleep(1000)
FileClose($fichiermodif)
;
;

MsgBox(0,"Info","t41.ini , Les comptes t41 et les mots de passes initiaux ont été définis, y compris pour la macro initiale Quick3270 !",14)
Else ;ko array
MsgBox(0,"","Lecture Nord-Est => t41.ini KO !",7)
EndIf ;



EndIf

EndFunc
