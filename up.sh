#!/bin/bash

DIR=`pwd`
MEN=$1

cd $DIR
DIRS=`ls -d $DIR/*/`
for i in $DIRS
  do 
    cd $DIR
    if [ "$i" != "." ] && [ "$i" != ".." ] && [ "$i" != ".git" ] && [ -e ".git" ]
    then
      cd $i
      echo `pwd`
      git pull
      for j in `ls -ac1`
      do
        if [ "$j" != "." ] && [ "$j" != ".." ] && [ "$j" != ".git" ]
        then
          git add $j
        fi
      done
      git commit -m "$MEN"
      git push
      
      ID=$(git rev-parse HEAD)
      echo $ID
    fi
  done

#if [ -e ".git" ]
#then
  cd $DIR
  git pull
  for j in `ls -ac1`
  do
    if [ "$j" != "." ] && [ "$j" != ".." ] && [ "$j" != ".git" ]
    then
      git add $j
    fi
  done
  git commit -m "$MEN"
  git push
#fi
