#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -t --no-align -c"
ELEMENTS_TABLE=$($PSQL "SELECT * FROM elements")
PROPERTIES_TABLE=$($PSQL "SELECT * FROM properties")


if [[ $1 ]]
then
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
  else 
    ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  fi

  if [[ -z $ELEMENT_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    IFS="|" read -r ATOMIC_NUMBER SYMBOL NAME <<< "$($PSQL "SELECT * FROM elements WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")"
    IFS="|" read -r ATOMIC_NUMBER ATOMIC_MASS M_P_CELSIUS B_P_CELSIUS TYPE_ID <<< "$($PSQL "SELECT * FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NUMBER")"
    IFS="|" read TYPE <<< "$($PSQL "SELECT type FROM types WHERE type_id=TYPE_ID")"
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $M_P_CELSIUS celsius and a boiling point of $B_P_CELSIUS celsius."
  fi
else
  echo "Please provide an element as an argument."
fi