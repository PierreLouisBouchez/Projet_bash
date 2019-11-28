#!/bin/bash

function lireFichierDisplay () {
	lines $tmp
	nbLignes=$ret
	for g in $(seq 1 $nbLignes)
    do
		nbRowLine $g
		for o in $(seq 1 $col)
		do
			ret=""
			res=""
			concat "l" $g
			concat $ret "c"
			concat $ret $o
			cel $ret
			if [[ $res == =display* ]]
			then
				local cel1=` echo $res | cut -d"," -f1 | cut -d"(" -f2`
				local cel2=` echo $res | cut -d"," -f2 | cut -d")" -f1`
				x1=`echo $cel1 | tr "l" " " | cut -d'c' -f 1 `
				y1=`echo $cel1 | cut -d'c' -f 2 `
				x2=`echo $cel2 | tr "l" " " | cut -d'c' -f 1 `
				y2=`echo $cel2 | cut -d'c' -f 2 `
				for a in $(seq $x1 $x2)
				do
					for b in $(seq $y1 $y2)
					do
						concat "l" $a
						concat $ret "c"
						concat $ret $b
						celDisplay $ret
						if test $b -eq $y2
						then
							ecrireCelDisplay $res 1
						else
							ecrireCelDisplay $res 0
						fi
					done
				done
			fi
		done
    done
}

function lireFichier () {
	lines $in
	nbLignes=$ret
	for g in $(seq 1 $nbLignes)
    do
		nbRowLine $g
		for o in $(seq 1 $col)
		do
			ret=""
			res=""
			concat "l" $g
			concat $ret "c"
			concat $ret $o
			cel $ret
			traitement $res
			if test $o -eq $col
			then
				ecrireCel $res 1
			else
				ecrireCel $res 0
			fi
		done
    done
}

function lireFichierInverse () {
	lines $in
	nbCol=$ret
	colMaxLigne
	nbLignes=$maxline
	for g in $(seq 1 $nbLignes)
    do
		nbRowLine $g
		for o in $(seq 1 $nbCol)
		do
			ret=""
			res=""
			concat "l" $o
			concat $ret "c"
			concat $ret $g
			cel $ret
			traitement $res
			if test $o -eq $nbCol
			then
				ecrireCel $res 1
			else
				ecrireCel $res 0
			fi
		done
    done
}

function colMaxLigne () {
	lines $in
	nbLignes=$ret
	maxline=0
	for g in $(seq 1 $nbLignes)
    do
		nbRowLine $g
		if test $col -gt $maxline
		then
			maxline=$col
		fi 
    done
}

function verifcel () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
    fi
	`echo "$1" | grep &>/dev/null "^l[0-9]*c[0-9]*$"`
	return $?
}

function test3Element () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	fi
	re='.*,.*'
	if ! [[ $1 =~ $re ]]; then
		return 1
	fi
	return 0
}

function test2Element () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	fi
	re='.*,.*'
	if ! [[ $1 =~ $re ]]; then
		return 1
	fi
	return 0
}

function test1Element () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	fi
	re='.*\(.*\)'
	if ! [[ $1 =~ $re ]]; then
		return 1
	fi
	return 0
}

function cel(){
    if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
    elif `verifcel "$1"`; then
		x=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
		y=`echo $1 | cut -d'c' -f 2 `
		for i in ` cat "$in" | cut -d"$slin" -f $x `
		do
		  res=` echo $i | cut -d"$scin" -f $y `
		done
		if [[ $res == "" ]]
		then
			res=0
		fi
		return 0
    fi
    echo "argument non attendu"
    exit 1
}

function celDisplay(){
	x=`echo $1 | tr "l" " " | cut -d'c' -f 1 `
	y=`echo $1 | cut -d'c' -f 2 `
	if [[ $slout == "\n" ]]
	then
sloutmodif='
'
	fi
	for i in ` cat "$tmp" | cut -d"$sloutmodif" -f $x `
	do
		res=` echo $i | cut -d"$scout" -f $y `
	done
	return 0
}

function ecrireCel(){
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
        exit 1
    fi
    if test "$tmp" != ""; then
		`testNumber $2` 
		if `test $? -eq 1` && `test $2 -eq 1`; then
			if [[ $slout != '\n' ]]; then
				echo "$1$slout" |awk '{printf("%s",$0)}' >> "$tmp"
				
			else 
				echo "$1" |awk '{printf("%s\n",$0)}' >> "$tmp"
			fi
		return 0
		else
			echo "$1$scout" |awk '{printf("%s",$0)}' >> "$tmp"
			return 0
		fi
	else
		if `test $? -eq 1` && `test $2 -eq 1`; then
			if test $slout != '\n'; then
				echo "$1$slout" |awk '{printf("%s",$0)}'
				
			else 
				echo "$1" |awk '{printf("%s\n",$0)}'
			fi
		return 0
		else
			echo "$1$scout" |awk '{printf("%s",$0)}'
			return 0
		fi
	fi
    echo "arguments non attendue"
    exit 1
}

