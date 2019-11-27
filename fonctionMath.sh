#!/bin/bash

function testNumber () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	fi
	re='^[+-]?[0-9]+([.][0-9]+)?$'
	if ! [[ $1 =~ $re ]]; then
		return 0
	fi
	return 1
}

function testfunctionMathSimple(){
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	fi
	re='^[+-*/]$'
	if ! [[ $1 =~ $re ]]; then
		return 0
	fi
	return 1
}

function add () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "$1+$2"|bc -l`
}

function sub () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "$1-$2"|bc -l`
}


function mul () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "$1*$2"|bc -l`
}

function div () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "$1/$2"|bc -l`
}

function puissance () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	if test $2 -eq 0; then
		return 1
	fi

	local cpt=1
	ret="$1"
	while test $cpt -lt $2; do
		ret=`echo "$ret*$1"|bc -l`
		cpt=`expr "$cpt" + 1`
	done
}

function ln () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	elif `testNumber "$1"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "l($1)" |bc -l`
}

function exponentiel () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	elif `testNumber "$1"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "e($1)" |bc -l`
}

function sqrt () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	elif `testNumber "$1"`; then
		echo " ERREUR not int"
		exit 1
	fi
	ret=`echo "sqrt($1)" |bc -l`
}

function concat () {
		if test $# -ne 2 ; then
			echo "NOMBRE DE D'ARGUMENTS != 2"
		exit 1
	fi
	ret="$1""$2"
}

function length () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	fi
	ret=`expr length $1`
}

function subsitute () {
	if test $# -ne 3 ; then
		echo "NOMBRE DE D'ARGUMENTS != 3"
		exit 1
	elif `echo "$1" | grep -q "$2"`; then
		ret=`echo ${1/$2/$3}`
	else
		ret="$2 n'est pas dans $1"
	fi
}

function size () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	elif test -f $1; then
		ret=`ls -lh "$1"| cut -d " " -f5`
	else
		ret=" $1 n'est pas un fichier"
	fi
}

function lines () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	elif test -f $1; then
		ret=`wc -l $1 | cut -d " " -f1`
	else
		ret=" $1 n'est pas un fichier"
	fi
}

function shell () {
	if test $# -ne 1 ; then
		echo "NOMBRE DE D'ARGUMENTS != 1"
		exit 1
	fi
	`$1`>/dev/null 2>&1
	if test $? -ne 0; then
		echo "ERREUR FONCTION SHELL"
		exit 1
	fi
	ret=`$1`
}
