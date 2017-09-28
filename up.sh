#!/bin/bash

DIR=`pwd`
MEN=$1

cd $DIR
DIRS=`ls -d $DIR/*/`
for i in $DIRS
  do 
    cd $DIR
    if [ "$i" != "." ] && [ "$i" != ".." ] && [ "$i" != ".git" ] && [ -d ".git/" ]
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
      
      sleep 15
      
      DATA=`curl -s 'https://api.travis-ci.org/soker90/aur-betcon.svg?branch=master'`
      PASS=0

      if [ "`echo "$DATA" | grep passing`" != '' ]
      then
        PASS=1
      fi
      
      if [ "`echo "$DATA" | grep fail`" != '' ]
      then
        PASS=1
      fi
      
      echo $PASS

      while [ $PASS == 0 ]
      do
        sleep 120
        DATA=`curl -s 'https://api.travis-ci.org/soker90/aur-betcon.svg?branch=master'`
        if [ $DATA | grep passing == "passing" ]
        then
          PASS=1
          COUNT=${#DIR}
          NAME=`cat $i | sed "s/$DIR//"`
          mkdir ../../$NAME
          cd ../../$NAME
          PACKAGE=`echo $NAME | sed "s/$DIR//"`
          git ssh://aur@aur.archlinux.org/$PACKAGE.git
          cp $i/* .
          rm .git .travis.yml LICENSE README.md
        fi
        
        if [ $DATA | grep passing == "fail" ]
        then
          PASS=1
          echo "ERROR en el paquete " + $PACKAGE
        fi
          
      done
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

