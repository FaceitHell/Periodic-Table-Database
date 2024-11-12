#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -t --no-align -c"

ELEMENTS_TABLE=$($PSQL "SELECT * FROM elements")
PROPERTIES_TABLE=$($PSQL "SELECT * FROM properties")
# echo "$ELEMENTS_TABLE" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME
# do
#   CAPITALIZED=$(echo "$SYMBOL" | sed 's/./\U&/')
#   UPDATE_SYMBOL=$($PSQL "UPDATE elements SET symbol='$CAPITALIZED' WHERE symbol='$SYMBOL'")
#   echo $UPDATE_SYMBOL
# done


echo "$PROPERTIES_TABLE" | while IFS="|" read ATOMIC_NUMBER TYPE ATOMIC_MASS M_POINT_C B_POINT_C TYPE_ID
do
  FIXED_NUMBER=$(printf "%.10g" "$ATOMIC_MASS")
  echo $FIXED_NUMBER
  UPDATE_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass=$FIXED_NUMBER WHERE atomic_mass=$ATOMIC_MASS")
  echo $UPDATE_ATOMIC_MASS
done