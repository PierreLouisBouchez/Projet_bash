#!/bin/bash

function verifcel(){
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
    fi
	`echo "$1" | grep &>/dev/null "^l[0-9]*c[0-9]*$"`
	return $?
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
      return 0
    fi
    echo "arguments non attendue"
    exit 1
}

function ecrireCel(){
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
        exit 1
    fi
    if test "$out" != ""; then
		`testNumber $2` 
		if `test $? -eq 1` && `test $2 -eq 1`; then
			if test $slout != '\n'; then
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
	local param=`echo $1 | cut -d'(' -f1`
	local a=` echo $1 | cut -c3- | cut -d"," -f1`
	local b=` echo $1 | cut -c3- | tr ")" ","| cut -d"," -f2`
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
	echo "$isNumbera $a $b"
	`testNumber "$b"`
	local isNumberb="$?"
	echo "$isNumberb"
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
            '^') echo '^';;
            *)  echo "rien";;
    esac
}

function traitement(){
    first=`echo $1 | cut -c1`
    if test "$first" == '=' ; then
        local param=`echo $1 | cut -c2-`
        traitementbis "$param"
        res="$ret"
    else
        res="$1"
    fi
}
