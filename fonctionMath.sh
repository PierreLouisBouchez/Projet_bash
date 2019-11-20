#!/bin/sh

function testNumber () {
	if test $# -ne 1 ; then
		echo "NOMBRE != 1"
		exit 1
	elif [ "$(echo $1 | grep "^[ [:digit:] ]*$")" ]; then
		return 1
	fi
	return 0
}

function mul () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	return `expr "$1" \* "$2"`
}

function div () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	return `expr "$1" / "$2"`
}

function puissance () {
	if test $# -ne 2 ; then
		echo "NOMBRE != 2"
		exit 1
	elif `testNumber "$1"` || `testNumber "$2"`; then
		echo " ERREUR not int"
		exit 1
	fi
	cpt=0
	while test $cpt -gt
	return `expr "$1" / "$2"`
}

`div 20 5`
echo $?
