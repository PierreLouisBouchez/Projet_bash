#!/bin/bash


function cel(){
    if test $# -ne 1 ; then
      echo "NOMBRE != 1"
      exit 1
    elif echo "$1" | grep &>/dev/null "^l[0-9]c[0-9]$"; then
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
