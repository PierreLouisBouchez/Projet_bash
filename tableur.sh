#!/bin/sh
#echo "hello world"
int="fr"
out=""
scin="\t"
scout="\t"
slin="\n"
slout="\n"
inverse=0
while test $# -gt 0 ;do
    case "$1" in
        ("-in")  if test -e ./$2
            then
                int=$2
                shift
            else
                echo "Le fichier $2 n'existe pas"
                exit 0
            fi;;
        ("-out") if test -e ./$2
                then
                    out=$2
                    shift
                else
                    echo "Le fichier $2 n'existe pas"
                    exit 0
                fi;;
        ("-scin")   scin=$2
                    shift;;
        ("-scout") scout=$2
                    shift;;
        ("-slin")   slin=$2
                    shift;;
        ("-slout")  slin=$2
                    shift;;
        ("-inverse") inverse=1 ;;
        (*) exit 0;;
    esac
    shift
done
if [ $slin == '\n' ]
then
    for i in $(cat $int)
    do
        echo "$i"
    done
else
    for i in `cut -d "$slin" -f 1 "$int"`
    do
        for j in `cut -d "$scin" -f 1 "$i"`
        do
            echo "$j"
        done
    done
fi
#echo $int
#echo $out
#echo $scin
#echo $scout
#echo $slin
#echo $slout
#echo $inverse

