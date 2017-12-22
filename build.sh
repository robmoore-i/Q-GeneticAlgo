#!/bin/bash

if [[ $QHOME == "" ]]
then
  echo "Set QHOME first! Commands below:"
  echo "sudo su"
  echo "echo \"QHOME=/path/to/your/q/\" >> /etc/environment"
  echo "exit"
  echo "source /etc/environment"
  exit 1
fi

if [[ ! -d $QHOME ]]
then
  echo "QHOME directory not found: $QHOME"
  exit 0
fi

if [[ ! -f $QHOME/l32/q ]]
then
  if [[ ! -f $QHOME/l64/q ]]
  then
    echo "Neither 32 nor 64 bit q executable found: $QHOME/l32/q $QHOME/l64/q"
    exit 0
  fi
fi

echo "Copying ga.q to QHOME"
cp ga.q $QHOME
echo "All done"
exit 0
