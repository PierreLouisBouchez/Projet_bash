#!/bin/bash

source fonctionMath.sh

function cel () {
    x=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y=`echo $1 | cut -d'c' -f 2 `
    for i in ` cat "$in" | cut -d"$slin" -f $x `
    do
        res=` echo $i | cut -d"$scin" -f $y `
    done
}

function somme () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    val=0
    for j in $(seq $x1 $x2)
    do 
		for k in $(seq $y1 $y2)
		do
			concat "l" $j
			concat $ret "c"
			concat $ret $k
			cel $ret
			add $val $res
			val=$ret
		done
	done
}

function moyenne () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    sub $x2 $x1
    add $ret 1
    val1=$ret
    sub $y2 $y1
    add $ret 1
    val2=$ret
	somme $1 $2
    mul $val1 $val2
	div $val $ret
}

function variance () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    valeee=0
    nbElt=0
	moyenne $1 $2
	moy=$ret
	for j in $(seq $x1 $x2)
    do 
		for k in $(seq $y1 $y2)
		do
			concat "l" $j
			concat $ret "c"
			concat $ret $k
			cel $ret
			sub $res $moy
			puissance $ret 2
			add $valeee $ret
			valeee=$ret
			add $nbElt 1
			nbElt=$ret
		done
	done
    div $valeee $nbElt
}

function ecarttype () {
	variance $1 $2
	sqrt $ret
}

function mediane () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    cpt=0
    for j in $(seq $x1 $x2)
    do 
		for k in $(seq $y1 $y2)
		do
			concat "l" $j
			concat $ret "c"
			concat $ret $k
			cel $ret
			tab[cpt]=$res
			add $cpt 1
			cpt=$ret
		done
	done
	tab=($(printf "%s\n" ${tab[*]} | sort -n))
	impair=$(($cpt%2))
	if test $impair -eq 0 ; then
		milieu1=$(($cpt/2))
		milieu2=$(($milieu1-1))
		add ${tab[milieu1]} ${tab[milieu2]}
		div $ret 2
	else
		milieu=$(($cpt/2))
		ret=`echo ${tab[milieu]}`
	fi
}

function min () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    cel $1
    petit=$res
	for j in $(seq $x1 $x2)
    do 
		for k in $(seq $y1 $y2)
		do
			concat "l" $j
			concat $ret "c"
			concat $ret $k
			cel $ret
			val=$res
			if test $val -lt $petit ; then
				petit=$val
			fi
		done
	done
	ret=`echo $petit`
}

function max () {
	x1=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
    y1=`echo $1 | cut -d'c' -f 2 `
	x2=`echo $2 | tr "l" " " | cut -d'c' -f 1 `
    y2=`echo $2 | cut -d'c' -f 2 `
    cel $1
    grand=$res
	for j in $(seq $x1 $x2)
    do 
		for k in $(seq $y1 $y2)
		do
			concat "l" $j
			concat $ret "c"
			concat $ret $k
			cel $ret
			val=$res
			if test $val -gt $grand ; then
				grand=$val
			fi
		done
	done
	ret=`echo $grand`
}
