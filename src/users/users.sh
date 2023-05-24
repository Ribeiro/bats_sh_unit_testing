#!/bin/sh
#A simple script with User functions

add()
{
  echo "User successfully added!"
}

remove()
{
  echo "User successfully removed!"
}

createConfigFileUsingEnv()
{
  touch user.conf
  echo 'username='${ENV_USERNAME} > user.conf
}

createConfigFile()
{
  username="'$*'"
  touch user.conf
  echo 'username='$username > user.conf
}
