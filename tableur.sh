#!/bin/bash

source fonctionMath.sh
source fonctionCell.sh
source lireFic.sh

in=''
out=''
scin=':'
slin='
'
scout=' '
slout='\n'
inverse=0

while test $# -gt 0 ;do
    case "$1" in
        ("-in")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-in\" : veuillez indiquer le fichier où se trouve la feuille de calculs"
					exit 0
				elif test -e $2
				then
					in=$2
					shift
				else
					echo "Le fichier \"$2\" n'existe pas"
					exit 0
				fi
				;;
        ("-out")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-out\" : veuillez indiquer le fichier dans lequel doit être écrite la feuille de calculs"
					exit 0
				else
					if test ! -e $2
					then
						touch $2
					fi
					out=$2
					shift
				fi
				;;
        ("-scin")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-scin\" : veuillez indiquer le séparateur de colonnes de la feuille de calculs initiale"
					exit 0
				else
					scin=$2
					shift
				fi
				;;
        ("-slin")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-slin\" : veuillez indiquer le séparateur de lignes de la feuille de calculs initiale"
					exit 0
				else
					slin=$2
					shift
				fi
				;;
        ("-scout")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-scout\" : veuillez indiquer le séparateur de colonnes de la feuille calculée"
					exit 0
				else
					scout=$2
					shift
				fi
				;;
        ("-slout")
				if test $# -lt 2 || [[ $2 == -* ]]
				then
					echo "Erreur \"-slout\" : veuillez indiquer le séparateur de lignes de la feuille calculée"
					exit 0
				else
					slout=$2
					shift
				fi
				;;
        ("-inverse")
				if test $# -gt 1 && [[ $2 != -* ]]
				then
					echo "Erreur \"-inverse\" : cette option ne nécessite pas de paramètre"
					exit 0
				else
					inverse=1
				fi
				;;
        (*)
				echo "Erreur : option \"$1\" inconnue"
				exit 0
				;;
    esac
    shift
done

#echo "[Fichier entrée] : \"$in\""
#echo "[Fichier sortie] : \"$out\""
#echo "[Séparateur colonne entrée] : \"$scin\""
#echo "[Séparateur ligne entrée] : \"$slin\""
#echo "[Séparateur colonne sortie] : \"$scout\""
#echo "[Séparateur ligne sortie] : \"$slout\""
#echo "[Inversion lignes/colonnes] : \"$inverse\""


if [[ $in == "" ]]
then
    touch "tmp.tmp"
    read input
    in="tmp.tmp"
    echo "$input" >$in
fi

<<<<<<< HEAD
add 4.666 5.5555e
echo $ret

#max "l2c1" "l3c4"
#echo $ret
=======
testNumber 45 
echo $?

>>>>>>> master