function ecrireCelDisplay(){
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
        exit 1
    fi
    if test "$out" != ""; then
		`testNumber $2` 
		if `test $? -eq 1` && `test $2 -eq 1`; then
			if [[ $slout != '\n' ]]; then
				echo "$1$slout" |awk '{printf("%s",$0)}' >> "$out"
				
			else 
				echo "$1" |awk '{printf("%s\n",$0)}' >> "$out"
			fi
		return 0
		else
			echo "$1$scout" |awk '{printf("%s",$0)}' >> "$out"
			return 0
		fi
	else
		if `test $? -eq 1` && `test $2 -eq 1`; then
			if test $slout != '\n'; then
				echo "$1$slout" |awk '{printf("%s",$0)}'
				
			else 
				echo "$1" |awk '{printf("%s\n",$0)}'
			fi
		return 0
		else
			echo "$1$scout" |awk '{printf("%s",$0)}'
			return 0
		fi
	fi
    echo "arguments non attendue"
    exit 1
}

function traitementbis(){
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
        exit 1
    fi
    local dejafaitA=0
    local dejafaitB=0
	local param=`echo $1 | cut -d'(' -f1`
	if `test3Element "$1"`; then
		if test "$param" == "subsitute"; then
			local a=` echo $1 | cut -d"," -f1 | cut -d"(" -f2`
			local b=` echo $1 | tr ")" ","| cut -d"," -f2`
			local c=` echo $1 | tr ")" ","| cut -d"," -f3`
			subsitute "$a" "$b" "$c" 
		fi
	fi
	if `test2Element "$1"` && ! `testfunctionMathSimple "$param"`; then
		if test "$dejafaitA" -eq 0; then
			local a=` echo $1 | cut -c3- | cut -d"," -f1`
		fi
		if test "$dejafaitB" -eq 0; then
			local b=` echo $1 | cut -c3- | tr ")" ","| cut -d"," -f2`
		fi
		`verifcel "$a"`
		iscel="$?"
		if test "$iscel" -eq 0; then
			cel "$a"
			traitement "$res"
			local a="$res"
		fi
		`verifcel "$b"`
		iscel="$?"
		if test "$iscel" -eq 0; then
			cel "$b" 
			traitement "$res"
			local b="$res"
		fi
		`testNumber "$a"`
		local isNumbera="$?"
		`testNumber "$b"`
		local isNumberb="$?"
		
		case $param in
			
				'+') 	
						if test "$isNumbera" -eq 1 && test "$isNumberb" -eq 1 ; then
							add "$a" "$b"
						else
							ret="probleme NAN"
						fi ;;
				'-') if test "$isNumbera" -eq 1 && test "$isNumberb" -eq 1 ; then
							sub "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
				'*')  if test "$isNumbera" -eq 1 && test "$isNumberb" -eq 1 ; then
							mul "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
				'/')   if test "$isNumbera" -eq 1 && test "$isNumberb" -eq 1 ; then
							div "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
				'^') if test "$isNumbera" -eq 1 && test "$isNumberb" -eq 1 ; then
							puissance "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
				*)  echo "rien";;
		esac
	elif `test2Element "$1"`; then
		local a=` echo $1 | cut -d"," -f1 | tail -c5`
		local b=` echo $1 | cut -c3- | tr ")" ","| cut -d"," -f2`
		`verifcel "$a"`
		iscela="$?"
		`verifcel "$b"`
		iscelb="$?"
		case $param in
			'somme')	if test "$iscela" -eq 0 && test "$iscelb" -eq 0 ; then
							somme "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'moyenne')	if test "$iscela" -eq 0 && test "$iscelb" -eq 0 ; then
							moyenne "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'variance') if test "$iscela" -eq 0 && test "$iscelb" -eq 0 ; then
							variance "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'ecarttype')if test "$iscela" -eq 0 && test "$iscelb" -eq 0; then
							ecarttype "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'mediane')	if test "$iscela" -eq 0 && test "$iscelb" -eq 0; then
							mediane "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'min')		if test "$iscela" -eq 0 && test "$iscelb" -eq 0 ; then
							min "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'max')		if test "$iscela" -eq 0 && test "$iscelb" -eq 0 ; then
							max "$a" "$b"
						else
							ret="probleme ici "
						fi ;;
			'concat')   concat "$a" "$b" ;;
			'display') 	nbDisplay=`expr $nbDisplay + 1`
						ret="$1";;
		esac
		
	elif `test1Element "$1"` ; then
		local a=` echo $1 | cut -d"(" -f2 | cut -d")" -f1`
		if test "$param" == "length"; then
			length "$a"
			return 0
		fi
		`verifcel "$a"`
		iscel="$?"
		if test "$iscel" -eq 0; then
			cel "$a"
			traitement "$res"
			local a="$res"
		fi
		`testNumber "$a"`
		local isNumbera="$?"
		case $param in
			'ln') 	if test "$isNumbera" -eq 1; then
						ln "$a"
					else
						ret="probleme ici "
					fi ;;
			'e')	if test "$isNumbera" -eq 1; then
						exponentiel "$a"
					else
						ret="probleme ici "
					fi ;;
			'sqrt') if test "$isNumbera" -eq 1; then
						sqrt "$a" 
					else
						ret="probleme ici "
					fi ;;
			'size') size "$a" ;;
			'lines') lines "$a" ;;
            *)  echo "rien";;
		esac
	fi
}

function traitement(){
    first=`echo $1 | cut -c1`
    verifcel "$1"
	iscel="$?"
    if test "$first" == '=' ; then
        local param=`echo $1 | cut -c2-`
        traitementbis "$param"
        res="$ret"
    elif test "$iscel" -eq 0; then
		cel "$1"
    else
        res="$1"
    fi
}
