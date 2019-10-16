#!/bin/sh
#echo "hello world"

in=""
out=""
scin="\t"
scout="\t"
slin="\n"
slout="\n"
inverse=0




while test $# -gt 0 ;do
    case $1 in
    "-in")  if test -e ./$2
            then
                echo "Fichier trouvé"
                in=$2
                shift
            else
                echo "Le fichier $2 n'existe pas"
                exit 0
            fi;;
    "-out") if test -e ./$2
            then
                echo "Fichier trouvé"
                out=$2
                shift
            else
                echo "Le fichier $2 n'existe pas"
                exit 0
            fi;;
    "-scin") echo "-scin" ;;
    "-scout") echo "-scout" ;;
    "-slin") echo "-slin" ;;
    "-slout") echo hello ;;
    "-inverse") invers=1 ;;
    *) exit 0;;
    esac
    shift
done
echo $in
echo $out