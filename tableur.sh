#!/bin/sh
int=""
out=" "
scin='  '
scout=' '
slin='
'
slout='
'
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

if [[ $int == "" ]] 
then
    touch "tmp.tmp"
    read input
    int="tmp.tmp"
    echo "$input" >$int
fi

function cel(){
    x=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y=`echo $1 | cut -d'c' -f 2 `
    for i in ` cat "$int" | cut -d"$slin" -f $x `
    do
        res=` echo $i | cut -d"$scin" -f $y `
    done
}


cel l1c1
echo $res


